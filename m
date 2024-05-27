Return-Path: <linux-kernel+bounces-190483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA48CFEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45181F22DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961C913C8EA;
	Mon, 27 May 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Md2dvVf/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B156D13C825
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808945; cv=none; b=RbMX5UFqeJ+uwirtgtJ2i7dYVaBFTtoEOwIS8GYp1XyV3NIsmffLmLONvhhu1cGTr/jb4FVLBrITh7KJifFMkTjX6bPERGXJsvoPF9LDDnbO28tzW5lg/6BeQd6LvBKol66j2dMewl1ZlNq5I2hEukdEgvfoFNL1nEdnpyI6+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808945; c=relaxed/simple;
	bh=88POcvOWFFjPPQWCit/6miZynfoeEN1gpEssKj4qSgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLJripdgq/MkcC5sFC2z6+XqAc6YBdwpwN8nsPuy7XFBP9/UYpXQ+Djr6jyJXiZ033UGB9rnjM0n9bdayUg0yaLK8pStCYqFLr+zQaROJJ5OQV1QYQj/zlYBq0tg7Oy+uWQ7Yhnd2EW/ZtEpM/spapL/RfR02n/uzTvaPp0tjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Md2dvVf/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a63036f2daaso68847266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716808942; x=1717413742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLptiP5qkymbmbX9UsdRdz023vOqmxKFBh0YRmvGv1M=;
        b=Md2dvVf/doenhWB6q1z18CIBpb1+DAdMiaeYMtqTIiB4sSWQkKKWBDtRW39Xujysb8
         DBm47LAAAwVpE8kg0V4ec87EToNwM1ckYBL8dbBas+kM/iNk4eBIvrETqmaerH/Is0mZ
         e6thb8v1nUpd0Pt3Z9emAjTUYZd15TzvujOOXZUqjRpOfAv3wJO/Anig6h77bgnmRC1U
         Yms42EaqFrmGZ1RKfJXZLaZcMo5hjm2ESEjxdFNmOkx3MuomlhebPs/5zDh9/wPdcZo8
         Dge+Tm4Jp9nPbmY5dp7rPcShNsD90h55pepcDG3MqbCj1NObkGff7tqro4UiRo7QKesC
         v10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808942; x=1717413742;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eLptiP5qkymbmbX9UsdRdz023vOqmxKFBh0YRmvGv1M=;
        b=AkgJ26kq2mgGtAAGTr6rZ4xVJVjPCIpYCrt96P1yGAXYPp/CqztWkat6UNth0beDB/
         dovrIkSkXnGHtxIA03zmcFbYUJj6NaNcGLWWlVDjxlwlbByNH+yFodFRlrrgg9fTKUp5
         MMlqBOxbUUWpyj5G6YeNIH9PpJFh+jMSi4DVR0vQNn+ICrdAyQ3IeDpN/QtnAPtRzixO
         p3D7oICQGadJZBfpfS4W7IJei/DVmD6u1luoAYQHKJkWU8YPbblfuVNkcgy1yKEpK3w6
         +bIA0iB+790g+GW9qYIxIu6msGVN3pZfVabwPMEdbWLMIRpbAaCQztXtkrdgJumJsQDi
         G+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+FAYc3LP/5wYrb6i7AlHKvMpe/NghMveM82UWBdEWnFPpRCe+8Gn8OR3m30CHtRT1azi6Z0R7+CsVhsMdsA+IRnTIvvP/h/5Om1IU
X-Gm-Message-State: AOJu0YxMXXhdIjKXtCTyN3DdF8L9Re+jGo3REz8ZneYgwz2ZhEiEo8Kh
	uzI2BRxr/lKM/nLdGAApZvlEXIj8swUd73kfbso7DduZ3QRH8o4mrd0sgb2CGHM=
