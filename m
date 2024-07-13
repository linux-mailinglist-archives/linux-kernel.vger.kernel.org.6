Return-Path: <linux-kernel+bounces-251615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F7793070A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 20:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBAF9B25363
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A934C13DBB1;
	Sat, 13 Jul 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b="D0GjrcNR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A811DFC5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720895919; cv=none; b=TleHYw34SiAH7EfWlhiVDPbxIGxeYcugw/frIp+BiFwf6yFTKJnIjtT5drB1gcN5z9cPrjKj2Bj0NMVhpvQh5e6vXKI3SY959CGJk5MbihPoR+MP58wfVk/L1lOOuvF9bE1ugp4qfDfd2+XE0PZEEB6/gr01JiGxt93dMhrXEN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720895919; c=relaxed/simple;
	bh=66JM7MTshMlOTzGaZeayzTXOiK9+WXLBxR6p2mbsZ6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gbYDqE7SsNbAjPPlBUvBY7nNT76nNy7I/5pmT77a6CxNcxNQ7IRVZ2skU4gMIMOmaaFNJj8JWlO3fSnDfqlrkht+r7frfBAdgieVv7mlFskc9YM+8ynEOle2/A6SU7OCusKOgk9QA9+ysPyubT+P/LjlMjSXsO4bhOnXadc3NZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in; spf=fail smtp.mailfrom=mitaoe.ac.in; dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b=D0GjrcNR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mitaoe.ac.in
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb1ff21748so21107995ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mitaoe.ac.in; s=google; t=1720895916; x=1721500716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LBPw5aAlo17a0qcvw45tKrPGk8ZlsZwPKEwzWdjyf7A=;
        b=D0GjrcNRTV6QX0uedoc98l5zy3XYNscR7XSsqgs8L6vjZrJyK02Zr+7h4x7i7yb7HB
         ot+gSwRoGMcLx1YqMlOtjnMJMMxmY6sMyY3+PC0wk16IuOewHawMNaCEWDbfgSHw4L28
         E3Nuz5cNvBy+8/owVk6QNrgidX+jIwgbuPfcbufgjnOzaqMX8BAvYbNN6SLQfjVSLntT
         buxOd0rANtz9uyJ6TyGMwIL+1+B4PWyN40z01TfFqq2MwhUjzMcBoi8bQayTndTzotlQ
         4HeHT3iZwmuqYKKj5+2Nr13e6JFjYK6M2uKxBCA8aAq9NdiLUJi225Fzl1aCPjmpT0kO
         GdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720895916; x=1721500716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBPw5aAlo17a0qcvw45tKrPGk8ZlsZwPKEwzWdjyf7A=;
        b=fZT5AlW5Gb7KFdW5O0FNL1NgezlQGL36hHFl5vPGaKJQvoG0XTJAz8orJfoCR2CNaR
         ALVQGLL83pANInBbFlhprbpdzVy3eW2I40GaEgoVL7CuX8PrOLNglA/6Fqtbtr99PwPz
         H2rwYYM6dCqWuMVAI/xDAqcnIYcIp9VI58Xgzlc64yB2llthNrpRuonWuEQaiy6vrSBQ
         a317Oln91D1aT32C350s8Ika5g6/1Hsw9BdCk7Ghf25LyqAaa+KXXDh2d7YxQ2GuUAzq
         X2a1BFaqKMr7d48l7IXFYe7beYBl2M/SnalkWMoycqUAyTyUKlqB6Lf2UtWQTmAGN43g
         B+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpAkRUB8XHR7PR4ix5gK+jKI9mzIYVCF8xxn3YMrwTyf9XeI+OXYyHqfN+ZZ97JtRqDJ4LqXqdO+hquNtxw4hjapdjyWTkw1S0bBCr
X-Gm-Message-State: AOJu0YwdM72t31Rpkxu9BcFGzUDr96ozZTxSu4t/Wh85JXnqY8ZxAbmW
	56o9lv65i8RCvOdApXqRIEKPggOTI/+UfLtPYkoaVsYpHn9/gT/SUCDB+occSTk=
X-Google-Smtp-Source: AGHT+IEAGCPvPUUX0mH+chWYU7b4BUEc+3xxeZoD9yWvB/3c1yEm1dy33ooRnGEm9lyXYu2x1cHGbA==
X-Received: by 2002:a17:903:228b:b0:1fb:6ea1:5e with SMTP id d9443c01a7336-1fbb6ec1f2emr129417495ad.44.1720895916109;
        Sat, 13 Jul 2024 11:38:36 -0700 (PDT)
