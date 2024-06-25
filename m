Return-Path: <linux-kernel+bounces-228494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2819160AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9689F1F223D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328DC147C76;
	Tue, 25 Jun 2024 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhS5HS55"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA0145FE8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303082; cv=none; b=qJAlEDE8q5NXKhhKfg9E/xUfPC/IwmJq0iE46paL3hjTo9IHJg6DI37zi2YyvsdOha42SUnROaWbN03YRWC0BvZ9w67ylRSBXitHmDEwtkW8f2Xa5WjGVLF5Mc1okG6F7tjYjUrRkbjfGvUZEvBfkrmW/lu5WUBJJJHxgEPBD+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303082; c=relaxed/simple;
	bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LW16i22WGbdAa/tLef7pV9jZY1On2PUhOLOdnaY74hwkHama6XKA71zloj4Xr2Ejo1wbUkAw0b9X3nQZfHh8kEVNPkYinckMoKjQHpJEdVRDpcsFG0/COXeQq0/2LmzPP+q+ln4IXhRfeI/5tDo5ExWWXIRuznacc+9A4xFXm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhS5HS55; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719303080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
	b=bhS5HS55p+yoILch5etm3g/8tILfXNSjtYEB429VitxkhCdw2fOMBIjWKR5qWlkSh9Ev+q
	F1C4i5AToUEFR621ZzqWMLIrdV15mUY80kyh6S7d/qwl8vlqqq4kQPVSXGTTZXg/mMihiN
	DECsW9tOFoHzpb1D7r4R0iYgAJtV9fA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-umhku6nLOAKW7Yx5pS-OGg-1; Tue, 25 Jun 2024 04:11:18 -0400
X-MC-Unique: umhku6nLOAKW7Yx5pS-OGg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-706652a8d0cso3626298b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303077; x=1719907877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
        b=Pa7rZ7GfKLKYR32PeWp/VtZNwXgAOBZqQMjZijMlBfRfX6uR3L4alweM5M9sCOueB5
         FdKYdVy+nsDMnMx6GLJxo02VivQ7+xf+UhMWcAWwqZKuQIW+Df3qwtpqIoElTiniaF5U
         JGAFJJRtHdpd/iSR7Ckk08hDMhOLsDSCehbBAd3+yCVhB5Jb0o9d4flrLMqgi3rYaGqe
         9M15dywLhjvCI1T3x3U0l1NBnChmW7b2UpnKMGuUtDHxFXAYwmN3uBz2tm/ytLub/P1h
         9txh5mnxJaw3kDoJqcH3v2gk85vf9R8f/RFApyXKvlKiSSSOEt7Nl+vvGe6PoHGcwCbG
         NqMw==
X-Forwarded-Encrypted: i=1; AJvYcCVjwvlw5S3tdrVqCLgkAn2QziGHAd5wga6whmu8LwnD3tligWhPh101EuaK6bm5i5YSYhg3kehxU/WF8Ud3k/eSjDF2eKOop+IuqaD8
X-Gm-Message-State: AOJu0Yx4u1GYzeIfJRfJzCbJe8GC8fZxWmwFJw8d9uqZuveldhd8+xLk
	2fsD23ZyWsc+P+YbGXH/JkoEC6YMfW5pbNfO0sWtXDE9PHbKYodbFTkbkaLxH/I+ODiFOI3pxPA
	U/A1T0JO2iOBO+TTW+skRiQ7kTQkRfwLHCd8Aet1AmA7kIasQQSq9ybBwTpKmMFjyfQ/8aGnkPP
	Yu/UVEROdu/WZ1OJoWz4/X21Je+46OyP6JPV80
X-Received: by 2002:a05:6a20:841c:b0:1bc:f9ca:6153 with SMTP id adf61e73a8af0-1bcf9ca6221mr6768784637.14.1719303077075;
        Tue, 25 Jun 2024 01:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTxP7NUZILtOLpE7RPvLE5M6VrDgjulN2KCLl6SrNH4G4epy0uBszytXEo+lWjLhrJAgoEer6T7AKyi5WlAwI=
X-Received: by 2002:a05:6a20:841c:b0:1bc:f9ca:6153 with SMTP id
 adf61e73a8af0-1bcf9ca6221mr6768765637.14.1719303076509; Tue, 25 Jun 2024
 01:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org> <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org> <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625035638-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 16:11:05 +0800
Message-ID: <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state
 on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > Workqueue is used to serialize those so we won't lose any change.
>
> So we don't need to re-read then?
>

We might have to re-read but I don't get why it is a problem for us.

Thanks


