Return-Path: <linux-kernel+bounces-272770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C579460C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E02830F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D1615C129;
	Fri,  2 Aug 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUga1Fki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168281537AB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613502; cv=none; b=k0j0Y9F6oZN0xdEhi4VSUubLm7WqpdJdRQLcAboBcYGl6YWJuS2fk55Bv1lK5pMLtkGZdoaQtRRgO6EVfoP2fA1g00GQ3UEsjI65+LljDmhtmnrtqh2vCJI+FmbMiZiCMUIECy5Y77QDOzCqV3ZVyNSOdBaWCI7seCbC6TPQZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613502; c=relaxed/simple;
	bh=6QUD70SiRGvAjjQ0omZHxZfLiA1BVKzWBUikgZbzAkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVIJr+w3M5OXwE02FbAfqrp+zbA3OVIBWuLNCqrS6S1N0s0axDIC4go9gD77u0dReY99UjNcfr6Etk1PLIl3lSPWR/Svp+FDZxiuTBpxzw8OoMP7HCADIWSKP5ZlQXb9vGpF/xeu/GNT1BtLxjcD2dAwZhbccd+98g8ESc6d7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUga1Fki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEAFC4AF0A;
	Fri,  2 Aug 2024 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613501;
	bh=6QUD70SiRGvAjjQ0omZHxZfLiA1BVKzWBUikgZbzAkY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TUga1FkibXUOV+EXeTzkEFIHtJbmox94Z7mO2aMV2+BrYRae3t/rMfvJq1Ld2+aSC
	 WPdlBCM4EddtfjDK/LXoRrLQNuQcSSnZy7uWWXA4jYKtMw+K1jUafwJ9C3LhWU8Jcx
	 fzmArg3UdegmVtE3w6V4Rfks2vOegi884KDbFU9bjj3Hhiilpig6mbFEVlGxZ7pvEA
	 cQZqgCyVxJpg1r4JDFqQuVs40CeQg1JrhUqcAL3cvD9kFc2bMHq6IgBAp7bhqiYadT
	 KwYxvM3bouQCPJAFsY47k4FHxhLoqi3+3NaCvatdI/Rog67mifZikN0Lbk2Li9KtLp
	 hLHtRLr5GXjuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 31825CE09DB; Fri,  2 Aug 2024 08:45:01 -0700 (PDT)
Date: Fri, 2 Aug 2024 08:45:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Tang <feng.tang@intel.com>, Waiman Long <longman@redhat.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 clocksource 0/5] TSC and clocksource-watchdog updates for
 v6.12
Message-ID: <dac058b2-68c7-4b9a-a428-afb2b4b03ea0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <463c0174-356b-4918-8759-c36b1b30ba55@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463c0174-356b-4918-8759-c36b1b30ba55@paulmck-laptop>

Hello!

This series contains TSC and clocksource-watchdog updates:

1.	 clocksource: Improve comments for watchdog skew bounds, courtesy
	 of Borislav Petkov.

2.	 clocksource: Fix brown-bag boolean thinko in cs_watchdog_read().

3.	 clocksource: Fix comments on WATCHDOG_THRESHOLD &
	 WATCHDOG_MAX_SKEW.

4.	 clocksource: Set cs_watchdog_read() checks based on
	 .uncertainty_margin.

5.	Check for sockets instead of CPUs to make code match comment.

						Thanx, Paul

Changes since v1:

o	Remember to CC LKML.  :-/

------------------------------------------------------------------------

 b/arch/x86/kernel/tsc.c     |    2 +-
 b/kernel/time/clocksource.c |   28 ++++++++++++++++++++--------
 kernel/time/clocksource.c   |   19 +++++++++++++------
 3 files changed, 34 insertions(+), 15 deletions(-)

