Return-Path: <linux-kernel+bounces-260268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1F393A532
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E41E1C220A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3C7158875;
	Tue, 23 Jul 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPsq4UtM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE07C381B1;
	Tue, 23 Jul 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721757499; cv=none; b=C8fBihZ7QPIl+9Ryy4OuzSaptuZGe02Ofhg90ugMDudlKXJcEQ4fY6MJhyCcwBo2hCP59xTkz0ABP2YXY8dc/Nm9TvSLFizpOc/WZv+Wp4iAlcxyVkMlsa+U05SzaBMnFROnxeTCL44zW87qnR68ndM63tqPMoj5v22eabNN+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721757499; c=relaxed/simple;
	bh=zpqs01eB+r9f6kaArGfa7scDf/edw0VAmt/EXKackuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbGT0fWaictxy/h30g/anYijKxc1Q28qPw5JeXi/4v4+yyC8zIlxeWAM/0GmqDwKvi9dldsJ50ln9Pxqd6gD6QMCiVYVgm7BBed4KhpAfHgVpzmOmMSPOEFSeu5myR96R8FdIWJXEXOoeuOKPZLjg/lyL8CnxJuhaqZuhgOUNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPsq4UtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A7EC4AF09;
	Tue, 23 Jul 2024 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721757499;
	bh=zpqs01eB+r9f6kaArGfa7scDf/edw0VAmt/EXKackuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FPsq4UtMrVh4tmnqKIdEETKig0H5QkPJlaZLVc3KQ7dLo2EyAGH+OXw3IynnKiCFD
	 6dCO3u0j9XtpkF9H4Hy6kicROmupDksrrqctmM13Y8075pG/AJaV15HcmBR1uzfyFs
	 wpESB0g+CazGiMPgctqHEQXOvtGfHb/ak+IV/Xgw=
Date: Tue, 23 Jul 2024 19:58:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, yi.zhang@huawei.com,
	jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, niecheng1@uniontech.com,
	zhangdandan@uniontech.com, guanwentao@uniontech.com
Subject: Re: [PATCH v2 4.19 0/4] ext4: improve delalloc buffer write
 performance
Message-ID: <2024072316-thirty-cytoplasm-2b81@gregkh>
References: <78C2D546AD199A57+20240720160420.578940-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78C2D546AD199A57+20240720160420.578940-1-wangyuli@uniontech.com>

On Sun, Jul 21, 2024 at 12:04:06AM +0800, WangYuli wrote:
> Changes since v1:
>   Fixed some formatting errors to make the patchset less confusing.
> 
> A patchset from linux-5.15 should be backported to 4.19 that can
> significantly improve ext4 fs read and write performance. Unixbench test
> results for linux-4.19.318 on Phytium D2000 CPU are shown below.

Also, this looks like a performance issue, why not just use a newer
kernel (i.e. 5.15.y) to get the benefit of this, and many other,
increased performance fixes?  4.19.y is only going to be alive for a few
more months, if you haven't already planned to move off of it yet, you
need to do so now.

thanks,

greg k-h

