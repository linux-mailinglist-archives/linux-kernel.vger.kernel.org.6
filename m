Return-Path: <linux-kernel+bounces-273320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290094676D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 06:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CCF282A95
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 04:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0882A78676;
	Sat,  3 Aug 2024 04:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXMBpSqG"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D816F2EA
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659328; cv=none; b=eCCFTzNRLp+Lj2VR943OccOSW26lRhGCvw2GTO9znUC5VEhs7DuMRBaS2mWtBzOJO1rECUE3+N5EmFqjKqQFAP+sWTBsOCHGay/lTUZ9gwg3vqNDFVLl8EM02IJnhdkuVyf4RcXTa5TyF6eBmQa3oqZImDvK2gaOeOHxDX95V0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659328; c=relaxed/simple;
	bh=A0FigfRcdI5TmtnLIowXNHNmseW9E6VQpT3GSq9/Ec4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHRxGHrxGJF8A75xhuB4Ujm3Tt4AApqwKaazWm1H/GMoYlvdghLwxyLQwaxnCu53kNVJkr6yQJz7WZpvlaNxirx8E6Hlx/xmPeyhQ0KMHq8S64vkiptsfOUT5B1NU83VOG+rUv3IcpLx/91547LqMAMQXJfjI9w0kdIkyu+ydjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXMBpSqG; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db14cc9066so5417609b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 21:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722659326; x=1723264126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rzn92C1AHPPlWzjTKcidqRR6Rxvggoz6sIIwczUKFlg=;
        b=zXMBpSqG3EtonY7DXYXLqGTPmU1d8C3PBmSdRNu43BSuunbKc2VdNnARnkMhibigYh
         HPNQiQxbN3VR9zutxDq2gTh3Nqlh1UGkr485JmTzc2FO4Ngaod07IzQ9f8i09D7WhGav
         AF+vfoVQdXEwGVU7YTyHVXg+1LwOro4a5DhTFF3H2YtvEX4Wb3RsJDFdEFnQ28IetKeT
         wn6DdyklbZSA4a8WuPtHrFdagZKJDmpMI+DUoAHa8gNkiqy8nG+8HoKIp36OyD8Z52Pj
         6JF9TlN82dnJ4bfOxAVA7WIfl7rEr4PJLOBsbbVGc15jjocvAXSkI0qAtuKi/fdOAkmm
         6YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722659326; x=1723264126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rzn92C1AHPPlWzjTKcidqRR6Rxvggoz6sIIwczUKFlg=;
        b=msFI1tB9zvMG041TjeW+cwytaSALzhphnu8pkW7r4wdxdvVEAbPWU1xXrStbvAhuTG
         gdFbPazMSth+xMaS1FV/oSlMTwl9KWxTX6DzSEMJBldgDFiljvqp18fEuXZk040dyIRt
         J4wCFMen5cMezkfvlKmOb+GhUfRtsFt7AhROXtw6FP+QKCwOYfKhOmVyJ3rUoyzUDb/M
         /MGHIu2Q+uemLQogCR35MzuXYYOt5K4AIjFktoCU8vMUjYyYNoc4Fk++V2BSI8/euySh
         91+hW+jRMK68QIst9tPZUDkrrdT9T40xCzfkGu6IcjskojL/9/R2x8u8BINf+uF/yU+O
         N4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuAVAv4GI2qKBb/lelpsq72gTHExExi2m2K+Lgf3u4De9i/+mOw1RtS5oP9/1yX/BYp9UD4BSgTjezETolue8QyqfV9eyIpdEUPNv0
X-Gm-Message-State: AOJu0YzmXcbTZn5XNglysom7WCuRXW/d9KaP7VzpSk9NBWoOp1iKhHGA
	0VEEbv0hw9rR98j2gMnP11PHUSzgKB8OS7YpNzulYwBnuhp7/W7OMgm8UOFWFmLa0BhfbuNljJk
	z
X-Google-Smtp-Source: AGHT+IHxWS3iNqvAAzqLqQWuBAFRbxKqLawxiRW8lxpchWWctf2N+xj8WDxTH2k/CshLA+HBc83npQ==
X-Received: by 2002:a05:6870:3314:b0:260:f054:7774 with SMTP id 586e51a60fabf-26891d3cb1dmr7021954fac.13.1722659325803;
        Fri, 02 Aug 2024 21:28:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2689a2a826asm790540fac.8.2024.08.02.21.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 21:28:45 -0700 (PDT)
Date: Fri, 2 Aug 2024 23:28:43 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Whitton <spwhitton@spwhitton.name>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com,
	Hans de Goede <hdegoede@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: atomisp: Add parentheses around macro
 definitions
Message-ID: <8d383b9d-d029-4706-91c5-9623fddf5df3@suswa.mountain>
References: <20240730062348.46205-2-spwhitton@spwhitton.name>
 <2024073020-reload-vanquish-f937@gregkh>
 <87v80i475p.fsf@melete.silentflame.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v80i475p.fsf@melete.silentflame.com>

On Sat, Aug 03, 2024 at 11:28:02AM +0800, Sean Whitton wrote:
> Hello,
> 
> On Tue 30 Jul 2024 at 08:38am +02, Greg Kroah-Hartman wrote:
> 
> > This isn't a "complex values", and really should just be removed
> > entirely and use the correct "static inline" properly.
> 
> I found that there are several headers in
> atomisp/pci/hive_isp_css_include which have this pattern of defining an
> _INLINE_*_ preprocessor constant, and using it to choose between
> 'extern' and 'static inline' in each file where the header is included.
> 
> I don't know what the author's intention was.  Are you saying that you
> think this preprocessor mechanism should just be replaced with
> hardcoding 'extern' or 'static inline' in each file which includes one
> of these headers?

*You* need to figure out what the proper thing is.  Not us.  That's the
difficult part of writing a patch.  Once you know what the correct thing
is, then the rest is just typing.

That business of defining STORAGE_CLASS_SP_C is weird.  Figure out the
authors intention and find a better way to do it.

Figure out why your code compiled as well because putting parentheses
around (static inline) is a syntax error.

regards,
dan carpenter


