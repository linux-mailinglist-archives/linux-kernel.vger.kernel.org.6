Return-Path: <linux-kernel+bounces-416445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A6A9D44DD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC21282481
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA7A4A0F;
	Thu, 21 Nov 2024 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWRh8QWx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB429B0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732148016; cv=none; b=oc+zOOuiWcgslt2nQ92J2dvTPVc+HAUFLUF35iLH2+P8Sana/ut7ouYiynkiqhvDSAQsMriW5hskjGMjrGrh7ad45b1Y1dE1Li3f3IOMcZ9iPAdm1NG/WUiDaHfhyXk/a5sHRnv9IuVHFy2RWJEtfywPArIXoMwwfAa4fV1HZ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732148016; c=relaxed/simple;
	bh=PCr1mtbsU4whEOP/4sRtwf9oHyJnRJYmHVmRK5noXAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wo4AjEu9JikR6crXT5EpilHw2K8+Oi+JK2pG1hux7ZTf4siw9n673xcDTBZri3I3A+KOYzsns3poH2iIQt0S/L+X9PqJjx8UDK4C9TFzzXuUtYZkvgompWy+jth0F+Y9YSFwzJm3rAa2JGFrl0dajXr1atsfknwnegyKV6LXchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWRh8QWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9908AC4CED1;
	Thu, 21 Nov 2024 00:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732148015;
	bh=PCr1mtbsU4whEOP/4sRtwf9oHyJnRJYmHVmRK5noXAU=;
	h=From:To:Cc:Subject:Date:From;
	b=mWRh8QWx11qIK576H8qsAyfgMcRhz8vmthJcqiGFFdPLuCDyVeyh8/qi72dGpU4dB
	 GG+/pCzA40XHaz1Mf38e+5dz8NaNx0Xa/vAnnZDv08BUETqaRZnw2HpBmb52AoyovN
	 zCW4HHambK2FJpXHB29s2PaFODMg9zO4z8IMZjpQHEBymWKhIxG1KFtyGs+JSYWi4S
	 afSUNZ3DgEt5FcyaelXMrmk5u5DMtknKrpp0Gw7IUVWmcUSw5g2UGxAYrxXruw4HX1
	 v43U3JS8UdY0PV0R1qGmgA3UcjjGJtIOUEtaqjU1vQSDLEigR2VIl+fxGmD9xk9L7M
	 0Haw4dCjKedNg==
From: Namhyung Kim <namhyung@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Stephane Eranian <eranian@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] perf/arm-cmn: Ensure port and device id bits are set properly
Date: Wed, 20 Nov 2024 16:13:34 -0800
Message-ID: <20241121001334.331334-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The portid_bits and deviceid_bits were set only for XP type nodes in
the arm_cmn_discover() and it confused other nodes to find XP nodes.
Copy the both bits from the XP nodes directly when it sets up a new
node.

Fixes: e79634b53e39 ("perf/arm-cmn: Refactor node ID handling. Again.")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 drivers/perf/arm-cmn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 49bd811c6fd6efdd..b20fa600e510c54f 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2178,8 +2178,6 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
 			continue;
 
 		xp = arm_cmn_node_to_xp(cmn, dn);
-		dn->portid_bits = xp->portid_bits;
-		dn->deviceid_bits = xp->deviceid_bits;
 		dn->dtc = xp->dtc;
 		dn->dtm = xp->dtm;
 		if (cmn->multi_dtm)
@@ -2420,6 +2418,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			}
 
 			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
+			dn->portid_bits = xp->portid_bits;
+			dn->deviceid_bits = xp->deviceid_bits;
 
 			switch (dn->type) {
 			case CMN_TYPE_DTC:

base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
-- 
2.47.0.338.g60cca15819-goog


