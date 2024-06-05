Return-Path: <linux-kernel+bounces-203406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E88FDA71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE61F25D00
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDBA1667F6;
	Wed,  5 Jun 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iElbNTyu"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301415FA8D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630022; cv=none; b=nZe+GENyaLirxeeVvTkK/rvVcWQg7e0pwq/qNAktnlnQoMn4I0Flh1zIU8NOmDzDdDayox7+ihsippGJTsc4LNBtKH/k15wj5HkSNlxo/Pc9A4dY8UNW9OdVkxbHgzzKCUkuCQRHbDBUyGJYJ+H6izSvQQrkNh6l4IAOOdf4tLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630022; c=relaxed/simple;
	bh=Uvh7c5HPcPZsUBUF5x6xG49unjoIWNwnWZBN+MKrLUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgaSoypnIOcSDGn6zCFUTvIoF7mpB5zh54XcwBY4AE8i3ddxilc18Z4i7nxykpvYqEFIYoBhcf3qarQrdlDj7zQ1vItUTlZ6BtBBvaa7N5Mi5rB1X5tJMCDogrUPnuIiX4PyH2ne388mzQ+MUyYKlTLiaUlEf1Psr/KJBonK6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iElbNTyu; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfa71ded97bso285570276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717630020; x=1718234820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QIAF8QbRwm7UUfXsDXX+XUkKot8/Im3q+obHDhaEPyU=;
        b=iElbNTyuJl/fqEYibZ3VA2RQmTCx2dGHqviU5RG/TU7LfcW6r/kj6IDQNux6qSrxEh
         d5TP5+ZwBOBxlYYaVZgL7yW7p8oJ6fr+J+frp5u7DjHdyqIaBsocMU7FYe2ismAy0+0h
         a+eJI0F7KhN6Qv2+E5VPVU0XvBI+fW2mLzdc9H42k2RyRFQhf38wiXUqzvbwA9qLViYz
         lvcnFYsvQfpmUcD64Y9UndMsjLqv4wP8ckou1K57uMhK5zV7OLR9DzRNrGOkC2d7rLIa
         dSbY8+OblEVpRo26KS2VjnQA0z6EfB2NYAqPmSWTWarH4jbJ2P72dXmJAiqSj4h4q6LP
         38fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630020; x=1718234820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIAF8QbRwm7UUfXsDXX+XUkKot8/Im3q+obHDhaEPyU=;
        b=jKkBLM44a31Y6JatlDapa/L/PEF+Jx3QrsZpZjzbhQrY+WFB9VON9cg3lru08H20vG
         kkxA/+PZBPLcKfzY0/5wi8FgEyV9CfEGgESz4BMVFQExU1Y9092QgsEWzgJnZHzml671
         XcZLHz0h6NB7Otir24dJIEhLrj4BFs7wNHQJKfjQCuYAfSXj61oREtzIorQViR1uhjGV
         Zupo5coeg/+2hfoKHE0AX/B+2RehFqBN+tGdy1DiLG3pgGzLQMMaUYPn9v49WLx2Mbaq
         DuO7A6X8PRXqSEcToM+cywxxQZdG7pCZ+O11NNbDQa8OGbSymPD1MPV4mklDcX7pW+Pj
         0alQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlq2rxP3Ww5NVtMVTK6ZDe8yh6nAZ2BMmPPeuiEo3DXXYHFRs46vtHpgvTEv5eMUfHN2ZK8UarJRw4P6DJMuSkbyb03scydoOptbNM
X-Gm-Message-State: AOJu0YwqiH9KXrU657kJSHcrMHVyvdPnkYFq9bgy69aDZg45gxoJT21V
	Jv4Txjv2OJxJPwWkP/kMog+XeGJe1GtYXAnBUC3YYbJ71XmSApZGkQhRXBlsm559i2GEbCVgHvm
	qWusUSChSB05TDB/D9KAQ09xbxdftgad9bXkmLgmARYXsyGJW
