Return-Path: <linux-kernel+bounces-173964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9D8C085F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 02:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF64F1C20FB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796C1373;
	Thu,  9 May 2024 00:22:39 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F464D
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214159; cv=none; b=TYJ8N5wsqVvSis5kCOWbBrTTG+r1Bn4uqSi1t7z2tMo7QTb3rvA82gj6q4eLpULXCHcN/uFtlUOWkDy+HutaMU+qewHeqYS5BqFlRp3Kj7GSEXtlWoEa+LFNlq9UxVuDzKZ0m1rAhNfp3gxnDsoAEGn4p+8Q+rJ9PUgKqWghVf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214159; c=relaxed/simple;
	bh=l9xvlp8mrxeR8KRimpw6XquSnAWFPAab02KC7tmXc3Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tEqFfPxy6DupENX90lFdvXPsvYHDzsi3W/lDOyPxYz4A9Yztyu4w0rFcJd7qKzPK4rN53GjxNJwmyCC8yCw7pIHCirzJlnQed/ZL0y4aeeUgaxTXRmfjcJpilbam9MsVuZNj6/Ipqr324D9qqGKKICjJKKE1lPP9b4o65kkKzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e17a8bed9eso22686339f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 17:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715214157; x=1715818957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfqIbh/n8c/JvAZGLAr1nhft2YgtPBcREnLCX/t7Ouo=;
        b=ZRFRhdxFXt/vVMR1PcOZfNePAfcPxKd/GRC5I2gs16MOLxtAdc8j8TvEY0ROwQ2vdm
         BiXZhW/bM5+wtVFnOGI97d8qWFXSabJigzHbg5TOmrwKWF0AnNW6zMZ6npHEBZJTWmEV
         llR9V+LaUVtVgbHpaVf15zQ5/9R9Avzq0PKxl3234LOsGOTKS6Ehdt8BIf6NKaDYfDGk
         3+o9P3z7i989K8nDu//BhOp0BCso2VxUIXp0zb60mw4WUh4h98tn9L4248H7+YITt54D
         pbVJTNmU/hNIlpWMesb5LThbcYexJEBTVc5lDfjchFEBX6A+YoiwakQDPSXvAIL58ycw
         SoCQ==
X-Gm-Message-State: AOJu0Ywl5nuFJNiRPgKPZzoXdf1OYcCyhLBAGqD6KJloiiHj4xjQysAw
	KyUERfa7Ye6pXZDD57qvqoZa+IS4asqadRtblbyaP4miW45renP8MhMtmhBRGHrwm4OVsr23KjC
	IcOayEsHlr/1zUKTIdIULyfQgwDs/Lc+lB90/3D0fHoBLIBSLaExyLcs=
X-Google-Smtp-Source: AGHT+IEjOZsQuVPeyFb1IvYgsEtOl50gaaoZq+ZmQEmfxzJLjQ8LNDZpDDzcNCkoUCbYlO5AO+IQ3aghEUTtiaVPz0+jXYklTD1H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144e:b0:488:5ceb:9533 with SMTP id
 8926c6da1cb9f-488fd355a5fmr257833173.0.1715214157190; Wed, 08 May 2024
 17:22:37 -0700 (PDT)
Date: Wed, 08 May 2024 17:22:37 -0700
In-Reply-To: <0000000000006a59f00617ecd989@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008daaac0617fa6a18@google.com>
Subject: Re: [syzbot] [PATCH] bcachefs: guard against invalid bits_per_field
 in bch2_bkey_format_invalid
From: syzbot <syzbot+9833a1d29d4a44361e2c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] bcachefs: guard against invalid bits_per_field in bch2_bkey_format_invalid
Author: cam.alvarez.i@gmail.com

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
A check for a valid value for bits_per_field is performed for each field before computing packed_max.
If bits_per_field is invalid for any field the whole format is deemed
invalid.

Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
---
 fs/bcachefs/bcachefs_format.h |  8 ++++++++
 fs/bcachefs/bkey.c            | 17 +++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/bcachefs_format.h b/fs/bcachefs/bcachefs_format.h
index d5b90439e581..23eb04148724 100644
--- a/fs/bcachefs/bcachefs_format.h
+++ b/fs/bcachefs/bcachefs_format.h
@@ -318,6 +318,14 @@ enum bch_bkey_fields {
 #define bkey_format_field(name, field)					\
 	[BKEY_FIELD_##name] = (sizeof(((struct bkey *) NULL)->field) * 8)
 
+#define BCH_BKEY_FIELDS()						\
+	x(INODE,        p.inode)					\
+	x(OFFSET,       p.offset)					\
+	x(SNAPSHOT,     p.snapshot)					\
+	x(SIZE,         size)						\
+	x(VERSION_HI,   version.hi)					\
+	x(VERSION_LO,   version.lo)					
+
 #define BKEY_FORMAT_CURRENT						\
 ((struct bkey_format) {							\
 	.key_u64s	= BKEY_U64s,					\
diff --git a/fs/bcachefs/bkey.c b/fs/bcachefs/bkey.c
index 76e79a15ba08..b6004b5f77e0 100644
--- a/fs/bcachefs/bkey.c
+++ b/fs/bcachefs/bkey.c
@@ -638,6 +638,13 @@ struct bkey_format bch2_bkey_format_done(struct bkey_format_state *s)
 	return ret;
 }
 
+static unsigned bch2_max_bits_per_field[] = {
+#define x(name, field) \
+	bkey_format_field(name, field),
+	BCH_BKEY_FIELDS()
+#undef x
+};
+
 int bch2_bkey_format_invalid(struct bch_fs *c,
 			     struct bkey_format *f,
 			     enum bkey_invalid_flags flags,
@@ -659,8 +666,14 @@ int bch2_bkey_format_invalid(struct bch_fs *c,
 		if (!c || c->sb.version_min >= bcachefs_metadata_version_snapshot) {
 			unsigned unpacked_bits = bch2_bkey_format_current.bits_per_field[i];
 			u64 unpacked_max = ~((~0ULL << 1) << (unpacked_bits - 1));
-			u64 packed_max = f->bits_per_field[i]
-				? ~((~0ULL << 1) << (f->bits_per_field[i] - 1))
+			unsigned bits_per_field = f->bits_per_field[i];
+			if (bits_per_field > bch2_max_bits_per_field[i]) {
+				prt_printf(err, "field %u uses more bits than allowed: %u > %u",
+						i, bits_per_field, bch2_max_bits_per_field[i]);
+				return -BCH_ERR_invalid;
+			}
+			u64 packed_max = bits_per_field
+				? ~((~0ULL << 1) << (bits_per_field - 1))
 				: 0;
 			u64 field_offset = le64_to_cpu(f->field_offset[i]);
 
-- 
2.34.1


