Return-Path: <linux-kernel+bounces-230816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4587918237
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F471C21346
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46D181B80;
	Wed, 26 Jun 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MkABVdL6"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD911E51F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408153; cv=none; b=WKiIrYBEOt9nSVZEplgmjQDE1FzU4p97plDpvihOnakm/zHYtGtY70ykKK6PZJoo5wykoL6xJ9YNi4aWFGow7SxU4XXlwHWWn/qYTwaeeNqPxHwT0myBL2AGhhF1EyoMa/elfwaul3Ijy/cqLQEsZn9NO+1dgz04nMd2sGmcPUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408153; c=relaxed/simple;
	bh=XxBobdsohKtbbp+VDP9sBXJLs9uMbEUbONhmhgK7pq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5LPy7Dj8Wkrgdp/pjD69JOWBKd0xeXMjlpVBcBCzXVm69XH93DbSRr1bWfv99Lkc698M59qLZw+g4jMGgg9M8BsbwAXuDXqB2Mv2crj0BB7+AoyygIqOstft9dgJb7U96IwYM/dDzZO32YAN1g4cG7Pb8QgHyeordyxOT/297M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MkABVdL6; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-700cc388839so954305a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719408151; x=1720012951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5xewZHY2oJYxuRQNOBT5mZfboUik/lCsriRBhVol24=;
        b=MkABVdL6PzsU5MPCrZFzZFCczVjW1kUU2yObpmVSqXL8Xz0lfIhZvyXnvgWZHSlfDq
         Bd7cnz0GMGG2yRO05qkcnnGOLa67jjxn8WntvfOKOE1QnS02ClVmjobWGt3sDpLhWqhb
         ZOB2W0E7tGQjrr7XnVlbWkNJvRaNPD9QuqvdHkgeYAM2efmsk92ZvP2exj/XmhHzp2h4
         eDOYuLlQOvO5KDoQgPVR2eCfcksG5B+LUZAPm+UDCJqQFnSATipors1djcA0e8M0qa6Q
         mB2w5nVmQKCoz3EraLt3k0wP2NfIuSFwduNUWlKm/mjIgszBjrPaQ2QKPm+p1bCT/7T/
         BzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719408151; x=1720012951;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5xewZHY2oJYxuRQNOBT5mZfboUik/lCsriRBhVol24=;
        b=BzRgn1Jygarzgts7+ZP2yZ9lA5Nq/byvVwHCeQSyy0XTq09IANTJRYklNh0XC7LBPd
         nWCOwIWO2siKd45LRgKQvm+/fNmzSH2BdN10WSjZKDA2vqj2XKAOrUYvHGdUBqOuptz1
         J6kMNwk1FXJVpBAovG9SxC0tXB4SAahBAphorLZoVoy+Cr7lMnR1MMpdVy7mO2ihldP9
         TWn7ED8bVKD9LRmsryRON2/+8Nv/fxUYIPc3zZWKg3nDFhgeZdxt6AKO31hUrbR0p4sx
         V//KBOfN+q0bQ3JXCCRwK+q1Z+oQXto9n4+wdxe3j1/BaA66UltJYnCbAClfafZEPPoK
         y+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJyQf2Rco9nCk7R3WzyHq81oJDaCz37kWT1OzgCyWJVt84lV2cs1dMSVw0N261iEhnq25t3uRXAayIAQ5tQdtkz2Za8FUuqEe8KE7r
X-Gm-Message-State: AOJu0YxpVH2l+9hrUattjPqm0elQceIrkCl8JC6l9+hhtwEiitWOX2i/
	ckDe6GxM13sK7V744q7w2hwmEWNKeF9oiFJ7r4QDsRBBbDwtIsDIIMtWTsY8PDg=
X-Google-Smtp-Source: AGHT+IFQ7TQc949+gnCiGt+D4TzmOQ0Ckn0QWBw98q32b0sD5xDjYU5NsCtAsd0KDekGkzXy4fWwFw==
X-Received: by 2002:a05:6830:1d46:b0:700:ab11:86c8 with SMTP id 46e09a7af769-700af98902emr11454041a34.22.1719408150773;
        Wed, 26 Jun 2024 06:22:30 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-700d369f8adsm118762a34.48.2024.06.26.06.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:22:30 -0700 (PDT)
Message-ID: <6f5c1de2-42da-46be-9af1-9b293e4ac3e5@sifive.com>
Date: Wed, 26 Jun 2024 08:22:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/fpu: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Masahiro Yamada <masahiroy@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Palmer Dabbelt <palmer@rivosinc.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, WANG Xuerui <git@xen0n.name>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240622-md-i386-lib-test_fpu_glue-v1-1-a4e40b7b1264@quicinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240622-md-i386-lib-test_fpu_glue-v1-1-a4e40b7b1264@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-22 9:55 AM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 now reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_fpu.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Fixes: 9613736d852d ("selftests/fpu: move FP code to a separate translation unit")
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  lib/test_fpu_glue.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/test_fpu_glue.c b/lib/test_fpu_glue.c
> index eef282a2715f..074f30301f29 100644
> --- a/lib/test_fpu_glue.c
> +++ b/lib/test_fpu_glue.c
> @@ -59,4 +59,5 @@ static void __exit test_fpu_exit(void)
>  module_init(test_fpu_init);
>  module_exit(test_fpu_exit);
>  
> +MODULE_DESCRIPTION("Test cases for floating point operations");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
> change-id: 20240622-md-i386-lib-test_fpu_glue-437927d4afe3
> 

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


