Return-Path: <linux-kernel+bounces-558480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CCA5E680
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D7172337
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2F71F0E43;
	Wed, 12 Mar 2025 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sCFyKZak"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793761EF393
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814580; cv=none; b=iimCSLCwh/5F+vIcXruokf64LikxZo2674XaLZa3d6g8XQSZigTSU6VVRKkdhniplD+cMFxnsgec+Aqs4coRtk3ds05U4J8VFlfVAFMg+CxvdPDolMxR4R7c3E4sibxQJ92UuSj1cO5SCRwF2gie09625HOMlsNX7PyeSgd30bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814580; c=relaxed/simple;
	bh=UQi4jGJd9JPX9q54M13Eyu1joQsCWppMerqI6/F5Zeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhMwTi0F6F8Y4KJsLZefiw4rhx5Z4a7VrSb8ogqmjsxXy+Jss9fBJKWjVI/nYxiviq+jbmZYnh0dIqwKWnHVxxJXOj3UFNRfSl/uGgQ1GbhTvO7ROw1T7uiCb4PJyXpfED4E2OXbxqJurYnStyrYcDyt8D/qIrJhGYHL5MXNVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sCFyKZak; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 73F8D3F71C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814573;
	bh=vkBChevR2KYwwFZBDZ6M820pfzcyPKZb2PO3mstNSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=sCFyKZakaUftWxs9QToSa2iYDRjmwymogEnh5bqNk+TcutGHQj9F0evcRwByZfnif
	 mzfGT37QLIhi9GxW0NLVMtPvVL8i/4N1Z11S0gz3Am+a+fAkqQFRcweqS6j45bU4Ps
	 di9NaLEzCZUIPwau/tK1oxZg1naxvstlzn9m0EtpyabpVX0+7NiMlEoRJppbuDrUrZ
	 TbAimvT/OXzsfPIaIbjkJMa3Q18gbvrYKrjQ3Qgj67zWju3huasfBqTn4n75QcTCPB
	 EEgl958EFmTLiUBE5PCwCT2Ve49CRgm6WRLWa80uv8GJk3b4Bj5dvMk0kBsdiq20pi
	 dBXKQP0ViouSg==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso734407a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814571; x=1742419371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkBChevR2KYwwFZBDZ6M820pfzcyPKZb2PO3mstNSrA=;
        b=kAVfIrBWxrN5QwC13H0VIeKUwAafvktPbVMjdCbMKHqibQ0rRoCnliuIFSdkneA4Uf
         TcIqzHiasA/aWcgBV2IP+0womcpa1JWhNsgDL6ut4zN79c7SNxpS2PONANb7rx5oRnwz
         MIanB4tQwhlet/iQRhMulgqg6X7oqOIR8FmVoa6ExlfUHqiB0GgyKRaEVCFaALjIqtvA
         Mg5JRVMdZQVkmEfmbHSXruqqDs4X38NJl9YQks6QdG+ozj5saNByEm/K8zvJtaucYXXq
         WOcy7HKGttZtvaSlrmtaQZIng/I0sf5Aevri0k9Gg5cRR99ysMht7m5g5kIpeYrIRSgk
         OpCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgPsG4Hl/1MmJBNSwGKvaZqBVkbbgPbMd8nUh/n0DSuevwnLaOjOayc9ctpI2hyF+MX8BiJ9SygllrtgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhcDBpGRy56PuJf0k2rOksh3gD+YCJd7GaEPc0Aox7bhtCb4nS
	vpaB9ABJRxCD5AN6jlisQuBnxuBVyiE+s+jLhx8V2wZeBJ8wsk7j+PHyi7UDD3npWTs7BzNX9Fz
	ma8IlHI34qvI+brer0sHwlw7k/GNXPG+ouv7r6Vsm7oJKbt2PxvGGZ0d3sjG5+1Dvcc+OqrVdZU
	tDCw==
X-Gm-Gg: ASbGncvlyW3NGBXH5Y5oMr2qI7RnHiXi4o32f7yKeRh0Y6uPoxrRsH8H2iSCl3Pqv7S
	exvUXMK/ivYNZZMUU1I4yfABmlvgR49gB8It7kRESAmhkVCQQNfqcVOezfJw6E2eDN1mIGT2x15
	jg8Q3Pk6tT0FTulb70qAg7Thgo847s+1OBtKW4RaK9XMmknbrLeJIu3sPuD7cfF1QOo7zxf8etH
	9mQlx5ZeuEMUC+br+Xsh0AS9AvpGgA+X4sX6bMlInc+MZAxqNDFG6nfZnoWTIVbEUXDS+EoxR8X
	1zyHD5d11eG5jnbEudN5et2YnzwqEAoR6Tjsnrfy428jLNdzTIVpsU8D1MOyDmFXICOs9Ds=
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr32847529a91.28.1741814570801;
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2zy2F9PoKbQMeK6fUS3X/Yt717KlC839Q5G4xkP4Nr8/wnDbMYJ8pDxU6TgdAPfQxzzejkA==
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr32847501a91.28.1741814570519;
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 4/6] selinux: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:44 -0700
Message-ID: <20250312212148.274205-5-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that O_PATH fds are being passed to the file_open hook,
unconditionally skip mediation of them to preserve existing behavior.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/selinux/hooks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 07f71e6c2660..886ee9381507 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4009,6 +4009,11 @@ static int selinux_file_open(struct file *file)
 	 */
 	fsec->isid = isec->sid;
 	fsec->pseqno = avc_policy_seqno();
+
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
-- 
2.43.0

base-kernel: v6.14-rc6

