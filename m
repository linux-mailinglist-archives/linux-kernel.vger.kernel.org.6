Return-Path: <linux-kernel+bounces-387940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B19B5833
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AFD1F23C14
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B011185;
	Wed, 30 Oct 2024 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lb8Z8CrQ"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A5D517;
	Wed, 30 Oct 2024 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730246628; cv=none; b=QBZ1o54EG8Z3gWnXbAypDvXjFCwsTlWExpDh0eiRGsGMWNdUT8ziJDFVjp1b+gI9reii6xzIjbAXMwRHMGkkrld7+AOqvGHNcv0trjxQE0WI8efJJQDq6cRnECMfQ8Nsw/457yUfalZ4kYVaePG8It11T/L0rO3ifNiWs4hSpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730246628; c=relaxed/simple;
	bh=lJ62VeqeyfSXeMCf0BWYVDHUBfy3Hb22PLXv73uereA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXlsE1roH34mS3gQMftEVzbsiUjaqw8kgK2vb3RwXj3nRpPwWEg5zfl9V69xmGzNAidGSNc7tONRWGXWWOVVdzdMxF9Is9yFfKmLKShqLGjZYtbEg+s11/y/fZtuDpIMzg9YnBr1S5JnrK3IoOsy+vZn+Dm0DN1c0Uk7rWe8Upk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lb8Z8CrQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db238d07b3so4448008a12.2;
        Tue, 29 Oct 2024 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730246625; x=1730851425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xs2Dqzb5EmENFr8Eu1V+VriqI6zScBCq+Z1hofY+Mdk=;
        b=lb8Z8CrQqPWu9r0j/BE3jU8C+7sZPf3cSLSwgVwKkRv46xR0SuxsRMyyPk+jOcL7Th
         tRaKBdHZF87MSukgqXHPyOPqamS/vmjy6v4Ir0FttzEokipb4XJCRzm9n8aNjFwH821I
         Ms6Dk9LMJwOWr+6osJs2b2HlhXgzSLYjpq5BgLx7bw5fYpB4s01dXPWmqOj3gWJewG0Q
         pz6rMy0hJMO/9jfyuG+t96WOiYMQnAVjaEVfDW+ZDaHIU2fifvk5BBJdANWbEHmpsbKk
         U2uxZifhHTToUCJ3a1GIHPkyP2oOcbhkKIVx9IJPECJcidPi7ZZk5lmOsrER5vUBi3+2
         vRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730246625; x=1730851425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xs2Dqzb5EmENFr8Eu1V+VriqI6zScBCq+Z1hofY+Mdk=;
        b=KSL33b1AFB2VIKPvs/IVm+GB2SJknGG2Ro99ZMTEvU6z0jQyghVniJL/twL/1CrNMb
         Qf5ST6wLSwSxZ0HkShBVF5M6UXNh6msIpaRiyZiKfFal+heUmsPopU1Gtdaq49rb7S6E
         LNbkozVTR/OJOwQhU0k5mDXiyAy4ZBTUC/w91ciPw4mnx5wYLsp2FPpGSbFFByRGrj+r
         RGvezA/GI4gyeNFXbKk51lhQCOaeTnhtNmittTZAFQz1rJEUC7pizr5LwMhTtcuDUaE2
         pXREq+Ej5557Hvp7LseQfAoI0coPR1YBxW1WeVNGilGK9La4RaU7tG9gvEA2h+HgyHd6
         0IVA==
X-Forwarded-Encrypted: i=1; AJvYcCUNa9upJgVc4QxD9o93qDL4uaPRhflG1xrLirtQ/0I2onYSdyqQZjHSPB5Lam85VoWkw9K9CRcldUZPnXc=@vger.kernel.org, AJvYcCXmqrCPf4jTj8BSv8XRRhWhg/kZN+bW+So8XJLeX0imcmFSg9Zru5lEGsEM48q1aGwk5iZ43DCm+gTEa5X2V65wRoTodA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFyBebeGh3sPUVE9NEDfLzPjx1x6BpojdzlP/Nj8ydEAebSR/t
	HHBswZbUt6r8mTesjoCDIqLMqtBcvslah1WI+DjVs4OczGM5tTo5
X-Google-Smtp-Source: AGHT+IFuZtjoboKtzTA3CRKQSpSoWxWmicnqmID/NI9hMnKI9czdmuWV0LmIOo66oFQ5sPFyi+x6iw==
X-Received: by 2002:a05:6a21:3414:b0:1d8:d600:2c6b with SMTP id adf61e73a8af0-1d9a83aa150mr15263491637.3.1730246625394;
        Tue, 29 Oct 2024 17:03:45 -0700 (PDT)
Received: from alphacentauri (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8495cabsm8189905a12.0.2024.10.29.17.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:03:45 -0700 (PDT)
Date: Tue, 29 Oct 2024 21:03:42 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v10 4/5] alienware-wmi: added force module parameters
Message-ID: <ffpx5vvpy7twwcbqfxj2dni2bq625sd57irepbxxit3ut3mbzg@f2oogtlvot23>
References: <20241029135107.5582-2-kuurtb@gmail.com>
 <20241029135354.5937-2-kuurtb@gmail.com>
 <677c9b97-8eef-4001-a276-e9bc68538b81@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <677c9b97-8eef-4001-a276-e9bc68538b81@gmx.de>

On Wed, Oct 30, 2024 at 12:13:45AM +0100, Armin Wolf wrote:
> Am 29.10.24 um 14:53 schrieb Kurt Borja:
> 
> > Added force_platform_profile and force_gmode unsafe module parameters,
> > allowing users to force `thermal` and `gmode` quirks respectively.
> > 
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> > v10:
> >   - Introduced
> > ---
> >   drivers/platform/x86/dell/alienware-wmi.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
> > index 1d62c2ce7..91f0e09d0 100644
> > --- a/drivers/platform/x86/dell/alienware-wmi.c
> > +++ b/drivers/platform/x86/dell/alienware-wmi.c
> > @@ -42,6 +42,14 @@ MODULE_LICENSE("GPL");
> >   MODULE_ALIAS("wmi:" LEGACY_CONTROL_GUID);
> >   MODULE_ALIAS("wmi:" WMAX_CONTROL_GUID);
> > 
> > +static bool force_platform_profile;
> > +module_param_unsafe(force_platform_profile, bool, 0);
> > +MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
> > +
> > +static bool force_gmode;
> > +module_param_unsafe(force_gmode, bool, 0);
> > +MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile is selected");
> > +
> >   enum INTERFACE_FLAGS {
> >   	LEGACY,
> >   	WMAX,
> > @@ -1075,6 +1083,16 @@ static int __init alienware_wmi_init(void)
> >   	if (quirks == NULL)
> >   		quirks = &quirk_unknown;
> > 
> > +	if (force_platform_profile)
> > +		quirks->thermal = true;
> > +
> > +	if (force_gmode) {
> > +		if (quirks->thermal)
> > +			quirks->gmode = true;
> > +		else
> > +			pr_warn("alienware-wmi: force_gmode requieres platform profile support");
> 
> Please drop the "alienware-wmi:" prefix, it should get added automatically.

Right away.

> 
> With that being fixed:
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your review!

Kurt

> 
> > +	}
> > +
> >   	ret = platform_driver_register(&platform_driver);
> >   	if (ret)
> >   		goto fail_platform_driver;

