Return-Path: <linux-kernel+bounces-256882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 281039371B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9243D1F21DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4411FA5;
	Fri, 19 Jul 2024 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCCITDoZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF40C5664
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350935; cv=none; b=VTVUbU6bQXz8zTB1dY8zqBCLbWATY4FJcT+6jsnwEkOfPVxancCaNn7dJeO2qoXbZNEuTJKTCbaZrrNHRhKwGex9GSAE6/aOEvKFvYC38DOOl7ThgfHHKQdCR5aXu0Fb5YI4fXQtRa8tmVHTIS9FqPYYaUo1ajK/zg6r5KY1fpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350935; c=relaxed/simple;
	bh=egPWD6SvkPUOxMbhJVXX/ZmlFwvqOXO8b8h7S1FD3o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYLQwLYRX1gLsUPaJlpzw40x/wMUmzfcp7uzliuzJwDVxSdKQpEI6iwjgOev9vMuoJLr6krWeeEjo5EQJJ57nrEh1wg6wmDp5NBnZNgU3m47ZyOVaxQgDINQHAK+Au2O7q8oA7rQNfuKMBbfbIHUUTsdlHehgjS1FNFjQoVjeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCCITDoZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721350932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Juhk1rxXqcv0LvjBmmBek/yRx3F0GQ+A2PArt9J+ciU=;
	b=TCCITDoZZAxLWUR9fMipuChb0Whecd3AzOb5ksAB4z2aEZdkvNPK3oOGxKl/a0TL0TVMww
	85x6BJ95FH6VpeqcXptRj1r12hUE5IDkulXiUwT099V/HZjgqkXCUNSGur+IBwjwtjruag
	Bm7rqN9LXQYRSwiUCStLRc2QZTeRnDE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-hu9NtLTuMJSvQ5ZL2WLKcA-1; Thu, 18 Jul 2024 21:02:11 -0400
X-MC-Unique: hu9NtLTuMJSvQ5ZL2WLKcA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fc52d3c76eso14059555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350930; x=1721955730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Juhk1rxXqcv0LvjBmmBek/yRx3F0GQ+A2PArt9J+ciU=;
        b=DTJyAnGeGg7eDRRYQnN7Cbssf+somwib5670mqyr8LajKu5uxAjQpmMUFkMQ4emBWP
         fKGxuLtm3/unJG1ymmc54X64JcPoByjez0b5eqwvysi79zHjtHvP710GiERwS5cJMso+
         foREryqN9hY6u3MiW0gMt7Uu8CHpMks41dpUVY+7ndcckxl01p/AF7ABdcE5M3Q+1kvl
         GduIkx+It47d4HMPsbEnjv6alsihIRx+j43M+40vtSJ2QRPvyVZt5tuhT5SJnhu0C6jF
         1R5TJiVoyu7TMtem3R/uKxI6yOTHOxUzWHbR3xYGjhO26V8PdC/Nn910BrH85xIiRNvg
         cPyg==
X-Forwarded-Encrypted: i=1; AJvYcCVn4jgRPnObtbbTnv6wlT3SwuKJapo6zeqqEvKUuRTK+g7Oh/li/iK9xNSBFI0/zgMwjcRFJd4hVvVBkMpY3uwc6EpPTnrqma8NMy8D
X-Gm-Message-State: AOJu0Yw82TCaJTOT6a+VFL5CebHpBDBiIAtzLt3Paw1uFW0bEaYhqybk
	Otg9fioJqaJYPjiM9a/LzIFpJaCZEviHxufWsvCHnquxzGnP2p6CunS9Ip6EBojXJ0gJb4AewxD
	SVdFUqmw/o6JjiRfw7I1QR79a8go6fpXNQ0MdnJ14QgYHvzrbE52IhUgA0Y9pgmjfUHrqlj4xuV
	ACqAE+nn0NOFPbEs3gMdiYkVMz92zgdPLP9+Lx
X-Received: by 2002:a05:6a21:39a:b0:1c0:f529:af05 with SMTP id adf61e73a8af0-1c3fdd4d914mr6793179637.43.1721350930337;
        Thu, 18 Jul 2024 18:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIRWijrC51r9BOXUiE6Aug7hDC6Lr0jyTkTo6KMrQRu/t6/fcr6+L8+BQ4wl7rzCezfYFnYOWyCyo72nnIjgU=
X-Received: by 2002:a05:6a21:39a:b0:1c0:f529:af05 with SMTP id
 adf61e73a8af0-1c3fdd4d914mr6793160637.43.1721350929827; Thu, 18 Jul 2024
 18:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717053034-mutt-send-email-mst@kernel.org>
 <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com> <20240718152712-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240718152712-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Jul 2024 09:01:58 +0800
Message-ID: <CACGkMEtTVmKYMdvjzE753+czmEcts4caG859_jW7nHQt7ATgkw@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aha310510@gmail.com, arefev@swemel.ru, 
	arseny.krasnov@kaspersky.com, davem@davemloft.net, dtatulea@nvidia.com, 
	eperezma@redhat.com, glider@google.com, iii@linux.ibm.com, jiri@nvidia.com, 
	jiri@resnulli.us, kuba@kernel.org, lingshan.zhu@intel.com, 
	ndabilpuram@marvell.com, pgootzen@nvidia.com, pizhenwei@bytedance.com, 
	quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com, 
	sthotton@marvell.com, syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, 
	vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com, 
	yskelg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 3:28=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jul 18, 2024 at 08:52:28AM +0800, Jason Wang wrote:
> > On Wed, Jul 17, 2024 at 5:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > This is relatively small.
> > > I had to drop a buggy commit in the middle so some hashes
> > > changed from what was in linux-next.
> > > Deferred admin vq scalability fix to after rc2 as a minor issue was
> > > found with it recently, but the infrastructure for it
> > > is there now.
> > >
> > > The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780=
936b3e:
> > >
> > >   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/=
pub/scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/=
for_linus
> > >
> > > for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b31=
63:
> > >
> > >   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07=
-17 05:20:58 -0400)
> > >
> > > ----------------------------------------------------------------
> > > virtio: features, fixes, cleanups
> > >
> > > Several new features here:
> > >
> > > - Virtio find vqs API has been reworked
> > >   (required to fix the scalability issue we have with
> > >    adminq, which I hope to merge later in the cycle)
> > >
> > > - vDPA driver for Marvell OCTEON
> > >
> > > - virtio fs performance improvement
> > >
> > > - mlx5 migration speedups
> > >
> > > Fixes, cleanups all over the place.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> >
> > It looks like this one is missing?
> >
> > https://lore.kernel.org/kvm/20240701033159.18133-1-jasowang@redhat.com/=
T/
> >
> > Thanks
>
> It's not included in the full but it's a bugfix and it's subtel enough
> that I decided it's best to merge later, in particular when I'm not on
> vacation ;)

Understood.

Thanks

>
> --
> MST
>


