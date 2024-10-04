Return-Path: <linux-kernel+bounces-351177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C039990E35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9632B21E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6AB1DE4D8;
	Fri,  4 Oct 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKRoiBJH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7C1DE4C2;
	Fri,  4 Oct 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066556; cv=none; b=XD9Q2UIRXRrj1PcA1UbOXL6BmDmHH7La4GC8K8fC6HM3YhjfYEWAERN48mtoi94Vfwykoqzsfa4TD+XZ8zlPuxcobyrB+xYkl2o3RG3lRi0EqxGUHR+3SsF7TwQBylP4D2EryeI/OTffAky9K7EqwXkyK+LKx8WIZ6dCe4WLN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066556; c=relaxed/simple;
	bh=S1cH/tUhi9S86Jke06n4nZxyL1wuLzEaKDUuNPUUZfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4uVvI6BxKoTyARzdiViaxBXv9NPiWTZ24uOIa9kB96H8HElogwb48GV+91g05PXJFNqJ2uoWT99W2ySnFVymnabcnyl51AmxnRYzVZXypIxTc9C4OKSe0I5JZNw+St7s2yxkridY4fPqufEbQBmysKqk7lY2UosZuQ1B6dd7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKRoiBJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D682C4CEC6;
	Fri,  4 Oct 2024 18:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066556;
	bh=S1cH/tUhi9S86Jke06n4nZxyL1wuLzEaKDUuNPUUZfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKRoiBJHQppPJiyM0jOo8tF93j2hfkHIft7LDI8ZFhk1MqHq6+mn83RP4bVRiDcq+
	 z9Pke5ebgvgYi8djt3lafj41TwFwVjk6WtGYfDqGSw4q8alAE5vSb6bKvB26Wf51eQ
	 /1FqvBDcHYcyNplm0sw4h+9uyYgwpR08CPsKVcjvYaWOCXdY6rZNmFdkqJb9jUqPQL
	 1W+rTQ3W/7Png0jvefYcba85IL3N7BW1G2GM4IdYdhCLFWcxBYsgtPhk6HKFKMMfuP
	 mYlOZZDN/HEnHGq7ZMcNaejXsBMMLt1CRg76W8HPfcP8qVCyFomGPQHnfCRpaHJ0x7
	 M6WZaKF2RZLfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 12/31] ktest.pl: Avoid false positives with grub2 skip regex
Date: Fri,  4 Oct 2024 14:28:20 -0400
Message-ID: <20241004182854.3674661-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Daniel Jordan <daniel.m.jordan@oracle.com>

[ Upstream commit 2351e8c65404aabc433300b6bf90c7a37e8bbc4d ]

Some distros have grub2 config files with the lines

    if [ x"${feature_menuentry_id}" = xy ]; then
      menuentry_id_option="--id"
    else
      menuentry_id_option=""
    fi

which match the skip regex defined for grub2 in get_grub_index():

    $skip = '^\s*menuentry';

These false positives cause the grub number to be higher than it
should be, and the wrong kernel can end up booting.

Grub documents the menuentry command with whitespace between it and the
title, so make the skip regex reflect this.

Link: https://lore.kernel.org/20240904175530.84175-1-daniel.m.jordan@oracle.com
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: John 'Warthog9' Hawley (Tenstorrent) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 449e45bd69665..99e17a0a13649 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -2036,7 +2036,7 @@ sub get_grub_index {
     } elsif ($reboot_type eq "grub2") {
 	$command = "cat $grub_file";
 	$target = '^\s*menuentry.*' . $grub_menu_qt;
-	$skip = '^\s*menuentry';
+	$skip = '^\s*menuentry\s';
 	$submenu = '^\s*submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
 	$command = $grub_bls_get;
-- 
2.43.0


