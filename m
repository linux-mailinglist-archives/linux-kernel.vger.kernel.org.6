Return-Path: <linux-kernel+bounces-287882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC34952DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8EE1C235AA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E061714D2;
	Thu, 15 Aug 2024 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/ICbuHE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4231714A3;
	Thu, 15 Aug 2024 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721888; cv=none; b=NAmkBPHWK3/EZ5y2vT4lXLRRkASwdl/OlTbRveotTyKIFJUVKRABytzf7EH3CIhrhk2XVjugFsoKsp43jPVuI1Y9zYkdMdYWKAHG/TJ7fspEqM9LU3Xfhz4KvpufGd9yrLrAQhTsXrzVdJLRzb8CJg7FAznVzQMA8BxZtpaeaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721888; c=relaxed/simple;
	bh=8Musr8BHJg9qpZBJozkwfuQ/+M+yvTVZ1obEnB8Kt2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LMAZ2nWzQVf/64MFpwfuzNCmox0P+5kkibxawhZgURAcAhY7tGfR5hzEHYyWy71ktuaMVh9PUjIbTrxYKnZyi/AMr99O45tx6bPoo8JMNQHvXYcrJKKiBH2KgODFTp7mp6Rtn6HENfavClPQ7eRf/OmmMSU8a2UXDl3UWAHEC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/ICbuHE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723721887; x=1755257887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Musr8BHJg9qpZBJozkwfuQ/+M+yvTVZ1obEnB8Kt2M=;
  b=N/ICbuHEb8q7p43/lz0P+J6csun/tjdlh8ofykooYv+Qkk69Le42p5h8
   lQsFg4RtbIPqeRJR5d1mUmFrRrfMBOklDFAk06jK6yHGYaFLwf+JxthUM
   flWTUoMKH6llSoUW/jKL8iCjRZWVq9kKj8qCrrxgVrE51AVKhXpmCps31
   uFvF0sEpiE3zhta34pgFxEppiVwVhaoN4CcIKsDfIgHhZwIjZ58S+SyTM
   u29/5xphdeBMXWmbD3EUWBIl01U8HJ3LnVzYUXOHzP3rzdlJFj04T69D4
   rZ4jhGiLkb+dnoy4CGN/7XVpWGTjthkDgnY0Et4MRr/tjgHQ5i3DPPfHm
   A==;
X-CSE-ConnectionGUID: IFmS9e5ETgucxF6vtZrDvg==
X-CSE-MsgGUID: CH8eHbgCTKmUuEGrZUapXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21791345"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="21791345"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 04:35:04 -0700
X-CSE-ConnectionGUID: QbKt3aJmS1Gq4azKnHypEA==
X-CSE-MsgGUID: 7TytNjTyReq1h4YeN9yf9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59354324"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.160])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 04:35:02 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jani.nikula@intel.com,
	Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] get_maintainer: add --bug option to print bug reporting info
Date: Thu, 15 Aug 2024 14:34:49 +0300
Message-Id: <20240815113450.3397499-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

For example Documentation/adming-guide/bug-hunting.rst suggest using
get_maintainer.pl to get a list of maintainers and mailing lists to
report bugs to, while a number of subsystems and drivers explicitly use
the "B:" MAINTAINERS entry to direct bug reports at issue trackers
instead of mailing lists and people.

Add the --bug option to get_maintainer.pl to print the bug reporting
URIs, if any.

Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 scripts/get_maintainer.pl | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index ee1aed7e090c..5ac02e198737 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -54,6 +54,7 @@ my $output_section_maxlen = 50;
 my $scm = 0;
 my $tree = 1;
 my $web = 0;
+my $bug = 0;
 my $subsystem = 0;
 my $status = 0;
 my $letters = "";
@@ -271,6 +272,7 @@ if (!GetOptions(
 		'scm!' => \$scm,
 		'tree!' => \$tree,
 		'web!' => \$web,
+		'bug!' => \$bug,
 		'letters=s' => \$letters,
 		'pattern-depth=i' => \$pattern_depth,
 		'k|keywords!' => \$keywords,
@@ -320,13 +322,14 @@ if ($sections || $letters ne "") {
     $status = 0;
     $subsystem = 0;
     $web = 0;
+    $bug = 0;
     $keywords = 0;
     $keywords_in_file = 0;
     $interactive = 0;
 } else {
-    my $selections = $email + $scm + $status + $subsystem + $web;
+    my $selections = $email + $scm + $status + $subsystem + $web + $bug;
     if ($selections == 0) {
-	die "$P:  Missing required option: email, scm, status, subsystem or web\n";
+	die "$P:  Missing required option: email, scm, status, subsystem, web or bug\n";
     }
 }
 
@@ -631,6 +634,7 @@ my %hash_list_to;
 my @list_to = ();
 my @scm = ();
 my @web = ();
+my @bug = ();
 my @subsystem = ();
 my @status = ();
 my %deduplicate_name_hash = ();
@@ -662,6 +666,11 @@ if ($web) {
     output(@web);
 }
 
+if ($bug) {
+    @bug = uniq(@bug);
+    output(@bug);
+}
+
 exit($exit);
 
 sub self_test {
@@ -847,6 +856,7 @@ sub get_maintainers {
     @list_to = ();
     @scm = ();
     @web = ();
+    @bug = ();
     @subsystem = ();
     @status = ();
     %deduplicate_name_hash = ();
@@ -1069,6 +1079,7 @@ MAINTAINER field selection options:
   --status => print status if any
   --subsystem => print subsystem name if any
   --web => print website(s) if any
+  --bug => print bug reporting info if any
 
 Output type options:
   --separator [, ] => separator for multiple entries on 1 line
@@ -1382,6 +1393,8 @@ sub add_categories {
 		push(@scm, $pvalue . $suffix);
 	    } elsif ($ptype eq "W") {
 		push(@web, $pvalue . $suffix);
+	    } elsif ($ptype eq "B") {
+		push(@bug, $pvalue . $suffix);
 	    } elsif ($ptype eq "S") {
 		push(@status, $pvalue . $suffix);
 	    }
-- 
2.39.2