X-Google-Smtp-Source: AGHT+IFfQiXdaxWwXiph80q/21i5cUmAcf5zvU2JUP9S2fWWkpl/D3qIPiQt8Ovp+Liq/Ff2Le+9lzJrniwVaZMFMjI=
X-Received: by 2002:a25:906:0:b0:dfa:5ab5:d2d with SMTP id 3f1490d57ef6-dfadeb86662mr1026190276.13.1717630019511;
 Wed, 05 Jun 2024 16:26:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mpearson-lenovo@squebb.ca> <20240604194056.16625-1-mpearson-lenovo@squebb.ca>
 <2midmmssv2i3plvtc2hajar6alfvggpnbvgpmldspelxsnjvcl@qiblhwat6n3p> <a517bb13-9772-49f9-b75c-8fa4d98b2ae9@app.fastmail.com>
In-Reply-To: <a517bb13-9772-49f9-b75c-8fa4d98b2ae9@app.fastmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 6 Jun 2024 02:26:46 +0300
Message-ID: <CAA8EJppzeBPHW1GPGvVzT-YSGm4PZUQ4qgq0FCgqn1e9Vt-MXg@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: ucsi: treat get_pdos not supported condition
 as info instead of error
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Diogo Ivo <diogo.ivo@siemens.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 20:09, Mark Pearson <mpearson-lenovo@squebb.ca> wrote:
>
> Thanks Dmitry (& Diogo from the other thread)
>
> On Tue, Jun 4, 2024, at 7:45 PM, Dmitry Baryshkov wrote:
> > On Tue, Jun 04, 2024 at 03:40:44PM -0400, Mark Pearson wrote:
> >> On systems where the UCSI PDOs are not supported, the UCSI driver is
> >> giving an error message. This can cause users to believe there is a HW
> >> issue with their system when in fact it is working as designed.
> >>
> >> Downgrade message to dev_info for EOPNOTSUPP condition.
> >>
> >> Tested on Lenovo L14 G5 AMD and confirmed with Lenovo FW team that PDOs
> >> are not supported on this platform.
> >>
> >> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >> ---
> >>  drivers/usb/typec/ucsi/ucsi.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> >> index cb52e7b0a2c5..090be87d5485 100644
> >> --- a/drivers/usb/typec/ucsi/ucsi.c
> >> +++ b/drivers/usb/typec/ucsi/ucsi.c
> >> @@ -632,8 +632,12 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
> >>      command |= is_source(role) ? UCSI_GET_PDOS_SRC_PDOS : 0;
> >>      ret = ucsi_send_command(ucsi, command, pdos + offset,
> >>                              num_pdos * sizeof(u32));
> >> -    if (ret < 0 && ret != -ETIMEDOUT)
> >> -            dev_err(ucsi->dev, "UCSI_GET_PDOS failed (%d)\n", ret);
> >> +    if (ret < 0 && ret != -ETIMEDOUT) {
> >> +            if (ret == -EOPNOTSUPP)
> >> +                    dev_info(ucsi->dev, "UCSI_GET_PDOS not supported on this hardware\n");
> >
> > Maybe it would be enough to guard GET_PDOS commands with the
> > UCSI_CAP_PDO_DETAILS check? Is it cleared on affected platforms?
> >
>
> I checked on the system I have and the features are 0x84, so the CAP_PDO_DETAILS aren't set.
> I can do a formal patch if the approach is better, I ended up doing:
>
> @@ -645,9 +645,13 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
>  static int ucsi_get_pdos(struct ucsi_connector *con, enum typec_role role,
>                          int is_partner, u32 *pdos)
>  {
> +       struct ucsi *ucsi = con->ucsi;
>         u8 num_pdos;
>         int ret;
>
> +       if (!(ucsi->cap.features & UCSI_CAP_PDO_DETAILS))
> +               return 0;
> +
>         /* UCSI max payload means only getting at most 4 PDOs at a time */
>         ret = ucsi_read_pdos(con, role, is_partner, pdos, 0, UCSI_MAX_PDOS);
>
> And this did indeed squelch the 'error' message.
>
> Couple of notes:
>  - I don't know this area very well, so don't know if there are risks of any regressions in other circumstances. I think it's pretty safe, but if any experts have an opinion that would be appreciated.
>  - It means that there isn't a log message saying that PDO capabilities are not available. Are there going to be power related tooling that won't work and it would be useful to have that message available?

From my POV this patch looks good. Also if there are no PDOs, then the
UCSI driver will register an empty usb_power_delivery object with
neither source nor sink capabilities being present. So userspace can
identify the case of PDOs retrieval being unsupported. If you really
want to have a possible trace in the logs, it might be a good idea to
add dev_dbg under this if statement.

-- 
With best wishes
Dmitry

