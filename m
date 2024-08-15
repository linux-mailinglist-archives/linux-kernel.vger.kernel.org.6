Return-Path: <linux-kernel+bounces-287739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE45952C11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE30BB24E21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5D1EB498;
	Thu, 15 Aug 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DPvwIH7N"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D11C3F11
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713890; cv=none; b=Sf8/k6yI1u6j5RVSdwPWIOn5JA0e7uqSyiwiy6p+tWqsBfILFVmkB7yHIH02XD3ERUfvEb1NCsymGHj50F0EaIddwQN6L8P0g9vDMBoRH2/1lXhpneTFcaIa5TJ4RmHicOjTa3XCLgpFtZ7K3AT+GbvAVi0FK0GeDuwAHrGec9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713890; c=relaxed/simple;
	bh=7QlYD6l9p5eF21jVsZq19AIhqtZNByHgXnAh7C0YaT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8lGpPDH+nP+ev4MKEVfh+a4vivtkwlrAj5BVyI1uzLqtgJ3mpgRibM97jRQ8J072g3SSb+wHLyDH7RmP8c7CGKbwOXp6Y+Q4t1oGu2xb9DlBp2F3/hKlj7GnTORuogKpYzvH0VKxpgOSFGrItbZJRE32Cp0voOChd5nTe1Hifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DPvwIH7N; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDE7D3F1ED
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713886;
	bh=rAXMreNRBTPp2+RJ3in8rXzVuCGcw271HJnlzrndXY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=DPvwIH7Nxo/G6vxKU5f5NnxsZN0g9klwabS8P7LbEAyKSU4haqFP5eAZcchCoPOCJ
	 ZjVLOx4pKTFGZJPxFjPcp4Jrli6TuB8Y3zAioCUnavLJT/cQBD9gr6vzXZxJbkVJ+x
	 XpzwvuM+J6Nopn3OrzUH13n5u924pk10+lt8UxC+MEAeVoTBT0Oigm9e2noyI7xu8i
	 SOdYoGf0MjoPi8W5fIklaQlF1SX9nDMiQeMBXyArBDmHdZaqTM/IGmpJ95IY4KONAC
	 GteU4q09hGNwjPlfh9NLDU6tmL8cS6J+5Xv5UHIB3emhqGr34LG5BIZ+u6FaPVtcEE
	 odXb3WegFyuQw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77f0eca75bso84180666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 02:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713886; x=1724318686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAXMreNRBTPp2+RJ3in8rXzVuCGcw271HJnlzrndXY4=;
        b=aKiFoB4quF360fTDg2DPnzkA0Bt//ni7GNR1QzGKDQFKpQJfvyV0asrvleutGX2/5u
         rlu6WnaoMDBbwo8dhO2mT27eZkVrWtdza9O+6p6SF991d2YUA6fAHl81xWZZOfXxQIRA
         uEPPvkRsjicvpc46902O6gu/w6Q/cWL2xVDyuUuZQFvVFwTU1S+TIrVdKRhaR+Wfyyry
         B4lscy7UHQEzShTt3n3fEKTtS10bls/GmXTPMoVDAcQnkwe6UtULOLuGTGqLEdLsSo0e
         6a2YdOOp0cFHlkw0+wCqWulEBR9+G+TE8OYn2XDRxSq0JYZCQb8DMw2u6kTW1ioIjow7
         aheQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX5Uu0uuTvzDkFF/LFsKfysW388Hl6H5TUJ2206IMnvuO9NtQCJk6nxDOJ2dyrzKRuSgcbFX0aBYBTfhNG3VK58LMkHOnckKLQsQbV
X-Gm-Message-State: AOJu0Yz+enCe2OuOSwClt9XrG/F/KXbFnS1+X/boahHXzoJcpv2NxjZs
	d8ATDnwPxGSzVd6uDIyK9VyPwGWlVNHNjTrgo1EBDw/hZqBqwwWtCsKHl7W+hqwVFrXClkNB1Q1
	eRCk53wg0nWhKHnSm6CbFrUXqJNROyMkrnXxSlaEuJhVGTIxJr721UdEO6MphsG/Xf8IShi0jSX
	MhNQ==
X-Received: by 2002:a17:906:d25c:b0:a7a:8cb9:7491 with SMTP id a640c23a62f3a-a8367087421mr391868566b.54.1723713886450;
        Thu, 15 Aug 2024 02:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs7cI7cvU+ksFskAocCsC23yqHF28RZ3Vu3jlzk3u1ykj3LBphtlYXWKHo08N1JU0SKHg0ow==
X-Received: by 2002:a17:906:d25c:b0:a7a:8cb9:7491 with SMTP id a640c23a62f3a-a8367087421mr391866066b.54.1723713885797;
        Thu, 15 Aug 2024 02:24:45 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:24:44 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/11] fs/namespace: introduce SB_I_NOIDMAP flag
Date: Thu, 15 Aug 2024 11:24:18 +0200
Message-Id: <20240815092429.103356-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now we determine if filesystem support vfs idmappings
or not basing on the FS_ALLOW_IDMAP flag presence. This
"static" way works perfecly well for local filesystems
like ext4, xfs, btrfs, etc. But for network-like filesystems
like fuse, cephfs this approach is not ideal, because sometimes
proper support of vfs idmaps requires some extensions for the on-wire
protocol, which implies that changes have to be made not only
in the Linux kernel code but also in the 3rd party components like
libfuse, cephfs MDS server and so on.

We have seen that issue during our work on cephfs idmapped mounts [1]
with Christian, but right now I'm working on the idmapped mounts
support for fuse/virtiofs and I think that it is a right time for this extension.

[1] 5ccd8530dd7 ("ceph: handle idmapped mounts in create_request_message()")

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v3:
	- this commit added
---
 fs/namespace.c     | 4 ++++
 include/linux/fs.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..d1702285c915 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4436,6 +4436,10 @@ static int can_idmap_mount(const struct mount_kattr *kattr, struct mount *mnt)
 	if (!(m->mnt_sb->s_type->fs_flags & FS_ALLOW_IDMAP))
 		return -EINVAL;
 
+	/* The filesystem has turned off idmapped mounts. */
+	if (m->mnt_sb->s_iflags & SB_I_NOIDMAP)
+		return -EINVAL;
+
 	/* We're not controlling the superblock. */
 	if (!ns_capable(fs_userns, CAP_SYS_ADMIN))
 		return -EPERM;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..6ff547ef21f2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1189,6 +1189,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
+#define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
 
 /* Possible states of 'frozen' field */
 enum {
-- 
2.34.1


