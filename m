Return-Path: <linux-kernel+bounces-271984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987AC94559E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DC41F23D63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48612E405;
	Fri,  2 Aug 2024 00:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvvWAKZ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A7A249EB;
	Fri,  2 Aug 2024 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559072; cv=none; b=SSckOe/JhJjc/HtF5y4WsnVlOVwStdZh11dGIUsnQtcld99IHax72kb+D1gXjv4Alt5ozL2+sw0PFSvEI+XIRhgYTtCPf0ER/4nxYxZFHl3W+2vJGlRijYwh2B0wK7uMPPXVcIkKi5AlY5XmNldbq9P25O+fh5quk5AH/rMlbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559072; c=relaxed/simple;
	bh=XzfMbwBaTKMebhXjqJdBOmTvMeI7ZiKNs5sHEYidrL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FgymqkL3SjlZbOM6G61c5RsI8W+bQxbAjCZ6fIx/kQddk0T8Ao+7qSEtSbmWcxFKewZM6tJZJJS0DkJmjtM/Wu1AibL/J8fDrBZNQ16u6RK0ewCrjc5R6yn2ngmWTgRE7RWS+xZar7J8imTulPszSkJN2msiDpH4bMsOuDXv4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvvWAKZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1408C4AF0C;
	Fri,  2 Aug 2024 00:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559072;
	bh=XzfMbwBaTKMebhXjqJdBOmTvMeI7ZiKNs5sHEYidrL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AvvWAKZ6AsAUzRKl3q6EUUqeUy5mOyJnUv3JZbE5jiqCVTrkSq2PXmJWPMXN/kOYG
	 51XC4A42wVAJ0n5G1FPe1IzKj5IITrSEfGeqUjmKxXTuf9csSV5ZHjBnlCdfG90FAD
	 37TYurtcfDT+rZJk4BLaJcvOP1AgCgROYcW3eebX1WNvrm8/kZ2G+yvA0VbodTcVYp
	 ux2VAp3akgXgnamPuQuJ9dpiDS6uq7319rV1UsiydUsb7y/8HeNJ6m4o+cc1dRhY+B
	 7nU6WXpchzpcdT/LQ5jISaw586JGHFj16qPFnymRvGwcI9FoPi1aZXEjCSZCEFdRXd
	 M6h5Wxvpx3j/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 64ADFCE09F8; Thu,  1 Aug 2024 17:37:52 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/3] rcutorture: Add rcutree.nohz_full_patience_delay to TREE07
Date: Thu,  1 Aug 2024 17:37:48 -0700
Message-Id: <20240802003750.4134451-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <22c4b040-7b7b-45ff-8fa5-41b741c7cd7e@paulmck-laptop>
References: <22c4b040-7b7b-45ff-8fa5-41b741c7cd7e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the rcutree.nohz_full_patience_delay=1000 kernel boot
parameter to the TREE07 scenario, on the observation that "if it ain't
tested, it don't work".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
index 979edbf4c8205..55ce305b2a3d0 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
@@ -2,3 +2,4 @@ nohz_full=2-9
 rcutorture.stall_cpu=14
 rcutorture.stall_cpu_holdoff=90
 rcutorture.fwd_progress=0
+rcutree.nohz_full_patience_delay=1000
-- 
2.40.1


