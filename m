Return-Path: <linux-kernel+bounces-339747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC5A9869D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167952813F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00D91AE84A;
	Wed, 25 Sep 2024 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PY6Kja1y"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90001AD9E5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307591; cv=none; b=GO3ozgd6FT33K335IdLyxxbSZbI9hzSv7Jttwmq8GUQqgtP0WDuR9tI+27cmmzmef+493oZVRycwROBjQTMApFqwB+sefvuoJtFC65BVclvzNzi8LF7Dq2Snb/ZtOyVVCCrB1yguGTnZnmc+MWh8Gr/kk9w8eYPeB/G6Sy1TYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307591; c=relaxed/simple;
	bh=W7tU7P3GNG+a73WgyQWeP1re2H5Hhpn0LeAD9h0akfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oaeHad6jIU/WCp63Bb6Y4ZSVFeWVqF+vtsacgKPEF7imS9as01wd0R7NLzthsBGamz2DdaLzb+9Ek1tZKeu+i/yhGKssJ2lG2jB2HplAbHLcHAcQZ5eWT/kzXI8ZQGMTEGo5pfEz0+jBmbWjrTdVgCBIqnFewDGf3LTr7GUikf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PY6Kja1y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e22f0be237so9001347b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307588; x=1727912388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2yLoLuY3hdxUDQj4FAKHilbBg2KnzEPjHr+p4Rv35M=;
        b=PY6Kja1yO8FnJye7bHsyQXHe4y1e4dfN3dHXxgTZkfBU0quAuB+SylDK6cVtwedwgf
         3H48Hrh/I5tNAO5dWh64Db7Tov4QBC8jLuPu36yeMrKswEuAsYL8tj2wu5bTG5nqiwjz
         eLk8/CRbto8lTlXKPfeyiAPrK9vVaYvGYMhnPQVW4EWpfGixMu14TXcRHAo0kEQHRMVy
         MQe3GzHPK8KU8gzuywJ73078/Ny9zUI9wHtpSute0IM8QOpeWiyu+PfR1J5wjR/lWNdR
         6cjB8zpWx5Hk81ano1+ywkNJuJHVMIYea+V26Dyx0v6KiI9MPOjjydEIgQDIo29Z+Hio
         q08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307588; x=1727912388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2yLoLuY3hdxUDQj4FAKHilbBg2KnzEPjHr+p4Rv35M=;
        b=t0n8mFipaTmt1Mi39wVpJHq6QRKO8eNxmvtak2G8OyRbvtUo4R7xq3Np+fwOoXSSwr
         BsHSb/KiHaV443Jy81xgxFVeDkawkzpwQVSQUu2CB6W6p4/rAOwTBmMIO+uNT+DA9f/r
         BFqrPGw/xC49kDX38ihuCVHe5TvGfN4Bx8UJJfFbfHZ9pZr13RNUV/AhAwTrLzo6Y8eb
         esM+nsT3ohWacmHZk8EuOGC8MFcvcFJcrzroX4VslG8tN08zkT6zcLXzAYJRtqvZV7tT
         g5kPgFxzVcp3BwuLE5jPHRAginRMcKmBct0m/rlGmDhpIyYoWZHdE2BumOMoKJe7LeTg
         lNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA87qRGp1H3IBLVvmew9N9fYaEIjiaQRM5K29mMtH5kN3nSSotkt+0GgwlCbo4TDXb4OQZbqoE9lIREGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC0Dd5Pw2B0d7GcQeaDEiNBjfhceaPINdVR3Blzu1zJbxXBrFH
	/TP3c7V2SV/yaUug5aYJt61jcBVymZyvoZJ4j5XxmZe7CANTJ0VxQJwTrmryL9FicHeRIUKt8GW
	oKFoTsQ==
X-Google-Smtp-Source: AGHT+IGo3KQ6k/CMKWp9luhAJxulkW1/EkZDzA8kfvweM/2fd5g67sil+zl5Hoq7sgFCeukL28HlOifIuPFz
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:b120:0:b0:e22:624b:aea2 with SMTP id
 3f1490d57ef6-e24d46b5e11mr4072276.0.1727307588565; Wed, 25 Sep 2024 16:39:48
 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:27 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-13-mmaurer@google.com>
Subject: [PATCH v5 12/16] module: Reformat struct for code style
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Matthew Maurer <mmaurer@google.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

Using commas to declare struct members makes adding new members to this
struct not as nice with patch management.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/internal.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 2ebece8a789f..daef2be83902 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -80,7 +80,12 @@ struct load_info {
 	unsigned int used_pages;
 #endif
 	struct {
-		unsigned int sym, str, mod, vers, info, pcpu;
+		unsigned int sym;
+		unsigned int str;
+		unsigned int mod;
+		unsigned int vers;
+		unsigned int info;
+		unsigned int pcpu;
 	} index;
 };
 
-- 
2.46.1.824.gd892dcdcdd-goog


