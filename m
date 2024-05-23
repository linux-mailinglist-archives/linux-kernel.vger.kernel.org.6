Return-Path: <linux-kernel+bounces-187601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA18CD51B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7062E1C227F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74414AD35;
	Thu, 23 May 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pRmMHcdz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74014A633;
	Thu, 23 May 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472608; cv=none; b=uVfhFDOpOPP310qx+qhLnEpvlclR4bI031jTV01oZby8rGty1o0taZOkRnrH9JVaKMlIkGynAylKK416XOJGa7XCZ5FL9A7Z0a1ip/5cPcP6mvcoiOlLB3mQ4p3KZmqRslS4hZfmDwRyu93yBCeeVtWyepV6vaMe1kwXtX9Fpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472608; c=relaxed/simple;
	bh=NuGhr7Ze7oZ7xDZ++e/nLZxv4dxcfSFOl8w0DFD5S6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7fezIXwYNRffMrFVetlklGa/h4xyDyysk7zqYfxRoA0jmeczqYxz7NICp+pX1feuWvyTuob4ePzwWGrX65ZzQdfcIu4XE+Wz4DdWNoDa6QDrOSGy8E2e55ce15tDda9COY4VR/co0YoLkrw22YoXwmgH7VPliEIaYsGpqs2MiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pRmMHcdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC72C2BD10;
	Thu, 23 May 2024 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716472607;
	bh=NuGhr7Ze7oZ7xDZ++e/nLZxv4dxcfSFOl8w0DFD5S6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRmMHcdzxoOXIAaz8SdoAhI2O380ggQ33OGHfk4iNl3FF6g6KiTpVEoD9V4H8AbPn
	 ZeAxGAvkzLcg8PYIa6vJt+8I0mSmvAPnS3IPc7QKIlvkILvX8c2NQ2w2IguWnif2mE
	 CqdsDGCmdbYrcf+JVtfnsiXIhcimsD3pYxsrJm6E=
Date: Thu, 23 May 2024 15:56:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26821: fs: relax mount_setattr() permission checks
Message-ID: <2024052328-favorably-gesture-7495@gregkh>
References: <2024041702-CVE-2024-26821-de6b@gregkh>
 <20240514124939.77984-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Yes, it fixes a problem where the system could not be booted
properly without this fix.

> Christian, what do you think ?

I'll defer to Christian if this CVE should be revoked or not.

thanks,

greg k-h

