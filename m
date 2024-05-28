Return-Path: <linux-kernel+bounces-191658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9BB8D124C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E192284065
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029E8F9D6;
	Tue, 28 May 2024 02:50:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396698825
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716864605; cv=none; b=MzjXwCf57LWmiSpAkyGaf+zvb1yK3BUilTl2zSmw069mfLkxPTTX/5qIskuDdpRc+pqXI0HIZ2JAjqgsWe82F9Be5Ae6jpz1o1ugTBdZ7wM4cBHmdq0qe83Ow8TPtJ9NFzc0QNls+sokXzdLGquYsL4fznY1ohXgIq/7ITpdxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716864605; c=relaxed/simple;
	bh=hX796rXSwtq/K2hmf6qXbrcDx+cm+U3Ok3j/3g235IM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ih7u9oceGR3yTSmNBDUizdxsQra4ATDkgPdh9gOFl8znL02KkBvL0WE4HmphLLGabubFZsGCSOvQrO7zzysBrE+m91xgzCWFmlrIZcbVflh1hmajvcTAswDyLfdGC1E5ELHHNuPwrOesVjNpaxDJZIB4bumozgEdQfGnjJxKkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-371280b8ddfso4040555ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 19:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716864603; x=1717469403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cXmF4n3w2NyNyVAQCGsZHWSqE6AcwGvAmjmQMYRIE84=;
        b=j2+6/DtdDL8zum4i6SzihHlOdXUr+MEUzrKLQl8sNf4awvxb1CAIn6oXdDnAB7mhlr
         PzDfc5SCYVJvB6JRD0UVyd7HytGmS1wSkRWKUbLwkYOlawHEnFTkLsTp/9QooWiIMyLU
         MA6KZykQV8HaBTgJrQdT5frt9y6HZ/bRpnqQczMHwHKUD4aEY1tjOehDfI5pVi1HlXlw
         0ayVJXXFdiPvq1VVNaresBOB0Q45jbP/UQXGHXg0ljzw98NffqlpDNDE1kvbSO8ENC5W
         FkFOXm7scTJjyR7/vP/Pq7vG/2izzM8iaLrS0RIIsGOvLug4nHc/3K6UyYAFHZZr7qto
         qSQg==
X-Forwarded-Encrypted: i=1; AJvYcCUPdFlW8yhm+tjXGN8v6dsph0fpoaU5iA8NHz+M4KzfLKWj9vKsjnPC5Wg8Fvsasdz4aC3Fa70Fu1VJlI1VY9SsmmCKE3HA9pHmC9f7
X-Gm-Message-State: AOJu0YyaJQBmQhqWfYUmfi7MAgP+PojPnKBeA9WqV11bE+eslYru+LOZ
	qIz4YTwpTr+dOiTFOri2BuwKdNUFb+cjRN6jsYPY2RBUePX1rZCWk7/A00ZIJoiVumyDvzV2Nik
	stzMGxtLrFFUtiwvZz3IUuJ8tOkfUC3ohkNhSkKi8w2rNGqwsy/w5SX4=
X-Google-Smtp-Source: AGHT+IH1gn8SrewRRF8Ky/aHjelfrALLOlApvzDNZptiCEWeOe7AI1wof5wTAwi3dOAPpU5PwQ+yW2pPzG3ZGrzPsfIoMX8Rxg8g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a49:b0:36d:cebb:6c8b with SMTP id
 e9e14a558f8ab-3737b2b9aa0mr7326725ab.1.1716864603390; Mon, 27 May 2024
 19:50:03 -0700 (PDT)
Date: Mon, 27 May 2024 19:50:03 -0700
In-Reply-To: <tencent_0974B3778B662A3DDD36E0973636FE4B8609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0156c06197ab0d3@google.com>
Subject: Re: [syzbot] [nfc?] [net?] KMSAN: uninit-value in nci_ntf_packet (2)
From: syzbot <syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+71bfed2b2bcea46c98f2@syzkaller.appspotmail.com

Tested on:

commit:         614da38e Merge tag 'hid-for-linus-2024051401' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10f2d63c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
dashboard link: https://syzkaller.appspot.com/bug?extid=71bfed2b2bcea46c98f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10071592980000

Note: testing is done by a robot and is best-effort only.

