Return-Path: <linux-kernel+bounces-203823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DA18FE0EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6111C24C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541913C690;
	Thu,  6 Jun 2024 08:27:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BF13A895
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662444; cv=none; b=uhRBmm3TJo3R6Y3g8AMEzrGKewC/72iTbuAjgszH7WaqXXAFaBUUd9ui0eL+qEPw9LQKgA7C3RKwN9+2w8aiXdq5PEF3cnUXDDGgARa9hW6IlM/N5No2mkT0xq4kDmSiO7lOKS+Os7yI0l/mgdE+roR4LPQX44d+6eBPZQH+0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662444; c=relaxed/simple;
	bh=K9MBZmFADFOEn3EnG7bM171OFbDVyhQs9ympNxCaWSE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A7n0HFCgydIe/gp4bNmc8fsHbP4EL6GaDYV7wAEUyb9M/pFY2OQ73p0EW82EVWpTSU1xJoUwaHivZcqjLXg6qq2KtI1HwpRqIPOeWPTXRv4kd6oaKVn/AY0fGZsPgXU3okwMWWe0/Sw6b7YJ3TDTSqBjpjp95TxKcvAc+UgiDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3737b6fc28fso13856905ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662442; x=1718267242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9MBZmFADFOEn3EnG7bM171OFbDVyhQs9ympNxCaWSE=;
        b=YIJZOTSV1dD11F7y6rtKkaAIW5F2AEUyhxOttDxPVl1H3Qevd2nk33xPiFIOgXgI20
         ec7fxrTCDMEQECojRc8sHzumb+5s1gsXCxf2+9RuLuabiDnLzD0A0lH/PqM7jg+tOJvC
         d7efqMHBVmi9De8CZXFuEse3S9w6yG/6MBy2cA3F3y8XtEge0PcY21OetsCTlWWUK8DK
         zvqA0DKX8+119fVbyXaEcy8ojM0ipB5AdKzT78G2H/SbDr0Z8TjXKl6po06UhfRIhM7y
         0yrvUwyswLk4fEElpQHPWZJszOrdx9PpxTRSVmBgZwewH4ejV/mvo5OwtrC2ZYOvD271
         aQVQ==
X-Gm-Message-State: AOJu0YwAAv1GW+mKzp/5q1vnZ8tbWu09cQ/e1iMlRnCFYp0nm6/udAVz
	wJFlPGi5i6J1ElLn9HK4siOrl2ofcCV3FG04B190IGNmeSxw1KnAXSz46Y41WGpz1NVvqHEgqMT
	/Q91dH3vOUilL1IMSs4ny1PwnVVJKClmg0EAYDeWsQzm8hsOYAAMWnlk=
X-Google-Smtp-Source: AGHT+IEg5l4mAaXGu6OUlZmMp0vwRJ0ELnDqFHliyyQ3BRwEotu6g7gfq+TAGBo17xLlcMPuKouBgwfIfHYel0ErzdV+MqeNDut+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca2:b0:374:9abd:277a with SMTP id
 e9e14a558f8ab-374b96a26abmr1277925ab.2.1717662442288; Thu, 06 Jun 2024
 01:27:22 -0700 (PDT)
Date: Thu, 06 Jun 2024 01:27:22 -0700
In-Reply-To: <0000000000000fe556061725a7be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b78a0c061a34736d@google.com>
Subject: Re: [syzbot] [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
From: syzbot <syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [syzbot] [ext4] KMSAN: uninit-value in aes_encrypt (5)
Author: norkam41@gmail.com

#syz test

