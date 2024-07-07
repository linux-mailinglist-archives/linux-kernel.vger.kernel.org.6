Return-Path: <linux-kernel+bounces-243592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3C92982A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 15:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28161282626
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E106210E7;
	Sun,  7 Jul 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="eettQHY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfCblkb9"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDBA18028
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720359932; cv=none; b=Dp0Cb/Yr2m4X4RiJ7ROJNQB1Hfs37kMh9AzBysBIpP05KuHBRc1EN+J8x4ZA0nKuf1qM7qqgU3Fle4vknaxtM8mb3NnEwRwfMlaP75NnvabbzCEXPhsg3pZCz3SqYKmrmW1VNc7CE6cF7PLj+UKtwK32Et6NysbYlLJweSrbDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720359932; c=relaxed/simple;
	bh=CMNhHjrdjfvTzR+mNc/aN9+WYOILDb43zX5zpbSuuqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxU9nroxgQMN+KWUfadWyQHBuQL1uh3Yvw7mAEtMjcecAojVuPR0cbnBMopg2uI/NXOue/2EJG59IdBtBN5CkbVUQvYqHCgMcGheGonRat8Bqy7jJV07kzWbKGzn3CfJTm3S8j97Uxkv8Xn9P1UYA6mWKMYkjpie1pcOJKU2zBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=eettQHY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lfCblkb9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D88301140303;
	Sun,  7 Jul 2024 09:45:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 07 Jul 2024 09:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1720359928; x=1720446328; bh=qA/HFjc/24
	lmxUn0haUeS3EHO7KTIEkvUdM/7EDKp2U=; b=eettQHY40kfcsHhMnBqcKuMB3g
	I8MBwZCNGRsjK0pR/x5dqDFlUHoP9+97dNRMh7BSZS4ZE4XvC1rVyyxuXlcwZEbV
	oCo6QUrp7lj5IGDv50rPkSgRiqm0sWVn6l6GWUDzs9BEII7ituIMH8XS+e/1LCah
	serlEb8v6u59urc4YoAfe9ghpTqCfDxn4FtJa/X3AZRRJJ9wuJQMPZIqlSaUu0YG
	9zjOCqt0lnSseCLd4cD9VQRRZCxEzF15FrF8dtDKpLBr1DDtbUuWPA/K0XTLMwT8
	XAF1tDVE3I4zwFlxDCoIMXuNSxIPY4yL8qBCRp02bu0P3e9zNf15UOA0le6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720359928; x=1720446328; bh=qA/HFjc/24lmxUn0haUeS3EHO7KT
	IEkvUdM/7EDKp2U=; b=lfCblkb9ouLJp67X3s/wB1ThI21GW+4qJznztid6wsMP
	ba+mSRosryuZxZPx6c3jfMFbl0LCq2cfPe9hLnXgpYjEoYcjIo64MWvw7Y9NMe75
	WFwWztB+6PAqg2QAQyLwxSbQcqc+75icCoSePx1/sbNt7ugtjpHmCnzZ7UmKWmSJ
	yy1pFxjauFD0odeNLAicAnPhrUBRDLPRyNvKoGQ9JuKvYl+5F1MIAA+Bu8sAZBXe
	KP9ZawJ7ofRHkKZx8ZNpIDXWZhBHhmFPuihBV9VI9FtLE/gYWo4zEpn0eVqrE30A
	9Z/mt1x5M4UjSGqYEQmK/tAhLMsv/4RKj4YKjkifOw==
X-ME-Sender: <xms:-JuKZnKQcH-Ma9PbXbnDHJLT2YwX5YBXeOvxbSDMkBdeBceRfT1KVA>
    <xme:-JuKZrIIwrG-mbf5Lgw3v9rVs05OLCMSs1EQBZwEF8NtWg-8_r_dKl6bUW5DHY3sz
    cg4KPOmBJ9TZ3y7JNs>
