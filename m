Return-Path: <linux-kernel+bounces-376545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840599AB319
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AD21F26223
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B6F1BCA01;
	Tue, 22 Oct 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqlf9Fe/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4981BC077;
	Tue, 22 Oct 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612792; cv=none; b=ZwpJBMcAgSZHEwFmIGXzIZIZpRw06X7wv7Sv4mm7pdkQ5400A+N7GVl633lpg13TcSK4REmdJMl8hvgJryFuZKpKplnABHErUVHeUWuHnjM1C/uki68fgEuvO0tXPvf2U0xb90Wgvao3DggtMZ788p88pvEm7PZYqfJvfnSv+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612792; c=relaxed/simple;
	bh=b82FuBLPKP3F01X5HLQYV4L/cPxtWxQfdRBNQm1O/+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W70dA1kTjosfOmLyQZYNPLmg5/SG6DVp+tWpuIg8+O88tL7Y6rSPIsE1un65ZAZ+pBeCDGo0XkVo3v7erpTu3Z05dmjbVzY4IV4jI9+M5b5PHGk4OAA42jm8Ewzn3wDO8bF7sNpqjOB9ShsA30Wqrsjd7B90y61utt5V1wckbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqlf9Fe/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8DBC4CEC7;
	Tue, 22 Oct 2024 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729612792;
	bh=b82FuBLPKP3F01X5HLQYV4L/cPxtWxQfdRBNQm1O/+0=;
	h=From:Date:Subject:To:Cc:From;
	b=kqlf9Fe/9Ma+6jqXO3MzRI9Pcl5eI09XfwgcYUygNYtEfihHCH49Ieu6S8unqY+ft
	 lBpcVyuPXQ5k4VI6c0AC7g3Ox7wR8vtOd5llcvgCRcjcPnKXcWjpYSUcDqLN7MvL54
	 u3laCiL3LpiUlm3mNWQPYhK2WBN1UA2swSNFlg3D+E4PqcSunz6HLwZy5YaUWDHlUW
	 1k5bJsE8+tsgboZHca176mm90X3GGQpMPenEw7UawR4Suz9LuYZ0pbxlP803aXnEjv
	 bDX/b8U7eQZraK/qy41P3IZBnUxc4I2Ex1ZtMWtwpiGR3BMeNp7pTaF3BKVOTlrod+
	 MHMN0clORn4+Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 22 Oct 2024 16:59:41 +0100
Subject: [PATCH] docs: bug-bisect: Add a note about bisecting -next
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-doc-bisect-next-v1-1-196c0a60d554@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOzLF2cC/x3MTQqAIBBA4avIrBtIsd+rRAsbp5qNhUYE4d2Tl
 t/ivRcSR+EEo3oh8i1JjlCgKwW0u7Axii8GUxura2PQH4SLJKYLAz8XettR64h7NzRQqjPyKs9
 /nOacP+OQR1FhAAAA
X-Change-ID: 20241022-doc-bisect-next-d47c6ace8a95
To: Thorsten Leemhuis <linux@leemhuis.info>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=broonie@kernel.org;
 h=from:subject:message-id; bh=b82FuBLPKP3F01X5HLQYV4L/cPxtWxQfdRBNQm1O/+0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnF8v2hrtl0MvUB2SWMg8hJALTDZRpJsxn8eV+VQoF
 GL/ZWqKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxfL9gAKCRAk1otyXVSH0GffB/
 4wZKnxPSOH5xzPYQO4WpZy7gaN70nlIYPfOL8LTWJiPt6CJMrNiUPOlJ2j5aFyzGH/H6HX4EySiJtR
 Kccr8fOGZicySAMoMFhc0v/LfQpqo2TEI3RXs944vDZ1xonfZUqgQjH4FoLNqv3d10TYkZANA9NvWL
 9Hd0KYsrzLMDQfKsr6NQBFy1WN15zn7HhtWB4RdHQvSyse4VbwkyzdPX4c7GBaKsRp9QPNN129fJQx
 Sp3cQCOH9zk35Fu28IM5keiuuSBPzn3TQh3XdUYoeNGM4aUhyLnClgLs7SuwssLzw9UnL1TqpZy5Dy
 fB1NQXinOMrDLLV0GUBN+16/zJyyF5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We don't explicitly mention anywhere in the kernel tree that bisects
between -next versions won't work well and it's better to bisect between
mainline and -next. Let's add a note about that to try to help people avoid
this particular gotcha.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/admin-guide/bug-bisect.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/bug-bisect.rst b/Documentation/admin-guide/bug-bisect.rst
index 585630d14581c7e0bdf9dd3b66d427793d41925b..eef6921a9542ef276c097e5861ca4efe5812ea0d 100644
--- a/Documentation/admin-guide/bug-bisect.rst
+++ b/Documentation/admin-guide/bug-bisect.rst
@@ -109,6 +109,18 @@ With that the process is complete. Now report the regression as described by
 Documentation/admin-guide/reporting-issues.rst.
 
 
+Bisecting linux-next
+--------------------
+
+Since linux-next is a series of merges rebuilt every day starting from
+Linus' tree there is no commmon history between multiple versions of
+-next. This means that the history of a given -next release won't
+include prior -next releases which confuses bisect if you try to
+bisect between them. Bisects will run much better if performed between
+-next and the commit in Linus' tree which that version of -next is
+based on instead.
+
+
 Additional reading material
 ---------------------------
 

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241022-doc-bisect-next-d47c6ace8a95

Best regards,
-- 
Mark Brown <broonie@kernel.org>


