Return-Path: <linux-kernel+bounces-201876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69918FC478
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940AB28B5BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265911922D6;
	Wed,  5 Jun 2024 07:25:42 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA281922C6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572341; cv=none; b=qF3sbxFRsBPskAJZfeJFHYS5h0V8bE6TpiYqfcDzLP66uZ+BwACDNnyb8NSiatIEeQiWVtE7dMoFOq4hWdUpZeucd+eHtwz5Ougzt18JXx02koV7cy4Sad81uenFxvY/zL1JS0EU/NuUmeRa57dbJGuFwRQSpcBzh3v+gy2AQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572341; c=relaxed/simple;
	bh=5jVZ+F8iul/MXl68OT3lB4bL7dKSLhQPN3ZL10GpPas=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z2JryncsrBQ2GXUJCM9ZjZJ2zMVgxXkuCWhef2INAT2SA92YfgmPd6sunkXv24eDSmZ+e+vxr60DLDec44NdHSoA+fsG1OTOToSPxAhAhef4cy1IMwWndxHNgNcllvlEiZqPd1ev0+2MiKrncpR//Oth3KDbC7bwtDjmnJHpbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-374b033db7dso11294235ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717572339; x=1718177139;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jVZ+F8iul/MXl68OT3lB4bL7dKSLhQPN3ZL10GpPas=;
        b=afk26ETAcP2J/ysYifmFOuUjdWJNqxo8w4r0jTH9MEm+52wdc+C9s07sbUj7rjITj0
         T7ykqtOjw4U9TLFHI/vpymQ5RKmZvfdG7lmhqBk8m/Ayb/YBME0+ZQYMU9k0BCd/p5OO
         mGeQ+YvPBGs2XO1a1oiFFfrfKNoqhQz+HNLXrJmjI0TWMTpwFtxdt6HODjVk8Hd9m3Uc
         UafiqlKqgQ8HktFA37nqUSDqgIuGanjudH1PBXSXrm+WTDCpE2LDhkl3mABPLyKux+c/
         a8kMN5vUNAo09AxnlCJlKNrSMb0GQHGhipqgJ+Fl5rNBqFV7OHQqLpHCg4NFR252+ACZ
         Pr4w==
X-Gm-Message-State: AOJu0YzVuBjUoNv7Y2ttvWSsxixnkNYPF6a907ZO2oDz7jT5v6bK3nIx
	5/vwyaJv8HmU0woqTlHwp+fY00drDXJehV2LtmfY9t2le1I8tPBLEO9ae1ORoYCYmGwPAdtt9Qw
	UM4N1SNS3a8srXrNRdN5GrXHHJBVpPatCSBubS9JOb9Nq8Ti7kWMzUic=
X-Google-Smtp-Source: AGHT+IEJifPXDqaUYsOLA3EmvPsi16Hd2X+UACfaGI7/1tCY+z16N5rF1Fv0RKPwW9dP/i4IGWNQ+TdHoYBIuoXLBTo5oahenfcd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a24:b0:374:9af0:5f5a with SMTP id
 e9e14a558f8ab-374b1f88226mr955115ab.6.1717572339724; Wed, 05 Jun 2024
 00:25:39 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:25:39 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f8558061a1f7902@google.com>
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

#syz test https://linux.googlesource.com/linux/kernel/git/torvalds/linux e3=
77d803b65ee4130213b3c041fc25fdfec1bd90
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

