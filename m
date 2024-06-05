Return-Path: <linux-kernel+bounces-201925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2A8FC55F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D25A1F21779
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B418F2D5;
	Wed,  5 Jun 2024 08:07:43 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AB51922FC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574863; cv=none; b=gmUrD2aeWQd61NHYrOMDo1SSDQ2nGjWZTbgZJtiM6QzxoYmDJJaRC5GmiEj7dnJVSUBv/kd7R4djav5hzIlEw35bOHHLaENvoPvEmHIKpPmcFUwHPPcKFbcZTxrT0D7VJwfRGY7gobLoXaahpTnCej6C063ziqt24pHER79tR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574863; c=relaxed/simple;
	bh=1kLFYEdHzgi1x1FvIp3jMd+fuDzilPyeeoZZEJrlR3A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r9UuoHfEAx8j3tNcplF3gYr43ZlC/cNRi+UQMP+KzX2PfXhEDJ6zcKEtT6dEaTNzr+haoWTswno49PBDgGdydSD8dDScQmhCT2tfzHK9sd9iNJcBQ42ltGRVyydI227R8VwkPl9KAHhXD5I1KWa0xucNwZNwa0CWUMfrAqK32Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e8e7707356so755731139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574861; x=1718179661;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kLFYEdHzgi1x1FvIp3jMd+fuDzilPyeeoZZEJrlR3A=;
        b=Z4wU4ADnCU5RVLZP084aHFtTMbcNMvhGc0NNnVq4anCXBKYyTul4+yMg5Z5OucIQfo
         L5WvP/dDGwLwJeQZHVjI8qJFMvoxxC/r2ofRMMzswiq7CiI3kdnFZ/661ty1AGlQhX07
         LAAm5IiGTN9ueEnxqmTK+xbzAytFk6JB9ASj9I5DRIhD3DkD2n79ass0/DfaPviUXH2p
         VkYKycL3tG7GznD8zyIgvchz0IhYDIOdngRv7Nl7OGfR3ICxeQcniuOLfjNOLiDQ6h/l
         Pi8/f1/riDy+aVczmGAhBEhOio+l6UZ8z5sO9t4xiRX7tGXwCHPg/DeylOvptbeNOjBD
         XAmw==
X-Gm-Message-State: AOJu0YyZyaXV8CB2hpRkTgM7lomkKMgiogvxiQQ6MM5+MkVLyPROBTbI
	wcB1B0QEg1YMtlE9nPoij4YSAO3uJAei67q2O8T8MCUKHi3oasH91OyE79CplIjYgKR6B83cvS3
	1qAQJVc++RY0P1r3eip4R8mA2J25acUYWMyIuIFNZTGEDqmmh/xwbFh8=
X-Google-Smtp-Source: AGHT+IGkkUKbhSYKr7fa9sL/haagR70d/1uevnxvK1FtA7H/TpnILAjH+wTzm8JpDsjn15VT2lwAJ/DxZu+WTCcVdSvZ7YgDgJQz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:374:abd6:2ec with SMTP id
 e9e14a558f8ab-374b1f88a04mr1161265ab.6.1717574861283; Wed, 05 Jun 2024
 01:07:41 -0700 (PDT)
Date: Wed, 05 Jun 2024 01:07:41 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b74ba061a200f61@google.com>
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

#syz test
________________________________
From: Wojciech Gladysz <Wojciech.Gladysz@infogain.com>
Sent: Wednesday, June 5, 2024 09:25
To: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
Subject: Re: 000000000000fcfa6406141cc8ac@google.com

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

