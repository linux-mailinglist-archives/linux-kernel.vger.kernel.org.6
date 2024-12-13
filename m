Return-Path: <linux-kernel+bounces-444937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE039F0EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD425280F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E53A1E0DD1;
	Fri, 13 Dec 2024 14:13:57 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3E1E00B4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099236; cv=none; b=Cq4wKFqGIHDc1yIg1w0zeRcRp/VU4SoaGfzITpW7LHWc4efl+RFu8+2Er49OW23l3bgLUf7CJKfMTnRAap2512YJ9eafEGPCiZNEC2/HYQfOfO2Tab1mcDTARAhQgBY2LnwTbL2ZhCaSRSFHFNoXPQWkWJOGMUwmgdUH3rVLau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099236; c=relaxed/simple;
	bh=T2E8kohs2Sz27sLWiniK+Ilnm09+ctyImHyisgZ5Jtg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o6yUFrKbF9MyHjcmpYHmJoKCEYm2OwKrXVQMW5h5hsNxiNRbDox3cX7UUNHzZslfRTHJV/ctSgQtAH4WXsq+gAUGCTDTNIJf2RkxW8rZq8TNmcZASdeBg25Gl/B9qbSjjM+r3Xqsu0me0DHmPYANm9OgKr+nJ4blWAwg253r2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7d60252cbso15226235ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734099234; x=1734704034;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BXFWa2EJBuQIqwTiEzMlP+cVuPNirgB/zhCHNyvSiw=;
        b=XsQ1soVqB4RN8XrK7ROOdywIYSjnpkklQB6k17+6+kyHvNqM+u4SFBiTlWn1Ng4vms
         C2obCzRCUBL0ayRRttvSNtUzqFm4WkBffG2mWtKGXZcw1qgpYZDBXMfquaUarHC1jRJ8
         yat+vjm5l6W08RS8zhT6nfOeOiiSNRilrze+iKp4mLZydMegoqs+1zcurR1MUhEYVfGw
         FiAAhDVYa9zAbkk+wRfG3rgOgALQPa+C9YLVAPE+br4e0y9PYQmJxx3/Tk+QkURhGGUq
         QwAFWQp0PplRTsYSJBHnAxYzWA4aF1d0W2W+qc2RC+1yTZMs13P2siZT/tvg28qO1Iz/
         H9RQ==
X-Gm-Message-State: AOJu0YyDclnJcTSU37w0MV73MA/6l9qB4/qq2LVKG2i35uGVGEI4off5
	Dou3ORm2TwPfSYPka4MP1hgpqFI0plfjyDzqcNvJOK9Fd1TiO5Ds2U2tb2s7LHKLj8UWiRPdFSM
	C+pmlDX/B6JfhgOICCS79tuqhMsoQ/wQaVAyAoW+Xys+PloEc1sP+v8U=
X-Google-Smtp-Source: AGHT+IEKfInS4KGswTyXrtGacL+7IwudC/91LSYqov7sVrZeTK0uhEcnzkMrX2+7szwB72UGvDfXng+8hWcLpmJ3sQ0/Wheme1lj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c4:b0:3a7:e069:95e0 with SMTP id
 e9e14a558f8ab-3b02a13bd4amr27716765ab.1.1734099232846; Fri, 13 Dec 2024
 06:13:52 -0800 (PST)
Date: Fri, 13 Dec 2024 06:13:52 -0800
In-Reply-To: <674f4e43.050a0220.17bd51.004e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c4120.050a0220.17d782.0012.GAE@google.com>
Subject: Re: [syzbot] Re: general protection fault in exfat_get_dentry_cached()
From: syzbot <syzbot+8f8fe64a30c50b289a18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: general protection fault in exfat_get_dentry_cached()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f932fb9b40749d1c9a539d89bb3e288c077aafe5

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 97d2774760fe..73dbc5cdf388 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -331,7 +331,7 @@ static int exfat_find_empty_entry(struct inode *inode,
 	while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
 					num_entries, es)) < 0) {
 		if (dentry == -EIO)
-			break;
+			return -EIO;
 
 		if (exfat_check_max_dentries(inode))
 			return -ENOSPC;

