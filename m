Return-Path: <linux-kernel+bounces-410365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30199CDA6F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FBC283990
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427EA18A6D5;
	Fri, 15 Nov 2024 08:26:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40560189528
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659194; cv=none; b=qcJINmp+2ENlyFy1QfcOvJKDjoPhztoE9VXXcT3Z/lA+fEffjbQKuhaygZdY592XbTEKRYk5B6uKKERrt3GlakNIZ8YF6+/WnnMWT5b5NxNcSCiJl7JKUF+rYHeHqEfj1w1yr4gL8dvBGSYe3efnShyAy6SyTT95xAlQczecIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659194; c=relaxed/simple;
	bh=8wKPhUOT9T5aGZCbzbxqrv3QLs4wnqUJO893p2oXsQ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TRLm9k8Azgc5voEdaG3ovjMmOi+H6/KrKjb4bvGHxfNxYH8NfPTd2gpVECbUFC7D6XIJkJT83JsocHxEJ9qXXPu7Ji1HdvAS+tXAjzxg2+DgB9eaiv6HIUDsUgLMGhtNJ9Durnmga6/hx4Nmh7b/BstMDcFlGLP5E8xTQojU2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abad6594fso55411539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731659192; x=1732263992;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gj1kT6DNIxpoEsuPOvZYFOXRj3E43iQAQpFVr6sujoE=;
        b=t88zEu7ZptxqpUGidQ5Rj6TlKR3Q1k+TOsPlbA+vZF5D60GrzSZSmiloFonRCX5S38
         LoGonvrV6/z2TOmXNxhMSltBC4jrTk409N4gQXf/uf9gSJs/kLriSA0Cf4ZOlhYRlcaK
         sqYQjCp76rS2PWg11HYUFpt7uF9R/f06mA5ddGgzLF96uGecytn7JpNpARvjiNsTWLq5
         ShyEaYcAS8jY4Ro6tj5BJydSjWa5JzmWeI39/4pA8oth1147X4xr2/R1DCHGny3QvyUY
         k8FzXH0750ZAV9peIg5Z6S2Tyea8CSqd4HfbofA+D02mkG7SPy+s2iyEbG4EH1yupWk8
         Bndg==
X-Gm-Message-State: AOJu0YwjvuGQIzkh/rYFgy300J+7B9OKCvaXNf35tjNn6vRpOryltHth
	gixqLAIZp06GvBC6SQ21m0cVJn+I6GkvZGvz+lR8Hs4b3Z9Cw5Ln37PsalbM6lwNkBd4Qv2nD6l
	1sFIenwccNPEJ74b9uTrECU+D+bh2dabl7uGRnGOkpVw/eQMUvUbJLCk=
X-Google-Smtp-Source: AGHT+IFYIz71zAVSOkkFYtOsCFDIjhU+6t7lx5ow5wnR/6/zMKmJorVSoVxcsuK7J3o4An+8d4zwex0/5elDR04W0RVzci1GfXhO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a748084dcdmr21174345ab.23.1731659192256; Fri, 15 Nov 2024
 00:26:32 -0800 (PST)
Date: Fri, 15 Nov 2024 00:26:32 -0800
In-Reply-To: <67363c96.050a0220.1324f8.009e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673705b8.050a0220.1324f8.00a2.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [ntfs3?] general protection fault in pick_link
From: syzbot <syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [ntfs3?] general protection fault in pick_link
Author: lizhi.xu@windriver.com

the symlink inode is corrupted.

#syz test

diff --git a/fs/namei.c b/fs/namei.c
index 4a4a22a08ac2..f5dbccb3aafc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1844,6 +1844,9 @@ static const char *pick_link(struct nameidata *nd, struct path *link,
 	if (unlikely(error))
 		return ERR_PTR(error);
 
+	if (!S_ISLNK(inode->i_mode))
+		return ERR_PTR(-EINVAL);
+
 	res = READ_ONCE(inode->i_link);
 	if (!res) {
 		const char * (*get)(struct dentry *, struct inode *,

