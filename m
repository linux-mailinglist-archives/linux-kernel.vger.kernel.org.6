Return-Path: <linux-kernel+bounces-547368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3420A50650
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0D01714BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8BA250C0E;
	Wed,  5 Mar 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrL1Jir0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1224CEDF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195631; cv=none; b=XawCm0SNuU3RU7aMDCTyJPd7t7QwjzhP8VVGAEj4pQFBmzip/JujiUWU5LbuTECCTNNFVgZcX/vysB7Ujrq0BdvdiYjasY8uiyr5DW/P06yDXQgS5QlTqsY2hcrunlQv69AMF1PcDJXD1DP2fHGJ6cJyuwhpJ8XK8jL9ZBoDLDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195631; c=relaxed/simple;
	bh=RisxFpFmnEqsk120dUhp7R0608Lgy53D2nNT5acAd+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2ZtdUw4aJuk2xeXx9nplnwrXr/wWqtNhqvRXDh2XCG/AErheWI31MNx2K5ivILFPIRsZjYtZlovp3lU7pgrfw8aZeqKnCCI+GwChhS6DvHAKTh0WPA/cUDomotcFmjf+tWuizadArEaRL+wI9ddQQdiAb+n6IajWLshDM/AzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrL1Jir0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74491C4CEEB;
	Wed,  5 Mar 2025 17:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195630;
	bh=RisxFpFmnEqsk120dUhp7R0608Lgy53D2nNT5acAd+I=;
	h=From:To:Cc:Subject:Date:From;
	b=JrL1Jir0XgycKVrTblDyxxUrW2lSnFiYVw76F94yo35+mA3XlQ6xnwemkw3TbIYGt
	 sSHlTHvSL+NDc85DicpFScsiMUtzqdHIvayaa0BrJ6YiLioJ4cvJ9GIsMPLjgD0Ai4
	 ZoLTEwpQ+m3Uz+Me6XY9T3MgDRtBe+jaexBwOQuBnGUXA++RbLzh7h3VxPfVM7ez+Z
	 Zs4z+LzKWEJZpWXsqWqih/cEivce/C1pLg4TaA6G6oqk0RhtN2oysNE0V5G4sU6OR8
	 +6RaTRKVB8eH1VEByXnrB/NM1HtjsnvSYdvPDcHjkL1/p4qDHr3DhzI4weRQ6/vxiD
	 Ri3Thb5a0SY6w==
From: Arnd Bergmann <arnd@kernel.org>
To: David Disseldorp <ddiss@suse.de>,
	Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs_test: mark testcases as __refdata
Date: Wed,  5 Mar 2025 18:27:01 +0100
Message-Id: <20250305172707.3418080-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The testcase calls an __init function, so it must have a corresponding
annotation:

WARNING: modpost: vmlinux: section mismatch in reference: initramfs_test_cases+0x0 (section: .data) -> initramfs_test_extract (section: .init.text)

As with other kunit tests, using __refdata suppresses the warning without
annotating the structure itself as __initdata.

Fixes: b6736cfccb58 ("initramfs_test: kunit tests for initramfs unpacking")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 init/initramfs_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 6231fe012583..3539891ae081 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -387,7 +387,7 @@ static void __init initramfs_test_many(struct kunit *test)
  * The kunit_case/_suite struct cannot be marked as __initdata as this will be
  * used in debugfs to retrieve results after test has run.
  */
-static struct kunit_case initramfs_test_cases[] = {
+static struct kunit_case initramfs_test_cases[] __refdata = {
 	KUNIT_CASE(initramfs_test_extract),
 	KUNIT_CASE(initramfs_test_fname_overrun),
 	KUNIT_CASE(initramfs_test_data),
-- 
2.39.5


