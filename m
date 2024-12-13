Return-Path: <linux-kernel+bounces-445117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF79F1194
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039AC1884999
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508381E32DC;
	Fri, 13 Dec 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AAeHJeZd"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B961E47D7
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105372; cv=none; b=KKSTVmfWNfKDp0ZKAb80L9AagiPoxxKv/H2+walI7tKaERThbcIF0wN/FJaHQN7Mzq8deed8vgrm4W/mJYVxyiZFUMYGxx+Qhajg+slXHZujZbEg/xoFu3tsSLL7BzvSmsTpi/UOALTtVgw6PTcuBFEXoQZP/MYpXCb9pc2AFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105372; c=relaxed/simple;
	bh=SKl6hxJdy3uyJbhZpOOdAiYhB+0FB2yQzq5XqnnCoF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBEOr0Lo3w4tqdw8NjL9VL6O6K7TQQrHb4r5skCYyDZwGiZVj9g19r23iqIhhvud56wa8gVuUrmTKGKnboQILDcL2X2/OwaJFBNBVfpZB6C86aiZ1AR1TZxaW82ToWfy5o1IM+FNG+ER9h1tYeU3f5AoVyDicAb9Pq1RKulNVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AAeHJeZd; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844e6d1283aso39025139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734105370; x=1734710170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz0Pdg9jqnEJMYLqH2tprv5bkemx7uetlhB6shaJiPY=;
        b=AAeHJeZdtfP/2H1iy+ldIoEDGS54o7//Dw0LyEhQdwB2FK9yFFGFcrabdhflnp0wSE
         r4/OU71VRA2b2GHywltcJnJlEL1ybczlTCu7MiRyPZL4gHKbl9uq8e/I+jYAtiAR0p8b
         /HSiDCDdIwWN2KJ1ZA7CVvimVvrQK8YBnpEeKzchSpnBKlVDSH4xXiwlMNSs+rj7CWQn
         /ZPx9n6tpXNmdHn+5S2uFX+cZJDFowx0rXuu50y3DH2XqOyofqO4v32vjRTUT1OuleQG
         PEMbCUTiTt15tdYbNozMlbAvfmBcw+52Y+IVA1bOp+woVNHYK3HQ5w9p/BDSOI1UnKxN
         QM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734105370; x=1734710170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kz0Pdg9jqnEJMYLqH2tprv5bkemx7uetlhB6shaJiPY=;
        b=KEYuPxSy9raQ54kvkeRTQzg/dPzAsKFlx30uNjaAzl3JeNtokihiLkBXvus0ijyAKS
         uH2DerJkyC7su3XnIxOQe7WR8NzgLxKbLtigyXQJBXUW/rP/RK0uOp7Bm6zLjmU+jAYO
         tY7bFIwPzEKSh8tGw9GOyIhyBEz6I49TXLrzMiy9wvDELguLEVXJN+i5BpWYCc7s4HgR
         zZEiO8rVWap5UlY1zmYAEGer1crUblKy+8uUXg4CScCh6LyhdRnvdbtgPst0uWzNQGeg
         2rud+YC7itSClNYUGjZLzy+IvhlxBdVWD2zFI4LCvYcvUrBU5ViKwSjZ710bB1ZU0S6C
         qCng==
X-Forwarded-Encrypted: i=1; AJvYcCXoikyW+M5kyYyHBYmzb7ygIvXjzx9zlfdITiB0QMkpGj0w00ET11T4fTDEiMYUEuR9m3Yo8Bu6705dqL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3F9300gnUyyLDtrlDreoLX0qIXgh4p4XT+wP9E3QJqD7R1B+
	kwBjV/mIHdtnDxSPv1DqYNYH1hzNr7JAVdNhuLJFtSaHSjEyKxWNL/HEFxwhGrE=
X-Gm-Gg: ASbGncsCFvuWUpyQXbLb9UbSJlDLbIBNhxz+AXuo+1O0XdLU2NJiCVdyAHehn3+Rkoi
	MuSV7nJDx919dXxM38+dw5uXT9nz0vRq9pfemsVtWsQ1hbnIIWu6nlLyXpeddvCArqrBSTEcg6/
	eE1J6kOyhr+Ue3lc+blals9nEMw7ZVA/LE5YxCoxYuu5zJzD50vsLcQQqP4VcnbVurpn0xOA9af
	VTkREspdYHzYh+w44CWwmKASCD4y0FihmtjWxij5bVLZVezxF0SA2gIAgyr
X-Google-Smtp-Source: AGHT+IHcUplw3Q6ECt5DnQxOZIMw6sSCxN/kZ+qm1VNkzK8N15/r675oe1NRLkEoEeFprb07mxKCyg==
X-Received: by 2002:a92:d10c:0:b0:3a8:13d5:bd2c with SMTP id e9e14a558f8ab-3ae61f23bb3mr46583235ab.2.1734105370422;
        Fri, 13 Dec 2024 07:56:10 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a9ca03ae11sm35258405ab.41.2024.12.13.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:56:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 05/11] mm/readahead: add readahead_control->dropbehind member
Date: Fri, 13 Dec 2024 08:55:19 -0700
Message-ID: <20241213155557.105419-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
References: <20241213155557.105419-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ractl->dropbehind is set to true, then folios created are marked as
dropbehind as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcf0865a38ae..5da4b6d42fae 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1353,6 +1353,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool dropbehind;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 8a62ad4106ff..c0a6dc5d5686 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
 static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 				       gfp_t gfp_mask, unsigned int order)
 {
-	return filemap_alloc_folio(gfp_mask, order);
+	struct folio *folio;
+
+	folio = filemap_alloc_folio(gfp_mask, order);
+	if (folio && ractl->dropbehind)
+		__folio_set_dropbehind(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


