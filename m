Return-Path: <linux-kernel+bounces-276924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C4949A1F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21BD280F66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C457516F824;
	Tue,  6 Aug 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvQ9Op5m"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E7D16F260
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979304; cv=none; b=mrCzcF37dgd/zFC6qhZOGfQN10Frig3UbqCc+AjC/CVhjSfxozqUMxXGn+0w2AuwQsVZ9Oj157iEdQ/C3Kk83R2bKwJvFU0+T/o4Geh39ZdQaQlaGbxPpFNIfqcYRakzVKvc4FznEH/+Ze7rhoqXt0x2p7bSodcRPGJxkovNzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979304; c=relaxed/simple;
	bh=mCqYq1X/5JSmTDPsE/ocb7zGxaMcpnc/Bjh/o+XxIs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ETjbl3+W2WOSX9/9cA4A1HO5czrkfAj+bg3emzrsH2xRyFk4l4dbu97HdOc5PZvLsEB0asw3byvV/KYm9tIDYtEIdwJPKUYlUpoO/EiCxCLXFDBnFXVTNkSe/4cxIKBbwTPRdBrkOo1zHD16SImgkd68Tm1grnhp2ORI/FN1w+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvQ9Op5m; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6688c44060fso20554007b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979301; x=1723584101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAaXWC0uuTf8zgXDc0pw4iU2+AZ5Ew6s2WlxaR3c8mU=;
        b=CvQ9Op5mhhpRJDe1qd93QNFQaqonLa6repdE0h752xjjkgN2guWrirFaWYR2pBNutW
         ljj4/LA+BPeHN1X9W5wdXp0593x355DQW5SqI9yxh9MGjQOfOfhCKMYFyjSFVIWUY5wY
         gffElgTC0Iv+79Wz5j4DBcobZN71h/EgnIxJGc7jh2VpvNb7HHooi+Ih6oexnRwvhqEq
         Oc429EkUMvjsqU7z++0ubhz/6Lbfh9+bdbKfwTgZP59uf10uyhkASITA6x/bIVJbDrJ6
         XOnRWU5YTViaJhi8CpHK9FW2qbAT5P5/kaH49auhmK/3DxKjCt0GtcdHFJHFA/B656r2
         mqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979301; x=1723584101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAaXWC0uuTf8zgXDc0pw4iU2+AZ5Ew6s2WlxaR3c8mU=;
        b=A3ZCW/S1RQpXloEB48IeF7TPQdicONAYXur4qJhvc78LVm6guaCkwC/VxCbRkt/PrA
         u+svcpEYtQES1YtcN+llE1ClUfmuqcoW3nlMbQHXtQWTKr+pFBSlWDR4gTAK8M+3fJ2R
         stdQvKXDf8/m0utEWcnGf3ZLnR2bFKVlc6o2SOoe5zh0BxjjET4aMmj83qSM9H3Dw9lq
         dby3k0+nWepPpRem4/54gyrvAFQnqDsmpzQQW2Wkf9gU1H1dwMzqdkf6ngOwoNOED+dZ
         HPFsNBqu45oQNA7HxDISowigGf7QDW2XkWEG4mta5aNMIeYysQ2bxlqC5pLMSJ7GdZEN
         msxg==
X-Forwarded-Encrypted: i=1; AJvYcCWUACYk3coVH9v/4fYJ2/JU/TJEa2JSduJII/L4X+FaTmZxak0VajgwGYeCXWDy8gWBu/QVLU5l31P6s6sAmis9SMGsEyX+Kyric/+T
X-Gm-Message-State: AOJu0YzSQNNb4tDOxlD6AJIgZTlzkrMlVMVqgGlZQ0iXwR6ENN0IJIXB
	pNoIksridhKmifAwADXUoG7+hSO1fBO2hLlYta0TQH8NPIL6wQuYmUbbcrdZKuyr+CPWnP5a7f6
	5RZtKaw==
X-Google-Smtp-Source: AGHT+IFcUQaohqepPhNvLJBa4TjhoTiyuvux1yaJvbNrJCyjQGkSU02qkk9c/0giXa9EMI+33KR83fwc25z7
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:150a:b0:e0b:f93:fe8c with SMTP id
 3f1490d57ef6-e0bdde8775cmr310737276.0.1722979301649; Tue, 06 Aug 2024
 14:21:41 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:39 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-14-mmaurer@google.com>
Subject: [PATCH v3 13/16] export_report: Rehabilitate script
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Matthew Maurer <mmaurer@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
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
2.46.0.rc2.264.g509ed76dc8-goog


