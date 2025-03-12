Return-Path: <linux-kernel+bounces-557177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA93A5D48E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15880189C0D1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443537DA6D;
	Wed, 12 Mar 2025 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mp4Fz3tb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361442A82
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748412; cv=none; b=VmsuvvPK/0kaLloOmThXQ3H6fxt/uXhaluwHeNe4NT0hoALRZbeHYYsHcClmBNq5P5FE03fEH1+wH0K1cB/sR9am85M7niCjTgJe3QZ5Xmcch2GpjYi9/dJvknZpcIzzKeQ69XsWbc0/DCE4Ha9FCbGRXVpgfhTdhuG6F/TodMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748412; c=relaxed/simple;
	bh=uh729120lBrgt14eq8/qws4JD1PfEtETFf5h4dUiehI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHeQp344m1q0rpNC/WlYo9S173hbFAvegnuI6H0TLK4+S0Ettj28sG/2R3Uarbhp8MnIGEW3j1S/5COzVlsXiHNiOCVT2aesK08xo6u7u6udnx5/r3ObvWwUKz7PJ6Hjx0YA25zyklJK/oYvYVTKLLjxx3GbPsG40K7LZ+erUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mp4Fz3tb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741748409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPO7R0eIW5tnFxhT73UA9jvPdIiqGpsDvnFvTsNRiiU=;
	b=Mp4Fz3tbxJiZMvsD6hfvpeFdwo03iVMThCe0yJP/vcVlrLwFNIN98Qu4OGgENceB6CjewT
	nesvGG4rg58Rx4kUh8gDN7Y0lEUgmhDEzwGkbnG9semiqNCfiEcf5sUyqtQ7ezvqfAuujJ
	j+X1sSZAAIzBvsITJ/nABwjTKXd7xSA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-Pk1i7PYHPm6PdoRLB4rwaA-1; Tue, 11 Mar 2025 23:00:08 -0400
X-MC-Unique: Pk1i7PYHPm6PdoRLB4rwaA-1
X-Mimecast-MFC-AGG-ID: Pk1i7PYHPm6PdoRLB4rwaA_1741748407
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so9552296a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 20:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741748407; x=1742353207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPO7R0eIW5tnFxhT73UA9jvPdIiqGpsDvnFvTsNRiiU=;
        b=f3mGO+5hZEgHvJi+olT97FMgVlaekYo2FDCsBONW3DKuhqP0wv+coUnHpOX9ztkFOK
         VD95H3tOT2ASSe8QI7gIg2cZk3lED+2ZpcAiBmZ9yHHUll9wFWHd80p6NkN/t5UQx0v4
         szQA0MqsmMlzLrQGxMCa/h2qIY+YM6wrbod63jElDDLu3Wkg/jteFG2k0c73xxkob4Oo
         KokFUSRFRaIV8IUqI0cW1gdZXDJmJZYgBipblBU6fx7pL+TPStaRq+1WzAy3W6rTOZuJ
         z24Kyjdx+J3NXZb1Tvb5RNKk+gwwMa96jdcvst6aupT/KsGcrijo48bkeGek+yGhtwOO
         92wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdI+FDkHQB2NJCrEsxDA4kip4iWwZoX5ApSg3iRNXvcR0avSB+LIW2Tuc9yrJ7b8tmbTB2Q7SlpheUDXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyILwAW8hpCRJ2ztAdj+s7CBCPerQI+U46VmImQTcDRprDLsxTJ
	++u2hawqDINT56pyA3vmdp2A28AoBnAm8XjxZAz3l2cqcAifHa/RkEyleQrEqTied8woa03LQ0D
	RN/e6HaVnTKqmCaHHmW5GeBPBB2p1S1rTwT815xVjF0F94i2460/hrfEZdeaAWkhSs2tYWFeU9U
	2+Q1tceDeM32ydeRoMVsP2DbfqdPLZCpa1/7cM
X-Gm-Gg: ASbGncthnTKdAE71yDa1yFuPxq3Rsqo+l5TvXhusSa+ZLuNLHCfohypBXmTFuUtIGJp
	XUMRLSKOyigGbNXeww7SDI3/0cJtwDL7wf91ogbxvRHBSWCP+rstFIJZ/+X2oW0G7piUfIA==
X-Received: by 2002:a17:90b:35c6:b0:2ff:4bac:6fa2 with SMTP id 98e67ed59e1d1-300ff100782mr8803695a91.16.1741748407250;
        Tue, 11 Mar 2025 20:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET6lsV/yTA4z+MP1noXOIunYsp3qN8L1Z8eiyVimjBwI0oZIPPsINtQsWF9heOMDn6TbEv142XFxBfq24rdok=
