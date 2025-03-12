Return-Path: <linux-kernel+bounces-558482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBFA5E68B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDF5189859A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981891F153D;
	Wed, 12 Mar 2025 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oPZTfyZk"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622381F12F8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814582; cv=none; b=nIzikmf+2S5F1osyj9vQViOxeTXFtOngFryD2rWIHUXDALWGNyaafF4Jt5TrLMcdPGKUfnKV/JDWoSenv0eEabX19bvNkRw/bHF9kd3BmAT2QaNA27SlQo5e8Ld6gda/Geyu5dGluAcVgidhYsVubmnBtUERJi6JnRI29FIUu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814582; c=relaxed/simple;
	bh=nQa75EiYN3ygFHWP5CltgBdCU2YvLoFl9S3DeRklaTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMOVHQ4i1ccqzOa0bDUjT2tJiSe68q8LsH489d4E6jFCaxsxTb7aFenCmxJ9Dt5TOJId2NCSkKq3Bqi9mEtsz0sGuWfMV6vBk5xwCCV0frlbUfpeL2cCK9U+SjuOhiEklN6O0FkxX4fTKhx9oahkbHc8I7UU82eKTxPtcllukSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oPZTfyZk; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1AAEF3F75A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814577;
	bh=sxXlT+NKuH/R8o+IpND8qEtQPr3+MVFoHvHlcLQeNOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=oPZTfyZkG3nK6Ke3V03kcoylP3G8dBLsS6lUvTeOgmtV7zHW4IEzi8Yr4xDQ29L0O
	 Tc4ThwbLlkrcEDsx0jtWr2UjlomoBNoxjICvEt03YQL4MbSUtNYD4NK26bofnVtMDN
	 +qEcJWrbW56pzagNvte4O4/Qvu4vrTROYN8kP82QiPnAKsXIO25Ul24qhTt2Jspbj/
	 ilq6UfWcbYPqZUTOrGCAZEkbWRuIb4J7+tKgZS7z/oCxWGMnfoOdOxzn8KQDvQcDt7
	 EguZr9dBNVGF3vzJ6AfpTnk8rKyTP+SD3sswAmo0HVCxKqdFe5vXFekWoIM8AxWsAV
	 uSL5OesuozGKg==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so501241a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814575; x=1742419375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxXlT+NKuH/R8o+IpND8qEtQPr3+MVFoHvHlcLQeNOw=;
        b=YYYwlk/spZzLf5m5EXPjy51UUh75lqTo6w5LFj97FxsbxdyujxmM5qnUgbAKqvrfye
         qXVvszPCdNQsl/q0zodyw1S333nJcKWwZk+EfNHdkSnm0aNYS+cuXXKsHzAO+iYVaCuj
         F51yP2LViLKid+FPqDe5LUSHCBIE1cQFwaaMQCevgFEH0fijiMthoHsYSF/IER0zFkfM
         yotWJMAt4piZcaTwvs2hEaJSgskdzNcCaEzcoEzeW6Rs0zwfgc4njiS/ufxzMLGMxeqE
         RkOab1cwfNxFOFiRUW3P8GIt96tmsThSZKcumDUB10dDajnxeKz1cFRvT2FZwnFZw5Mn
         rrww==
X-Forwarded-Encrypted: i=1; AJvYcCVu83w3I6mEeHuHZaHsGwir2CBWCTQSItP+mW1wh4/8SnT4lS0csK1MuoQFZ9U9zRje9Gs0BPLa/unwXnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Si3obCzSPC/az80/rFNz2mGPqJM5ZMVOfxM/o+TwFi8sIVns
	Upy7eOAS8N9tOMQE4qZy1a+Dges/62CnTyGepM9OLFsKACDYZRI/YgOkFzDoI41M/qNHeuDf1Pd
	0abfjLbYlJHgt6VP/RKkLLQ2pMj6p1roP6TUfX9IsKH7fyEB8kQolksl9+puIvDfrolujukQcLE
	XalA==
X-Gm-Gg: ASbGncuVnfDV4+1573lCNePeKq6dHJH0HqH/RYSHZpYX7H7+4mrmjPeb8QIQOcLcj0m
	2LvtpI7/dX8kzRwx+SftIfoGLGAWsoy4KqY0zDx7LeaneRXxjHgVOMSav7ZxaRf7azvvcCN1yiH
	Qq9RNhsjy0oMkK2Ws9vcBKitNct12BnXDEcl5Db3pf6F8tKjmbk6XtXkphdKmLFLuRuThQqwbTH
	NTci4vY/8gxAKXNX5qoTh6oePmOoV/KCMN8Qbt3aw2p+LGh1OOcis//N8zRAeNsDTGUgyq5AVfK
	crpoM8wWyzbUzNCqq2RqSAGPIZ59Xw/H2WhCkkDdz0+5dnrZNyXlUngSgRI2OKY6e6BCEs8=
X-Received: by 2002:a17:90a:7345:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-3011bcec36fmr4989223a91.27.1741814575230;
        Wed, 12 Mar 2025 14:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7VJ3I6Ag0U5c89zoKAvdV8xkokC+gkGPKK5VTC7ZbVdDme14D+x+zHYl4u3ZWPKhOLxMFvA==
X-Received: by 2002:a17:90a:7345:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-3011bcec36fmr4989199a91.27.1741814574931;
        Wed, 12 Mar 2025 14:22:54 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:54 -0700 (PDT)
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
Subject: [RFC PATCH 6/6] tomoyo: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:46 -0700
Message-ID: <20250312212148.274205-7-ryan.lee@canonical.com>
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
 security/tomoyo/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 8f3b90b6e03d..efecfa7d15b2 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -762,6 +762,10 @@ int tomoyo_check_open_permission(struct tomoyo_domain_info *domain,
 	};
 	int idx;
 
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (flag & O_PATH)
+		return 0;
+
 	buf.name = NULL;
 	r.mode = TOMOYO_CONFIG_DISABLED;
 	idx = tomoyo_read_lock();
-- 
2.43.0

base-kernel: v6.14-rc6

