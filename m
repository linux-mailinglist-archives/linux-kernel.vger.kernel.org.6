Return-Path: <linux-kernel+bounces-201447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A128FBEB7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E243B25354
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D9E145322;
	Tue,  4 Jun 2024 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4Ppw4nX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863542AEEC;
	Tue,  4 Jun 2024 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539440; cv=none; b=FiX4Kk5MpOmizbd0SwqzgdGrJBgLf7O0Bh2uHjJ/u8Jaz4agQCpXFX73WjLnbXO+ND1YFZUe+HSFGxquULsmWI0cWsNYWAuZk3klntayKvEHsppTAbHrQy85jqEZOePfSl5+sAcwvj5W+MUbPPOJdxjqN5KY/HyhHT7o+7b31oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539440; c=relaxed/simple;
	bh=aJZ+lItQghN7ju48iKk7ERmRlKCfvZdxUtvI+DIjTqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VgwARXaNFJYVXJpHW8ZWdjRhugKLF7VpQLe2RYfaD14A/J5xTwZQ/oZGQGd389eFz1GBD3mrPg+0cV/CYbewSZjjXWHrbpxnrZtXszAlER/3RTXnsr9F8PIWmjH9PYuE+Vop9BDkIuMoURAdL/NS5tLP/RtkLNZbAl5SDvzWrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4Ppw4nX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED59DC2BBFC;
	Tue,  4 Jun 2024 22:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539440;
	bh=aJZ+lItQghN7ju48iKk7ERmRlKCfvZdxUtvI+DIjTqQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=R4Ppw4nXrH66SQcOQaK5JbIgycd7euPtV1oeobFh4EDDh2Boj2BCU++0RCAv8MCy+
	 GHK7/4zICiakvZYnGEX4/xu2NmXJW/2AKT7LQZwrEK4hOeCJyfXNq2kxIVHG3DQHi8
	 ghPIPKzxn4cb8RoDqV+3I4xfqZcvAwuJij5bVrVwGQqvC11vPhcmIt43HK5TliNq4V
	 /ZcdxQpEghRGSYxczv4A1RxlUkxgY32/spW5662pucTjLe7GrCDBuG6q62STeP7qR/
	 McFsNzHb35G19sxRxQchXnJHbMagV+2ob/ivdExalPrbFOsXvPoXgFhPeozPtjJBY8
	 N6tZ8d9LQQkEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8D4A0CE3ED6; Tue,  4 Jun 2024 15:17:19 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:17:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/4] Torture-test updates for v6.11
Message-ID: <0b6e7177-5620-4bb4-832e-908f871b081d@paulmck-laptop>
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

This series provides non-RCU torture-testing updates:

1.	Add MODULE_DESCRIPTION(), courtesy of Jeff Johnson.

2.	Add MODULE_DESCRIPTION(), courtesy of Jeff Johnson.

3.	Add MODULE_DESCRIPTION(), courtesy of Jeff Johnson.

4.	Make torture_type static, courtesy of Jeff Johnson.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/locking/locktorture.c |    1 +
 b/kernel/scftorture.c          |    1 +
 b/kernel/torture.c             |    1 +
 kernel/scftorture.c            |    2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

