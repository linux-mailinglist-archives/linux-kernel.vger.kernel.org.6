Return-Path: <linux-kernel+bounces-425890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC79DEC43
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0969B2193B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3B71A0B12;
	Fri, 29 Nov 2024 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwPj6YKi"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0514A60F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732906613; cv=none; b=bbO2R81QV62VNTEigIUJFJyUZB5kHduCsYWmNrB9LbPokVT+Y0zEPtgl+LaMMhARHyoBgPVu6oQhMaKU679CDDeM9VogHdjkJe/hkfHA+TdLq1TGgmiO4n43kpe8H7hURDxzMtzlxDDcDzSCdw0RmC4fzNAHHbDTWgDmoVeStLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732906613; c=relaxed/simple;
	bh=l7WvbTtMYsH+NsX4psnONR+tA3CJuYPZU/C/SZ2q9e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDGo+3y25oWYSdw6awXck1fypA0jtueE1xdQlQuWapbNU52jTvoLOgTTCT95xXY8xQYThZKJAaQdJviMTrpf8Z+UUvIgcaL8+ybHLV884jRM3UKlf2/1atXDllHVczUda9jlUYmaluktUdqHZzUmc48QPNQUd/TGi3ZfJOKs0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwPj6YKi; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ede8c4fedeso1777903a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732906612; x=1733511412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzPuQk3ZQ6E9JagPssZlS/uY8SuiQz+WhShMT3H3dhg=;
        b=kwPj6YKix8M6ORl/Mzxdo77f+VvBV6crZCi2jAB6wp14bq7QQdHxiA+9w8n6ONK+US
         UH1M94X8oFC1PS1+dNQlXADc4TwQcvezC258mLW3kb8nqbw+lK5nx/ICxr/ifX5sH0vs
         tgl8m1+8D0bcI28zGw2vmAi51LEYQFbyNi3MY6ZeRUrRhhy8u5uWHOtV6cYbnFxodIJR
         nh9YhEOHQUlD81vFwFc+Z4VoJuXRDmNxrtDpYWhpI73cSy0YtLl9ZuNxMgOgcW6QosOh
         g+QdybVJVtfBM3LDRDmrVq8RzlDRsUZDev4Jy80Nm1J2GD4zPKmh18zyCbKmMBOLGcDh
         1O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732906612; x=1733511412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzPuQk3ZQ6E9JagPssZlS/uY8SuiQz+WhShMT3H3dhg=;
        b=HoGSZirfVZwV35/FreDdRczH1hhYyC+iFSCJ1mgik/h/ePsfwTNVBTaSsTrD2S1WI+
         ecaep8tKdiUY4D4BkzV6l80wTB4b+KGbDjk7nT1MzToRV2AJd7tmP94gaoQnlXWLalY0
         AhwpiS/5/D2BXx18TXTCo65Bbtx+EWxqsxQ7QH0VCDgJf14iTRVYcMz8+OA4MjOxF/j2
         /I3ZnRKGtfPuHh4jHw7f9mL17LjKcNLnPCgkbY0MUo3w/rwHgEVSmFgzI68tQ7fHQxem
         aO/QuKlbIekHmO911dg2VQalRXKR6F0bqWUNXjQn1oxgI/0+nhZ4Cpcf2H7lkHQ1qul6
         c5kg==
X-Forwarded-Encrypted: i=1; AJvYcCWzZaNYdMFi6wPNLdWcUNI1lWmIknX1Rq8T2zKXtqQbWCjZUFz+HDpAk+KkSCFEghW0gANIbYGY9eMpTtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznNjCyoX3Q1DqwepOyRGy52jgGty00fPCQShu7mcW44Upbb0Ce
	3KXp6Ahb1BcsrPsf5rMwbmXq1KByzTPNEDSJ2AK+LmxvKKujTIHe
X-Gm-Gg: ASbGncscsXZYOZm4wrpdPZilQ9/5fQgDQwSdBqvwxsgNQfz0IszcBWtx34AyzodUSC+
	vlDr1waXCS21G6H6DnI01TZ248Z+BfGyg7nnYOAjR1/l8byBQYIGebDcVJdv08KnoYyvo1NXB+E
	hlzjlsASK/2oDRpHJdsrMtPKRoN1TBFm5D1mrFx4cUuUomkok59hLcCRBpkhZmSYixeUlU67VXP
	h6OSIzTmYqTVFGTlzadUBxjm+6vggJGOoPvxHsNGaHri5Nvr3wK8bp6bVjAEwiAQw==
X-Google-Smtp-Source: AGHT+IEQ5B46R7s78o1UFrbgGbgPRQC2H4C26jFLulnenm8fn3q9cgoa3G+RaMIFtl7McLRHfZGKcA==
X-Received: by 2002:a17:90b:3845:b0:2ea:97b6:c461 with SMTP id 98e67ed59e1d1-2ee08eb30d4mr17333769a91.16.1732906611724;
        Fri, 29 Nov 2024 10:56:51 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:21cb:a5d2:92cc:4587])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417612f3sm3960330b3a.22.2024.11.29.10.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:56:51 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	anupnewsmail@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Subject: [PATCH v2] f2fs: Add check for deleted inode
Date: Fri, 29 Nov 2024 10:56:41 -0800
Message-ID: <20241129185642.6483-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reproducer mounts a f2fs image, then tries to unlink an
existing file. However, the unlinked file already has a link count of 0
when it is read for the first time in do_read_inode().

Add a check to sanity_check_inode() for i_nlink == 0.

Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
Fixes: 5d64600d4f33 ("f2fs: avoid bug_on on corrupted inode")
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v2: Correct "Fixes" line
v1: https://lore.kernel.org/all/20241124010459.23283-1-leocstone@gmail.com/T/
---
 fs/f2fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1ed86df343a5..65f1dc32f173 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -372,6 +372,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (inode->i_nlink == 0) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
+			  __func__, inode->i_ino);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.43.0


