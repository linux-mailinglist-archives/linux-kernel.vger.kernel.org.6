Return-Path: <linux-kernel+bounces-209677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F7390393C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996C11C219F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB7179675;
	Tue, 11 Jun 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="222edido"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BB17838E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102977; cv=none; b=RHGgsrgvsSICIlLypHN5ikob1E7W+Bhk9KyiqB4QOfT57k5DpvHyakCfhxfViMdUSfPj1bBC9H4BsjZq5RQs6pA9E0cm36E12wCQgbMgNY0HKY0D6Ue9DYajGUkOKn6kZYTxJiEWcOocwfFbPQF6tUurB47X+e+fE9MGkHhkBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102977; c=relaxed/simple;
	bh=4O2Uxmz/F3XBT6FyYTlGE7PHtHM5nOk8ldOnR0efqfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rouJRgH5efLwSHg/DqOLcf8nKCT46QCGF4uGYL/FmGRtCi44Nrc9qygTnRL7cHQ79CLgJu862rZTt4xyPYxm63zzYSm0/mGtY+Ddx4YKosYFonaVJVCZRLrimDAXViQ0EhTQOmEkHtGg2RgWyIfLxc+k1gss8VF7AvhLtWaNKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=222edido; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so56825e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718102974; x=1718707774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSVKo2pe01AB7x7GbbPrXmfw4EIFhok1cqIc+dcHHns=;
        b=222edidoL4/s3k/k9oDV4Ia+ILrMbySgrkWAGIjceFA6dj+DMwc+8YNbt0KiGBfsAg
         0RLpGGorcM2zPRhaH+q4eJM5aKwmd1BcB53s1uw/2wFld4vCkGbpGknfxkrkiJtfGJPG
         qe/J+sYAIjEqrtP7YXPHpWNhCqzi07O6Wfb5hkyfQVwT4ZcCOf+08Oas15BjJ06HcCXW
         Ve2zkRj9TwoiiFRWvarEvH94O2JPEfWl7bVDU7xZjBZH/3IVHCd1DUJzz/XpOP3FDuQb
         uN4qcdzx9RDSEgJbjordkhiNVK4iLztyZNJSycrKwKjqNCMkBbmf12aGh9x37CshvyyG
         uilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718102974; x=1718707774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSVKo2pe01AB7x7GbbPrXmfw4EIFhok1cqIc+dcHHns=;
        b=s+uH0xeRl4/PIjHmSLSkxZDMoz/zGxtPiu1pmgXunGqEX92wXkXWvX4Gk6KiED7IDn
         GIwjrKb/Ucu4thZoRAsBwKH2otD3DbAkpO//LFWM6ZtoO3k510neYuY/DCOBW7+MLthm
         pvgvDca7FVzG1800YZgvgseDaPp6b9h3zM/z+S48NJ6CNkTG2Y9/F1tPndmZwif8N/kP
         3Felwq9UmTXZHigX37ieT1hoemOSO0z9+Bx26k03WPPbWiOw9jbtFruNDrPuvLOyZLZA
         gJ/jDPCK65GVqSn9q16/1K3HiJendU8opSd301+xo1bUJgyvRLjJ5jk9NFn9kkNPeAd9
         ihbg==
X-Forwarded-Encrypted: i=1; AJvYcCUY3TtOyjDzGN+8yuC7mC70mrPO6tF+VTKgS/1s4aoFleYJWxgjcuUSgXavMJDDY+bUS8zpL8YbEVPiW32teu2djtkdIYvQZnahWYeN
X-Gm-Message-State: AOJu0YwnC4n8Uh3sfD6RGhOQGNyoqntPZtsbR6IIuy3ezhrLgzdpHFt0
	6XAdXY4hVHxZfVTIDtI4DUhntVI/K8HS4xa/QmHu6b4ptpcB3xHQhSssJ7Q7vQ==
X-Google-Smtp-Source: AGHT+IE5yzeTqofjnZB7D8WgGPQP5pjB7l7vijEDXFyCgt3o0q6KfIKPTWLi9xb+HTV8eET3Fu25Qw==
X-Received: by 2002:a05:600c:c0d:b0:421:292d:f1e7 with SMTP id 5b1f17b1804b1-42244f454ecmr1465415e9.6.1718102974037;
        Tue, 11 Jun 2024 03:49:34 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4221defede0sm38840675e9.7.2024.06.11.03.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:49:33 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:49:31 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Conor Dooley <conor@kernel.org>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org,
	maz@kernel.org, Rob Herring <robh+dt@kernel.org>,
	Dragan Cvetic <dragan.cvetic@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 2/2] misc: Register a PPI for the vcpu stall detection
 virtual device
Message-ID: <Zmgru836nv3CP5wt@google.com>
References: <20240523160413.868830-1-sebastianene@google.com>
 <20240523160413.868830-3-sebastianene@google.com>
 <20240524-joyous-fantastic-2747ab94e83d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-joyous-fantastic-2747ab94e83d@spud>

