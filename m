Return-Path: <linux-kernel+bounces-232409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446891A864
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A07287469
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274A1953BB;
	Thu, 27 Jun 2024 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5U4/w5l"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFD194C62
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496487; cv=none; b=gWkIq0fVquHpk7d6CPJ93L8gA6Xkv6HyG46WAaFLr6X7eeFSUt3KxqDfqvIv6P3zGPBiMW19hlX5K71EyxDSXIus9/zn9K726dUjyK7kQOAQRYvAWJyRrAyNepNfiRtH3NAnEqHmnD09x438WQRwsuLfDzkW6zuuCPI01RNeilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496487; c=relaxed/simple;
	bh=b7bOhize7LEvUwKz4/795cSqj/Se2wduc6WO5bwEXZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAkNhNMOeaPIwhQzHiWMjuAmzl1PfrOqEVvfzSYK2SGm6jRr7daxR/JP+TDMcYGFYqpLbtM3b7K64WtitoKZFJBMASuXs2vIFG7khn4hDOMxyOeKv9rvzUdz/TEQ51U2/VzhUS11eeUDcstR92vmMJWcxaRFwawcBVnOPdJYCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5U4/w5l; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719496482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nUwWST44U1/yKHahJYGe2+vcp0m8PSuGOix6qGydW4c=;
	b=R5U4/w5lxcTGkf3Bn96S2VWKdr9MGSRe1cudvwr489BNzoQde0gDKW4FVxMH4pWBmm7eo0
	4CzaZpHajLyvglwC+ce81BfXRkEdVPOypLeXuZYzgHypF7y3XpPX3xUjCyL36J8eP+59Lh
	4Kzbo2672QSldfK9eaTBkf8RlOef19o=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luis Henriques <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>
Cc: Jan Kara <jack@suse.cz>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
In-Reply-To: <20240529092030.9557-1-luis.henriques@linux.dev> (Luis
	Henriques's message of "Wed, 29 May 2024 10:20:28 +0100")
References: <20240529092030.9557-1-luis.henriques@linux.dev>
Date: Thu, 27 Jun 2024 14:54:39 +0100
Message-ID: <875xtu7aow.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Wed, May 29 2024, Luis Henriques (SUSE) wrote:

> Hi!
>
> Here's v3 of this fix to the fast commit enqueuing bug triggered by fstest
> generic/047.  This version simplifies the previous patch version by re-using
> the i_sync_tid field in struct ext4_inode_info instead of adding a new one.
>
> The extra patch includes a few extra fixes to the tid_t type handling.  Jan
> brought to my attention the fact that this sequence number may wrap, and I
> quickly found a few places in the code where the tid_geq() and tid_gt()
> helpers had to be used.
>
> Again, please note that this fix requires [1] to be applied too.
>
> [1] https://lore.kernel.org/all/20240515082857.32730-1-luis.henriques@linux.dev
>
> Luis Henriques (SUSE) (2):
>   ext4: fix fast commit inode enqueueing during a full journal commit
>   ext4: fix possible tid_t sequence overflows

Gentle ping...  Has this fell through the cracks?

Cheers,
-- 
Luis

>
> fs/ext4/fast_commit.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>

