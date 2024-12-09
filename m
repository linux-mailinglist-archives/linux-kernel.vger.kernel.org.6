Return-Path: <linux-kernel+bounces-437644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312F9E9663
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D007D2819CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C961C5CBF;
	Mon,  9 Dec 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m1cjrZ2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112ED1A23A8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749686; cv=none; b=VCBPimTqhVivdLrT24Os+e8UYu6W9WKU4/H6vSIr4lU0WqYdgbxp+m2WUoWN23zgYFH8XkNWWOZAlePYL2kerM70rtpgptE5NmHDRQeBYHckJ7K3W0p4OuVELDOJ8JMmmrQ56EvE1muPwUpAVMCKlZ+M2MlJLK/AX03ZarXaPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749686; c=relaxed/simple;
	bh=FpcSYZ+IZJZii9+Z6c1cLJmRyCEpz88hwc0NxaOYFQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbBFdVv/b/fTEaqbyDrZi7RYIE9Dw3gcN1muvSSmcTLV6XD0KjYWvP4929HKhAMRszrIrRR3cE11CzICv7q2D6T1ZmIzLFe0ply4e6p5F7zeN8hIANnpNK4mm0ufvNSILtlh+I3+YrCmQNKEirNKnyy2zMQaepJpW+WadT7hAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m1cjrZ2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4ECC4CEE8;
	Mon,  9 Dec 2024 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733749685;
	bh=FpcSYZ+IZJZii9+Z6c1cLJmRyCEpz88hwc0NxaOYFQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1cjrZ2wWAX4wVatZfRX5UeZAEfaD3E0d/xGoXaFsb8jiMr9azqcFd5LHF7/or44S
	 6eRsQ6z6vxGK3Od4NrwBMolkZ23tMSfdy85h17NoBXh79oZRnIAhfR5Jcg9Fm+tvdG
	 S9NsRhoh93nSAOuTu5FTa3HcIIa9CT34S6XFEpBs=
Date: Mon, 9 Dec 2024 14:08:02 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-49967: ext4: no need to continue when the number of
 entries is 1
Message-ID: <2024120952-decorator-lyricist-1e9a@gregkh>
References: <2024102133-CVE-2024-49967-a58a@gregkh>
 <be6117aa16c1a42d9c192e95334a440ac790de11.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be6117aa16c1a42d9c192e95334a440ac790de11.camel@oracle.com>

On Mon, Dec 09, 2024 at 12:30:08PM +0000, Siddh Raman Pant wrote:
> On Mon, 21 Oct 2024 20:02:55 +0200, Greg Kroah-Hartman wrote:
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > ext4: no need to continue when the number of entries is 1
> > 
> > The Linux kernel CVE team has assigned CVE-2024-49967 to this issue.
> 
> This seems to fix nothing:
> 
> https://lore.kernel.org/all/6ba9afc8-fa95-478c-8ed2-a4ad10b3c520@huawei.com/

Ok, so should it be revoked?

thanks,

greg k-h

