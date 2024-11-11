Return-Path: <linux-kernel+bounces-403500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275EE9C3689
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286FE1C20BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A03EA98;
	Mon, 11 Nov 2024 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="egEY05Wo"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E717F7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731292117; cv=none; b=QsVrKE/Gp2dGZ9KmtDyECCSsEm/UghJrSAhFCuefKdDveeYBrFY6DXKjLU/dwA1FAS+4NUjxx/YG6pbLpk1PMFfnFlS6qZeoQXkF3ow+7RneSyDqab/yC+P3qT/hhbNFArJHtLjncH+naZ2Jh70kluALpn6ANTY2dIG+8QSwjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731292117; c=relaxed/simple;
	bh=Rck7b4h1yQBgK+/ro4iWqphkA3CJcWXpt/ZuVmwBuWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gr2p6pt+StJqmfj+BpOUfrTbpBrMU1XSNVTtixYT5Nha4h6vBKk7Ei+G/93L3fqsYpAqb/1w7JFiI4XD/s9ngNigcUaHm9J8wb83izmNUSOkPDbP5J9ezgeTIBW1nrwfLmLDcbEMo8lbEnryKE9Qwr3L2QSxgpLElI4sK1PrDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=egEY05Wo; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731292105; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bANbxY9BmAz7NXQK5ofkVWL88hJguTT5ljf1WDdn6Ag=;
	b=egEY05WoogtONcl3J+0yMoggodypg9KTnB/reqrdwPne5KstzpU0+MQSlJ5yiSspItLhOvlofFZYVXtgKn/pkOD0koZ9j/Vgw6wJ+jUpEyCaY3ytdgpMwyVxHksMcV1hxE41ExWlF3WlrlDeyt8fJ1ChBcYRqGO/YZ3AwY9FM08=
Received: from 30.221.130.244(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJ447SW_1731292104 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 10:28:25 +0800
Message-ID: <0fa61236-e84b-4a3d-9804-612b33d166da@linux.alibaba.com>
Date: Mon, 11 Nov 2024 10:28:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add sysfs node to control cached decompression
 strategy
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241101124241.3090642-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241101124241.3090642-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chunhai,

On 2024/11/1 20:42, Chunhai Guo wrote:
> Add sysfs node to control cached decompression strategy, and all the
> cache will be cleaned up when the strategy is set to
> EROFS_ZIP_CACHE_DISABLED.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

I guess remount could also change the decompression strategy?
Or there are some other concern that remount is not usable
for your use cases?

Thanks,
Gao Xiang

