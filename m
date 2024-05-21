Return-Path: <linux-kernel+bounces-184546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74F58CA85B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CB11C21694
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F443482EE;
	Tue, 21 May 2024 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FpubFwbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ECA7F;
	Tue, 21 May 2024 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275129; cv=none; b=ZIMdwTEU1lmBJLRVF6lKv/0WxKWTQVAZhn1VqME/vX2liFPmgEGtPJlB6/Fcn7lEeCPrEi0r6Kfn5x5PWRzPlERP7/LaOQb1Vepm6nQ5VD48h+UB23CEJXVhTIvIPmZfc+lUgpB73A42kt3qxIZ97gqIwdTEETRdkIzDaeKu8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275129; c=relaxed/simple;
	bh=c15ujsRuh9F0sSf6p/i3/BKLdIXyJaOjwGLssPCITqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdAXttJjAnReh/xPQ77/RYnmO2rP5PSImmBDfkretqTTH/0chwYtBlztco+HtN/kH6r5DgKNeRTH8xLOLgyu5vWT3d8Pyi7fDRy9B1kW0/XzbAOhN09lDWN7eJSJki9wMJpgBLgVMkiej4KtrTf12JE5pTIgrb60nO2heCIyVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FpubFwbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E85C2BD11;
	Tue, 21 May 2024 07:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716275129;
	bh=c15ujsRuh9F0sSf6p/i3/BKLdIXyJaOjwGLssPCITqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpubFwbDdYhOWxbBwoG1Ci3LjO/ByT9N4wesTog2P8vjKzZ0vWa+Qfq9hjCq0xYXc
	 hbS5SwJF9nUGLvqCjIIJRg4wvvyCaeHze642XBmWvDio2qdRDIoOJzvJGF4tJLpb5+
	 XKp0pGe4LyLaaR5+IVRemhJa9/IP9S1Om/XM2m7s=
Date: Tue, 21 May 2024 09:05:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26904: btrfs: fix data race at btrfs_use_block_rsv()
 when accessing block reserve
Message-ID: <2024052155-raking-onshore-f6f3@gregkh>
References: <2024041746-CVE-2024-26904-e3a8@gregkh>
 <Zkt48ug3KKOTQk42@debian0.Home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zkt48ug3KKOTQk42@debian0.Home>

On Mon, May 20, 2024 at 05:23:14PM +0100, Filipe Manana wrote:
> On Wed, Apr 17, 2024 at 12:29:19PM +0200, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > btrfs: fix data race at btrfs_use_block_rsv() when accessing block reserve
> 
> May I ask why is this classified a CVE?
> 
> How can a malicious user exploit this to do something harmful?
> 
> The race was solved to silence KCSAN warnings, as from time to time we have
> someone reporting it, but other than that, it should be harmless.

Oops, you are right, the line "BUG:" triggered our review to tag this as
a CVE.  I'll go reject it now, thanks for the review.

greg k-h

