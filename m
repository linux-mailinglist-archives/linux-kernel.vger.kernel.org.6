Return-Path: <linux-kernel+bounces-521097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90176A3B436
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C423B00B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A541DF25A;
	Wed, 19 Feb 2025 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW87f3rO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3FE1CEAC3;
	Wed, 19 Feb 2025 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953972; cv=none; b=mQbUjMxZAmYw7sQ70mMv6gwWHpD9L0YsTF8h06jPr5lR1IZjaHZD6Y7WdMPU51I3gZyKOOqR77WKMwqOGHTzGBme1J9tjsCmU9Z5M2WJJIA5sbaVowZEHFXAEcgcmpMK5508/CRJN7dHdovGudaPwy7ajRFRZ7qIuw2pXqN+sqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953972; c=relaxed/simple;
	bh=o+1xc6xKU/lADwcvw9syISNuAVlcBEcy5nbY0N3w4kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3ePcNYcy9AXhnM+PvXEQEbwuSBo6MCfiKBu7+4e3vuZgNzvgmVNWE3nKJZ6cweXKZDdPaxqzuN2iyFbfV5fg5wD6jM5B34PVWQxujB7SlGKEyx/ut4bDSAwW8HeJtWslckJ5+43pXYOvgP7I+f0rJGTzBKJrQ/39zpbaecRc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW87f3rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE73DC4CEEC;
	Wed, 19 Feb 2025 08:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739953972;
	bh=o+1xc6xKU/lADwcvw9syISNuAVlcBEcy5nbY0N3w4kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BW87f3rOoOH+5hXco+hAjc/XgauazXzSPXWPdYnovT3YGvtx/gXgB8S5H5dGnAbU7
	 Y5Hi60/+8kjez3kfnd87VWbbJNOpiZ2EkZrawW/BEHbO0pWG60t3O9ifPb+gtDmZ1D
	 xAz4godOY6VqhLL6XT8va15kXSkUyO3qhmaIt6fMAlG4Pohc4gSDUFvpsV9EgC7eb0
	 P6+v6bNQtjM20nkKFLT9qcMyXaxDU8uUqYbMKQg0kUkpHsRU26Gi6lG8t03/mK7vDi
	 4LuiLKinCID3oNr33BSTuXIKT53CB5GCNgS8hGgkqed+AkNoxM8zqSM3oTISSIJgL7
	 r1WnfC/wIMFqg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tkfVi-0000000Gv4f-0M0d;
	Wed, 19 Feb 2025 09:32:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/27] scripts/kernel-doc: drop dead code for Wcontents_before_sections
Date: Wed, 19 Feb 2025 09:32:22 +0100
Message-ID: <d7f83274d7039a17761d95cb721aba23140f42a6.1739952783.git.mchehab+huawei@kernel.org>
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


