Return-Path: <linux-kernel+bounces-270578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDC2944197
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EA1B21B00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6656D14286;
	Thu,  1 Aug 2024 03:16:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D41EB4A2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722482167; cv=none; b=q5KlkXkZjpXODoSTOt8kuNrgvQoJFCoCrZq2V/B/XyQmZ3BJzkxCEtPC3YbgwE0CgWqAGjhGKX3um8L3BMspEOnAQSlQFiXhfItIMJvsUhiMBXuJ460SUbk4Vpq2R+QKmdXYVAS9lEGqwi6IQqyLCOKKO09jvHVwLXOMRZCek/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722482167; c=relaxed/simple;
	bh=tTrkGaERI+6C+yvGp4dj2OAwKGULSnXUPbWJxzuDIzU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FjCPw/GVPNzH/Bzcbj9T5RrWhFDXI/r71H1xdsX5snoYOllv1NC7i4yM9eIidjgUf4L28b8Hoz4LgH0Ci0s2ehn/FlZt60iudmBgHo18q94Pq41BD7PNZFZ39lAINMCZAz9rPphmzgFGnzsb1Sf6M0bHRohuei5tkEmZgixbb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f869f653fso925200739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722482164; x=1723086964;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj+3YzbFyqxX8y3I1pqPNjpCc4I94FNkS3JvGpPbypg=;
        b=f5y08X6fsItEl//8TlKLr2mARYxIFoZ1skyJ3Cdt2IDSQ5obn6kR/3zZr11wrIFZqs
         UV6srPluiP7rVG/hpTEnG6Ho1yOUaJ+zC2kZnaU35rBM8ojOu/osVZCHtoGZzNYPONyu
         0W7hjsrlNBgUJ0UCkHzhR0UKpksPHaBKN5SoXo5hbjEbuyoHxBsQHIvs8EtLJIug8ps1
         TvsN3RboFWuIv9ctzlrY2pWm8xMNuZA+JPwt0UGjA66DnsSTEpgzTAKK8hScAkuqQl1m
         HALGAPTIlwJ1O8p4Uz0WkTFWsIad5yrk1owyacahf83QVUmC/NS1rB+Lolha5z6BlPGQ
         N4cg==
X-Forwarded-Encrypted: i=1; AJvYcCW0+x72qONXLwtvJ5kC9GRfFXH9MOzBGalGOxIWRSBxDPWpJWp5g4QNJxVTMa1r4MGqhobKinjQZ90khGy392Du8E4Eab7BFKOPA9gI
X-Gm-Message-State: AOJu0YzBLZNsB1slsrdUrN+Mwf1DFKfuXCfHICbXNA8Rn5pAPyyn1bnR
	U3nNbBXyJBTq07nxGez9EeeE4eP3K3nGDt+lNy5xG7jnKKjDbtY8l1mncCoprcCTEIJy/wU6Sx+
	7XolMMR32Unk1eibMfV2wRLhuwcOQN4ab6gKJfByqX93DsCLWaA4RvHA=
X-Google-Smtp-Source: AGHT+IGDuV9hpbSDTD0E8eKEVJsER6jk50azZ7juHwtTF2dhv0wUoItJxs62T7dS3NIfc83iU04tDOjuRWROwegxT7flvZTgfQBV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4103:b0:4c2:7179:ce03 with SMTP id
 8926c6da1cb9f-4c8c9b668e3mr48659173.2.1722482164647; Wed, 31 Jul 2024
 20:16:04 -0700 (PDT)
Date: Wed, 31 Jul 2024 20:16:04 -0700
In-Reply-To: <00000000000030293b05c39afd6f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e5b5e061e96a171@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in profile_pc
From: syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>
To: ak@linux.intel.com, bp@alien8.de, chouhan.shreyansh630@gmail.com, 
	contact@donation1.gq, dave.hansen@linux.intel.com, dvyukov@google.com, 
	hpa@zytor.com, inglorion@google.com, jpoimboe@redhat.com, 
	lee.jones@linaro.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tkjos@google.com, 
	torvalds@linux-foundation.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 093d9603b60093a9aaae942db56107f6432a5dca
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Jun 28 21:27:22 2024 +0000

    x86: stop playing stack games in profile_pc()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1732b59d980000
start commit:   0106679839f7 Merge tag 'regulator-fix-v6.9-rc6' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a10709e36c02a40
dashboard link: https://syzkaller.appspot.com/bug?extid=84fe685c02cd112a2ac3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14276088980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140e7b7f180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: x86: stop playing stack games in profile_pc()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

