Return-Path: <linux-kernel+bounces-374649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C2D9A6E07
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FB11F23C55
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC56313A26B;
	Mon, 21 Oct 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SR2aVyJn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA680139D07;
	Mon, 21 Oct 2024 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524228; cv=none; b=iORuZhGC0dLGwhWkrOHvIUHwjG28GdyGvw9C44A0fmSxmCWc7d/tUYVunKAQmvJaJaCzw3R+vzXZr4f4unyt3xVGvVI03pOneir++JdOc6ocAvK+ZXZ9oLskzriHk8c3LZrctKvt46bhk3Lab5hiAjgZOvpq5yopAdyR71m3Zl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524228; c=relaxed/simple;
	bh=7pU6vkbGnprUGktKk+a7ZZkR/p1JECpfVOIKBVS7138=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jpocyez/lLvxAX7LC77LsiqoYGuouPtcfTwl0rGtU3KOxTTTLClIRG8rWbtYCB2KBovwvFCuKcGCG+Zdmbwkp88GVXZc0EwkEzidi5hfADSYejGYiiasHJTZctaykg1cVtdqWPXorQK+0T5dzWg3GkbbVgDTEOy97uUpU3Dk9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SR2aVyJn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C300642B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729524219; bh=6Jw+esIEWfg5ZWvEfD6M9DRTfBpL3wluszkI2M9kyEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SR2aVyJnFE8EsbjVIj+P96LTeY7Ae6IuZrPA/LARPe+Hc6zGWAYSqn/J8bPy9S11q
	 SG5irqhZ/M2XlFX42+5ARCR5qojEK+b4N/4weECBK4Zdx90fXzEwSSdgUsR4/I4HX3
	 e8TWml+R+mgJilv80nffXDC5ezMwi/sKTD8HingrRQN+YGjBM4Lbc4NoUDxe8Vxpmo
	 tOzMp36QwiJ61x+jjqN7ih4WkK4F7/WLAuoHMCHfh6tzb9R9mC82SG5VrS2sb0E5sf
	 l1LlKiVnJP79bS4HFA2fpRuCWr7XqCuseAPw7wHGm4XcytB+Gag98sCm4OTcDPitXV
	 mZysEx04FGy7w==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C300642B3D;
	Mon, 21 Oct 2024 15:23:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Haoyang Liu <tttturtleruss@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: hust-os-kernel-patches@googlegroups.com, Haoyang Liu
 <tttturtleruss@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] docs/zh_CN: add translation of dev-tools/kmsan.rst
In-Reply-To: <20241019142243.88712-1-tttturtleruss@hust.edu.cn>
References: <20241019142243.88712-1-tttturtleruss@hust.edu.cn>
Date: Mon, 21 Oct 2024 09:23:38 -0600
Message-ID: <87v7xltr7p.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Haoyang Liu <tttturtleruss@hust.edu.cn> writes:

> Add translation of kmsan.rst and remove it from TODO list.
> update to commit 3f53d1b4a4d2 ("docs/dev-tools: fix a typo")
>
> Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> ---
> v1 -> v2: fix incorrect translations
>
>  .../translations/zh_CN/dev-tools/index.rst    |   2 +-
>  .../translations/zh_CN/dev-tools/kmsan.rst    | 392 ++++++++++++++++++
>  2 files changed, 393 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/dev-tools/kmsan.rst

Applied, thanks.

jon

