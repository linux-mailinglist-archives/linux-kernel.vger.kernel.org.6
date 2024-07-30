Return-Path: <linux-kernel+bounces-267000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB137940B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F85A280F94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2C518FC70;
	Tue, 30 Jul 2024 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRE976g7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFE98003F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722327338; cv=none; b=EuuP3oxE06pnVfHcuJGMORAB1L9+NzpYwPLhja0cY3t2m7S6ZtBAROWhul3dd5KLi4l5KbMmreV3JWF2rW3kZoYmMYnHANzcx6q4xNOqnk4PR8ke44gT7OS4fHj6JhqdNqwFnaAx9ghZkIWAswwkWr5UqWRw2Tt8CVRfXwvvDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722327338; c=relaxed/simple;
	bh=WOOMSfhnQcNODeN5xJyfMfPqy0keIAX/hzTWSUrYaGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUQ7ny3NkMJqaSXByidI3pixX7yhS5UhZLiqEZyK3e+ipGrA//QaF4lGR/amc8DvIe1bLNoYjRb2pLhMyreatghTbYTyUZOPQjn23xkQ3kxayGXucEaBtGmA3KTxGls4+oMBxQfJMxcbkUHO3wDsf1qAYuRqOBs3jUtha+PzH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cRE976g7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722327336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOOMSfhnQcNODeN5xJyfMfPqy0keIAX/hzTWSUrYaGA=;
	b=cRE976g7DlunkmS4hBkuad6ImBvLzLG2A5rM62fUDTQtiQ3Q+91PHC2pJgJ7125V4Mk9ud
	jOXtpbfv1xWAm+R7mu8pbDQtiIqncKdOJWCeU0z9RzfyHaoHPcMGn97GfvMVbdiWCf8H2H
	2Dm5g5QAXn64m+GOGsX1ALCRRlMxgf4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-zszeyCOWN9itLy9cDV-CAQ-1; Tue, 30 Jul 2024 04:15:33 -0400
X-MC-Unique: zszeyCOWN9itLy9cDV-CAQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb685d5987so5579236a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722327332; x=1722932132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOOMSfhnQcNODeN5xJyfMfPqy0keIAX/hzTWSUrYaGA=;
        b=VDeM4ZGx0AoJeOavn/1xYua13uN0L7z/X50NxyIzfAyCnpezPfKgh7t2xfl4J+ZtUh
         jQbcRxVIKMjFX/r3xtVTVdy4bmuar495VF6gBkHNFQ+RsF5aKNqtrYMVhtiz2f56KWxl
         O+rrK6gJy7tE6OfGGcWcpxAY8c8wlzo+oaS4y29cTykgDy7OgFwR1M2Q4QBSa8WVgead
         thqxTUeqdIG4cTRF4Op8N4LUNqHpXf1YvfiNLsctbXK+6FrwIwc1Q3f3O1p/Zio09s38
         wvKhEhelBp58RO6J3xKOOUn5kVzV0st4LjOCmPKY7ZMRzMvCFQmES2Xr/ZoeAMduc/t6
         o/2w==
X-Forwarded-Encrypted: i=1; AJvYcCUIqa+5ChHuxt6u+MXGuGbIQCENOvXPWtpYnwq5bBpgrJDvgpIWu/KOyTrF6wHYz/Q/2HpSrqvyUyhrafuJvIsLGqRs12GQSyAQ0Uev
X-Gm-Message-State: AOJu0YyT76ts6HIIej8OCpkVYjnXKcbcihqyQzkgmEtPck85UrrWEsFE
	l9Qu6JjNrD/Vi7evel83T9anvBNm4Neow7HzFA7W1GrP7M5zVauEgA5iY0XUKm9qMHbBaO8Lj8Q
	bCyqJZ6vVO/1O3YEdqQ5p4JzFLhTGnhlBPSirf90tAXU4jmmmejxwjDF0Jxs0QNAsy1mI9JHF3R
	aQuj1bEvJWriYvr36pIGeW66C1le6EDdeYNrUO
X-Received: by 2002:a17:90b:1e03:b0:2c9:7219:1db0 with SMTP id 98e67ed59e1d1-2cf7e097ee5mr11968770a91.3.1722327332664;
        Tue, 30 Jul 2024 01:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeIY6efqBzVRcnHDrZf789cD3QSb4GU491Vbgv01oZGYCmlbPHS55aNBW4HeDxvzWdKSlTy0/zXAZP3u9j+fc=
