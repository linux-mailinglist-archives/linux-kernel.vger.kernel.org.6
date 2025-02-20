Return-Path: <linux-kernel+bounces-524178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0513A3E024
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D303167B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B9A204874;
	Thu, 20 Feb 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEScfLP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438891FCCFD;
	Thu, 20 Feb 2025 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068034; cv=none; b=KsA5+2/1Wqcy685JW9fjBjncf/5H1caKLbfFHrd6IabdyY38Nw5gju+znoIQRvSDrkCdln59rOD/CpM9bnbqoQxMqDiN+RebcpuHtnewrnEFLvfdkRtqpHMArTx77PzKxgpPq4PMrrV65VbKhIMIqc1OS02j1ipHvLXLYdUpB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068034; c=relaxed/simple;
	bh=3VSzR5Z8uIuVC+7tweHictjvzbkRlvDxQeYKXDewMeg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l3tQbfDCR3DYCAYomWRicUzT2FsRWozVD2twmGZNdINJiVieFcKI8JcFBWRnzlFm1uAQnlVtYTzayk5sxXNJ4N33hA18+0mdQ4n5hPPWfMK8ftPTtmMewEseHxPmTMA1tRx+nvHvivavK6pGTDOr1y6fyQnokKfKMALX14S1MN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEScfLP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3787C4CEE9;
	Thu, 20 Feb 2025 16:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740068033;
	bh=3VSzR5Z8uIuVC+7tweHictjvzbkRlvDxQeYKXDewMeg=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=uEScfLP3uSwjd9fRU1v9j/AvFqqzminZLgG0p9yBa6wLV6bdjMQlnCAGn+HA5OcEL
	 R+hfJICC8Z5b29cwNVCzsviPCi7e/hiZKTKsU4qzJO388ihKrwwng6CPdItTkUIm/O
	 RvLcEMHHmVerfMhVTxgbAy1GP6cmty+NNQtAJ0Kj9KJZY0ItN4qjtAV8HZT8woZyiU
	 KaEmE0lKJ0TQe42QSsDlbUZ1r1Ap8Vs2ZyTD+Vc/LMouAyI7RYrVJFaepuSV3Fz+Dx
	 /+M0MPKnrTllmgE2o4cBy2LeDC1p+0qcUPkIym2UyYNXmFDaXjyB66ACSwEfobpjrJ
	 N69cfYDriKI7A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4AEB8CE0B34; Thu, 20 Feb 2025 08:13:53 -0800 (PST)
Date: Thu, 20 Feb 2025 08:13:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, kernel-team@meta.com, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com
Subject: [PATCH memory-model 0/7] LKMM updates for v6.15
Message-ID: <8cfb51e3-9726-4285-b8ca-0d0abcacb07e@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series celebrates the release of version 7.58 of herd7, which
permits these commits to head to mainline:

1.	Add atomic_and()/or()/xor() and add_negative, courtesy of
	Puranjay Mohan.

2.	Add atomic_andnot() with its variants, courtesy of Puranjay Mohan.

3.	Legitimize current use of tags in LKMM macros, courtesy of
	Jonas Oberhauser.

4.	Define applicable tags on operation in tools/..., courtesy of
	Jonas Oberhauser.

5.	Define effect of Mb tags on RMWs in tools/..., courtesy of
	Jonas Oberhauser.

6.	Switch to softcoded herd7 tags, courtesy of Jonas Oberhauser.

7.	Distinguish between syntactic and semantic tags, courtesy of
	Jonas Oberhauser.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/memory-model/Documentation/herd-representation.txt |   27 -
 b/tools/memory-model/README                                |    2 
 b/tools/memory-model/linux-kernel.bell                     |    9 
 b/tools/memory-model/linux-kernel.cat                      |   10 
 b/tools/memory-model/linux-kernel.cfg                      |    1 
 b/tools/memory-model/linux-kernel.def                      |   21 +
 tools/memory-model/Documentation/herd-representation.txt   |   44 +-
 tools/memory-model/linux-kernel.bell                       |   36 +-
 tools/memory-model/linux-kernel.def                        |  222 ++++++-------
 9 files changed, 215 insertions(+), 157 deletions(-)

