Return-Path: <linux-kernel+bounces-526319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6390DA3FD3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131FF3B954C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929B224C698;
	Fri, 21 Feb 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEKyiLzO"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3124C680
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157942; cv=none; b=D6Fr2N0kwMPdCv50JmN8jNskcX1LH9vFMzDUFGy5c6BJkX9rfx2IOzGlKRb2c3EmYYrDfGn2gS3JEbFTvGqqaKS/ziqDyB09PVvyR2x2hscsivUY4U5syTzp+Ha4gDGDTfG/68BAftte7in4ROruc+0j9CQdnOZLvV1n6cxiGAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157942; c=relaxed/simple;
	bh=DXvFTs7oxh7lPTo/mbOBZb379NqGajHAFQFN6oblHdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exGmMs6A24S523nj+UFSzecstazCdMcRUkT5fXD5NO/+bqdwIMCOAkFR+/rTQ1WOvukLZ2PbGZukIdKmuOzRYFCmf+k5BpynACNeRmbcuLF1ogvpw3jiR0ZWMf6P005CWfKtQp5AUl7qxkwvN8gjnJyCi8yJpSz/b4yvdjacEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEKyiLzO; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e67f377236so18342216d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740157939; x=1740762739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvm0spvO2odf0aHHsM8EDOsI9Ul6jn5O/yToI2VY3kA=;
        b=SEKyiLzOhUc9nWziV7ruL5BqL06T3P4lDNPc4z+ezS7U9jkxsuOu/QGJMxSlBPcCni
         s9J/RgNEwz2YVMkytRf6KR39/TIyqJ/BKjPhfuRKDlRlcnW28eSbCA+1E+nxVTv57a4s
         uPJi2utgTc5LIGaTtXD2SAkUdLl3uHKJTd3tca4FMxRYbi08rnkVWkbB+PXkXQyEE1hF
         DAKnBCsQxdTfKZ+0nQ/khhfV9qYxPDe1+WXzwdv6bhpENO/LTNpGOgNIINemVWtOvXkZ
         +Xe5ob+zRjcYPOhMcJeIXfxcHgLy/1Nm6ZIZ2GUlFwLqiuKGc7uP1Ahox8xkK2/3tzNA
         y7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157939; x=1740762739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gvm0spvO2odf0aHHsM8EDOsI9Ul6jn5O/yToI2VY3kA=;
        b=NdR5XmssFqiG3DmjsywVox8hRU6r3QwjdN5jprrFamVh2ZyOjSGIXpseXF22smbLo5
         jErgn6CDNXvw1twsqpjGHnMebXHF0n/r964ihA1oUQb1MtkwOxCc9OXav5DQHCk/37uR
         QLtoTDn4V2D/WLK5XIrFHU28j5q0t6UlbHIYh90lrP6AaGNF35VNXE7xG8DPc4stK5Mi
         bK58boR1Va1nP9LExr5eV8Z7oqCJ5s585HMfOV72zn38dpG58HlqRId2Ub8gOP8nUgMC
         dw00vlk3KXvMzaPVwAp2aLNFcHRvSvncamiBh0vZvL9WQM2pyXXLXyHKGh1HNaaXhdqc
         Di9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFTDfuE2EC7cw8E3Dr3Ywy11EHEHYXeWzPGWMVyb7ZIwLwVQGvddErwuaJeqqEOjQAQei7Jr9TCVcWhAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoM3z/MxYZQCXYks9wbe2TsPN+9IC0yhAIed8N3Wh1bMkzilX
	BxMTEaWKU2aw02wIBdhljRNxzdvh8Cu8MX32BwrAqb6N6nkHy94K
X-Gm-Gg: ASbGncuKYklkgRMq8SXoE6wEVOtI0bhrtEZnN895olqLoZAle0KO6TF8ftbHxYPCcPc
	Zx8b5be9vCnjM1PxZ4QreuVyzzn+pA+Xq3Ll6tfdwcM/Gho9j5LjzaODgOGQT5PSIgUWnwbVdvu
	1jiLHFheCbHmx8UIhWzRT76YGKNa+9RQ4ACDQ/2Y6QsRgjx82W+FcCxVg5gdNbsjxrVGGC8r64h
	elt5C6zUwpUSrSLd7ZyFfTX0LVQ9QC1Hjz6Oi1XrHm6mVl3oxy2mgaiBcKcItDdnA0LGQJLkMby
	rfSOZwrJ60KgLAV7EYcdp8m8xPMfGmTOPYqxbN2ctjSbZ60W/DKAl15nZMN+DAmPmw04NK225mu
	mL/aAOTdWhEl9MHYK
X-Google-Smtp-Source: AGHT+IFjz6/XWqgrOc/wxviH2i2uUN1ZBOPiZFcPTkpBgZA6YfE7uJZDiS1EyvuQ9fK1Orj1klTwkA==
X-Received: by 2002:ad4:5d65:0:b0:6e6:5d69:ec1d with SMTP id 6a1803df08f44-6e6b01c68e8mr41738656d6.37.1740157939147;
        Fri, 21 Feb 2025 09:12:19 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77959csm100393536d6.21.2025.02.21.09.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:12:18 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4595B1200072;
	Fri, 21 Feb 2025 12:12:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 21 Feb 2025 12:12:18 -0500
