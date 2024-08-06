Return-Path: <linux-kernel+bounces-276921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BDA949A17
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13B21F244BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADDF17A587;
	Tue,  6 Aug 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxPC/edP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3E1791EB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979292; cv=none; b=KOU+C48xbGRjBpvfq25F0cK8xAkn8ZQ7zTOTapMAy48HWJlceTSkP2z4PvyuzC2DbACq4ozRxAEo9fP1Sku+v5VfIVfh7GzlUJ9gJ44TfcBPRa3L3PZCeKdQs/6jtno+rN7isPhGcnkNTJrnelhZRuNiFEOKQny6luihHR8UkIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979292; c=relaxed/simple;
	bh=eZqSlIaoWM4WfSbfbvyZzWv8g4Xdrp3U8leU2Zoxrnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m3NfeirE1fw+wZVq9oPi/tjRc9XDhKMtY36ZxFR0kP8Y0T1Wql7BzXKvD2LIoN6Ge7Fl3yRz7g1qhcHfRXUvn6cJ75KLDLz4YprQQwHv0PRtlFAoFt202AY4zylsh62oG1NPgqxM4RHNCNDtd1UifxfTN7Fn+3fxJZ3JorHdN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxPC/edP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-68d1d966c06so21599027b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979290; x=1723584090; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hw8pe/f7IoV2WGVsVTnz/cmhjcosc9mitK3vA0Vr4gE=;
        b=vxPC/edPVG9Dq3/FENh4yehDRZG4vGdY0gyUFzCUxOR0FNtvOD+y5onZI0u+CFGX2u
         obXSWxw4dcyJ31+d2hqAAPZSb80BRyer8SH6CBf7pbWjoL21Zrt8gcD4xfZKbg8NCKAT
         W1mNf1DpNwHtUF+y0bDgHXhFv+zMxMzbwq0AtBn9MOXNET5SL8jfvyDbTed448d8TUaT
         ERoyQm2E4VarNDLC68Frh+m6a8ZpaHwiFb/3JXiRZELrlqGNjS1kH8/OrtpbFkBsL+Z5
         7rPaFijcw+RlfW02RcdDrXBquS2AS2ptjP3Cr5jDSC6ppihYuPk90/3ZztYsNCCs6aWh
         IE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979290; x=1723584090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hw8pe/f7IoV2WGVsVTnz/cmhjcosc9mitK3vA0Vr4gE=;
        b=glM/aFjUPll8JGkSUqwTfapOtNekN7qImBDbDAEK0Zr3U3Kh9vJGwc5T8NUHuf/dFD
         4R/K8nzKcQj5N/U51B/3gnW61OuWe0DD7TTfHiEMYYJXVzqvzmKntFTWZ2VUTI6Pa5b5
         l4T9GSWBkcohqkHtb95P4LPyPyxwkrYIDFWsxbJDTu4Fmgyz6YFKCCQRnRFvkDUqUKeI
         FU1oESaj4yvAt3s0bhDWA7PwNODdW5Rteyq9twnq5kn4kNiOPPLBYQNaxBfNPS90W89y
         bPux2zuDtzN0+4gsnlSH/faDr4BNic0X9msKhYhvMFI0CatmMSjFP5cz4nnJoy2G5/LD
         YmAA==
X-Forwarded-Encrypted: i=1; AJvYcCXAwb+fG39JGACMf9CAtWWv6f/jMMy40xLvNXR/Lr+BE5+TZDErDsy/+HLrx1YWA0jlFQzC3du43/uTaT75zOk7YSve8ok3/iQ+sSza
X-Gm-Message-State: AOJu0YySZJ3bN2Q3a4RpnLT0mJCxqxPRhSlVij8sE+Of3mb+yRXNGze/
	nJQGtWcJe6VAVFPKHGxbE961o1zBdETAPugggx46lBJPfLOKu+eyUIMFS9y0qTUAPgDVXpeaYNg
	E89JrmA==
X-Google-Smtp-Source: AGHT+IF5wsgdTm2gCul2NqvSzln5bWqJN3fKvtypjNCS0MoVrnS+AxrHcsaPzCqJFh4r2PB0Xp3Zwok4SnEx
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:f12:b0:648:3f93:68e0 with SMTP id
 00721157ae682-6896313e32emr5643397b3.6.1722979290510; Tue, 06 Aug 2024
 14:21:30 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:36 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-11-mmaurer@google.com>
Subject: [PATCH v3 10/16] module: Factor out elf_validity_cache_strtab
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch only moves the existing strtab population to a function.
Validation comes in a following patch, this is split out to make the new
validation checks more clearly separated.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index a3a4acdcd647..d70d829b5ab9 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2089,6 +2089,23 @@ static int elf_validity_cache_index(struct load_info *info, int flags)
 	return 0;
 }
 
+/**
+ * elf_validity_cache_strtab() - Cache symbol string table
+ * @info: Load info to read from and update.
+ *        Must have &load_info->sechdrs and &load_info->secstrings populated.
+ *        Must have &load_info->index populated.
+ *
+ * Return: 0 on success, negative error code if a check failed.
+ */
+static int elf_validity_cache_strtab(struct load_info *info)
+{
+	Elf_Shdr *str_shdr = &info->sechdrs[info->index.str];
+	char *strtab = (char *)info->hdr + str_shdr->sh_offset;
+
+	info->strtab = strtab;
+	return 0;
+}
+
 /*
  * Check userspace passed ELF module against our expectations, and cache
  * useful variables for further processing as we go.
@@ -2122,9 +2139,9 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
 	err = elf_validity_cache_index(info, flags);
 	if (err < 0)
 		return err;
-
-	/* Sets internal strings. */
-	info->strtab = (char *)info->hdr + info->sechdrs[info->index.str].sh_offset;
+	err = elf_validity_cache_strtab(info);
+	if (err < 0)
+		return err;
 
 	/* This is temporary: point mod into copy of data. */
 	info->mod = (void *)info->hdr + info->sechdrs[info->index.mod].sh_offset;
-- 
2.46.0.rc2.264.g509ed76dc8-goog


