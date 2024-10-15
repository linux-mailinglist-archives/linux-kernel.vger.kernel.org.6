Return-Path: <linux-kernel+bounces-366409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60A599F4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97F31C22958
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB321FC7CB;
	Tue, 15 Oct 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQeCr7/p"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E8C1F667F;
	Tue, 15 Oct 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015872; cv=none; b=tsEL2nJaxS7wcxPI4BKD0JFJ9DJTtYiOOQZq0LmgjlAPPFNcZIBZ+OtFdifzI3sGOLJi/elQ+rmInieouiNGu0tbp1eSl4hSWr2ATYmZu91muQXG9w18X/Der9dwGy4dJ9W/JMoWARlauiLdrUQmSyUiz7prR4J8Kb32h52aRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015872; c=relaxed/simple;
	bh=XAlwUBAiZ2E3jswvMROzLoftINMnoDe4ju4Zy4isOUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8kldGeeR+vgbelIP1QKTsCc5upf+F+1bfazzSP868A/dXBu5jVhCNyCum3OuveknnJqgs6iQyPh+qUGGGO93Fbr3OqRT1XUfLYtFchI0nfzSh3nzjXpOKXed9hOSQOb02a8wfpubzzRR8s6RME3XeuEX364cXGsncZIHusBw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JQeCr7/p; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=A54Vq6G3DIWEbChUUIbdpVXmCGGWCTgYDROxKPHY1HY=; b=JQeCr7/psRpgMh1ovKaVTzLR5j
	W2FJyUTClN1I02YTCLsOYio+SuytXbiKH9lPqHD8cLmMvM220me/FLO/WCxsbKriNNTMMskFbiJei
	annwr8bBqOlRhPna6JBKd8s0n7VrUGO50oibjYjEgKftqoLxdmdvKFMkYJQhZTNUeNtHAXh+UC4FB
	vW3rH7C3jWp/qdMK/1/aC+klImRw0dolua+mTg/hyKdKu12YPsgrhIubKvsQ/h+RO0tnTBpJl8evV
	JihDZMSdqPsEwS90l0e76nd3vO84Oac2Eh79aJ7pKsCeY2vbTGVv7UKXK+GO4oqjOaZ5fsR8Yu0AE
	xaJxZ9Lw==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0m0k-0000000999s-0VxW;
	Tue, 15 Oct 2024 18:11:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Horia Geanta <horia.geanta@freescale.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] kernel-doc: allow object-like macros in ReST output
Date: Tue, 15 Oct 2024 11:11:07 -0700
Message-ID: <20241015181107.536894-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

output_function_rst() does not handle object-like macros. It presents
a trailing "()" while output_function_man() handles these macros
correctly.

Update output_function_rst() to handle object-like macros.
Don't show the "Parameters" heading if there are no parameters.

For output_function_man(), don't show the "ARGUMENTS" heading if there
are no parameters.

I have tested this quite a bit with my ad hoc test files for both ReST
and man format outputs. The generated output looks good.

Fixes: cbb4d3e6510b ("scripts/kernel-doc: handle object-like macros")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Horia Geanta <horia.geanta@freescale.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
Cc: linux-doc@vger.kernel.org

@Jon, feel free to update the attribution for your patch or I can do it
and send a v2 if you like.

 scripts/kernel-doc |   43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