X-Received: by 2002:a17:90b:35c6:b0:2ff:4bac:6fa2 with SMTP id
 98e67ed59e1d1-300ff100782mr8803670a91.16.1741748406897; Tue, 11 Mar 2025
 20:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <7978dfd5-8499-44f3-9c30-e53a01449281@daynix.com> <CACGkMEsR4_RreDbYQSEk5Cr29_26WNUYheWCQBjyMNUn=1eS2Q@mail.gmail.com>
 <5e67a0a6-f613-4b0a-b64e-67f649e45c3e@daynix.com>
In-Reply-To: <5e67a0a6-f613-4b0a-b64e-67f649e45c3e@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Mar 2025 10:59:51 +0800
X-Gm-Features: AQ5f1JqQKEMLpBM7U-YYsZ15IkMLY-FYatkHcqLxAc5jqhv4juthUfs4s77Xshk
Message-ID: <CACGkMEv83iR0vU00XGOGonL1fkd=K1b-shCcNb1K8yJ9O+0BDQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 2:17=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/11 9:38, Jason Wang wrote:
> > On Mon, Mar 10, 2025 at 3:45=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/10 12:55, Jason Wang wrote:
> >>> On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> Hash reporting
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> Allow the guest to reuse the hash value to make receive steering
> >>>> consistent between the host and guest, and to save hash computation.
> >>>>
> >>>> RSS
> >>>> =3D=3D=3D
> >>>>
> >>>> RSS is a receive steering algorithm that can be negotiated to use wi=
th
> >>>> virtio_net. Conventionally the hash calculation was done by the VMM.
> >>>> However, computing the hash after the queue was chosen defeats the
> >>>> purpose of RSS.
> >>>>
> >>>> Another approach is to use eBPF steering program. This approach has
> >>>> another downside: it cannot report the calculated hash due to the
> >>>> restrictive nature of eBPF steering program.
> >>>>
> >>>> Introduce the code to perform RSS to the kernel in order to overcome
> >>>> thse challenges. An alternative solution is to extend the eBPF steer=
ing
> >>>> program so that it will be able to report to the userspace, but I di=
dn't
> >>>> opt for it because extending the current mechanism of eBPF steering
> >>>> program as is because it relies on legacy context rewriting, and
> >>>> introducing kfunc-based eBPF will result in non-UAPI dependency whil=
e
> >>>> the other relevant virtualization APIs such as KVM and vhost_net are
> >>>> UAPIs.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> ---
> >>>>    Documentation/networking/tuntap.rst |   7 ++
> >>>>    drivers/net/Kconfig                 |   1 +
> >>>>    drivers/net/tap.c                   |  68 ++++++++++++++-
> >>>>    drivers/net/tun.c                   |  98 +++++++++++++++++-----
> >>>>    drivers/net/tun_vnet.h              | 159 +++++++++++++++++++++++=
+++++++++++--
> >>>>    include/linux/if_tap.h              |   2 +
> >>>>    include/linux/skbuff.h              |   3 +
> >>>>    include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
> >>>>    net/core/skbuff.c                   |   4 +
> >>>>    9 files changed, 386 insertions(+), 31 deletions(-)
> >>>>

[...]

> >>> Let's has a consistent name for this and the uapi to be consistent
> >>> with TUNSETIFF/TUNGETIFF. Probably TUNSETVNETHASH and
> >>> tun_vnet_ioctl_gethash().
> >>
> >> They have different semantics so they should have different names.
> >> TUNGETIFF reports the value currently set while TUNGETVNETHASHCAP
> >> reports the value that can be set later.
> >
> > I'm not sure I will get here. I meant a symmetric name
> >
> > TUNSETVNETHASH and TUNVETVNETHASH.
>
> TUNGETVNETHASHCAP does not correspond to TUNGETIFF. The correspondence
> of ioctl names is as follows:
> TUNGETFEATURES - TUNGETVNETHASHCAP

TUNGETFEATURES returns the value set from TUNSETIFF. This differs from
TUNGETVNETHASHCAP semantic which just return the capabilities.

+static inline long tun_vnet_ioctl_gethashcap(void __user *argp)
+{
+       static const struct tun_vnet_hash cap =3D {
+               .flags =3D TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
+               .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
+       };
+
+       return copy_to_user(argp, &cap, sizeof(cap)) ? -EFAULT : 0;
+}

TUNGETFEATURES doesn't' help too much for non-persist TAP as userspace
knows what value it set before.

> TUNSETIFF - TUNSETVNETHASH
> TUNGETIFF - no corresponding ioctl for the virtio-net hash features

And this sounds odd and a hint for a incomplete uAPI as userspace
needs to know knowing what can set before doing TUNSETVNETHASH.

>
> Regards,
> Akihiko Odaki
>

Thanks


