Return-Path: <linux-kernel+bounces-280545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5799A94CC00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09E9B23697
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB816D4D4;
	Fri,  9 Aug 2024 08:15:51 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8034CC4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191350; cv=none; b=M7myoPzwPqlAkp5txRx9+jhvBO5Ca0fUn/E6hqvkj5LeVDE9gcdob3h4u9KrQgd3OABgIJxEQ/B7q4IKBLco3J4pKeIXjMp7zd8P7pOya62t2Zf17/cJVymT7E0HI9gYO5txRuKXNc003qywSrLTku0KM9XJud/BULnkYfzcHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191350; c=relaxed/simple;
	bh=nwEQiZ3UCQsYyia76yvGCguP3yp7krgBA9WRd5sdQB8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eeOLi7PVls7H6np51gYdlN+qcmFilnr23Jh/Igzquksw3dYlpGdEpvis27K3dz6/e1id0Zj7kn81J7GIDPO+WAaHPWh4jSdFQFhKBU6ENwcY2g+JocWv6EZKSROSDLYqsjKVbsAaMSr/REv15xyDg40w/xJKbQIWPtdTT/YxR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8489097eso218617039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723191348; x=1723796148;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHqRj4gx9kZchfqm+YpYcaa7MOh5AO6YHrOsQOcMfjw=;
        b=YvsoaVL3C6dPLT99eTAE4BMWUWd9fjb0GyhHWVg2nWkpVGm4HUVb2SrGMGRCRoy8eb
         YDnv8f3b2BvvTQtcNMHciHmcBorSTF60I3frYLZpClq9afuCJSo6FwJf1NJf6Fg0A/A1
         qle1oWXVk9y3yF7JCUsMCXR74+DUw4IoqU+pOI/s0TovHfX3dqqzzarJfjGpHst+RWkF
         Pbihb4sv7EQD6lv+qQG+N4f00UHT13vsXfbo2tEY/bJRbmqlQdlUYuGDNAdVot041/n5
         c978cP2rh4yRizYV4dJb4ueR2uO618mXb0Ohet81VhxRzNgyfE4/neSvHt8jlurnFG5i
         xnvQ==
X-Gm-Message-State: AOJu0YzXnonTkSBUZbzETZvaS4qTsUSn2lo9FMYVjZGeaHnWRSRUOANN
	6FQag1C33OrIgjUq7RaN8JS68iFJaIZ0u5boXPt+n4UJTtnPvoO9XzWqQvQA6pLgmMxXYvSkBS9
	jCT/Pxm2xFghPuRouY8eMy+V72HlZV4acrl1APeHX4Zh25xnCZq86YPI=
X-Google-Smtp-Source: AGHT+IEV/vSOL6ozFbataxikj6ULw5pT0vJJjK+nK1xpQSh7BmjolJbpLoDVHhA7z4XYDvgO/xexotxtFeGR0CyjwWahVdfZVCO4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1655:b0:81f:a277:a2fd with SMTP id
 ca18e2360f4ac-8225eeb4c8cmr2000839f.4.1723191348626; Fri, 09 Aug 2024
 01:15:48 -0700 (PDT)
Date: Fri, 09 Aug 2024 01:15:48 -0700
In-Reply-To: <0000000000007ec511061f00a7b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003717ae061f3bc0f7@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
Author: lizhi.xu@windriver.com

add file refconut when add fid to list

#syz test: upstream c0ecd6388360

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..4ccd9cb74c11 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -95,6 +95,7 @@ void v9fs_open_fid_add(struct inode *inode, struct p9_fid **pfid)
 	struct p9_fid *fid = *pfid;
 
 	spin_lock(&inode->i_lock);
+	fget(fid->fid);
 	hlist_add_head(&fid->ilist, (struct hlist_head *)&inode->i_private);
 	spin_unlock(&inode->i_lock);
 

