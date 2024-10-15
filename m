Return-Path: <linux-kernel+bounces-365610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2013C99E4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB97E1F243DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF615821A;
	Tue, 15 Oct 2024 11:01:22 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4648214AD38
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990081; cv=none; b=ZS04hIla5DbsjcumJYXHU7luJXqtr2z91CHHwgPly5P1tjHtkgQLHjr13vggps1yu34kp3Yjel5o3b6Nkw4DVEwsXB4E+JmJVze3372ko0fdaNo5gtY1Au0XYYOMDpwn0dbz6ETeIePDnRU1wM3g8FWQOA51AL5s5lhdQ6peeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990081; c=relaxed/simple;
	bh=v+agA1GzMbSPyko2lfKWPfx4t+1C0NQ1LVVBokmMLiI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ua+frGCy1sFT3twnV+c2d5iutFH3o5Onw6zCQ4JUEn9pG1E1QZG/E7PcMlthB2/JGDQ1vFS63NbePNy47KRRgBof5bx+PSMWIEayrZY+ETK9r3WlV+/NXXq5D3iCK6EzF67NmNeJzU1F9MTUTZQVdpsLcVGJaJJ3iWB1tojrwVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c4ed972bso13603465ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990079; x=1729594879;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+agA1GzMbSPyko2lfKWPfx4t+1C0NQ1LVVBokmMLiI=;
        b=E0u9T7glff8DECnjMIIdkOs4B9B57/9cArhs/5S2RLIwwUD19AJ0dqcRp7diiLFolC
         iCK9sCZjFTKc3XhjCUJz71VoxBt/f7RSBRbO3sxd8tuwhpYsJ0beHjHdwo9iLB1+WXZU
         bIT6gMjD0UH/47d7IP9JPyiYhac7hlWXLnAnlX1CnJPAqV6pEpN3BeojvE5ky1arN8Bz
         UVkn2CccV2CZzg9+ujL0CFQagdaqk/UW29PApNH/BoXbz68BdzYAnuzcd80H13m7YuFz
         ncUJzHYL/hkT6lGxNW8DNB1BYYTEAwKnjP3YbzUtZ+mob4KJVOJlbhoqgSS0SIrgloz1
         OnCA==
X-Gm-Message-State: AOJu0YxI/tWoi8HQAVXMen+BPhYPJA6zB7edQDlEL11bkkt7Qzl2dNfC
	AdSODVQwZN6WR5NVdoDt+2FXOLkw18mk+z8kmK4BRxDJmMqfO+DDmweT/Y1QTNTGKIy+k5w9+RB
	84FYKpea13qEpiLLRe21j0efArIj/AX8FJW0L9C6Kv445rZ9kgx7DS+w=
X-Google-Smtp-Source: AGHT+IF3UO+9znhMBBWyr5FkbNQMQt7VYKc1Vmq0Dtmiz75JxxOFfRxEJReQHy2sMZ60AGBYnzrtfpbizF4lDEtR1LOV8vJfwNv2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1446:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a3bcdbb5acmr96144655ab.7.1728990079310; Tue, 15 Oct 2024
 04:01:19 -0700 (PDT)
Date: Tue, 15 Oct 2024 04:01:19 -0700
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e4b7f.050a0220.d5849.0005.GAE@google.com>
Subject: Re: [syzbot] Re: Fix NULL pointer dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: Fix NULL pointer dereference in read_cache_folio
Author: gianf.trad@gmail.com

#syz test


