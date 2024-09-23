Return-Path: <linux-kernel+bounces-332044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A2597B4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C583B1F2402C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B133190045;
	Tue, 17 Sep 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TujJ6W4w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6424818DF78;
	Tue, 17 Sep 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726605277; cv=none; b=oT98qJFGorKid18FjVWRqbqGVNXSAsEEJJyfdpuHV8qG5o2YBYCXbt08up2pDvNwbLNrTcn35Vz7NVsNkHsAKwV/a/IHrw+dxqbfK24N4L8aA4CGtYmX88RZ53MREh0c3fhJoX+RbaPO5aMbYAQcgKDpZ35+BpfSwVhEhBzM0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726605277; c=relaxed/simple;
	bh=y06KJqQSiE5bvlBadgKqQf5IV4peeMsJJ8nz3/uQpwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY3k/pcgRg4mSOOtJoKir0lvYC3QtDJNQxwSEgKPpniJFMEVmk/GpNC0doDx7dcpz7w8eTQwzW+pPRkGUuL7Q3zdtsW+lYnmPezl1aKhw9k8XX5TepHx18Uxq8gmGALSVckOEyS9TbnyTdiCzYXLuanR+qMSBnNW/rzy0417eOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TujJ6W4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0FFC4CEC5;
	Tue, 17 Sep 2024 20:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726605277;
	bh=y06KJqQSiE5bvlBadgKqQf5IV4peeMsJJ8nz3/uQpwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TujJ6W4wSeOV0JhFS+vHmtxb5ahFJFjP3ogJe8ntNU9r0k8hww5ekLL8I9h74880r
	 KL6RllfrprJOn9WPo0WUe+1jLGBqvEzCnMSxp9HJSivwX75wkYbjoYD1b/vfZs/4PF
	 U6a/Uz/yxowvddeILp9k8W1kZ69EKpfDRWao/xI8PD4s1T/+SxCNRKZrIB0wWg2Slt
	 OdZlvPjzwa9Vu9md2DEZzRlHxHWg6sWux1IsXp/a/JU/bHugD0Y1JqyzHE3o+FY2eQ
	 9j8jAWdnGXxAReAlmx9VhgtQpmqtWcQfWxOuabW6FLNRdL8rDS/kJ/HG2Ci1ln8YkC
	 vA9VK0KY0jl/w==
Received: by pali.im (Postfix)
	id 92C697BA; Tue, 17 Sep 2024 22:34:31 +0200 (CEST)
Date: Tue, 17 Sep 2024 22:34:31 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Jeremy Allison <jra@samba.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix getting reparse points from server without WSL
 support
Message-ID: <20240917203431.w5dejuwfkmabrewz@pali>
References: <20240913200204.10660-1-pali@kernel.org>
 <20240913201041.cwueaflcxhewnvwj@pali>
 <20240917200600.6smfxhrppkyjuyku@pali>
 <ZunlTDxPLn4yryW3@jeremy-rocky-laptop.localdomain>
 <20240917202921.ty32zzmhrg33knpy@pali>
 <ZunnGhOogEQU2Hje@jeremy-rocky-laptop.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZunnGhOogEQU2Hje@jeremy-rocky-laptop.localdomain>
User-Agent: NeoMutt/20180716

On Tuesday 17 September 2024 13:31:22 Jeremy Allison wrote:
> On Tue, Sep 17, 2024 at 10:29:21PM +0200, Pali Rohár wrote:
> > On Tuesday 17 September 2024 13:23:40 Jeremy Allison wrote:
> > > On Tue, Sep 17, 2024 at 10:06:00PM +0200, Pali Rohár wrote:
> > > > And seems that SMB2_OP_QUERY_WSL_EA is useful not only for reparse
> > > > points, but also for any regular file or directory as it can contain
> > > > UNIX mode and UID/GID ownership.
> > > 
> > > uid/gid should *never* be exposed over the wire for SMB.
> > > 
> > > That way lies madness.
> > 
> > Hello Jeremy, if I understood wsl_to_fattr() function correctly then it
> > is already doing it, it fills uid/gid for stat() from data which were
> > exposed over the wire for SMB. Could you check that function if it is
> > truth?
> 
> I'm sure the Windows implementation is doing it - however, any Linux
> server implementations should not do this (IMHO).
> 
> It will break all SID -> uid / gid mapping that servers must
> carefully set up.
> 
> On the wire - SIDs must be the only source of identity.

Ok. But then I do not understand why Linux client parses and uses uid
and gids which are sent over the wire. If you are saying that the SIDs
must be the only source of truth then Linux client should rather ignore
uid and gid values?

