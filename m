Return-Path: <linux-kernel+bounces-214000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E600907D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0D81F22D41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090E613B590;
	Thu, 13 Jun 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Px52YDSv"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACF13A25D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311255; cv=none; b=YoqNDtjdc+AUkcq5OhT4iGPtzv8Z9cDleMCYRhfecAGuDAJnV41DRY7LnWL5yWB4A19CV/JlXHlWa6c6tWXWdsJ87Qk+qB6eoqyiCEmV/ast6lh+unSMFM+te7g+WfZi8hv44LOJfRJ3IFD4TyPamvcMK9fUyMjrYoumjWzzJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311255; c=relaxed/simple;
	bh=hMRBdG6cvbF9dqGsarLSaTPh2ZKi8B/U9f3d7mMDYdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/Be1QJ3eHvBIh+NQ93UGa5LWV5CU/mYivdt89JUFOoIhRT4lnbW3aFIRYGO+6YUgtC/pNRUQuahLZWTyLoIEBMzSusk5+ZGhzhQrLTW6YqBWYjPinMdz4p0CAcTB8jyUqrd7uFsKte6QAm5rGs9GP4LYtK5ermtHTOv4ceplVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Px52YDSv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f8Hv8V6cN+X5EJURCSa9FCk4ssc3QG0ndzedC6vUgdg=; b=Px52YDSvht7vj1jYddzKgW/Hb4
	I9a+H7SF4EpKeLbcQenbbSw8u15UGb+RSNfDS/NBycb80nhVCb1t+VcJDa6rvjvFLiRjauM4vCAfQ
	3C3BwsjUDfTrmCG6K3rzx9a9TTNluu9Geu3nGvypblLNfo3ggfEbOQ+ExO97i6Mxp5qaYN10Q9A/Q
	BAX6rCRz425x/hzRJIBnttddLJPpS+Z3beMWdRxw0B4q8Ebj1atYj2fwGEq6xq6+g+TeMN2YZyPLf
	ChapvaY8kA1KRJTmsDRsrDT2mH6RzLYLW+KwXx1hZ4hizXZeZ2Buab+DZujMROlqsVzcVg1eqCD48
	YxlUHr/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sHrFX-003PW2-0k;
	Thu, 13 Jun 2024 20:40:47 +0000
Date: Thu, 13 Jun 2024 21:40:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: dushistov@mail.ru, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] ufs: Add table lookup to set d_type based on mode &
 S_IFMT
Message-ID: <20240613204047.GJ1629371@ZenIV>
References: <20240613202650.39739-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613202650.39739-1-jain.abhinav177@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 13, 2024 at 08:26:50PM +0000, Abhinav Jain wrote:
> Add usf_de_type_mapping structure to map file mode masks to dir entries.
> Add a static ufs_type_table array to map file mode to dir entries.
> Remove switch and add a table based lookup for the mapping.
> Add ARRAY_SIZE macro on ufs_type_table to eliminate checkpatch warning.

For one thing, ARRAY_SIZE is already defined.  Finding the header
in question (and figuring out if its include needs to be added) is
left as an exercise for reader.

For another, you have added a copy of that array to *every* *file*
that inludes "util.h".  Finding the number of those files is, again,
left as an exercise for reader.

Finally, this

> +	for (i = 0; i < ARRAY_SIZE(ufs_type_table); i++) {
> +		if ((mode & S_IFMT) == ufs_type_table[i].mode_mask) {
> +			de->d_u.d_44.d_type = ufs_type_table[i].d_type;
> +			break;
> +		}

should've raised an arseload of mental red flags.  That loop is
bloody ridiculous, even if you don't bother to check what other
similar filesystems actually do in the counterpart of that logics.

"Table lookup" does *NOT* refer to that.  What you've got is strictly
worse than the original switch, and that takes some doing.

NAK.

