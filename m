Return-Path: <linux-kernel+bounces-364632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 119BE99D739
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E88C1C2290D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AF1CCB42;
	Mon, 14 Oct 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hBumXe42"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F11CC158;
	Mon, 14 Oct 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933676; cv=none; b=TVG5ugrRxIbXK2YoOv43KFXolg9jKLhvQTQ1vINXLWi+GTkgfABfzKRU8a9hNd0e4bB6b9y2tvBjrBxHMjpm3Ga0mTerczDvMxQHuFPJJcrAuIHI7wsuZhdx63SalAIZVwBsANEHH4CN/Ezv16EWwrGata6cSqJx4JZzll9V6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933676; c=relaxed/simple;
	bh=EWO9FphDFiCQ5vH7ch25CvniUbz9Uqg7Sy/Ub8Gg80M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XpOuCCeELofQ2/URXMGSZIdyFnvvdBb94rvjk7VjN8bMFLMWpHthSpge9HT9k58j63cqIU6NFpnmmy7HyW9PTDysFYQ5Lx382ZZrYjLlFIRtw2ZK2jPVOYF2sXMdtFUKquHqU8W1PvtkpVtJB8i4/yaROh0qs67HLOn/pHBlj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hBumXe42; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF5E942BFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728933674; bh=yb7cwJ8k9w7LHa2Pxg7+b6c7gkrBhkiuqlch4nwOn5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hBumXe42Hytqj42nN0KvqQth+9UWD9ig4MzZ4AFlIPHoKvLH+xupiRFeJCLmWHDTQ
	 0iMxGAO1pZ1hz4952CMCuFZOBuRXZPChFJBw6ylNAd6+M9SACfzUtKusxpbpIKK3Ub
	 H8Sl9zR1NLgoHmTPEILvulpZPymxFhvFW9S6iv1tK8LE1Yx/4/Jey2H0vetY7v6UmF
	 BQcu4Jj1Ak6kVbgTiuvt8cmn0BMDzuMDYAnSwb16CWrdqa1d4DITjpusAUWOuHjjNl
	 OWVL5Sa319N0H5TvxGDoAxR+1bWQ47+U5mP09iKZQ74UObeEy83+BG0XPHM41nSAmU
	 2WFcWydPdiBsQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DF5E942BFE;
	Mon, 14 Oct 2024 19:21:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Alex Shi <seakeel@gmail.com>, jiang.kun2@zte.com.cn, alexs@kernel.org,
 siyanteng@loongson.cn, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com
Cc: wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn, xu.xin16@zte.com.cn,
 he.peilin@zte.com.cn, tu.qiang35@zte.com.cn, qiu.yutan@zte.com.cn,
 zhang.yunkai@zte.com.cn
Subject: Re: [PATCH v5] Docs/zh_CN: Translate physical_memory.rst to
 Simplified Chinese
In-Reply-To: <ecdc7672-965a-4bc5-8e0a-a407de82407f@gmail.com>
References: <20241012171357153parWX6Has5WheQyGlP0kP@zte.com.cn>
 <ecdc7672-965a-4bc5-8e0a-a407de82407f@gmail.com>
Date: Mon, 14 Oct 2024 13:21:12 -0600
Message-ID: <87ed4isd7b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alex Shi <seakeel@gmail.com> writes:

> Hi Jiang, 
>
> Your patch format is still odd in 'Subject':
> Subject: =?UTF-8?B?wqBbUEFUQ0ggdjVdIERvY3MvemhfQ046IFRyYW5zbGF0ZSBwaHlzaWNhbF9tZW1vcnkucnN0IHRvIFNpbXBsaWZpZWTCoENoaW5lc2U=?=
> Content-Type: text/plain;
>         charset="UTF-8"
> X-MAIL:mse-fl2.zte.com.cn 49C9DsLB077233
> X-Fangmail-Anti-Spam-Filtered: true
> X-Fangmail-MID-QID: 670A3DD9.001/4XQd8n4BCPz5B1DK
>
> It should a English word. 
> You need to send patch to yourself and apply it to check if
> everything all right.

I think the formatting is OK - the patch applies fine here.  I would
appreciate a review of the actual content, though...:)

Thanks,

jon

