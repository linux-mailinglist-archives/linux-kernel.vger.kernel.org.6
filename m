Return-Path: <linux-kernel+bounces-413321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B1B9D1753
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2AA282E09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850C7197531;
	Mon, 18 Nov 2024 17:41:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57241CABF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951666; cv=none; b=O7SERHvJXWx3OmAczxibKi/dfAu+2XXvng9I2s57nHcRUMA1ClC3jZSPQMvb5KXGTS7A34BC40Ox6kkyqsivTCVLtdV0hKtReYmUNb9+cdvnf4IggrB8U1ijhrZyKMLp7W1CreZmeqr/6UU2UJD89j8XPW7e5rcWYGb0dyDJNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951666; c=relaxed/simple;
	bh=q9Qgt2DmgQFigkaYeiK/TKVRJt1z5fm0Ha46dAqq1u0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Htyh0yhnGJU3/CEey83H98pzZHxV8Fjrs6ECstJRzctXWP3K78x600IvpKtTtHO5nbmg4ZzJNdxwXU5tfWPXZVw5Cb3dsEy6yUS+dEYBXKXXecEbHB0WmIDQ74MEsTuROoCuHKPWe/mx9ucQJKeSfqiBnilDbxCXo1QVPGXy6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7642d452dso13503105ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731951664; x=1732556464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+eyOHdkIZSYMZRH4DcsQR8I81X6UeSZ86aZEWeyMBA=;
        b=NZSKjlooPOILe/qrT6H+QaEsT+SFU000VEIKSKd636T8GAq/U88YWdaYRCUeKrsuUB
         lvYX5oq8PIEz9NJ/COiMamlcjzCZ10SELvASVyZK3CZ8oQgtedkWxepVcO2zYc/L0Lu0
         YcJmKIBUZeMyGmmQaDmJl4IJuQPzTGTeO0f8QzBus5K144WNqzf1MK7axfl51zYxePfA
         cDyS+oSVbYGojIpCXFrwauvwB1Y8BpXfNOID3zcvrDTzklsLvw7AM7R7fFXWdF4rkTop
         lfhg2lKBqbgox1Rl8Ugp53o3YHteFFTCHseGmIwYR+8FuKtpBmN75B/LnRIL/CnPAGnc
         +t2w==
X-Forwarded-Encrypted: i=1; AJvYcCWH+zi7mp5LV6D+zY4UP61BqP0ItnqOveSjdJRMUElc/LmeU6CR/VFWn68fY0ehlo8QIzymGefbnLs1G2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4luvs4YFkSP3np94RNnJW+ECSQPdBdDHL6UHIMQ9QPjWsq0bT
	Qnd57pSlckdIidYZqsljiXQ/YzyMYh2N6lHNdEhfT7DOofVlbeAn+RvT6qdJSxzvyzpBERvpTvJ
	cc5HOOyTSPreNGX4mZgshxSjng/jMwEdmtDrpBCgGSJU6VTNAT6vAqrY=
X-Google-Smtp-Source: AGHT+IElwG55NQquD0GWFUFxabkI3rZ7NfRUYnvEJbi5TbWuwX/VdFh46AaPLhqYxQVETibg96kShUvE3RMzLvCLW3O+ePH1FTcs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1382:b0:3a7:158d:6398 with SMTP id
 e9e14a558f8ab-3a777448011mr1522735ab.7.1731951664002; Mon, 18 Nov 2024
 09:41:04 -0800 (PST)
Date: Mon, 18 Nov 2024 09:41:03 -0800
In-Reply-To: <949458.1731950611@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b7c2f.050a0220.87769.0053.GAE@google.com>
Subject: Re: [syzbot] [mm?] [v9fs?] BUG: stack guard page was hit in sys_open
From: syzbot <syzbot+885c03ad650731743489@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, asmadeus@codewreck.org, dhowells@redhat.com, 
	ericvh@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com
Tested-by: syzbot+885c03ad650731743489@syzkaller.appspotmail.com

Tested on:

commit:         2aece382 netfs: Report on NULL folioq in netfs_writeba..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12714930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=55f8591b98dd132
dashboard link: https://syzkaller.appspot.com/bug?extid=885c03ad650731743489
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

