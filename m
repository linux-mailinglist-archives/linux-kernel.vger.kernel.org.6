Return-Path: <linux-kernel+bounces-253044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D809F931BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FB61F228A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670013B5B6;
	Mon, 15 Jul 2024 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dnw6gvp+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEB13B58B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075001; cv=none; b=ITRCf4qh+k0y/WB0hYP8nDGMYV89Ro1TGJe53Yk68h1foE5I/2FCpcY8m7r9T8qnLpfPKaUZ/J3ntiGJqK3F54+r45MNukPp/rRSB6k7vWJq2Nw/v0lx52Q8K+x3bHNKqAyj0Vkby2py4MG0FdSlOo+w+IBdw9b9grDz/4zrzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075001; c=relaxed/simple;
	bh=cE5kb5OhWmUjG+RWiSI8KHouAEy0OVxKToAtD89Ri00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scHP/Eda6GU1yKNI4xv4mGZAti8yjfxg24Wu60D8feBqg/JkXcHT6tDmTp6/jtDPaKGzNPfu59yU9fdxdfaQDhQN4q/R6iTtYnESIXpUc6bAcq0kkMWaheCAjkWTkWlVtcyORugD85Rmvk7xO4M0W7vII/MYBx29a5pOmfZ1LWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dnw6gvp+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b4267ccfcso3533437b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721074999; x=1721679799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwMUdEYsdK3KTo/Zxpf0KpV7FfeKyb9hErR3OBes0Rs=;
        b=Dnw6gvp+niO+Wo5tlzIQwlulEP6ToF46Zu1CTqViiH0HOA011spkvZ9SmNpuwWCP9r
         ssXjzw8B6e49/mQKN7VEgD9T4xjgz/xdA8jD67k0rdTPQ1vP17VRijp5veU6TkA3eOSA
         hXqTjBQpfGlXBZxLXOtqPiHZISYaJKUZ6gAMkEXAThDgH0z9CeCX385QA0jcH9VMnTVo
         xU4jQYKBwcZmc1kbtEo6flHXVneQqjawodrHJD3pezSdnYujOAM4QfJRoQPN/pZXC4VQ
         g8/xyoZFMf+QcI4jbcb96KC49DWZaGX1/3W7rFlZJtUvW31zUyMPAgUPPaPwt/ORkxQ7
         89Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074999; x=1721679799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwMUdEYsdK3KTo/Zxpf0KpV7FfeKyb9hErR3OBes0Rs=;
        b=SNA2v9HDzeM2j9xhIHARanJ8+feuBUbnco0F8hUEyuzW/JNVDdobWPvBNPtXSKeLNF
         8XKwl7QgtbkKM2BeTiE3k3PXURMOuNSyrWj3sj6ycIQt+m+rG7K4XqMxtIUvVIeaxbff
         n6xRgi17pP0SOCO8ueMH31SSiyBVYHg207fXW9W9VUMmvXv9NK334sJiOH41Be4qosFh
         NTC7u28tadqnQusLGaI+s7a5kzcr+HMVQodfHjuVw4bHTjRKQTntkZFjQV5j/NazmNyx
         YbXNNyDku/A5t3T2vrscziLUalFaAWF1ywSjfYVrSQbuENdu7BPcjoWzCw01lJoDAEyB
         ZC1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWl9Ht5KwjjPnE43oRl7IORd0GzwSCZ17mLposmr9bR/hYofcuietw1ZHYJmdKu5qWmewcJwD4H5wzBe7BFWFUwhHMi21+8LyusXyTI
X-Gm-Message-State: AOJu0YwseDCQr5dLQc/y2wR1/yIBe89TQC0veWq2OQeV0wjJvmcE6ygq
	s4OtwYo+EqsclJDHtt2sKaM3sfEs5AX0ad23adBXm8U+KxYr1/mtW4cq1pLI6A==
X-Google-Smtp-Source: AGHT+IGjK4gJPTkxtjL4LcNN7V6AHRM1s0TYLhgZT6tFKHy/mGhMFPFmkIIyqT/gSnJMhd7WT9TA4w==
X-Received: by 2002:a05:6a00:194f:b0:70a:f811:4857 with SMTP id d2e1a72fcca58-70c1fb1880dmr236986b3a.3.1721074998516;
        Mon, 15 Jul 2024 13:23:18 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eccc1c3sm4770671b3a.208.2024.07.15.13.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:23:18 -0700 (PDT)
