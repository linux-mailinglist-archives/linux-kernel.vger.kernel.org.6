Return-Path: <linux-kernel+bounces-282569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E194E5E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D470282043
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775B814B940;
	Mon, 12 Aug 2024 04:53:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5654F95
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723438385; cv=none; b=vFURDP/22WctzO7F/skS8LMuK/1ojbAnjRyCoGcWxi40zxOG3u8qOzQR+4hEly+MBlnauiMFzK9qQcY7rBXJJO7lVoky8hAJFs2+C5FB8feHyGeJ5mZLJEIqpPnw99AH8QyNFsSPiUJQBMrgOJaMCwQptSV5742v2qYvfJ6G/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723438385; c=relaxed/simple;
	bh=wbPL9xTIQV0fKwjKstFY4ij6hqeFTYyO59yYSlmm7kE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D7486nK4IkowlxG7KFiAfOhzyF1AVpfHzF39hONziQeLaJnieu4i55TiEGxHL34EadU2r1SEljnc41gF22bgnd7my9/SkUkTtcd7+03vlN1u5wN6GaD5T79GmY9UO2appOWBlswmLLh/EztprqX+hefezbRaELBp07RP0pI+Di4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f81da0972so556500039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723438383; x=1724043183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCIUv5W1hQZANZ1PEvV4VxKZP1pSyOaOOcCYK3C1sQI=;
        b=O5JMasDwZJfgEU+xHzdnsoR7ID1ogXxU/pFiMb4dR3Y96mUQclHHcRva4blS+eS/m/
         W5sK3gpyw3MKqx5ahoRC/Z/X2eNvQFQ73ecbpbm1zhzIwqhtlwwKnnSBpc1SnbapzSRy
         AU3E6ghES/NXWH2aGuAy+C4KLRCgakIm6e7TrZxVHlNYrrPf6xCoKBJaX6e+TsCPi6SS
         iF7kuqQ71yuIC9XoFF7ANtlWp0Fy00Fs/ZpN9NP+Sinq/x9oT91KRvwAO4mOJa9uzBxZ
         bILo7TJpOqn6VXKjtolqSiX7F28YJbiMVTg2tgZZhgjEvM3uDo8/DIu+qIYRd8/kIArV
         KKPw==
X-Forwarded-Encrypted: i=1; AJvYcCUT49OQE193MZwFNaFIPYK9J1DeKyDVJrPn/OkuRuP2/uvS49XsYMWxBZs37yUMWVEKji2iWp49+ntk9fofQmjPlrKjXF3Fg/eVCdG0
X-Gm-Message-State: AOJu0YyVi3zzwcTv/rcDaHmtSgnzQQfQeOLKtvi74CrJQHULx/mqDfNs
	5eGTjXIEoYuS3MQwO2w0IjYSVPJXytkkobU2tIa3hrQEFjrzm05ilDbHX3//9zgHwMXl0yjXSKh
	HLHn+KNqO5jsr3TidhfExYldOfy09u3T0F3ZRkix4wmZ7mbyasD1Vk4k=
X-Google-Smtp-Source: AGHT+IHYd+OnzWf3WONlYUINKA2XYz4D597wPU1q1yxE0VsRcZoM2LIA3Gz9v5hY/DdXx/pnUZRWQH+QReSO0PWFGZ2UzuXHaJcN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640d:b0:806:bf73:1167 with SMTP id
 ca18e2360f4ac-8225ee96f73mr27822739f.3.1723438382830; Sun, 11 Aug 2024
 21:53:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 21:53:02 -0700
In-Reply-To: <00000000000061c0a106183499ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099eca4061f754420@google.com>
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, jason@zx2c4.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	oneukum@suse.com, pabeni@redhat.com, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b3e40fc85735b787ce65909619fcd173107113c2
Author: Oliver Neukum <oneukum@suse.com>
Date:   Thu May 2 11:51:40 2024 +0000

    USB: usb_parse_endpoint: ignore reserved bits

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11ca267d980000
start commit:   dc1c8034e31b minmax: simplify min()/max()/clamp() implemen..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13ca267d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15ca267d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1022b573980000

Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

