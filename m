Return-Path: <linux-kernel+bounces-175254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8586F8C1D14
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B061C21C97
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5FB149C78;
	Fri, 10 May 2024 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqLW4GmA"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A413BAC8;
	Fri, 10 May 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312176; cv=none; b=qtWV2YwljkJYDaWoZoMr/kbohRnwd4k0E2u9PAY9oZ5yF5fegIbcC8F+rxAcg1i6p2phZ1oednNU9C7VwVcyA//4YTVmfIb4A4sLQ1TBDihMDS23Ig/YAibeIJwyCe85n5dQZsQi6KTlKQ4AI0aXuHkA+DQ4tvPRUuuwsvd56eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312176; c=relaxed/simple;
	bh=KOSn1hZhv1DeOtrd/XQIWrqlLlDGMSahtKxPMjKo1v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO1R1vLqziIlze33pUr8/L2Y8KEjxtLaPcMXwnHnfD++i6dpGtYynSDY5/LTIjGNGmUzfmjxTnT/iRYEq5XSyJRan9q7VQYz7wlfwzqgChu2UF0WfuDPXaJG5ESF7s9gM/YWacfBm2Zxz2Tqw+52LpLVPzOnixBlWvKkhDPUbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqLW4GmA; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ff57410ebbso1301587a12.1;
        Thu, 09 May 2024 20:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715312173; x=1715916973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=om+gVHo+UYQCK20XV54trkvgwUZ7dLC7k9R/3N8VLiQ=;
        b=EqLW4GmA4bZtF1KFsa9TxT5M4ieJ1Y6EO9M16RWMHtVfvXvGG3tB0T4j5vRFoPPWGy
         w480zePmbiero3u00+O6KJ6rduFapBCQ9oOzgT5KkyhZAvdUE79+sh7gPpsdcwjn6+2X
         E40VT19olM9fqymq6FLo4dVBDC/CoJ7Zr0h0Ua3L2QuddQcbn1Ko4VRjCpANM1iC0n7J
         Gmh00sXkNj24PAhOlIN5A8eJv2s0SC9dWCJwdxlL69D7n76xCvEn+n2lZdNpG0ZrdhTt
         D2uZUDWVESLaQ49+bgSYFwYdsP9DoLp03ejH5E9g3AKsCV2r2QPmEEC9ic5KpU1bXhTq
         AqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715312173; x=1715916973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om+gVHo+UYQCK20XV54trkvgwUZ7dLC7k9R/3N8VLiQ=;
        b=VGcA6jymm65S0RYgGWZ5uyvpMHo9f96syANhdVnUOTm6VCUFQt+0TX9kA4K5UE1mRW
         JSH9aiXjbIEmXkDA9QPqqLi/vGnkJ1a8DUXGbKKjcou+W1/2C0F4rubrMAxhRYq1ISl1
         gEecZgI7GUkjzNvPggOfx/VAteqPGixeJSeWaDk11BEFFsorNQZ1XCiX/TNM+IGpSWWJ
         K7cjXwh4/AuTmAd5B27SecYKG0P5qDZmPSpBuoPMldCYPa8cueb3RqbaobIvJK6BQSId
         d0y37Z7cMA9vYFe9kMkiDdHOuergVzLaCpnZ2eJyorgOPpFRJ7vW5IOVjFuWsvnNB/+u
         iJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU92N3KrH+rfuINHMcuEzcHewO/PzoRzv5rV/vr4funPJLBczcCy6/YP/slCT6ocPED8QzqEqgTUDM45nThWXU6RxdjWxHoqVFpgaKn//m/xi1neN85+5FmJCaV0qner6KH4IpJV0Hu1sCii7cEqIiZt/YrGOXCu0BkGq2V2rVuozfEZjjR
X-Gm-Message-State: AOJu0YzlnU/n5RUIwv+0vMngZqYFRviuFgidBAHBkKYOPFclOxerN3NY
	O7Qzg1arDYk2Tskb4R7/BfgXhwUxIcGl7ejoY9aPsKppGNMNOdBH