Date: Mon, 15 Jul 2024 20:23:14 +0000
From: Carlos Llamas <cmllamas@google.com>
To: syzbot <syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	maco@android.com, surenb@google.com,
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_inc_ref_for_node
Message-ID: <ZpWFMgpbZipqyGfN@google.com>
References: <000000000000c1c0a0061d1e6979@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c1c0a0061d1e6979@google.com>

On Sat, Jul 13, 2024 at 03:25:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    82d01fe6ee52 Add linux-next specific files for 20240709
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=106472a5980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=95a20e7acf357998
> dashboard link: https://syzkaller.appspot.com/bug?extid=3dae065ca76952a67257
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f2e87e980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a4869e980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 82d01fe6ee52

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 0c2161b1f057..f54e5c0c7d04 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1046,13 +1046,13 @@ static struct binder_ref *binder_get_ref_olocked(struct binder_proc *proc,
 }
 
 /* Find the smallest unused descriptor the "slow way" */
-static u32 slow_desc_lookup_olocked(struct binder_proc *proc)
+static u32 slow_desc_lookup_olocked(struct binder_proc *proc, u32 offset)
 {
 	struct binder_ref *ref;
 	struct rb_node *n;
 	u32 desc;
 
-	desc = 1;
+	desc = offset;
 	for (n = rb_first(&proc->refs_by_desc); n; n = rb_next(n)) {
 		ref = rb_entry(n, struct binder_ref, rb_node_desc);
 		if (ref->data.desc > desc)
@@ -1073,21 +1073,18 @@ static int get_ref_desc_olocked(struct binder_proc *proc,
 				u32 *desc)
 {
 	struct dbitmap *dmap = &proc->dmap;
+	unsigned int nbits, offset;
 	unsigned long *new, bit;
-	unsigned int nbits;
 
 	/* 0 is reserved for the context manager */
-	if (node == proc->context->binder_context_mgr_node) {
-		*desc = 0;
-		return 0;
-	}
+	offset = (node == proc->context->binder_context_mgr_node) ? 0 : 1;
 
 	if (!dbitmap_enabled(dmap)) {
-		*desc = slow_desc_lookup_olocked(proc);
+		*desc = slow_desc_lookup_olocked(proc, offset);
 		return 0;
 	}
 
-	if (dbitmap_acquire_first_zero_bit(dmap, &bit) == 0) {
+	if (dbitmap_acquire_next_zero_bit(dmap, offset, &bit) == 0) {
 		*desc = bit;
 		return 0;
 	}
diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
index b8ac7b4764fd..1d58c2e7abd6 100644
--- a/drivers/android/dbitmap.h
+++ b/drivers/android/dbitmap.h
@@ -6,8 +6,7 @@
  *
  * Used by the binder driver to optimize the allocation of the smallest
  * available descriptor ID. Each bit in the bitmap represents the state
- * of an ID, with the exception of BIT(0) which is used exclusively to
- * reference binder's context manager.
+ * of an ID.
  *
  * A dbitmap can grow or shrink as needed. This part has been designed
  * considering that users might need to briefly release their locks in
@@ -132,16 +131,17 @@ dbitmap_grow(struct dbitmap *dmap, unsigned long *new, unsigned int nbits)
 }
 
 /*
- * Finds and sets the first zero bit in the bitmap. Upon success @bit
+ * Finds and sets the next zero bit in the bitmap. Upon success @bit
  * is populated with the index and 0 is returned. Otherwise, -ENOSPC
  * is returned to indicate that a dbitmap_grow() is needed.
  */
 static inline int
-dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
+dbitmap_acquire_next_zero_bit(struct dbitmap *dmap, unsigned long offset,
+			      unsigned long *bit)
 {
 	unsigned long n;
 
-	n = find_first_zero_bit(dmap->map, dmap->nbits);
+	n = find_next_zero_bit(dmap->map, dmap->nbits, offset);
 	if (n == dmap->nbits)
 		return -ENOSPC;
 
@@ -154,9 +154,7 @@ dbitmap_acquire_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
 static inline void
 dbitmap_clear_bit(struct dbitmap *dmap, unsigned long bit)
 {
-	/* BIT(0) should always set for the context manager */
-	if (bit)
-		clear_bit(bit, dmap->map);
+	clear_bit(bit, dmap->map);
 }
 
 static inline int dbitmap_init(struct dbitmap *dmap)
@@ -168,8 +166,6 @@ static inline int dbitmap_init(struct dbitmap *dmap)
 	}
 
 	dmap->nbits = NBITS_MIN;
-	/* BIT(0) is reserved for the context manager */
-	set_bit(0, dmap->map);
 
 	return 0;
 }

