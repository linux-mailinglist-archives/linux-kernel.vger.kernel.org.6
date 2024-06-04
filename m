Return-Path: <linux-kernel+bounces-201355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B999D8FBD74
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4C61F22A86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AB614BFBC;
	Tue,  4 Jun 2024 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyNtBL0+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DAA17C96
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533609; cv=none; b=MJrFi0CM9v+TyZ/pOjDEmVUfHDbJ4XHYCGH+grC8fWCW6nwj75Y6/FafLhbXKKLYWZ6R4bumWOHy04upcuFb7mNRBNdFjKJMTwRlnFcWaJVsHildYZPvXlpcgy5az8lA6JEv/GJnA8cUakFwAaYsfnCoEwgxg16rz0W0HWJQDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533609; c=relaxed/simple;
	bh=YGiYd+G/quHQJqKEqS1+8iAeP7kk1gfIeZPfJ7HaAxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CwfdI/iY4ljAZaaXseyiWRbA+cocQ9azlzpmrgNHNKLO7/QsPm6ridfxtam8GX/2dF6Qisk8UjnA43XnfS27QRdYBtCQbKvNyo7WTktqS55ZPj552pRzIgCxk9dY4khYnrf0+gB4X8bqGHPES37TO9UrBPWkMRlCdzNSjK/xMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyNtBL0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDA0C3277B;
	Tue,  4 Jun 2024 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717533608;
	bh=YGiYd+G/quHQJqKEqS1+8iAeP7kk1gfIeZPfJ7HaAxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyNtBL0+ZIdrbbg607Hd5kixC94aaljLboCpxsKU9lnc87K4mvL7iMpsr0i53mOff
	 I8RlTTEtz2Oif43out4MY3TEK6Nbe4QOJN+UQ8xBxHryyw8aFulS0jH0Qw8mxyCHwZ
	 bjbPOa41bCw0wOASz3VDP54WkkxlnJnX1mShwfU3GJfRWRYRYDKfsPF5NCHLT+DFSA
	 mvJRwv3FRmrngDiGnz46qEGuzd3zP4c+MWUMeeUgwnakmgGK41+dkuoVo06HFcY47U
	 EBVlUfujUPrqokXdmbPGF9cSgL04nBcgJu2b5iMIk5hQtaDa7FuLCnUBXi9Pnf11Ia
	 Rc2afeQIqYQmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7ABB9CE3F0F; Tue,  4 Jun 2024 13:40:08 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	kernel-team@meta.com,
	mingo@kernel.org
Cc: elver@google.com,
	andreyknvl@google.com,
	glider@google.com,
	dvyukov@google.com,
	cai@lca.pw,
	boqun.feng@gmail.com,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 2/2] kcsan: test: add missing MODULE_DESCRIPTION() macro
Date: Tue,  4 Jun 2024 13:40:06 -0700
Message-Id: <20240604204006.2367440-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ecf1cf53-3334-4bf4-afee-849cc00c3672@paulmck-laptop>
References: <ecf1cf53-3334-4bf4-afee-849cc00c3672@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

Fix the warning reported by 'make C=1 W=1':
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/kcsan/kcsan_test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/kcsan_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 0c17b4c83e1ca..117d9d4d3c3bd 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1620,5 +1620,6 @@ static struct kunit_suite kcsan_test_suite = {
 
 kunit_test_suites(&kcsan_test_suite);
 
+MODULE_DESCRIPTION("KCSAN test suite");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Marco Elver <elver@google.com>");
-- 
2.40.1


