Return-Path: <linux-kernel+bounces-422659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D236A9D9C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B4E28155A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57421DB52D;
	Tue, 26 Nov 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moeazF86"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B11AC8A6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642118; cv=none; b=WZ8zOtfx+zY5bYvMzdfPdhR47aocA+5IBAzZFTGRbvTCMPbA/9e2py8KczxnjL/e5wuzR8Z+/E5Vki9RFhbWFu/dAv5qUepH4GQAwE9csTtHndoG6lOUK50useYAclOMi9RbMqPL9gwCmp12Utlx4mv5mrByxiyNdvWyS7Ts/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642118; c=relaxed/simple;
	bh=9wbT7KvarKSMuXpGlgNLQC85YPVjzdKnj22wj2HilKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYdkc3yRcsHGrSww01mlUJxBy9YGCXqK5sQYMuSUx+WDDHNaHcwRaXVFVD279zzq/O11izfKISSD1Z5NEOlP9gWS511PiAt0CckzmqP6SZWTJc0yWWdIX43tr1GN8sDPlTgIVQZpn7L3DJjx+2Hamuiz7DlNQA18FOkRX5vPjUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moeazF86; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724f383c5bfso2924368b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732642116; x=1733246916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jdvil7J0bZhAA4aaOyViWI8sU7Jc49WXcGpRWqWHNM=;
        b=moeazF86855ohy43rge4dsQSXTN6mrJXk5ix8piiEYXQi2A/BJIA8/sazGIJM75Qwq
         9ktDsrgk/3an1Qm7Zd1Xo2uE+pa2nGKfI8gLvyDeJ2mvZVoLktaJAPLF5hhd1q1nhxbJ
         XgrFO9FYKiiKuzExe+DT0ADXXOXGvUMqsigvgE6a34UkqNfU1yYL5zy89k3f+ycY9x47
         Pt6JuMGUsvgKe9Z2pKQDjDPzU2scp8iTgQ++r3FHOCVkTlKLnKqmd3OD7Lu67oJleeIH
         3ECuUfpMtVNZn1V4HCVhptT4iFUqfknNlA23EV8WetWwMhHKQQhIN+09P7Zv7uBEy28X
         cGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732642116; x=1733246916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jdvil7J0bZhAA4aaOyViWI8sU7Jc49WXcGpRWqWHNM=;
        b=ko4oJn3bifQYTU0xmKGZ1aDd7j7oxpTg+gihzrC/vhN+yXBGn0/3ZYJ/T/pEhNkuBe
         dBnPGlxCL4Gvdno7CscAiGEKGJWqw04hKeiz2AjkSI2Rm7xQ23UEU0djCnTiRULO/fd6
         A82pvMNYN9Q51e9uNZkFC7iWsNe9qfWzUwQpBSWNKBPpHu5WyN8vvpECq47SvHmU3/XU
         Li53V5S12j80mIBy07mN9Yzz4lsDrCbRFT7E7c3tBmV6tJ5mChkmu4KQtUndNjX+E6om
         2qM8JdUB1U3t5mQoa/IL9XyrK8DkcM75ogFx/sJ4GPaLSZITxKqoQpQJ0+DLdGHYCuyQ
         +QNA==
X-Forwarded-Encrypted: i=1; AJvYcCUZibBcY4diliokt7csw3ar4nHogEPXD2TSLfED6CBiG16+oQ2hsUkUHSxy3b/AhcMS7YV4dDdqMLKgPAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQKWs8+LAvvpIdKmP6Nm/ZzPC031Wu3tTecxOvoTl8LRTnvbmT
	oeDTqPBuDJ0yPg5uC3JHnYTg4OtrmP0kteplE7r8jZU6xtYtRhos
X-Gm-Gg: ASbGnctLWM0CuZcNgBJcwB2fHxiqQmqNd8rjVV25edC10QqPJjf5kOIhJ3z34SwvAmS
	QmlXhK2BAp+AUm3gxIpMbbkWxzP3xR6qysuCBr3Fc/X5krT/8pg0aVUzjHk7RC50vFULiFWwPAV
	p/uAlUycZFrMsknEetyMBgb3CP0Kr9TheDvouFfAYA6X3Qq1SdpCQOEZp9NaV5mV7SkAgoMl0MZ
	1KHqb3H0Dm7w6jPS1hI7OX93u14E8Ssxa48UrqPsaSuwm86/NXy84ObBzj92Bl/8Q==
X-Google-Smtp-Source: AGHT+IEYbOFZv4S1J8DJ8sJmOXBTQ14kgVvt8ItV0Izei3KknmQuhhpcmuVRc8pbsYQFvCRP/m8BSA==
X-Received: by 2002:a05:6a00:1390:b0:71e:7174:3ae with SMTP id d2e1a72fcca58-724df5ed802mr21202721b3a.11.1732642116324;
        Tue, 26 Nov 2024 09:28:36 -0800 (PST)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:3e9e:9bc4:e80c:2141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e8852fe8sm8013211b3a.187.2024.11.26.09.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:28:36 -0800 (PST)
From: Leo Stone <leocstone@gmail.com>
To: syzbot+82064afd8bd59070fc22@syzkaller.appspotmail.com
Cc: chao@kernel.org,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	yuchao0@huawei.com
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_rename2 
Date: Tue, 26 Nov 2024 09:28:34 -0800
Message-ID: <20241126172834.78149-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67450f9a.050a0220.21d33d.0003.GAE@google.com>
References: <67450f9a.050a0220.21d33d.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This looks like the same image with a deleted inode as in:
https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83

#syz test

---
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
 

