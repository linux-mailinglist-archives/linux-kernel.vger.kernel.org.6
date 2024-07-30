Return-Path: <linux-kernel+bounces-267869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE49417D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E341828499D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7C318B470;
	Tue, 30 Jul 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CPmxrc49"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569ED183CDF;
	Tue, 30 Jul 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355963; cv=none; b=nW1HiL1MuOp2hBS6KaRO+sDh4qIOnXuHgYCjo7b50SW0SKRHy8/KOMhkfIX7NySQrNaOtHIAuN4MLSXzE3qeQQ1wL2FVaEATvdcOCPs18I0U1I9RsqBkycQWuiGoXJV6H/hjAMvisErIx3yTo+rsqF8UtM1QdYkRTVSJfilzUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355963; c=relaxed/simple;
	bh=s++80n9+rmfOboCZ7B8NazDEUVsaeUfjIsEJqeBwIyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKkvIzgDgok0oOlDpIV0YfvdT9W++k8/CiBzX75Mv67jWCd0ijiANZGG/lZAX3V7aqKi/1G2QWTkYpL92tqyRJKYgY9J/x3luU8ZFswugKlvFIrHfE42NU7CdbNcKQzJonCheVqLjckX1dRz3JifJCWCK7zgDuuwbhKD+DfyHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CPmxrc49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFACBC32782;
	Tue, 30 Jul 2024 16:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355963;
	bh=s++80n9+rmfOboCZ7B8NazDEUVsaeUfjIsEJqeBwIyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CPmxrc49DOFV1+sBzDSH7No3LR9Pr0EFc2j9sPVIBaIPKHEHfSSbRTS6Kzj+GJOul
	 BrId1mlkjqbRczONu/pe05OEIEoWlEiBAMS5tRgYgY/S0IcjviDNLND11f4w5rR8k/
	 pSinCd1QklHXLfG9J1bySVCwFsdonXpXmZfE7VEc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: corbet@lwn.net
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michael Dolan <mdolan@linuxfoundation.org>
Subject: [PATCH 2/2] Documentation: embargoed-hardware-issues.rst: add a section documenting the "early access" process
Date: Tue, 30 Jul 2024 18:09:32 +0200
Message-ID: <2024073035-bagel-vertigo-e0dd@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024073032-outsource-sniff-e8ea@gregkh>
References: <2024073032-outsource-sniff-e8ea@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 78
X-Developer-Signature: v=1; a=openpgp-sha256; l=3824; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=s++80n9+rmfOboCZ7B8NazDEUVsaeUfjIsEJqeBwIyM=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkrBeyFuefarT5yjmfpl7igs7/W7pyok3y4Kzdpnb+wq /D5CX3tHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRKZMZFpxf8aj8yyS1rUus 5POOxsaKn5hnEMkwP2q1QtVs+512QUc3B4Uy1H68xXN7MQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Over the past years there have been many "misunderstandings" and
"confusion" as to who is, and is not, allowed early access to the
changes created by the members of the embargoed hardware issue teams
working on a specific problem.

The current process, while it does work, is "difficult" for many
companies to understand and agree with.  Because of this, there has been
numerous attempts by many companies to work around the process by lies,
subterfuge, and other side channels sometimes involving unsuspecting
lawyers.  Cut all of that out, and put the responsibility of
distributing code on the silicon vendor affected, as they already have
legal agreements in place that cover this type of distribution.  When
this distribution happens, the developers involved MUST be notified of
this happening, to be kept aware of the situation at all times.

The wording here has been hashed out by many different companies and
lawyers involved in the process, as well as community members and
everyone now agrees that the proposed change here should work better
than what is currently happening.

This change has been approved by a review from a large number of
different open source legal members, representing the companies involved
in this process.

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Michael Dolan <mdolan@linuxfoundation.org>
Signed-off-by: Michael Dolan <mdolan@linuxfoundation.org>
Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../process/embargoed-hardware-issues.rst     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
index 2b34bb6b7cda..daebce49cfdf 100644
--- a/Documentation/process/embargoed-hardware-issues.rst
+++ b/Documentation/process/embargoed-hardware-issues.rst
@@ -219,6 +219,37 @@ List participants may not communicate about the issue outside of the
 private mailing list. List participants may not use any shared resources
 (e.g. employer build farms, CI systems, etc) when working on patches.
 
+Early access
+""""""""""""
+
+The patches discussed and developed on the list can neither be distributed
+to any individual who is not a member of the response team nor to any other
+organization.
+
+To allow the affected silicon vendors to work with their internal teams and
+industry partners on testing, validation, and logistics, the following
+exception is provided:
+
+	Designated representatives of the affected silicon vendors are
+	allowed to hand over the patches at any time to the silicon
+	vendor’s response team. The representative must notify the kernel
+	response team about the handover. The affected silicon vendor must
+	have and maintain their own documented security process for any
+	patches shared with their response team that is consistent with
+	this policy.
+
+	The silicon vendor’s response team can distribute these patches to
+	their industry partners and to their internal teams under the
+	silicon vendor’s documented security process. Feedback from the
+	industry partners goes back to the silicon vendor and is
+	communicated by the silicon vendor to the kernel response team.
+
+	The handover to the silicon vendor’s response team removes any
+	responsibility or liability from the kernel response team regarding
+	premature disclosure, which happens due to the involvement of the
+	silicon vendor’s internal teams or industry partners. The silicon
+	vendor guarantees this release of liability by agreeing to this
+	process.
 
 Coordinated release
 """""""""""""""""""
-- 
2.45.2


