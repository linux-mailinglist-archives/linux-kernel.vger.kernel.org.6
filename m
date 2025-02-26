Return-Path: <linux-kernel+bounces-532868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4287A45331
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE733AB79B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0D21CA0B;
	Wed, 26 Feb 2025 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GS/Ckw96"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E904F21C9ED
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740537656; cv=none; b=Xi/b+YK2VQ9O9Y//DG1eB6pKdTM3kgm9+tCT4rgBvaJbBIkq0w6Ugl2ZCIvECssj698dlCZz7A2sUa7L4a+k17zxZEM/U/9YtMx4LBzkjHupTea2vCNZ1I4tnwVlNWq/JHLgOutJzuBlx6swkr+vrTFDeNs45Ou76krwatXuqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740537656; c=relaxed/simple;
	bh=wjq1hhNmQD/Y69/cVuHxDfp8iNsL790jhspOLVSqRqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C25lopUSgqYTRXlJgsozVvBOOcLsTdXOypb6UygnKTCeUjSdtRL+45AD2mMaOul03RtcxD1OYWhuYLkRu2qcT57XrIqDEzxs+Pl31Sga1XqhOm8P/kasvA1YKjQ9myxmKonJpJkT41YfniiqVmKXZnVdnYkUTlLOGQ5RwmkzNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GS/Ckw96; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso12443042a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740537654; x=1741142454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faw8k4TIY5A7eHVQZOGgzqUSa20esi5XC3jgrNGM418=;
        b=GS/Ckw967HgEBztwhEXtWyn70THH/82RU5C07OL+zjPuB1o1Jv6xlSab1Ifir0ySI7
         cL5y5aHYUTXGjIJG/uoPD8+e+FoBNATvn/b7FEXGf+5qZwa4gNPm0OYJgCeB0mU0d4zZ
         KD4Uj+Qqp4Y+/6DXM+89Yi69FY4OgAztNGASRC3TWKzLTTAmhpYRPo0AoJUWs99X/hZ0
         uOBDn9dxLPBSSwBQT2iBj5l5tFijagzV5pTSPoTfO8Hq9CNNPdc5VNomMbSKsdtWUiTd
         0sdZIJXxiFqZSo3/wnZ5sc6jtX6iDba7Si66mju+5Rs2hqbxDcVsBLQy75GMk9DDElJM
         6YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740537654; x=1741142454;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faw8k4TIY5A7eHVQZOGgzqUSa20esi5XC3jgrNGM418=;
        b=hyJI0diGAXF1xBKCjSnrqBzhrLqFV/Bye3PLQLGu8m+1Bl0p2Bnvzzrf+rQjKK0qkl
         2UWbpfElCZQcsKfFLhpN/8SvNS0Dw5n+O+U0si0E7U5lzP1R1b+sj89MIALr8QxtF1+X
         Sj+7R1TcF3rWsHeJPpHFTnrEfeDprRg6CBfnbsVgct2Vtus5hrpacuqyTPVYgYh7SoC8
         WJ3YMCJ2uTfhvCGnA1cR35mm2aSjpIgte0DGhHYDOpRD5vCeLOIcO6E5WglPB3o2Ipco
         KRzcQW8JLMK2VB+kxSsv4Ys1ZF72C8XUBQaBpnt8R3ZTfSxdF/qfVrYaENMLAMv2VTHm
         +pkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoaw7TVJ4pmyx7CTZhF8kkHOlO9CSRgb7tBtgTPaRlF7jmWkap0PBcdXQ62DWcIigpjsG+1EOgwyU6i4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0WOErZPCO8c1YymswiCv5q/5HBQ65jr6DGH0G6hmVXoB8qPN
	uFIt71urlAAX+jkI9i/kvBPBecNFCIRTt58345eFyjnlOsgw7AFgGbyubgYObXc=
X-Gm-Gg: ASbGnctoD8/q5Y84VOcByE+raPLy77AH1G6hIHdN1JOrXbeuK5WqbTY6cUXWudNmCEo
	EoANcYu38i9dljC/xeQVV/B/gyzZRpDx+rLZu2fqqkOGshnwZinu4Zo8oI+/891GR9dgmJKYaDm
	cIKq+hpoklyfBnZKHOpxI+ZiI0I+qBsWsa2lM9pqFEp0Mvs2qKg9nudlJjKaDDoJnCoYOKRm0xj
	cEkUDJrHCCgH5U8+jLHBB/CoBeg+3VLI9AiKPMfLli3AHOw/fx9ZiF40QX5PGGVTXNqg3t4/Liy
	17tWyEKUA7b1O5K6+2/n36kVJUWhbwXXtIfj1QCcFi5vOKkO5g==
X-Google-Smtp-Source: AGHT+IGBavOro6p44pm0knw7epDm1Ms4/cRCm5nI7A9v1bvB0aFlwIUaa3TK9A89BXdQQHklrRCMwg==
X-Received: by 2002:a17:90b:2242:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-2fce868c4f9mr34212880a91.7.1740537654049;
        Tue, 25 Feb 2025 18:40:54 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000a01sm21742845ad.40.2025.02.25.18.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 18:40:53 -0800 (PST)
Message-ID: <3e3ab5b0-4669-4d7a-a7bd-6f5963662757@bytedance.com>
Date: Wed, 26 Feb 2025 10:40:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] x86: pgtable: convert to use tlb_remove_ptdesc()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, x86@kernel.org, linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <36ad56b7e06fa4b17fb23c4fc650e8e0d72bb3cd.1740454179.git.zhengqi.arch@bytedance.com>
 <20250225183519.91a5b75b13c0df6954c68576@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250225183519.91a5b75b13c0df6954c68576@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/26/25 上午10:35, Andrew Morton wrote:
> On Tue, 25 Feb 2025 11:45:55 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> The x86 has already been converted to use struct ptdesc, so convert it to
>> use tlb_remove_ptdesc() instead of tlb_remove_table().
>>
> 
> This is dependent upon Rik's a37259732a7dc ("x86/mm: Make
> MMU_GATHER_RCU_TABLE_FREE unconditional") from the x86 tree.  I'll add

Yes.

> Rik's patch to mm-unstable also and shall figure it out during the
> merge window.

Thanks!



