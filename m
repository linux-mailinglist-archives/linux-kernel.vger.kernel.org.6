Return-Path: <linux-kernel+bounces-180178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479268C6B22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4981F24301
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52C4C3CD;
	Wed, 15 May 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+Nq9kZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170F45014;
	Wed, 15 May 2024 16:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715792319; cv=none; b=RAXwxAJX0tfSjdV7DHrp+xNh4Lw8XJsijforg8Wqhetb31WwVqfGfczhZxTctTlKocI0l8GpbdP8Dhzc5J6WlFsMXPF1MZlwe36cufX/WlBu3Fs6keB8g+CZpAmOI0fOVuPKny+/INEvkkKaEk2z4vfsKZwxoTYS8Zdl0uFkUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715792319; c=relaxed/simple;
	bh=SG+F31jcchOBQl/TZikHS/uKvjZSzf5ZwHECGYyIEVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBttaQfcsDa92gUNVZedXUGan1o5QwiykYsfs8la5lkOc7qFrHCb0sxZPP/oo665A3u4a1mVIHeBeAJfQhy2ezrD8R+p6Py1rQXAQxPRj3ITEJBuIcffg9Y/Gx8y/CBwNuA07yJe3RxMKsZwx0iIoi7mDbh4I7WELRAGtAfkLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+Nq9kZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB73C32786;
	Wed, 15 May 2024 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715792319;
	bh=SG+F31jcchOBQl/TZikHS/uKvjZSzf5ZwHECGYyIEVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+Nq9kZSDD52tdIndEozwKQEkAzd5h/sRXMTJWCPgVuo/ZK1pHfufWyEoSDkwHeyp
	 uETfCfvlkkJfTZFGqHxMD+GJoZUYumSd6FMfjAV5zFApfY7viklsH3PA9F40cmAw/C
	 u/0iyVcib49gOPLvBk6H385gdrC31Xw7D0lzpKVbkPOU/0GMPfoPoMsuQIElTrmGGz
	 aJdJ7LEIBr3zeths6JOBqg5H7md2TfGcQ09Bceu+1hIZLfRwutFym5Kd8gMnr7JDK7
	 wiaE/YIwjahELhqpy/AKh2WcZE7ucJVkghNdIOgW5SBWOu0zqfL9Sp+OOkTaDY5rfT
	 WyrGOaSvtGFZQ==
Date: Wed, 15 May 2024 18:58:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org, 
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26821: fs: relax mount_setattr() permission checks
Message-ID: <20240515-faken-gebohrt-b7c4731929fe@brauner>
References: <2024041702-CVE-2024-26821-de6b@gregkh>
 <20240514124939.77984-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240514124939.77984-1-ailiop@suse.com>

On Tue, May 14, 2024 at 02:49:39PM +0200, Anthony Iliopoulos wrote:
> On Wed, Apr 17, 2024 at 11:44:04AM +0200, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > fs: relax mount_setattr() permission checks
> > 
> > When we added mount_setattr() I added additional checks compared to the
> > legacy do_reconfigure_mnt() and do_change_type() helpers used by regular
> > mount(2). If that mount had a parent then verify that the caller and the
> > mount namespace the mount is attached to match and if not make sure that
> > it's an anonymous mount.
> > 
> > The real rootfs falls into neither category. It is neither an anoymous
> > mount because it is obviously attached to the initial mount namespace
> > but it also obviously doesn't have a parent mount. So that means legacy
> > mount(2) allows changing mount properties on the real rootfs but
> > mount_setattr(2) blocks this. I never thought much about this but of
> > course someone on this planet of earth changes properties on the real
> > rootfs as can be seen in [1].
> > 
> > Since util-linux finally switched to the new mount api in 2.39 not so
> > long ago it also relies on mount_setattr() and that surfaced this issue
> > when Fedora 39 finally switched to it. Fix this.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-26821 to this issue.
> 
> This one probably needs to be disputed as it isn't an actual
> vulnerability, but rather a fix for the mount_setattr which previously
> didn't allow reconfiguring the real rootfs similar to what the mount
> syscall always allowed to do.
> 
> So it merely brings mount_attr up to par with mount in terms of allowing
> the real rootfs to be reconfigured.
> 
> Christian, what do you think ?

Yeah, it's not security related at all. It just allows _additional_
functionality. Not sure how that ended up on the CVE list. Thanks for
pinging about this!

