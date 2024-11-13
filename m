Return-Path: <linux-kernel+bounces-407429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DBE9C6D56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681A6281FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997AD1FEFA9;
	Wed, 13 Nov 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MGA2zcLj"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA591F9435
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495879; cv=none; b=DTYCl06zuuOGNHWgZLhrejEfwwmIsb8snrNXCea+s4J9ntIym6LWppFQ42xbLj3WKxoN7hypcBRoUOK3nzQXdGZZc5HB/LhZRRIMz/EeDgA3WB/KV5hdJVj+KzHyFSbFmeiGyFhegGg6TFudHxYrQLAONNkGTk7ViO/XxmOibHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495879; c=relaxed/simple;
	bh=hiEKG0Y/wVS1hVVfn6hW+Hn/EPfdMAbyw57JMuySK30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTYiZyW+OnCQwD3/eE0DjXyUndrl3y7zsjBQ0bHE9IYwECyD5PeGkbtMq6Mu/nhNvZgCdowlrXt549IjZ+DFaZEGH+efLnAJT234aAYc95cg6tsCYAh1w3zP1Tr6rjV8bb+SIfQ8V0t5vwkiwahXPOFl3RJJgSTp9NpLKqIca6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MGA2zcLj; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e91403950dso5195650a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731495877; x=1732100677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMOqhaCgw8IKmEsNJSLqBPkergpNUbgBzqtDMTWnOM0=;
        b=MGA2zcLjvmq+nDaRIa7gzHm3ioKbRidKi+X9R4hg6egh09etk52w3cTAye7mXd70N+
         LDrTyPt1n517CfiyCbyHqJVDmhn99hg+gdgpAqS76C1rAlhIafq5UH2wGjOldwoQa7VX
         uXLl69YOHTQ2dNwgnmIKJxOKkQKP+ggWoSb5XZzq6jn+7uMnYCUC/ZMvNelsiXyTXAdU
         bLar0XRdnvjqvTGFFdqmc9mmkqq1AAcj1YqgVUJIcvJDuUSRbiQxdfBulVikYMxNDThd
         f9CJ2F4IRVWWmAtvQVGSdkapyvOwf9pPijaE4QG9tXAsaJbCco77OJzDLy2/KjNCjHWC
         Lk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731495877; x=1732100677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMOqhaCgw8IKmEsNJSLqBPkergpNUbgBzqtDMTWnOM0=;
        b=xDPIXAzSv9FV6xHNQPBVjIwEGLBBhHEYV0AiQ3tXh8Mg7zaCxtpIxxATiuQ1fFNIlO
         UUG1Ahy/DI1qPL+J5ZeP2lpIMhfAjGC645f2xNWIaAPnYWMaCMZ10sfupV5O2E+K9ojr
         aVh+dwSZl+rhZM6MRn/KTulThO7PBTuhXjcmIiYlM5iEjuv+dCA5ie+a3sMsd24TLBiY
         ui2hdJ7R5WVamX2KbAZR1mSn8ZNy0YJQ/F0eC8OpM4S+l+YTAXp3NDHWU15kpFS7SCDD
         +GtVLwsZr9KNJG9UN+2PVGbHN71r9JX30Vin69INHQM3dd70dHucat87cbeFG14TZBkO
         vroA==
X-Forwarded-Encrypted: i=1; AJvYcCVaHSG2SBoY52qKvLTY2sZKJZdDQ+Wyrj24DHkw4nxSGCUDBjXzyY1YuuBmJ3E4qBCTM05NHS86MDDJJpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhEL7wzUtyCO9miYwA+q9l1Qd+UzWkq8EzA3SgIb1Mj2KrGssl
	A5GrC8pV+xiuPXuY+iLHA/2X+wBaUx3sHImbaUZUvNsxt3ZNgI5TZv1VsXaOAh1q7OK0FDvTdJj
	PI22JTxYxHOX8mI1TBMaQd/cRfnFcZE40ecdMsoSb2v4kMh0TYiVu
X-Google-Smtp-Source: AGHT+IFCGCxcDOLZAmdw80iYEzsYnxhIrxgVHLCqYanCStMyqQB/LYaoF/ZRtSAnjJ9StjD0+4B3355HPCGxxZvP09U=
X-Received: by 2002:a17:90b:388f:b0:2e2:cd62:549c with SMTP id
 98e67ed59e1d1-2e9b17412a3mr29382581a91.22.1731495876849; Wed, 13 Nov 2024
 03:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <672d2a52.050a0220.15a23d.01a1.GAE@google.com> <87bjylnq8j.ffs@tglx>
In-Reply-To: <87bjylnq8j.ffs@tglx>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 13 Nov 2024 12:04:25 +0100
Message-ID: <CANp29Y7O8tgw=NLydjYq=Wa4CrfT1NsidhrOByW6He9qS4LpmQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in trie_delete_elem
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, frederic@kernel.org, haoluo@google.com, 
	houtao@huaweicloud.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	peterz@infradead.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 3:24=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Nov 07 2024 at 13:00, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 4febce44cfebcb490b196d5d10ae9f403ca4c956
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Tue Oct 1 08:42:03 2024 +0000
> >
> >     posix-timers: Cure si_sys_private race
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D129f2d87=
980000
> > start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D169f2d87980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D328572ed4d1=
52be9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db506de56cbbb6=
3148c33
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1387655f9=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11ac5540580=
000
> >
> > Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
> > Fixes: 4febce44cfeb ("posix-timers: Cure si_sys_private race")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> I seriously doubt that this bisection is even remotely correct.
>
> This commit has absolutely nothing to do with the lockdep splat and
> trie_delete_elem().

Yes, the bisection is wrong, please ignore it.
I've added this case to the issue that tracks the underlying problem:
https://github.com/google/syzkaller/issues/5414

--=20
Aleksandr

>
> Thanks,
>
>         tglx
>
> --

