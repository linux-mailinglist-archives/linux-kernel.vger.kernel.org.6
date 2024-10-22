Return-Path: <linux-kernel+bounces-375533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A54F9A971A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E2C1C21786
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB813D8B5;
	Tue, 22 Oct 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Njv7Ii"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582513A86A;
	Tue, 22 Oct 2024 03:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567745; cv=none; b=R+2eRtZnrn4lGZd6QYweHNSu2GsswGBgjlf0j30EoTUPCEZPsilbvlj66B2FtAf4by7/QwQkc2aEMQWin5JtsOwwPysDAquN44EoikIfKk20Xa/RUaEBaFt66z+w2C3lbBiD+Ojokk0dxZzuJrszeXsvBrN483y73s4k7CoYaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567745; c=relaxed/simple;
	bh=+EgaXF/VyRaCocT7c4QBaSaXuDPO+CiNlt6NTkbIoxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2Y8yn7PGthLbrcNPmbs8oxrkX95xh4cAyiXLkffJj5X+L3bbbQgSEywjdKJqjK0RJa7i6rjWLeXYJMR/d8xvLtCS5kS2kGZ4VTgTK1nyeREBwie6OLg3hRcnXk5DdYcLJ0+ilmNqsP+CR0yspLnGsW5IecjiZmNcFD04Ydup7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Njv7Ii; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so4717049276.0;
        Mon, 21 Oct 2024 20:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729567743; x=1730172543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+of3sn6my3fTdyQClh+kg+3L6lJjqrKeiMmZ8o2XgE=;
        b=l5Njv7IigfizQOTihrcWw6dI25N5frWONbUdQZJcboxN0TjqUnAG9x9ldZJWbzemoM
         zK7eQl5xmyrbK+n6750rKWfpBuwKFqG2lUDjPUBtQKjsajThZ3gNCehujusl/FIG9mLF
         DNHCmJ0066ejQyHdL/5nbEo4d8CxK1s8nC4vNAFhryfMcyuDnmy0oU63+2mK8fNvD9o4
         U8NnpbLjQmhZEp3FgQ3wDDp5GhFF7XtzzTLr2bxysqFSiXPkoq2qVDF/QobuCKVDIutH
         qQCn73sBZQPbCMrZj5U4Y+0Qfk4p3UX6Fcw+w05caso91/d8tb2Bz7MY7GFdDSO9M056
         4XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567743; x=1730172543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+of3sn6my3fTdyQClh+kg+3L6lJjqrKeiMmZ8o2XgE=;
        b=TRzcQugTVeKuxknTqzLiF6Cjm1DTQVhEkix/Xv00ds1RuRLp9LpSRB9okInvHpLdRC
         dC9J/IW8HY/R/SALbUR7IxQleMTaKDHI74p8QS2hWRhTzzpkC8JojpA1iOc+kfvuDtz0
         UniSgVHmLo2k6Ladnm9AWOWFrYukE7N/VUBx9Ogcj5cNT3Jv5uymUfb3yg7TQvkmHFMH
         KEIMdb6TauuyYf6T019pgS7DOgebLWT2bg1f6XCJqNjJOw+XtgGJaxpEouFMb0wYXLTd
         Z3hWU5ffjGloe0gX/12Ebi1L2S3NuYg9aSDzfoS7MrkYlQoxMGLCy3iiRvrNoIQGGB3f
         YAag==
X-Forwarded-Encrypted: i=1; AJvYcCVqZv7A0i41mTxoLGMdGx1hk2m+li0Wo8C6SJUJ3J7sB/n+a8wkMNAyO42oR4NW2xHxClA9T6RNhqU=@vger.kernel.org, AJvYcCXQtXyEg12i5o4G8UfvxC4qHHLZy/VBWQA5Kh4EXnLd6/TAR1ellnScvdUkBm2J+VDDiEuFUq3rsTAKGefP@vger.kernel.org
X-Gm-Message-State: AOJu0YwEHeEgwPHgKmvS95wbLU1Y5ANBidlpdeF3A/MQ5nuuiIELXFEY
	10NNMvc6MwpPueISqxfPpcRF6UhTYdcbCYpugraXS1vkfJDrZSun
X-Google-Smtp-Source: AGHT+IEkFnW0xFEimjKvu3s+rbX3lF8V3Fc79mdDgyh2EDBVu5WJhRepTDGzvIugNEFmOl+gxhtBBw==
X-Received: by 2002:a05:690c:a:b0:6e2:313a:a01e with SMTP id 00721157ae682-6e5bfc3f30dmr126243927b3.32.1729567742959;
        Mon, 21 Oct 2024 20:29:02 -0700 (PDT)
Received: from [192.168.2.226] ([107.175.133.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d6f904sm9372707b3.135.2024.10.21.20.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 20:29:01 -0700 (PDT)
Message-ID: <4cf5f422-d287-4f53-9af2-82bd7fe3b264@gmail.com>
Date: Tue, 22 Oct 2024 11:28:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] docs/zh_CN: update the translation of mm/hmm.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, alexs@kernel.org,
 corbet@lwn.net, Yanteng Si <siyanteng@loongson.cn>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1729327831.git.dzm91@hust.edu.cn>
 <82259a2656549c90591dc3873f3d2e8a4fb41233.1729327831.git.dzm91@hust.edu.cn>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <82259a2656549c90591dc3873f3d2e8a4fb41233.1729327831.git.dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Shi <alexs@kernel.org>

On 10/19/24 16:54, Dongliang Mu wrote:
> Update to commit 406c4c5ee4ea ("docs:mm: fix spelling mistakes in
> heterogeneous memory management page")
> 
> scripts/checktransupdate.py reports:
> 
> Documentation/translations/zh_CN/mm/hmm.rst
> commit 406c4c5ee4ea ("docs:mm: fix spelling mistakes in heterogeneous
> memory management page")
> commit 090a7f1009b8 ("docs/mm: remove references to hmm_mirror ops and
> clean typos")
> commit d56b699d76d1 ("Documentation: Fix typos")
> 3 commits needs resolving in total
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/translations/zh_CN/mm/hmm.rst | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/mm/hmm.rst b/Documentation/translations/zh_CN/mm/hmm.rst
> index babbbe756c0f..0669f947d0bc 100644
> --- a/Documentation/translations/zh_CN/mm/hmm.rst
> +++ b/Documentation/translations/zh_CN/mm/hmm.rst
> @@ -129,13 +129,7 @@ struct page可以与现有的 mm 机制进行最简单、最干净的集成。
>    int hmm_range_fault(struct hmm_range *range);
>  
>  如果请求写访问，它将在丢失或只读条目上触发缺页异常（见下文）。缺页异常使用通用的 mm 缺
> -页异常代码路径，就像 CPU 缺页异常一样。
> -
> -这两个函数都将 CPU 页表条目复制到它们的 pfns 数组参数中。该数组中的每个条目对应于虚拟
> -范围中的一个地址。HMM 提供了一组标志来帮助驱动程序识别特殊的 CPU 页表项。
> -
> -在 sync_cpu_device_pagetables() 回调中锁定是驱动程序必须尊重的最重要的方面，以保
> -持事物正确同步。使用模式是::
> +页异常代码路径，就像 CPU 缺页异常一样。使用模式是::
>  
>   int driver_populate_range(...)
>   {

