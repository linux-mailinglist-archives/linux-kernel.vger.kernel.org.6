Return-Path: <linux-kernel+bounces-402594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7B9C297D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69C71F224B9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5177940BF2;
	Sat,  9 Nov 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKVVyr54"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B526281
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119120; cv=none; b=g4p474bv3j38w0stMnRqOOt5cNjMSV27Jc0uXnmerdBXg0IcyXkMTUwX4mKa+mD/Oe1E7dWXo6DKJABpUOPozTCsn9178R+vehMVzKp4JjzGDTKH4CG2e7qdU85Lzrxa5SPWkCtSbWdoLsBtYDdB7sL5QYEjMk9JuJEcrYMWF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119120; c=relaxed/simple;
	bh=VT6e/CLgXHCJ3p+hf0W1CIK6LB0T7zir8LpC675BqmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTl8UK+c8OQl32NUroDqhSB7R4XZxztYdTLSvWd69A9wXkZlpAQ06DOrxQXKVcn2oTrYlWNR5lvTQ1eCyCqrrQHCy3PmaUdRAoHib3ieSatMs6ejJk9FboTY3nVJQ1FNrJkyDNRLr0R0H1Ns9M7qNFvk6RhzG/LrPLNJerhgIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKVVyr54; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbca51687so28397615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 18:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731119118; x=1731723918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AVplWpa1YMVj6o2/I08R6HlW4MwhtEOYCQznVsuTIyk=;
        b=QKVVyr54SoqW5sl6tZBySmIzi/xPkbbUn+4awYCwZeWVLDzvwxndJVhu1Nii3Xmoow
         kyO1GqW0iSBd7EXqs32rB/k+zgor6bSZ5Kg/25/8+0+5GNQ9nCoVdBoWESFLuHM4Rqeu
         x/i/Ef/EiifmcDwkIdTFacXV6w5TEoxIScVzjzJqQosWutMk5U6hyndskj6RnvVH/JVg
         vM/0Qtn6KQd3+c2capf7N657NdxMRbFmGJBNus8xdNF2L8KRNFqAO2Cg4Rbz2HUednU2
         daqPZm875L/mfyvFknErEykbfnxSsiGpYAwO4kUevpsy+7A23PEIQxRpfE8EH/naEUMv
         aXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731119118; x=1731723918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVplWpa1YMVj6o2/I08R6HlW4MwhtEOYCQznVsuTIyk=;
        b=LkSyTWeeBggNMPq4poHirg3MivCSb0IpyEL7Vs5HhqyotBVk3bDr+T1qXDE588olut
         gtptMZqdqu3mgFt8xN2L6AIo9NEemxKhfOwPAcXzPl3SWtakb3K/gY/F5K7Nu3BJjv19
         zSRHCwGsdv9RxFr2T48athcTAklpFsT8yXZpBsSXeDYATqsYJtigzJ9QXcFTUxNueQWU
         VxSwIO4wg0jrPG4Orj/5yumFWlg6Yk9gZVo6UbtY+74Tpf/1Hkw/XiXx05BTLz/Wk96H
         KcLEKeO/VjlcpPOO2cXxTUM+g0nt49UCAUWlI1mDB/QEeW7GYwCbKpjx2OvC3cRoVTAa
         IxHA==
X-Forwarded-Encrypted: i=1; AJvYcCUhjNMhpSH8JM+oS5jDj6yxLd3ujPoDWNCmSGpdZ81rzO+6Hhm9GLn9PXDu1oWN3mKFvxZ04Zve2jlYf5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzsSLGKdXWN9Sx4roQ9qZe+phoijEBgq++g3CPbvlxLIWcPiIy
	XCZR7RnFAHSx/M0NVa70hSO9dm0G8u5KSvZ8depERqSTbtrzOAJY
X-Google-Smtp-Source: AGHT+IGJnWnwhxylWK13RDDluX2TjnLTEUb9o/pb+orI431Kd833/8s2UMkDw2nlJghMyxko7FZAOw==
X-Received: by 2002:a17:903:1246:b0:20b:ab6a:3a18 with SMTP id d9443c01a7336-2118350d16fmr72049195ad.17.1731119118457;
        Fri, 08 Nov 2024 18:25:18 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf7c7sm37728565ad.101.2024.11.08.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 18:25:18 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Clarify sched_ext_ops table for userland scheduler
Date: Sat,  9 Nov 2024 11:25:14 +0900
Message-ID: <20241109022514.173631-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the comments in sched_ext_ops to clarify this table is for
a BPF scheduler and a userland scheduler should also rely on the
sched_ext_ops table through the BPF scheduler.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 02f39314ef8a..f1a185ab5fbc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -199,8 +199,10 @@ struct scx_dump_ctx {
 /**
  * struct sched_ext_ops - Operation table for BPF scheduler implementation
  *
- * Userland can implement an arbitrary scheduling policy by implementing and
- * loading operations in this table.
+ * A BPF scheduler can implement an arbitrary scheduling policy by
+ * implementing and loading operations in this table. Note that a userland
+ * scheduling policy can also be implemented using the BPF scheduler
+ * as a shim layer.
  */
 struct sched_ext_ops {
 	/**
-- 
2.47.0