X-Received: by 2002:a17:90b:1e03:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2cf7e097ee5mr11968756a91.3.1722327332330; Tue, 30 Jul 2024
 01:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702095401.16278-1-gongruiqi1@huawei.com> <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
 <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com>
 <0729db54-98cf-4006-91d0-0ebda4dbc251@huawei.com> <CAFqZXNsN9M__Mo018L8m0txi60vm3Ui5HgHvJYQK__0hhhMULQ@mail.gmail.com>
 <55390a1e-5994-465a-a5c5-94f3370259c3@huawei.com> <CAFqZXNu_cLLH811Z8CxDb07Adf+E_z+1nH=7nkO9H83CY9RETw@mail.gmail.com>
 <CAEjxPJ4H_MVWd5iaP5eE_q0tbebSFRE=KMS80-dE3EdRpmv84A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4H_MVWd5iaP5eE_q0tbebSFRE=KMS80-dE3EdRpmv84A@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 30 Jul 2024 10:15:21 +0200
Message-ID: <CAFqZXNtNipvJLt3kvhQ0hB-P_Niyn0fQK0VTp-+Ce15WiJYO+A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Gong Ruiqi <gongruiqi1@huawei.com>, Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wang Weiyang <wangweiyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 1:55=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 29, 2024 at 6:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > On Sat, Jul 27, 2024 at 4:55=E2=80=AFAM Gong Ruiqi <gongruiqi1@huawei.c=
om> wrote:
> > >
> > >
> > > On 2024/07/26 21:43, Ondrej Mosnacek wrote:
> > > > On Thu, Jul 18, 2024 at 2:34=E2=80=AFPM Gong Ruiqi <gongruiqi1@huaw=
ei.com> wrote:
> > > >>
> > > >>
> > > >> On 2024/07/18 0:17, Paul Moore wrote:
> > > >>> ...
> > > >>>
> > > >>> Where (what distribution, version, etc.) did you see this problem=
?
> > > >>
> > > >> The problem occurred when I ran the testsuite on Fedora 40 with v6=
.6
> > > >> kernel, and it was the only failed testcase.
> > > >
> > > > Sorry for the delay... For some reason the test passes for me even
> > > > with cgroup v2 only and without the patch (also when run from a
> > > > regular user account with sudo). Do you happen to know what
> > > > circumstances are needed for it to fail when the cgroup is not
> > > > switched?
> > > >
> > >
> > > As the comment in the script says, a process need to be in the root
> > > cgroup in order to switch its scheduler policy to SCHED_{RR,FIFO}. So
> > > maybe in your case the shell process is already in the root cgroup?
> > >
> > > In my case I need to ssh to a Fedora VM, and that makes my shell proc=
ess
> > > to be in a sub cgroup called /user.slice/.../XXX.scope (looks like so=
me
> > > systemd stuff). And since /sys/fs/cgroup/cpu/tasks doesn't exit in th=
e
> > > system with cgroup v2 only, the script skips moving the target proces=
s
> > > to the root cgroup, and therefore the subsequent test fails.
> >
> > In my case I ssh as root and end up in
> > /user.slice/user-0.slice/session-1.scope cgroup,
> > /sys/fs/cgroup/cpu/tasks also doesn't exist, and yet the test passes.
> > The same also happens when I ssh as a regular user (with cgroup
> > /user.slice/user-1000.slice/session-3.scope) and run the testsuite
> > with sudo. So there must be something more to it... maybe some kernel
> > config or sysctl setting?
>
> As a further data point, I also have been unable to reproduce the
> reported behavior.
> That said, since tasks doesn't exist, isn't the passing test a false
> negative (i.e. it isn't truly testing as intended)?

I don't think it is. The test wants to verify that it is possible to
change the scheduling policy with the SELinux permission and that it
is not possible without it - and it tests basically identical
conditions with the permission allowed and denied, so it indeed
verifies it correctly. The cgroup switch is just a preparation step so
that changing the policy to realtime policies can succeed at all. When
the test fully passes without switching the cgroup, then it just means
that the switch wasn't necessary for whatever reason.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


