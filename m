Return-Path: <linux-kernel+bounces-415370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F39D351E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D651F2172C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC01171E7C;
	Wed, 20 Nov 2024 08:15:02 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90E16DC3C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732090502; cv=none; b=j4nWjTkFeIQd1DhVyk3kI40Kjnss9TBUGqOOd1zdYtfapTxkeeTcy28dXlk+3OkjsfFXmi3YByDh+h704tgbZK0nOrbIrO5UssW3ALk8QhM1PFitfy7sRlPC494TlTsc8G7IyC2JWYvxt9zxiu+JLIPfAUDHCsuXYcaRhh2IJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732090502; c=relaxed/simple;
	bh=btndiWnlPwIXcPgtAdaPTZAhDf1YNroazmmYh4c1S5w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k04TniCzuBtbmOScrqhbHJ+5JgmKVJ+3MjqN4NusdAH+4OlnafJDXQ5FHcc/oKbrDgtRU3s2GZ4cqEu/6ofky4QPj6vSvh7igK6z104w8l8NYiDHcmDbTTxubiPXcmPEqehOxTNcra3TzhtZ1H5FQncOpGrOwa5UjtyxcqkBuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so9467955ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732090500; x=1732695300;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad40FtYveJr9oIne7xznzh9EtdwiCChDJDJKXvOpnkc=;
        b=mMrwGuBv/tmtK/FDKlMlkotPRX3i58VbheBy5PN4a9fKsaASqGs4h1W8SuwWLxPf36
         Tk8f9YUzHAjQvgLKsxUVYaP97adfyv7ep++T6w4lck4/wn789GXcOMD69pj+w0/9P5Vq
         kz1pw/CW8xsSBcOj3eRdPl/5VuSYsrDGGEY3MyPhQkeZMVrL2n2Uf7vly8qucV7oT5YO
         CHiQJidj4kqo0hap94BSEdE9lW2CngyrVbkZmdn1S+m9agky65GsbnqvIf9vu5ouTM5Z
         hDX954by5ou2RN5ZrODA1sPcI/JsviWhP8IAleovTjwfxCzvd4RsmEyU2f6DCHcI4BX/
         GO9Q==
X-Gm-Message-State: AOJu0YwrKi1HDnXeW9OHdcv7FnMbqlRvTVkl5AMyDIcR90nUU0lqOUw3
	P7fVl6yZo5aTrtF+pC/3wACdXno4quevSTMmxFl1rCL5oJw8GyEtdPVo2Q01UjiWtsOTFFrurmG
	Xl431HDK6hEj+cj9hyXzZ120zKHAdHAq/nyhG7Bh/mYtf41qwz1bZwiY=
X-Google-Smtp-Source: AGHT+IGrbe7kdMrnkmLBKWlWBzdDZjzIVQFxt0fLaMZWOjew7ApHcypJWbt3+v4kgy1s9SJGXy3Adgb+ANm1aWv88+aT5srV43qF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:3a6:ac4e:2659 with SMTP id
 e9e14a558f8ab-3a78642f46cmr21432905ab.6.1732090499912; Wed, 20 Nov 2024
 00:14:59 -0800 (PST)
Date: Wed, 20 Nov 2024 00:14:59 -0800
In-Reply-To: <67253f50.050a0220.35b515.0179.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673d9a83.050a0220.363a1b.0004.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in ocfs2_reserve_suballoc_bits()
From: syzbot <syzbot+fd05de09d1267725aa95@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in ocfs2_reserve_suballoc_bits()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bf9aa14fc523d2763fc9a10672a709224e8fcaf4

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 60df52e4c1f8..d65326d36b1c 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2440,6 +2440,13 @@ int ocfs2_inode_lock_full_nested(struct inode *inode,
 
 	status = 0;
 	acquired = 0;
+
+	/* Do not trust a filesystem which is known for containing errors. */
+	if (ocfs2_has_errors(osb)) {
+		status = -EINVAL;
+		goto bail;
+	}
+
 	/* We'll allow faking a readonly metadata lock for
 	 * rodevices. */
 	if (ocfs2_is_hard_readonly(osb)) {
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 51c52768132d..a48f79ca750a 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -665,6 +665,17 @@ static inline int ocfs2_is_soft_readonly(struct ocfs2_super *osb)
 	return ret;
 }
 
+static inline int ocfs2_has_errors(struct ocfs2_super *osb)
+{
+	int ret;
+
+	spin_lock(&osb->osb_lock);
+	ret = osb->osb_flags & OCFS2_OSB_ERROR_FS;
+	spin_unlock(&osb->osb_lock);
+
+	return ret;
+}
+
 static inline int ocfs2_clusterinfo_valid(struct ocfs2_super *osb)
 {
 	return (osb->s_feature_incompat &

