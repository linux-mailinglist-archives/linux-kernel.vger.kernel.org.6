Return-Path: <linux-kernel+bounces-510539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF97A31E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753913A8F90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4113B1F8937;
	Wed, 12 Feb 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahr1P44G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5D2AE69;
	Wed, 12 Feb 2025 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340191; cv=none; b=mIO8/pFTHCemkf//ihptJsqNyV1OsVQIrAyN4Z4SnDsz6hb5PIYYnPeJ4y1CFOykbx0ahbrjUv6GVceJCT3IRjGq+LbaIkvqTRhRLJJAdQxwSYg76D9yeYxuQPpr6d+qnFSqgDM+ppDvEWHuhW3TVfJBeqv21l/CZN5TIk37kAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340191; c=relaxed/simple;
	bh=AbtiWm7KrQwGR0dmAQH/R+3c6zbpBrPp9XhZWqZGL9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSUXdFdWNUVMy4YE3MyIY0Mxlk/BDCZFapFiSnOsnnLJB0iL4dNNUVewMCbP+vM7d/49KCvC1kaiyWxy4GTYoSyrQK6ZJeyCMwcRWQcB50cn7qSZfWqUlkyIEmoORBXMjjaeZp3dtfh6QfzPIC4Tu+nFGNPtwwM2K7UEJWS14L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahr1P44G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE708C4CEDF;
	Wed, 12 Feb 2025 06:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739340190;
	bh=AbtiWm7KrQwGR0dmAQH/R+3c6zbpBrPp9XhZWqZGL9c=;
	h=From:To:Cc:Subject:Date:From;
	b=ahr1P44G85GHvYzMrlmjMXxg4h5XSr1xR7jQy5B676/WTEF5IN7FTVuVVZb1fljat
	 mAV2ytY04Hi4L99oILqDkDbwJF06/VHYRluPFQ78/AEOmYDMFk0dCnVcEGmbPfTJ+O
	 pYQSrcDvhZo46Gbwyxca/M4o11EQJsJKHVDUwpNg3GjDbwFf4NhW61R3aFGEllRoa1
	 i80D/HTcxyRl2eri0uDKRFdR4FPKZ+qY3/nFjF5s8xoK4jrYBdk+jkSmZO+OxugPuX
	 dAJdQ5xhdiDXLWqHu7qIBts9RgUZ4tZqyKdqa32i1FGMmHjcHL3m7nNWD1orZptTHO
	 fYnm28JNMwQgw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ti5q0-00000009L1Z-3QCx;
	Wed, 12 Feb 2025 07:03:08 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/kernel-doc: remove an obscure logic from kernel-doc
Date: Wed, 12 Feb 2025 07:02:52 +0100
Message-ID: <fd3b28dec36ba1668325d6770d4c4754414337fc.1739340170.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Kernel-doc has an obscure logic that uses an external file
to map files via a .tmp_filelist.txt file stored at the current
directory. The rationale for such code predates git time,
as it was added on Kernel v2.4.5.5, with the following description:

	# 26/05/2001 -         Support for separate source and object trees.
	#              Return error code.
	#              Keith Owens <kaos@ocs.com.au>

from commit 396a6123577d ("v2.4.5.4 -> v2.4.5.5") at the historic
tree:
	https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/

Support for separate source and object trees is now done on a different
way via make O=<object>.

There's no logic to create such file, so it sounds to me that this is
just dead code.

So, drop it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e57c5e989a0a..70da9a3369c6 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -179,7 +179,7 @@ my ($function, %function_table, %parametertypes, $declaration_purpose);
 my %nosymbol_table = ();
 my $declaration_start_line;
 my ($type, $declaration_name, $return_type);
-my ($newsection, $newcontents, $prototype, $brcount, %source_map);
+my ($newsection, $newcontents, $prototype, $brcount);
 
 if (defined($ENV{'KBUILD_VERBOSE'}) && $ENV{'KBUILD_VERBOSE'} =~ '1') {
     $verbose = 1;
@@ -2005,10 +2005,6 @@ sub map_filename($) {
         $file = $orig_file;
     }
 
-    if (defined($source_map{$file})) {
-        $file = $source_map{$file};
-    }
-
     return $file;
 }
 
@@ -2403,19 +2399,6 @@ for (my $k = 0; $k < @highlights; $k++) {
     $dohighlight .=  "\$contents =~ s:$pattern:$result:gs;\n";
 }
 
-# Read the file that maps relative names to absolute names for
-# separate source and object directories and for shadow trees.
-if (open(SOURCE_MAP, "<.tmp_filelist.txt")) {
-    my ($relname, $absname);
-    while(<SOURCE_MAP>) {
-        chop();
-        ($relname, $absname) = (split())[0..1];
-        $relname =~ s:^/+::;
-        $source_map{$relname} = $absname;
-    }
-    close(SOURCE_MAP);
-}
-
 if ($output_selection == OUTPUT_EXPORTED ||
     $output_selection == OUTPUT_INTERNAL) {
 
-- 
2.48.1


