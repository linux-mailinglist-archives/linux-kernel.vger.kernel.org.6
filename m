Return-Path: <linux-kernel+bounces-332086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5D97B541
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 215CEB2707C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0C1862B9;
	Tue, 17 Sep 2024 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvM9kJJu"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945BB446A1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608822; cv=none; b=ROjk1GZ3xWP33TEMMh0BgpK6L1vWNEFamCSO2vxl0P868S3VsFG57VT3QfcV57smBW5LDgwpvkUxmriSjoQ8Hl5CxhZtrybYAvb9938GZkWSbIj4mmowcSvpN0k6gUm5uuyw5oKWfv3681sX1Q0FLEdgt5zaCPEKIHZX/S5bfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608822; c=relaxed/simple;
	bh=Z1uLbveJ56wcm5PNmTgORzaYuJDI2kO8pQRQgdViPqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJ4pQ7AuEKJULDBCKIK/dKMBVHc9ElcADmvKhiZq/em8iau6IHeEuI6neWCwvsMARcxFE8FmK9m8VnOav4o7PtG4nKswetH+adxAoPdWRy2hnc5qV11ND4B3fpl9R/kdFEsBX0UYLMy69aab5YvkeGnoIMkCnr9PIw8kHnBBw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvM9kJJu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so48167991fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726608819; x=1727213619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qcUP6KH1bwwdVFb3AEC9DcDS+ZdFSH/BG2nk4V8dEOg=;
        b=NvM9kJJujFonh1lYKNC8H27CpjeqFDsG3Az4ITIW55Pg9oCmpKwq1qHg+WjFTuBz2b
         nu1UwPohet1WPdpPp7U2VRcICJYEgoqR/f21p5Vky2SySamjhUa24kssZHXop+IPwiBP
         EtOs7vNnIkKnkQRYArSeKrlK4P1ZEu8juUT4LcGckwB/X9vxzyKz5qMNmrgLU3uLJp28
         rjTNt+K/AYvXYKkbwUAuiOkdL0slhV2QW1Vh+NFr6JErBOto5VSbtW2uiQ8ZSorNsYHe
         zTOiZQGpV635HY0kGqLkyBw2WSj/4VnJ7BmSZzfsjeVhyjwGVmzY/Bc+8bJrMBWEDZht
         nYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608819; x=1727213619;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcUP6KH1bwwdVFb3AEC9DcDS+ZdFSH/BG2nk4V8dEOg=;
        b=RFx4ysTkuxFVycqV3uDr3eZzK+7J26ixqQdbHCad8p113/+ePN8NzYHyfSU1+etlMc
         51UKpzjnZ0HoP54kdbikjaxrw8WqrbPm+HKafhdlTtkHOnQWTRjHdFI/4MKWSBnf8ETi
         iEMj0HjTV3P2K0bZnhwsEDY+FGa+32koFVnDF0xlKseuA4DW8ehV4HwSOOkqn5WZzzbC
         ogZRw2CCQ5fXnU8J8z9RwH1z9Cdgi8vp/Uk7IEuGuZs3iCUKyApLZH7TjAZWshDH/1NF
         RdtSmhaFev6W5RpiQlemdeuGY/+QAXyBQ+8FfaLUHv0vOzSxdSfJEuK5yJ5TsuJRwnfu
         P2mw==
X-Gm-Message-State: AOJu0Yzh/iocjGaV67FSft66K57yWO5klofdfR77nBRO1wvh5wPhDtlK
	8v/jXMQf8zPu/LUVT+63fPU+495G2jul0RPhAA5uJwQZwHyadLJE
X-Google-Smtp-Source: AGHT+IHW0mx7gDrJOZ/ycoasqak0LRDhhgu/xV7YlGlx38siuVyfIK/MQ5bZj5r9EVgZY//m2m/P9A==
X-Received: by 2002:a2e:be24:0:b0:2f1:a30c:cd15 with SMTP id 38308e7fff4ca-2f791a57fa4mr77851681fa.36.1726608818059;
        Tue, 17 Sep 2024 14:33:38 -0700 (PDT)
Received: from 127.0.0.1 ([94.41.86.134])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d3012a5sm11895571fa.42.2024.09.17.14.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 14:33:37 -0700 (PDT)
Sender: <irecca.kun@gmail.com>
Message-ID: <90d5a756-e534-490b-b451-7c855183ebc3@gmail.com>
Date: Tue, 17 Sep 2024 21:33:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
To: Borislav Petkov <bp@alien8.de>, John <therealgraysky@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Unknown <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
 <20240915124944.GAZubX6LAcjQjN-yEb@fat_crate.local>
Content-Language: en-US
From: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>
In-Reply-To: <20240915124944.GAZubX6LAcjQjN-yEb@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/24 12:49, Borislav Petkov wrote:
> Patches like this one appear off and on on the mailing list and each
> time I ask what's the upside of maintaining this complexity?

Besides, there are already well-known patches exist for years. So why reinventing the wheel here?

E.g. graysky patch used by ZEN kernel:
https://github.com/zen-kernel/zen-kernel/commit/6f32b8af8ccdb56ef2856db3631eea55b79378c6
It contains way more architectures, includig ISA levels.

On 9/15/24 11:05, John wrote:
> GCC 11.1 and Clang 12.0[1] allow for the following new generic
> 64-bit levels: x86-64-v2, x86-64-v3, and x86-64-v4.  This commit
> adds them as options accessible under:
>   Processor type and features  --->
>    Processor family --->

Anyway, this whole thing is actually more complicated than simply setting '-march'.
Vector instructions are known to be problematic for the kernel, so they are disabled by KBUILD_CFLAGS.
If you want to go with higher ISA levels than the kernel expects, an additional patch like this is required:
https://github.com/zen-kernel/zen-kernel/commit/addc601c58e035e28153deeb6d441b91f1a50247


