Return-Path: <linux-kernel+bounces-289033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661B95416E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC1D282D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E52C6BB;
	Fri, 16 Aug 2024 05:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6HYR8on"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59C3C24;
	Fri, 16 Aug 2024 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787623; cv=none; b=b/9Em6K88RyHnENHVv6FVRQf4P9lpZf0btS98jDwCt2acM7LVZ0zAT1SsHDEjsCN4JETa8/Z9uorUVxM3J3gpYf5cS/erNzB+aZRevjTcKKYnz5ukDJDllaKoJJMO+cV85oLPPIiidd3suiT24wjow/Em5CiG2++Mdu5Vj8GjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787623; c=relaxed/simple;
	bh=xJck8nZ7/i2WWJz8ew/0idJPKNfB40Goh/ebcunUtv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LW/7JNNYFF+nCBvadC+vPYNprixa9nvCDr6h8V9n3k4oFgT8/Ry3YLmZF4iJDEZAyDH3dPE9f7QitiWNvh8wsYuKd/Wa5VQhPkyLNLYShDps62hzu2LLOrFgE82VE8GNWSTurDejKDMlHmHH8stPJgBIp5ECALCYa1THatEwgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6HYR8on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D17C32782;
	Fri, 16 Aug 2024 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787622;
	bh=xJck8nZ7/i2WWJz8ew/0idJPKNfB40Goh/ebcunUtv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f6HYR8ondYT/rlLhrdTJhbojPJhzbDHiSzsaU9tNQ9sebm3OcpKU17W2knodAlUU+
	 aZPNsGQvK/UV+bj6iEJxQZy5cy+TtzdD9MPzeSUy2v1CB2SQpDHl1XppY6lYe+2uyB
	 CrbwkcKCuvP/RvIJnMi1/MSdf/myj3GcMVpxQblrPQbcNowMjH+G1W2l5kjv5RwIgR
	 boLXIlymnPBhHinL1qZC4Zlwpyz+1RgXWGl0pbK+3Gy7PXLDSoQXmHpVTVMchsWOT0
	 F+lc1zT9gyGUVAncEIDkOGg354qLUsd60pU0Qc+5hUSXrjI8JjTSiJ9llhtqy5P798
	 wim5lDFAMxylw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 6/8] rcutorture: Add rcutree.nohz_full_patience_delay to TREE07
Date: Fri, 16 Aug 2024 11:22:01 +0530
Message-Id: <20240816055203.43784-7-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
References: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the rcutree.nohz_full_patience_delay=1000 kernel boot
parameter to the TREE07 scenario, on the observation that "if it ain't
tested, it don't work".

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
index 979edbf4c820..55ce305b2a3d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
@@ -2,3 +2,4 @@ nohz_full=2-9
 rcutorture.stall_cpu=14
 rcutorture.stall_cpu_holdoff=90
 rcutorture.fwd_progress=0
+rcutree.nohz_full_patience_delay=1000
-- 
2.40.1


