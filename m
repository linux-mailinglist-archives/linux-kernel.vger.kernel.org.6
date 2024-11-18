Return-Path: <linux-kernel+bounces-413143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A8B9D141A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8BE1F22413
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D901B6D0A;
	Mon, 18 Nov 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNt9Ruir"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6131AA1F1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942721; cv=none; b=uN2Kvj0Fgjhy45DN/dJeG/vn7E09cD2qh3oLiuDNLDgXTG2370KVFLu3dzO62Sc0g1JiLLF4+C+2jy4cCs5IeMsdjgAYRURrb4/aHZFxBSmVtTbcX2CWfi05uH0uKm120HBtQNdcLqc8KeL1ws28FB1NfiuAj9pTH5/O3JvQp+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942721; c=relaxed/simple;
	bh=L9u4djOarGr7R4ePq4khHIOJD1iKc5G+rEeGtjnMB48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d92j145qt44+xDHVUOAqKJIv+U5H31CvNNRbAomvsszGzT0jWe4b5tFTVW9WEYIpWryxsBKJlTHBcfC7AIATzJtRtGGA88kZA3e1GTMp71L0FUFMnsQ93SzeOexSVeJRaqvgXhmzErNq1ZMYScsJ6N85csEkWvB0HLuZcTC+UQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNt9Ruir; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21145812538so33722625ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731942719; x=1732547519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKBcsDimJww6pYRM1GJfE4zk512cTlx5BHsoCw7EaLw=;
        b=WNt9Ruir6k34qW1M8h5DPRsNGgumtEkN728Y8l8RjX2ZwqS/k+X5TY1UmlR7OSs8rb
         zUyde93LfJjeFLr+Gx1eM7/jjbZcoPBm/0V3HACfDoaVROfJUqUE7+upKNhURv+fInzR
         nDZHFc2lgjVNhXpyb8zGOPsb7R0bpFMFkaLm6sWBp23iROafFQNVieZk9PBU3wdUmN4l
         b3pxZcPJFhaaQU/AV1avTIM3kSJLBsYZmESDSlk+H5wp2OrW8b/uDiydqzbUrA8MHDxv
         xgidmB+tsmcklrNwJj8f3Ag12b+Kp+E8O/N4KhJESElH+2vxYGaljdSzwRldWIF6gEJU
         y9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731942719; x=1732547519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKBcsDimJww6pYRM1GJfE4zk512cTlx5BHsoCw7EaLw=;
        b=YphhGMIvjBbpZKA72EA3xHSh7M0+qddqiJLPvgmqXLTTQDWdJ/nsnbSzzdI+UVQ2dA
         dHSdyiwx5SOPQO4H6z1KGp8RToFaP28XDQJuTwR2M0uAGk+UHcoyVE6/EvxEmDSfarYt
         9cqtKBDhWwy7kWd3HRoqlXaBCAJrMbt1s9YTlAbbfkUceoTNS9s9IktudiJabjE7ChhD
         hCeNsQef0J5MFu+AgGKZMuKmHN4YXqbKUvOv7MX5BlUW4ryYY4QtlEswh2iqQ3/VaWoq
         HoDNAm/eHAbnh46wcyCXKnUvr8c7k6otEqTfk3TRS3Xpvm79uFOwQqzRzuFZZ4LWYjcJ
         ceHw==
X-Forwarded-Encrypted: i=1; AJvYcCUjAZk+t/9HqBpWRKngOOrap9nYYTaUznOfStRrqxbTaIHodc92SKuQjHGM5UFTRjnbkeAd5bfXgy/dKok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ggCM6dDh9T+VGZ3FqiXIOs2XJxsbCqJfkjqNGdE9eJahf7cd
	RIhfDJqISGfgC7he2NNAzrELJTLVPgHjjxzDzGazMLO2aojq57iw8s/4uE0Qgz4xszP85kkqYpX
	hfwTzb22IUjSGjkZfcyeRrjXpHCWgY1/F8s1N
