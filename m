Return-Path: <linux-kernel+bounces-222005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B13D90FB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65375B227F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9CE1D556;
	Thu, 20 Jun 2024 03:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnXlEZsf"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3B2139C7;
	Thu, 20 Jun 2024 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853531; cv=none; b=X5381CTE/BeUio0D0OPiTK+QtGOTviXnsBgsQWVveeBqhyYFdt9mrTmzKcQhbBLDYdkOz3ODZNqFzOsyAAbAsrCEnLzKuJfRhHQCM0gdu6LHA40BeOxl9MuKP+IJ43N2rP3qsAtqetpHDimIyu4tTmQZqjgw3QOUvfnIwlCEH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853531; c=relaxed/simple;
	bh=Ku4WBWGLxv96+zeTa8DS1MjRgA6aKIiac+KSQePtfA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjcgYrRRq3kmEVAUulmBptMloGkyOBJ3oBAV+QFSzkoCl7ybs3HIrFBnm7Qv5x67+mFnwlicvIUM9K3Yv0HHGd/O1hJPr6BpoQB6QKbXrrwOu5481MEBq/NLzlsmNIvKhO/gF2uKdDKnS4iMJbiSkgUTduLfVJwL2EpvbAPEZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnXlEZsf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c72becd4fdso417248a91.0;
        Wed, 19 Jun 2024 20:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718853530; x=1719458330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxzWE9lbTzRfMB3sOdCyzovZxPNcU5DkIKhPdXbvn8I=;
        b=HnXlEZsfZN+Za1OuPMF1I9L6cEHgCX1a6hKgeT/KbP2V79qjFgEOs+6pVrV6Qv5Wjo
         5NJXrCumleGnDWkba0sI7YuycOEsMiynNylMi7MUvWg8qIOu6HwK9Wcz2Kpc+L6yEIK4
         VVUZF/T1ilFoyAKc60CGuqug3tbWtfqGEXUAralefg3C2akamu49En3174a6jMI0Iiu/
         yzoYR5oGhEPuN2Xn5BmvG6TLFvV6x8Y8UBMbv8W1Vtr6On6LOL4MdM2ib5ReYrWYlKu3
         SWj7vGjblrFOIYhRuA1Xc17fFl1QkCwnuK8NOOkPGwIpLpuJ2u0tDSR1UnhmaJkNJ3JA
         96lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718853530; x=1719458330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxzWE9lbTzRfMB3sOdCyzovZxPNcU5DkIKhPdXbvn8I=;
        b=vLIQ/vHPYMgtWTJKzytk8F9Xs5jbBe3vOYnSWEnrcF9+bvz5S0zkfUOhP/7yk1It2C
         TNIR/J/63UVr2g2p9FLXN1N9RcEyekmVroXGZcZPPlOuvAMDm+cOUt8Fxjx5wuLNfzg3
         BtJAZazxmCLkANFx5VAwgidNkU/ilblA+Gktptt3YpMm1LUqJLashrSMjciR9QE0Rlh2
         irEE8Y8NU5UBWJE+Rq1+oL8KulnvR+BJW4+Kwaz/96QF0JekNGMbHJs3BtwZG1NYcpJ2
         sludBSUkrk5U9YAO7E0C+SNENWmyRaezHhuNiWY2wKy85xp+3cbNOQwj+Ewz+1v1ACNE
         T9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUwcozNQR6DxRNuPB5wbnADZv/BqCkFMXPgU5PmKmtCeU+4Pknq+9irkzCGcJPqAlDR60kfITMsHgqRyUYEM4rGIOiDgPIi7b/NN6FpoAYGWQwH+sQ+FkY83EJlc7q+aO3ocSqFEZDu
X-Gm-Message-State: AOJu0YzRsjfn8wdshBltDXcNAfDMfzfkFK4r1KduVERIK9i9keXBbSpd
	ROBNjlsUwC5kcs+lo4dmBIkdWYDyLWT+5sF571KmKFClkiTMfUr0NzZf4Q==
X-Google-Smtp-Source: AGHT+IEVUyMtZdJrpNx5r5URae5gSqGLqjWpA5GtSjKjJmfpbYmeA8V/5FvfMfs6pMkWBsE5u5GzWw==
X-Received: by 2002:a17:90a:2f43:b0:2c7:bade:25be with SMTP id 98e67ed59e1d1-2c7bade2676mr3614370a91.14.1718853529711;
        Wed, 19 Jun 2024 20:18:49 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c738c1d57asm3232673a91.1.2024.06.19.20.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 20:18:49 -0700 (PDT)
