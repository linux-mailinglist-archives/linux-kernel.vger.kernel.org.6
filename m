Return-Path: <linux-kernel+bounces-575372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F7A7011B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE957A4C60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941125A2A5;
	Tue, 25 Mar 2025 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yk21LG16"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DA259CBB
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907195; cv=none; b=jyAK70iVaroJSFi3IxhWDzwmlVTCyMaq6Y/+dWz+Hht1NsIJImyMjNvjkxDz5w0oTrTWVSthBf1p/uD+zDVEy66mqG79u/qwsvRwyG0BbCCQDOSpbPGB4P+xqrf7xy7sRwYf40OChTCVv+qS1o2sjRx3JLJd57qN0h+7iqlh93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907195; c=relaxed/simple;
	bh=yk5V0lLbSKSewN4X99NDU39q4bYUTkfI8/5DQqD0X3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFWlOrkcOnStbiEqFAv1p+Aaa/7rRv2Zw4gw7DxNBnEdTUvhqkEbnYwmsnopstfPc3I/ddalbJ8jEcGwGA9Eg9ZcceaeltjD34mcwOdaOWSs3wSv36uCXCtWTU+Kg9gtNJ+xbCTY7ubNAndgYleqkVun6NE4U+pvOUgBpKRvMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yk21LG16; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso3230930f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742907191; x=1743511991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWTGK/X4SS10wsDie07tFoBcds9fT9TR5FQTDlGWK3w=;
        b=Yk21LG16aA8bMWMANdojH/m0m9UHsNx1RLLxmgJ+e1WWIQEdoBK6b6iHrkd+SZse6M
         NVne8R8DznZID3yRLRanjY3alAp58amieixrNkgsckz+4UxM/GrydGg5PeWrTSDwoBPm
         /wqLR9ga4U0XIRaxDGP0MDrE8PTSTtbmWDzhjhpJ0dE72zrL/9hmD7JWxrQ4BGXsf72o
         CQ92pU48gP8GGq5hmn6MMni19+NoXRWKUCaWYGikyI1upLt5pSQC5wEv4RK6WLVWPEPR
         MCcXBr34sU9DavjGnFL0+t4qZcFvn44tXIDSNqfJdKHmaHGX7v4k+bzSKGHtxP3JxB/f
         MRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907191; x=1743511991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWTGK/X4SS10wsDie07tFoBcds9fT9TR5FQTDlGWK3w=;
        b=VwpPfks0dOaKYmvYZE4kKpbOdnG5mKdPkpUJ58ysYmold24D5cxvCUR16fpvQ9BdQs
         PxGAxrY+xYHJmYq+3amBUBjg0BP1tuvFWyR9Fw7M5FnI+BBPhHwneDXS5/cAowZThx81
         BGWSRsLqIeHX+1CZLoiWt1UZHVAT5PL8ASNFpSXw131tQg/Ddh5fgAymLB9XH5R9UVhy
         Dv4UJorytJg/lDr2XBywQ+FThQJnDqCQ9++X5EdcU3F8kn5yWeUwrEM049X79vuJ3ndu
         DoWfOZ3W3hSFPer+ZRz+K+ngzCZj0N8fumf/55eC6stJocBDG+q+rmOSVSfgFJ54/V90
         UFLA==
X-Forwarded-Encrypted: i=1; AJvYcCXz3DVYjiurxtO0IvUxcg1WDfjYg3NmgBqmsXHgFEBpq/Pem8p/TVNTtPyMSxSdg17bejrgv7QobV/W8t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRn/hS3gSz1bSzQePWLGb7mt+MwDiCzqg6KCAuU80Pnie7kJvA
	b0Zzc2SttaT+EtqLDVjGcNTM0mZCD6KQBaMCg6hEXsBzxCVwJiTn0WOBOQFr3t8=
X-Gm-Gg: ASbGncslPzaXWnVN9yCpJzoA2Jgw1vJvkn5t3XYJYnt46hSjbKNeFXjcs724qLJTE0j
	luMcLuyseuHIViSQA7AZV0k0LTwNt5HQqerfLhtXPl2Sx2gmF9gqDzdQcWL7Dk/WPE9Em7YUjv6
	Ryw8Csd/zJzDQwyvzQu7t+wXN3qcuI2rr77OWmU/FTcQ62j9osX8IsTxAsCciFNeG+5EaEQKHw+
	yRotLBlCAGTLOTBsIwZ+AZCy9Vema/0MoV5/1cCp269nH78T60f5oOgTtv2AIAFln90vmC6LhwV
	e2xJR8Rghro9beFY2IepHdcYJ5dmG1LrtYjOC3e3depL
X-Google-Smtp-Source: AGHT+IEE0UpwexJ3OeA2GpZXDHjojgHRAF+v+OvPsapSM0mU4OKjhQXj6Y5aUqQobFvv4w+MSqtBUA==
X-Received: by 2002:a5d:5886:0:b0:390:f460:77b0 with SMTP id ffacd0b85a97d-3997f90df2emr15215129f8f.26.1742907191489;
        Tue, 25 Mar 2025 05:53:11 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f99540bsm13579803f8f.2.2025.03.25.05.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:53:11 -0700 (PDT)
Date: Tue, 25 Mar 2025 13:53:09 +0100
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-toolchains@vger.kernel.org, live-patching@vger.kernel.org,
	indu.bhagat@oracle.com, puranjay@kernel.org, wnliu@google.com,
	irogers@google.com, joe.lawrence@redhat.com, jpoimboe@kernel.org,
	mark.rutland@arm.com, peterz@infradead.org,
	roman.gushchin@linux.dev, rostedt@goodmis.org, will@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] arm64: livepatch: Enable livepatch without sframe
Message-ID: <Z-KnNU2A_kwwYdXU@pathway.suse.cz>
References: <20250320171559.3423224-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320171559.3423224-1-song@kernel.org>

On Thu 2025-03-20 10:15:57, Song Liu wrote:
> There are recent efforts to enable livepatch for arm64, with sframe [1] or
> without sframe [2]. This set tries to enable livepatch without sframe. Some
> of the code, however, are from [1].
> 
> Although the sframe implementation is more promising in longer term, it
> suffers from the following issues:
> 
>   1. sframe is not yet supported in llvm;
>   2. There is still bug in binutil [3], so that we cannot yet use sframe
>      with gcc;
>   3. sframe unwinder hasn't been fully verified in the kernel.
> 
> On the other hand, arm64 processors have become more and more important in
> the data center world. Therefore, it is getting critical to support
> livepatching of arm64 kernels.
> 
> With recent change in arm64 unwinder [4], it is possible to reliably
> livepatch arm64 kernels without sframe. This is because we do not need
> arch_stack_walk_reliable() to get reliable stack trace in all scenarios.
> Instead, we only need arch_stack_walk_reliable() to detect when the
> stack trace is not reliable, then the livepatch logic can retry the patch
> transition at a later time.
> 
> Given the increasing need of livepatching, and relatively long time before
> sframe is fully ready (for both gcc and clang), we would like to enable
> livepatch without sframe.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/live-patching/20250127213310.2496133-1-wnliu@google.com/
> [2] https://lore.kernel.org/live-patching/20250129232936.1795412-1-song@kernel.org/
> [3] https://sourceware.org/bugzilla/show_bug.cgi?id=32589
> [4] https://lore.kernel.org/linux-arm-kernel/20241017092538.1859841-1-mark.rutland@arm.com/

Hi, I am sorry but I haven't found time to look at this in time before
the merge window. Is it acceptable to postpone this change to 6.16,
please?

Best Regards,
Petr

