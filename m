Return-Path: <linux-kernel+bounces-393693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A649BA41F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B2E1C210B0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4C41632E5;
	Sun,  3 Nov 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YXQCKCWx"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D615D5C1
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730611499; cv=none; b=gdzCoRz48vCFI3UIm06fP8cPO0fKsF/YAU6BdfgB6/sIL25JA1c7jpefK+RYohUPnnNDELuES1Op0xlS1AWduiJ1JWw3wBwwsTzVE+E6WywosiF5ZX6cyufGgP/DlLGA+kxr3o7ALD9In8sjmBtzicJ24rb2nU6yeFt0dXW24Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730611499; c=relaxed/simple;
	bh=QMGh9V+fCN/j+D0uLjcnIHw3s7shm5dxlUbsYTeYPOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hWctAX/bzoH2StXtFtHXtagdqLPvJM9cBw61rIfFjG3WkdfcvEsR2Zb1UlZBXNp/O+YsxoFHL4b2lks1tYbpCYvWZx4Udc7xI62Ofy8cEyeSB9Pb21/Nmz37+Y4/ttXAAdIXNbjS7yNVMK2gyIIIKR/PPKZEPtIF0CF882RPu9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YXQCKCWx; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f12ba969ccso77461a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 22:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730611497; x=1731216297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=YXQCKCWxTVrcPblnRs/RmrE5ZzICtpCGVovI1D5N9rS7NN6TNA27CdAbQMwvjK27Pt
         zYUSicLe8+WNJXjb3PfI/Y3PPaIzIQaIHM1qy0mdTwcW75ZihUz8E+e9Luu8j0mDHeAS
         asI8KIPAZEgxGN0j//q4ttipaFCEkA9IqAMlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730611497; x=1731216297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBpeWwUMYPpQhLDdrb3cMWwRM83RuSfCI6YlvdtYdM=;
        b=ceqwXIeInkbNeF+vy5+ypYvM2DWFiy3YcXWHHp16qlJ2kMEAnolzlkr9CdjpI+TkDI
         PMsNQGdchkItkIrZ4xZso6Tcg6GzXQhzz8FjWg64hKFBmHUFZOsbqxJcBjrXB9YQJ7ZF
         jn6WF6iffaqH1dGmYjjRprpEfuUXvOsyR4KvIYYGhz2Q5uIIrHuuwg3OCPINsCYVdO+e
         GSpmWsKL1kL1U2E4EQtDfjEVVqFuz9ITs/qeWeaHu5xc9vebLFQm6y+b3X5amYIgBdye
         0jwTtl9vYi3UcG0COAh1B/7ne3LGbZSC+IvbogcSazH30abZLb9EEgnw2u5bKeGKe8DE
         Jfmg==
X-Forwarded-Encrypted: i=1; AJvYcCWeBUXFwHoCrIHFBMGbSNe3ArH5Jpq2j0Z4fj3kqBfa8dxSYE/zt3gAvCgMhoXU+tTlFEp/o0PX5fsDtSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtev2fWUT3wc2fgCmt5ZzUhDEp/Zuj6dSbKPT/Ok/FkxJWpXY
	DnP2QqWQpTgZh1zmtVqhgtn5eRFTUSoj+UY5v4v+Q415UP1LNRNeKsCTXYwEGyw=
X-Google-Smtp-Source: AGHT+IGj67LQzHccSPaoNRSSYU6or2x5eE08VEYq8Ivkb29KJsMnCnNhiTd26q1ONYBfh6ziDHgzow==
X-Received: by 2002:a17:902:e808:b0:20c:8f98:5dbe with SMTP id d9443c01a7336-210c6ae3d6bmr369676635ad.33.1730611497060;
        Sat, 02 Nov 2024 22:24:57 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93dac02acsm5896036a91.27.2024.11.02.22.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 22:24:56 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 4/7] eventpoll: Trigger napi_busy_loop, if prefer_busy_poll is set
Date: Sun,  3 Nov 2024 05:24:06 +0000
Message-Id: <20241103052421.518856-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241103052421.518856-1-jdamato@fastly.com>
References: <20241103052421.518856-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

Setting prefer_busy_poll now leads to an effectively nonblocking
iteration though napi_busy_loop, even when busy_poll_usecs is 0.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v1 -> v2:
   - Rebased to apply now that commit b9ca079dd6b0 ("eventpoll: Annotate
     data-race of busy_poll_usecs") has been picked up from VFS.

 fs/eventpoll.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1ae4542f0bd8..f9e0d9307dad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -420,7 +420,9 @@ static bool busy_loop_ep_timeout(unsigned long start_time,
 
 static bool ep_busy_loop_on(struct eventpoll *ep)
 {
-	return !!READ_ONCE(ep->busy_poll_usecs) || net_busy_loop_on();
+	return !!READ_ONCE(ep->busy_poll_usecs) ||
+	       READ_ONCE(ep->prefer_busy_poll) ||
+	       net_busy_loop_on();
 }
 
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
-- 
2.25.1


