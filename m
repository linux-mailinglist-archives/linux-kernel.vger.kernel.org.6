Return-Path: <linux-kernel+bounces-528495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDFAA4186D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7061E1897B72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284C02528FA;
	Mon, 24 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2r7O0oW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506724502E;
	Mon, 24 Feb 2025 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388143; cv=none; b=boj20LlHZvgHgSLhZRQCJ7uuwH+Nu+w36IEGSR745cvIPQMZpq7/BkV2jMvnRbERXUg6MF3DHFfAPaTOEsrOBM3E/O5pwYpAe+mqMdhJFg4Djc8JPQWjZvfN6k4oSne5/2rvAxqQOV1MgpWa61mCog9LOGuTekJlC2aS8bYfdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388143; c=relaxed/simple;
	bh=o+1xc6xKU/lADwcvw9syISNuAVlcBEcy5nbY0N3w4kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDYWv8L8+fFp2sQc3vd1JabBrSpwKQYBJejEfIFFRQZCSUB7eO+ZWOgN8PR2jrMr/McWXGNeshJ4tB7HSPfQYhGyKFqvjWe0Fm5C5xq9QiK9V5tpfviX8MchiTirQ/cL8ZHZwybigaU/mE1odkbzfD9m+dwF9Ntr6QkqbXoIscw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2r7O0oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2923C4CEED;
	Mon, 24 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388142;
	bh=o+1xc6xKU/lADwcvw9syISNuAVlcBEcy5nbY0N3w4kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2r7O0oWeInb6b4ufMZt2RTSkkEqMALf9aH9Gp9F3HbTf5JWVMLj2QkMY79pAQ6wV
	 kB47vnkGkxz7YnHbnhsH7XWEjqsC3+lDdGkUjHBYfiII21hbDJb2HroiiSjO3JXI6i
	 xYtl3V1pRllhgwOAlFPMtbrkTxo4Hn2dWP6AP6v9IaK4Gr7o7H8ljE8WtdL1RYzwXZ
	 aKAwXDZl+7VmkPBV0a1tsLqbQSpq9QWisaKcOf077diMwVFW/ypk416GKsN3g8+HS8
	 F6y0yLOmm7YTbh3qO/hXLB6AG/TG0b7Ct5A3cgQxKNw3GW+Bs4LvB7ybgcaUSQCCfn
	 BxPnG/6L3WbDQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tmUSS-00000003p3o-3zXF;
	Mon, 24 Feb 2025 10:09:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/39] scripts/kernel-doc: drop dead code for Wcontents_before_sections
Date: Mon, 24 Feb 2025 10:08:12 +0100
Message-ID: <174a15607fd057c736dc9123c53d0835ce20e68b.1740387599.git.mchehab+huawei@kernel.org>
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

There is a warning about contents before sections, which doesn't
work, since in_doc_sect variable is always true at the point
it is checked.

Drop the dead code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index d59552e1a31d..af6cf408b96d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -137,7 +137,6 @@ my $verbose = 0;
 my $Werror = 0;
 my $Wreturn = 0;
 my $Wshort_desc = 0;
-my $Wcontents_before_sections = 0;
 my $output_mode = "rst";
 my $output_preformatted = 0;
 my $no_doc_sections = 0;
@@ -223,7 +222,6 @@ use constant {
     STATE_INLINE        => 7,        # gathering doc outside main block
 };
 my $state;
-my $in_doc_sect;
 my $leading_space;
 
 # Inline documentation state
@@ -332,12 +330,9 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
         $Wreturn = 1;
     } elsif ($cmd eq "Wshort-desc" or $cmd eq "Wshort-description") {
         $Wshort_desc = 1;
-    } elsif ($cmd eq "Wcontents-before-sections") {
-        $Wcontents_before_sections = 1;
     } elsif ($cmd eq "Wall") {
         $Wreturn = 1;
         $Wshort_desc = 1;
-        $Wcontents_before_sections = 1;
     } elsif (($cmd eq "h") || ($cmd eq "help")) {
         pod2usage(-exitval => 0, -verbose => 2);
     } elsif ($cmd eq 'no-doc-sections') {
@@ -1963,7 +1958,6 @@ sub process_export_file($) {
 sub process_normal() {
     if (/$doc_start/o) {
         $state = STATE_NAME;        # next line is always the function name
-        $in_doc_sect = 0;
         $declaration_start_line = $. + 1;
     }
 }
@@ -2068,7 +2062,6 @@ sub process_body($$) {
     }
 
     if (/$doc_sect/i) { # case insensitive for supported section names
-        $in_doc_sect = 1;
         $newsection = $1;
         $newcontents = $2;
 
@@ -2085,14 +2078,10 @@ sub process_body($$) {
         }
 
         if (($contents ne "") && ($contents ne "\n")) {
-            if (!$in_doc_sect && $Wcontents_before_sections) {
-                emit_warning("${file}:$.", "contents before sections\n");
-            }
             dump_section($file, $section, $contents);
             $section = $section_default;
         }
 
-        $in_doc_sect = 1;
         $state = STATE_BODY;
         $contents = $newcontents;
         $new_start_line = $.;
-- 
2.48.1