X-Google-Smtp-Source: AGHT+IEZdlj1VzyTR7Ta4LFCgyFZzIs4D4+uzViTqz7y8iQel3WIQ/7/p0r19rtv0ZF0a3iVzioFGg==
X-Received: by 2002:a17:906:314e:b0:a59:c319:f1dc with SMTP id a640c23a62f3a-a62642daa92mr608591766b.4.1716808942029;
        Mon, 27 May 2024 04:22:22 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62bee266a1sm259856066b.159.2024.05.27.04.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:22:21 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Hillf Danton <hdanton@sina.com>,  Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>,  Eric Dumazet <edumazet@google.com>,
  Linus Torvalds <torvalds@linux-foundation.org>,  bpf
 <bpf@vger.kernel.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
In-Reply-To: <87a5kfwe8l.fsf@cloudflare.com> (Jakub Sitnicki's message of
	"Fri, 24 May 2024 15:06:50 +0200")
References: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
	<20240521225918.2147-1-hdanton@sina.com>
	<20240522113349.2202-1-hdanton@sina.com> <87o78yvydx.fsf@cloudflare.com>
	<CAADnVQKfbaY-pm2H-6U_c=-XyvocSAkNqXg4+Kj7cXGtmajaAA@mail.gmail.com>
	<87a5kfwe8l.fsf@cloudflare.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 27 May 2024 13:22:19 +0200
Message-ID: <871q5nwlck.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 03:06 PM +02, Jakub Sitnicki wrote:
> On Wed, May 22, 2024 at 07:57 AM -07, Alexei Starovoitov wrote:
>> On Wed, May 22, 2024 at 5:12=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare=
com> wrote:
>>>
>>> On Wed, May 22, 2024 at 07:33 PM +08, Hillf Danton wrote:
>>> > On Wed, 22 May 2024 11:50:49 +0200 Jakub Sitnicki <jakub@cloudflare.c=
om>
>>> > On Wed, May 22, 2024 at 06:59 AM +08, Hillf Danton wrote:
>>> >> > On Tue, 21 May 2024 08:38:52 -0700 Alexei Starovoitov <alexei.star=
ovoitov@gmail.com>
>>> >> >> On Sun, May 12, 2024 at 12:22=3DE2=3D80=3DAFAM Tetsuo Handa <peng=
uin-kernel@i-love.sakura.ne.jp> wrote:
>>> >> >> > --- a/net/core/sock_map.c
>>> >> >> > +++ b/net/core/sock_map.c
>>> >> >> > @@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *=
sk,
>>> >> >> >         bool strp_stop =3D3D false, verdict_stop =3D3D false;
>>> >> >> >         struct sk_psock_link *link, *tmp;
>>> >> >> >
>>> >> >> > +       rcu_read_lock();
>>> >> >> >         spin_lock_bh(&psock->link_lock);
>>> >> >>
>>> >> >> I think this is incorrect.
>>> >> >> spin_lock_bh may sleep in RT and it won't be safe to do in rcu cs.
>>> >> >
>>> >> > Could you specify why it won't be safe in rcu cs if you are right?
>>> >> > What does rcu look like in RT if not nothing?
>>> >>
>>> >> RCU readers can't block, while spinlock RT doesn't disable preemptio=
n.
>>> >>
>>> >> https://docs.kernel.org/RCU/rcu.html
>>> >> https://docs.kernel.org/locking/locktypes.html#spinlock-t-and-preemp=
t-rt
>>> >>
>>> >> I've finally gotten around to testing proposed fix that just disallo=
ws
>>> >> map_delete_elem on sockmap/sockhash from BPF tracing progs
>>> >> completely. This should put an end to this saga of syzkaller reports.
>>> >>
>>> >> https://lore.kernel.org/all/87jzjnxaqf.fsf@cloudflare.com/
>>
>> Agree. Let's do that. According to John the delete path is not something
>> that is used in production. It's only a source of trouble with syzbot.
>
> Cool. The proposed API rule would be that if a BPF program type is
> allowed to update a sockmap/sockhash, then it is also allowed to delete
> from it.
>
> So I need to tweak my patch to allow deletes from sock_ops progs.
> We have a dedicated bpf_sock_map_update() helper there.
>
> [...]

Posted:

https://lore.kernel.org/r/20240527-sockmap-verify-deletes-v1-0-944b372f2101=
@cloudflare.com

