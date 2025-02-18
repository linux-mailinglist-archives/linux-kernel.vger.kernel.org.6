Return-Path: <linux-kernel+bounces-519944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB8AA3A3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A491896D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A87726FA79;
	Tue, 18 Feb 2025 17:12:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91F26F464
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898723; cv=none; b=UV3sU3W50KhalltPslFKqii8Obkh77lILghSaG77o4tcn3EoD4KuZvtI55Kse23SHMjyHIGuQCyzcHFvVp7no4tMfwPU0N8T3UFiCZvopMus/Ev1PFNnhYm6iL7OB2VwdlQg+pMNLvJZpkYjMLA1QDt5ahBicOvap0O7RIq0hF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898723; c=relaxed/simple;
	bh=lDpYjh3VSbmvm7pcdlVkKB1jdgcsMiR+DFO5TPEcpgU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lSEEN9vbd5IoedOn3lNi54yIBtguOHSB5G1+OgO9rroWDbzJf00HjY7wWYyozRWIrKEUYvBwz9jv76osdHUJB97DZ9CfezrP3lU1dxDKSiQQDJGVTqRwLIiNc38N4mn/DRG6yTEbILNClkdrloHP1aZPoCMlQlwbrPMBv/LI3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d2a63dc62aso8932955ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898721; x=1740503521;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrV7N5ufKl/ReOlAEsGur1cJU+J+xnMEkV63I7/jZcY=;
        b=Gp+/cio0SOP5CVyCYUFvv4NWl3iQkCjKUJuRx1WMtlIA63s0y7qQE0L5LFk5aWXDY6
         vsmG4xyomikXXOPAhGinETj4HhGhOmldIoArGjrrEb5Q0aVLVTgIMRA1MhBXim3x7/MV
         59u8PagA3OscQLcrQKDpZlIaCWW6Yg+nvQt06m8DqADFNn0PQOGa6AhOhtY88akrQoap
         mMlaLaBQJ1akuyHhslDklalI+FL0CYVBH0o82VudIPyJREr2cSUZqjhW3vbuW4fHGvAi
         lE8wrbRuSiRA2MjYLKwmxrPljJ5AFfaO8rABM7V9b4RGzgVXgfpNl7FJpn0nJe4uZw5C
         1WTg==
X-Gm-Message-State: AOJu0YyjHnhGl+WA5kkqXhgm/O4ThsKX93hgugx/t+jhzx13t7flvXQI
	7FV9VL2wHJBIOXS1BIdwpLLxOHu6pX4mB/yuGGRuHvilPGlLizd8ntA8/OEE25agbo/XqHpKAU9
	pH9dlTR8ysVXQDS4o4US/yOUIqC3DUumW5HgNKQTrUb0JnoPE4wsZykA=
X-Google-Smtp-Source: AGHT+IHiMuAh3VgfE0orA5WJY3MVl8l6FZS6JYjdnwB9HTYY+T/wJUwKzCU7KbPA8qXtzKxUptB5KAtuSHRXqhtVCRK8HKGe1Zq4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3d0:4eaa:e480 with SMTP id
 e9e14a558f8ab-3d280763d29mr146169585ab.3.1739898721557; Tue, 18 Feb 2025
 09:12:01 -0800 (PST)
Date: Tue, 18 Feb 2025 09:12:01 -0800
In-Reply-To: <7ADD7E39-E7DC-4A40-8236-CD5C90112C96@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b4bf61.050a0220.6ca4a.0003.GAE@google.com>
Subject: Re: [syzbot] [mm?] [bcachefs?] WARNING in lock_list_lru_of_memcg
From: syzbot <syzbot+38a0cbd267eff2d286ff@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/bcachefs/btree_io.c
Hunk #1 FAILED at 997.
1 out of 1 hunk FAILED



Tested on:

commit:         2408a807 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c776e555cfbdb82d
dashboard link: https://syzkaller.appspot.com/bug?extid=38a0cbd267eff2d286ff
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139b65b0580000


