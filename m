Return-Path: <linux-kernel+bounces-528489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F644A4184B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF211895610
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E935224A076;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU4H75v9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E9245018;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=pCu80fOpjZNsnhBZDWuEVtwb0EQAtWQfLmDzs/zQlqyGKXVtXpB4thDBTRw42z0M8Omv+wSIm7iuCGf32URZlHugAA5L/G3lO65WTOwOiXNfbm9xaT+aYKc70Gz8gsv45er007OpEwkdcp0n76csYaiOxKEU5bRdenVhhmWMFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=yvf7sytYLZ4Yo2xKDIwz8bS24pWVxbZ/2mOY1uefT38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vt+goMIrfvw306wYfbUoWNSmTcOYqedTDiGXpDw9XvbkeCNv3bektINDUPb7LcG6OFrpB3cQ+tjQ/faYyvhauUJwxj8ewb1O9Jnrphgga/HhsKwWjIlohuGsKIQpQtnvoWdOYJSZ1LFnZrPVFiFmaPEP6UvF3Zo/1YIg+OcY9UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lU4H75v9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7207C4CEEB;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=yvf7sytYLZ4Yo2xKDIwz8bS24pWVxbZ/2mOY1uefT38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lU4H75v9JaktPHhJiCK+DSMdgiPZGmwv8v6gIUYcDgCClPS+aIks6D4DpvRNqbNwc
	 JIMI+K8Mk7n04jJkl8kWmOPKtOlOFjjmM6vnuZqgTx0SkQUFYnCfaUl3+cLAUhK/rt
	 N5m5RtyVyoxjCwi0NyQnezMZnS73SUsGZQY7dtG1nkx8om9aEh9MwEYTI83QAI+/kI
	 mF7Q0GVWkklzlJgLfk6W4x5s6Sozmr0RN3DwWAvVwYh9T+ip8m3w8Eb5X1VPZqTyXf
	 U4wt7O24xBREmxkcDmsFGNB1za7c0kKtjkokZGM2Sp/ITtoFH5YAaGIl3W/JOtv0pO
	 ExNPnBmeERzVA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUSS-00000003p3k-3rKn;
	Mon, 24 Feb 2025 10:09:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/39] scripts/kernel-doc: don't add not needed new lines
Date: Mon, 24 Feb 2025 10:08:11 +0100
Message-ID: <6b036ef7d746f26d7d0044626b04d1f0880a2188.1740387599.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This helps comparing kernel-doc output with the new .py version
of it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2c77b914d017..d59552e1a31d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -760,6 +760,10 @@ sub output_highlight_rst {
     if ($block) {
         $output .= highlight_block($block);
     }
+
+    $output =~ s/^\n+//g;
+    $output =~ s/\n+$//g;
+
     foreach $line (split "\n", $output) {
         print $lineprefix . $line . "\n";
     }
-- 
2.48.1


