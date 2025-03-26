Return-Path: <linux-kernel+bounces-576439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC2A70F47
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59141770AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B01553A3;
	Wed, 26 Mar 2025 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deaAg3Id"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A62AD0B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742958305; cv=none; b=OgXJnTnsRf26HBeuedRwL5uBJnwXaB/fiaX4rUXzA+UJBzy6Cdj5oUGqVBZ9NYS7VjCOxfXvcaZJ0+/yWhD+Ynaup0U4WYb4VIoJEBDakEZ1jt7ljobg4UbTa9BAqYHli3ewsu/rGCwxNFevUNdGgu3x6K2BwsFDskJY2zROs+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742958305; c=relaxed/simple;
	bh=J5s/KFlxYHPrN7VpRmM8wPZtukkpFEFTb5uqELTC8xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueLfw2m32Ydz+gnHTO2XQqpf6tiMBUFPvtDWuWoDmkCVmVfOw6NzcP9I1n+OD9dnnaGYWRpO1o//eGQGaBa7n4YKrY0hnyKWbfKeHpzsRuX3iV+guO4gRPGhdI9N12F21F3rX5ql6V3PQaDengoPVoy+yUoI9K38AaLjUW9qkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deaAg3Id; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224019ad9edso7690155ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742958303; x=1743563103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwRT6lPwkPl7iBKgqrcj08LwKHuJssOc/9VsDTfZLrU=;
        b=deaAg3IdnK6l4NITVAE72jncTiZ1BquL3Z76vNOqm4TG9zelJVzwLV1rhC9K/htGwv
         SqMJy3Mv/ZLyBROSvrPDj2DyG+BpTvrzya3k/7mARmoMRy0u9neA9PgeSr3M7/VjFy7i
         JaMJDSA7b2nhkdq2O1jw5+Zenb3watFuk7QTP8tF2rk87JM0BLWM39EE7aN2JxUNgKFi
         W69nNaYeziozkXta59lohnqiQAkeeCNZstFfTQl3BEtAEXkgOm4aR1hQde762F8arSsd
         MCLc9XtJXakuRmqKh/1/kqSLIjSdo/PEUmiQpd2fqej1Zpeh9RO5h2nZCsSD5hdgfAcm
         tBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742958303; x=1743563103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwRT6lPwkPl7iBKgqrcj08LwKHuJssOc/9VsDTfZLrU=;
        b=E1zKWsRNauLUNa+MVzH9QEq6yjfh7x1PqKbPoC0Q0gt56C54GgG513Jzor8wJBpg+l
         36Prfved3xNXvZ3poXjVEAzfpXOffbh1zdwy1ltf2uf43SIuHGuHCsFr4/cet0JHgUR4
         CtbsTGW1zcHWFiD+xyU0R4eGXfaEiOPwmoeW9TBsH49cH62aETtOyyVzsSHX2aC5M5MZ
         oYUPPXsbc4fmJNMBFI79Lig6vFen+H0WKr/Qpx+YsszhncdZhjL6hCmlPzbADt4/T1MB
         o3nT9sQuItBm5aM0Tb17Cz78tQ5JgzvdJuNNY2D6BfmO518tW9o6XOcLq0I7hBAPOF5W
         mm6w==
X-Gm-Message-State: AOJu0YxAvqt2Di2M6EdqJxyuPqUjuRF3OC2tEr7T72tQYJ3NyUL98//C
	MDk+zjRfG4HkYjpC89qmMVHqfqmi2+4zom6rlu2g1NYTngkGIdC6QjPvqQ==
X-Gm-Gg: ASbGncsYsWdk1KgZRzbNNdhV8wgrxqzfPzOM/9awv/BiW67FbwkWUnsMpclK2lQnFJD
	xd/IHANEUlXej8mKxGw404uOe5+Ckm0Uel1XgISWqKzFZO6qnwVP0xGA2P9LmH8OOlq7huIg10Y
	KIfU1fh9GF+A4440PUYc2XUZHbjB+XVKlYMUvmsRtPBeKRh7Wcpc55oF91lVNBPFC1FfnCTloUg
	cxnt8SYYqhU0DQdzDR4SAO3Iz3N/2Fh7ptEGMpEEAPRA8rYWFOVkh89BDNAnxQFWn8j5iYkwnaI
	Y/j2qKG4IIsxH8zOxdarbsfcvH3cXiyaS062sdinSf0Ba/Gmav4L8eaMS2vPHwtc1WWWYcv/Bw=
	=
X-Google-Smtp-Source: AGHT+IGi8Abbxwd2EyL3Qlm+LZH1btkWKJLrDj7JaZX8Be2PefAKzpKfycYlxv4+ioGFYPd9N1DNKw==
X-Received: by 2002:a05:6a21:3a94:b0:1f5:a05b:c741 with SMTP id adf61e73a8af0-1fe42f35e71mr33477153637.18.1742958303456;
        Tue, 25 Mar 2025 20:05:03 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:7cf9:c75d:456:248c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a292b1ffsm9799190a12.61.2025.03.25.20.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 20:05:02 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Date: Wed, 26 Mar 2025 11:04:57 +0800
Message-ID: <20250326030457.83426-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
References: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..3f57fdeb72fa 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -307,8 +307,7 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 		kfree(rc);
 		return -ENOMEM;
 	}
-	memcpy(rc->rc_bitmap, dchunk->dqc_bitmap,
-	       (ol_chunk_entries(sb) + 7) >> 3);
+	memcpy(rc->rc_bitmap, dchunk->dqc_bitmap, ol_chunk_entries(sb));
 	list_add_tail(&rc->rc_list, head);
 	return 0;
 }


