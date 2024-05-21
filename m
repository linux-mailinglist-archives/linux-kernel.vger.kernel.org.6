Return-Path: <linux-kernel+bounces-184535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD098CA82F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A0B2821E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D045337F;
	Tue, 21 May 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mPHjtAxr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3E51C30
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 06:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274281; cv=none; b=fM7V9haVojhTtmkZTQ1yaMD9+xtP9WVH8Z2HqaavRftaoW+Jt3/OF28lxBYzw5/J9cbtacTY7ddHql2ImaAoxgyPPpNHME7YP+blAyC7KJF93mDLQyb6luSonYyJpxiEe3gV3vunOu+fFI3qUcMqre9lUuObCXI9NO96JrsYaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274281; c=relaxed/simple;
	bh=OH4cLngpr688D6c6flc0xYeuNkIFvmRIGHw0APLbxfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqfsgtBKsSGpKVciE6yKl7Pjj4h6WZk8mWXa3QViwAhRs06sLdNLDBWLFO56j25En0bwIyGxCQLD6MYLGXDduJ9/t0c8LPRtmwBtJNbPlRVfaPsISSwddJU2oT7FmdNsYA9ryRAFkSDL0/NkSZ7Z6RdJytM4jGswOVopD1fp/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mPHjtAxr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ed0abbf706so30538905ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716274279; x=1716879079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOkWGMmTQVEt7UvShsfEX9Q7OP2nXlbFbaBQoutTKvo=;
        b=mPHjtAxrxDL2UF6NtlHhTc8chXwN6GdzHjoecsCaQg41uxN5ztOYmcZLbjzNRWuNIS
         DOQvYYjUa6mFMNcdklStrv0BYe9yg85cQ3+Nu9yCnvk7G2VJsvJ9QIa9T6UcuTYYClBA
         WumyskxqVLCSfWzfrbwvZdaBn/pngV+DBCwIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716274279; x=1716879079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOkWGMmTQVEt7UvShsfEX9Q7OP2nXlbFbaBQoutTKvo=;
        b=L/rh9xJJM92X377RzGvr1qrRb3IhsSzygka3JOJbvWZ7VXuGRN0GNqntWQFZ1fpmz2
         0o/p1z0a3Kg4s54q65q5hql7+kaPlImO4aZfC9kDKIsh60aKX7XHMAP1JQBOazR7T/ur
         IUwEtNh4syBjHN3BmFrtAqQVtGqkMvTIR06u7MdUmoIiMUfJgIyunQSysRi5TEAjhQlb
         Vb4MTj+jpwd8ThM5KQOkU0ZmMN95iKP0mZ7G57nWCrcEVxa4RljwA1UlF5v1Tl5A6PN6
         fJVnBX+hWVdET9/CiI1RcwR7OWr0YC4qt5pL7rgX1+jix5HybiuMuUzxKdx5G1L2xCFr
         ViiA==
X-Forwarded-Encrypted: i=1; AJvYcCVOyipmkD6fAXojE0MYehSp2r4slGcEwXPKXWDhCxqfpKSKja68v6qqXksQwX+Qm4UwJ1N00dg8W84+mTuGiKpmvNZxYn/2cT8JOr84
X-Gm-Message-State: AOJu0YzgK6XWicqyz6hYyxQpsseCAof7yXnGg8THDUENqupasTOu+fDz
	90UDopZBPAc+KfNDWiBlOh/zx33HCBI7bo/9zr7nf9P1DpdNUkDgIDRVvZRuJ754hrIv1VUIcLc
	=
X-Google-Smtp-Source: AGHT+IEe1eZFm8OQhme98CfuDT2vPG0NOgmo3lGuwwSKsHDgjQxj8mKdLiIdPioZKeAtoWh2bQX69g==
X-Received: by 2002:a05:6a21:998d:b0:1b1:d823:3ea2 with SMTP id adf61e73a8af0-1b1d8233f35mr6544797637.12.1716274278853;
        Mon, 20 May 2024 23:51:18 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f8a5:77aa:5a0d:e30c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f30644ad48sm23100985ad.169.2024.05.20.23.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 23:51:18 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Simon Glass <sjg@chromium.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 2/2] scripts/make_fit: Add option to disable compression for DTBs
Date: Tue, 21 May 2024 14:51:05 +0800
Message-ID: <20240521065107.30371-3-wenst@chromium.org>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
In-Reply-To: <20240521065107.30371-1-wenst@chromium.org>
References: <20240521065107.30371-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old bootloaders found on RK3399 and MT8173 based Chromebooks only
support compression for the kernel image in the FIT image, and not the
DTBs. While compression could be disabled, aforementioned bootloaders
also limit the kernel image size to 32 MiB, making compression necessary
for any practical setup.

Add an option to disable DTB compression to support this case.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 scripts/Makefile.lib |  1 +
 scripts/make_fit.py  | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9f06f6aaf7fc..84d9b0166cc0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -522,6 +522,7 @@ quiet_cmd_fit = FIT     $@
       cmd_fit = $(MAKE_FIT) -o $@ --arch $(UIMAGE_ARCH) --os linux \
 		--name '$(UIMAGE_NAME)' \
 		$(if $(findstring 1,$(KBUILD_VERBOSE)),-v) \
+		$(if $(FIT_DISABLE_DTB_COMPRESSION),--no-dtb-compression) \
 		--compress $(FIT_COMPRESSION) -k $< @$(word 2,$^)
 
 # XZ
diff --git a/scripts/make_fit.py b/scripts/make_fit.py
index 263147df80a4..626cf3422079 100755
--- a/scripts/make_fit.py
+++ b/scripts/make_fit.py
@@ -22,6 +22,10 @@ the entire FIT.
 Use -c to compress the data, using bzip2, gzip, lz4, lzma, lzo and
 zstd algorithms.
 
+Use -C to disable compression for DTBs regardless of the setting of '-c'.
+This is intended for old bootloaders that support compression of the
+kernel image but not the devicetree blobs.
+
 The resulting FIT can be booted by bootloaders which support FIT, such
 as U-Boot, Linuxboot, Tianocore, etc.
 
@@ -64,6 +68,8 @@ def parse_args():
           help='Specifies the architecture')
     parser.add_argument('-c', '--compress', type=str, default='none',
           help='Specifies the compression')
+    parser.add_argument('-C', '--no-dtb-compression', action='store_true',
+                        help='Disables compression for included DTBs')
     parser.add_argument('-E', '--external', action='store_true',
           help='Convert the FIT to use external data')
     parser.add_argument('-n', '--name', type=str, required=True,
@@ -247,7 +253,10 @@ def build_fit(args):
         if os.path.splitext(fname)[1] == '.dtb':
             seq += 1
             size += os.path.getsize(fname)
-            model, compat = output_dtb(fsw, seq, fname, args.arch, args.compress)
+            compress = args.compress
+            if args.no_dtb_compression:
+                compress = 'none'
+            model, compat = output_dtb(fsw, seq, fname, args.arch, compress)
             entries.append([model, compat])
 
     finish_fit(fsw, entries)
-- 
2.45.0.215.g3402c0e53f-goog


