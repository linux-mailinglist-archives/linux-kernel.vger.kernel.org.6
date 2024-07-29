Return-Path: <linux-kernel+bounces-265548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225AB93F2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A356E1F22842
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA65144306;
	Mon, 29 Jul 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghUwKQlW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C778C63
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722248940; cv=none; b=M65AISD5xPMhLVy6x+7ur8PlPuPyqYgdpLvfkqVBrlm/PgGf+1OcttMrTJTLXMfAi2uCCH+HEilWWFJQkcJX1Pe1kFqKqMIrNdGe4fxJ2NE28/ZAk4tH6yh3ZuIuWB65xloMe5PVuJpfWrBbWqfgPjKFcI1JxPnJh3MXq1YIqa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722248940; c=relaxed/simple;
	bh=94HpCqIwg6BpBMPLVy8Gp//1JlmALRCUA0aVAoB9dK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BB7zNg4QkMU5uicsXpWl8TZBBJV71677CStmpaObXPNIIUM3R5RfB96F1crSfeaxcQ0/Fm8CHcBQT7BUgjTTvMaNXdzMlNpQUXTrfIbolFpqP+bWa3WR6x0EvLJLZheFuIgc5RIMA/sie3Ehxla7gWF40G16UhESTYxbKKrR5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ghUwKQlW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722248938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=94HpCqIwg6BpBMPLVy8Gp//1JlmALRCUA0aVAoB9dK0=;
	b=ghUwKQlW8pOOtS2zcJdcj8c37BeppOgF1LnPOr/pt7a9yKngG5hjLj0grkRHcvxUUK7yqf
	2Ntg0rrDe7HAFzJoUhdIleGYK1VRVZyKCugMwMG2xU6fjKzikS/oired3P1Mt+dGVdtnGS
	8yJ095OHe0Dv0Je/yrlg0CwBDPpde6E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-LDkD-ClgNZey4wATfRlGyQ-1; Mon, 29 Jul 2024 06:28:56 -0400
X-MC-Unique: LDkD-ClgNZey4wATfRlGyQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb639aa911so3122668a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 03:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722248936; x=1722853736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94HpCqIwg6BpBMPLVy8Gp//1JlmALRCUA0aVAoB9dK0=;
        b=AdpetGNS6wL0JavpO1ylUj1ILleH34OdQC9O2LPerlf32IaO98idbF0EYIkQI6U8Rl
         ve+ChrHpnXBTaU852CW3WVQ3HQAXJTuHdwH3boqSYNXFYyXZw8Bu7FKjbTxFIqxaC1HN
         SQw5F4GLr0Q2SajOjArIueAxwI3B1sLsJjtQ3cKgQyEJzRxyk3OgDS44Zhk4xF3r9OOT
         LPmXBD0VWVNp9hj5/6agWvHPDxXdPY1yCmLZB8NbitngJDQo5TCbrXF4ee2W/zrC8T7A
         jeN5ogbmUA9IZ5biyfcDT4whVEh4rJ2w6wMS1ramUsngcZPjeaMOrzSo28Mkun2poeu7
         ZtDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUinhtBXSZrjkTyViLSGQGid2P8BeNxhLzMG23IvJuXR7LebQJK8flAzU/Lj0I1oEwALUP8bweUEFYlES6/u72TccsVyK5edZQUJRXU
X-Gm-Message-State: AOJu0Yytw+nehxzkLS/tFn21HNcbwyJRi6SeVok+Q1JSqa71OSmuuIa7
	DgknB1YxcyNiQ9WslmgnRY3/ifCniK52fXCKHSVIfpfOwukqwJ7AOsdZpcDJCV/AjcowqSjmjmO
	hYTlzNZ/4xr5fj7kE3X3BaejxggD6yttnnta5HPNqxwbPoOlqRJ1QzOPdJ6oWWSdMTdsFXtiz5x
	u1Heg3yJhTLk8OFWxwaUCZ24JdGwSa/Big8TNQ
X-Received: by 2002:a17:90b:4c10:b0:2c9:7e98:a4b8 with SMTP id 98e67ed59e1d1-2cf7e207326mr5246208a91.24.1722248935722;
        Mon, 29 Jul 2024 03:28:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNC/iS70v48zrdpZXE+dD099lMsj3bVzyfkaPrvoNB79eNxNaWVl5ejuzlLHrFBwBSRnBoCL40IKptXEr4wkw=
X-Received: by 2002:a17:90b:4c10:b0:2c9:7e98:a4b8 with SMTP id
 98e67ed59e1d1-2cf7e207326mr5246190a91.24.1722248935365; Mon, 29 Jul 2024
 03:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702095401.16278-1-gongruiqi1@huawei.com> <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
 <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com>
 <0729db54-98cf-4006-91d0-0ebda4dbc251@huawei.com> <CAFqZXNsN9M__Mo018L8m0txi60vm3Ui5HgHvJYQK__0hhhMULQ@mail.gmail.com>
 <55390a1e-5994-465a-a5c5-94f3370259c3@huawei.com>
In-Reply-To: <55390a1e-5994-465a-a5c5-94f3370259c3@huawei.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 29 Jul 2024 12:28:44 +0200
Message-ID: <CAFqZXNu_cLLH811Z8CxDb07Adf+E_z+1nH=7nkO9H83CY9RETw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Gong Ruiqi <gongruiqi1@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wang Weiyang <wangweiyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 4:55=E2=80=AFAM Gong Ruiqi <gongruiqi1@huawei.com> =
wrote:
>
>
> On 2024/07/26 21:43, Ondrej Mosnacek wrote:
> > On Thu, Jul 18, 2024 at 2:34=E2=80=AFPM Gong Ruiqi <gongruiqi1@huawei.c=
om> wrote:
> >>
> >>
> >> On 2024/07/18 0:17, Paul Moore wrote:
> >>> ...
> >>>
> >>> Where (what distribution, version, etc.) did you see this problem?
> >>
> >> The problem occurred when I ran the testsuite on Fedora 40 with v6.6
> >> kernel, and it was the only failed testcase.
> >
> > Sorry for the delay... For some reason the test passes for me even
> > with cgroup v2 only and without the patch (also when run from a
> > regular user account with sudo). Do you happen to know what
> > circumstances are needed for it to fail when the cgroup is not
> > switched?
> >
>
> As the comment in the script says, a process need to be in the root
> cgroup in order to switch its scheduler policy to SCHED_{RR,FIFO}. So
> maybe in your case the shell process is already in the root cgroup?
>
> In my case I need to ssh to a Fedora VM, and that makes my shell process
> to be in a sub cgroup called /user.slice/.../XXX.scope (looks like some
> systemd stuff). And since /sys/fs/cgroup/cpu/tasks doesn't exit in the
> system with cgroup v2 only, the script skips moving the target process
> to the root cgroup, and therefore the subsequent test fails.

In my case I ssh as root and end up in
/user.slice/user-0.slice/session-1.scope cgroup,
/sys/fs/cgroup/cpu/tasks also doesn't exist, and yet the test passes.
The same also happens when I ssh as a regular user (with cgroup
/user.slice/user-1000.slice/session-3.scope) and run the testsuite
with sudo. So there must be something more to it... maybe some kernel
config or sysctl setting?

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


