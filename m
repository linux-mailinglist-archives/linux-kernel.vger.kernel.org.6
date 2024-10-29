Return-Path: <linux-kernel+bounces-386877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC49B48F3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59001F21AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF5205AD2;
	Tue, 29 Oct 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="NKdXUkUk"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370362064FE
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203426; cv=none; b=txyOM/z2xuadwgUO5MajkYt5rfsv6xY6H52G03rUPMHHQOCM3dH+J5zK+Jvr9IigItqaj4fNNJ+KeIXyqZse9iDxQ+NFvZZpghX0HNiVblJLHNPFVjn5qmv7MdFwGoSRTX+DFe54kfrvbrCPz6s5tp2hB3t2JhadVazbQ/lVcRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203426; c=relaxed/simple;
	bh=0arwWO/z8nwgluKfMG97O4YJP87Fp6inA4j+237I7LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsQkfNoBkb5AmXc//ZxfngvALwr2pYQwtOD7NorI3eSl6dvyvDj/oR1TpJzNUEpHmGT3GTWXgKhtHkceqYPRESA84kXYGMt5jnROS1U3dmb42x/JvhhKQ6w/AmYRkQh5dvbe/E6KX0EN19fKQXb1fMnS02Ld/W/F8RoBIXokh5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=NKdXUkUk; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 17B542A8D55;
	Tue, 29 Oct 2024 13:03:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730203423;
	bh=0arwWO/z8nwgluKfMG97O4YJP87Fp6inA4j+237I7LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NKdXUkUkYpKnnLaAjd2+/a1o3SgIwl5sMxarCDnHNI1qAoZOJUzsl2xUmee/xv5qs
	 DyyZZU8pV2o3RTGInHikp9Isgzd/TXgqXMcAdKzv9JxsFlgOxMTqrLz/wNY9QI/NfD
	 vIrUG/yIS8pEDPC9PyK7pS3okOq6mPGF84yc4nPCQOsliFMND4eZIGBHOK3FdBd/iJ
	 Rd+V8qK1nuhLMlWRmy9yq5dWDxt2ucI+l5J+b77hWOYhWbnDVoakzeIL68KTlHAvw4
	 yLCElK4fqQH+lCwfquoruIeTRbO+gvHeZHhLNSiS+5XCEbJD6vp4j2z7OGxek2Ksbm
	 xuyZ7MF+3SniQ==
Date: Tue, 29 Oct 2024 13:03:42 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Restore iommu_flush_iotlb_all()
Message-ID: <ZyDPHtJkMdlVRj2N@8bytes.org>
References: <20241029112302.63639-1-joro@8bytes.org>
 <20241029114201.GH20281@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029114201.GH20281@ziepe.ca>

On Tue, Oct 29, 2024 at 08:42:01AM -0300, Jason Gunthorpe wrote:
> Strange that 0-day didn't flag this in my trees. We really need to get
> 0-day running on the iommu list too :\

In general I agree, but these issues where found with
allnoconfig/allmodconfig builds. Or in other words, compile tests I
expect patch submitters to do before sending changes my way.

Regards,

	Joerg

