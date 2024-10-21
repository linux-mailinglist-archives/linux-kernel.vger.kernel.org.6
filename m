Return-Path: <linux-kernel+bounces-374695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44149A6EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8B7283A44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9181C57BE;
	Mon, 21 Oct 2024 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XlCsq8no"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117451C689F;
	Mon, 21 Oct 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729525707; cv=none; b=LkAI8mpfslCSDud5xTrIQ4oviKiyOzxWB5WeayawKEVU4oLzSHT09T866A1AT0+thzHYoRKUhyWFy7gGoST8k9t66VJa39d+9rdhopVexUaAWo857/+knaKY0O6vN+M/Eof288nuCinszstWKkvCSq1yFI5354boQwHlPmn4rkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729525707; c=relaxed/simple;
	bh=iFBTx2tL9cgwlq2ZMEXOuCF9LrIb+11+pMkkMd1tZIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fzb/zSN7Fpmhnxlb+CX0nvBynVdgi4ttMzTGwa3+f/nHwyQn8X6yO80yiywadEM6xDt4cIPKKFM0OfZZzigxRA+vMbwVchFFIWeuRRoW+hECxkziThQx7AfVWhBAY0T8lbuNkFA6/fUm6iA+gIg8OESmJr1foKGozTFoNnXiDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XlCsq8no; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 23EEE42B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729525705; bh=kV/Ep5boGmFSxiUYUYBsRcjsc6S01qOrduEERitEcx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XlCsq8nogaJs2Xzr2CmkglUV+vQe1z/WqCljlb0D6TbTM6NBp3awFrJxYiaklPt8X
	 XUIohrp0iklFJLZavy9pb6/GRykIijXh1aYclSAi5fF2LcBjTF2Nw0OEV7UWGxZG7e
	 efAnj3w/DNSBmDzgDeQwsscMslLpk+hA+M3DCmhRgV8Cr+xFXmBFA7CYSFqX2vSSJO
	 Eij4S5THp0F4KmbNSXZ1tNqlZ9l3Q8dB1GdcmdkHuRiCuW6Zfz+PHlUAmrBySfb0vU
	 COZ7KyasFBKTZV5wydZvJAsJS4fzv0cQ9dwY/6QZ0Wk2+GWC7ht5HR5cvHlFqAA1zi
	 lUFTkxLKb8kyg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 23EEE42B3D;
	Mon, 21 Oct 2024 15:48:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pengyu Zhang <zpenya1314@gmail.com>, alexs@kernel.org,
 siyanteng@loongson.cn, seakeel@gmail.com, si.yanteng@linux.dev
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 yaxin_wang_uestc@163.com, zenghui.yu@linux.dev, Pengyu Zhang
 <zpenya1314@gmail.com>
Subject: Re: [PATCH v6 0/4] translate page_tables.rst and fix PFN calculation
In-Reply-To: <20241016141801.25487-1-zpenya1314@gmail.com>
References: <20241016141801.25487-1-zpenya1314@gmail.com>
Date: Mon, 21 Oct 2024 09:48:24 -0600
Message-ID: <871q09tq2f.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pengyu Zhang <zpenya1314@gmail.com> writes:

> Translate page_tables.rst to Simplified Chinese.
>
> Fix a mistake for pfn value in mm/page_tables.rst.
>
> Add a entry in Chinese glossary
>
> Pengyu Zhang (4):
>   Docs/zh_CN: Translate page_tables.rst to Simplified Chinese
>   Docs/mm: Fix a mistake for pfn in page_tables.rst
>   Docs/zh_CN: Fix the pfn calculation error in page_tables.rst
>   docs/zh_CN: Add a entry in Chinese glossary
>
>  Documentation/mm/page_tables.rst              |   2 +-
>  Documentation/translations/zh_CN/glossary.rst |   1 +
>  Documentation/translations/zh_CN/mm/index.rst |   1 +
>  .../translations/zh_CN/mm/page_tables.rst     | 221 ++++++++++++++++++
>  4 files changed, 224 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/translations/zh_CN/mm/page_tables.rst

Series applied (minus #2, applied previously).

Thanks,

jon

