Return-Path: <linux-kernel+bounces-282865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D8294E9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E77281A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE7816D4DF;
	Mon, 12 Aug 2024 09:28:53 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5620323
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454933; cv=none; b=ftVuyIVnCGHL0M8JcVVO2tmnQ4KGa1eDjyf+Ov4moCmtzMn45t+XVQJWyjmj8twAyNYWKp+42Gq0naG0dEQj7/56R8ab7JuXAhOFo9tRQZpSF+zOR4P7pc5SOD9msozXxTqbuZFo5h4aBYeuloGlbN632MlbDuib2N14J7OnScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454933; c=relaxed/simple;
	bh=wcFjmbjIke8M3Qtt3M5N2ZhejAHoAnPeoduq/Omoex0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mlOIRgofrnrv0IdsobXUALnTfKIFJnN32LCxCXOe0V1fcRawZ6O6JYYy9LKdpW2QkAdVnLn5k1Vm14xE8Z3q2AWgVwIVoHdootGfs+AiXOXqGgsVXznRAGdrjfT9cyOM8nltyBhahh09C8mOM31u/C5KmlPgmYdNRn2oA15sjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8e43f0c1so527812939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723454931; x=1724059731;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/cZWbvjQCwNi7v8yT6AIQ71nNJlJobFKupWkCD1plw=;
        b=osIK61bLikTaUuw4V+fcnp6UnEvnVbMqzBVny1J9mgKstLFcVUKgQvejxVGyN5GhHI
         wmRPKGOTgSXwAe/KMLoILF68zlca0pGIL9HodxiK+UGMgsgpV7yC5NXaALev3GNsm8P+
         uNfvc21fIgqB6OikCigzOe0F/AGgKKskyg0Wi7foaouY+84fcQ0A5l7ZVGgCtGd9hQzw
         ONtKShRljpKbHOxTKq8hIzSsCLiIlNtzt0T6yYj5eUvvR4EWWAwSIAdxUhT9jqVJGr90
         6yvB/a6TI61ahL/w34nG+LB8YD8WzMNHwfrxGgPGesnDcPtEO9x05f5CsAECUKOj0R7+
         tOaA==
X-Gm-Message-State: AOJu0YwtPZAyV9qdBnTklBvkoMym8glM76RRtSQQUZCTvJxiI3fZFzhu
	wXydAhSFAOFjg/+0W8AmUGiUmsVJzTGMXh2mPG4daraJJj/e95Es9Sk+MQEC7J0VmmBne/VA1b2
	eQzIiAD67KLVu5hVQvSg/KiRhLSt95io5XO3w68iuckFfm8qqLRJk2hY=
X-Google-Smtp-Source: AGHT+IFCJ36OsgK7FddjuKiywTcALg5D0G/49M7vkFlJplM+d6yLaTiRdRduInssmU9x0idBQj51ckVHm3eZey0eHiumiNV3rzAd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:981e:b0:4b9:6c10:36a9 with SMTP id
 8926c6da1cb9f-4ca6eccddbfmr541913173.1.1723454930891; Mon, 12 Aug 2024
 02:28:50 -0700 (PDT)
Date: Mon, 12 Aug 2024 02:28:50 -0700
In-Reply-To: <000000000000fabef5061f429db7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f14232061f791e04@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
From: syzbot <syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [s390?] general protection fault in smc_diag_dump_proto
Author: lizhi.xu@windriver.com

out already closed

#syz test: net-next d7e78951a8b8

diff --git a/fs/splice.c b/fs/splice.c
index 60aed8de21f8..67a5965c0793 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1647,7 +1647,7 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
 	error = -EBADF;
 	in = fdget(fd_in);
 	if (in.file) {
-		out = fdget(fd_out);
+		out = fdget_raw(fd_out);
 		if (out.file) {
 			error = __do_splice(in.file, off_in, out.file, off_out,
 					    len, flags);

