Return-Path: <linux-kernel+bounces-512878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB0A33EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC296161FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F90221576;
	Thu, 13 Feb 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc+AlMlx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC021D3DD;
	Thu, 13 Feb 2025 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448388; cv=none; b=WqWawHf4K7dBEzJhCcOm47fyIlPaKmge2rAoPUXdSkKHla4Xuglfdcn5aIG0MhektathkOpU3WhwhTsZXHUqZHp2qaALWs/0U2nqZMzwmJu6zwGlGs66h3HVlK9JgaKDRODUKkmQmngCxH7+VcWZv4CaP2eUt6WeJQpv1G/DAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448388; c=relaxed/simple;
	bh=AbtiWm7KrQwGR0dmAQH/R+3c6zbpBrPp9XhZWqZGL9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONqnop8c8osSGNXg5Xpiw1kFe1Mbh0kMaE6CUaJCSjpcdUcDczSJeAsliCWvi/wsoUBIA9ZZ1u3z/nQLN8kRoGCoqoHF23/Bd2jr4K4Rk0i+CblVd/PDzWgzfJI0ftMUdMGVMjp2v0e+mnHLZhcvV2cdi2w6aTRsZoV3pR0i1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc+AlMlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF777C4CEE7;
	Thu, 13 Feb 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739448388;
	bh=AbtiWm7KrQwGR0dmAQH/R+3c6zbpBrPp9XhZWqZGL9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fc+AlMlx23kPbg+1fjwaxv8a3tTB2B+A8MgSZtThj2W60xr/Vu9rtG7voWbJl1aa1
	 sBYc424nnK+QXpT38doNydnbI8K87mW2PC432N0ltUgxXUyq8ytUd3HXY+qKxywoQC
	 8n4UbdtCDm26LBV+4nt92QgO0lr5yLOhdlb92vfTiJ4KAsqERBIy4Uk7LSdmczVvz7
	 KbjHHyT+lkDUxRy5JK03k2sdy+dcHgazq14SHgz6ZlkezBRWTgJsDz/KiQcftVBAfX
	 8atGqglZZRw1CwHwYLwC6WnkdeQLBmUOw5orUwuC/yxDDvPb74mGkCtY76DMCg+TK8
	 YbCiNmOsHIrrg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tiXz7-0000000BIV8-1VDd;
	Thu, 13 Feb 2025 13:06:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFCv2 2/5] scripts/kernel-doc: remove an obscure logic from kernel-doc
Date: Thu, 13 Feb 2025 13:06:15 +0100
Message-ID: <ba4b0d8fbfe8d6cc3a818f0578857369e6d695e5.1739447912.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739447912.git.mchehab+huawei@kernel.org>
References: <cover.1739447912.git.mchehab+huawei@kernel.org>
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


