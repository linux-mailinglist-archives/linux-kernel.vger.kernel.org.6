Return-Path: <linux-kernel+bounces-547213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9D9A50442
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6735816F049
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E905124CEF1;
	Wed,  5 Mar 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GRCmUsk+"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD91F63C3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191140; cv=none; b=jeBDPqPukbxiKOwt4l0Ns7dmmwNqDZzKVar45zDY1M2MnIxHKZRNxk6ZdPlu67PAPSqWGTw+mGBquzEGXvrhXc4OQDcoaMfXyF0aF0ZWpSfMX7SRMl+Vsa+T1vEYxMWrE3nJ4EUMmJcMau0rEmNFSLCOGMEwGoDeDgT2Akl4U9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191140; c=relaxed/simple;
	bh=2q39nFob89uGjhIZ3SJiCBavEHz6XphRtukgeM+fPHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqUVP4ejTmyLm0jmkoZdbdaFbVLnnRG1VdLZlxP6HhsrMC5b5F2a8HB+UQ+REfd8XK/iOh7Q00Yu90Vlz4/nrE5UfXZ19/gHg1c9QXKV4OepPGEVoZOU5fnwsiTHJtDdQxDp7CF1ryZjDXB+2R+ISmMouxxsRSidRMcEpAUbJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GRCmUsk+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e60c4412127so3250672276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741191138; x=1741795938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR6v/qJNcz2018VPIy19J59hCQI20OhNaLeBeMvMyms=;
        b=GRCmUsk+KxmEFI1arAP0wyX/T/tWMTzc9ZJ+oF37MOw5vKZfVPQfE3GS0AImNbqEV1
         t/WJ2kUcsQ5FaifEqil2ms5vhwPJQ+hEC63dbLxWoLgBqQ6trVqZ7E+zSPAJrxuxa0g7
         MW+oYixfDflRvccCzn4GSy30B9Ya+nS/f8qDuQuD0CxpbB+bWLdykfDgr9KVSQkJljrN
         l1y0PRKxER4TdC3RI1kd3hAyKXX42y6Qa+rcMX4VXy1WjHKFMx0rfPllrQhKasdPcE9S
         9TSKHrYxV5yE1TujVK03fCfYDAsz+IqXT49919qukuVWrrwcJqugFSc1Lpg4PPv5OeQF
         fEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191138; x=1741795938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR6v/qJNcz2018VPIy19J59hCQI20OhNaLeBeMvMyms=;
        b=RciJMmtdpZnr5yCqjTgDh8z/17QJKUj4HrcaF8GbaY7VG2OOGON2xh+Oa1r2t8Qckw
         dAphBNORonlVzZiJgR0n4SehR9WDrRHJGjnSKvv1HAmXHoJGL1SfIw6ejOzkIujwkHAv
         nbiDnkh5sSTBK3Qv+c4eYv67PS2DsutS7wAWR1cuutQZLQsrvvoBehMquLJTr4znepPb
         wjZ1jzCSFrrA3rmrfHrx1zJlb/PzG1uTm1rn038JqbdLIDGg7X1D3c8gNmf/vNlQUIfI
         UbFTBAJwACItLnAzJ5FKrwhUfMHZjwClFMqgcobPkP4RIdyZxdK52CGgPAMkpJuXBVTb
         ETUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZWIvs12DpTvdrnhHps3enrttOACa3Xw0XR3+4WpaLO+kbA8VdXcRvcbAcROdHbcxaF4+iIjTJ1goRY60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/yufRCu6Z5UyNnRiojCcX704tnctNEZkHNsWbmhVMsq5olNU
	QTii5G7PWuU3p7J93Q7aZvCEZm5Q2drCr/SUai1h4u141xosfJJZMepH1ZAT40jcIomcVtCZHqj
	Smb9NOphKdmz5bJ2hggKj9uabcqc9QfhlSi3q
X-Gm-Gg: ASbGncud8BvjRUGIDUu7y6HQ5mBTSZCK5VgzmJd3uMg6owS+1oqUKCnZsPo5GcSs2QM
	X0gFW2ICD5l1SyDUVNoNVkJ5HKO8K+AJkqlP48540nD5UZwhEDoXxMtd3g0QCor2oH7Nz6snKcR
	/4Tpw+dsZQq9ZPaOpv+WjSqaTafg==
X-Google-Smtp-Source: AGHT+IG2+ri9TiG/+pR3y5KkKxoz0d2KVOY8e3WkmBgUHc2qC5BioAV59fgj/NVLtTUT4F32NzzVt7ytF05Eu8bmAsg=
X-Received: by 2002:a05:6902:1583:b0:e61:1be5:d0ae with SMTP id
 3f1490d57ef6-e611e196a54mr5413376276.5.1741191137730; Wed, 05 Mar 2025
 08:12:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304203123.3935371-1-bboscaccy@linux.microsoft.com>
 <20250304203123.3935371-3-bboscaccy@linux.microsoft.com> <CAHC9VhS5Gnj98K4fBCq3hDXjmj1Zt9WWqoOiTrwH85CDSTGEYA@mail.gmail.com>
 <877c54jmjl.fsf@microsoft.com> <CAHC9VhQO_CVeg0sU_prvQ_Z8c9pSB02K3E5s84pngYN1RcxXGQ@mail.gmail.com>
 <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
In-Reply-To: <CAPhsuW6RrUiXaQe1HBYOvwUx2GFaA-RKx22955A2StsP2erTeA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Mar 2025 11:12:07 -0500
X-Gm-Features: AQ5f1Jpzk8xNhqaDNcdEV_2AlQwGfaf4RmRxkPjJlwjeTek1OtX3R3sL0LkAbEc
Message-ID: <CAHC9VhQ1BHXfQSxMMbFtGDb2yVtBvuLD0b34=eSrCAKEtFq=OQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] selftests/bpf: Add is_kernel parameter to
 LSM/bpf test programs
To: Song Liu <song@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:32=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Tue, Mar 4, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Mar 4, 2025 at 8:26=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> > > Paul Moore <paul@paul-moore.com> writes:
> > > > On Tue, Mar 4, 2025 at 3:31=E2=80=AFPM Blaise Boscaccy
> > > > <bboscaccy@linux.microsoft.com> wrote:

...

> Do we need this in the LSM tree before the upcoming merge window?
> If not, we would prefer to carry it in bpf-next.

As long as we can send this up to Linus during the upcoming merge
window I'll be happy; if you feel strongly and want to take it via the
BPF tree, that's fine by me.  I'm currently helping someone draft a
patchset to implement the LSM/SELinux access control LSM callbacks for
the BPF tokens and I'm also working on a fix for the LSM framework
initialization code, both efforts may land in a development tree
during the next dev cycle and may cause a merge conflict with Blaise's
changes.  Not that a merge conflict is a terrible thing that we can't
work around, but if we can avoid it I'd be much happier :)

Please do make the /is_kernel/kernel/ change I mentioned in patch 1/2,
and feel free to keep my ACK from this patchset revision.

Thanks everyone!

--=20
paul-moore.com

