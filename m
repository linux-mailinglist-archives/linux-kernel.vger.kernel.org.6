Return-Path: <linux-kernel+bounces-179691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF88C6363
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075321F230F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828EA56458;
	Wed, 15 May 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b="W4Mibdny"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9355C3B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764022; cv=none; b=mA/EoaLPE1AO/wC61vqwYFJT5MP/7GO1l6EqqYKfRHm/b5qSrzLFx9zRP0tvKrqRLOSGoaUMDbzLVDgasW1YrKAQZn+y+Kfpl6krTSL6KLSOLhW/XBtz9jG0AgJsjnxDUR6G49u55QI9dWv6cjzEsJKa0I518JG6HkKtTQU00+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764022; c=relaxed/simple;
	bh=1xrqSVmY6y5f0IJU/CJ9W0rn3p4eJZgwKOfeaSBXORQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7H/xhpM/0lTPJBqlGIlK0yPaePsvgRvjWzTFEdRzEbMtboWNAV5tE5SsQGfIjRBob8+2mmDu2LQVHG6BF6QltGj1m9427yHS79QHRqwWssI6jWooyCsfN5I1A1A/y/cx4WCLYpgg2dinNp1HYzt0LKSN1ci3mv4xcg68SYg2DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org; spf=pass smtp.mailfrom=cryptogams.org; dkim=pass (2048-bit key) header.d=cryptogams.org header.i=@cryptogams.org header.b=W4Mibdny; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptogams.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptogams.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e271acb015so85953291fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptogams.org; s=gmail; t=1715764019; x=1716368819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCN4Aw4+b34uYf5T+77CTVPm7n3v2SZABsZPxP6R4EM=;
        b=W4MibdnyEPm6VESKpU3NOozrmFp9lvzvSDRa92N6z8tVpClECojxMWGzKLzQIwY0wx
         F88b7mwtSrnt043J6VHiKCWARXxk/yfNYQQNd9ZwHzRH0lxPWrMcvzZpuG1S2uxRoHHO
         GcvQve3Cd3Q3eWxZACI+SwupUFcXYURiKJmSqJ6Zb3ampvurpwZYdrhsnCO9Dldt8aiQ
         m7M8bsJA4aYj8wV+BlYdbRGqOd+fO99tceqbfsmGI+ueUEWuodzmiqqAzjfBVrDTJy30
         KmDPu3EVkktp+kknNqIIxy4+KSei23oQvUuUME1W2Y3YRNyKwBhZDVlmYJXvzL6jKj+t
         5NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715764019; x=1716368819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCN4Aw4+b34uYf5T+77CTVPm7n3v2SZABsZPxP6R4EM=;
        b=cDJ8+3PGCfpqxd/4ZAeTbAKC7EPSGhQh755K9PuHrkDp53GhBVS4lwCkWI6IgxGxtf
         3wwikRJYpc2vrKVEs+cXuzOKi1msaDCKKjc3L1ZiQNKGNF4Yy8c9IYi2DNXpU4pksc0v
         7yBdHCuLS7gaCrGWW59gGudoQJ3XHEI8V1T7IwB0v7pKT6ZOcHM3SKo/fEH762jRoP9X
         rZXbKiQ5RX0GuMprpU6mn1Ymp0AsKEAWpP5UxIy3Fy8HSNPK1EAE9sNMv4netwLCG2Xp
         kyVVzsOIlaoVzWrYBU1Teav9QeNCM1btF6X5f4cav6Nk+xIe3mLVIqh45AF6BWn5PAmP
         G8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVZZciG32iVEb0wbU5/Cy8QMJIBnzE+Qzjofae5/dZvu2848nB3UOucQBOvFWLMb20W15Qpc9SdacB5DKfEKyfTOm4p/yHQ3WpoFcqI
X-Gm-Message-State: AOJu0YwTOh1wU2inx3iL2dZbzdFhp5ONoATBDnFxltWliP0Ly8r63l/O
	UF4oFgrUN1hs3BXHdzN4Lk/0U7axNvTU6on8Q6m+mU8m2JynQg1WHcbowyDl+Pc=
X-Google-Smtp-Source: AGHT+IFGA1MJpKD7oQyr1PZIq0Tmx5HGUB13Z1Mg0iiS0ZqwHQj3FyTq5u9WwgiEAYYNn+VyIwyrpw==
X-Received: by 2002:a2e:a794:0:b0:2e6:f3af:c6aa with SMTP id 38308e7fff4ca-2e6f3afcb13mr16822391fa.40.1715764019239;
        Wed, 15 May 2024 02:06:59 -0700 (PDT)
Received: from [10.0.1.129] (c-922370d5.012-252-67626723.bbcust.telenor.se. [213.112.35.146])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d1621233sm20272571fa.126.2024.05.15.02.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 02:06:58 -0700 (PDT)
Message-ID: <db513fd8-4723-4b4c-bc14-7da7222617b3@cryptogams.org>
Date: Wed, 15 May 2024 11:06:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] crypto: X25519 low-level primitives for ppc64le.
To: Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, leitao@debian.org, nayna@linux.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com
References: <20240514173835.4814-1-dtsen@linux.ibm.com>
 <20240514173835.4814-2-dtsen@linux.ibm.com>
Content-Language: en-US
From: Andy Polyakov <appro@cryptogams.org>
In-Reply-To: <20240514173835.4814-2-dtsen@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

> +SYM_FUNC_START(x25519_fe51_sqr_times)
> ...
> +
> +.Lsqr_times_loop:
> ...
> +
> +	std	9,16(3)
> +	std	10,24(3)
> +	std	11,32(3)
> +	std	7,0(3)
> +	std	8,8(3)
> +	bdnz	.Lsqr_times_loop

I see no reason for why the stores can't be moved outside the loop in 
question.

> +SYM_FUNC_START(x25519_fe51_frombytes)
> +.align	5
> +
> +	li	12, -1
> +	srdi	12, 12, 13	# 0x7ffffffffffff
> +
> +	ld	5, 0(4)
> +	ld	6, 8(4)
> +	ld	7, 16(4)
> +	ld	8, 24(4)

Is there actual guarantee that the byte input is 64-bit aligned? While 
it is true that processor is obliged to handle misaligned loads and 
stores by the ISA specification, them being inefficient doesn't go 
against it. Most notably inefficiency is likely to be noted at the page 
boundaries. What I'm trying to say is that it would be more appropriate 
to avoid the unaligned loads (and stores).

Cheers.


