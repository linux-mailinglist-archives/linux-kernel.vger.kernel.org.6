Return-Path: <linux-kernel+bounces-349412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E66F898F58E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B14A1F251A2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED851AAE1D;
	Thu,  3 Oct 2024 17:49:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008638DD1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977775; cv=none; b=pFHI+WyjigMieJ+6QrgKOxdENKn6Hx3YokgRsxhPFf1hKRibu+ip+ytNTwciaawMZC7MS8nHfBAJampYNwhtVN5BNyVJUOsq7bw3E9uEjrwPE6yFcZM6gHHSrUWmOpTWK4JkTQsHxTVpsJLz7LL+t+bzbt3EWlDtZ5FPSzv/cy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977775; c=relaxed/simple;
	bh=O8ruqtPBMirH+B1IX8Q2RlZDP8tFGxNpRmrpN6KDoIc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fy3OWHz08LoxAR1y/VLlbMddFWEMPsGeo3OMVSoHYmkQ6obGaa5dAnh7wiVclP2qFBLkAdJmoRCBzdCuCFqRmO3tOH0Su3aHD50Hkb9Xh5oFipNFh9TjHSdOy/reJMgP61QjClL0JnFiKXIYHC0K240pX4me2ep1iKE0ujeJmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a6d8bb03so13451445ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 10:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727977770; x=1728582570;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H34jU7qZH3uxxv94ulFV1JusJ6pKMr4bePGKkuXNFQw=;
        b=kniDh+2IFkMKBP2HC5L0O+To2+rtSVjyVp4Vom+f72q/lqbNX9rym/Gs4yErNJ8rxI
         UknW1O4zy3ZFSDzlc8Jal5mC3GXVndAQdyu1TLSPA72caGIPZOLtm74nWBQWn9oosEcu
         8ve86JfAzAwfAqe/67NuJpv19fYfmbF7PhSMcgHBhdrN+l5AvvRuQAAXCTGrEBg45ba5
         Q2eyIgySKH+cznmUsr3aH0kEG0+EPFxTRyi8Jn1s62OObc03uj9OWWs7HmvEuIl1Lxfg
         7Tb4GuX3T1ZU+H6yQejM2r16dTlRJLzl4PzkisQeetKSceZal1QnHhzXohPGNAm0Vf8Z
         N30Q==
X-Gm-Message-State: AOJu0YyR0LaA3hSg/EEgjRAEJtJlVb+OiZ7HQc1YWvZa/lI5cjhlOfny
	SYgMuab4n1VjBjrrJDyx1c7HBywbMDnukZIaHRNxbS2mFyyYLYmFFBVQoxhBkNz0X0oLRouOsX7
	s018lpeix9kEgs0nWRa2CcctqocBIgmFm0h8ksVFRdWdYpumzSiDv7rA=
X-Google-Smtp-Source: AGHT+IEkIZAyZFVCXIqKgXQaNrzdZ+X8IhGDvzMhsUR+ZeQaxKdCV2tqU/L3LMuVjKDmW01LaMdBzL6Z4rJ1JJOw0iX6cQB1zXQU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e2:b0:3a1:a179:bb54 with SMTP id
 e9e14a558f8ab-3a3757c6cf1mr908825ab.0.1727977770669; Thu, 03 Oct 2024
 10:49:30 -0700 (PDT)
Date: Thu, 03 Oct 2024 10:49:30 -0700
In-Reply-To: <66fec2e2.050a0220.9ec68.0047.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fed92a.050a0220.9ec68.0052.GAE@google.com>
Subject: Re: [syzbot] Re: [netfilter-core] [syzbot] [netfilter?] WARNING in
 xt_cluster_mt (2)
From: syzbot <syzbot+256c348558aa5cf611a9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [netfilter-core] [syzbot] [netfilter?] WARNING in xt_cluster_mt (2)
Author: fw@strlen.de

#syz test:  https://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf xt_cluster_restrict

