Return-Path: <linux-kernel+bounces-207791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1666D901C39
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB1C2811E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867605588E;
	Mon, 10 Jun 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BC+ZXPTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74642200C7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006422; cv=none; b=sPeT5ADHXiBdLjmW55XjKICXdoADJP2J884hYaBZ6/IJUs6V5YB4/SDvZ/1TX2Mf2JKRTcw1A3FK5z5S1fz/DSEt5tfk9Oqp3xNm0zaOcO36HgmbRaCY1akQhhOwwNKvgYG6GfX5Vn5uHPcZTyOYewYran1VrjAMhJw4mpKjbd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006422; c=relaxed/simple;
	bh=8wxMSYoRONwrF9RsGHTh53kHDh3LzFcEbYhcNxkNjwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAjRijo6skyJI4k//rO5Ovb/G8yQ3AGmE2kS89h1myWwDVXTJcQ9j8rQsehuzON9rAim57isAHy2W7YxL6y167vnUpkcgUXpggHPh8UFg1mdyI/eGMx0NV4HZiz3txWWm5BHEj3tRVmMZBfn+fGwUqXn0iKDjBCLYB7ILvdnaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BC+ZXPTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83604C2BBFC;
	Mon, 10 Jun 2024 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718006421;
	bh=8wxMSYoRONwrF9RsGHTh53kHDh3LzFcEbYhcNxkNjwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BC+ZXPTL+jwX4mfe92NOxrgQvbL+EdnWkjljsQog0TJyWKhZXb9lai3UkJ/Q2nPHO
	 xmE+466/LRVFUHawik9RphG7uFt8WhUP9R3Q75m81o+TBs9VIPedcJRs90CdpahcNL
	 uVksCmlxY7jOlnlo4KtrmN62Y2ioB+rSUDMeB/8c=
Date: Mon, 10 Jun 2024 10:00:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Evgeniy Dushistov <dushistov@mail.ru>,
	Shuah Khan <skhan@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/ufs: Use LUT for dir entry types
Message-ID: <2024061008-granddad-aspirin-4208@gregkh>
References: <20240610034219.14711-1-luis.hernandez093@gmail.com>
 <0485dd2d-488a-40e9-b0f7-24236b9c00ab@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0485dd2d-488a-40e9-b0f7-24236b9c00ab@web.de>

On Mon, Jun 10, 2024 at 09:48:09AM +0200, Markus Elfring wrote:
> > As per the original TODO, replacing the switch statement with a lookup
> > table results in more concise mapping logic and improved performance.
> …
> 
> Can imperative wordings be relevant for another improved change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc2#n94
> 
> 
> …
> > +++ b/fs/ufs/util.h
> …
> >  static inline void
> >  ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int mode)
> …
> > +	if (mode_index < ARRAY_SIZE(ufs_mode_to_dt))
> > +		de->d_u.d_44.d_type = ufs_mode_to_dt[mode_index];
> > +	else
> >  		de->d_u.d_44.d_type = DT_UNKNOWN;
> …
> 
> May a conditional operator expression be applied at this source code place?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

