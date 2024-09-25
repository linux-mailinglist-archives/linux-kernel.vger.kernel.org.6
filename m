Return-Path: <linux-kernel+bounces-339748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A5A9869DD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04D57B23D19
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18901AD9E5;
	Wed, 25 Sep 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKP1Z8NY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF11A4B99
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307598; cv=none; b=WPSk11pDhInSWxISagqpP0kKeTso1rkqC8lJeUuOXuFdvafFPcPHcYpFYvC38KNXtP+EjATHQOHxpQmAv/Iw1Xq6MrQ5FGTEKwSpN2HdKpoNSowVvf4LS17G/H1+M9PHtr8ZL3lpxAV3XAiLGSNGdI1dVzkq6NKJEzEWK7Rx6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307598; c=relaxed/simple;
	bh=KqzbIRZaiTcASB5/z7j1pBJp9u/nLEzrmBQfqdwdS+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r3xqYZwoacdnKcw/C8OiBD7TQRo63XKSDwvTE3ZhAGhmblIj8XLZQNX5Zk6kZFvWkA5SRFqoGG3geU+d6v9QwxFY2EYn0LNMMEytp6KxgfpXxHuzYO/C7i+KdY+veBQMh5vCVxwJGowu40GDk6uMiQZS8Dav8qtw4t4tniRHp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKP1Z8NY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e230808464so6353457b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307596; x=1727912396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tQH+085gbT8g6utnUHSGPzzhaq/BvRPx+qqG98o3U=;
        b=oKP1Z8NYzCW3wdrGLbSd0+z4YaAtfoT+55NhpDw9t6rLvl0jWbL70Dl2B/Kh5tmKYJ
         G2GupxkGy83tyRGyRSwtyT2FpBXLIt2wWabdNX8ecp8Q2pvr7ur+V5PCfEkE/+QQAfmD
         doEyyE0OPuqskrD0GERU3wJK2bYsEcRh+wphK+xOCG4PE7A5T8fic6AcJjgLfY1bIffK
         /CbN1lGPMw30iGanZXxYrQ0ALBD+BIzgPamajUHMsFR/lRfTlwLxJXbYLLPl0Dr0HhEc
         SppOLafq9h5SiDULiY5MytW1aEBXpqMqaP3MuoJrIfc3QQdNjcXXYfo484YrusBlvFOK
         t6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307596; x=1727912396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tQH+085gbT8g6utnUHSGPzzhaq/BvRPx+qqG98o3U=;
        b=sDo6b9v37uzdZlTlIBbhztrEgJ4OwSvcT020INX7NEMDvsd6hLCOEmrJchJBRMG46H
         YZlXX4Sx2LAHxu6A3qp8iKRgObPb/a3g17P2K/JfDa2+ek7ZPUVw8+bvHe4ysh/Vg+sM
         utK0dUQXMmd395qOIxk0SYfxlVnc4AjiaquVDHkXQaMLe2cSEnKlen1xd2z6m7kRHqqA
         EHIKp1ehGbFyFNuZpHOvM56ATD5+m3e8EFgvr6QS6WEQhjgFjOptO7sqpPPz40SmTmSe
         1HLuU9u0i+mdreLVrAXbr4p1RfLYonKX1h49UHJJX8fhXq+kMSuoqqE2PrwhbUeQPNNT
         sbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdnGfkU+vhJgknCVgscytYRYa/C03+PgwyTApC+f7ZbJvz5nmjNZAbkun9wyJfZMsI1k5PYSVN7N1ORJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZjBivUYmZvWiOwKm4hGZZQS3vricUbOdPrwmA5gLV550T1uKX
	jvoAvB18gz1pW6HLsKgYppJED3i4FwC2WT5m8OQiYwxqk2xf9/9sVwbjrXDjq7nKbkvLc7l8mWd
	Y3U5sxw==
X-Google-Smtp-Source: AGHT+IHf83nSsh8dSI5MT6Lq2qwz18kf/IKNLkJKmhvyxAcTbUnK8QftG83szzLWCAGb7csPDeD/aKPeenOu
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:118f:b0:e24:9584:52d3 with SMTP
 id 3f1490d57ef6-e24d71625d8mr82063276.2.1727307595844; Wed, 25 Sep 2024
 16:39:55 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:28 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-14-mmaurer@google.com>
Subject: [PATCH v5 13/16] export_report: Rehabilitate script
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Matthew Maurer <mmaurer@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

* modules.order has .o files when in a build dir, support this
* .mod.c source layout has changed, update regexes to match
* Add a stage 3, to be more robust against additional .mod.c content

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index feb3d5542a62..dcef915405f3 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -55,6 +55,7 @@ sub collectcfiles {
     open my $fh, '< modules.order' or die "cannot open modules.order: $!\n";
     while (<$fh>) {
 	s/\.ko$/.mod.c/;
+	s/\.o$/.mod.c/;
 	push (@file, $_)
     }
     close($fh);
@@ -120,10 +121,14 @@ foreach my $thismod (@allcfiles) {
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__attribute__\(\(section\("__versions"\)\)\)/);
+			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
 			next;
 		}
 		if ($state == 2) {
+			if ( $_ =~ /};/ ) {
+				$state = 3;
+				next;
+			}
 			if ( $_ !~ /0x[0-9a-f]+,/ ) {
 				next;
 			}
@@ -133,7 +138,7 @@ foreach my $thismod (@allcfiles) {
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 2) {
+	if ($state != 3) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.46.1.824.gd892dcdcdd-goog


