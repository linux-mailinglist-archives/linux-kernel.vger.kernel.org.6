Return-Path: <linux-kernel+bounces-420276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25309D7815
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 21:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782E62821D0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06B16EB54;
	Sun, 24 Nov 2024 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8Z2M9KY"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53901514CC;
	Sun, 24 Nov 2024 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732480210; cv=none; b=DlAcjKaKetmv69KXbX34F7gXt6QW/zmDrRoFSM6Z3nxNv9y6YJB/MbHt9NzQRVH5N5rbsNDjl5kUO8MOvj1cUzjHJ7Y7rWIti5hqJhKMIpey9AvRTEZ7AIfv9pDULpo5H40qz9iCIlqmp3//tly0CKoOf7GI7+HFsL6/pyk0Swo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732480210; c=relaxed/simple;
	bh=b0zJ+1w0rSXrcUfJFVsZHYWclzP9koqNBleKNvcaNI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goMNV+/bdth+yhr7ZPNRNB7JZvIPdzQnDmUQYD6KTHlN1Q+ZkgMCyZuPrFRqIa3wTVunzhIQM/at5BhFqEW8MkHfapCWfiFsn+KdnHp1OHUyw2w+65H3Z/Ghd5aIUAEpSJ5nFzmj/8sOTW2Qwrxu2n5piKTvL8fR0xknRCs6ThU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8Z2M9KY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38242abf421so2626943f8f.2;
        Sun, 24 Nov 2024 12:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732480207; x=1733085007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEHD4xg3fpEqhVxo7h0zl2GuAd3y3pi4wZYTTu+6Nqg=;
        b=D8Z2M9KYB+eo8IapsoInTPJU8zABc8UO0S4MWcvrY69uIQcW2hbia3zlNuibCGgEXh
         OBS4RM1em4KQsZcKd4/hs/yFEG1Ewz8W6Q9we6VfwiBnGg3M5SNZCg94pcd5iZ5ffqem
         +8mvN1HYtqQ3e2AbGky1tCyEK6o4NJCZwPpHTCETyKuL2FNrHM4fsXpe+S39gU+WbLoh
         yy9qG1O9NOagEh6hXideR/0nDSVJW8ls775Ak+nrTeSWu7XKOA8XbkaiCijhwErrFapM
         ifHqIWoNYQItEo1zCL1dTicg/5UME6gzRhC4yd1DGIzLI/51xxkLL1PDTElfZa99ggtq
         sIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732480207; x=1733085007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEHD4xg3fpEqhVxo7h0zl2GuAd3y3pi4wZYTTu+6Nqg=;
        b=eL803ZhMk3ptQDAFh4GCQZJNDK954RTDyABWACd2WlCKz7Sh0kVQeTR7bBjSHND88Z
         o/Zc+ZJCuoIIHcG+BE7G2dlmshDtfUUjVmd8Z//N6ULPkh/FDp2Sq6JBtYxOMpWy8TSy
         qp87A4U6RDJl4/r6KeX5RX3kweNFy30HqtJZDSrC/udY+Jlu60eW3Dv5V/7QSsNcAbOH
         tznSbFwZRzF6vA8R+sAJTrtTw0ivo3KloV3Gv4RI9CSO9AbcNT0jzsVZ55JqXmTleYE7
         jDUcgjd4CvehIjQrH/zBJOIbDdLGuHZduhl7SW3ICVgPM/6LMQteaanUXzz2A+Ti/Q1E
         8LyA==
X-Forwarded-Encrypted: i=1; AJvYcCWBsMCq1W1vrzE4VHoqoOleEyQGw0hWfoxMuc+aDCeS5Wh6+vmnbKpcbXu5DAU7PfJK3/vxsukcKBFR@vger.kernel.org, AJvYcCWqeC83Et1Z1Bjta934G2U7RrJiY6Na+DgDfcoC4TDcIwwwaqqQEYftsXpy6qA8ZukI8PhnakVc2wKcrNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+xjhWikSAoIjo5cRCsxaS8O79rTD1LhnYnC2cya+fIi6s3ho
	nSlL/1bkE8cXmNGjy0YVxuydDlP4t1P1J4SSVkTUOykfBXQp+JT7ijkQsEsCXRcEuwCa8NcmK9a
	csm0fq/74azpvBAqLLuGzARNBFVo=
X-Gm-Gg: ASbGncvWWVqUHIx5d7AiEos/IOrBY5Mgi26AFbY0oxDBjS31m6Fg3hIPPcymYNdw55/
	mlgAXeEmwrZzHEuUYDZlO6I2+1Rcb0u/dQA==
X-Google-Smtp-Source: AGHT+IHxY9xhVK60hNmUjHbJsFLHkW8fRnXfpPQFrMPAKXdy6tzBwn69pHtqDTq0suqecrS+4hFqSAciP+G2GL2/kis=
X-Received: by 2002:a05:6000:1866:b0:382:4a3b:5139 with SMTP id
 ffacd0b85a97d-38260bed0dcmr8542633f8f.59.1732480207065; Sun, 24 Nov 2024
 12:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003c68f3061fd2c285@google.com> <000000000000e82e420622326e3f@google.com>
 <CA+fCnZd2b70N6nXTyWO2UYivh_U7Wey==XWURpFy7B_x8xEFHQ@mail.gmail.com> <ZyVn1tNVntbykOuG@gmail.com>
In-Reply-To: <ZyVn1tNVntbykOuG@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 24 Nov 2024 21:29:56 +0100
Message-ID: <CA+fCnZcA4hEujDLUtzN=3q7akeG8qMMbYrL1Jyj=JKN0C1D12g@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: invalid-free in dev_free
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 12:44=E2=80=AFAM Chang Yu <marcus.yu.56@gmail.com> w=
rote:
>
> On Sat, Nov 02, 2024 at 12:26:30AM +0100, Andrey Konovalov wrote:
> > On Mon, Sep 16, 2024 at 3:24=E2=80=AFAM syzbot
> > <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has found a reproducer for the following issue on:
> > >
> > > HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID=
 cons..
> > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregk=
h/usb.git usb-testing
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10a962005=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcb61872d4=
d8c5df9
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3e563d99e70=
973c0755c
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1297cc0=
7980000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1217c8a99=
80000
> >
> > I'm not sure what the correct patch would be though, as I don't
> > understand what the issue is. It seems that dev_free() indeed gets
> > called twice, but since it's guarded by kref_put(), this shouldn't
> > happen AFAIU. Or at least we should get a bad refcount report.

Interestingly, crashes stopped happening 20 days ago. It could be that
there was some kind of bug in the refcount or the generic USB code,
and that got fixed (at least I don't see a problem in the Raw Gadget
code). Let's keep this bug open for now and monitor, and late I'll
close it if there are no more crashes.

