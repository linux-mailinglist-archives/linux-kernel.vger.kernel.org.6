Return-Path: <linux-kernel+bounces-521106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A9BA3B43D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBCE174F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF531DF980;
	Wed, 19 Feb 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKw86eO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554C1DB92E;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=Dj84q07Rcft3jXZHmjx8E7QKPPDLw9cua9HlL0BK0Ai6uRVKm30B8FeOQgvlxVvajkRpQ4DwZFV4ywmZVrcpSc6xBnSYdSMpGMpCOoXZkrXkCu7eN4Cl0KW9XPuJ4BpaQpP3HxlpqaRCtyGd/T4vZUhgwJotdpdJhCBqj+gt8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=ojXYm2ybn18UU1+Rz9pniQpO3g763W9s/DzLh/PxuxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7Is3Nei/V7whNXEGlLDtg0u04u/SsUZyG/gI4b3wtMYo1NVyQxlu5tknChSW1TUNbd1a5nSNc3gLKQaw7JZRIDq9RZr8cENyyEDlBEGNbXde64E2LQR08VktfuarTkOFhVhXP2Nk9MH7s2jgbw66zbCswf6Zu4PIe9qYdkW8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKw86eO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F737C4CEFF;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=ojXYm2ybn18UU1+Rz9pniQpO3g763W9s/DzLh/PxuxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKw86eO60YukQMLJ7wic2bN+mODdww9MFBlG8Yg8Nw9PkaYt92lGwLikxI8xzRtpI
	 4EjkwzS6+Li2GZC6nh7zI7R1ZE1Ozo2gfv1B+F1ZLpyybotFhae/VqkedE3ct7h3BK
	 E4GCcdhvOyuqHVDAO4sO3oR3J/oAU9LVd92x9pURtt24ngBSJWaEWL9dl6+U9yShJR
	 ZkrhL04HrmPbiNmAZZvwmGHPHEo0fUNQbpcPMYhlLhl8SR+JTN1B/qyrdqYgMaSPjx
	 uToyWuNoCXAt5v+M0obdkmUc8hUvHz3LPzwp4nSOYYAh6UsLASkSodISURI8CUqnzF
	 EN5cSE888CJYA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv4n-0ZdU;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/27] scripts/kernel-doc: add a symlink to the Perl version of kernel-doc
Date: Wed, 19 Feb 2025 09:32:24 +0100
Message-ID: <21857431e7cb0b53e21259e7dd999ce50920e0d3.1739952783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739952783.git.mchehab+huawei@kernel.org>
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Preserve kernel-doc name, associating with the curent version
in Perl.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 scripts/kernel-doc

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
new file mode 120000
index 000000000000..f175155c1e66
--- /dev/null
+++ b/scripts/kernel-doc
@@ -0,0 +1 @@
+kernel-doc.pl
\ No newline at end of file
-- 
2.48.1


