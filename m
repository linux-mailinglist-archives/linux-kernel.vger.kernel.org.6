Return-Path: <linux-kernel+bounces-285253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A0950B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83042284E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57F1A0727;
	Tue, 13 Aug 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMnbDAr6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9203B26AC6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569136; cv=none; b=Iy/Sm6Jb8ZJzbG2Y1ynblntvKsBLch+hgx7cCM2B0Wgu5HRL4EwjOo5ICeS4f46O6DazrIRQ9h750X4AjTUt6eCZWkFW2iUnS0GIsTiGko1tYek+T77fmTMc7qfmmmODCuqNlhe4kPP2pCKwWQ86mQZGvkqldC4OMJBLD549ezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569136; c=relaxed/simple;
	bh=0ErpuWWSPnpaojgHN11TgqxPDqy80549EkewgFkL670=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fDZAS9/D5r+Mfw36k3jKp/LzDY0Kd8CCUAfBMv74m0DW6rx2RZYCQmEM6t1mXvuP+bLzwnyc+cXHUZqgFHbNfuvKzNEPHnWq0DD1SEiO3T/T86ttK1PpMd14NABqFGDOQ7+a1XtKNVzP8MWRR5Lkq9n2HTd/8J758j2Ulql6oLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMnbDAr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C618C4AF0B;
	Tue, 13 Aug 2024 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723569136;
	bh=0ErpuWWSPnpaojgHN11TgqxPDqy80549EkewgFkL670=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XMnbDAr6OJ4ZfBkMdfT9QJfBYxeQ6SyhoRHnPK7K/VlF8J1EkoPLi1SABf+wfzMSY
	 jCAXM456Ba559AcTyN5PitxPB5EvTRDWtg1sIx0M+/0bEhi4rIfjlWirinqMMpkFgm
	 yN12l66ERVzvm8vzwWyZ1+j6OTtdnWLwz2IUJVzeuqn1JP0B5NjdfkPVLaUuLc2V2N
	 E3vvvQaAilxhxl3NEBaKVdFa4jn7d+CqSEQPKnaT9KEYnHUEreacKpOUauPGCbsOlj
	 K81/2ClgqJeZl+TjhSLm5KfIQfnfaIQWN8mBlG5xqItvDgh71pr6PbJUrY39jmAc4v
	 hp//iU75Ska8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4CFC52D7C;
	Tue, 13 Aug 2024 17:12:15 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 14 Aug 2024 01:12:13 +0800
Subject: [PATCH] mm: vmalloc: add optimization hint on page existence check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-fix_vmap_unlikely-v1-1-cd7954775f12@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOyTu2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0MT3bTMiviy3MSC+NK8nMzs1JxKXSNLc+MUo+QkSwOTJCWgvoKiVKA
 isJnRsbW1AH/FfypjAAAA
To: Andrew Morton <akpm@linux-foundation.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
 Hariom Panthi <hariom1.p@samsung.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=aKT10OS/EIu/f+l3Yr9+KAyeKsqSPbtIB3kaInDaHw8=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBmu5Pu3nSA77waXX7mNuwFc+0VAxl78qImyULQr
 uXa9ljONeOJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZruT7gAKCRCwMePKe/7Z
 bnjMD/4xPtGTC99xAoo1V0wlI+UMEiaSAmgH/aqfr4Mzmt+XgAIRz5yHddKDAq2Dbc22YEH3Y3Z
 UqKupngslY6Y4qlv6Ufozw2o7NmTI8dojgtLPIbPfBslKNQW28V7qqLCEN01tsYQm2SFFDq7Jo1
 wG1WyGkMyMrflLEKVTONBBCelhFpyZq2cRmwqmVb6+wsm3oA47ueQFRupufsjM6UnpUWMJX0G7h
 Q+CG+Be/JuRiu7YwkIl8H1HgSYzcQz6Djk+l6YUUSgeM72nFkLfoYqh29EXJI4FGiOFdvdMl8NB
 1XSDmkAxh4Ab3IeUg7fMkBqloVUWAGRUpOIslIV+INdzgzmsFldHmjK3eaXw/lY1JCqBOYHc8PE
 ytCf6MopH/QfvvkIc4zcczvG3cRCOHLOVm3EnUt48JyqOLYM7mI1yl5WKpTNxKe0gF0SK56jjgZ
 ign8iHfC5yeenD0FA7kqOoh7laVOHS4B4jDDU1LsNCaU/LuFwsUkG1+WC4IuPpTkVutPi2fYjBL
 pstgO1VJ08V2U46aue7dv+yB/PAcWMwgM98SYKp+poQ9T/umAl0FetGEkuRJcb8dMkN3jYRgV81
 YzdiC71umtNVsSis9HZBH5+U2p9PlC/VkWi1jTNLcS4IIRKskEkuFwbJ1CMrh7FAZ161XOblLx3
 5Ry2VNwZwvx5eaA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Miao Wang <shankerwangmiao@gmail.com>

In commit 21e516b913c1 ("mm: vmalloc: dump page owner info if page is
already mapped"), a BUG_ON macro was changed into an if statement, where
the compiler optimization hint introduced in the BUG_ON macro was removed
along with this change. This patch adds back the hint.

Fixes: 21e516b913c1 ("mm: vmalloc: dump page owner info if page is already mapped")
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..5d031fc83f04 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -105,7 +105,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	if (!pte)
 		return -ENOMEM;
 	do {
-		if (!pte_none(ptep_get(pte))) {
+		if (unlikely(!pte_none(ptep_get(pte)))) {
 			if (pfn_valid(pfn)) {
 				page = pfn_to_page(pfn);
 				dump_page(page, "remapping already mapped page");

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240814-fix_vmap_unlikely-2973d2cb904b

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



