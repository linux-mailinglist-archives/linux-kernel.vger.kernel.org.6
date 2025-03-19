Return-Path: <linux-kernel+bounces-567180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E13A682F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2DE3B762D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDFE24E005;
	Wed, 19 Mar 2025 01:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="CeXeUrmi"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFCE21CC52
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349379; cv=none; b=WfogdhnUFwEblS2eWKJAqdTeGhhiCotE9QdH4OITQfZpEgj4AiSpoUyuSUF6BrziTYJCQKgplhPulPETcc+Jgtx8B0EfTrZ5+Al0pC33rRWMC6efbtxYYeD4pHPJyWucSX/HFrqqaHWK4uPonST07oyGOnKuW11XDN9UdZAiEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349379; c=relaxed/simple;
	bh=lR0MwRszE0kn7WUhEx4A82qGmqAX/TqjCnHTJJqa4vo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qwPdVKObsfvzO1TWUHDWaEgSNMlXwNi9DNPnJFS4owfbuGjflkaOOEcrn4L5xjzRBz7daCcJmbU6G8Cbrws/t15G9WeLwHF67SPa6YMZXGNiMSN4JlYg9lPCWP1hCibQKk7v6294k1tkG0Si9NP6QdKFAFXYoxbQFKP2e/qYD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=CeXeUrmi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2254e0b4b79so20485825ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1742349376; x=1742954176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kfSYL161gfIZziJoaNEPd49jdNT8x0tZy2mZDGsqfFQ=;
        b=CeXeUrmi4SeUSt9Np4LztkqGdIedkthR9jUghJmUlLLpmg1gjJCSIeheEOOjz/dQZy
         siag5MaLB2Twv7BxekGBOI/z+sbK1ZfqNnwHBxKd/tSKSghxqgaDU4TeZjlhIRrLn/yo
         BnskbCj6tknI8vKxaXxSlu4z0CT5BmcXG0b0Hzw0v6jxP4vnQbb4jvUbKudNwXlnAVLu
         R0JYM7c/G9Uh4EEZR3oXGWPgDA9Z05zgDsrlkAMK8UIbeSHIUS7Di5HhSjiTJQfplwpa
         8uF8j75ANzk1CNbHonTsAvUoIjfVqfGFNDzkehPOADRbDfIFghvC+TIwcwrbx70NRERJ
         bPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742349376; x=1742954176;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfSYL161gfIZziJoaNEPd49jdNT8x0tZy2mZDGsqfFQ=;
        b=Q7lXaaXWjrKFRG1ag7HR/V0KmyLu0AMxQBfkquaDLg4XiVGhLOXbDK6mv6VeAotUFJ
         0aSJ+d/ya+58Yr+aWjuSg1elLhKdWq7OyIU4+wGpR9vDWQ72w6iOKoCKcggNdpOYKgpN
         7AhfWw6Eg+Z6AT+hcPUl0nEbMzOOR3n8dErg03jYKqFCrYNLMCpctvd9SssOhkJ/4+Vw
         eNOKsU3rF3CEMxeaKYxrEQYLFYVpJjMhyFAKsfFh74aD/5llFLmo254od0+eIJ/Zl4/y
         REkuXsnLVr2RxQkjaaZnfp17E2/U7uGqOpdsHcKChiPzpLfgyt6d0MFPykJ4I9Fn8sOx
         uh5g==
X-Forwarded-Encrypted: i=1; AJvYcCUCqNphHpDT/HEhS2DPm5bQwiBoy+xT+cL7uoCyPlufkF6ewwFfDF1U8/3BD9tD3AM5W0BI+2qZkBzphPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LXpNWpzyCGFTPHUo6a10BRMji8bm1lWAHWyF2DiHdZD85ek9
	2/vQzGEl2Jp8WWVOqgRGgeqZb/rjgkDvWE7fCjZw81VoPD9vn4nLEvSSYm/d9A==