On Fri, May 24, 2024 at 08:00:42PM +0100, Conor Dooley wrote:
> On Thu, May 23, 2024 at 04:04:13PM +0000, Sebastian Ene wrote:
> > Request a PPI for each vCPU during probe which will be used by the host
> > to communicate a stall detected event on the vCPU. When the host raises
> > this interrupt from the virtual machine monitor, the guest is expected to
> > handle the interrupt and panic.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  drivers/misc/vcpu_stall_detector.c | 41 ++++++++++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
> > index e2015c87f03f..c580cd7fd225 100644
> > --- a/drivers/misc/vcpu_stall_detector.c
> > +++ b/drivers/misc/vcpu_stall_detector.c
> > @@ -32,6 +32,7 @@
> >  struct vcpu_stall_detect_config {
> >  	u32 clock_freq_hz;
> >  	u32 stall_timeout_sec;
> > +	int ppi_irq;
> >  
> >  	void __iomem *membase;
> >  	struct platform_device *dev;
> > @@ -77,6 +78,12 @@ vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
> >  	return HRTIMER_RESTART;
> >  }
> >  
> > +static irqreturn_t vcpu_stall_detector_irq(int irq, void *dev)
> > +{
> > +	panic("vCPU stall detector");
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int start_stall_detector_cpu(unsigned int cpu)
> >  {
> >  	u32 ticks, ping_timeout_ms;
> > @@ -132,7 +139,7 @@ static int stop_stall_detector_cpu(unsigned int cpu)
> >  
> >  static int vcpu_stall_detect_probe(struct platform_device *pdev)
> >  {
> > -	int ret;
> > +	int ret, irq, num_irqs;
> >  	struct resource *r;
> >  	void __iomem *membase;
> >  	u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
> > @@ -169,9 +176,32 @@ static int vcpu_stall_detect_probe(struct platform_device *pdev)
> >  	vcpu_stall_config = (struct vcpu_stall_detect_config) {
> >  		.membase		= membase,
> >  		.clock_freq_hz		= clock_freq_hz,
> > -		.stall_timeout_sec	= stall_timeout_sec
> > +		.stall_timeout_sec	= stall_timeout_sec,
> > +		.ppi_irq		= -1,
> >  	};
> >  
> > +	num_irqs = platform_irq_count(pdev);
> > +	if (num_irqs < 0) {
> > +		dev_err(&pdev->dev, "Failed to get irqs\n");

Hello Conor,


> 
> platform_irq_count() either returns a number or EPROBE_DEFER, I don't
> think emitting an error on deferred probe is the correct thing to do
> here?

I will drop this.


> > +		ret = num_irqs;
> > +		goto err;
> > +	} else if (num_irqs > 1) {
> > +		dev_err(&pdev->dev, "Multipple irqs detected\n");
> 
> Typo. I don't really see why you're going to this level of complexity
> though, why aren't you just doing a single get_irq_optional()?
> 

Thanks for the feedback, I simplified it by using the
platform_get_irq_optional as you suggested.


> > +		ret = -EINVAL;
> > +		goto err;
> > +	} else if (num_irqs == 1) {
> > +		irq = platform_get_irq(pdev, 0);
> > +		if ((irq > 0) && irq_is_percpu_devid(irq)) {
> > +			ret = request_percpu_irq(irq,
> > +						 vcpu_stall_detector_irq,
> > +						 "vcpu_stall_detector",
> > +						 vcpu_stall_detectors);
> > +			if (!ret)
> > +				vcpu_stall_config.ppi_irq = irq;
> > +
> > +		}
> > +	}
> > +
> >  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> >  				"virt/vcpu_stall_detector:online",
> >  				start_stall_detector_cpu,
> > @@ -184,6 +214,9 @@ static int vcpu_stall_detect_probe(struct platform_device *pdev)
> >  	vcpu_stall_config.hp_online = ret;
> >  	return 0;
> >  err:
> > +	if (vcpu_stall_config.ppi_irq > 0)
> > +		free_percpu_irq(vcpu_stall_config.ppi_irq,
> > +				vcpu_stall_detectors);
> >  	return ret;
> >  }
> >  
> > @@ -193,6 +226,10 @@ static void vcpu_stall_detect_remove(struct platform_device *pdev)
> >  
> >  	cpuhp_remove_state(vcpu_stall_config.hp_online);
> >  
> > +	if (vcpu_stall_config.ppi_irq > 0)
> > +		free_percpu_irq(vcpu_stall_config.ppi_irq,
> > +				vcpu_stall_detectors);
> > +
> >  	for_each_possible_cpu(cpu)
> >  		stop_stall_detector_cpu(cpu);
> >  }
> > -- 
> > 2.45.1.288.g0e0cd299f1-goog
> > 
> > 

Cheers,
Seb

