Return-Path: <linux-kernel+bounces-410410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B19CDB39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB411F21B20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB14E18CBF2;
	Fri, 15 Nov 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5I9e5Co"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FE188CD8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731662034; cv=none; b=RlR56MA9oQKaA0R7I97nwud9Wxqui4frHHGP7EmEOWSY4ozrTnTNP+MwNstAl7oW/3T4eZzYbxBifiAsDSftMI9ahejjrDBC2tRXCkFYjqVvUkxrL5BbFjf94adnpMpFUab05iqhoGJcULEXOSre4qBxF8dUjpUd4pDfTjwsqVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731662034; c=relaxed/simple;
	bh=1gpbH+F/EyAt7/qdUtEQNzUhRagbx8xAr7oPVt5RjTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ufKPQoSIGsyPdQwE2VuAy8BT+K/XLMERvvP35eMb3MI0EGkkRI7NBQjvmgK9FoCpaG9ltesPcl4F8EyZkk0P3cDvHCTFT7Hxh3e+73fgA4ghYMuKKt1IGeX8ky41iuzYsAAbRe+G+HM8KRWEtp2Z1DLbW+s8FLY/vkic+/JVNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5I9e5Co; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-431616c23b5so8904275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731662030; x=1732266830; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8COCFgpNqgb0Y7Anvsa8b6bhjh2JHm033ij5t0kw0Q=;
        b=R5I9e5CoPM/aQPgX41XFKdbka73yFh+88oqZ/9hJqCCj+0y9MQRtJIX9f+wRfDaHLv
         KiVC8C4n77YvLqMopfeX8Lk6JS/QuXvG0llSlpBBZAcqvZkr1fkLFjj+UtGw83XLgpCI
         Obw0F1/nuX9CdXbq/YplY36vIqKtuDzmtMa8nuNocUaNnqOcBs41UxHVP1b20xoSkZY/
         t2MOCoWP8/Ff3xRbxSafG0g6mKXekMr5mzPGmns7nljistl59aD3RKjWsR/B0+FZA3mJ
         514/v9ROijofCtf/w/U0ifxdYgyeh3QXNzXdCPhVfnpvDd3oqbphHkDNfhw0eT/ipqD1
         QV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731662030; x=1732266830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8COCFgpNqgb0Y7Anvsa8b6bhjh2JHm033ij5t0kw0Q=;
        b=M3GA0RJuMF9v7cZSapZhJEgoKuPlTVz9bXUY6j8oTqdsLuxTZHdeq3WWT+JPbAcIvH
         Kelq2C1IJTpgnIKW7rdZBfUq6tXVw2xU/K7QC8JKPc8faZuHrBfA5TDzuz70XwCwypR3
         YYGSszwyeVLXGrd4d/UaSIGnB5PBx3oxatI3IQpyX0svUF9FZlQqh0Klt6glrqp5KyoU
         Y2k2xtxDZ6dDQ/hIjtfnvToV1YJ7/K+uPzCcWpMVX6ctxK14BlihLErweAJLPPpFJ5L0
         Tgo6ImmsjvJ7xxPP4PsMYUry8Flp35QxrUMspHQdbGDzRDSRWeXAFpVK/Pq4EIYmSfa5
         9agA==
X-Forwarded-Encrypted: i=1; AJvYcCU5vfbUcCtFXDFMpzfBzNHOSU3souRrtorLCF3iPWLreVSo4J4omaOSLQF0rRJoVUzXHgIOYSs1hCAREAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGEe5kWWWg7g8bU8Sn/07o2v+o1QOkmYeVy5lc2IRCSXXItvL
	EFDUZz62wgUJSYt8dwWpFVt4S9lZgOoO24SN2t55qj0n4OoLXbLiZ1aHfD6eeSw=
X-Google-Smtp-Source: AGHT+IFDwyeF9NdbO3uA8WPZbwIsipDKiK7gl4rjQvHP2ciMl3NTCJLQxQXZjpw4OVLXp1FI70A9Yw==
X-Received: by 2002:a05:600c:a4c:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-432d95ad53cmr54878725e9.0.1731662029843;
        Fri, 15 Nov 2024 01:13:49 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298c81sm51915835e9.39.2024.11.15.01.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:13:49 -0800 (PST)
Date: Fri, 15 Nov 2024 12:13:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] netfs: Remove duplicate check in
 netfs_cache_read_terminated()
Message-ID: <dfc4ac23-88eb-4293-b4dd-e617779ee7ac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There are two checks for "if (transferred_or_error > 0)".  Delete
the second check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/netfs/read_collect.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 7f3a3c056c6e..431166d4f103 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -597,10 +597,8 @@ void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error, bool
 
 	if (transferred_or_error > 0) {
 		subreq->error = 0;
-		if (transferred_or_error > 0) {
-			subreq->transferred += transferred_or_error;
-			__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
-		}
+		subreq->transferred += transferred_or_error;
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	} else {
 		subreq->error = transferred_or_error;
 	}
-- 
2.45.2


