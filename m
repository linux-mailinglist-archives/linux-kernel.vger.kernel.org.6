Return-Path: <linux-kernel+bounces-286385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E80951A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7491C20BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1060F1B9B23;
	Wed, 14 Aug 2024 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GW+JoGSF"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BE21B8EA3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635703; cv=none; b=chuH569ix3vZ6hg317Gpha62Gs+VrvBz9Lhob3k6JCQfIg0LG8/zIvhBchdkUseWOVhW2I1VSePMZ8Eavlv+/SyqkPF7UHqhxu1I9w6rkO673cGBcigXSR4CGoU0lJAe8xHJa123X5/cmCvfIuW/JtmA0nIv544bUm1HaR60ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635703; c=relaxed/simple;
	bh=ItY86ikXLB5CiOOsAivB6bVSog31+kYXgujXhFdDat8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YUl8jcPGJRwPXYAzSPJoZlQ5iAda3MeNrrq9m3EByC1IMiW0lf4wXZt3Ypf7ZnQ7KiGHJyt5WqULMHftYlw6GYPxilG5kFTTmNji6C+gt/DGxrQI1sals/xp5E0T9/yc/hKMVSbQTVswNnXjROyaWCdgjnN3sEpOiY7m50qAfaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GW+JoGSF; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0930D3F0F8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723635700;
	bh=AKgOJzf1FD6sazbw1kqXlY4ydMZMTG/q+wfid3Wy6NY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=GW+JoGSFctlWaIynxyhHWIYq+Ha8p24ifX4AkHPSgx1V9uSHQ/1tE90m19WtI07kj
	 +6NW076IeWYuH1fjdz4xatXPIlvIxWNrk8cN+SvUgHsFw2k4o9Q0Qxx3pTzW0CUczl
	 yniTlMyGqrhIzhiWLpc0lbFDkWQGBTs+cw+n9CRjdDMzUPR24neTwjU37oIIelqEK/
	 lMJo2NNf4CoNEVR1amSKzihPqr+Avkktmm9ED7Q1CJkqkZrOYOaylX5Q2kq6tV0OSd
	 iAVIAw8ejcNu/Xos+wHFgGjmegSrVusMcstHouAj8ncd48/egTsBopL5nCX/VWx/+A
	 ZR1KFEhR5IxKw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bb35b28f82so4575147a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635699; x=1724240499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKgOJzf1FD6sazbw1kqXlY4ydMZMTG/q+wfid3Wy6NY=;
        b=D6YO8A8xG2lgEZ9X3rtjCykahBUYVy6eAE/sp7oJz9qPo3mExyk1x86iEs3/AHesOJ
         PoktI6+eObDYMtY4zEDpZJ1Lek06oWCM63fYnoLw7wXl+Nf6GQAq4lpJ91OQ9pEhImZv
         I//4QMcnbIzrJ1oOtXCW8CkvKA1FzgPra1gnJBs7YCAxs49o5vjWy/OUz9XR2Xq53bJ3
         VBukcI1mPOthhmdrWNqGOtacV5ikTIvKr0AvDEZQrfYdRdUYhHmGMuGo/OAGVycCeMTO
         Dq7Bz5I2PnYQQ2AAUEUc664qto/PrPEaxycJ8LQECr+s+eacKU7kFzkPtf7CjDz/1PKd
         IHyg==
X-Forwarded-Encrypted: i=1; AJvYcCU86N8WzTuWD6a/btDJh/f+p1xNUNS5OFlwTNqOiOPTRCUo6hjU5cLKxotQt14aHXQ4597hVeTbM/3lMZW/mbkMr+L8JSio7CXdiPxu
X-Gm-Message-State: AOJu0YxBUHsasY6Cbfbe0x6G/6q4RV17CHsxsH5A59qx1zlPcQW2GdU4
	Zop4ZyakrfxIre9T+LTlLpFRd9KxnC1auRuExMpvax/C5i2ZmEonUzQ3oQBFFnQSym4A/hD0nAL
	U/zVHdQn5qQ+BDTzdwZUGnUuEgdHvK4CCvK4O9ayVitJLsx9nW6pdWbptk3YfJG3oFou2/2XNKw
	ymbA==
X-Received: by 2002:a17:906:d25b:b0:a77:de2a:af00 with SMTP id a640c23a62f3a-a8367026317mr187631366b.44.1723635699538;
        Wed, 14 Aug 2024 04:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5139C2GtCKpY//YiiF+7oG06NRNE51BKEi55w6sj5WoOK8gcp46+pzNqcXQJShEtt5z7FGQ==
X-Received: by 2002:a17:906:d25b:b0:a77:de2a:af00 with SMTP id a640c23a62f3a-a8367026317mr187629066b.44.1723635699193;
        Wed, 14 Aug 2024 04:41:39 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa782csm162586166b.60.2024.08.14.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:41:38 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] fs/fuse: support idmapped ->set_acl
Date: Wed, 14 Aug 2024 13:40:32 +0200
Message-Id: <20240814114034.113953-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240814114034.113953-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's just a matter of adjusting a permission check condition
for S_ISGID flag. All the rest is already handled in the generic
VFS code.

Notice that this permission check is the analog of what
we have in posix_acl_update_mode() generic helper, but
fuse doesn't use this helper as on the kernel side we don't
care about ensuring that POSIX ACL and CHMOD permissions are in sync
as it is a responsibility of a userspace daemon to handle that.
For the same reason we don't have a calls to posix_acl_chmod(),
while most of other filesystem do.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/acl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 897d813c5e92..8f484b105f13 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -144,8 +144,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * be stripped.
 		 */
 		if (fc->posix_acl &&
-		    !in_group_or_capable(&nop_mnt_idmap, inode,
-					 i_gid_into_vfsgid(&nop_mnt_idmap, inode)))
+		    !in_group_or_capable(idmap, inode,
+					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
 
 		ret = fuse_setxattr(inode, name, value, size, 0, extra_flags);
-- 
2.34.1


