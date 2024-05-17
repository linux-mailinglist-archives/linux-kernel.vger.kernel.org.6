Return-Path: <linux-kernel+bounces-182309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044058C8983
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4FC1F213E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0AA12F588;
	Fri, 17 May 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ePHlPFT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37923FBBF
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960619; cv=none; b=NcajzSW/axgjdQ1PqMrAdxY1ldI/I2mphQGkCmbEeP2HUctDgG3FrJA6buQMWv4KFm+Qx+dcpMRwjKrdXdRME+lgtZviGPyoV6KfFUs0vNC9nyxZf1PMX5z5l9O5JRTX3qXd9tIaLH7j0dpWcBiCxg6eYexo9DoFcopp69IIS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960619; c=relaxed/simple;
	bh=TAHsO+enrRjaHHyHQmk5F4hor4FFHWsBfoDW8N25pYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DymqTBMQjZiZ29t59OSlpK+Q8QsbKtq/UAX0OXZMmjM+YYZk00PuJzpzjTuV8XNpsGMgoIuGWITimjmtOyeuRBbr1cxktcLXa3B1PLxfSNNMHjASmCM2C3N5q40e6KVZNSH3TG60Ve64op3K+EdTydQx7sry/gv1yCYfcw61w8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ePHlPFT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee5f3123d8so122685ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715960617; x=1716565417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/3daA1XGwwkDRem+DezURSgZYn6E+GwDq5O1DK5VCM=;
        b=1ePHlPFThY0BB2pQk42p/sngS1cNaqEh5K041Nx8mxdx9fpqQEtgS81VjUKWdfiWAn
         ApWhS/bVnpqteTTmiWb40HfDAvP+dkINeIh0h6YwKJIMLv7Z8oW77OXmZDjBsMea9b7q
         ijh9ZsJKpgWUbtJQzJEfsAwTXWpqVdMH5dXed2qbI7cBeOZCVfzHvY2Q0EB5AR4o6DW8
         jRsDU57RB88dia9mIc91AoORKlC9jt3+hgD7HdUK3p+C3PU11wFZtA32MPJ69RHi2KU/
         FOtHAVq9iE3W7RGekXYshniqyQOgaWVhPdVca3uzJqN5PN0/RfbWJp2F3XB53cnEFWYR
         uOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715960617; x=1716565417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/3daA1XGwwkDRem+DezURSgZYn6E+GwDq5O1DK5VCM=;
        b=oYHADLdL0oqqZUfi+K6gBSIWLFho7K0yIMz3UUb80eP28FLgxYVA8C94Kk8ygrPS02
         haIvwW+P2YmRwR6HvyaGLZKMp9CzV80ZUqQjgUcC1MEOQtiIpYqkl1zpQ4P3xaxhoJBo
         GIRcu05BJkd7v1wSfX1FdxyL7XV8e8pIIHvhe6tC5uaKHaStpoBaayqNDjcr0oDWip/n
         3v+2GNs4C8Rw5MVTmSX+kjYTZpUMN1CIBCMHLrxVsYX3Yx+jLc5t4QYkgK/jflNTa75p
         OyqI7LSos1oOBbInQjpc08wDXQwWBvsQwQ1ZM/t0JU/69FzsZgivG1DMJRpW6J8la2lN
         AOoA==
X-Forwarded-Encrypted: i=1; AJvYcCVO3lSmRGqfycJsRsghh6Cz+E9cDjwdlx4S6zsHNq8XjVWaiVye9KDTWx7tsd+BFvNRR7CVjYuurAFTt4fqoL7s43Yr2CbVGS1QBwlG
X-Gm-Message-State: AOJu0Yzkz32UJE7yIggjvYsA7HSDb+N+s66xLEuWhP2R9lGJQM/Kwpmp
	B7++i+QbPiF+A9lqX+IdN9Q32idnPBYznovafmv5Vp9x+MUhmUvs9qwp3uO8irZPrz+Hid78esb
	WfH0VQm4Jg+k4YHQM+uG4dtgld5dWHkD+T4l2
X-Google-Smtp-Source: AGHT+IFHiI76LkcRJNEbHfi00wWx54oRA+JuNHT1RYzrV2XdD2aqNdPWYqPYy/7Ol2y67MttKfB/M2dajh30tO6K2aY=
X-Received: by 2002:a17:902:ccc9:b0:1eb:7285:d604 with SMTP id
 d9443c01a7336-1f2e04c0715mr2458065ad.6.1715960616752; Fri, 17 May 2024
 08:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000141e8306185a0daa@google.com> <CAJfpegtwuOgundfkCdh4c4-scJjBEgHjNzJ8Vq2VUxjxWWQPHQ@mail.gmail.com>
In-Reply-To: <CAJfpegtwuOgundfkCdh4c4-scJjBEgHjNzJ8Vq2VUxjxWWQPHQ@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 17 May 2024 17:43:25 +0200
Message-ID: <CANp29Y6zWmm2YGxsL0Eaj=TAe6gbvJ+V0jtAS1xLhnbmtNaHOw@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_workdir_create (3)
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: syzbot <syzbot+8aa3f99a6acb9f8fd429@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 5:41=E2=80=AFPM 'Miklos Szeredi' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Mon, 13 May 2024 at 20:28, syzbot
> <syzbot+8aa3f99a6acb9f8fd429@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    45db3ab70092 Merge tag '6.9-rc7-ksmbd-fixes' of git://g=
it...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D169b934c980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2f7a2b43b9e=
58995
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8aa3f99a6acb9=
f8fd429
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0c2a8034002c/d=
isk-45db3ab7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/807e35e2b3a9/vmli=
nux-45db3ab7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/4868b2eab91a=
/bzImage-45db3ab7.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+8aa3f99a6acb9f8fd429@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) !=3D current) && !rwsem_test_ofl=
ags(sem, RWSEM_NONSPINNABLE)): count =3D 0x0, magic =3D 0xffff888077f311f0,=
 owner =3D 0x0, curr 0xffff8880787ebc00, list empty
>
> This is lock corruption on the upper filesystem, definitely not an
> overlayfs issue.
>
> #syz unset subsystems
>
> Thanks,
> Miklos
>
> --

Let's set ext4 then:

#syz set subsystems: ext4

