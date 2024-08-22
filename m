Return-Path: <linux-kernel+bounces-296992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485695B1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2021C2229A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7717C7BF;
	Thu, 22 Aug 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur5p5OC9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F114EC5E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318954; cv=none; b=dUsRfKehVU5OjQzkwWvtrzhPvoGskaJ8UK/geGcZ2qswlqiMEmq7U6fgmvU287iVg0G4qyr9tq8WBlL5X/BaBFQCXTPtl7m8bjFFPlqLI2QfkYXCll0dunQVcIZa6NE+NsxJ7wsLPjIUkxJQuI5JCyFwHeu3DC8esx/xO6Rm2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318954; c=relaxed/simple;
	bh=vtJuoUWmrsdNKkbGI+rezLvYxha6TAvMZGOFWrjivYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwM4Q+CmjdTZA1bo7j3gaPM6H+yAX4HZkzUOxVKx3V+tG6lYCz0PFbMbsX8n0748v/O4gsmecWW4l89t8yaPCNXYP1zwB54nWCk/icor3Ea2UHPaYZ5o3qw88itq3KqhHjsDBoMdu2JMWrC5qNU9aZUVmtTG/7keoRva4NUe0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur5p5OC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE593C32782;
	Thu, 22 Aug 2024 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724318954;
	bh=vtJuoUWmrsdNKkbGI+rezLvYxha6TAvMZGOFWrjivYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur5p5OC9XTtEnxrPOD6bK+pZ4iaZS2GD2Adkkc40MWWpa6QW6Py9WVgwpNY3EFRmk
	 +BIy73o/h87sQboLKXJiaMvrPR3R3/UP6pRSn6qLXzmCn9bd5xS92ej1/JJCiRd/3Y
	 1e+TXP8Mc94UW+0vNk00CyMmGKONRCseAzjlDSdETjFsuVCllJRgHNMcHVTvyBVPro
	 6uNTeP8mHqjI3f1I8/r3p7r4oHZ9Y4i5/26hfV1d/cYBeqHJbwT3dsjE386MQlpqPI
	 vQGoVZq3gY3Z4kriaurvwofF+aJeWbobFN6nmV+aKKahP4xgP0LrWrCSVBLKDCzFdc
	 sYvyYI6v/LXHQ==
Date: Thu, 22 Aug 2024 12:28:59 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tvrtko Ursulin <tursulin@igalia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] numa: Add simple generic NUMA emulation
Message-ID: <ZscE23zQZGCqUz0p@kernel.org>
References: <20240625125803.38038-1-tursulin@igalia.com>
 <20240625125803.38038-2-tursulin@igalia.com>
 <2024062627-curler-unlucky-51e0@gregkh>
 <679a9dda-8e8a-4428-8d57-30b0c60f28ce@igalia.com>
 <54b357b2-2132-4fd6-89db-7a60617dc859@igalia.com>
 <20240808172726.0000154a@Huawei.com>
 <7673fb84-5fe8-4d80-865d-95df3f519528@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7673fb84-5fe8-4d80-865d-95df3f519528@igalia.com>

Hi Tvrtko,

On Mon, Aug 12, 2024 at 05:35:31PM +0100, Tvrtko Ursulin wrote:
> 
> Hi Jonathan,
> 
> On 08/08/2024 17:27, Jonathan Cameron wrote:
> > On Thu, 8 Aug 2024 12:56:44 +0100
> > Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:
> > > 
> > > c)
> > > Strong nack for either a) or b) - so "do it in the firmware" comment.
> > > 
> > > Trying to understand your position so we can progress this.
> > 
> > See:
> > https://lore.kernel.org/all/20240807064110.1003856-20-rppt@kernel.org/
> > and rest of thread
> > https://lore.kernel.org/all/20240807064110.1003856-1-rppt@kernel.org/
> > [PATCH v4 00/26] mm: introduce numa_memblks
> > 
> > Much larger rework and unification set from Mike Rapoport
> > that happens to end up adding numa emulation as part of making
> > the x86 numa_memblk work for arm64 etc.
> > 
> > It's in mm-unstable now so getting some test coverage etc.
> > 
> > Sorry, I'd kind of assumed this also went to linux-mm so
> > the connection would have been made.
> 
> This is great - I did not see it since I don't read linux-mm regularly!
> 
> I gave Mike's implementation a spin on top of RPi 6.11 kernel and it mostly
> works fine.
> 
> Is the decision that this is going in pretty much set, that is, high level
> acks are there?

It's in mm-unstable now

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-unstable

and I hope will go to Linus next merge window.
 
> One area to potentially improve is working around CMA areas when they are
> put by the firmware at a range which straddles two nodes. In my series,
> albeit not the one I yet posted, I have some code to fudge that so that CMA
> ends up wholly in one node and so CMA initialisation can succeed.
> 
> I can try and adapt that patch to this series and post as a RFC.
> 
> Then there are some odd things about NUMA, memory pressure and swap
> behaviour, but that is not specific to this series and not something I got
> to the bottom off just yet. Could be specific to my board and IO for
> instance.
> 
> Regards,
> 
> Tvrtko

-- 
Sincerely yours,
Mike.

