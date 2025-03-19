Return-Path: <linux-kernel+bounces-567941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6ECA68C37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4941895E37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6BE254AFD;
	Wed, 19 Mar 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="KalEKvvx"
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E71E1E0C;
	Wed, 19 Mar 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385455; cv=none; b=FNUDkB9a6bmv9NvdJF8IVAqGlR2hf1mTKTTFYfolhFZg4u9UjpZ9k/B5bVtOP4mYmGT616vpQ0X+wteRm3LrGef1ZRz6VQcQms3NQ2dn7FklMTInFjPNFQSjZldufqmYGv8dPMthbiRaqy4IzOPUHFtocbECEEh/h/jx5UwBiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385455; c=relaxed/simple;
	bh=+GcmxnegzF4HxRw5Iin980YT+JpN7xF+a36qW+enIr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CW9tfbwSpzG11z1mRks6a1mksxfJmN5IhY4Fd1Uxi+nfy7VMgeXfr+z3XeKtagvMQRfznZGDfJ7ty1UaXTZ4IaM+lED3Gttmax7cV8s/hygvgiV7bfpa5snJCE1BolgAKiCUIXKPDn3BLs1GbbGg4KKgkAd3167N85UB3xPunc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=KalEKvvx; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=e54Sn09BVp7/KKqTaPTDv8dKNEjZmVWfgmTI2brbebg=; b=KalEKvvxHEgYej6g5YkNPGPj9h
	5CwtJ/Wq80V5BOCCtOTXeQRT0gIZ0mThUBO+J77pTQC+Y8P0tkZTy3hpAcGiom3CyET2qjsEeVbsM
	HuUya6q/0PyrxyvLjcv3fUF5wvDH9nSbYVm6ZMhEQ6yoB3hktzjPWFENoS8HRLVZX3z+zq5AvERDR
	GZ7i4Hrjo0eLTaOyWzSOtyO4oDbjuKQ2t0Cttq4cqv8ogiteVQxphL6Mnk2x/Ccv7Uz9dlgED0YSY
	ZoL7zUeW1AStMLv2tb2emH4zxUb0gfS+QXDZgyIIHxIsHKn0FZbwIOz8Z5jR5ATDhF+G1cTY6DA+T
	Lqr1g/bM3iYafMR33SD2uMtLyXj5oYk09zzgcKdzwUpGtiacohObofeuy20KOatBJUKQmbKzS5aCa
	KyHMJ4HEgEObAR0JNNmLahVql68ZIaVzrDuIUOXYWsc6ddliVCgWyi0xuE0SZ6qMLmqdqOLmnL0+e
	KyWOx5eu7Dxo3UpqzJLZgizNWxLaFcpRgPx0joDr2CemL53CjhhyBmLc2vjc5kFOt6bSzbuFnfG4R
	3CxsywdFIvXq0bvkddnhrUClub6uvfjgHnxawJ2B8ru3CQzbuX1RxQiaREFYuJQWemRb7ArhGAzxI
	zJ5v3oPZWePSxfPbh551ASCX8oRavRZJX2L7dgdnI=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robert Morris <rtm@mit.edu>
Subject:
 Re: [PATCH v3] 9p/net: fix improper handling of bogus negative read/write
 replies
Date: Wed, 19 Mar 2025 12:57:23 +0100
Message-ID: <2428194.19GxUa3r0a@silver>
In-Reply-To: <20250319-9p_unsigned_rw-v3-1-71327f1503d0@codewreck.org>
References: <20250319-9p_unsigned_rw-v3-1-71327f1503d0@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, March 19, 2025 12:20:15 PM CET Dominique Martinet wrote:
> In p9_client_write() and p9_client_read_once(), if the server
> incorrectly replies with success but a negative write/read count then we
> would consider written (negative) <= rsize (positive) because both
> variables were signed.
> 
> Make variables unsigned to avoid this problem.
> 
> The reproducer linked below now fails with the following error instead
> of a null pointer deref:
> 9pnet: bogus RWRITE count (4294967295 > 3)
> 
> Reported-by: Robert Morris <rtm@mit.edu>
> Closes: https://lore.kernel.org/16271.1734448631@26-5-164.dynamic.csail.mit.edu
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
> Changes in v3:
> - fix bad print formats
> - Link to v2: https://lore.kernel.org/r/20250317-9p_unsigned_rw-v2-1-9d7a94a916ae@codewreck.org
> 
> Changes in v2:
> - fixed rsize to be u32 instead of size_t
> - Link to v1: https://lore.kernel.org/r/20241222-9p_unsigned_rw-v1-1-3ea971d200cb@codewreck.org
> ---
>  net/9p/client.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)




