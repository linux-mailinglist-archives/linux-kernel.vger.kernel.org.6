Return-Path: <linux-kernel+bounces-515868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9415A36A07
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C96F7A1B8C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033321345;
	Sat, 15 Feb 2025 00:42:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2A4C8F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580125; cv=none; b=UnInc6PUs79LnT3xP2LFHf0JVUfvnKfRCU8xCUZZCm2x1Rn+luJbINCI2OLae+nTY2bwUv32B884WKm6No/CiW5K1+8p8ZU3e8R/8SivVB6QZC0a+LKxy6wGi4MdydAYPY62qouvYBlGFgsAHLxkdPksatCIiiZk/XW5uuaNN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580125; c=relaxed/simple;
	bh=QHlgrgPo4KmuDZtdq0FQ6oJSFqq49pJE5f9O3F4cAdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h9LOPTrkjAjCMeaqmfij98gmfLHIl/kIcicVIPV2TMolqZfFpfLMfi7fV6WDCEy+Rs9Cd7SkZwhyK5rN/SzJKZ8LOMyl25ECmzlhqLA9timLL4uPWNbrlScvwPDhWgrN7cpINGxF5n+I8o6picaxVILVN6HCY53NRnxI2VKd2jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d190258f86so15170475ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 16:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739580123; x=1740184923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKwerxj8SPZm1nQF29TKoeCKUQZ2OHFk206rxIGFqpA=;
        b=o+MGT+XbCE+hsibi6lJWFImSNgci34QSwLnpA70H/EcnZpFg5UpbyW8mgd+HXBAMv8
         FcAjVIviixW8BPzXjTm3Ewawn9sJFL+xwkAGGJRSaOP9MPa26bkoBm8AKzgtPnNvZ7Hs
         4JmCXRCQKjFEpfabbYW2JY9J5sMsc/oR4HzlylzsyWKUZIN9AA+pVEnE5PCZ8DKeeDlo
         YuMvTjnO9nEaOVBL3PlQzrCvgibIL8e6y1LIRvLPEW5XHLMgG44M/Kd4OomPZZ0OFV0e
         TO7yexLosmZdS/11MKQ3rvim+HZOETGojJ/oVfQVhm1CFHTLVKq/wbhzpVgRe1qS6zPT
         V5Uw==
X-Gm-Message-State: AOJu0Yx9s4hPhc2oPpvROsFNNvM75u5EaUl/OhqiLLgIMxDXRubX6njK
	Kw7AsZWwydfzewzn+ZvR/lb/l6okqCXTMn/hHj9k7ZK5Mm2fM0COfLvPmj4jLSLjJTRhZAC7xCO
	6RQg77zK2fchtjP93lBEdGEJTiulGEInXiYBzp4XTXSZy6ToI8CDCOCA=
X-Google-Smtp-Source: AGHT+IErLpbuzK2GDubofDsR/fhiklBns9sN4jEoKhBlWF0xEHvaAnxoevf9kmawwQ0/xzs92pWcwrudL8crltIMakCPKDaWNMf2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3706:b0:3d1:4a69:e58f with SMTP id
 e9e14a558f8ab-3d18cc3ff7cmr81783655ab.2.1739580123353; Fri, 14 Feb 2025
 16:42:03 -0800 (PST)
Date: Fri, 14 Feb 2025 16:42:03 -0800
In-Reply-To: <2B47C642-0140-4981-BE7F-1E02676166B8@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67afe2db.050a0220.21dd3.005e.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in shmem_mapping
From: syzbot <syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com
Tested-by: syzbot+012c6245eaea0e23f7f9@syzkaller.appspotmail.com

Tested on:

commit:         df5d6180 Add linux-next specific files for 20250210
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1326d9b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cd616b6e736ca7
dashboard link: https://syzkaller.appspot.com/bug?extid=012c6245eaea0e23f7f9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157467df980000

Note: testing is done by a robot and is best-effort only.

