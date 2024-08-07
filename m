Return-Path: <linux-kernel+bounces-277180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C45F949D88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680F41C21424
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A56D18FDAD;
	Wed,  7 Aug 2024 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ixsystems.com header.i=@ixsystems.com header.b="grcg18Ef"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D0BE4E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995950; cv=none; b=ddelEkVITuwzUvloeUj+pePUGhP+bWbCuGlP4C96BCfRmCjVcVlWHxXBVf+VDDMn22mdzILG7hLLweCmOJeK+oRDJxvvC0rjxyN8ZFLkixIXwj4YsN7k+XhXkZXx2kmsZvHSf8nAfeuDQ4g1h7um5lyvWbaSFjHHuEErUrg0muc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995950; c=relaxed/simple;
	bh=skMbL4HeJKvCzlDBjA0ZutSBXr/oskyL0uj+M4mKkDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Svv9TW0NGDtTmO3XYj3ztciIscmgPKJEXecrFbPG0SCoMaL0CyumbbySTFivQg8XQkcSINhEEgyLoat73h1jglOMDn6b4fPx8ustljJGQxk30DBGT4qldi5iY6QuWQdf+rLTIhsFWyAhcIERT9TvSZfjfmqV6TcLUY92Y5WwBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixsystems.com; spf=pass smtp.mailfrom=ixsystems.com; dkim=pass (2048-bit key) header.d=ixsystems.com header.i=@ixsystems.com header.b=grcg18Ef; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixsystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixsystems.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so1062739a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 18:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google; t=1722995948; x=1723600748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SCIPcCSDa/PEPZmF24DhQG9SXXfINSbv01ae/ezl4x0=;
        b=grcg18EfJ7XF54dE1Z7NxClmHB1pFFxzS8ZHdy++UBdBcHvyZ5U4oezCCs8+ZTDcVl
         ZHlmXOsxwiX9uUr5mLAaOQ7MMXgw6mLBwVEXGkTwt13xxW8hFVFu7s8X3x4gWoDy9LnP
         JbnENHg6VzCGwDPoxQy5Z/JDemwNjG6UYFxPbK8Rb04GAifLSFKbKyw+VRbkTAUMmR/t
         G4kbHxmcFamaC3vEUySCRC4dr9Ngh+IHpXGwJ1T9TZybSkQX5ODkxVg4GHfH2qUuifOD
         7hhZfnXkhOV3YyEAuX9FlQD2VnF2wKjIscl7KHV3pwVxi36mPDtCqFTw0CPwqSX6McfX
         p1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722995948; x=1723600748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCIPcCSDa/PEPZmF24DhQG9SXXfINSbv01ae/ezl4x0=;
        b=pOTNsFl0+SxkqshLtgCPBg2M3NqtNKkqG2Byf/KojisHPs5YHsC4Ah/xYCFXAhbBCv
         vsq44yiGFT7lKBV0Vc20Jnz9bNfEr2w+eJotW56I9+vVWrp/7g6eHB0UROiFpChpgaDz
         /WvGA3Xr1G7YmIBqfNADLvh/FL9BRvOdW33jYB9qlRtTUo4My3lTvxge2E5fp9OWbYJ8
         xyUKuyZkkzpLWzNMzykiGFaH11M0AhSmsPFYHgwgASqvayYR975/vkDCkOnKAYzVrh13
         a58HDLYjCjy3wtCrkq9YEra7jyYgVrW0YWpJVuGgA1yqm4OOZUkJJT1HohkwRzxFPQx9
         EPsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZarhwWUk/p+2GWhr51KESLdbRUsLVu73FMnm2PRW6EjTggrQDZIj+6Z6pvy2J5uyBgXsOtjZJ5Dd5UJW8+4ZG/qua4zzR/Hu0eAYk
X-Gm-Message-State: AOJu0YyquyFIg3TiuvvcXLLmo81khkIYW/gIYvzF10QjR46nEq14riBN
	2JHm9esT/3IU4vIv8nDfRCX8jvHA0K+a70h1C/kr2HmZPz/gysijAFq/d8TKyw==
X-Google-Smtp-Source: AGHT+IGgoRPV9X4BvPZbIAPUX5vt+UcpWRpi4UuFqMbgHFTS0xMqohswYbEz1lvorjjyQD99FiV7GQ==
X-Received: by 2002:a05:6a21:338b:b0:1c6:ecee:184c with SMTP id adf61e73a8af0-1c6ecee1963mr1205795637.32.1722995947116;
        Tue, 06 Aug 2024 18:59:07 -0700 (PDT)
Received: from localhost.localdomain (c-174-62-124-140.hsd1.ca.comcast.net. [174.62.124.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905f85csm94345695ad.160.2024.08.06.18.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 18:59:06 -0700 (PDT)
From: Mark Grimes <mark.grimes@ixsystems.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mark Grimes <mark.grimes@ixsystems.com>
Subject: [PATCH] nfsd: Add quotes to client info 'callback address'
Date: Tue,  6 Aug 2024 18:58:34 -0700
Message-Id: <20240807015834.44960-1-mark.grimes@ixsystems.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'callback address' in client_info_show is output without quotes
causing yaml parsers to fail on processing IPv6 addresses.
Adding quotes to 'callback address' also matches that used by
the 'address' field.

Signed-off-by: Mark Grimes <mark.grimes@ixsystems.com>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..0061ae253f4d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2692,7 +2692,7 @@ static int client_info_show(struct seq_file *m, void *v)
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
 	}
 	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
-	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
+	seq_printf(m, "callback address: \"%pISpc\"\n", &clp->cl_cb_conn.cb_addr);
 	seq_printf(m, "admin-revoked states: %d\n",
 		   atomic_read(&clp->cl_admin_revoked));
 	drop_client(clp);
-- 
2.39.2


