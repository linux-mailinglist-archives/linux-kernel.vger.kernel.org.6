Return-Path: <linux-kernel+bounces-539242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E6A4A259
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03F4A1890D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3751C5D75;
	Fri, 28 Feb 2025 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPDhT4nU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948227703A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740769368; cv=none; b=H8sBn2NPJ9lt3Y95u0kuhciwedl936DDwK/wKaFtRzDPI4rYlKlxMvYl35RQO9vEIjP6Q3n6AYF9r3NI/+fuE5CfaS1RCZswRMyLBdIr1pEqIrUbEhuJvpHyCOZ7IBzM8guYHPEjYQ++3+kyIjh1pjpvnrRZLB3LqbE/SAUb6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740769368; c=relaxed/simple;
	bh=sXAENoPFPxaq4WbK4iPt7+QE0RtQwoGbdAQRdAGwUYA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q+V5Im1RIThHqFxihva56KMyuH42gVchBR1tiJKivOozLQcsZT7D/PJSuOI6yD95r5a5m5vbQ4sjQw5zrDtUWQPOJsap9A3PBkUBLd4bisE1L0psbDUms2QQy+TW8PEQEpCcolrKsi7Q69xEEqTPitEF5dNCCLvgqU2ey4/W4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPDhT4nU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001B3C4CED6;
	Fri, 28 Feb 2025 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740769368;
	bh=sXAENoPFPxaq4WbK4iPt7+QE0RtQwoGbdAQRdAGwUYA=;
	h=Date:From:To:Cc:Subject:From;
	b=gPDhT4nUxzfBmOhhY7vzcWQuCL1WqXVIbCEVPsHcgQKEG/U8PPm4f6e+E/1D04TTd
	 lrb/iDxGTDmwTQUThmfKTHkXnnre0gbfPHR4/sMUZPZy+GtqazoCqrps4gQhYyqIT0
	 Cy+6IT/zZnUYLGZftjPEPwhqY5PCREaUOYDk0OvA7Srioo4HHU+pFKo+mc3zO315gO
	 2pi5PUc3pUHkGLt3HxP/DqzkDitZz4kVx5y9beKharsv2eJXWZOJgUgvelhPMKtqco
	 ZsRPi9lWWMurRKo2V7YcQDNcwlseDIuoCxzWgFmcISOMz1G8HymwANUThp70DIGiUm
	 wMLblat/7ZGtA==
Date: Fri, 28 Feb 2025 20:02:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Subject: [GIT PULL] locking fix
Message-ID: <Z8IITcV7pyylQLdb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2025-02-28

   # HEAD: b9a49520679e98700d3d89689cc91c08a1c88c1d rcuref: Plug slowpath race in rcuref_put()

Fix an rcuref_put() slowpath race.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      rcuref: Plug slowpath race in rcuref_put()


 include/linux/rcuref.h | 9 ++++++---
 lib/rcuref.c           | 5 ++---
 2 files changed, 8 insertions(+), 6 deletions(-)

