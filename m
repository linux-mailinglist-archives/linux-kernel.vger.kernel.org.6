Return-Path: <linux-kernel+bounces-396318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265149BCB74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CE71F23A5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE721D358D;
	Tue,  5 Nov 2024 11:17:54 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0E16D30B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805474; cv=none; b=lWPABeH01ZHaCuofUR5WVTNbJnoig7kwV0BU3SmlKFgXyiUh05gApenLRhrRDQFeGkVBa+sbtOpNd/tsc9MamKyRuiuZmIaijUTHHkbP1ykYvV7rAXSYyiF2WQo245TiRb2BVLoQNao1Lwy07g6Xgtgy20oVY0CSHAmWyWWBtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805474; c=relaxed/simple;
	bh=sYOY7/eYPyraHf3lyb7BuAE00o4NvC3JJ3YyUo0QfS4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eDRcrOL6FEhZpW/NG62rOTTVrA0otAmQrS1yEsq0Ed3XBqDz4rR5wYU+rXGhk2sQe79NQl+4q3w8grh7hRfM/J923gb4SlZch68hZaDvdxuoksGhKSRjcJSqM6B3nsgpsKzGltoEayb+/WSJuniCRCzAqlNo8bg0oUSKm+OlR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83b567c78c3so471393239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805472; x=1731410272;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnxxvP+aM8OMOvK10BXOrKfEK4hD3Hh9VsLhsQYgKNA=;
        b=MY1wFCsNBPWMyX9xkroS5GzFX83IyqI6FwCa+3CH7GufDvLqj4v5nlTQPI+80T0+K8
         1AJ3YzqUuQ8sbSZjlDSNIzbQ22avbmIJA9xfio/cUlnYP+UeQFFsNBwbgcmFtZBzr0c6
         Xkr/8t8uqhS4XJC8gX/YwfHR9Wl6z0aujWZB9k91wf0CURRFIUDal5CqaHW+8IEdq+oE
         tGhsqiRa0N8iiejUu6yTmEoDzTNzNvQYjSiHUMjz7sDk58j3aN7Hitm9ZJOg06y7g8em
         BsxPerqsypiZ27VxaGrTlcCAdvXfaPhhjS36JtuTt9/N7ZuemtnMsdDfCGdcTmWAKm+4
         Qprg==
X-Gm-Message-State: AOJu0Yw4WtlJSlsx+TD+ztm7vqEOUvuhWQ8aWUlHVdXuYnpBJ8IZcSV1
	pCv5nSf2gNRqDK/QuyvRK1kOK4Hk7Eo1Q8QVCUKTM8GmQbjq8yAqwHO2fM3zoEJ7MjokQJAismM
	boe4/DY++OPwvfvOQNj0pwXy+mGRJjQhhUE++feTQtvvMXZLIlfTf0HE=
X-Google-Smtp-Source: AGHT+IGnbWKkh7BI4hmhhrXFkCG79EcPO6J/1wh9vX1air9eXLOtShXzdNDpR6t0Gogmr4R3KpaH+q9+87WgdbSwyVH13ydrumP0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c691:0:b0:3a0:ce43:fb62 with SMTP id
 e9e14a558f8ab-3a6aff71f01mr117629135ab.11.1730805471715; Tue, 05 Nov 2024
 03:17:51 -0800 (PST)
Date: Tue, 05 Nov 2024 03:17:51 -0800
In-Reply-To: <6729d8d1.050a0220.701a.0017.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729fedf.050a0220.701a.001b.GAE@google.com>
Subject: Re: [syzbot] Re: kernel BUG in free_bprm()
From: syzbot <syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: kernel BUG in free_bprm()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next 850f22c42f4b0a14a015aecc26f46f9948ded6dd

diff --git a/fs/exec.c b/fs/exec.c
index ef18eb0ea5b4..df70ed8e36fe 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1496,7 +1496,8 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
 	kfree(bprm->fdpath);
-	kfree(bprm->argv0);
+	if (!IS_ERR(bprm->argv0))
+		kfree(bprm->argv0);
 	kfree(bprm);
 }
 

