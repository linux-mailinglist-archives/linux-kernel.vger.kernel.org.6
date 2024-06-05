Return-Path: <linux-kernel+bounces-201862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CDC8FC458
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6117B2AC1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5281922EF;
	Wed,  5 Jun 2024 07:16:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB041922E1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571793; cv=none; b=JPE89DQB+/LWJ95qMB8HsFXhVmZ51IfmCjVuuIszWInxEw8y+h8om36aT7rY/n1uOvjrmteQTpKv4ip/At7TP7xM3fk0eWCnYS5JiKD1VQLhkWdC2guytdIx/CfTuy2I4E0rWkzvYJk6jxdoqIXsbAB7VWK6RWFglzT6COdFjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571793; c=relaxed/simple;
	bh=spoIagucG+g6y9Jzfkyx8tJd0E6gU2PK/OyZNdp3Ev0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GBcIQ4giEt1znW+VWkoz26cOu2wQtbX4mCEtPcr5evpNlNybtnyGAM4Oc4iK+BLSy9qB9o+HeWGi82d27RPCskzGN9DWm4h8L2C0WmRi6/Yojd4cpY+AnetT7F4+K2uDYe3GpqOEPAc2LwKDqw7uxPWqAr5PgccSfE8P8sjYTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb01189491so229824939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571791; x=1718176591;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spoIagucG+g6y9Jzfkyx8tJd0E6gU2PK/OyZNdp3Ev0=;
        b=lNUMnDLPGCBnEORMB1wBulfu/zA47WsfhPpMBdFsWNyCZAi8LWVgwrHcJD8XFD/UJc
         uTPF/xvvdS5jGxx14uGe/y/trdLNylPV8t11cc1tgs3ePsqplbF2K+zmR4q4d1M0qBhD
         iuH90DsN7+1XdodjpvjyZWd1/Ha+ivLSazg/sZonslqoNZZzV5koE5TUG0L6Camuh0aW
         O1MkFrjyeZK0FdfA9runsFDU3wKczbTAyFNLKfHDxpUbDBMY0hU8+dHieo/PPhrvoOuX
         dSsPHHjEnMZ+Ko+6t3YWjcshYRdHOmed6dRpJtkzZKDzrnGlgU+a0iFZSFAJVZZIZpL2
         oDNw==
X-Gm-Message-State: AOJu0Yye8ZbEPdOmF0jGZI3Ce31LrEOmH70q9ijfmMPaumjdR/7lagke
	FJc1mRe8dbwsMfgQquz2rAykTw5qe0RXDszbnA7PMiD/qH0vtrdq3iSMRxwVSM6omNhlVtDhZn+
	LgFKlU86ii1ku6uCImPyncUDKK7puAl9+Xv+Crn5PUMF/VDcLfQuqIpI=
X-Google-Smtp-Source: AGHT+IHoSb40IqlCTvnN15HxUkXaNPb2EzU4ioMBgZr9+nT6JwrBpKNtl2BPQe8UCn08D7nshY93JvpTsvWUy3CXA/7Jev4f6miI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe3:b0:36d:b5df:f478 with SMTP id
 e9e14a558f8ab-374b1f6586amr911535ab.4.1717571791585; Wed, 05 Jun 2024
 00:16:31 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:16:31 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000839533061a1f586a@google.com>
Subject: Re: [syzbot] Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: 000000000000fcfa6406141cc8ac@google.com
Author: wojciech.gladysz@infogain.com

#syz test https://github.com/torvalds/linux.git e377d803b65ee4130213b3c041f=
c25fdfec1bd90
________________________________
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
Sent: Wednesday, June 5, 2024 09:15
To: Wojciech Gladysz <Wojciech.Gladysz@infogain.com>
Cc: Wojciech Gladysz <Wojciech.Gladysz@infogain.com>; linux-kernel@vger.ker=
nel.org <linux-kernel@vger.kernel.org>; syzkaller-bugs@googlegroups.com <sy=
zkaller-bugs@googlegroups.com>
Subject: Re: 000000000000fcfa6406141cc8ac@google.com

EXTERNAL: This message was sent from outside of Infogain. Please do not cli=
ck links or open attachments unless you know the content is safe.

> #syz testhttps://github.com/torvalds/linux.gite377d803b65ee4130213b3c041f=
c25fdfec1bd90

unknown command "testhttps://github.com/torvalds/linux.gite377d803b65ee4130=
213b3c041fc25fdfec1bd90"

> ________________________________
> From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
> Sent: Wednesday, June 5, 2024 09:06
> To: Wojciech Gladysz <Wojciech.Gladysz@infogain.com>
> Cc: Wojciech Gladysz <Wojciech.Gladysz@infogain.com>; linux-kernel@vger.k=
ernel.org <linux-kernel@vger.kernel.org>; syzkaller-bugs@googlegroups.com <=
syzkaller-bugs@googlegroups.com>
> Subject: Re: 000000000000fcfa6406141cc8ac@google.com
>
> EXTERNAL: This message was sent from outside of Infogain. Please do not c=
lick links or open attachments unless you know the content is safe.
>
>> #syz test https://linux.googlesource.com/linux/kernel/git/torvalds/linux=
<https://linux.googlesource.com/linux/kernel/git/torvalds/linux<https://lin=
ux.googlesource.com/linux/kernel/git/torvalds/linux>> e377d803b65ee4130213b=
3c041fc25fdfec1bd90
>
> "https://linux.googlesource.com/linux/kernel/git/torvalds/linux<https://l=
inux.googlesource.com/linux/kernel/git/torvalds/linux<https://linux.googles=
ource.com/linux/kernel/git/torvalds/linux>>" does not look like a valid git=
 repo address.
>
>>
>> The information in this email is confidential and may be legally privile=
ged. It is intended solely for the addressee and access to it by anyone els=
e is unauthorized. If you are not the intended recipient, any disclosure, c=
opying, distribution or any action taken or omitted to be taken based on it=
, is strictly prohibited and may be unlawful.

