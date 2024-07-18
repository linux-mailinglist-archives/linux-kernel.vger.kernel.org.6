Return-Path: <linux-kernel+bounces-255816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B2C934572
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9EC1C213AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838FA1C36;
	Thu, 18 Jul 2024 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUHoXZXn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBE639
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721263964; cv=none; b=q3PvY0/FR+l6mqy1qpiQZBiQV7cW6LNfEoYhwkkafEWjIDm0arz5Af8T6qHVo/ZkIML7x8NrJaLKMG3ObKPq8s+aByL7JKgVWrojUY0maTkEt8koleLo5GDKnLMD34u8i7CFI9iECq2jRIe+JHMBJ64g+EIU+ffFU4dA4QQC22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721263964; c=relaxed/simple;
	bh=esd7lYe5iq+onNX9j0js0Xwd+FXvQRDJiIeVuo28nhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5Od/Tfc3GuTtNZ1MKKZNJhQSa7T6pTInBYBwarhq3CEqSlv4S9ciOuc5ctwd6AfLOCRejMafd1r+5MPRo9JXQUQD6dNtTSfFQEJys+93BKIVS1/ANQ7ak+gS9W3HaavYa5z74WEUFC0lrCUJpWSVmHxZRnwdPvKwF/S10rSWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUHoXZXn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721263962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AodQvD7UxAvNv2pUpx69b2DHyG8xaHJX0frFiPMlh3I=;
	b=GUHoXZXnQ0jT/GaD8XAXtk1pEViDje+/t9q2ieOMv8zri+jSAiK/qBknyStQziSh2JZGfF
	OgeL1s62E53mBekPGHN0LJPb1hhEBari9m8eJUwzYtq7bxWCVtUCxyvie/2z3z45GB7KeM
	9UO+XEaGCC5qAByf5i0cvB1f309+8Mc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-ZyAe7OZiOZaxMHxzRUpKtA-1; Wed, 17 Jul 2024 20:52:40 -0400
X-MC-Unique: ZyAe7OZiOZaxMHxzRUpKtA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d92b366160so285124b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721263960; x=1721868760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AodQvD7UxAvNv2pUpx69b2DHyG8xaHJX0frFiPMlh3I=;
        b=C3d/MT+N3KYglxR/BbeHJQRIBpsZp62TVVm5lpN3VjzBmgZrd57Y/r6TUEw1qvQFRk
         Prr/QhMepiOuZuipgRv3eNBlZIS6qLARgN8qqkvmhxjiwn2hHqAAI6VoCzyy6unQNznc
         htM8XCW2Ihe9Wu3++2Wc/uD2NQbFg0/WHAtHnbhokND7n/kzMAicFIvJE6wXaKpmD8dW
         Uq/YP9CkXxQzzNMwWcuPI8eOtRRPA3mSeoS6ye/W7pRCMikcxVv1QovBj17AHZ1lEmlR
         LXP61NDHh8+e4Vgh43NOPbY26R22KmMyx06AKp41Q/ofOsFnkW7iZAnFXGxQHenmkZ20
         ZIGw==
X-Forwarded-Encrypted: i=1; AJvYcCVZWF9PtbSQGgp1YejmNCf74uhYIn7tNCa8XQITbgiP45iRHV8r8mWjqATGlOa+9sjpd5MAQg7hur+z7qG2PCIOJQPpAliGhwGG220K
X-Gm-Message-State: AOJu0YyYe1647kUcXm6k1sGRIDjgw8VKKrEIYyQ3z4ws2shRmKdkqDOc
	y/IIT3r7WsU5eYorqiX8Q3Q3sv4RMBQtBssID4g9SzOiIWoZWvrIwvLzWq0qu/IiTon/kSlhFw5
	sn1SkhIqvD+QqZJzOUT5fuJy/Py9wx3GN89LB6DcnmW0ovItiFi2eUZWOnYSADrGwWedS2Os9/k
	H1xiER+BYWFrj6ZXvNBYWOHxmeCzz4bBl6RGe5
X-Received: by 2002:a05:6808:1a23:b0:3d9:28d0:fcdb with SMTP id 5614622812f47-3dad51eee14mr3145976b6e.12.1721263960081;
        Wed, 17 Jul 2024 17:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9h+0U2xvRbnvYEIv1j3r48AzVXHuxA2+eaNiLAp0VT0zFKA+GDu9vEaf/3S87+CdfT1c71ctDFijpnhuen/I=
X-Received: by 2002:a05:6808:1a23:b0:3d9:28d0:fcdb with SMTP id
 5614622812f47-3dad51eee14mr3145947b6e.12.1721263959710; Wed, 17 Jul 2024
 17:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717053034-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240717053034-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Jul 2024 08:52:28 +0800
Message-ID: <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com>
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

On Wed, Jul 17, 2024 at 5:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> This is relatively small.
> I had to drop a buggy commit in the middle so some hashes
> changed from what was in linux-next.
> Deferred admin vq scalability fix to after rc2 as a minor issue was
> found with it recently, but the infrastructure for it
> is there now.
>
> The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780936b=
3e:
>
>   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/pub/=
scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_=
linus
>
> for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b3163:
>
>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07-17 =
05:20:58 -0400)
>
> ----------------------------------------------------------------
> virtio: features, fixes, cleanups
>
> Several new features here:
>
> - Virtio find vqs API has been reworked
>   (required to fix the scalability issue we have with
>    adminq, which I hope to merge later in the cycle)
>
> - vDPA driver for Marvell OCTEON
>
> - virtio fs performance improvement
>
> - mlx5 migration speedups
>
> Fixes, cleanups all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

It looks like this one is missing?

https://lore.kernel.org/kvm/20240701033159.18133-1-jasowang@redhat.com/T/

Thanks


