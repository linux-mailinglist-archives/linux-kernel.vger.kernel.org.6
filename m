Return-Path: <linux-kernel+bounces-521099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B71A3B437
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FA43B018E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0161DF25D;
	Wed, 19 Feb 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1P46Odl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D31D416E;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=gT8ksfC0u/TatgN2NRm2wlhDOmYddt5Eqi9tLC/cc/BymcZEkbWC62v99oYjLuchdvp9c11azU//L9ItV4dlmk2DECYxN3C56I4EMTK0Vmcdq/uLT96isySX2SaABiQdyifmJ9M+g79My6ameBNfqK5aoSVFXDk2B0zcquVjNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=yvf7sytYLZ4Yo2xKDIwz8bS24pWVxbZ/2mOY1uefT38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u14y8BHaBvWV70opz2fHp3qlT2a4cw0RZYeIk4+tmiuqkl+y9Er5tX3j1YBLC9msenfwrqT1j5DHS8SqcURWFLNXIeQk/iEev5cHfBF6w1ES5AOWeMjEHBTpBvSBA4rjaIqDnzkLRCpZTHNCZkiXe83xBzHj74StOXaR1Qzey/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1P46Odl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C10C4CEED;
	Wed, 19 Feb 2025 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=yvf7sytYLZ4Yo2xKDIwz8bS24pWVxbZ/2mOY1uefT38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1P46OdldTj+xPr9+6Os6i9blKx/Kq1f3xm8D6hiXLxAecHgY+vuumVmhTBwzxJhc
	 JV8XpFDkxAEyAVdQFd0wozw5FNg3ii2udEiuu9wJX2YKmasGoIzFkxgOhN7GzAHYUW
	 8AuscBWfZfK6Do8Ro85rhSBSNWdlIuRs6orhmxfvWAVuXN8b2XyFfdKH090NvBlRLe
	 aEkod/dnj3ASH0NYZ9z1Dv57otJKBT6oRouQ83yCS2Y5Rtyd53nuj6J46FV9hSPMUe
	 J1OlBtzI9eIs+Crh/N+dGuM0piyBqHtAXl+3leRs7/ye0YRkxhxPI7YsliyzdcdkF8
	 8GdL2uFeXL7Ew==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv4b-0FWK;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/27] scripts/kernel-doc: don't add not needed new lines
Date: Wed, 19 Feb 2025 09:32:21 +0100
Message-ID: <e1e658a35a9a21a182e05e6af403442faf1351df.1739952783.git.mchehab+huawei@kernel.org>
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


