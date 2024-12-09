Return-Path: <linux-kernel+bounces-438011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89309E9B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552F8166897
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64291448E3;
	Mon,  9 Dec 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gaj0lUkz"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D09142900
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761601; cv=none; b=JYFFjLqFxGk7EZ14IvkzaGaaLm8DGbNFthihzouPM63EvQExEf6IT8qaobwSwM4QwdT7YvTTyxvTauf5ScwvnuZreAsxa1YUoKDFx2cYEu5LQjq1cyW8D0ZWkrZkqUi7i6pOfUiD1TztwrSU50pyP/MZEFrVf3Z0Lylgc0AzUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761601; c=relaxed/simple;
	bh=PB5g3keC4KOpzFgvR7IzcMS66NDTuMCagN78bp+R8Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfY9/YuWeuY6dQLa61+jzIqBFIqGM6I0ZJLMS7MN7HSxenTdtHc6eRZdXcRjA2orlmWmBC/TUH4FW9akg9gSxlVAixNL+kJ5JzAeujPwm1J9j2DRvNEp0zzJxqjGmeC0W+WdYr7J54V+EUiK3cULJMnRpbodUxAPKo0Tx87/hTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gaj0lUkz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-3.bstnma.fios.verizon.net [173.48.102.3])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4B9GQNcQ018141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 11:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1733761585; bh=AlQnSEW6BCUL04WyaCl4xk0jfkzQg9Fph9LBPlI/ES0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gaj0lUkzNmq3fWAChUARiWCohQTkPHgplMmnLuEdSAfwRuk+tDpNZfWp24PavFYV7
	 +/t/PC/DFab3SM24jtSwL0BejAVGHdDgHvB24ahddU9mOnwIK8hXuMH0KoiU7rcoSo
	 1NVNZhIYbbKiKTnbmUyCaLLlcUQGEeLea4DeLoo4cGgvcZt1kF6oAegcFsnfVqrKLK
	 z4z+0Ud3Hk9ame+TLmXYOqKIVzsK6Xh7un0orLmH464BYxNGhVqv9+yr/Ypd93rdc+
	 yNPl+BehUsYUkt2VZeSoCsJvb2PRyZN7kW9mLfRYGAptJRMRaM/nHUdhTlG4XvEwZw
	 j2KtDfo5MvS2w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 7451C15C6794; Mon, 09 Dec 2024 11:26:23 -0500 (EST)
Date: Mon, 9 Dec 2024 11:26:23 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-49967: ext4: no need to continue when the number of
 entries is 1
Message-ID: <20241209162623.GA1667758@mit.edu>
References: <2024102133-CVE-2024-49967-a58a@gregkh>
 <be6117aa16c1a42d9c192e95334a440ac790de11.camel@oracle.com>
 <2024120952-decorator-lyricist-1e9a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120952-decorator-lyricist-1e9a@gregkh>

On Mon, Dec 09, 2024 at 02:08:02PM +0100, gregkh@linuxfoundation.org wrote:
> On Mon, Dec 09, 2024 at 12:30:08PM +0000, Siddh Raman Pant wrote:
> > On Mon, 21 Oct 2024 20:02:55 +0200, Greg Kroah-Hartman wrote:
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > ext4: no need to continue when the number of entries is 1
> > > 
> > > The Linux kernel CVE team has assigned CVE-2024-49967 to this issue.
> > 
> > This seems to fix nothing:
> > 
> > https://lore.kernel.org/all/6ba9afc8-fa95-478c-8ed2-a4ad10b3c520@huawei.com/
> 
> Ok, so should it be revoked?

We're not aware of a way of triggering the OOB error, so in that sense
the CVE is not valid.  There might be a way that someone might be able
to trigger it in the future; in that hypothetical future, there might
be some other fix that would address the root cause, but this would be
a belt and suspenders thing that might prevent that (hypothetical)
future.  So in that sense, it is highly commended that enterprise
distros and people who are not following the LTS kernels take this
patch.  But is it actually fixing a known vulnerability today?  Not
that we know of.

Cheers,

						- Ted

P.S.  If some security researcher wants to find such a way, to educate
people on why using LTS kernels is superior, they should feel free to
consider this a challenge.  :-P