--- linux-next-20241009.orig/scripts/kernel-doc
+++ linux-next-20241009/scripts/kernel-doc
@@ -569,6 +569,8 @@ sub output_function_man(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
     my $count;
+    my $func_macro = $args{'func_macro'};
+    my $paramcount = $#{$args{'parameterlist'}}; # -1 is empty
 
     print ".TH \"$args{'function'}\" 9 \"$args{'function'}\" \"$man_date\" \"Kernel Hacker's Manual\" LINUX\n";
 
@@ -600,7 +602,10 @@ sub output_function_man(%) {
         $parenth = "";
     }
 
-    print ".SH ARGUMENTS\n";
+    $paramcount = $#{$args{'parameterlist'}}; # -1 is empty
+    if ($paramcount >= 0) {
+    	print ".SH ARGUMENTS\n";
+	}
     foreach $parameter (@{$args{'parameterlist'}}) {
         my $parameter_name = $parameter;
         $parameter_name =~ s/\[.*//;
@@ -822,10 +827,16 @@ sub output_function_rst(%) {
     my $oldprefix = $lineprefix;
 
     my $signature = "";
-    if ($args{'functiontype'} ne "") {
-        $signature = $args{'functiontype'} . " " . $args{'function'} . " (";
-    } else {
-        $signature = $args{'function'} . " (";
+    my $func_macro = $args{'func_macro'};
+    my $paramcount = $#{$args{'parameterlist'}}; # -1 is empty
+
+	if ($func_macro) {
+        $signature = $args{'function'};
+	} else {
+		if ($args{'functiontype'}) {
+        	$signature = $args{'functiontype'} . " ";
+		}
+		$signature .= $args{'function'} . " (";
     }
 
     my $count = 0;
@@ -844,7 +855,9 @@ sub output_function_rst(%) {
         }
     }
 
-    $signature .= ")";
+    if (!$func_macro) {
+    	$signature .= ")";
+    }
 
     if ($sphinx_major < 3) {
         if ($args{'typedef'}) {
@@ -888,9 +901,11 @@ sub output_function_rst(%) {
     # Put our descriptive text into a container (thus an HTML <div>) to help
     # set the function prototypes apart.
     #
-    print ".. container:: kernelindent\n\n";
     $lineprefix = "  ";
-    print $lineprefix . "**Parameters**\n\n";
+	if ($paramcount >= 0) {
+    	print ".. container:: kernelindent\n\n";
+   		print $lineprefix . "**Parameters**\n\n";
+    }
     foreach $parameter (@{$args{'parameterlist'}}) {
         my $parameter_name = $parameter;
         $parameter_name =~ s/\[.*//;
@@ -1704,7 +1719,7 @@ sub check_return_section {
 sub dump_function($$) {
     my $prototype = shift;
     my $file = shift;
-    my $noret = 0;
+    my $func_macro = 0;
 
     print_lineno($new_start_line);
 
@@ -1769,7 +1784,7 @@ sub dump_function($$) {
         # declaration_name and opening parenthesis (notice the \s+).
         $return_type = $1;
         $declaration_name = $2;
-        $noret = 1;
+        $func_macro = 1;
     } elsif ($prototype =~ m/^()($name)\s*$prototype_end/ ||
         $prototype =~ m/^($type1)\s+($name)\s*$prototype_end/ ||
         $prototype =~ m/^($type2+)\s*($name)\s*$prototype_end/)  {
@@ -1796,7 +1811,7 @@ sub dump_function($$) {
     # of warnings goes sufficiently down, the check is only performed in
     # -Wreturn mode.
     # TODO: always perform the check.
-    if ($Wreturn && !$noret) {
+    if ($Wreturn && !$func_macro) {
         check_return_section($file, $declaration_name, $return_type);
     }
 
@@ -1814,7 +1829,8 @@ sub dump_function($$) {
                             'parametertypes' => \%parametertypes,
                             'sectionlist' => \@sectionlist,
                             'sections' => \%sections,
-                            'purpose' => $declaration_purpose
+                            'purpose' => $declaration_purpose,
+							'func_macro' => $func_macro
                            });
     } else {
         output_declaration($declaration_name,
@@ -1827,7 +1843,8 @@ sub dump_function($$) {
                             'parametertypes' => \%parametertypes,
                             'sectionlist' => \@sectionlist,
                             'sections' => \%sections,
-                            'purpose' => $declaration_purpose
+                            'purpose' => $declaration_purpose,
+							'func_macro' => $func_macro
                            });
     }
 }

