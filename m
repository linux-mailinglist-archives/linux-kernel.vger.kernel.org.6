Return-Path: <linux-kernel+bounces-412560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6389D0AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADEA1F216B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1808815442A;
	Mon, 18 Nov 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rAZckC15"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31518E25
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917627; cv=none; b=bWrJAp+fAHd1Pqh2yMGrwGwx8hNMf/V3oD03i/hmHeth/sNldl1l91LP4QQgjIkr2S6n4r3dPY0YVxwE9JyI/QFEXyFMOhVdiAKmAHOQciz78uZQIv4pC3P+eqgVFZNRUj3v7gIHVAod5Fu8DpcEaMCUVWbiQzT1efNvIBsrQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917627; c=relaxed/simple;
	bh=EjN2FOjlhXfTzPg/EElgB1IbsKczLAtQuB4kZcdGrz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVtriDoAmE9zUG8q4jV//Jjd5cKNC/AdG+Di4kZL5NFK1lM2JzU+6CqV+Jy0S3N7Vqc02XQP93CYyQChHcLx0vdrYPMy/VKhJ0jv4OjXwX1gtRNJNYT3TonpNRQVoFv801XI1+//L4B/EdNjVpthi6ElRQN9UEl1dSQwE4AHTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rAZckC15; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so24650175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 00:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731917624; x=1732522424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PrD3D7iL//Mh4abst76FIfs2+jhPNoFsbOsCfvfo52E=;
        b=rAZckC15T39AAAHjUkHcKvCW/07531piOOnzYnoRefrds1d6WjTE9jFwCGNR4gq0tm
         KcPE4pNuA3/CHTDAyeiPD4/i1cZPChtWY6VV1AHINT8chcQuYBpElBuJrUhdhwrhysnJ
         1X0Ahd5TxXiPJC9sv3x9T8w2b0Un0vyubn/hFOXeRTor4rKqhLrvoCIZkj6vyqwzvoFO
         vI/eCTB8S7/OQBRM1JOsPGBc9R5ShaINHoASg97LhCP0396VOunqBg8uZd46WuDE8qG+
         0QeU3mcVkuSMYxFdBLOyPltEdD7UHjocMaSf8Fc8fygJMObIcZ+EZt5ZtAoSQfUsBiyl
         1Zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731917624; x=1732522424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrD3D7iL//Mh4abst76FIfs2+jhPNoFsbOsCfvfo52E=;
        b=D/a9T5h5xfOuKVZG8MRCYA7pR27uD8O4j2gdkaWay52iXNKqTftolti7zMN/cgDZ7u
         ht0wcd8wnSokrue/GwlVUZLWMRnu1tFUakNq6AC0gM8GMX56XCU53SEgn3JMlQDJiMt0
         rfhOOrAQh5/+5vUzKofWqPtnMBb0oJpdsdISAcJ+aOH7TUQ/z6HEapNee7lpYDLHCm5X
         gVtzhxVAECZv9YHXg+3634vVhiz7PBWfBVRQSxHZK2mdcS4c2Vwr8W35085EOMfm8gol
         nD/qgGPzRNaRDBc/EBaoCR2WFPn94kzDpZQrqkhOAVwqH0GFpYWDl2DT+KdLHOoQK7y8
         2ETw==
X-Forwarded-Encrypted: i=1; AJvYcCXgjs+1rcyqc9ED3EzuEIlDFoFzOapQQcpnnMvemLZmWXecb7eZlUQYR/hkscS2DR4Cm7uFe6+DXg3Zlmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4+lyJNSG4BIv4KIcdotEnJgGhmBPDEKSGjrwKujLDrmn96hh
	+ozrcvNjQPWNkMcWQJEbyFCNv+Qs//djMsv2MqApfXJCa1LH2TypJnkUmvwBZmo=
X-Google-Smtp-Source: AGHT+IGuQUg4zqLcof123OuTET4pS8hUz2MMP7MXmYJJ7qXDFxQQcBUhfeky+bsj5tZDGaDRRwX7bQ==
X-Received: by 2002:a05:6000:402b:b0:382:383e:84e2 with SMTP id ffacd0b85a97d-382383e87e6mr6160452f8f.46.1731917624022;
        Mon, 18 Nov 2024 00:13:44 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823390c818sm6944834f8f.28.2024.11.18.00.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 00:13:43 -0800 (PST)
Date: Mon, 18 Nov 2024 11:13:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: improve size_add/mul for 32bit systems
Message-ID: <f8ed52f5-51e0-4fe4-a1f9-d840979f52a8@stanley.mountain>
References: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebdae636-11f3-4f02-a158-f15bbed2847f@stanley.mountain>

On Mon, Nov 18, 2024 at 09:09:28AM +0300, Dan Carpenter wrote:
> On 32bit systems, if you pass a long long to size_add()/mul() the top
> 32 bits are truncated away so the function doesn't work as expected.
> Add a test to prevent this.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Sorry, I thought I had build tested this, but actually I didn't build test it
enough...  Probably the kbuild bot will complain soon.

regards,
dan carpenter


