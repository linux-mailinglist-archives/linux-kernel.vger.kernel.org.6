Return-Path: <linux-kernel+bounces-366932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29E499FC60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8CA286C96
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112B1FDFA9;
	Tue, 15 Oct 2024 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJkd1Qjd"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612F1FE117
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034408; cv=none; b=m9r9Q/0D726+jBNoH802sHBEBwcoiwIgepJ9zoM8DT9dhIRfyZqHRuLBGiy/17rPAofFNl6WAO8bDNLXV6TevwldvAzNK2XuSUQMPVpccftIkTV0kvdG/JEw9Vzpvc8NGpm1XtYbfvZ0OaczMQwm65RlTYusibH3IqgWT/l9Ybg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034408; c=relaxed/simple;
	bh=THSkSo9lSkuxsbYiUqaXJmBiMFSg1TaDfQHynW6LWoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJkPntjS1FH2jL+PacufWar8sjDdUvGqb+Qycb0Vu6bthzbP/ykDy4A7ow/TInbv05WK9rtJDOUlGzzUiQh1B0cc6tCz726bLxM899J9pEvWFGyF+2CRJeG4FPZtmDl0NlXIKU+8kMct/QJ0QZ3qWdbaDiuQIfATu2aAlZOqlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJkd1Qjd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3231725c9so89764797b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034406; x=1729639206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y90q7N+0JYvarHeSSS/HcK3d00J7zzbtwQB+DjacdQs=;
        b=DJkd1Qjd6nfYoALd0SmcygiPVkhCub3F6KQlzJFaGd172PG+zHvYXrDFqdcoFw0l0z
         tWxJYs8O1wnSlt1nmB4VxN8+fUgqqTfBhiR1l2yEoKMPJWI3W59zpmOEvX9mbskJt5ZT
         nrBnDIBtqftzCfy78ruvNKuL1ztQTwLC7QLbOMYdZJn13C9pt/W4Vz+YSlZhAJocTjU2
         I7+ez/lBvnXV0i12tYHwHherRtEsaIgNIovI3jTloJGbO+ZKEPhTn4o1sBQRHEYouOfd
         1rKPDILVBOJjh8HMLJ9xvCghVD5Iw+lGW8VdhR92biWljp6a1fLZNBHKBTb1EBl1NPrF
         OwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034406; x=1729639206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y90q7N+0JYvarHeSSS/HcK3d00J7zzbtwQB+DjacdQs=;
        b=Q+7Ls56AH/ljKfu/bl4eYSS/gRbOF2WwMLIjwPx59VDno8H2p1pWD3GmLz0eb7Feg2
         UmJYCAjmmTAlEiGMTtEQhbJGV8x0qKf9WFRY1XENGvT7xGl+tB3g9+vnyM/x9pwpUzW1
         spwmW45Vwllu6YPfvaOaYTUJo+H2jlYUun1zI/rym8IkQ0p1OEGlEh8k9wCrZLTglpFh
         NaFJU8UqL3LdjSRdwCCGNNr7Ln4CXHYl4bQAygk9pc1RupUcEzb0HrAIEh8xMU8E2rBo
         oUW4YzynC2FHJknfRsx2jDzJVP//mDNmaJhCp33R/5khDfj2MtzmFd3fzlLzFbb1/eve
         YkOA==
X-Forwarded-Encrypted: i=1; AJvYcCWMducQuiqM/VlfIK6SUGnVAnCMwWtTX6t54nZUJvbVOOluh3e7nMhdjHwP8n3gMdLs5I3IDUr0M2azETk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySyl7NuDi+/DNpAj1sj9V3ZLQEVT/vXPgyqTCzkOngMVWoaIOX
	Ou30V/T9XbRrMMHPG63lkm24gecXUlCQbbRu6MtbhmV7vA1bHOCnJnxR8PEI39tbOhiWCNFOJeV
	ychnhtA==
X-Google-Smtp-Source: AGHT+IEl0PoSNMsAIV4NYkV6h7fXXICopbsvroAdggBgvaXcptZB1VvmgZiKvr9u8QtCOHgbZG9OiwkRYgC+
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:9b02:b0:6e2:371f:4afe with SMTP
 id 00721157ae682-6e3d4194914mr597357b3.4.1729034405979; Tue, 15 Oct 2024
 16:20:05 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:19:00 +0000
In-Reply-To: <20241015231925.3854230-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231925.3854230-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231925.3854230-6-mmaurer@google.com>
Subject: [PATCH v6 5/5] export_report: Use new version info format
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, samitolvanen@google.com, 
	Matthew Maurer <mmaurer@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

The new version info format has a superset of symbols in the old format.
Since this is a tool for in-tree modules, we don't need to parse the old
one with this tool any longer.

Even if we build without CONFIG_EXTENDED_MODVERSIONS, these are still in
the `.mod.c` file. Their presence in the final module is controlled by
conditional compilation inside the at file.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index dcef915405f3..6a37df6f947f 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -114,31 +114,29 @@ foreach my $thismod (@allcfiles) {
 	}
 
 	my $state=0;
+	# State map:
+	# 0 - Looking for names
+	# 1 - Scanning names
+	# 2 - Done
 	while ( <$module> ) {
 		chomp;
 		if ($state == 0) {
-			$state = 1 if ($_ =~ /static const struct modversion_info/);
+			$state = 1 if ($_ =~ /__used __section\("__version_ext_names"\)/);
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
-			next;
-		}
-		if ($state == 2) {
-			if ( $_ =~ /};/ ) {
-				$state = 3;
-				next;
-			}
-			if ( $_ !~ /0x[0-9a-f]+,/ ) {
+			if ( $_ =~ /;/ ) {
+				$state = 2;
 				next;
 			}
-			my $sym = (split /([,"])/,)[4];
+			$_ =~ /"(.*)\\0"/;
+			my $sym = $1;
 			my ($module, $value, $symbol, $gpl) = @{$SYMBOL{$sym}};
 			$SYMBOL{ $sym } =  [ $module, $value+1, $symbol, $gpl];
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 3) {
+	if ($state != 2) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.47.0.rc1.288.g06298d1525-goog


