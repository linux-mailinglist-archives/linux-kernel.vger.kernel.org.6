Return-Path: <linux-kernel+bounces-510608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80630A31F70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042021884AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF871FBE8B;
	Wed, 12 Feb 2025 06:49:48 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21B2146A68
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342988; cv=none; b=ENrczkK44s+dmfDE9yfa2G6FVlHsWVImn/IeCqwk1R+Khj272Ihvo4guT9+d6RnE+O+HMmdS/3/7aif5rPfc5rDI5cUtu9ocIw9TX8ilmI3U2dHr3qmI3h18OqRM+aiPIXk6PTUNDSsdMzaeaoh8VUnjyoXnJBv7FljgkPnagV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342988; c=relaxed/simple;
	bh=zTACTPEA92TOUbNC0DosFFv7rTk1CMhrDvic9iTbzok=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OK+ZYHNXqTQUHjRiJ5iw7ZP2p/9GABZNBjsmvUrhamXXWSPApy87F6/p12uUBcl2DokInB13aw9ywNc1U52lQzC+OiaPhsGfZ5hzDjP4Ix7VVz3oQKoHzvCEZlnVWvuGDnZodsSCTg6UAkas+WzM9v9zJkAyxyuqxtciF60Efm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso119545085ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342986; x=1739947786;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTACTPEA92TOUbNC0DosFFv7rTk1CMhrDvic9iTbzok=;
        b=XGLIjs83jddtmuoeSl1Y0zbSMfr3q7VdpqCGkn8VfsaJBDrNkNhAeZbn6wQh+SJD7P
         YahaCy/qSPySza+zdJQg0UL9spJPsdQBZz5JDn0D1XU1lkB6kDlkmX84kjgel8zvwXav
         jSzegMh+TwmC3DpJap0gNkMaFmuEQ3MBJn89NUwIIpMw2bzq23Qkfv6egry+Q0LRjTRL
         Gkt/yWUYyiYR246qy/tO9fBhQgdAE2JfH+739h1dcEJ4LewTj2v/ZdEcaq+ubeu/CU09
         lKzT4bCCYMmABHfMS6eoCbGeRZk7VePNYUs9/ayHgAMJKa6hEY2luR3+vXdAtiE/ayll
         0yxQ==
X-Gm-Message-State: AOJu0YxQAWfRiJy6t8ZdXQ3Nbp625yPaOucdaBExqyMIQ6To8KYHffZu
	vqHDZPszl2HKcziwOz+p+ziOoWlyQ+QQ+weUHhpIwOnDhSV9aCxVTdJFsI5ZWoYrd3N37wQd3qw
	ixazYRNF/cjIcPj1za8apVE9n5hb6erNxyRBNRKHar4Ug+dQhuDjKmzs=
X-Google-Smtp-Source: AGHT+IFw2mF27ESan/kI2BmFCBj3qEIE4A4pUKoetm7Q0yhab1UCtYz1cpADtjk6vngHvndR7LDazbHXgDSf4lRGjkYKPc9pks9v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d03:b0:3cf:c8bf:3b87 with SMTP id
 e9e14a558f8ab-3d17bf4a86fmr20358435ab.1.1739342985906; Tue, 11 Feb 2025
 22:49:45 -0800 (PST)
Date: Tue, 11 Feb 2025 22:49:45 -0800
In-Reply-To: <000000000000cbc8670618a25b24@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ac4489.050a0220.110943.0049.GAE@google.com>
Subject: Re: [syzbot] [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 skb_queue_purge_reason (2)
From: syzbot <syzbot+683f8cb11b94b1824c77@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in skb_queue_purge_reason (2)
Author: avkrasnov@salutedevices.com

#syz test