Message-ID: <5f6bd005-81b4-4e26-ae43-803448a0dbbf@gmail.com>
Date: Thu, 20 Jun 2024 11:18:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst
 translation document
To: Tao Zou <wodemia@foxmail.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>
Cc: Tao Zou <wodemia@linux.alibaba.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_6C54200469B1518482F88605A0980FBFD20A@qq.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <tencent_6C54200469B1518482F88605A0980FBFD20A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/20/24 11:14 AM, Tao Zou wrote:
> From: Tao Zou <wodemia@linux.alibaba.com>
> 
> Add translation zh_CN/admin-guide/numastat.rst and link it to
> zh_CN/admin-guide/index.rst while clean its todo entry.
> 
> commit 77691ee92d4a ("Documentation: update numastat explanation")
> 
> Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  .../translations/zh_CN/admin-guide/index.rst  |  2 +-
>  .../zh_CN/admin-guide/numastat.rst            | 48 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst
> 
> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
> index ac2960da33e6..0db80ab830a0 100644
> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
> @@ -68,6 +68,7 @@ Todolist:
>     cpu-load
>     cputopology
>     lockup-watchdogs
> +   numastat
>     unicode
>     sysrq
>     mm/index
> @@ -109,7 +110,6 @@ Todolist:
>  *   module-signing
>  *   mono
>  *   namespaces/index
> -*   numastat
>  *   parport
>  *   perf-security
>  *   pm/index
> diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rst b/Documentation/translations/zh_CN/admin-guide/numastat.rst
> new file mode 100644
> index 000000000000..817043676c90
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
> @@ -0,0 +1,48 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/admin-guide/numastat.rst
> +:Translator: Tao Zou <wodemia@linux.alibaba.com>
> +
> +
> +=======================
> +Numa策略命中/未命中统计
> +=======================
> +
> +/sys/devices/system/node/node*/numastat
> +
> +所有数据的单位都是页面。巨页有独立的计数器。
> +
> +numa_hit、numa_miss和numa_foreign计数器反应了进程是否能够在他们偏好的节点上分配内存。
> +如果进程成功在偏好的节点上分配内存则在偏好的节点上增加numa_hit计数，否则在偏好的节点上增
> +加numa_foreign计数同时在实际内存分配的节点上增加numa_miss计数。
> +
> +通常，偏好的节点是进程运行所在的CPU的本地节点，但是一些限制可以改变这一行为，比如内存策略，
> +因此同样有两个基于CPU本地节点的计数器。local_node和numa_hit类似，当在CPU所在的节点上分
> +配内存时增加local_node计数，other_node和numa_miss类似，当在CPU所在节点之外的其他节点
> +上成功分配内存时增加other_node计数。需要注意，没有和numa_foreign对应的计数器。
> +
> +更多细节内容:
> +
> +=============== ============================================================
> +numa_hit        一个进程想要从本节点分配内存并且成功。
> +
> +numa_miss       一个进程想要从其他节点分配内存但是最终在本节点完成内存分配。
> +
> +numa_foreign    一个进程想要在本节点分配内存但是最终在其他节点完成内存分配。
> +
> +local_node      一个进程运行在本节点的CPU上并且从本节点上获得了内存。
> +
> +other_node      一个进程运行在其他节点的CPU上但是在本节点上获得了内存。
> +
> +interleave_hit  内存交叉分配策略下想要从本节点分配内存并且成功。
> +=============== ============================================================
> +
> +你可以使用numactl软件包（http://oss.sgi.com/projects/libnuma/）中的numastat工具
> +来辅助阅读。需要注意，numastat工具目前只在有少量CPU的机器上运行良好。
> +
> +需要注意，在有无内存节点（一个节点有CPUs但是没有内存）的系统中numa_hit，numa_miss和

s/在有无内存节点/存在无内存节点/ ？

Thanks
Alex
> +numa_foreign统计数据会被严重曲解。在当前的内核实现中，如果一个进程偏好一个无内存节点（即
> +进程正在该节点的一个本地CPU上运行），实际上会从距离最近的有内存节点中挑选一个作为偏好节点。
> +结果会导致相应的内存分配不会增加无内存节点上的numa_foreign计数器，并且会扭曲最近节点上的
> +numa_hit、numa_miss和numa_foreign统计数据。