X-Google-Smtp-Source: AGHT+IFjfo/P9iieM7k3RDDAKQkvHdROHwdE7KrApXM3Ox4639CjYPlUVBIU1hPxB9Eq00WcnPDLHK03pzGg2veHBUw=
X-Received: by 2002:a17:902:e80e:b0:20c:f27f:fcc with SMTP id
 d9443c01a7336-211d0ebc0bamr195870035ad.44.1731942718549; Mon, 18 Nov 2024
 07:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6731d32b.050a0220.1fb99c.014d.GAE@google.com> <1af819ae-cd88-4db0-af6e-02064489ebb2@rowland.harvard.edu>
 <CANp29Y7RA00bKOinkjSDBchbkx3RDvWXGs4hr0PrPKyqSEC-_g@mail.gmail.com> <efc7e41c-b4a3-469a-983a-24b167b944e3@rowland.harvard.edu>
In-Reply-To: <efc7e41c-b4a3-469a-983a-24b167b944e3@rowland.harvard.edu>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 18 Nov 2024 16:11:46 +0100
Message-ID: <CANp29Y4X9v_G-JE342xpvGRiso=48R-kgO85R5FWau5CGYCFHQ@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in ld_usb_release
To: Alan Stern <stern@rowland.harvard.edu>
Cc: syzbot <syzbot+e8e879922808870c3437@syzkaller.appspotmail.com>, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 6:48=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Wed, Nov 13, 2024 at 11:46:00AM +0100, Aleksandr Nogikh wrote:
> > Hi Alan,
> >
> > On Mon, Nov 11, 2024 at 4:45=E2=80=AFPM Alan Stern <stern@rowland.harva=
rd.edu> wrote:
> > >
> > > On Mon, Nov 11, 2024 at 01:49:31AM -0800, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://=
git.ker..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1650d6a=
7980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db77c8a5=
5ccf1d9e2
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3De8e879922=
808870c3437
> > > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils=
 for Debian) 2.40
> > > > userspace arch: i386
> > > >
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Question for the syzbot people:
> > >
> > > If I have a patch which I think will cause the issue to become
> > > reproducible, is there any way to ask syzbot to apply the same test t=
hat
> > > failed here to a kernel including my patch?
> >
> > No, that's unfortunately not supported.
> >
> > In this particular case, it's at least evident from `Comm: ` which
> > exact program was being executed when the kernel crashed:
> >
> > [  178.539707][ T8305] BUG: KASAN: slab-use-after-free in
> > do_raw_spin_lock+0x271/0x2c0
> > [  178.542477][ T8305] Read of size 4 at addr ffff888022387c0c by task
> > syz.3.600/8305
> > [  178.546823][ T8305]
> > [  178.548202][ T8305] CPU: 3 UID: 0 PID: 8305 Comm: syz.3.600 Not
> > tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
> >
> > syz.3.600 means procid=3D3 and id=3D600, so it's the program that comes
> > after the following line in
> > https://syzkaller.appspot.com/x/log.txt?x=3D1650d6a7980000:
> >
> > 551.627007ms ago: executing program 3 (id=3D600):
> > <...>
> >
> > You may try to treat that program as a normal syz reproducer and run
> > it against your patched kernel locally, that should be quite
> > straightforward to do (just several commands). See e.g. the
> > instructions here:
> > https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#r=
un-a-syz-reproducer-directly
>
> One of the beauties of syzbot is that it will run potential reproducers
> and test patches for us with very little effort on our part.
>
> Can I request an enhancement of the "#syz test:" email command?  It
> would be great if it would be willing to run a test even if the test
> program isn't considered a bona fide reproducer.

That could be doable I think, thanks for the suggestion!

We actually have a related action item in our backlog:
https://github.com/google/syzkaller/issues/613

I've referenced your comment there.

--=20
Aleksandr

>
> I don't really need it for this particular bug report; the underlying
> cause of the problem in this case is pretty clear.  But having this
> capability in the future could be a big help.
>
> Alan Stern