X-Gm-Gg: ASbGncubvHrza23sCQn6IKzlHY0n545eoNfm1/s7mgvHgaC59NLFFa858duQBo85YVA
	LhzZsMfjLim8pTALIbOy3+iI4FQrFQ2Jq3hDB/Bbvsw3GADirIJ9IO2LFWYx+smH0UeLyYTHwTY
	qp7vSH+OX9fF57BskajAcDhzO8UAjR6aweMlfeN8BnbPSEYbIxh2xlMRWGVjfc9V2TbQjKCg1ZV
	1+oqnKlgNip08MPpON4HHqdurWJEtRDl+1CSQEnClnvxO1b5NYBeI1hBsHnxy/nFy3xdJPCvVB5
	UM9U4UAN1/EFpnVpm3Vyzr8HvAGrzyqon5b8tQrzl3YgvB7rlkAbU4hPCAylCHkjqQ==
X-Google-Smtp-Source: AGHT+IG4aYGLWzhUSXqPklhX63oL6b0Chh4MUxqPBtMaZK5s4ebrHNR820gE0xM/ygYk34MdDhDAdA==
X-Received: by 2002:a17:902:d4d0:b0:215:6e01:ad07 with SMTP id d9443c01a7336-2264982aa1cmr10975815ad.6.1742349375959;
        Tue, 18 Mar 2025 18:56:15 -0700 (PDT)
Received: from [192.168.50.200] ([202.172.96.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a40a7sm102324425ad.59.2025.03.18.18.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 18:56:15 -0700 (PDT)
Message-ID: <81544837-6e2b-4a75-a6d9-595128519447@tenstorrent.com>
Date: Wed, 19 Mar 2025 12:56:10 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] riscv: uaccess: optimizations
From: Cyril Bur <cyrilbur@tenstorrent.com>
To: palmer@dabbelt.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
 charlie@rivosinc.com, jrtc27@jrtc27.com, ben.dooks@codethink.co.uk,
 alex@ghiti.fr
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jszhang@kernel.org
References: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
Content-Language: en-US
In-Reply-To: <20250318061514.1223111-1-cyrilbur@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/3/2025 5:15 pm, Cyril Bur wrote:
> This series tries to optimize riscv uaccess by allowing the use of
> user_access_begin() and user_access_end() which permits grouping user accesses
> and avoiding the CSR write penalty for each access.
> 
> The error path can also be optimised using asm goto which patches 3 and 4
> achieve. This will speed up jumping to labels by avoiding the need of an
> intermediary error type variable within the uaccess macros
> 
> I did read the discussion this series generated. It isn't clear to me
> which direction to take the patches, if any.
> 
> V2:
> I've taken on this series as there isn't any response from Jisheng. No
> significant changes other than build fixes.
> - Fixes build breakage in patch 3 to do with not having used 'goto' keyword.
> - Fixes build breakage in patch 4 on 32bit not having delcared __ptr in the
>    macro.
> 
> V3:
> Significant commit message rewrites.
>   - Corrected the justification for patch 2
>   - Better explained/justified patches 3 and 4
> Minor code changes for legibility and more comments
> 
> V4:
> Fixed checkpatch errors
> Added a unsafe_copy_from_user()
> Added patch from Ben Dooks to save SR_SUM bit on switch

There is something uniquely wrong with V4 (not sure of the cause yet). I 
will send a new version.

> 
> Ben Dooks (1):
>    riscv: save the SR_SUM status over switches
> 
> Jisheng Zhang (4):
>    riscv: implement user_access_begin() and families
>    riscv: uaccess: use input constraints for ptr of __put_user()
>    riscv: uaccess: use 'asm goto' for put_user()
>    riscv: uaccess: use 'asm_goto_output' for get_user()
> 
>   arch/riscv/include/asm/processor.h |   1 +
>   arch/riscv/include/asm/uaccess.h   | 218 ++++++++++++++++++++++-------
>   arch/riscv/kernel/asm-offsets.c    |   5 +
>   arch/riscv/kernel/entry.S          |   8 ++
>   4 files changed, 179 insertions(+), 53 deletions(-)
> 


