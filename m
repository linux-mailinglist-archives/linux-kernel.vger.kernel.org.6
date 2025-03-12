Return-Path: <linux-kernel+bounces-558483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700DA5E68F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130501887FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7AF1F236E;
	Wed, 12 Mar 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dUGjWfB4"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB831F130F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814583; cv=none; b=pewmrOdur7K26WpJAU+9Yb5ivHVesI+gol0a04uX34Z9CLRoilMmUEdkoRzGh3O0lVg8+Y059+AnpUb84ha7ZxNHiYTEY4OfgtrMlc2fO7VO2sKD7/312tYcztOxAAOCUYFTXwOcQ2qmh8Gw5snworlzaqOyXkd93JtLTU7N0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814583; c=relaxed/simple;
	bh=G2e3iolvH9qEslV/akG34i7cS7UuqJvA1p2iiSDOzVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PthjYb635uazI0uc2HJ0fxTT2/YeSktAUk0HK7VL9y002r542DnQXTt6e4gWqS3Sf7UMb+Xuyi0lSrzbvPnVfs0LXBPoTEKWsGoUxkn51NhI/Ryb3izJXojK/Kz7C+HSXwFR4KlKG3yRSdm7KU6PNiB2FFaqzmig97WVoQnE4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dUGjWfB4; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8523A3F1F4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814578;
	bh=yf0KmmK+2JCiuqTR1dE5uJSectdXjdHO7BaOi/Ze5/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=dUGjWfB4MVh6GMbZatjMA6Br1feE//dP06FPzq7TXU9MzDzIAx3Z3YO55Z9FVbWRX
	 7rtoSKfTmY9HOjTvl47BZRrKQYdY+T513U1/TiDHyESuhoXdwHKbkk9yHQ3qWDXvD1
	 5IxJOFJJx2OOzcWwS3+40T5Z+cuA2w8W0Qgeq0pqvxM9/1156qRxcPR6GVvPP6QSSb
	 w1V/f/ddRHretnppcF4LToQHzb8LXMKXTEiXhGnUFLiVfqblI18bOfLdWG9YxxX+KN
	 3izU/eZc809+Od93qfSx8mCC5zf4Vzu1RxVXMiCgG+tlC4HmlLQh0GLl0KdPARHwSX
	 6hgcdmff/PwiQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso2105924a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814574; x=1742419374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf0KmmK+2JCiuqTR1dE5uJSectdXjdHO7BaOi/Ze5/Q=;
        b=OgELPD0WUA/nqYheukmQJAx0gx+6FTQyZ4D2YHWxjZxHsg1UQRX7EkHYH8O3MWUIs1
         7fZB1Hjn/U4+hXpnwdoiZJktAshf07x8JBTyR8pT9pYm45OxUbo+REVoa+VNKIZDk/qt
         slsIHJbkUMcv2sXUciBBZSuUAPSOn7b8B1cH4xcqZU4wGC7ZbwLihI+oUyac1X2ORX2g
         GAMH9tEGPZiniODV0EBXyFmxT8UMO+5oXQS9p5ASmOvTuaXJrDhqlT9LV1jNEjxmw/Zx
         PmyOVAfQ7kHGr8Hm1Qs0oXIglebhSt0w3vGId1MfyTb7ItQxwMWOxodVIorkps4IZ7Kv
         +vSg==
X-Forwarded-Encrypted: i=1; AJvYcCXkGCJS/2Xl3cnpwptjIASs7Gy4cKKzEsu5aZVn6Sa/MBBEdYtc7IKEfQ5X8FYCbAqXbnOiQC6yjpjrThA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQnosdV9oeMaP2gVndy+u9Nv7IoxS7U2Cz01qKYfuz084Ev15P
	vwSv4oUivpfhAX0nQ4CQtxV8mLJPeRGGvfLyPdFmzvg0YvvhyVrE3Ti4h4Zmq95JvyCrU5XJUrH
	QrtVyUFl3SLj/nhCwoqLNKLPE56xo9VO78bbk3cr7Aod1CsG7XTDUqNaaMz9N2D+AufV4Z1wMDr
	lHDWr2xVLmh4l7
X-Gm-Gg: ASbGncu3JfVj8jsm71bnThfShYTc9vCVTUkkOjZHZUavxdn2lfctUm2iX3a9hkQGchA
	v1PnMaRd6UeF0phiXnI/y+7mi62qvw7+gGO5MU53wt1cF0wo7GauMUJ8jCUk1jJ/NPNYCe9xuUj
	chfGNlUHYsqYZ8phGqD7M8t/um7l/ZZuViJSVAxCtfbr6nef0cgLs52xtb2X3O+m2WzkLMhrVnS
	UWEjcTifMsCldXSnVX/7cmN6zlsiL1o6HOhmx/QrvYLw98fxjWxu1UIdN/dgEm49Kyt6gBWAhHx
	F3oHiWOKW7uLUrxUb8uv/uUa6WcnR5ikCurAXm0//8rec/ujbLyfKTQX9W+qukAPBgc87LM=
X-Received: by 2002:a17:90b:3bce:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-30135f6037cmr88394a91.15.1741814573787;
        Wed, 12 Mar 2025 14:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwAw+1MiMC/B8BNZEJ4oppU1sIELS1vCTl7SNsacHdi/KdGlgg9CgoB/KGdKxX2Zf2vFxSyQ==
X-Received: by 2002:a17:90b:3bce:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-30135f6037cmr88319a91.15.1741814572564;
        Wed, 12 Mar 2025 14:22:52 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:52 -0700 (PDT)
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
Subject: [RFC PATCH 5/6] smack: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:45 -0700
Message-ID: <20250312212148.274205-6-ryan.lee@canonical.com>
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
 security/smack/smack_lsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2f65eb392bc0..c05e223bfb33 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2062,6 +2062,10 @@ static int smack_file_open(struct file *file)
 	struct smk_audit_info ad;
 	int rc;
 
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 	rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
-- 
2.43.0

base-kernel: v6.14-rc6

