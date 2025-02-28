Return-Path: <linux-kernel+bounces-539236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A06A4A24F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837037A6C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA41F8722;
	Fri, 28 Feb 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjWlVRZv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE281C548C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769208; cv=none; b=Z4OFavgSelyVDI00YbaEX6Iw+emIGO7MFhPeQ9F7WTV7S0XxyezmP1L0PWc4iaVJeixB5mxsag9R4efo/utVTQaMvGqAX0XOh9GGk/sCs2MXOkh25zIYkq4hCHRCIhF87gqUmGgr9EslK8dGAu2LWAy7fHxYEGUs+zv2cLstWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769208; c=relaxed/simple;
	bh=hkm7QpEQ+GD5YAz/3ZFCJHK8aHG2qDCErePiBWqo/hY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ur+w4qqQZN50EOxmNQ1UBn4fmFFTc/blGv0T9gijKe9sTBRaFqHutc9xat/M9MQA8i2vI9ar0LtJD/bfL+jiCDMkbrXDMcqxj6enuzEcUPvhgcvDN1xZWtdJ49AN2/40lT0T1E4OYobBGBFKFhc+mUh5iNw77psaDGMejDBCJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjWlVRZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5A5C4CEE2;
	Fri, 28 Feb 2025 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769207;
	bh=hkm7QpEQ+GD5YAz/3ZFCJHK8aHG2qDCErePiBWqo/hY=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=TjWlVRZv1Rhd4nXwavT/cAs4dDHuvStmGrFUheNh1/IeNlMZoVz/3bOMLHJIvfCW3
	 QNUKMftrss0B/y1m6sbeoVH6LBgCEcQcYqiNlRxwAeDw8fJkusDm9S26LgsfP8R6NU
	 4Pw7P1qDb7T2/Xu1c5fgik9TlUl9DK4/oQBiUxr8EhCo11qrJh4WQkNziEfeybCIfe
	 qPdBlv0pNSsonXcjDxP5bKv8kJvDsU0RKYfqIwVcfkPGRg0MZn28MW9j6YqMRFU/NZ
	 1EfNhCtH51Qc7XQ3y1iibxqj4HlAUL7Rv5iIL82Yd7Lkvlu2TTYYw2hKiBTvaZgUIZ
	 Jh7hsdDH0E2bA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 861A5CE0DEB; Fri, 28 Feb 2025 11:00:07 -0800 (PST)
Date: Fri, 28 Feb 2025 11:00:07 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: patryk.wlazlyn@linux.intel.com
Cc: artem.bityutskiy@linux.intel.com, dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com, rafael.j.wysocki@intel.com,
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
	jpoimboe@kernel.org, peterz@infradead.org
Subject: [BUG objtool,x86] Missing __noreturn annotation in
 acpi_processor_ffh_play_dead()
Message-ID: <9a09eebe-f8fa-4993-83c1-7d58abac28af@paulmck-laptop>
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

My recent -next testing hits this objtool complaint:

vmlinux.o: warning: objtool: acpi_idle_play_dead+0x3c: acpi_processor_ffh_play_dead() is missing a __noreturn annotation

My attempts to silence this by adding the suggested __noreturn annotations
didn't help, and often got me compiler warnings about __noreturn functions
actually returning.  So I bisected, which converges on this innocent-looking
commit:

a7dd183f0b38 ("x86/smp: Allow calling mwait_play_dead with an arbitrary hint")

Several runs verified that this really is the commit that objtool is
complaining about.  Unfortunately, this commit does not revert cleanly.

This is from builds using clang version 19.1.5 (CentOS 19.1.5-2.el9).

Help?

							Thanx, Paul

