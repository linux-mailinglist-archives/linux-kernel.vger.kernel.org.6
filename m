Return-Path: <linux-kernel+bounces-529071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A3A41F56
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6191890021
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23E23372C;
	Mon, 24 Feb 2025 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L+nUgf9b"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3723371F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400859; cv=none; b=MeqTEHveu7p9E1X8HU4EI+L1l5q8q4I6e1nraQBDgJlk3jatj00HtNhr+Nny3j3lGwhctHRd/tYRy+PWBMobqtgAqRiTkyMTmtZfDfcI5BeC9rWIzgtnij41unFUuWQ+WMyzWhNkGfhnQXYTwyZUri9zSKj0mgrBGDN6yIEF838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400859; c=relaxed/simple;
	bh=l0gqURHk5dX6iMu60ku9YofrcSGIX2DN4NM5AdEw9Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbVgnuv0ko9jl0QRyFTyUEy/X+vnNlLl/nOgT7JqiG1r0trLjkaDlNRJc76rAnw9PHOT5DCOR1zJr6zEN0m3Eo1rlAOXM/c0gt9nB/5rPh5Cz84MyhKSmKPNRfLjN7ZscwvGSK3/Qpi6xMW438yCBRgzSIq95FBlskSS66ilqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L+nUgf9b; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740400853; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JdoIXR/PyO0tsr8CSMm0YjmkZsBotehPGDdTTTCKsR0=;
	b=L+nUgf9bOWJI07PcDmX2yo1m4VKjTZT/y+b+LG2yzsAVptA5XyO77rcFNgzWHeZZBnWwUl+vIbwEMBZ5LdiWzgopzoL2A1zr6w84M3Q048EUwhqzUtAbmwJZatpzFe5SEtjngFSqOlVOAZ0zB7CW7sKBzsgmn74yLjEVmcBfAz8=
Received: from 30.74.129.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQ7w-07_1740400853 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 20:40:53 +0800
Message-ID: <26db55bd-31a1-4fb8-8ac1-add64c971841@linux.alibaba.com>
Date: Mon, 24 Feb 2025 20:40:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] erofs: simplify tail inline pcluster handling
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250224123747.1387122-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/24 20:37, Gao Xiang wrote:
> Commit ab92184ff8f1 ("erofs: add on-disk compressed tail-packing inline
> support") introduced the flag `Z_EROFS_ADVISE_INLINE_PCLUSTER`, which is
> redundant because `h_idata_size != 0` serves the same purpose.
> 
> Additionally, merge `z_idataoff` and `z_fragmentoff` since these two
> features are mutually exclusive for a given inode.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> new patch.

Note that `Z_EROFS_ADVISE_INLINE_PCLUSTER` now is left for
the compatibility purposes, only `mkfs.erofs` uses it in
the future.

Thanks,
Gao Xiang

