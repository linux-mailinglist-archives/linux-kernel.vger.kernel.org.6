Return-Path: <linux-kernel+bounces-337644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A85984CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C738B23434
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485C81AB51F;
	Tue, 24 Sep 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AKOZ+uaf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325281547C5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212886; cv=none; b=t/fGbiSDAMfjW6XO7YRKZlJTlSvpDEaUEcTwu+XmTxgx2dHahzIqH/NzFXH9GjJYdsMT5IfjjiXJ52BhNsjVUnZQI+19R32NgInGsrvPLBly4hV8F/oQzUwfusS8dbkstIE8jvwYCb+YZQWiX/8agAV73TgbTmjiEFxDvSKtr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212886; c=relaxed/simple;
	bh=CxcOGYVl0RHNxURp1Y+1xpXbMOZLvm56O9AP4mZATd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CSkY41UGCVFTHSMbdqu3YBZVFQYmqfQh77eNF5emOogrFiMO1+r1buY3B7iPpLu09ayu8MvF44frQrIyVezX+Xt8ojcGh5SxgJ3mnZ7ACZbN18e4J86FonpDxqp29npK65cMkHtdWKa14uGqiyCOeBLSM/Jtp9/rtnbH3Grx3Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AKOZ+uaf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6dbbeee08f0so5055087b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727212884; x=1727817684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WplRKYGF+6Vdtojy3WxnxZnhza95+GyPbQDFLT+DHQA=;
        b=AKOZ+uaf0D8tspupXHAXYrBovcQp8XUT7CMpVLp+A21lbnl0gYY2o7dukUHOVMXP2e
         fINJPQK+B0+iBbGLAd5bQXPCkNfzWnzlT14YtosM4oCxZfQK4buu6pciZaBuTnmN/Xsg
         vf67JMxbCn2XAHhP3S/2CLdXHmpv9b+RejKYVvtTct570KIspmLS369dkhqjrf91emtj
         01tvdCo6sEAanK6RnsF06us6jl+H24zVVPVqZkT/dinxFaYSfauT0AaUiUOWMEfHgN8Y
         BxFhCkvTh/J8TpeWVI/xdpKu0wAhLtBXZZkIuux36CBYXUAfncqqFbc2WEi4Cz6hBTSl
         tjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212884; x=1727817684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WplRKYGF+6Vdtojy3WxnxZnhza95+GyPbQDFLT+DHQA=;
        b=ZLFr1bxmduZwEn2Zle/iUisN1uDbaIFaicYy/a+2JaWZClp/d2fYi0Urfk0YarSBCZ
         nQpZP1yZGwde/G9fHmmsjEoezpFVkyWPRqxw7VdWoEzpvK6hkJbGxIQXRngn0n3Bd/vG
         4Ajzyae/CuM7GrXnj4ny6+hD68iYggy+TnuSRpXIH4b52KNlQIVEVgkImcc5lSzvgHiO
         UvwjIMrtGe2sOGc2PrItgcWOXKHcvfjF0EpG0w+/EkYE5bQPt77jiIV+Nlf90dH/oR6P
         TZbYAFFBv9kvjxwWRSGH7ZUdRJkdFzq/1laR98VWJ+Fnjk2B4z7kE1Gk1ijzef1Abc0X
         C9GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV/l8w+RHhwN/j/EffZ16MEeCpc+6XPFKXbSuAXj6vbj08nr/TbzkTUAI4g7nejWhSpwFocTwnJe609Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgX8N3jzHaoiyYhG4gSYfAjpu8PZDwums7lRgO5aUf5w2Feey8
	BpyRxYvthkmT5AmVZu5/nfxSk0jAurZObQ3UANUhGXxi/7nC40oBKI0r7h+jiYTeJnWg8kQoIev
	jGe0wsQ==
X-Google-Smtp-Source: AGHT+IF4MxPHlb7j/5VsEwiO/CdZf6hOwGyAlmC18C9D4g5UAAgDjKnR/SlPm4jDqfBG2te5d6/arkT9UptV
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:dc8c:0:b0:e0b:b36e:d73d with SMTP id
 3f1490d57ef6-e24979369b9mr29871276.4.1727212883700; Tue, 24 Sep 2024 14:21:23
 -0700 (PDT)
Date: Tue, 24 Sep 2024 21:19:58 +0000
In-Reply-To: <20240924212024.540574-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924212024.540574-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240924212024.540574-17-mmaurer@google.com>
Subject: [PATCH v4 16/16] export_report: Use new version info format
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Matthew Maurer <mmaurer@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

The new version info format has a superset of symbols in the old format.
Since this is a tool for in-tree modules, we don't need to parse the old
one with this tool any longer.

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
2.46.1.824.gd892dcdcdd-goog


