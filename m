Return-Path: <linux-kernel+bounces-218397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEBA90BF2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75C41C213DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CFC19923F;
	Mon, 17 Jun 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZaRijN4i"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7558480;
	Mon, 17 Jun 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664420; cv=none; b=b7Ku2DlhaEp5pL+1DOtil6CpURq5s/W3weJXQ66syOPUmZhxvxoqejWHxoH8TQ8c2gWauq5V4O3IDJ0+p5+HKWLRPXk5ZSWPYn314N0Z0A7AYfjMKXFFDIYMsIdKLgRkUO5Naf46QyyqDUdMmQTxkXaPqO1ji9N41ASNhpzYjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664420; c=relaxed/simple;
	bh=BDg20nXsZgzxnllRRS/wM/GeHBhb/lCv+24XuceDeT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dZVMjzdYmBcX97LYOM6sFuIKQnMkwSvT0hj8fh9GCH5GeYEUJOrjZBX1MgnVzEszQG9V0AuhiXQMXePy8LLwL2D+o/Tkh2Ol1B/BFtPbv7+RMX/f8KcgXD7WBwQYATj+ZFVmiEA8U8YII+IcdCvILE/L7pyZsdrX4OJ7p/T91cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZaRijN4i; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F22EE45E1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1718664418; bh=qfoIGw5lnHrK1nWyh6BxV91vxJtrN+BH1xtk1FojI3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZaRijN4ikAhxBr9fgn1C780ueCgKgJRcvPq06m2YWyZqnoneqTZSntNnFDmAHqxWA
	 JAp/MUzzRZB68Rwx53l+HT9FV1N3PqT3yUoJDQImGRtoAjqRpoViuC0D0WE/lNMrIg
	 MU1eH3iBO29Bpt4o5WVM+ryvGnVQnT7+Cgbwbl/lK3nRjJDFkHvEfUT8jZro9mFBh9
	 NLQsBVBb7B/zwLYp6S8vlshXE6Asp0w540Spo24So6ikOi2q1BzcJl6pW+hxlxILD0
	 kmw9fpkamCQh7wgeAjCC0rfVAUpUESQ8FcD0Gd4pTaeoLBBd3C5W7FT8VqMhPEnjOa
	 vCCnJW/gki7ng==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F22EE45E1A;
	Mon, 17 Jun 2024 22:46:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng
 Si <siyanteng@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, Andrey
 Konovalov <andreyknvl@gmail.com>, Dongliang Mu <dzm91@hust.edu.cn>, Qing
 Zhang <zhangqing@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Marco Elver <elver@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN: add back the missing part in the English
 version
In-Reply-To: <20240614140326.3028384-1-dzm91@hust.edu.cn>
References: <20240614140326.3028384-1-dzm91@hust.edu.cn>
Date: Mon, 17 Jun 2024 16:46:57 -0600
Message-ID: <87r0cvfaqm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> The zh_CN kasan document misses the code change in commit eefe68280c94
> ("kasan: Add documentation for CONFIG_KASAN_EXTRA_INFO").
>
> Fix this by adding the translation of the missing part.
>
> Note that this missing commit is found by checktransupdate.py
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/dev-tools/kasan.rst     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied, thanks.

jon

