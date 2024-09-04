Return-Path: <linux-kernel+bounces-314353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D03A96B230
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6BC1F23E50
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E03146588;
	Wed,  4 Sep 2024 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H23CjZKh"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BB126C0A
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432981; cv=none; b=DQpMnkHGJ3h6VOWC9CTABh6A2TsMSJ54JhJwHkaGD6G1rlQVutSc/hnheqtOiPghFDuxUNOQFUwzSbBBz8ylpcyrK3sNjzEGk79dsMGB3VpRB2EUj+S4YvgzJzEfOAzK/oOb/8giTeJvgDuMGRmfQRbocunLRAKm4bWRpWQMZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432981; c=relaxed/simple;
	bh=jEU/yiPDlijZ1hPPllZLOJhLAd/v7FEN/G784d2Y0TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrhO4cPvsrGmpF2ZFnb7bHsWtYb/WGvd/la4eBpyl9vk2Gj199VjpvYV7OFRa2a8OZ5n0/oQPfuh0uhEq3qSBj003EHzx/V5uDKeIGBrzQGh6gLKJ4MoUk49DVvmkpBEZ86qq2BVgV1vPD+1jmit5UmloZZY5nE2ypruDxZcEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H23CjZKh; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725432969; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=74Yfbt5V1bRHHf2JB/mJ5iQAdMROQNunrC5fjEZ61Pg=;
	b=H23CjZKhqMJc5K2Oq43F9KBwbDZqwBfLNFSfs9n5HEnZGPYH6EFHXiXtuzdDBFr/q3fflimV1+NpaCoaGVQ3Ctf6jJITJBr2OW3873QoZYVYFhvjcXKCds5RMusHZwBDgLYpWlhNkmeGfyC8LrZ3AGWuNR28Z/fsQMHoYJiEFaU=
Received: from 30.221.130.127(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEGOD2h_1725432968)
          by smtp.aliyun-inc.com;
          Wed, 04 Sep 2024 14:56:09 +0800
Message-ID: <443a883e-7565-43ed-9def-77e0d666c454@linux.alibaba.com>
Date: Wed, 4 Sep 2024 14:56:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/30 11:28, Gao Xiang wrote:
> Since EROFS only needs to handle read requests in simple contexts,
> Just directly use vfs_iocb_iter_read() for data I/Os.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Unmapped extent could actually split, already fixed as below:

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 598b865ae25f..7f82238047e6 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -127,6 +127,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
  			erofs_put_metabuf(&buf);
  		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
  			folio_zero_segment(folio, cur, cur + len);
+			attached = 0;
  		} else {
  			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
  				       map->m_deviceid != io->dev.m_deviceid)) {

