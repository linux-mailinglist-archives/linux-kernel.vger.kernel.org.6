Return-Path: <linux-kernel+bounces-220268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC8A90DEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8E381C22D97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE502178378;
	Tue, 18 Jun 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="nU0Tj+hA"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931D15EFBD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747237; cv=none; b=H0ivTLu+i+qUFlGoU9sJ+o+hxWbDPXZr2azoliaBDAft3XneG9X1QoVFI1nGzE84szbcR4beBxSdgiC6KQc8yCzF1LU1CNQ1HTsyPsPtEGULs5eEHv38a0x2/bGlM6qrvfk5j+istwj/JJnpc/s1un1qU+z2Vwg0wDMje5u2rlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747237; c=relaxed/simple;
	bh=O8nbxBnAi/dpmzEyYIIUoH5D1eSn0BiZGFoC27wUa4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFTKoMfv9HOtZ9SQefmlQwZXV5RhEFut34ZQlZOlVT+Z7PM735JOnIWY01YZCsPJHBvHXabHfowo/9XdTBAgMfCfiO+OwmiCY9cPlwbC3cULgzqq03Pncpyi8iIbCvLCFEi2Kdm2rGMRVuVo0XbiZTdzI4xr3ldtJZ0nuGZSm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=nU0Tj+hA; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eb75c0d0a7so188408739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718747234; x=1719352034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/36AxVI5Kg9rJfKi/PCkX0OMQO0RBqJsC7Ok+ofUjE=;
        b=nU0Tj+hA2MpzZC6lVBhZgsb1/M9j1nAusQa6zahN2wbDwegU097JRqdjbFY9Qxwhlx
         hIsPXxFoekWjCsupMX64QWe7cVqCZHQj47JLZp7toqEMYdrpKAzceLEQ/Iefaa4ZF7lj
         JoRLL+FJXMpc/tlUBVZsLRSzZI2EMmxFv2eXc1KLf/ej2cxrNa5UxQOZBwYzeojt5S2o
         4kOF+JWYGLxy0M8g6JzKdmb7bIJI89QCwCO6NHJlkWgwTtoFk/AeUK3GPs6UfYA+LgNR
         CUZVWL4gjHxyhc7KLnHv6XsT5FSQynNZIg32ZVlSuEKl1AtU+iwCaBIJTZOG+K4XQR1O
         pcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718747234; x=1719352034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/36AxVI5Kg9rJfKi/PCkX0OMQO0RBqJsC7Ok+ofUjE=;
        b=JXoo59nkNkUT8xJSeRfX4pvOQZpA2fCi95KK/ri+qeLwoNE2224Qd0UsJgvc2wkbsN
         +NR0n0GczCAkbRX2w7KjGAazVqkbwvXKYq/MaoFP/IbcVgPuCFiV6lvAtIwfbqIF9r7D
         6MRIJ1z2vUDmIcVhjqS0FAmnQnk97tbuEsZcQXtYQtt3lh8FBg5ER5xYEfbo3jVes2oF
         G1MEfxW3kkwFJ2hH+StmMlmKXRgWd02YB5nfc3kkWNwu0vuBgfsK2XEnJ9CSljHkgkfq
         1ZsANEcZeMVbQ7mNMZv69eVeOZZ5LiBRAyppW7QXR/jUT3Zt+YLeVwaTKp4BwVDjmiL2
         kR1w==
X-Forwarded-Encrypted: i=1; AJvYcCUdwbheFdTsmmxTeUeIiP/fUujoYVZ3vkenUtPNSCcZFC4XHbxkT1mstuQPD/NaFQbBkKf5+OdH+1NkUp82rSlH1aztWP/2BC9dm4c7
X-Gm-Message-State: AOJu0YxpL8QmH8o+LJbDbc77jRSkdVMeiHOh+2sQ2jHbwWSYPdXMmYB8
	Bni78273+U7MQXmbEeYASDZ4wF8sjrH49pTFwvYHVV0S4qdp3peV7EJXimwR49phRBnxI1rrN+X
	x4mJ7aA==
