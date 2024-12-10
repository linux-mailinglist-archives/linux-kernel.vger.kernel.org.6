Return-Path: <linux-kernel+bounces-439469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 188259EAFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8389716B0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE2A212D70;
	Tue, 10 Dec 2024 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPGhqPdk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074223DE9C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829487; cv=none; b=rUXDNNNcYFvHb9M9vRnURBhwyjRp/P9exsf4Pp0IBCB55F4JMu7OvxOzIYoIPJW5a2KrRiBbA/NBcg4zI2GK1u+uyIDzhi+gpFs8t9RrD50vi5G14QiVNkoq9Si+itvpy18Xa/Zaw2v6t7sZg2XTYihyGJdJHmTLNNdifqO07qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829487; c=relaxed/simple;
	bh=xRkDnvgqhKC7pVvFgMOmw0vw6RnP7LSWwZlo4gH9JyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFSJUFCN3uy8qSh7nmWpsJd3sZuV87tFF/EkcAwGTywWij2wz6f3GaThwxTQfvYAd7QFyNU4A/jyuAlvcvCNLHVLIqRDOkXExgnwZlBXE1E/mqo5PwGFcPJMemDGJaqoe+l9oGHBKut953qGtzWAXvWf0l3U9iGzLnGOKhP+cfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPGhqPdk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733829485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/O28FvqUDFtlFEhRs0ZTpEz5523mfxGFot4nFCX4rWw=;
	b=UPGhqPdkiZuKI+Rn/Wqdief+6GW9O5gaLVAsprNkCvwjEjeHFg2ikMGMNkvkJwobx4sgrj
	6wXPmTgBAfcHNobIovIXB9Kw8Z26ypevwMBRGGnqzsSdSli0drzebXAoVQyi3nnmcHBbg7
	Z9TjPA4BipFCeR78QpEmqQ73cnilin8=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-lBoa1hNMMQyKgQuWzaFCEg-1; Tue, 10 Dec 2024 06:18:03 -0500
X-MC-Unique: lBoa1hNMMQyKgQuWzaFCEg-1
X-Mimecast-MFC-AGG-ID: lBoa1hNMMQyKgQuWzaFCEg
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4b11337b82fso882669137.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733829483; x=1734434283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O28FvqUDFtlFEhRs0ZTpEz5523mfxGFot4nFCX4rWw=;
        b=Qgu2OLIA4xOu31g29FOax4X/o5pV+FpxNNr7SUrWT8MiWQqoB9q1pfcvaLzKwoBhug
         rAEQ2fwG6/y9CJY+P94SzPKz3+gkFtxAK9N8Mi6+ifJEGgv2kDUO7fTRJ8rl/Hvu4rlJ
         NoGpDR/mxTmVZp2ts4vwDaIAOwXM97aDITs5SoKgc8eJIifW5pziAnagJ2SACYkakaMC
         vot3MV2eD+iZjC28njBCbfMGJ+zD8F3+4wGSzNYASgCrwrgNlDbETw/p2bzynJHXtv5j
         cwj9z3C9rN93Rqr64fs0eO7Nq+IVEF8avksRY2rOfHnPCgCjUXCn3fSO3SuJaiPfJbAT
         IPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUix5vwmWg3gr4kLyHjCGpZkvnNH/q8mpoC+TQAYToC6nSGv4IhXK4rNs6s6Fhj5us9fY1/oe7rs9NmhSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ9hCkRo4dZMi5GGmhSeQ2e2LEgYKIEnE2Tkyys6XApSutyQhE
	fuqfE4kubN3O2hQELBMiIwo/yeM/+cR5VqBevlQRDWWqQa2lNpZT1/ujhZXXTfio5QnHo9AVIMB
	SGqv9Ieo2L59zKff5/nFmu+xxjn7sWQyL2XLaDyoxhKwnpSyizp2zejn2Z4++VR8ZjLTY8S3d4V
	3kHSDQU65ZDQfWIGcUyr5jrio20ViAEAhIvbwU
X-Gm-Gg: ASbGncuNjDeS4baqOxX47zcrd+cOxIO7La3ZF/tf39qZWEmblxdBwntoxJJ6E5Yw564
	b7WEca8lxC1+FflfcVnelXMq9yQQVfIBJema9
X-Received: by 2002:a05:6102:54a8:b0:4b1:1295:43d2 with SMTP id ada2fe7eead31-4b11973af3dmr2038425137.12.1733829483305;
        Tue, 10 Dec 2024 03:18:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF7AJlQ4XwlrhYyc/FI8fEAkFBhMhMIGgnfhA9A/41dcNPSUDJR36T+/JNAESZorM0joIEwafHADQlO98lkag=
X-Received: by 2002:a05:6102:54a8:b0:4b1:1295:43d2 with SMTP id
 ada2fe7eead31-4b11973af3dmr2038418137.12.1733829483075; Tue, 10 Dec 2024
 03:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675742b5.050a0220.2477f.0054.GAE@google.com> <20241210104439.1770-1-hdanton@sina.com>
In-Reply-To: <20241210104439.1770-1-hdanton@sina.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 10 Dec 2024 19:17:52 +0800
Message-ID: <CAFj5m9+LOn130frv+bVuzLOc8a72xnXi-u9WENJdkT0hFOH+tQ@mail.gmail.com>
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>, 
	boqun.feng@gmail.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:45=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 09 Dec 2024 11:19:17 -0800
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    fac04efc5c79 Linux 6.13-rc2
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/lin=
ux.git for-kernelci
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D147528f85=
80000
>
> #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-bl=
ock.git   for-6.14/block

This one looks one real deadlock risk, similar with the following one:

https://lore.kernel.org/linux-block/Z0hkFoFsW5Xv8iKw@fedora/

I will take a look when I get time.

Thanks,


