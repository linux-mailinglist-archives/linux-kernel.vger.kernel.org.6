Return-Path: <linux-kernel+bounces-286789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3E951EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2731F1C2178A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A3C1B86D1;
	Wed, 14 Aug 2024 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJrBP9ra"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307631B29CF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650428; cv=none; b=b9OjMhHqYfYYeNJC+kI3WO+mM2KYpFrVo+ASY3dmeQ6EaFXDSotAydP4CMhPgWtedaGBb/C1n/z2h5rbZjB4g5UE9hr0n8vY1Znw+WA1jlYFo812Vu6T2PiuSUgyhGnMyEre7uQkni22doQywNEbJV4PvqqQwsY6agNEZ5o/CoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650428; c=relaxed/simple;
	bh=6s2UZiIbIL+xs+ThX4zHMsNr9MWrd6Lm3gZ9jqqawDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuyo8OiGVN1jkDz59kAbqTSdzuis98jKO+DtAnmRDPt2mwJXGFgQK+nIYjPa6BpVsgEX5MQD64+QP5hfMvO/ZFFDfEHkOLNcfBjoPMyaAqMQrQ92lpf3gPzEx6bP52ErNzD3eb/IkLQXJ89dxnsrr1ES52da4ICk4N6kIIQ3GnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJrBP9ra; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso52052515e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723650425; x=1724255225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxHKY8j9JY9GSssq+v7MBgIA0lHkRpEmbrmi0vFachA=;
        b=VJrBP9ra2mHREB30p6Ha5hk6E6iqh0Tk/tK1f7PxaujenUMN3aVDRKQkW2xWtojVKE
         VJImKgzByA5ZQPZTR14/s4r7+05i7UBotqcM4YVduVzF7Qz6ntnuzI1MuhgqPq6k5PlC
         omhh13mxOrfFHrBlPUelAmCHl/Tv472HK2v9oY7ihLQZyBeWJl/ji9r446lVWNk8mvyH
         t5G+XGoo7iCU9q6pb46bVxX4K9R6mHgHdzsOTXiEyPzfFwuT+RN3CSf9rTv+5AlbwyaL
         u00pKmRmJD4kYUhv18BYN/DYgLPWizKuYBYJIfuq7aA7u1rdNXMeas8AesrKuKe2AyW8
         TTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650425; x=1724255225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxHKY8j9JY9GSssq+v7MBgIA0lHkRpEmbrmi0vFachA=;
        b=J1Q7NnUwN3uwOpGFCJ0zDMywehV2tLENAKBbHX3rdQQcG2CUxDYfHhqfehEsG2SI0b
         NtD7LrIuNLntRJCd8iVxol3JhkrA1vUl8xqrkGR7+4R8YzXMxX+NQB54m/N7HiGxF1hI
         QRD5E8cGn6lFkGfiJM14blRp6n/wdFTfeSonbqxhUhPv0v8bIkgxPO048ErGxdLR7QSd
         amX4y11vaH6KYcfE3f2NkndlNBvfiGt4s97XH+q1+1hfrksZ9qwoAblfNqQu9c0PWvde
         CbE78U/xENHSeauP06Muqvkl7Gev/q2xpUoayfvoWfJEKStCCgzRhtRSavIB8WtQ6Yu1
         ee7g==
X-Forwarded-Encrypted: i=1; AJvYcCXrcMnzW4ZjhBTL9d54Dflfk1HGrvjvmM9+GWybFAowkn82dnrcIHykzD/csyUYgRLDquSFAdS4ymgLOYn6jCdieDrowqj+yVkgtTtW
X-Gm-Message-State: AOJu0YzcjenxfdA41lk45cr244CS+K9Zc7TYSylBd6TpFlSwpnvUX0nl
	IwTCXp4NRhIYlfKngyypAMYOQZrBM0QeVN3X8q+0snngOal4MBwMIke436niVD4=
X-Google-Smtp-Source: AGHT+IFJ7TTrqW106H8grxaPaM4TrNtxNgYAZzlQEAw+ii2wjX4qbf7zwRvdMCxwyRkjkZNGpv+B0w==
X-Received: by 2002:a05:600c:1d06:b0:426:67ad:38e3 with SMTP id 5b1f17b1804b1-429dd22ecb1mr20690655e9.3.1723650425302;
        Wed, 14 Aug 2024 08:47:05 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded36f55sm23611115e9.26.2024.08.14.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:47:05 -0700 (PDT)
Date: Wed, 14 Aug 2024 18:47:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Enno Onneken <ennoonneken@outlook.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] reboot: add missing break to switch statement for
 LINUX_REBOOT_CMD_HALT
Message-ID: <750452a3-ac8a-4af5-849f-3db83158a1e5@stanley.mountain>
References: <FRZP193MB2563F43FFC350926C0B7EEB1DC872@FRZP193MB2563.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FRZP193MB2563F43FFC350926C0B7EEB1DC872@FRZP193MB2563.EURP193.PROD.OUTLOOK.COM>

On Wed, Aug 14, 2024 at 04:24:45PM +0200, Enno Onneken wrote:
> All switch-cases should be isolated from each other due to shutting
> down/rebooting the kernel in different ways.
> In order to fully isolate this case (like all the others are), this patch
> adds a "break;" after do_exit(0); .

This patch is obviously harmless but the commit message is not clear what the
motivation is.  "missing break" in the subject is misleading.

do_exit() is annotated as a __noreturn function so it's already "fully
isolated".  It sounds like you are using a tool which doesn't understand the
no return attributes.  Better to fix that instead.

> 
> Fixes: 15d94b82565e ("reboot: move shutdown/reboot related functions to kernel/reboot.c")

This isn't a bugfix so a Fixes tag isn't appropriate.

regards,
dan carpenter


