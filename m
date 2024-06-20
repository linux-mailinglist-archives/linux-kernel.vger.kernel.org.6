Return-Path: <linux-kernel+bounces-222997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B351910B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D11F228EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF181B14E9;
	Thu, 20 Jun 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osuGaFBr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0091B14E8;
	Thu, 20 Jun 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899897; cv=none; b=m+GretDAPOoVRRu2gceoNFD7qOT1qFfnLtZtjakPlavIYj7XROZLzi05H3ZzPC2qAhk+UvK6wkvFxWbodAHeMhLuItQb5MmgFx8kipPwkouLL+rTbZcJMlmY6Mk3PWstsndVqDE1Hr1VcmkI27Uk7LyOtiut+5F9RKAzvjCYLig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899897; c=relaxed/simple;
	bh=CBBd2iTtU5QAWMm2k1fx6fI2ejuVnwZ445IFr3daZHY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DuX/uQXh+LKKEC1IcFnIm9XiHp4aYatTVutrVT0maYgSCkun14eshM/sA/SG9BWik1Ej1KkrmhzPHjaqYZT0mnj3YP69RaKOOwRXoZxvmk7MfG2UHXWZlLQcPetQbq2qFd7U4VZ7Go5gNOf5mf+cyJg2xWUqK1Fj2z6dnyISeAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osuGaFBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF582C2BD10;
	Thu, 20 Jun 2024 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899896;
	bh=CBBd2iTtU5QAWMm2k1fx6fI2ejuVnwZ445IFr3daZHY=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=osuGaFBrIHcXMamS35HLqk11zB2c8nw9AGw18BkTQbM4tX0OIo+I9EQms6mX1hWl/
	 SJRsxE7HOi9bDquGRqD1uCk86kZS8j1uxe+WhsncJGTOAEnt0KSVqSa2TXmLWex8j0
	 WFeRpADxPeoi7oJgzPjrFfCwwKzhWao2AkFs9XZWAqiF+2+EhzE5UAkq0k0E5o6kPP
	 YkbIMBz3T39lXEkz0/wYXMpMLegrADIOzF16xcSJTwb4GOfugAoRoarkEuZw/Uihto
	 ytJVDCbNeODkATYhM84QBLbrBXmIFSPQgoVLAH1CUKZSjteZBmEM+3DwoK3LSTMKjf
	 uBczrWCSuVHoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 73C3ACE0B67; Thu, 20 Jun 2024 09:11:36 -0700 (PDT)
Date: Thu, 20 Jun 2024 09:11:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/3] SRCU polled-grace-period updates for v6.11
Message-ID: <8ec14282-a768-49eb-b870-c2ee51e91f8b@paulmck-laptop>
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

This series provides some polled grace-period updates for SRCU:

1.	Add NUM_ACTIVE_SRCU_POLL_OLDSTATE.

2.	Update cleanup_srcu_struct() comment.

3.	Fill out polled grace-period APIs.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/srcu.h  |    4 ++++
 b/kernel/rcu/srcutiny.c |    3 ++-
 b/kernel/rcu/srcutree.c |    5 ++++-
 include/linux/srcu.h    |   31 +++++++++++++++++++++++++++++++
 kernel/rcu/srcutree.c   |    3 ++-
 5 files changed, 43 insertions(+), 3 deletions(-)

