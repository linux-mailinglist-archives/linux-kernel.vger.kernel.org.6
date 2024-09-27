Return-Path: <linux-kernel+bounces-341680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E283988388
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F421F241A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6418A957;
	Fri, 27 Sep 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7Aj4U0D"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A618A6DB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438113; cv=none; b=lR+aUPGmyC3tiO2wUKLka0uuWtLcfkwjyBfPoHbEMyyp0YNtE+jR10j5SLdFltHLS4dEGlU1uPt2z4pgZLUvE2UpJjTFa9KQULbhQBDunCztqAbyDXdRp+Lkmy+DmGBi/zG97A/VyUOnvHcWPlHNusektetqUIsj6u+oR/msOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438113; c=relaxed/simple;
	bh=5IelYLJtGCyBpA7doHnIKZw/Gl7uWB2w/o9JZrMS+Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKf+h/K6647/Q9d3r7rfslgJVWrsqXboMb83aainmuhTLpnwU4XB2p41wqVMoxaIeP+LJ2HPe0XZAlkGJfKqzNrbB4Zi1Rfml3D4z8/goa3+zjXigO0K+8f1FtohflCsocHnoZs/gcXNn+ev7vJl8QfwohyZrBvu+IknBXy/uh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7Aj4U0D; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a1a22a7fa6so7186685ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 04:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727438111; x=1728042911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IelYLJtGCyBpA7doHnIKZw/Gl7uWB2w/o9JZrMS+Uo=;
        b=b7Aj4U0D0AcHc27q1LZJM5zixeIK1i0UD4YNznARQzDTEv0NBGu1Iu3/GBfcgQBVAh
         5umS6hFIg+4f3Vv8uy+S1+Flh7wJlX/8AG9I/BLcWY5UZOerEONo6m0/Uhk2xOF1Pklk
         6KSS1P3FyA3aUFKqnLZ+3iqIq90soR1mp3bHAxVEyoQ0k+h2qSw6rztmxDMoXhoiQhCz
         wEncIlRuoDRDab4GF2XkSHpfMC0eWPlqTFrulJWUVaIOpoUWMb3J62iQEYDhpW/MO1S1
         mBm4WmD6cgj2Hexx3MzxZyPqvpb4vvVAVL4X1dBKeOfRaE3Xdd9BSL8iIH3La9nVGhza
         EApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727438111; x=1728042911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IelYLJtGCyBpA7doHnIKZw/Gl7uWB2w/o9JZrMS+Uo=;
        b=v9Ng93XjhWFW/Otzhm52O0j8d+XMdYRYoHoioOpaBexr7fC4MpODnExGVzkbwbQtti
         AxyaEzXLOgjWmkywEJ7aybIe7UavKGZa/QaU+WSV0YzC4kjSZXZ/OgxoagYWJoLA2Wxv
         VEMNJGG27wDrTGO8xd2dKYatHE+MFgJ1h7EmZFAaAjKVygF1oqLXZpPfvzXOzQMd96lt
         EiJ/FFJIgamAACe1uI1lrqTR1CK7bbtwJGb3avB23ZMtibEKHJUxIyz2AmuQ6LZFr7FW
         Uj/WyU8b1R1UQfEN6XOmVsi6SrehVcaIJmFRNlUBO4izeDSlUjXiC3s1UJi/Om1BYolZ
         rOWA==
X-Forwarded-Encrypted: i=1; AJvYcCUpRkFgwITt4qy8YCW98I53QxL9c4Z7vOOah7sBEs8y08hIy+ulxUlFSwnyK0OclBK8NNPThzwOaIB+7PE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcCGXQjo5emLCjfHb0LE9axXAXjhaiCMbQf8FBYwW/rzjnCSGR
	FIiwapoQSM1jvce8QdJn0ZZy2siblo+SLaVpn0yY9igfaZgjWmpF7JHrtwkHyk2QwsKgF/gxlJN
	xtYemvSDe1vYgiFrX86WPe+Gusa0o4dXRWH2L
X-Google-Smtp-Source: AGHT+IHQTZWHKkEbSKCyJsvEMcbPA/10XDV8GU1FMkAPGvZdeDFF6FsI0tkhCNu8S09/3QLHyN/aXXPqhjI4etM9I6w=
X-Received: by 2002:a05:6e02:13aa:b0:3a1:95d9:6f36 with SMTP id
 e9e14a558f8ab-3a2768beb2amr45557025ab.13.1727438111397; Fri, 27 Sep 2024
 04:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com> <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com>
 <20240927110422.1084-1-hdanton@sina.com> <CANn89iLKhw-X-gzCJHgpEXe-1WuqTmSWLGOPf5oy1ZMkWyW9_w@mail.gmail.com>
 <20240927114158.1190-1-hdanton@sina.com>
In-Reply-To: <20240927114158.1190-1-hdanton@sina.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Sep 2024 13:54:59 +0200
Message-ID: <CANn89iJMHqg4e_tErTERx=-ERXbA+CRbeC0chp9ofqANwwjhLA@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Boqun Feng <boqun.feng@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:44=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Fri, 27 Sep 2024 13:24:54 +0200 Eric Dumazet <edumazet@google.com>
> > I suggest you look at why we have to use rtnl_trylock()
> >
> > If you know better, please send patches to remove all instances.
>
> No patch is needed before you show us deadlock. I suspect you could
> spot a case where lockdep fails to report deadlock.

Please try to not educate maintainers about their stuff.

lockdep is usually right. And here there is an actua syzbot report.