X-Google-Smtp-Source: AGHT+IH6Hf6328sCOCn8+mJw4wcG8+kO+0Fz4jzSb3pwTOQ63zlhyvlNQ9WXloxluuoF6mjJntA2hw==
X-Received: by 2002:a05:6602:164a:b0:7eb:8887:d6c3 with SMTP id ca18e2360f4ac-7f13ee56f08mr126705539f.11.1718747234553;
        Tue, 18 Jun 2024 14:47:14 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a30de2sm3365204173.153.2024.06.18.14.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:47:14 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:47:11 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: Mario Limonciello <mario.limonciello@amd.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH V2 RFC] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnIAX9P5XSco4cZw@kf-XE>
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
 <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
 <ZnHtPbszYT8afOOk@kf-XE>
 <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com>

On Tue, Jun 18, 2024 at 04:24:22PM -0500, Mario Limonciello wrote:
> On 6/18/2024 15:25, Aaron Rainbolt wrote:
> > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > 
> > The _OSC is supposed to contain a bit indicating whether the hardware
> > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> > be considered absent. This results in severe single-core performance
> > issues with the EEVDF scheduler on heterogenous-core Intel processors.
> > 
> > To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit",
> > which may be used to ignore the _OSC CPPC v2 bit and act as if the bit was
> > enabled. This allows CPPC to be properly detected even if not "enabled" by
> > _OSC, allowing users with problematic hardware to obtain decent single-core
> > performance.
> > 
> > Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
> > 
> > ---
> > 
> > V1 -> V2: Rewrite to work in cpc_supported_by_cpu.
> > 
> > RFC: I have not yet tested this patch to ensure it functions properly,
> >   nor have I attempted to compile it against mainline. My system takes
> >   a couple of hours or so to build a kernel, and I'd like to submit this
> >   for feedback now and test once it's sent.
> 
> Thanks, this matches what I suggested, hopefully it works when you test it.
> 
> One comment below though.
> 
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index b600df82669d..af2d8973ba3a 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2063,6 +2063,12 @@
> >   			could change it dynamically, usually by
> >   			/sys/module/printk/parameters/ignore_loglevel.
> > +	ignore_osc_cppc_bit
> > +			Assume CPPC is present and ignore the CPPC v2 bit from
> > +			the ACPI _OSC method. This is useful for working
> > +			around buggy firmware where CPPC is supported, but
> > +			_OSC incorrectly reports it as being absent.
> > +
> >   	ignore_rlimit_data
> >   			Ignore RLIMIT_DATA setting for data mappings,
> >   			print warning at first misuse.  Can be changed via
> > diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> > index ff8f25faca3d..7346a25e68ce 100644
> > --- a/arch/x86/kernel/acpi/cppc.c
> > +++ b/arch/x86/kernel/acpi/cppc.c
> > @@ -11,6 +11,14 @@
> >   /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
> > +static bool ignore_osc_cppc_bit;
> > +static int __init parse_ignore_osc_cppc_bit(char *arg)
> > +{
> > +	ignore_osc_cppc_bit = true;
> > +	return 0;
> > +}
> > +early_param("ignore_osc_cppc_bit", parse_ignore_osc_cppc_bit);
> > +
> >   bool cpc_supported_by_cpu(void)
> >   {
> >   	switch (boot_cpu_data.x86_vendor) {
> > @@ -24,6 +32,10 @@ bool cpc_supported_by_cpu(void)
> >   			return true;
> >   		return boot_cpu_has(X86_FEATURE_CPPC);
> >   	}
> > +
> > +	if (ignore_osc_cppc_bit) {
> > +		return true;
> > +	}
> 
> I think you should move this check before the switch statement.
> The reason is that such a workaround could then apply to any CPU
> vendors and models that are AMD or Hygon too.

Oh good catch, I thought it would apply to everyone but missed an extra
'return' in the switch statement. I'll make sure to fix that in v3.

> >   	return false;
> >   }
> 

