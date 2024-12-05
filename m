Return-Path: <linux-kernel+bounces-433526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0339E598D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBD416272D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C7621A453;
	Thu,  5 Dec 2024 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RE6haTGh"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8880B1B0F22
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411788; cv=none; b=O9DzvOYFZ9DAoD5RD5pejWWa5BBOSL7fA4b9IU98pF07FF+p/EkhbzT7RxyGifj6lbrM8qlEfT64oGUOB/8bx5cMbed5+m7dOwjKRBuS3zF8QENV+wDHAQpVDk4DKcjPbeaoGFO5RK62o+nYHrarIJj3ctFdSCFyUpMt5JPE5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411788; c=relaxed/simple;
	bh=iM77qGeIh8E11wSG/JuOvn32bq1eD8WN4o1Kl4395UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7uCCutjctJXJ3/9XFg3K2ysq1XL7fqycU9b3+vGTISMYVm1A5Qxd2Yw2GOIMuxw4SUmWDwwaPRiq+qvqv+vm8je4Vb3fh+tOrMF8adRBzv+PlQ4KSKOnbEsYrDh4R8v0p0bxkT4gu3QMx0vWHYrUIlb4HWgfxMD1P8KHGvgYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RE6haTGh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a45f05feso11860235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733411784; x=1734016584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NNGzfvQhuEu1gaOMEO/yBEPHJg32agZ5235X4zgBXpI=;
        b=RE6haTGhV3liX7qr+Q2NMrC2oFdxqq9RKmqpf2zZh0pPGIzqXzmJy8g9WD4zw3DQ1z
         6E7t2pA1ZvUaVnZZ89wXDo1y1VK+Ad8lSA/WFi/7HtapicB+I05jxZOOg4z1aaYZhetu
         xsjMdy9x7TbgXd4L1JFh8Sr5JYOoRQC0wj4tUfcs5LncisLZumh9VrdvlgNsrUAfVYDD
         jY9UIIQkyomwR0i4ORe1C1Bgp3ilrITy2iXa++uxipk9U5sb0IgdINPs+mVm9XWkPxFY
         TK7zBeFrUZ/5u85HAf+F2sr8VqEMe8ao2VNc83OK4Qzp+Rohvesodde8sL6u0WxOACHU
         pezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411784; x=1734016584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNGzfvQhuEu1gaOMEO/yBEPHJg32agZ5235X4zgBXpI=;
        b=EvkTKrBXYT1es0XC0faI/Y3t7STHuWrOt0vL0yfwNegGYuLf6YrEnjixLrPN18mzjz
         pcBWjdy0miAcryvZrWqSScDIiTbQRu20z7c/vhILgRRFUD5M/VMypa6FgWvb4+E9VWL/
         Yxeob4rbX+Xs0364DlIJrITk6muWIpI6oBD51xmjfnjBAKOS8XMoC+vyNfCb2ziXVrpR
         ROqIchZLl63zJhEvZFcP/oymwl+8Ipbt9dyvmssSXGdFxCW2u+2uYR4zsmDEnSpNXI5X
         ZjjzDOB8E5K+4NYxBMTglYyALXsGt0uQpLcl8JGvNHEOrL6fD4NRxSzY8iCeokSBdU4O
         X7sg==
X-Gm-Message-State: AOJu0Yy9gNda3JrHzeBmBrQQy+spgctqD7W1f2Eq61X2GhT4voXvxH1n
	Bdf8ZGpbmEXwP+XAYdWJ6IMIrDha0Ii4aa3+4TO2VfeCbsjE+feoFuvjBWzxheU=
X-Gm-Gg: ASbGncv3N3Bo+YkpjhqgqFedr71rAYuFJHDrRaDDZcVe92RIOaAGRzLLv3S58n7AGti
	omHXPXsSd+pCxKt7UybCet3AfbLm6Rn6bMEXzaVrIDt6L5tSjZm2kvlS3VyjGhBQOC/aj3f+98C
	QTgzXSqEQXwLtJrJwBDRyp6rQpy2eEi34gdPrHG5nwGBCaM4i7ZbRrzQ79RlH5vbaYwx/B6U+B6
	e+Cj7mF5QuVHH5LtBlxsn1rUEieTzHFkIq6R7IqycdQsqhI1WCbZLE=
X-Google-Smtp-Source: AGHT+IFSHLZmIu9wSayLDq7ycBQ+roAuUKEE2td9KEmSdlWo6X+wsBQeahWHpQwNkTLYxu/aVfztNQ==
X-Received: by 2002:a05:600c:1989:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-434d09b2a75mr103448145e9.6.1733411783803;
        Thu, 05 Dec 2024 07:16:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59d651sm2179270f8f.44.2024.12.05.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:16:23 -0800 (PST)
Date: Thu, 5 Dec 2024 18:16:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	David Laight <David.Laight@aculab.com>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	netfilter-devel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Johannes Berg <johannes.berg@intel.com>, toke@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>, kernel@jfarr.cc, kees@kernel.org
Subject: Re: arm64: include/linux/compiler_types.h:542:38: error: call to
 '__compiletime_assert_1050' declared with attribute error: clamp() low limit
 min greater than high limit max_avail
Message-ID: <8dde5a62-4ce6-4954-86c9-54d961aed6df@stanley.mountain>
References: <CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9MRLfAbM3f6ke0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9MRLfAbM3f6ke0g@mail.gmail.com>

Add David to the CC list.

regards,
dan carpenter

On Thu, Dec 05, 2024 at 08:15:13PM +0530, Naresh Kamboju wrote:
> The arm64 build started failing from Linux next-20241203 tag with gcc-8
> due to following build warnings / errors.
> 
> First seen on Linux next-20241203 tag
> GOOD: Linux next-20241128 tag
> BAD: Linux next-20241203 tag and next-20241205 tag
> 
> * arm64, build
>   - gcc-8-defconfig
>   - gcc-8-defconfig-40bc7ee5
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ===========
> net/netfilter/ipvs/ip_vs_conn.c: In function 'ip_vs_conn_init':
> include/linux/compiler_types.h:542:38: error: call to
> '__compiletime_assert_1050' declared with attribute error: clamp() low
> limit min greater than high limit max_avail
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^
> include/linux/compiler_types.h:523:4: note: in definition of macro
> '__compiletime_assert'
>     prefix ## suffix();    \
>     ^~~~~~
> include/linux/compiler_types.h:542:2: note: in expansion of macro
> '_compiletime_assert'
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>   ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro
> 'compiletime_assert'
>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>                                      ^~~~~~~~~~~~~~~~~~
> include/linux/minmax.h:188:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>   BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
>   ^~~~~~~~~~~~~~~~
> include/linux/minmax.h:195:2: note: in expansion of macro '__clamp_once'
>   __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_),
> __UNIQUE_ID(h_))
>   ^~~~~~~~~~~~
> include/linux/minmax.h:206:28: note: in expansion of macro '__careful_clamp'
>  #define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
>                             ^~~~~~~~~~~~~~~
> net/netfilter/ipvs/ip_vs_conn.c:1498:8: note: in expansion of macro 'clamp'
>   max = clamp(max, min, max_avail);
>         ^~~~~
> 
> Links:
> ---
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOE9K3Dz9gRywrldKTyaXQoT/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/details/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/history/
> 
> Steps to reproduce:
> ------------
> # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> --kconfig defconfig
> 
> metadata:
> ----
>   git describe: next-20241203
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOE9K3Dz9gRywrldKTyaXQoT/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOE9K3Dz9gRywrldKTyaXQoT/
>   toolchain: gcc-8
>   config: gcc-8-defconfig
>   arch: arm64
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

