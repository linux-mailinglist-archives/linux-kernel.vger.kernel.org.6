Return-Path: <linux-kernel+bounces-300688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0028B95E733
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E9C1F218DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81722A1DF;
	Mon, 26 Aug 2024 03:10:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC411373
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724641804; cv=none; b=EVaou36eOALo0dm7GeM7emquaydN7WidZOlypMMeBWOq/N3A2p2sVwN4Bqrz6VaQJSe7n6oUxzNVTP7RKC01PS8UtWWBP4QSQ/hTUmqUQGxXZaBOrdVNLk8z+KX1RiHsuh6XO/W8FxPcqIeOR/mCS/RfzrSrae6xM/6kos4nHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724641804; c=relaxed/simple;
	bh=s0mypIbqER9T7YpPdTgRuW8UhY0+bvlDlx3D0F118G8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KPFyAtDhaMbe2lwfC1xYyYT9PJPihvHu/2cvEtOBhsk/CsbvXGwz0/oWFRifzdIjn9eFLdI3cZCiZNKi4+utsxP/CBWQq97X20RopZOd+AqLWm9zuK1jHRk/WeHztyrdz7dZaZCQg1J2OLeDjmlod7Ll4ycoPu8L9rcIaUqltsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d2c44422eso40862045ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 20:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724641802; x=1725246602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0mypIbqER9T7YpPdTgRuW8UhY0+bvlDlx3D0F118G8=;
        b=WUFr8mFhAL5W0uIfcSF6lQ/oxMQmPP72/qzkHSFnp3IPwEzbIDrtdERKnuD99lbtv3
         YRO5iiMxNzX+GChcOCnxXKhDld7oSfcz343NHgCjAbLM4UN6f/S0oT1f/kGiFcxHTTT8
         /vtPdcK1OwxRSyhzU/N1r3KL88a8/YnxRdHyewVBzF2/O6Uj1RiLjq/9VjgTkC9t4QJt
         ZIgfQagapv2qJtNiQ6yvuLqvugCPGQoyJBN0ajsbA+qa/Uzp+Uba4kVPWej5R52eMTc3
         LzR7EnKMv2/8Lr7EjZJcREYSeMzcbPlkOxPMCUFCiANpaxWHlB3dquQiwpUhVlYEOM0H
         8fPA==
X-Gm-Message-State: AOJu0YzLkt9YkF8PzjstlZv2Qv9AOr46ep55xzYbQsk8oNlmObp8ZuyZ
	lvGJSjgi+4vfNa/8CRnFGS7wr+ibCwh3AlWkFiC43gm0UD36TTkGXPzCtY7UCGFxqbtJm4d+Fyr
	yeD/JorYh8XbCPU5l0A8m8sxuO6/pGM+WuwSpgiTbQ5lAtlJY2A/iouY=
X-Google-Smtp-Source: AGHT+IEfzPxHk6pxywWo/fMDIpoEyaB/h0s1HZMQbTvT13blVbAe3Lf3KPlMCKqbVuFsqTCBzEIpzaaE4Lw3ETShf/p+FxF2s5ru
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc6:b0:39e:3939:5636 with SMTP id
 e9e14a558f8ab-39e3c982473mr5483015ab.2.1724641802099; Sun, 25 Aug 2024
 20:10:02 -0700 (PDT)
Date: Sun, 25 Aug 2024 20:10:02 -0700
In-Reply-To: <00000000000070a66706204e7698@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000faaea406208d75cd@google.com>
Subject: Re: [syzbot] jbd2: set JBD2_ABORT upon journal_reset failure
From: syzbot <syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: jbd2: set JBD2_ABORT upon journal_reset failure
Author: vpeixoto@lkcamp.dev

#syz test

