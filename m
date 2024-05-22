Return-Path: <linux-kernel+bounces-186740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACA68CC832
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4FE1C21163
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4B71465BE;
	Wed, 22 May 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFfs5xCu"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841D442F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414273; cv=none; b=D+55N7v3Zpp23fzXmr4cpQiB3yCP59yM7tOTmFChh7KcIh5UkyFhGj0mZAatmM5oPGKNgiCYVcMFnrx8GBBnXzYsl+JCZNWlnYYfucShf7B714c7wN5HemcQJkoKTRCeUYb2+CZc7Yew6ocgp2hRuaO5wdFPCuuZjGYXN9jeGlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414273; c=relaxed/simple;
	bh=Md88oVELUbSjvxTuUS0D0ZDGQaeVlJ0X8m6EViY4Sew=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jA47Ngt81Lh4O2GJQMa5t8o+Wq4QXOukX+2itnnPpYLE6sddb6AQ5fSYC61S5nbsx+hpH/MxjUTY/0tulIoszVG2jpS4buprSjpXVQ144KwsGkwCX4KHt+BNB2M2o7406IqhRI6MLZWdPMo27ldE52BGKe+kFFBJNtspIJ8Qf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFfs5xCu; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2465651a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716414271; x=1717019071; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v46ULALCCIswvjtGrmlgVEh57G2PxqWD3ZUSadHGYHo=;
        b=IFfs5xCuGj3Vp/6EK2f40YfD/8AuT9P8W/NvcqIhtFlX0g9kNwjRXcCnnoMlEntZrY
         6AspG+CBslnf+mULSs3Y5QUpCNyoYVmecujnC9wlyOYp0nANUnMment3SJzkerB1OCp4
         SZQJfhM8YWjpA8YTtyJjFoTMNL8TvNk8MmD7h5/DIGdD6CxnPZzeSeZLV0NVBdzmqy71
         4FJtd+WSxlCLLFi9Sr4H7WdassqEmdk4Mt1cYIx1tDi+6A2ttqNjjWeg5Y/L84C8Xh4k
         qmP2f08MpcqCyD2cJJwfKbQifuD80JuH9v0EvXNMIpRTbWFY+1aM7catq62IhmCwF+ls
         3t/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716414271; x=1717019071;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v46ULALCCIswvjtGrmlgVEh57G2PxqWD3ZUSadHGYHo=;
        b=KIVICP+Yy2X2CIqPREu5lsWZwIq0brxrEao7Zx1Yjj/ALbpgkbzNZlcIIdQoYNFfKJ
         ++G/W+nitIQqaDiy1eVTgtHNbQK0JZiMZAVZXPWUSuVFdMpan/o+QP2pQ0RAqNBUF/hH
         dAMvOSEaGzyxtzqMWkhsxXsyINfq7xQoAm61n7MqmpVzy/ciBi0IfzoTSMBWve1Gu8L2
         uP+RraeQdwXjKJA8arVck2KW2vpxsum6R6PMJCSPpXsfmbUUFItY4Go4f4UE/t6Gfkv4
         13t+B4AmiB/sB5pLRUN3vNTVO4CLWl5GP+1/vTM7OSflD/T+tLHGIx/Rp8zlb8iLRhHR
         CKfg==
X-Gm-Message-State: AOJu0YycoqvAQ6DvWgcX/UqFisRbHFDO3PLSjnoPNjeM9Pdh+aRgEM8q
	D7YvztINF0/N+E3S+szS9oGMBVkSAHRSVYVg1L7E1Eao2Loh4B5vyCZGqaOM
X-Google-Smtp-Source: AGHT+IHUklp2bY0BZYQdGaUbJ9xzMfXCnfIkhnpqIXqSWtpiqtpm4z3S5nTq7Kf0WL3ywAyqWKuPdw==
X-Received: by 2002:a17:902:e5c9:b0:1ee:8fb7:dce1 with SMTP id d9443c01a7336-1f31c993bacmr37538585ad.31.1716414270850;
        Wed, 22 May 2024 14:44:30 -0700 (PDT)
Received: from localhost ([138.0.199.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badadacsm244412805ad.111.2024.05.22.14.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 14:44:30 -0700 (PDT)
From: arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 22 May 2024 18:44:27 -0300
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync linux/stat.h with the
 kernel sources
Message-ID: <Zk5nO9yT0oPezUoo@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

To get the changes in:

  2a82bb02941fb53d ("statx: stx_subvol")

To pick up this change and support it:

  $ tools/perf/trace/beauty/statx_mask.sh > before
  $ cp include/uapi/linux/stat.h tools/perf/trace/beauty/include/uapi/linux/stat.h
  $ tools/perf/trace/beauty/statx_mask.sh > after
  $ diff -u before after
  --- before	2024-05-22 13:39:49.742470571 -0300
  +++ after	2024-05-22 13:39:59.157883101 -0300
  @@ -14,4 +14,5 @@
   	[ilog2(0x00001000) + 1] = "MNT_ID",
   	[ilog2(0x00002000) + 1] = "DIOALIGN",
   	[ilog2(0x00004000) + 1] = "MNT_ID_UNIQUE",
  +	[ilog2(0x00008000) + 1] = "SUBVOL",
   };
  $

Now we'll see it like we see these:

  # perf trace -e statx
     0.000 ( 0.015 ms): systemd-userwo/3982299 statx(dfd: 6, filename: ".", mask: TYPE|INO|MNT_ID, buffer: 0x7ffd8945e850) = 0
     <SNIP>
   180.559 ( 0.007 ms): (ostnamed)/3982957 statx(dfd: 4, filename: "sys", flags: SYMLINK_NOFOLLOW|NO_AUTOMOUNT|STATX_DONT_SYNC, mask: TYPE, buffer: 0x7fff13161190) = 0
   180.918 ( 0.011 ms): (ostnamed)/3982957 statx(dfd: CWD, filename: "/run/systemd/mount-rootfs/sys/kernel/security", flags: SYMLINK_NOFOLLOW|NO_AUTOMOUNT|STATX_DONT_SYNC, mask: MNT_ID, buffer: 0x7fff13161120) = 0
   180.956 ( 0.010 ms): (ostnamed)/3982957 statx(dfd: CWD, filename: "/run/systemd/mount-rootfs/sys/fs/cgroup", flags: SYMLINK_NOFOLLOW|NO_AUTOMOUNT|STATX_DONT_SYNC, mask: MNT_ID, buffer: 0x7fff13161120) = 0
   <SNIP>

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/uapi/linux/stat.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/stat.h b/tools/perf/trace/beauty/include/uapi/linux/stat.h
index 2f2ee82d55175d05..67626d53531664d0 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/stat.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/stat.h
@@ -126,8 +126,9 @@ struct statx {
 	__u64	stx_mnt_id;
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	__u64	stx_subvol;	/* Subvolume identifier */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -155,6 +156,7 @@ struct statx {
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+#define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.45.1


