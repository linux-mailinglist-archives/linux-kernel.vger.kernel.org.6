Return-Path: <linux-kernel+bounces-443188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7DC9EE88D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C455D1886B37
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA5211A0E;
	Thu, 12 Dec 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b="BsS20fPK"
Received: from 8.mo576.mail-out.ovh.net (8.mo576.mail-out.ovh.net [46.105.56.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF232135BA
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.56.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012811; cv=none; b=oq3t36WWofdofmpJkCKqdL30KPWJ5EGQn4IUxJwbpZPJ18WZySk08f+QxAYSv9YcC/yN8u6M9zlMF/cm1OadWm24vYPdNKYe8PqV4BgnWfPv4YyCyjISMIkBF9nfI3WazkFWDRU6IU8mMkJgV7gdjDtwuLVbqj0KY1ROY3dhVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012811; c=relaxed/simple;
	bh=kau2WDQDxns4OI4z3igOUSCCMFxUbhtoSJZaOegv+Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao1+JD8uu1SWPZcz/eJmye+2A2fBC+iliOmunRjbFlBd6lbqFcDt1VzTPe2fxPqraigqG6tZuiZO4jYe7EH0GB1XOOMWMV8XoXtTXHlaFknfHrFkJaN59IMqg3oiHCITEeNhWeN9Sae2qrXvrNP5sgE9LVu9W0aVg2BlqK9+4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com; spf=pass smtp.mailfrom=3mdeb.com; dkim=pass (2048-bit key) header.d=3mdeb.com header.i=@3mdeb.com header.b=BsS20fPK; arc=none smtp.client-ip=46.105.56.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3mdeb.com
Received: from director2.ghost.mail-out.ovh.net (unknown [10.108.25.152])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4Y8D4Z4DL0z25jG
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:35:42 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-qqnc2 (unknown [10.110.188.5])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id EFB171FED1;
	Thu, 12 Dec 2024 13:35:41 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.109])
	by ghost-submission-5b5ff79f4f-qqnc2 with ESMTPSA
	id nZZwL63mWmd88wMACTzsjg
	(envelope-from <sergii.dmytruk@3mdeb.com>); Thu, 12 Dec 2024 13:35:41 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-109S0031335659e-76f9-451a-a05c-49958d463d07,
                    B639BF7A6EC39DD0505FDBB1524E94DB3A46F08D) smtp.auth=sergii.dmytruk@3mdeb.com
X-OVh-ClientIp:176.111.183.174
From: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
To: linux-kernel@vger.kernel.org
Cc: trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 8/9] x86: AMD changes for EFI stub DRTM launch support
Date: Thu, 12 Dec 2024 15:35:06 +0200
Message-ID: <7572cae6440f596875eece59503f9494cfbef140.1734008878.git.sergii.dmytruk@3mdeb.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
References: <cover.1734008878.git.sergii.dmytruk@3mdeb.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16622223276734067868
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgvrhhgihhiucffmhihthhruhhkuceoshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpefhheefheduieelieekfffgfffgfedutdevleevvdfhfffgledvgfdtuddtheefieenucfkphepuddvjedrtddrtddruddpudejiedrudduuddrudekfedrudejgedpfeejrdehledrudegvddruddtleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepshgvrhhgihhirdgumhihthhruhhkseefmhguvggsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeeimgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=OcrJkRbmXaXFJKrn8lqT9xrqns/xLXDsqIioAjfE/bk=;
 c=relaxed/relaxed; d=3mdeb.com; h=From; s=ovhmo3617313-selector1;
 t=1734010542; v=1;
 b=BsS20fPKmMgyZ+oO+Uu58M7xHIlHdKk4SbdvRSuunG/OnynXQrMSp7TwB4ydhbxv/tcaahul
 yeTtaA/tkGvaMRJF7dAT2Ws0TWDQVvMGAEU0MPLLKDVpL0Xt7XlCoZ4MtoYjmBXjWlkcaJM13Y9
 APrTVU7nuTHogz41Tt924rXqc01okIl2JaEgral1VD+X1SlsK1Bf2LQXUc9K0KU6JLYrTg3sysa
 4H4gC3GsSYCp8ZJRoaQ9Wy3kM4Gnyk18djmvVdcEpnrIA9fGyOhY/ife+LZhmkHPt5VwIBvBMs9
 VqLskg+Ia/q7W2bOfX0Pw4ch5rgyxh71pnlBsPgIuINgA==

From: Ross Philipson <ross.philipson@oracle.com>

Only do the TXT setup steps if this is a TXT launch not an SKINIT one.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Sergii Dmytruk <sergii.dmytruk@3mdeb.com>
---
 drivers/firmware/efi/libstub/x86-stub.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 2e063bce1080..04f9a9cc72c3 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -929,21 +929,28 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
 						 struct boot_params *boot_params)
 {
-	struct slr_entry_intel_info *txt_info;
+	struct slr_entry_intel_info *intel_info;
+	struct slr_entry_amd_info *amd_info;
 	struct slr_entry_policy *policy;
 	struct txt_os_mle_data *os_mle;
 	bool updated = false;
 	int i;
 
-	txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
-	if (!txt_info)
-		return false;
+	intel_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
+	if (intel_info) {
+		/* If Intel info table is present, this indicates it is a TXT launch */
+		os_mle = txt_os_mle_data_start((void *)intel_info->txt_heap);
+		if (!os_mle)
+			return false;
 
-	os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
-	if (!os_mle)
-		return false;
+		os_mle->boot_params_addr = (u64)boot_params;
+	}
 
-	os_mle->boot_params_addr = (u64)boot_params;
+	amd_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_AMD_INFO);
+	if (amd_info) {
+		/* If AMD info table is present, this indicates it is a SKINIT launch */
+		amd_info->boot_params_base = (u64)boot_params;
+	}
 
 	policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
 	if (!policy)
-- 
2.47.1


