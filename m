Return-Path: <linux-kernel+bounces-557191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9917A5D4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D133B7B43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68619D092;
	Wed, 12 Mar 2025 03:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCdnctzN"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA0C1B0406
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741750207; cv=none; b=q7u79lGrp2UhR+xw1FgNBD8AYNCubfrn+IkaJATrMtZA/SK+8xnMKsZBA4l7NcYUA2k8Bphj31FTR3NL8HsUSzVQ8jyz1WzZFa/PmIzDxOD5tRAdpNooAvnqkB9xRS4HAVLIjczIl+AldhyrfflJMm+GnCw4QTziaSpKgr1jmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741750207; c=relaxed/simple;
	bh=8lKtlD878CpQP9xdYqFaFtx3UJlB12BxxXmMp7FSGqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEsEhjQmA3bLeVngHjAiy8hS7TRkduD5p7s+KK/1MFAipdsrCf7tzekLEXjf0NcruDk9Uwt7s6eXc4Yghtr6FFR0KeDJG8aQcQNoDpSZIkg30XA65RM1urf7jFofqRGQBDRvdjuwV1UKUUfGGFovV97qn8vQeKIbdOjaNHkOmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCdnctzN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-549a2997973so2819e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741750202; x=1742355002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTC6q0jJyCwm0Ms6LHn8x6WPWhr3FL+RLBtkQPmtIBA=;
        b=SCdnctzNnSQ6OV94jeyRzz30MMnwKbd/5DR3O/n9/ZAEWRmHwSq23ZieiscVfXd2k3
         XfDPJcXyI2Uh8RWOWMcINcUSEi3w8miJif/NMwqoe0UtaeFSnZGhiQ354mOz47F0p31l
         W/QEpUcu2lHpBvpzhHyADnj9J6nnw1xqCBquRj064VT3P57hjd3UZmuXiDkXsbpwD7WY
         RUn73/+1gs0JdvtLneFsbO9XZ0+m1/oufcO8FxdUIRlgsi7kVvX0rPj31/zpSqbZc961
         VGFQdIm0flEBAuAqgblCOp6SXqv1qj5NrFd7mdUO61wO01BqhrPl1mCk/6501yb6wtHB
         sorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741750202; x=1742355002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTC6q0jJyCwm0Ms6LHn8x6WPWhr3FL+RLBtkQPmtIBA=;
        b=AIowE3/ivpuEnqcKbSja7kExSD6YNZ2SdRl4XdB5NH00YfqiKYu5o2jhwhNrel3rmq
         ibqKU0SOq8vBoHSHi90r+nfo5zxYADgrGg2yvU46sArQahy3gSQbXV3MI7LWZeFhNxaj
         10wsBcvbkDTEcTTqKIluUV/o7lgAOcgcVf4qbPkxnMdozQTF6UISvLVv/R+jePJoW5FU
         aPvDu+XU+GwJX1Rwf/wC2YwHYeoGe6WnfmyD8dBE+bGjbMON3Ozlh5f6bWbudEU0yCBn
         MLCD3Gc/neHyTJtig8x4UwSvpa3rlN6VsfOWQe/6Sc6QYwNZzU8tvmVAcZaZdtBfDfjQ
         EyBw==
X-Forwarded-Encrypted: i=1; AJvYcCVtvj/J/JAjvn5ro3Gg5wxzTRiNlJPsdk1wnYrtKclmfvmtNDr+FWRhv3H+eS7+Wq0nJ1MwA+SiiycxKTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfEBCvWj6b0HHsvkX1H77w4PLz8xFE79ZFgnizVTF/Dvk+F6Ej
	utmxH/bIEdfChBafQFeiOQSag4AGx2VkIftDVEMCmlS+z+koGsqdqk0QnNj8Bfu0GGm4XyBvsaY
	8Afv/tAtGQSi7MzFNXGaruHFnvZnzJ57cKA6q
X-Gm-Gg: ASbGncuzg0wEhxWjvR8lfq/Ek2UKeIZNOuhCqGVg+Uj+dtmUaGcoFWfsxdkUcNK3BXY
	zva4CniHqq8AWo7w2bdFL5UHi6+vwVWb5mkYr2wcFLro75osqGACqFfkrclLOVOFVW04KhR6q3/
	io8K/TpLdBDCR/HSKpSVKlNqcaSDZZv2he/yHYTQuqf51QNJ0QKNMoxAyJ
X-Google-Smtp-Source: AGHT+IGP1YVSO5G5A7NPOF9hu8UMZmUxtP+Fj7fvYTNYvV5zNSe928DhT3IQzPqsLEwOPja96dJF23KWfgwjHorjZPM=
X-Received: by 2002:a05:6512:3c96:b0:545:1dea:7b2e with SMTP id
 2adb3069b0e04-549b1c370camr195846e87.6.1741750201654; Tue, 11 Mar 2025
 20:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com> <20250310150835.3139322-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250310150835.3139322-5-andriy.shevchenko@linux.intel.com>
From: Kyle Tso <kyletso@google.com>
Date: Wed, 12 Mar 2025 11:29:45 +0800
X-Gm-Features: AQ5f1JqezutAuLR9RCiDwHugv6YDAlJdEYt9fLJCmtrMads3aQIZSAKhgQtQ5Ys
Message-ID: <CAGZ6i=0GuBvEU41Offobn1MzMuFumn9F6JLHXsKppPidkjCLVw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] usb: typec: tcpm: Use fwnode_get_child_node_count()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rob Herring (Arm)" <robh@kernel.org>, 
	Markus Elfring <elfring@users.sourceforge.net>, Jakob Riepler <jakob+lkml@paranoidlabs.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:09=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since fwnode_get_child_node_count() was split from its device property
> counterpart, we may utilise it in the driver and drop custom implementati=
on.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Kyle Tso <kyletso@google.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index 9c455f073233..8ca2e26752fb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -7166,7 +7166,7 @@ static void tcpm_fw_get_timings(struct tcpm_port *p=
ort, struct fwnode_handle *fw
>
>  static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle=
 *fwnode)
>  {
> -       struct fwnode_handle *capabilities, *child, *caps =3D NULL;
> +       struct fwnode_handle *capabilities, *caps =3D NULL;
>         unsigned int nr_src_pdo, nr_snk_pdo;
>         const char *opmode_str;
>         u32 *src_pdo, *snk_pdo;
> @@ -7232,9 +7232,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,=
 struct fwnode_handle *fwnode
>         if (!capabilities) {
>                 port->pd_count =3D 1;
>         } else {
> -               fwnode_for_each_child_node(capabilities, child)
> -                       port->pd_count++;
> -
> +               port->pd_count =3D fwnode_get_child_node_count(capabiliti=
es);
>                 if (!port->pd_count) {
>                         ret =3D -ENODATA;
>                         goto put_capabilities;
> --
> 2.47.2
>
>

