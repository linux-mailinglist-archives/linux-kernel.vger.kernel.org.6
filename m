Return-Path: <linux-kernel+bounces-436602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EA79E8830
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 23:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AD01884DF9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 22:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83318B495;
	Sun,  8 Dec 2024 22:06:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59051DA23
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733695565; cv=none; b=eDDAYheKL18pOKO6u0qEIt3i+cOvbIrzV7ADn8R6bjHAEMfn/ng1+58NbHhzrXLbE5JgjpWT08HSWRVrBCo58Ao2s8xCltw7tk0IDiEHfe4FW9rKnzjpw6qfnwp3L6iR0VQgJLORgNWasYBIWvG/8GKUGNiNfGKEjn1cj75CDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733695565; c=relaxed/simple;
	bh=2IaNsbXXC/snz3oE1gSm8BKSElrm9tP+HPTwWnIE+zY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g6LQDgKqXiEwxUYDaxdtoId4OuKnoIiRFNcPqw/u2FwjbGqmZ9rqzerQBwXcd9iinE5rHa5lLflb6pbpUkOZo/N3V9nK3cncMzwgaE5yHHhl77JgICNoZOwwxs98uoSfytEo1Zn7yTOoJbv4sCh5BlC6BDrqu4wWpIOTmF0w6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9cc5c246bso11099555ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 14:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733695563; x=1734300363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSZMauOgrEjsql57BcG21QotuDMF0fkMj3KvE0hMnso=;
        b=e7AUFPGMKvvfweknC7ZHc+EbApOsHv4niKe4Q42jz1hwP11zzUM+FFKvqheiFWsE4x
         neALKeyZh5XMMeVF6NTkyuxx8awe6gbSTxoD3/qvYbaTXbA8y2AGLElngufxb0u8fLlk
         5HRiJnNP2mef1V+OKhwPXCI2T3m3Y1FspuK4grzXQCK5lpNKp7DJQN8xKaRskwtryAnC
         ZPXZtwpWQ82Llx6JMXOSIq3ENq11UdJe6rRd9+v0mdhpgBvahWcqOE7HKdKYSS/dCOvx
         XAzml8mmYn30rreOYOy1d/AsHGSiD4omyH3tG7s14WMim1Eaow6CcU5g11jUTad0cVVk
         vNwA==
X-Gm-Message-State: AOJu0YweRxprT/1DpNUrn4cOfX2NpAU2Qz/TM/LBJjJ9h1fZJIDSm5gc
	Wsy4Fgo1186SXoavkobcGKrFTLbE9oD0VHcOfijDlMTZ1LpHpMWVwy45sWb0BXaZhTEh7bT5f53
	+NqxyN5ogQAuVF33Jg3VJ8fJM57OuJHLMvt4C0LDzHdhgcpXD8ucehDc=
X-Google-Smtp-Source: AGHT+IHpXMlFeFmqlSjAu5rxFeELzsFmWM34Pd+jVXD651NZXxZ461hvyZw22cssPi0qNMmpQr4BTtyp7AhrxMT2kTM7OI0ZR9Kz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c265:0:b0:3a7:7ee3:109b with SMTP id
 e9e14a558f8ab-3a811e03747mr113122465ab.16.1733695562894; Sun, 08 Dec 2024
 14:06:02 -0800 (PST)
Date: Sun, 08 Dec 2024 14:06:02 -0800
In-Reply-To: <D66NBTS05F94.363JPCPCZ9AZS@getstate.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756184a.050a0220.a30f1.0188.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in mgmt_remove_adv_monitor_sync
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mazin@getstate.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com
Tested-by: syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com

Tested on:

commit:         0b6809a7 Merge tag 'kbuild-fixes-v6.13' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14409944580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=479aff51bb361ef5aa18
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147d14df980000

Note: testing is done by a robot and is best-effort only.

