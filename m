Return-Path: <linux-kernel+bounces-397551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D79BDD54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D654E1F234E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBF18FDC9;
	Wed,  6 Nov 2024 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cDQKclOx"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2618E368
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861801; cv=none; b=eMHHe2UDe3ZQzp4Tnweg2KmiSDk1N47jm2m50D840CqT4YFvOQFoVT/izYGJs16pW3wswKWUFCunt7b1FEV0Se83WSrwyWqIOgRt1rwFEjYP4X+Ig10v5ts5IVGdVL3n72AxERd/VC0iG513qr5fGlcY0yb9kfBFPP3sVuV9kLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861801; c=relaxed/simple;
	bh=v7EMBM5wtdNiLlk/MSFZIFIKgzmDktDMJeqDXyO8rfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwoEKRKOJCfCDDfCqyLtGMDSMyHSdDTXFA1dLsgpDcibx15h1VowqZGzmQgVb1u/NV/Hm6ppbDWyae6XMZpqfqlpYrZbN+jVnudPhcxVJ7vhjUAcSQAmZlvNA5EKeQlJEyexZshK9ZZDVPdNGH6zJsNCU1SsHFPyTUD6cTH1Cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cDQKclOx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e91403950dso4506232a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730861798; x=1731466598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6v8RHSDXZgHsuLc1Cv4dDOGwWTdVAAFVIsGb+m4CYc=;
        b=cDQKclOxwfg/v3zFze9wv1ocPK2gpkac00AEaJ6LIf9pJ8xlDFQ50OELzHaM+5LGwd
         g27ZGzIGQgEihpCJtoaiVSez0YDlyTTyQPI73pNouUPHa5XjS1ut9BpA16uFveS3oRLR
         1XwAtobZ+k5P1DBuJcz59MEcdCzRuWKPNvdFsRrd8oDD6d9VPs3dfIk7OXMwpKWCW4Lq
         FtAaHbzo4TUU1Kuamga+Ba1ad5Yfh25rl24UJlLBypwkm/RDseBqdbpaxWlnib5biqm0
         Jps8YyvZF24BuZksuNt+uwMeE6ogeFXXYG/sLfnp6T0ES3D14hEq3AXgEena3hb6bbxE
         XghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861798; x=1731466598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6v8RHSDXZgHsuLc1Cv4dDOGwWTdVAAFVIsGb+m4CYc=;
        b=lzzA3snxRGGXbRE23jn85dWByYryIeDRcnKwJiHItlwHq9ZbQ41TA5nlc+CpyUiE65
         KeGCUmNpxw+71nlB06UzZqFKzN6FjDZTQ2vbgaztmOrglSi2guS3qwsAYeL1bUJqgu38
         maZHy9G8MvGln7FcVlTE2D9esVa7DYtOyXYXAfZkttPj272JaD1ryJI1HEuvjK97LS0p
         0Y+1k+VkHw729tAdUhQfXDaDzR+QwvHsjxECp3gaSzCosZFxl/SJ0Ta9+1XeJd+5tu+c
         yfaeemYOkasGmmrldysA0DN5xMWDSfYCd6c3D82G2PGLNQEl8wlz10xdP7zkw5H9DZBD
         5T4A==
X-Forwarded-Encrypted: i=1; AJvYcCWd8j/gfkFHzpsu/vWcmBwnEQYTuuaJFbGAQCPSQahwGkVBgp1fCj6otOT8j8/0ISecpiokitSVlU/mvC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7x8jnvYc62z07ZDZRi3CnTsqNmWKGrdfMR9QNHkwdQMoNUzAP
	cvigsjBCR2fyqdZPvr2aAD6lxs7rRm5dKAukRXmcrWsPYOzNG2dke5MDlxxHZJ8=
X-Google-Smtp-Source: AGHT+IHIE44rAIMR6CmM88Kutnzf0JaYRrQsw3mD4TNQQAzGQub8JUfRY9RzhGAHTVMgGodOek2h5Q==
X-Received: by 2002:a17:90a:2ca7:b0:2e2:c15f:1ffd with SMTP id 98e67ed59e1d1-2e8f1071bdbmr39545597a91.14.1730861797615;
        Tue, 05 Nov 2024 18:56:37 -0800 (PST)
Received: from [10.84.149.95] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a541e16sm302276a91.21.2024.11.05.18.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 18:56:37 -0800 (PST)
Message-ID: <5969f498-a515-4394-a2b6-5d3abe2872aa@bytedance.com>
Date: Wed, 6 Nov 2024 10:56:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
 Boqun Feng <boqun.feng@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <CAG48ez0qsAM-dkOUDetmNBSK4typ5t_FvMvtGiB7wQsP-G1jVg@mail.gmail.com>
 <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2bf6329e-eb3b-4c5e-bd3a-b519eefffd63@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/5 00:42, Lorenzo Stoakes wrote:
> On Sat, Nov 02, 2024 at 02:45:35AM +0100, Jann Horn wrote:
>> On Fri, Nov 1, 2024 at 7:50 PM Lorenzo Stoakes

[...]

>>> +
>>> +Page table locks
>>> +----------------

Many thanks to Lorenzo for documenting page table locks! This is really
needed. And at a glance, I agree with Jann's additions.

>>
>> (except last-level page tables: khugepaged already deletes those for
>> file mappings without using the mmap lock at all in
>> retract_page_tables(), and there is a pending series that will do the
>> same with page tables in other VMAs too, see
>> <https://lore.kernel.org/all/cover.1729157502.git.zhengqi.arch@bytedance.com/>)

Thanks to Jann for mentioning this series, I just updated it to v2
recently:

https://lore.kernel.org/lkml/cover.1730360798.git.zhengqi.arch@bytedance.com/

> 
> Ugh wut OK haha. Will look into this.

Thanks!