X-ME-Received: <xmr:-JuKZvv35Vreih95K029J_2B2qD1TEOLvh_0HKbahS_-0V2iVf7RCucIVwnsFBTPH_aWdMAaMD8wUNSMeI-rryPpkCp_Mpp72MRqQhup6F5yRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepgefgheelheejie
    elheevfeekhfdtfeeftdefgefhkeffteduveejgeekvefhvdeunecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:-JuKZgaE_dprdUNbFczBo1GGshP0Q0ltPxdhEdYhU3v4uDbcgt6XiA>
    <xmx:-JuKZuZeWiiKqscYwE9KEdklQkjtZPOF1OfsjZzzLn259NgM3N5vyw>
    <xmx:-JuKZkCoq9ANTLoQ8Ulo8pmAInJ0e23MbV1Ky6wwZOXg2ztnugJUiQ>
    <xmx:-JuKZsa03R-ZPVZh1FukrB3v2HIsd9ltextlQY4pUnkuYMKjXgfBgQ>
    <xmx:-JuKZuHViHomZ2kwZaMNADAuTR29s6UPD-JHXJTnJn2hF3FWpJ68U6M6>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jul 2024 09:45:27 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] Revert "firewire: ohci: use common macro to interpret be32 data in le32 buffer"
Date: Sun,  7 Jul 2024 22:45:23 +0900
Message-ID: <20240707134523.11784-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit f26a38e61c03fdfacb6b596e1daf665cf4526a60, since it
causes the following sparse warnings:

sparse warnings: (new ones prefixed by >>)
>> drivers/firewire/ohci.c:891:23: sparse: sparse: cast to restricted __be32
>> drivers/firewire/ohci.c:891:23: sparse: sparse: cast from restricted __le32
   drivers/firewire/ohci.c:892:23: sparse: sparse: cast to restricted __be32
   drivers/firewire/ohci.c:892:23: sparse: sparse: cast from restricted __le32
   drivers/firewire/ohci.c:893:23: sparse: sparse: cast to restricted __be32
   drivers/firewire/ohci.c:893:23: sparse: sparse: cast from restricted __le32
   drivers/firewire/ohci.c:905:31: sparse: sparse: cast to restricted __be32
   drivers/firewire/ohci.c:905:31: sparse: sparse: cast from restricted __le32
   drivers/firewire/ohci.c:914:31: sparse: sparse: cast to restricted __be32
   drivers/firewire/ohci.c:914:31: sparse: sparse: cast from restricted __le32
   drivers/firewire/ohci.c:939:18: sparse: sparse: cast to restricted __be32
   drivers/firewire/ohci.c:939:18: sparse: sparse: cast from restricted __le32
   drivers/firewire/ohci.c:2033:23: sparse: sparse: cast to restricted __be32
   drivers/firewire/ohci.c:2033:23: sparse: sparse: cast from restricted __le32
   drivers/firewire/ohci.c:2037:27: sparse: sparse: cast to restricted __be32
   drivers/firewire/ohci.c:2037:27: sparse: sparse: cast from restricted __le32
   drivers/firewire/ohci.c:2038:27: sparse: sparse: cast to restricted __be32
   drivers/firewire/ohci.c:2038:27: sparse: sparse: cast from restricted __le32

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407050656.03bw1YXA-lkp@intel.com/
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index f8d880574c19..314a29c0fd3e 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -879,7 +879,7 @@ static void ar_sync_buffers_for_cpu(struct ar_context *ctx,
 #if defined(CONFIG_PPC_PMAC) && defined(CONFIG_PPC32)
 static u32 cond_le32_to_cpu(__le32 value, bool has_be_header_quirk)
 {
-	return has_be_header_quirk ? be32_to_cpu(value) : le32_to_cpu(value);
+	return has_be_header_quirk ? (__force __u32)value : le32_to_cpu(value);
 }
 
 static bool has_be_header_quirk(const struct fw_ohci *ohci)
-- 
2.43.0


