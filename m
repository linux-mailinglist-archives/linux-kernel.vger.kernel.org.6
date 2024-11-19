Return-Path: <linux-kernel+bounces-414221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAC09D24E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4FA1F22BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374D1C8788;
	Tue, 19 Nov 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="dE8Gk1gw"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67401C9DF3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015857; cv=none; b=cyqYfro5b6mpl3dGRljDVAp9RYoGIT4Z+14EfVGpJD4shnBhd4q83KrZtuJZGQxOgGVMQkx6vZZ65JsjeO5JsNrYrQUE8kV4aVgJxFvXkGXEXO1ZTLvpG3LQizXKnS9f1FD2l+UTzYvNiQKlOE/7AypCGHM0dccdKk7ZB66weCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015857; c=relaxed/simple;
	bh=7cGMC0JSae0yj/PWFPiCPDIjD4oYyoho7eIZOlOAeMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXUL0zqjA3G778GS6LAamLp1tRpY3KPQnsgSSBkOOXxG/dIRGThDaQiGRrg0iWzyvRx9KZvymxhuFMPh/tS06Pv48O+PH0vkis42rGmKuysfy/J9PbPXvk276faq+/F5qEp6SsoWw87Qy20FN7VUY4DyudF3VbUww8SXIhW5TH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=dE8Gk1gw; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53a097aa3daso2824262e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1732015852; x=1732620652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKwxKd5SMLLl6j1wqgSg6vRFE0Andwn/GjHqBxY+oho=;
        b=dE8Gk1gwawPRwwgFezl8HgQsSIpoyFHO9eUMmjTlzQ3SzE54ERb/zKMkzO24dNGzGN
         zO4JYq6RLfUwNKTmOyGGvDvisNwpdf51taa/sFmQ+ZJljEv/qRFOllcIIHdbMSa+CeFq
         EXCSXVqIIDk38K/s27op7pFY7utCIPV/Zz+ZjbCwEstRsVRIUy0buLLFbuGSBwBBbr+q
         uQ+CcXRp/+cu0skWQD2e21qB4jGTATvI5SEk6yopZkmmOSyrNOAiJHfiYM8kMqYMaSN4
         y4I3Q+bPeXtSZnF6PxGk25R0HsxpNC/Uh3CpuVsbfCgtI9llXb9587QueoRKiop22q9J
         FFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015852; x=1732620652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKwxKd5SMLLl6j1wqgSg6vRFE0Andwn/GjHqBxY+oho=;
        b=FcLSOPxKDCiUHlGqqakw73RQh4bG4G5vBj+J72gjXtq0CXcOKbi9IrjcvRag6wqsPZ
         VoPeXWZxh496vl++jAygGN6EVQI4vRlUKBoMRpMqKqjV67FkGiQe3HPHukVYLOhmDBho
         BPwsEywXt+WDfO1Y2g0u7hRtgdwkglqnvkg8KEGL5fy5l/P8Phnj6RsZRoYIyMD9v5C6
         HXLtjieQaCshnJqWtiu4po2Bn2GfQ5WLzuVEU7gHx0AN++yLrakxO1Cv1RUzzP0ePGPo
         sOWgJmx8LG9Ia4WMjjO/whT6hF4U/hF6ws9A0++BpIzDbVKfO6MPHjJi3jgXioGO4SJL
         S1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVuz+C7gO8S/Fdvwy/bUyhHDYDpnvnMVMJIS8/WC/LksBX2u0lAgKgpVwp5QBiL9bzzdnBo3X3iLQpWuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0IoSXUSj9lTr+WMfT4OAiX0vvf1cruzzDvcOAjTZ9MveAlaq
	NmKvSKLOuB8p/o21PqtsJWmqlveILXS45/Cd3y2bzao4cJ2NjMVl5d11oU8xaiKS+mmMEVl1CTE
	QvtOvXGEYcMcNwBVblnm8bbv3Lpex/Mz454Ux1A==
X-Google-Smtp-Source: AGHT+IGgDrPcP42r6Mykqqve++SYMiYoBLLuXEcKJ8Odoey2Gw+rjXy59n0lXdXEBiuizDXRmQkISh7faoV70Zej13k=
X-Received: by 2002:a05:6512:a8b:b0:53d:a000:1817 with SMTP id
 2adb3069b0e04-53dab29cc39mr6595733e87.22.1732015851781; Tue, 19 Nov 2024
 03:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
 <20241022-ssif-alert-gpios-v2-2-c7dd6dd17a7e@gmail.com> <434333fb-5703-449e-83f2-46e85f34fd23@os.amperecomputing.com>
In-Reply-To: <434333fb-5703-449e-83f2-46e85f34fd23@os.amperecomputing.com>
From: Corey Minyard <corey@minyard.net>
Date: Tue, 19 Nov 2024 05:30:40 -0600
Message-ID: <CAB9gMfphfY0H721G9qV8_3sm1d_RTnKkWbEOeqC-0ox9p4cfCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ipmi: ssif_bmc: add GPIO-based alert mechanism
To: Quan Nguyen <quan@os.amperecomputing.com>
Cc: Potin Lai <potin.lai.pt@gmail.com>, Corey Minyard <minyard@acm.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrick Williams <patrick@stwcx.xyz>, openipmi-developer@lists.sourceforge.net, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
	Cosmo Chou <chou.cosmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:30=E2=80=AFPM Quan Nguyen
<quan@os.amperecomputing.com> wrote:
>
>
>
> On 22/10/2024 08:20, Potin Lai wrote:
> > From: Cosmo Chou <chou.cosmo@gmail.com>
> >
> > Implement GPIO-based alert mechanism in the SSIF BMC driver to notify
> > the host when a response is ready.
> >
> > This improves host-BMC communication efficiency by providing immediate
> > notification, potentially reducing host polling overhead.
> >
> > Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
> > ---
> >   drivers/char/ipmi/ssif_bmc.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
>
> Thanks for adding feature to this driver, the code looks good to me.
>
> Reviewed-by: Quan Nguyen <quan@os.amperecomputing.com>
>
> I'm just have a bit of curious on how the ipmi_ssif in host side to work
> with this mechanism? Will there be patches for ipmi_ssif to use this
> feature followed?

I just saw this.  What makes you think alerts are not supported in ipmi_ssi=
f?

-corey

>
> Thanks and Best regards,
> - Quan