Received: from localhost.localdomain ([152.58.19.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc3787csm13061605ad.189.2024.07.13.11.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 11:38:35 -0700 (PDT)
From: mohitpawar@mitaoe.ac.in
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohit0404 <mohitpawar@mitaoe.ac.in>
Subject: [PATCH 4/4] Fixed: virt: kvm: kvm_main_c: Resolved seven code indent errors
Date: Sun, 14 Jul 2024 00:08:13 +0530
Message-Id: <20240713183813.127677-1-mohitpawar@mitaoe.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohit0404 <mohitpawar@mitaoe.ac.in>

Fixed 7 Code Indent ERRORS-
virt/kvm/kvm_main.c:3347: ERROR: code indent should use tabs where possible
virt/kvm/kvm_main.c:3377: ERROR: code indent should use tabs where possible
virt/kvm/kvm_main.c:3432: ERROR: code indent should use tabs where possible
virt/kvm/kvm_main.c:3598: ERROR: code indent should use tabs where possible
virt/kvm/kvm_main.c:6006: ERROR: code indent should use tabs where possible
virt/kvm/kvm_main.c:6007: ERROR: code indent should use tabs where possible
virt/kvm/kvm_main.c:6337: ERROR: code indent should use tabs where possible
---
 virt/kvm/kvm_main.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1192942aef91..4b9090693527 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -130,7 +130,10 @@ static long kvm_vcpu_compat_ioctl(struct file *file, unsigned int ioctl,
  *   passed to a compat task, let the ioctls fail.
  */
 static long kvm_no_compat_ioctl(struct file *file, unsigned int ioctl,
-				unsigned long arg) { return -EINVAL; }
+				unsigned long arg)
+{
+	return -EINVAL;
+}
 
 static int kvm_no_compat_open(struct inode *inode, struct file *file)
 {
@@ -3340,7 +3343,7 @@ int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data, unsigned l
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest);
 
 static int __kvm_read_guest_atomic(struct kvm_memory_slot *slot, gfn_t gfn,
-			           void *data, int offset, unsigned long len)
+				void *data, int offset, unsigned long len)
 {
 	int r;
 	unsigned long addr;
@@ -3369,8 +3372,8 @@ EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
 /* Copy @len bytes from @data into guest memory at '(@gfn * PAGE_SIZE) + @offset' */
 static int __kvm_write_guest_page(struct kvm *kvm,
-				  struct kvm_memory_slot *memslot, gfn_t gfn,
-			          const void *data, int offset, int len)
+				struct kvm_memory_slot *memslot, gfn_t gfn,
+				const void *data, int offset, int len)
 {
 	int r;
 	unsigned long addr;
@@ -3425,7 +3428,7 @@ int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 EXPORT_SYMBOL_GPL(kvm_write_guest);
 
 int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
-		         unsigned long len)
+			unsigned long len)
 {
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int seg;
@@ -3590,8 +3593,8 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 EXPORT_SYMBOL_GPL(kvm_clear_guest);
 
 void mark_page_dirty_in_slot(struct kvm *kvm,
-			     const struct kvm_memory_slot *memslot,
-		 	     gfn_t gfn)
+				const struct kvm_memory_slot *memslot,
+				gfn_t gfn)
 {
 	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 
@@ -5999,8 +6002,8 @@ static int kvm_debugfs_open(struct inode *inode, struct file *file,
 
 	/*
 	 * The debugfs files are a reference to the kvm struct which
-        * is still valid when kvm_destroy_vm is called.  kvm_get_kvm_safe
-        * avoids the race between open and the removal of the debugfs directory.
+	 * is still valid when kvm_destroy_vm is called.  kvm_get_kvm_safe
+	 * avoids the race between open and the removal of the debugfs directory.
 	 */
 	if (!kvm_get_kvm_safe(stat_data->kvm))
 		return -ENOENT;
@@ -6330,7 +6333,7 @@ EXPORT_SYMBOL_GPL(kvm_get_running_vcpu);
  */
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
 {
-        return &kvm_running_vcpu;
+	return &kvm_running_vcpu;
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS
-- 
2.34.1