X-ME-Sender: <xms:8rO4Z6mWbzWfFfaAJU5WEWyv2cQTegPlA01SmHrriVIS57agAjVPWA>
    <xme:8rO4Zx0YobszFd7NfkZjlJxxoV41upcDZKRvOHe8YLP_Tae1coEGVZeIhFU-2ypyB
    rAH0T9zwldDOxNSQA>
X-ME-Received: <xmr:8rO4Z4qqXfcQmgtfFkx5lJAzj_ku7Ng3tHAAVVWoLmyZTY160_jNvfmBrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephfetvdfgtdeukedvkeeiteeiteejieehvdet
    heduudejvdektdekfeegvddvhedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegsihhgvggrshihsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhu
    gidqrhhtqdguvghvvghlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuh
    igsehrohgvtghkqdhushdrnhgvthdprhgtphhtthhopegtlhhrkhiflhhlmhhssehkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:8rO4Z-kENaLoP6Mt7t3W8HqQn-L_EmWtF78qvAWnET220bukehqZ8Q>
    <xmx:8rO4Z40xDIS1k8l7MyjBc4-S_rivC3iGQZGlmKdcIbvO71Form3s_w>
    <xmx:8rO4Z1tjmKLHgxkIIi8w7y5cazwit6GC0Z_7qVoWiZggZe379w9yAw>
    <xmx:8rO4Z0Whpxi3WV2K2BmHYsD1tSJIeE0aNdfRNjrskT-vvw6C-bYT2g>
    <xmx:8rO4Zz11kKQHNpbd_BTNJw319ujQCxDK6duhzVTjOcLSvto6ASsKlEDM>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 12:12:17 -0500 (EST)
Date: Fri, 21 Feb 2025 09:12:16 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] lockdep: Don't disable interrupts on RT in
 disable_irq_nosync_lockdep.*()
Message-ID: <Z7iz8I6QD9Amjfmw@Mac.home>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
 <20250212103619.2560503-1-bigeasy@linutronix.de>
 <20250212103619.2560503-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212103619.2560503-2-bigeasy@linutronix.de>

On Wed, Feb 12, 2025 at 11:36:18AM +0100, Sebastian Andrzej Siewior wrote:
> disable_irq_nosync_lockdep() disables interrupts with lockdep enabled to
> avoid false positive reports by lockdep that a certain lock has not been
> acquired with disabled interrupts. The user of this macros expects that
> a lock can be acquried without disabling interrupts because the IRQ line
> triggering the interrupt is disabled.
> 
> This triggers a warning on PREEMPT_RT because after
> disable_irq_nosync_lockdep.*() the following spinlock_t now is acquired
> with disabled interrupts.
> 
> On PREEMPT_RT there is no difference between spin_lock() and
> spin_lock_irq() so avoiding disabling interrupts in this case works for
> the two remaining callers as of today.
> 
> Don't disable interrupts on PREEMPT_RT in disable_irq_nosync_lockdep.*().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net
> Fixes: e8106b941ceab ("[PATCH] lockdep: core, add enable/disable_irq_irqsave/irqrestore() APIs")

Is this "Fixes" tag accurate? IIUC, the issue only exists after
CONFIG_PREEMPT_RT is introduced from mainline POV. Or we want this to be
backported in older stable kernels predating CONFIG_PREEMPT_RT?

Regards,
Boqun

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/interrupt.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 8cd9327e4e78d..a1b1be9bf73b2 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -448,7 +448,7 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
>  static inline void disable_irq_nosync_lockdep(unsigned int irq)
>  {
>  	disable_irq_nosync(irq);
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
>  	local_irq_disable();
>  #endif
>  }
> @@ -456,7 +456,7 @@ static inline void disable_irq_nosync_lockdep(unsigned int irq)
>  static inline void disable_irq_nosync_lockdep_irqsave(unsigned int irq, unsigned long *flags)
>  {
>  	disable_irq_nosync(irq);
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
>  	local_irq_save(*flags);
>  #endif
>  }
> @@ -471,7 +471,7 @@ static inline void disable_irq_lockdep(unsigned int irq)
>  
>  static inline void enable_irq_lockdep(unsigned int irq)
>  {
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
>  	local_irq_enable();
>  #endif
>  	enable_irq(irq);
> @@ -479,7 +479,7 @@ static inline void enable_irq_lockdep(unsigned int irq)
>  
>  static inline void enable_irq_lockdep_irqrestore(unsigned int irq, unsigned long *flags)
>  {
> -#ifdef CONFIG_LOCKDEP
> +#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
>  	local_irq_restore(*flags);
>  #endif
>  	enable_irq(irq);
> -- 
> 2.47.2
> 