X-Google-Smtp-Source: AGHT+IE/0hqi92CFy7Q2dWIvYr/EbTY5YJEnOOZwOajGysRIZOSYsI29MBVKXbBecsK3oAg+mdknlg==
X-Received: by 2002:a05:6a21:35c6:b0:1af:8104:46e0 with SMTP id adf61e73a8af0-1afde1b7ee1mr1601971637.49.1715312173404;
        Thu, 09 May 2024 20:36:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67116413dsm2243612a91.13.2024.05.09.20.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 20:36:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 9 May 2024 20:36:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Document adt7475 PWM initial
 duty cycle
Message-ID: <94c843e2-4415-4786-bfd4-a77fdbbfab07@roeck-us.net>
References: <20240508215504.300580-1-chris.packham@alliedtelesis.co.nz>
 <20240508215504.300580-2-chris.packham@alliedtelesis.co.nz>
 <fe5b3af9-b307-45e1-b190-ba2b3327a8df@kernel.org>
 <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11093bb-230b-4918-a8cd-4f4eb760ccf3@alliedtelesis.co.nz>

Chris,

On Thu, May 09, 2024 at 06:19:12PM +0000, Chris Packham wrote:
> Hi Krzysztof,
> 
> On 9/05/24 19:06, Krzysztof Kozlowski wrote:
> > On 08/05/2024 23:55, Chris Packham wrote:
> >> Add documentation for the pwm-initial-duty-cycle and
> >> pwm-initial-frequency properties. These allow the starting state of the
> >> PWM outputs to be set to cater for hardware designs where undesirable
> >> amounts of noise is created by the default hardware state.
> >>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> ---
> >>
> >> Notes:
> >>      Changes in v2:
> >>      - Document 0 as a valid value (leaves hardware as-is)
> >>
> >>   .../devicetree/bindings/hwmon/adt7475.yaml    | 27 ++++++++++++++++++-
> >>   1 file changed, 26 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> >> index 051c976ab711..97deda082b4a 100644
> >> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> >> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> >> @@ -51,6 +51,30 @@ properties:
> >>         enum: [0, 1]
> >>         default: 1
> >>   
> >> +  adi,pwm-initial-duty-cycle:
> >> +    description: |
> >> +      Configures the initial duty cycle for the PWM outputs. The hardware
> >> +      default is 100% but this may cause unwanted fan noise at startup. Set
> >> +      this to a value from 0 (0% duty cycle) to 255 (100% duty cycle).
> >> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >> +    minItems: 3
> >> +    maxItems: 3
> >> +    items:
> >> +      minimum: 0
> >> +      maximum: 255
> >> +      default: 255
> >> +
> >> +  adi,pwm-initial-frequency:
> > Frequency usually has some units, so use appropriate unit suffix and
> > drop $ref.  Maybe that's just target-rpm property?
> >
> > But isn't this duplicating previous property? This is fan controller,
> > not PWM provider (in any case you miss proper $refs to pwm.yaml or
> > fan-common.yaml), so the only thing you initially want to configure is
> > the fan rotation, not specific PWM waveform. If you you want to
> > configure specific PWM waveform, then it's a PWM provider... but it is
> > not... Confused.
> 
> There's two things going on here. There's a PWM duty cycle which is 
> configurable from 0% to 100%. It might be nice if this was expressed as 
> a percentage instead of 0-255 but I went with the latter because that's 
> how the sysfs ABI for the duty cycle works.
> 
> The frequency (which I'll call adi,pwm-initial-frequency-hz in v3) 
> affects how that duty cycle is presented to the fans. So you could still 
> have a duty cycle of 50% at any frequency. What frequency is best 
> depends on the kind of fans being used. In my particular case the lower 
> frequencies end up with the fans oscillating annoyingly so I use the 
> highest setting.
> 

My udnerstanding is that we are supposed to use standard pwm provider
properties. The property description is provider specicic, so I think
we can pretty much just make it up.

Essentially you'd first define a pwm provider which defines all the
pwm parameters needed, such as pwm freqency, default duty cycle,
and flags such as PWM_POLARITY_INVERTED. You'd then add something like

	pwms = <&pwm index frequency duty_cycle ... flags>;

to the node for each fan, and be done.

That doesn't mean that we would actually have to register the chip
as pwm provider with the pwm subsystem; all we would have to do is to
interpret the property values.

Hope thie helps,
Guenter

