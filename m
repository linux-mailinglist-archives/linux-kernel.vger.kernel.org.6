Return-Path: <linux-kernel+bounces-404649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C9E9C4634
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B4C1F225B2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC2D1AAE1B;
	Mon, 11 Nov 2024 19:55:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87B132103
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354923; cv=none; b=M16ziOyVNUOONtElazwIt+Dyolmbtyn409laND+HQKc9XyomxdXWKMsvhWVFwl+20t2IpLhdJh2689Fdpz+oYeU2Y1AHV+hszV6gs401+VBe2eBNJ4hDxHPCOdQv92T4JMKsyx/xK44emheAJea89h1XO7e7sB6W8PuFeGrjhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354923; c=relaxed/simple;
	bh=wet4GcyKcPBYQGsQ+XIpVWvHP1vYW5cW0Gua9cBX5eA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hCa4UPiW7/S1RrBswictO+vaPETT6JL7WxrbI9dEQE1QAiSQBkfie6b0HFsVm0yJwzGiPz0dXvXnPMdhfSwHg+9ikE1knAkCG4OrovJGg/AkYY/KxWSN9VYE6FuwYlT49+YVO18NDSk41s90eAyaCXo0/nZ+4q4j4iMEjKhob6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6bd5be0faso62717495ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354921; x=1731959721;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wet4GcyKcPBYQGsQ+XIpVWvHP1vYW5cW0Gua9cBX5eA=;
        b=c2Q2zPob/FA8izAF4m7P7g0BK7oZKpbFqHFMfZBqZxuaiAu4GpqpLO98tOVVbjPGTJ
         P5b+7g3QRGMZ5qsE6qiTkOkeMbcPTEk1VA2d7JgU2mmrBAIJ+KBTJ0p1eSnDwEWV4dgw
         DLqqG8ii4lhnmhoI8xi8GdC5s0AdyA1bOzwxkeVifqehCVMGwk1qooS9gFvwgwdBTZrs
         7rdjImsA7KVfuPk7XAWwUXGaEENr42XyGvPpc1GHiSIM6ap/cVN+ak6JuTKpl6PZ1ZnO
         JH6+9irSGt/5hHHrsiZ46tdvj/xSs+aXJrVjWZ4B6fBVyMWKsvI/sYx1OnDlQwpXOTez
         7g8A==
X-Gm-Message-State: AOJu0YxYDPF/u+rkLc0iH/hN5HzNQX4j0BUkOS9m3gwEezkyDOdS3cgB
	5fsG4syzEiB5KWRArgIEa8BTWAqF/MNZsDr5fOc7FNTMDxOZJUk81rccCYzvrvmhmQqy7j70qbQ
	SJ1OjR0JSqYFvUPYMmgxGO3qLibuS29I939l63jB3BdvAZRMCgSpaH4w=
X-Google-Smtp-Source: AGHT+IHiKR3wofKnNVjn0EWqhNTy7TOc7E1HeEj3mzxIwDGwdsYzFOCMjzdy8Cz+8h9IB005AEIMeyl8LNSmV5UvugF6eb3zzK3g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f08:b0:3a4:eb9b:650 with SMTP id
 e9e14a558f8ab-3a6f1a230demr146691105ab.17.1731354921663; Mon, 11 Nov 2024
 11:55:21 -0800 (PST)
Date: Mon, 11 Nov 2024 11:55:21 -0800
In-Reply-To: <66fbc081.050a0220.6bad9.0056.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67326129.050a0220.138bd5.00ca.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
From: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in __hfs_ext_cache_extent (2)
Author: gianf.trad@gmail.com

#syz test

