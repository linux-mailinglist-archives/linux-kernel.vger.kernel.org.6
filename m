Return-Path: <linux-kernel+bounces-404860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213649C494B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE9BB23686
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0924B1BC08B;
	Mon, 11 Nov 2024 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="oU96+tzD"
Received: from sonic312-20.consmr.mail.sg3.yahoo.com (sonic312-20.consmr.mail.sg3.yahoo.com [106.10.244.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D7156C6F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731364874; cv=none; b=ZMRv8rW3OtbF6ozlF0sBrHlKB7En8jrV4B3FTq/gNmS7bBEPZtx5CgUfhzLx3wJ/TT6d049WQrXqlPDXjIlYCLLrerJXRfphAeApYa1LLJfiajuKfZyLdwN3AcO6z+uBVi/G4vUNvgku/b1uacXYAHwJpbZ8f2GB45oLoihfGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731364874; c=relaxed/simple;
	bh=cG7reSJoypxhSF8WZxlnJTDYEnJc2ocW1SAjGk4F16Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=G8UvXbzMNShrSZgr/GcE2G1RuuDgZA3tpIkXahxqX98nv2c8oSLRvsxNoy7AeIuqOO/HeFJjkcTuAxOnAgP3ealjlAUk5q21kAgpLjwovppDUwklkib2Avz0I3xkcRpFP0L05Bm5jFZ2Ftz0M1pqv3ujgFSlhoQ5cLfd6MMCUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=oU96+tzD; arc=none smtp.client-ip=106.10.244.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1731364870; bh=VAY3jISqxsGqhWsIMu+XZ8jzanX+gBt2aTfBTDDEbuQ=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=oU96+tzDvZBmPze0a8pdoOH0vca79uq0PtLflLkkfiXN3UUo4TsZlHxkqgTz5chVYw8eOiZ/vUHPaM5ShtZFB2ZaPHQNUONkGBsUmeiortxbxDkWrPBGcq1senLqjsdIfAk/gvv1mKFcMhyRWwFHJWgq20iGcSlUBaBqlqZK94Tzy7DHQ+potPTzhSzTt90xwVaK9oEtqAyK9415pz4SrZuDDZR8zLVGXKmsG1o4JFaWsz6nsmKimjE2WzFylrxOPocJzfRxxgOQJBHCneO/OJDzW1VV+RBrb7LWyWDOEBm1nWWx6j6vaQrSLoFH85WeYFdiGAU7w8SpAf6B69UkEA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731364870; bh=d8guuBnsU1QxFzfemBWMwOEsvyFA1uK7sPmMvD0pB6T=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=AOSGU0R0J3lzD6nCFd3jASvIh+z+q13JawdG/7XpzjA0wylF9ZU9aejNZ8m48/hIyIG+nC5c0wRMKmTsZMZpLUW3bKhv4XLh1kCaCOLsyTNJv3GCct/dd2g9W9OZ8pcRtLJHl90DY9l38uT06gWLAsvQvIYOtrqwUWG5NwSQNK/XMUxmTONdWN6nyTeM3J6adjugf/tNRCEq3AVZHu9a4vNpGhTHuaeX7maMnshHvzBQxEb6d8L3KU5hv95QqIMw8Imfb0TaOc3febEY+tizNZ6cYHhEj/QLClcT6EDLBQWXt45E8nhvZo2jpVWwp1sY80ZrGQA4FiAH7xL74mlZvg==
X-YMail-OSG: h6rPJJgVM1kaK0zIZ7qbFRwuu1neEu1.ud3XMHsCgXd_CH_rfIO3u0BwSljdQpc
 gp6Bufn1xYi1UoViRVyHo8YoxW_PwgmaTjxu0E1xF8AfMSroQU39ODz2xQEKs_uPaouLBvzNTt0o
 nvp6icWKArPpxV009lAm0PxXJgtFYatRLNfOMTQnO7CzmhXyCafuyUTYpPhvLH9Efh1tBHYVMG76
 JfkukRv9y7ghxL.RlX28fSlpePQPrOakvL5Z3HLHk4GlytBEb1_y18XYE9EyTA3Pvpc3Y.SerVqe
 K.pkcZYzW8P779QikwYSGMg4cHxd.FJdDAE_CtRYjnBq7yNpHr9SbHbobLsF9M.kmzMe5LwhFVDq
 CvZgnAhj1iNkx_535o4fc0Rk54xHVGDN49RfS_CfwOh9AmG8.Jyb4WUBiqFifPiWfCWjdE7.HRRR
 pjRRAaFwDT9bhw04Oic3EcfexPnmhJ7W6G9CTMVI59yhzC6T0EcGVljuexIID1w8PZT80rwm0VRj
 CQwJBHkrgzxzYxHJm1Az3W9_7wVjquxbvpCJjg27Lcnz1pvyyZgkaUsGj70Z8ei8juOG0ynEBrAh
 NhGi0gnxeXDE6g_2F7NcYW.MNCXaIu.QhQoUoC2Ixx7iVHV_cQ8zCHQuH4TVIRpTp12yeGO4pPvB
 7q_vUjm8On43s9gNC359jnSf7Xu_5iOnQxwo97YKIL2OpmVgEzDpX.qLsU_7bC.8W0Ki.k3BT09V
 3obeymFLfNGCLYq2ioM4mG1h6tGD8RLpEQtowzYWOPJXQJ_H91hd3CRdyYhqUgLVMpeJBvbml1yo
 nO5Qyr12PhN5seV5_SLkRIyWtJaJQr1cmGqF6HFJhbBiZzSMDTbNZuTnjOsDiFhHp675_UFBO97t
 4d6w2TOysg3puI.Sm9JHXHpliy.Gte31BWw7Hh9d8kunb41rbqilpcmIMGdl0vSmgevc8SVR4Yu8
 saQX_mmvEOY5HIci1aWV9vh1V.5VoFStwE9GpD7NiVrxKOEdygTGc8tHkQ0cR_mJoLj0X3uxHBRn
 wCnfOX66IXgFGJJ0Mn0Fzk7Lwkj6Pdd0qEqchu9ISGTjthL_lJAA4upIYxI9eCn.KLA.g87Uw0zf
 _ZYq37dAb9CSz5chc8BUIWnGjeybOsWHad82vjCOtva1xOTgr2bw5FE7kn30KgT7SoRbVttf2h4u
 gjvaSXyNIsECkuMhdRYVhzPfVIc_6HP7VrUVlb_pKXwEqMDhWFdPmkyXmqcPucerMR44_eBtTu8U
 A60rn1P1QD9t_WKEmRCO8NljX3ewEpPKSgaJFw8adGFyQoX4xjMcO35n61NH0_AsRU0wF0AvMVBY
 XyjpPCTSnLVShQwsPbPgQtVe0ZUXngo5AkZMCzEawrYO3kcxm90sqZMxDgVxGO.iY8JUL6XTXjQb
 nvqMn.5CSqWpvl8ZKCP9OaLHmmIYXCnh.h9rxaRMX9LUHFbVRuf0ECHpXBMzLPb_TYnTGbqtFCjP
 Cyg9jxUywKSS2fZyEf6PHeUm5BHM__ex2Bi1PfN1BoAV0KpDYay5z7SaYmtBlmYrb17qQxE0yFBi
 64g1RYrQZ.qCvuHlN_FZXt.cdisYL9JRfugsNL9NEVLQC6Tmyt7avz1zWXBgKnsFobG0Y142ipbZ
 Fit.tqHqL99y2HUYSLrZ__8i7y67QxHkr85lsEIpVB8sSOetMwSKvbrNEvS9TRRxYVLWpaWk4kbd
 4Usv06m_9LawHzTfUFTTDdNp2G5CDZow9HlbiwJn_2v6Fj3J74OXi_0g4aA31gxKO1URc8rXQdvz
 U2THYXKUs_gs475TMp_9NvGAw4n4mImrLtwd9W8GhzjZbuHyc2dXwgrxBNmJkuY4w70q3OevYKR2
 i4yqVqZx8E0PFriLchKm_G_Bh6iep8xtApp3kvzl85lZa1xTYqMKYnafHYj.G.bAH0qBMFNqwUJ8
 F.7J.ailbcTG1KLv0KioJy79y5OhU.XW2aD9xKi9I3JDcm.wGXfdD7sXbvAEZhterZUBYAkilZ8y
 C.KETEiJjAbjonxntk_VyySKMo47vtnitPiLIR1kYa_SFQ1skqjwDLTYeHNkUjbLMmbiPcNMuwpX
 FNx3Ci6ecvyGY2RsIR7Z7fHj7s2okUcLvT4_OLLV.d67.6jfczVARqJMngm7ka4djPno5vl74ORl
 SAV_eRUjqknaAqEPgryiQLa36GAVfS6NicCrpDt.U5w5OyevKtYvrCl6u83udOPsQf1gsA1aRJVc
 evk236WmJm0LdqzN_xHWWFFN9g0vSubQLeyKoUXFt1Ru2XxX3B8VQHME-
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 3f86b400-b84b-40d7-bc51-9595ddb8a81e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Mon, 11 Nov 2024 22:41:10 +0000
Received: by hermes--production-sg3-5b7954b588-f8smd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7fa1234fe99fc0a71fe48f5ec805f6a6;
          Mon, 11 Nov 2024 22:10:42 +0000 (UTC)
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: xiubli@redhat.com,
	idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdul Rahim <abdul.rahim@myyahoo.com>
Subject: [PATCH] Use strscpy() instead of strcpy()
Date: Tue, 12 Nov 2024 03:40:37 +0530
Message-ID: <20241111221037.92853-1-abdul.rahim@myyahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20241111221037.92853-1-abdul.rahim.ref@myyahoo.com>

strcpy() is generally considered unsafe and use of strscpy() is
recommended [1]

this fixes checkpatch warning:
    WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
---
 fs/ceph/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 44451749c544..0e5b3c7b3756 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -452,7 +452,7 @@ static int __get_snap_name(struct dentry *parent, char *name,
 		goto out;
 	if (ceph_snap(inode) == CEPH_SNAPDIR) {
 		if (ceph_snap(dir) == CEPH_NOSNAP) {
-			strcpy(name, fsc->mount_options->snapdir_name);
+			strscpy(name, fsc->mount_options->snapdir_name);
 			err = 0;
 		}
 		goto out;
-- 
2.43.0


