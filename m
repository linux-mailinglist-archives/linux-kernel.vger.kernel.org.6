Return-Path: <linux-kernel+bounces-290395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D995534A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD6B283912
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D018145A19;
	Fri, 16 Aug 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hHwHpY00"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481331459F7;
	Fri, 16 Aug 2024 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847326; cv=none; b=N1nPsmFQLtEWOfYAFYjIPCffjlI3utjoNKSwQOGV7+6F+xVyIjT4LC2lIHnd3VSoYPtV/fOOdmvkWeM4Jm8sliFOVSA6tBl0NdBlw3a/ePu5hf7rcCqqZh23neGhCpjW542hji0Qy+7UU5ISRJ8LK/qpJ8yBWiqvdtH/2GqxZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847326; c=relaxed/simple;
	bh=ADhPSC1RhrKTMeythfJmEvj3BHtdnbZi/eyzE1FFOkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lNSL7iWoaDRkmv5cv6d0UvPFt5e+SrAhCBFwvBYbOuE89H34f7VnsS8lUoLEOmhfRJZpjR5w4LSyi0IoUVSb3N5PZ7av42Pm7lG/HNGgOkMBwqZ6qAn3I7WW4BQD5SczPHKp5leyM6DIFl+QQcxWR5zghSlq1+aIbubYeypenc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hHwHpY00; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 34957418AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723847322; bh=GKR9Vn7868L+Axm2dm3bCL+LGD3nmVjIy+IUhUe3Va8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hHwHpY00zu+RpXn5tp7iWafFG6zdVWc3K9z3CauGEOnQcWHbIiacd+qsHE2nk1a/A
	 knjpA6zn8kHJPdF51hVcrGhipgu5cyLl6bFEPu2w0KQwAQzHgT0csCXtzXnOU3c8jv
	 vw3n02Hr0Z8755fgj80rDCJiW2ivxRi0194I+wKjhom2PcZNm7vG4v58zre0VC4ccA
	 8nbQxAfv9eo5j3R1dBHthwFh5MXj5HUSHHdcEXPszDgBGFefWCJVojQ7W3E2B5CefM
	 +zqmKoxPnBGbpMzg7+YkAa7g+p6l0rGiMowVQ9WgI8vWHuOyM85vSKj0PW61Bk7q2T
	 BK9Xu9qruyxmg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 34957418AB;
	Fri, 16 Aug 2024 22:28:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, Haoyang Liu
 <tttturtleruss@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6] docs/zh_CN: Add dev-tools/kcsan Chinese translation
In-Reply-To: <20240810082245.5934-1-tttturtleruss@hust.edu.cn>
References: <20240810082245.5934-1-tttturtleruss@hust.edu.cn>
Date: Fri, 16 Aug 2024 16:28:41 -0600
Message-ID: <87ttfkhzl2.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang Liu <tttturtleruss@hust.edu.cn> writes:

> Translate dev-tools/kcsan commit 31f605a308e6
> ("kcsan, compiler_types: Introduce __data_racy type qualifier")
> into Chinese and add it in dev-tools/zh_CN/index.rst
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> v5 -> v6: Fix a typo.
> v4 -> v5: Translate link into Chinese as well according to reviewer's advice.
> v3 -> v4: Added original English text for proper nouns and modified some unclear experessions. 
> v2 -> v3: Revised some sentences based on reviewer's suggestions and updated the KTSAN url.
> v1 -> v2: Added commit tag and fixed style problems according to reviewer's suggestions.
>
>  .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>  .../translations/zh_CN/dev-tools/kcsan.rst    | 321 ++++++++++++++++++
>  2 files changed, 322 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/kcsan.rst

So I applied this, but ended up unapplying it.  It adds a whole pile of
docs build warnings:

Documentation/translations/zh_CN/dev-tools/kcsan:223: ./include/linux/kcsan-checks.h:370: WARNING: Duplicate C declaration, also defined at dev-tools/kcsan:370.
Declaration is '.. c:macro:: ASSERT_EXCLUSIVE_WRITER'.
Documentation/translations/zh_CN/dev-tools/kcsan:223: ./include/linux/kcsan-checks.h:419: WARNING: Duplicate C declaration, also defined at dev-tools/kcsan:419.
Declaration is '.. c:macro:: ASSERT_EXCLUSIVE_WRITER_SCOPED'.
Documentation/translations/zh_CN/dev-tools/kcsan:223: ./include/linux/kcsan-checks.h:451: WARNING: Duplicate C declaration, also defined at dev-tools/kcsan:451.
Declaration is '.. c:macro:: ASSERT_EXCLUSIVE_ACCESS'.

[...]

You really do need to do a build test before sending changes like this.

The problem is the duplicated inclusion caused by the kernel-doc
directive:

> +.. kernel-doc:: include/linux/kcsan-checks.h
> +    :functions: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_WRITER_SCOPED
> +                ASSERT_EXCLUSIVE_ACCESS ASSERT_EXCLUSIVE_ACCESS_SCOPED
> +                ASSERT_EXCLUSIVE_BITS
> 

We really just can't do that with the current build system; the best
thing is to put in a note saying to see the original document for those
declarations.

This would be good to fix, perhaps with a variant of kernel-doc that
doesn't generate the duplicated declarations, but until somebody does
that we have to work around it.

Thanks,

jon

