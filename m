Return-Path: <linux-kernel+bounces-243269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B769E9293D2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58351C211AC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE871369BC;
	Sat,  6 Jul 2024 13:38:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B050285
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273085; cv=none; b=HJfq3id1nRpze6RbvLDiwE3szQqQu5lH/m0voJuPzpc7AAjIt7X+4RVfk6TT91D8BOyfjo5jshpC91nlGXqaqM+hhsNpZdniRYQfNSrIghSpLm6AwjqIQ9qUIaAw24pg8uG5gPX7QNaC/x/MqQFlweQsxnEBLk/1nWw6lQeWpkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273085; c=relaxed/simple;
	bh=zWaW7v6PJhOBV43NT3fE4HnLKL+0G6JoD8gx4YTscdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=txpFJH3wy+yr0Ml+0mGhHLr0p32F8Y/MaNN8IQmynmkSi5/pkGSFPdupsIRasNIrnwUHdXb/DuSBcymFhiUogq6fI+Lcat0AqrdGno37HlXMYkGxrgmYIXkVnEUW/aME+peGUYeYIImZNIiFr9KRkH6aZbc9qJAZ2iBES0A9K0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f92912a614so35587939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720273082; x=1720877882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrvwA9+kz/VdMLLWXSyRN3pFrHfsHxWlAply6NHrwzg=;
        b=MO3FNONi3ELes360axVqQCwzWhBTo+4iH1TeqtXs5yFVahRRENBZnZWCCxGGooCU6R
         ORz+Fi1FFzi5j5/birM1lK8FTj9D3Gtbk6kEi6w3WeenIOhnzz0hYM5EezQlSE+kup92
         edl8zIqG6OwKutNLSn6mIDdao48ZwxfqczuijZMAp6Y9Xd+/LpklGAiLldnwau98teFs
         nX6QZ/NAGMt3G5gKCWtOzKhwP90XEUACE32V7ZsKxxjmuju5qURPU9XW8Vblwd+dZNvy
         x4RYXh/q0oDPPUKSwtb/L1Tl8SJtX2fhVcMImGSI06IcjM8wWlExKXG/Kmuq4e2aa0zC
         FV5g==
X-Forwarded-Encrypted: i=1; AJvYcCWn1fhvbsMdkeMzRnQNoJx7qKdcPWgvpfo8LgwJN7trPsklUoJr3Pz3LH4LMDYBU4mZqBF+VaRYtxb2vpabsoq3KAC+r5jnlvtrIwLr
X-Gm-Message-State: AOJu0YyLY6W4jFklRH08qffocNfANPjL3QvMnLkUfTbbZCs7mhtzIwAE
	myFWEiBQL2u4KCQQ63V/cvi4V5S4yoR8FZIAT5x/sANv4Bg+uJD2N2wvV+g0HGyNB6cFYYztQ6g
	/hVWuWj9wYw7WJ4RwKj1ETkz1KXEV17EfDGQu3x7zU3PUoumOcPNHvwM=
X-Google-Smtp-Source: AGHT+IHCSx2+VbzZCCozhjDVuSHJ5tQ1gic4b9jAHvFVi10Tecnep7tLHfjFLuZpWjQmZJs8YvMggPuufjgt+z+fOZLhmQgFhl/w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144d:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4bf63c2f6efmr1014361173.6.1720273082401; Sat, 06 Jul 2024
 06:38:02 -0700 (PDT)
Date: Sat, 06 Jul 2024 06:38:02 -0700
In-Reply-To: <20240706131317.Vx3MriDC@linutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe576c061c944907@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_redirect
From: syzbot <syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, patchwork-bot@kernel.org, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+08811615f0e17bc6708b@syzkaller.appspotmail.com

Tested on:

commit:         2f5e6395 Merge branch 'net-pse-pd-add-new-pse-c33-feat..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=12f8b8a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db697e01efa9d1d7
dashboard link: https://syzkaller.appspot.com/bug?extid=08811615f0e17bc6708b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

