Return-Path: <linux-kernel+bounces-266775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DF9406AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C271C22755
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE25161914;
	Tue, 30 Jul 2024 04:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cZp664e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C33315F3E2;
	Tue, 30 Jul 2024 04:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722315224; cv=none; b=u4NIU2D686dygAFHIV+Gg66tTINU9V0oXAyhK7zya/DgzPlEhcaywiFj/6klTIMndSLIZYH85Q7kGqjIQFUoNcmki+2IDs4vCB5yzL15V3MYQrm0oZgcUi+VMQfB+8weROag0UY2D6j1DAIOjhFoxZHGMHT+cLR3kqDizUS5CfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722315224; c=relaxed/simple;
	bh=b+20sizAsLW7MM1AkpK2ZlYznbR0s8uH7ZeF0Ih+aN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2Po0xy89UfiLNIuiKjlCdR2OxvWdSbKTjdyPH/bh0MfHu1y9rpEGnjT0d6lAnVf4DwJt5vB8N9EXY78uwFEp7m7JO22F2VXLt87mNjd2fp21ygnKTBeUlpXJZLCDzd9ktdmca1VMBF5cMNC4iIy+hRKycSUWzc8BqUOBmUsbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0cZp664e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC9FC32782;
	Tue, 30 Jul 2024 04:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722315223;
	bh=b+20sizAsLW7MM1AkpK2ZlYznbR0s8uH7ZeF0Ih+aN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0cZp664eBWUdPWmiB3k2fXE++KvodsKL+ho37D9Q7sFHs9uQa/RB6OWnOWMRnmBhg
	 Mv0pH72sbcoAFrh4QG8u6gkX63+X4fslDlrrAT2ZCtR47fsv0AdOJfO50OtLKSBz2Y
	 1P+l1+wP3JQ8ms2YnLeFJScGRdFnAeGQI1gAlY6E=
Date: Tue, 30 Jul 2024 06:53:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: David Sterba <dsterba@suse.cz>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-41067: btrfs: scrub: handle RST lookup error correctly
Message-ID: <2024073030-vagabond-imprudent-8ea2@gregkh>
References: <2024072907-CVE-2024-41067-bc18@gregkh>
 <20240729205503.GT17473@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729205503.GT17473@twin.jikos.cz>

On Mon, Jul 29, 2024 at 10:55:03PM +0200, David Sterba wrote:
> On Mon, Jul 29, 2024 at 04:58:13PM +0200, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > btrfs: scrub: handle RST lookup error correctly
> > 
> > [BUG]
> > When running btrfs/060 with forced RST feature, it would crash the
> > following ASSERT() inside scrub_read_endio():
> > 
> > 	ASSERT(sector_nr < stripe->nr_sectors);
> > 
> > Before that, we would have tree dump from
> > btrfs_get_raid_extent_offset(), as we failed to find the RST entry for
> > the range.
> > 
> > [CAUSE]
> > Inside scrub_submit_extent_sector_read() every time we allocated a new
> > bbio we immediately called btrfs_map_block() to make sure there was some
> > RST range covering the scrub target.
> > 
> > But if btrfs_map_block() fails, we immediately call endio for the bbio,
> > while the bbio is newly allocated, it's completely empty.
> > 
> > Then inside scrub_read_endio(), we go through the bvecs to find
> > the sector number (as bi_sector is no longer reliable if the bio is
> > submitted to lower layers).
> > 
> > And since the bio is empty, such bvecs iteration would not find any
> > sector matching the sector, and return sector_nr == stripe->nr_sectors,
> > triggering the ASSERT().
> > 
> > [FIX]
> > Instead of calling btrfs_map_block() after allocating a new bbio, call
> > btrfs_map_block() first.
> > 
> > Since our only objective of calling btrfs_map_block() is only to update
> > stripe_len, there is really no need to do that after btrfs_alloc_bio().
> > 
> > This new timing would avoid the problem of handling empty bbio
> > completely, and in fact fixes a possible race window for the old code,
> > where if the submission thread is the only owner of the pending_io, the
> > scrub would never finish (since we didn't decrease the pending_io
> > counter).
> > 
> > Although the root cause of RST lookup failure still needs to be
> > addressed.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-41067 to this issue.
> 
> Please drop the CVE. It's a fix for feature that's still in development
> and is not enabled on production kernels (requires CONFIG_BTRFS_DEBUG).

We do not know people's use case, and can not "gate" CVE ids based on
difference config options like this.

> There was even a recent on-disk format change (mkfs required), this is
> not really for environments where security matters. Thanks.

It's a fix for a vulnerability, so I think it should stay assigned.  If
your system does not enable that config option, then there is nothing to
worry about, right?

thanks,

greg k-h

