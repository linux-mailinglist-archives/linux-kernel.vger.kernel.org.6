Return-Path: <linux-kernel+bounces-446251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649099F21B3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4EB1653FD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68AC133;
	Sun, 15 Dec 2024 02:08:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934B9454
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734228485; cv=none; b=caN0UQElOpOqYZjxVF85BMm9KlLGa40+XHaGdUmC7PqlJbZvITzO3+F8Z2aiNVrE/HzqtHnwByRNatg4Y6wiRlzil8IPfDFPvOgOmjIZ3d1x3M+W461kT/4y0wa8pL08bZ3pVZHdxbBLGXlvySJqpcfOLnCvDFtfi+2pzngMvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734228485; c=relaxed/simple;
	bh=6qdMR42hVUJF4DV+QEwMMQwa34hqKIvQBSpxMS5k354=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tL2UxuFa1owE1KE5BeJ3gjaqCu6/tzp7GjOa4wEvkFVfoqT7PDKy5g3piwoJB0vUvDSZ/JU+cw+9fYA+YTcmlt+wRwWgH7mFn5FU+J8xhXZW5HRO45bX1mYUOMYnEFk4q/bmTk0t2jbOywh3A39Ben/t5/tnoqHmwi+fkPa/Osw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a81754abb7so57673795ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734228482; x=1734833282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVd9QRa3RSnLpDuiGhYrNBGak9a7U/Tb19aR7sZOG30=;
        b=IaCnVv1b03PCDY0peSQaYK2ak+WfQEvyR65FmDr1ru/pJe7tBFeqMRVLAGENuFlsey
         vMgFpw/DEKHUaTvuvOmkjhUeKtVi778sJcdka+0ztno33slZSpAWQR4OaqRoMYMVg5Q5
         bY79U2D3bu1gO1TsXEa1LgVBFGNoekQELH2Y5rX1yD0Rsj4CpHSMEZdtxsA6jycTgKug
         BJ5ydVV7mWZv1g9ywNJYyMPMNAhoi70/B64zcr+uFQ8xgHPA7HVcMXZaJtsuiL+P8IvP
         D/E6OIAYrYJdowO2uPnGTRZtir9Wz530/YBOoI+Qz5uRuZqpZRXOuLlKIF3Okwm7khRU
         3xfw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/9arzsP7S7lMI53tadvbN8YXud5L+ziqpdBfTER7lQer86TogEnYFPrjWXPKOMD5Q2/RaYVi6Oq6W7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHuyRB6JZnZjyOCkSZPzho/dt69l85HMj3CM4GslT4eKfUtBSS
	K4ALIVdjaqnQfeFTKXaSFAmjd/5e3RYap4wp5SERNWUxD51WVmpJ80qfDZfNcPhcqxFrtUbRQO4
	V3KLERRghSDaiKHmDg9U+YwDa5wQCvcfjIM0tdqrU1FDPUU8KytYrvEE=
X-Google-Smtp-Source: AGHT+IEAezhzXIjYYJ6ypzh91V89nljSboeSTN+syCQMHBb/7tdQEwRGb9luGwsWv0doTG993TD+phZw6J2KJN/iaRs+NUKr7TeI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3a7:81a4:a54d with SMTP id
 e9e14a558f8ab-3aff1118613mr103484095ab.20.1734228482639; Sat, 14 Dec 2024
 18:08:02 -0800 (PST)
Date: Sat, 14 Dec 2024 18:08:02 -0800
In-Reply-To: <6731d0cf.050a0220.138bd5.0063.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e3a02.050a0220.37aaf.00e3.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in six_lock_ip_waiter
From: syzbot <syzbot+13b85e45ca365499aad5@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d46730580000
start commit:   243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of git:/..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17d46730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13d46730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=13b85e45ca365499aad5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17312730580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f4bbe8580000

Reported-by: syzbot+13b85e45ca365499aad5@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

