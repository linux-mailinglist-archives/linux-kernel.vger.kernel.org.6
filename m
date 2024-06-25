Return-Path: <linux-kernel+bounces-229263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CBA916D85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F59283E40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF216FF55;
	Tue, 25 Jun 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gsa1VxNW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DC156654
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330811; cv=none; b=KynnGw9PqIBvyTKL9VS37nnNeVIxh6nnTg00NeeLSSRKJgEJmVbnV1rq5xnT3p0rirbqXCm40bV8zsIn2XgjxtuNaIxIDEKc9j/rFv+RWWncCJ2zRGOhVzCY7QDlTnhYm+o/f2OkJDubRpkKRcI9t7sh8hZotLJ8vkxJ+ZkNy9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330811; c=relaxed/simple;
	bh=97xfRsJO+gSEj/L9l65cHnLuyQlLEtpEJ5oAVIlpzz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1WP/Py4iRou3YeFtbbf63WddKxhPWDXV6uD1zsu3t93FBBuM5sAoRFU/t40k4vLf2TI+Etj2Z78f4UE/aNd+z6WQos6MXlyXA0JxsTetplAabCZwwTeYgGCeSlfoMCIeX897s9YUOBbmyy6ike5cyugm/Ad5WUVObugxgYNlq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gsa1VxNW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=97xfRsJO+gSEj/L9l65cHnLuyQlLEtpEJ5oAVIlpzz4=; b=gsa1VxNWCGnRf9H/cGI/yRAHnS
	FEpmzDSJWTKM40bhJBqLzE6kpGnGPSYC7b3gWdAJnNWTdT5En3sjgA8Pik3SpK76yVkML5DxcdrUt
	KGU8GSlkWsA9Fo/NxIKYtLY2in2ru74OGLLNSQ3D2pzE6Aam01OtzDWjUE60sCRfnUm/nvohnF3dL
	Efb4XokIT3PrhV6cFbYeOSV6PP5+Svq9EJT1tWYsMumDD6JrDGr+BluTMmJAszvW3UXqo36f+cmgI
	AfxVX1YB9QY/xTX+4tAWLQsMZ2uj9HPxKPls8X1SoF8vsiFDDGGc1aClWyUGEfwIJoAy92XNI/rDg
	/jF9YnpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM8U5-00000003boG-0fme;
	Tue, 25 Jun 2024 15:53:29 +0000
Date: Tue, 25 Jun 2024 08:53:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Guanshun Liu <lgs156412@gmail.com>
Cc: rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock: export memblock_free() to free reserved
 memory.
Message-ID: <Znrn-Xh6AV_kKdvt@infradead.org>
References: <20240625121652.1189095-1-lgs156412@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625121652.1189095-1-lgs156412@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 25, 2024 at 08:16:52PM +0800, Guanshun Liu wrote:
> On architectures that support the preservation of memblock metadata
> after __init, allow drivers to call memblock_free() to free a
> reservation configured in dts. This is a hack to support the
> freeing of bootsplash reservations passed to Linux by the bootloader.

What driver?


