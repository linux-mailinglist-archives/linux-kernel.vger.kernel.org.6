Return-Path: <linux-kernel+bounces-251606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB369306DC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 20:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE81C21430
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9C13D603;
	Sat, 13 Jul 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b="cHjEbSs8"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E7F12FB2F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720894009; cv=none; b=lHPdNh5QyrKYsMrpWqkmg1AMIdSrll9KH1QqR42oSxqVHHrR1isoQK60q/ZViYQXXyL/TooLaveZYI0ogK16D62WZCi4I0OHj/Ecn1GVQEHLB2yw6KQ4VVcTSYRmZPhncweOrx5leafa7aWOc5CAe4P3w0i54PwWbirM4kCDiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720894009; c=relaxed/simple;
	bh=19deBKXtIrWdyfdWO2kcSIU8veOmHLYeyK6XrCCAh6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KKj9JO0BiZ48TNtPP9f6rcgdiTr46NVEWBBKh8B6oT19tH2BeDSADGm0bDBWCrqUtDfR/QDalVqAqu4Fzho2cQ1vcLfVNzom0WwL1tvBWHJivwm+oouufLK6Tr8Pny0vVOMAu5spmqYkI1a8EtB1QEbSx63TJ9rn95JU3TCoOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in; spf=fail smtp.mailfrom=mitaoe.ac.in; dkim=pass (2048-bit key) header.d=mitaoe.ac.in header.i=@mitaoe.ac.in header.b=cHjEbSs8; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mitaoe.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mitaoe.ac.in
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb72eb3143so21477525ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mitaoe.ac.in; s=google; t=1720894006; x=1721498806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LO1qAerOan7GyDs+4V1LarTw1zHLMK4oIn44Hbh1CA=;
        b=cHjEbSs86wa2qU8lwGz/KEHRyDJ25j76c6qy6bMxwXE4BXI0etqZ1SthzzhVP4NHfg
         CnvvpOIw+xhlWVpyUxQEvowZd6pMcWdQceDYYz+y7J4Da4uO8LysoZBaoQR8NKe//ur3
         RHTztKjRbbzFjSgjAxm+dN9BYov2/leBWxy68vNs5cB53Aw74+FmTr00Cgj/BMbim85i
         cLLZj5g1syWVlHppBqilcxbrrilDGxPksAypPNES9/RsNbyUZ5OOEFPUq8VAPwYooYp1
         snoCkgCI2qD/pn1+KjneEQ+Uk1I/x6Hl+WMz3Vb6ghUD6NKemMw1vubeP5D1E3g2qNdU
         cPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720894006; x=1721498806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LO1qAerOan7GyDs+4V1LarTw1zHLMK4oIn44Hbh1CA=;
        b=adscaetudDDJ4jRA679S3MBMjoDwPUJbkonwqC4/7zahiHup+H3+R4gD+FU+Z3xBjo
         9z8lO0+PUcMdBMZ7U/hdvkAxULz+po0qqoIRgg0hFIZ3UkmGZMV6Oq+mJwNWq3gKx1Q1
         7yCtFiNG4KaxJ5V+0qh8htYaSrGTbGZbs5vuhgQzDqzJjzQsOM3oEuS39sHObp2Fwl5/
         16VF1xerF7fswdKgsD5VVwKjUkT6s88A/7JUi61Hhm18cDWbz3PJIZdjz9emKxBEJnRy
         UIugQAMw6w2baOoxKaq8jnZML0N9zgbS/FehYaCzp69Uf+4jff5uFWER2Ai4CdjC0tAX
         6EYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD2vZ1AT0FpES/dMk+j5m/j/ltTDzRVsg89dFYPYeK8fQZqMhNbntJglT2Q0E9HTk3GnkLFus8svQxxMEs/oZMQ3eoZhj06Yo6gFPi
X-Gm-Message-State: AOJu0Yz7l6i4aTBBob9ETH3gD6KUqJMivCjl5Ou2J1OhZ73SX98e7VFE
	oGf//UpbLcA34dM9HNBVEFzGB4XK1riFpS09BhsL9wWI+zocRMw6gwJtiAE8bWDe7rz0071/3k5
	Qh/Y=
X-Google-Smtp-Source: AGHT+IHbBTEqXXoseVN7R1U+NKeFIwiKbZeWCkN1HC46RG9dLtQrGa969U9Tio6vyZC9WTNl+Lprtw==
X-Received: by 2002:a17:902:ccc8:b0:1fc:ee5:d581 with SMTP id d9443c01a7336-1fc0ee5d71bmr26008665ad.14.1720894005721;
        Sat, 13 Jul 2024 11:06:45 -0700 (PDT)
Received: from localhost.localdomain ([152.58.19.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbc4e68sm12896455ad.119.2024.07.13.11.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 11:06:45 -0700 (PDT)
From: mohitpawar@mitaoe.ac.in
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohit0404 <mohitpawar@mitaoe.ac.in>
Subject: [PATCH 3/3] Fixed: fs: file_table_c: Missing blank line warnings
Date: Sat, 13 Jul 2024 23:36:12 +0530
Message-Id: <20240713180612.126523-1-mohitpawar@mitaoe.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohit0404 <mohitpawar@mitaoe.ac.in>

Fixed-
	WARNING: Missing a blank line after declarations
	WARNING: Missing a blank line after declarations
---
 fs/file_table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index 4f03beed4737..9950293535e4 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -136,6 +136,7 @@ static int __init init_fs_stat_sysctls(void)
 	register_sysctl_init("fs", fs_stat_sysctls);
 	if (IS_ENABLED(CONFIG_BINFMT_MISC)) {
 		struct ctl_table_header *hdr;
+
 		hdr = register_sysctl_mount_point("fs/binfmt_misc");
 		kmemleak_not_leak(hdr);
 	}
@@ -384,6 +385,7 @@ struct file *alloc_file_clone(struct file *base, int flags,
 				const struct file_operations *fops)
 {
 	struct file *f = alloc_file(&base->f_path, flags, fops);
+
 	if (!IS_ERR(f)) {
 		path_get(&f->f_path);
 		f->f_mapping = base->f_mapping;
-- 
2.34.1


