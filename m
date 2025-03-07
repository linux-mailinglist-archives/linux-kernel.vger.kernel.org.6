Return-Path: <linux-kernel+bounces-550707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039AA5632B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167B23AA8DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C81E1E1DEA;
	Fri,  7 Mar 2025 09:03:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18521199E94
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338188; cv=none; b=Ag/40FTdOlif8IUaIL06j/t9mqalblbvM0nbZ/tVMATfAyl34lg1CIy1pCZRSe1EmWTXsAFy0FSGqYpqHp2kUiNRKX0My7Pbm8tZVAy7soYi4xp1v2wHn66Egw0RaacsvbDexL435k7UmmQCFSLs6PwJFYWKATO6xl17ci7yumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338188; c=relaxed/simple;
	bh=UIED+ZSwDpKgtvorZJCYaLdJuF2N8uzJYy+7I7lCU2U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rL1DQZ46ZULmUVpo9Pc4JiWVrjQ9nuk4OwEvAjvZi8uBg1oDSyjuUN/yvkPsONtvBlwMyDOax9QIlNv8Za9i0O0zJwxicvooSogQ9d3iKSi7s09wJvMYXtZR0O9Tjp4qlHJt+1c2gDsdlCqe/ggDK/Rj6N1uCoatJhaDneKBCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-84cdae60616so115746939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338184; x=1741942984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0OGtwtC/0/h5Zke+C8aKYHucbXvEquiBZ75ScCKlJA=;
        b=M66MVzzUJq7daGGpWmpdNU3QDA2wXUSSNfE3Zd5+Fqv6MiRVw59Q/UaMRoktE0AmAn
         1pPztW3w8orwgjY8yuTCPTgNVwxVLABKZMmFujlrjOhNvgwJ1gCXaUETgx5jTcCXXdcs
         MvojvKjdqOoMW52X8IhxS2FNPI/McWHT4C063pM9UfepXyYuaYrbpjQ25IFRTVxgogHt
         d30TkxMTH6+CeWBYIxCtZE/7PhHwvvNJZC+BZBkfrX48M8xKeSInytqVHrutbP8ZQTnT
         jhkcBAoOqurKDix2vNCFBX6KRVWuPeIzX2JuPqvd8KQor9pLmZeD8CbG4JGk/8M/VJdq
         2CzQ==
X-Gm-Message-State: AOJu0YxQ9sNDOrqUrQ0E9DXqvUv1JlSowLjziimxG18x1ihUqL8NCpWK
	DqwbmZOoAuu9vZzxQRRP//kUtP+evyXxegukaR3qQ4Hk4ztHa6r+6UKbpCvkeUpTD0CeSOe0UgW
	rg54xk94jzmTSq1AfU0C+Z0pI6X+Y+EwK0FG58vvr6jMMGJvFOOgNOWc=
X-Google-Smtp-Source: AGHT+IGAf+0D1FSdVlMV22FFwf961hBQTRqhWCdsQcxW4rhhCBdQDrG9Xv4qkPPVdnaKCcOpgOhz8hLQjh23o0OQkqYubRVA+O+l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0b:0:b0:3d3:ff5c:287 with SMTP id
 e9e14a558f8ab-3d44196fe0bmr28335245ab.14.1741338184124; Fri, 07 Mar 2025
 01:03:04 -0800 (PST)
Date: Fri, 07 Mar 2025 01:03:04 -0800
In-Reply-To: <7DF09BB7-B234-432B-A5A0-98575B756EFF@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cab648.050a0220.15b4b9.007b.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in validate_bset_keys
From: syzbot <syzbot+3cb3d9e8c3f197754825@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3cb3d9e8c3f197754825@syzkaller.appspotmail.com
Tested-by: syzbot+3cb3d9e8c3f197754825@syzkaller.appspotmail.com

Tested on:

commit:         14d05f12 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=119d8878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb3000d0159783f
dashboard link: https://syzkaller.appspot.com/bug?extid=3cb3d9e8c3f197754825
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=157aca64580000

Note: testing is done by a robot and is best-effort only.

