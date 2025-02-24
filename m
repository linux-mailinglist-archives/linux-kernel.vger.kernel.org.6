Return-Path: <linux-kernel+bounces-528521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D573DA4188B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375D33B9490
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C692586D0;
	Mon, 24 Feb 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1qu1IiW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214824BBF0;
	Mon, 24 Feb 2025 09:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388144; cv=none; b=A3VpHzd17A276aEJwo6zR6VByPlab7ZnXLdLvqnkhBK+TnjNH2bCIdj8MLsKg+X7kEVglrwFOHsm5sJ8tC0D+YH0VOMzXqQp2boimTd4TIDmkuFCVeViZMBW0YOHVc+sxA5ZYm6qakXE6PG4PiTnryb+IFbcuvhhrf2fmdORkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388144; c=relaxed/simple;
	bh=dA/lwXoRISFanQzES1j4+YBcD/qyLfU1x/1xle+1MdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwEF6+gF6mRtrC6Tr1QPzngRCI/NhD9hgwVRsONWyEWtQNk68JOescXfwEXlosvpt4uNFh/j1YuuOsN5Yrzyl41Huov6QVhATu8bOb/5PkVGPusLh/RNIPt8AgRtSRUs2/nMhlU9RkU8s9b80T5pSm/r9WgmNE59xmcaZcnOvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1qu1IiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A117C2BCC6;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388143;
	bh=dA/lwXoRISFanQzES1j4+YBcD/qyLfU1x/1xle+1MdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1qu1IiWGCGCgSi8NxNsQqFqHYTxZx5GQab2cZ8n4BrUUM/J+yZyeJIDaQNRAykcR
	 bCh+6QTRQUonMyP4doygMsjjz7vu/1ehWsSq/eCA+qr0kSuCRaaV8LGHBtx9iCdJLs
	 fe5R/Ij3TCxcKe0fN2jU9JvuU74Q9LhVQGe7XZiY2wfSbW2L2AK9ej3Z89AXUrTCzk
	 p/fgr4lvxBd7lGj5a3Ti0uwwJtgqFau5dbjMsAT15QVPZTFVriAFZQ1awNYTuRiu13
	 Dxcw8InNDVPBYSAKF7VkM1s3Ei69ZX5aUelLsxPtkJ4z6NwN+wk1B0/nGAwZHXz7Sq
	 e7oZXtBvNoGSA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUST-00000003p5n-3CKt;
	Mon, 24 Feb 2025 10:09:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/39] scripts/kernel-doc: switch to use kernel-doc.py
Date: Mon, 24 Feb 2025 10:08:42 +0100
Message-ID: <67b7ece3fae241361e0ae2fdd1536b34dbacf8b2.1740387599.git.mchehab+huawei@kernel.org>
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

Now that all features are in place, change the kernel-doc alias
to point to kernel-doc.py.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f175155c1e66..3b6ef807791a 120000
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1 +1 @@
-kernel-doc.pl
\ No newline at end of file
+kernel-doc.py
\ No newline at end of file
-- 
2.48.1


