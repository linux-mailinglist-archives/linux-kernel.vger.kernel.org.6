Return-Path: <linux-kernel+bounces-191035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620608D05CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F881F243B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6447C16F295;
	Mon, 27 May 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="b3UkZcLJ"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF215EFD8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822162; cv=none; b=L3I0oxv9UWKPRarikQh0I3K2WjE/X/AXZas72i0V1jqNDmsWCekkLPDF0lZDJoPtutrEWUQcncoVyHhffNZY1JE9pAIVYK5kBcxYV4Sq1F1Sd71nufD3vWXWn1pT055DLRqK8aCLnhd9V1k3aDMb6KDsb1Df6/df1thJak0uAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822162; c=relaxed/simple;
	bh=ZcfMiJyaPvcvjXhfFV/nyPzUmJd+dTs0K+agxcaJbBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NPQJh9Nig9yPcodUL9xQuBbqTLBeminbbZwyZn03Bo5673DZJibPRSnNcgfdh7IcgeuXfK8UrriFo814aUgI/U7m/KorfdsdZfXjlI9n8BYGG49pyITlpyhZ8u2oIgjCQluWxDdojIlCMAeOHdNhEVWK/fI7FD59z6lsygQHmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=b3UkZcLJ; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716822151; bh=ZcfMiJyaPvcvjXhfFV/nyPzUmJd+dTs0K+agxcaJbBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3UkZcLJW39/vkf1VZmonAUe6ysAQe8LFeZXSyI409Iv/rfGPy4xxazxDo3Bj7lCh
	 9qCJrvA+vLI3JqZ6jK5pUU8IPwfTy/Z5OoVq6iyBV8OoctwMrhT8jsBIPid4sWWdpc
	 eDHClNSyqwuvcLi5RwH1Nqm9YTBUVFayc+6drxR74Ro+luToqO6e/6RWuLSQIJfMgt
	 0Djm2tVmxa6SLtPJpDua3W1tGhoYoOBdM4AzWmteb/TxZl6Uq5JPhadyaQiHw5ZaIq
	 qlWgZ46xfvYMpGir+aDJ+7FsmqtStezwIW5pLc4qQ/M+BXKNCToSe8Hx9GFolwHzNJ
	 wQc1YKlz1uyhA==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RF2PiT1954007;
	Mon, 27 May 2024 18:02:25 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/8] accel/habanalabs: use device-name directory in debugfs-driver-habanalabs
Date: Mon, 27 May 2024 18:02:18 +0300
Message-Id: <20240527150224.1953969-2-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527150224.1953969-1-obitton@habana.ai>
References: <20240527150224.1953969-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomer Tayar <ttayar@habana.ai>

The device debugfs directory was modified to be named as the parent
device name.
Update the description of 'mmu' and 'mmu_error' to use the new path.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 Documentation/ABI/testing/debugfs-driver-habanalabs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index efbb78bedb8b..3318a14f35b9 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -217,7 +217,7 @@ Description:    Displays the hop values and physical address for a given ASID
                 and virtual address. The user should write the ASID and VA into
                 the file and then read the file to get the result.
                 e.g. to display info about VA 0x1000 for ASID 1 you need to do:
-                echo "1 0x1000" > /sys/kernel/debug/accel/0/mmu
+                echo "1 0x1000" > /sys/kernel/debug/accel/<parent_device>/mmu
 
 What:           /sys/kernel/debug/accel/<parent_device>/mmu_error
 Date:           Mar 2021
@@ -226,8 +226,8 @@ Contact:        fkassabri@habana.ai
 Description:    Check and display page fault or access violation mmu errors for
                 all MMUs specified in mmu_cap_mask.
                 e.g. to display error info for MMU hw cap bit 9, you need to do:
-                echo "0x200" > /sys/kernel/debug/accel/0/mmu_error
-                cat /sys/kernel/debug/accel/0/mmu_error
+                echo "0x200" > /sys/kernel/debug/accel/<parent_device>/mmu_error
+                cat /sys/kernel/debug/accel/<parent_device>/mmu_error
 
 What:           /sys/kernel/debug/accel/<parent_device>/monitor_dump
 Date:           Mar 2022
-- 
2.34.1


