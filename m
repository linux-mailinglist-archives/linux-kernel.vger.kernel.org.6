Return-Path: <linux-kernel+bounces-429169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB4C9E195B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D0CB475C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A51E0B73;
	Tue,  3 Dec 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrOFzl9h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A891E0B65
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218896; cv=none; b=DMRcl/D2yfccsLQ0OU31UNZNbcKhb9vWWqlK8b01CtvacILDE/PMrrOp5TGqLZyvPuzcTfXXyhgYaHGQ833exdMFnq3p1W4bUyAzgjUCfpcBX8Nwr5PngYOtd58MI8ZfXk20G9Wnpg5imOxez6pD8YAc4B/cMuZ+kkFCNcHdaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218896; c=relaxed/simple;
	bh=C/ei2hiSQTtqe+CFnjLzRRll1sTBAOBNYsVA7cruF58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzespzCealalBiN7fZmjkzNd+wTipE8dTovco7TbLl31tbR36pX2otwIseDURTWv+6E3eXf8X7N3lTZ49aSBxsVWOdlFnKzxg5omq/QaFDQlLvurQ7RvQ2CzY8KLFyvlUBlqa7PraE6zyHJfwKYu1iwEHmtMJxZXgKxKBlX1V5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrOFzl9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66405C4CECF;
	Tue,  3 Dec 2024 09:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733218895;
	bh=C/ei2hiSQTtqe+CFnjLzRRll1sTBAOBNYsVA7cruF58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrOFzl9hkKiipbUI4QHSCZRhgGQHP/wFZ2MJmFH7R/QBfQzeDUZh1bYXS6FGwDTtz
	 NcnQC/0cvGoYm7UiDn80/ZfZ5eOuAX8DfADNt55Al51K6kxdE44y5sNtOC5OH7YOJ+
	 EAwroid4Pftb2DalOb1wiXiBV7bwlc77XZWL2VJXuYvxG/PH6e4YjcsRtO0jsEApqP
	 cmejk+J7smfjH3KhKXjEQWSUgMas3aHpoht2qpuM0jXqRFgrStY+2fVsfY1KAEjnaf
	 CHx9lQKibOWShQV3/WLzVS/myPyCxpP8UUK9KzJmjjG5Oxtggwc+TMCDJk/mhpjBby
	 3ldcjHj2piqIg==
Date: Tue, 3 Dec 2024 10:41:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/qnx6: Fix building with GCC 15
Message-ID: <20241203-syndikat-jazzfest-f99972a88933@brauner>
References: <20241004184440.GQ4017910@ZenIV>
 <20241004195132.1393968-1-brahmajit.xyz@gmail.com>
 <20241115050358.GQ3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115050358.GQ3387508@ZenIV>

On Fri, Nov 15, 2024 at 05:03:58AM +0000, Al Viro wrote:
> On Sat, Oct 05, 2024 at 01:21:32AM +0530, Brahmajit Das wrote:
> > qnx6_checkroot() had been using weirdly spelled initializer - it needed
> > to initialize 3-element arrays of char and it used NUL-padded
> > 3-character string literals (i.e. 4-element initializers, with
> > completely pointless zeroes at the end).
> > 
> > That had been spotted by gcc-15[*]; prior to that gcc quietly dropped
> > the 4th element of initializers.
> > 
> > However, none of that had been needed in the first place - all this
> > array is used for is checking that the first directory entry in root
> > directory is "." and the second - "..".  The check had been expressed as
> > a loop, using that match_root[] array.  Since there is no chance that we
> > ever want to extend that list of entries, the entire thing is much too
> > fancy for its own good; what we need is just a couple of explicit
> > memcmp() and that's it.
> > 
> > [*]: fs/qnx6/inode.c: In function ‘qnx6_checkroot’:
> > fs/qnx6/inode.c:182:41: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
> >   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
> >       |                                         ^~~~~~~
> > fs/qnx6/inode.c:182:50: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
> >   182 |         static char match_root[2][3] = {".\0\0", "..\0"};
> >       |                                                  ^~~~~~
> > 
> > Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
> 
> Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Sorry, hadn't realized it had fallen through the cracks.
> Christian, usually you are handling vfs/vfs.git#vfs.misc; I can put
> it there myself, if you prefer it that way...

I've put it into vfs.fixes for rc2 as it's a bugfix. I didn't see you
wrote me message smh. Sorry.

