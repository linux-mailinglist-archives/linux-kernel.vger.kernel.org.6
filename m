Return-Path: <linux-kernel+bounces-563227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17104A63A20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173733AE5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C975C86331;
	Mon, 17 Mar 2025 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6ZEtcUy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C4481B1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174660; cv=none; b=EoFJqPY5vPr/ERfxAG75uyYlAhAagxrS861vQHlsiLUvKUhbCWk5edVGSPEL1RCGfT15Der6AeQn0cKRqtnph1qXbpmo4I+knQc5wm+LSEazXuW+hmi8NEk+WvvbGM6eHYLGYfZ95M+l98Guh0bKQoj1Np7bdbrn3dmGyTCmmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174660; c=relaxed/simple;
	bh=wr5705vY/nP2UC9VWATWaf62F8wYzdpPjoyNpsn0P4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/NcE2V4LqJ7I0YbpDL8suXXZUMeKmRfQPrG/cSf+i3JbEXIbCsIMGN1pz1DXUHquypmLuHYMXJOe2NzoxMyW1pllp0zcoJmVkH0IEYcWjtXdPpfoMSLPZQCJK1MO7rEZryBgU7lRGN3tYKP7hJCEPv2huGKytzG9E1pmoogI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6ZEtcUy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742174657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqjIRX75JyFvC1kWSb5JfMC4rfb0SrVX1WUN6W9PP0E=;
	b=f6ZEtcUy1rjxGSUIp9xYLyMZoj1u44uyrJa5Lyy9p8eAUVaHmQTR8iFbt0qOPIl7UCFEv9
	SkxI+668fyEEIhSEVTq9YHFscDOP594yg1D8jYQetBz/yqAHwYxVNTlrN40q6PBDOQR5Vw
	TXPxno8SjzjuYbtKCDwroBpMdO76fQ0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-blScKE3uPdyo1RS8T7Xm9g-1; Sun, 16 Mar 2025 21:24:16 -0400
X-MC-Unique: blScKE3uPdyo1RS8T7Xm9g-1
X-Mimecast-MFC-AGG-ID: blScKE3uPdyo1RS8T7Xm9g_1742174655
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso1891051a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 18:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174655; x=1742779455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqjIRX75JyFvC1kWSb5JfMC4rfb0SrVX1WUN6W9PP0E=;
        b=ML6ngADTJk2WgVdWWcffdhye/NzGlxfxtQ7d4RsEizARNhuc9r51eXfBe5sh0FSa0V
         WfxNwq/y2hs3UkB2cw7jHs3sGzmHeErQA1+6ZgaOkWeQAhMmcZeLfXSY+uuuPVTwdfyF
         7g06ss4QjiLe0UThxyoCL9HrIBEnto7dzWHotd+cvSxMwwEawZR9nzxw0+w2kzjHLAr6
         UAMMmw8jV+j13N/YAz/ykI9ktYQ9pMX763sRbdifSGcqfwI0Yb8ry644jUF4kju+01Pe
         TjIjh9NPwtsP2k+dsHuJvGb93TOY6d1zamKnz0F35Y3w8/ZxggaM3Ruw48TXrUAm0blB
         8cww==
X-Forwarded-Encrypted: i=1; AJvYcCUNe9Qf/0PwViHz4/rnhygVM5s0O0MPb0rzWAsxxYKk0S1pSGplybBdo0l0c7s2G9npelzEQIJHMyv0ldg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJm6JM1wR6dtetGrJYGU9SrSvFwuy02HI9imEzyNKbXgN5cKK
	Y7CyET2RBNRVkhbNrt3A4M9jc9cV92N5tlMNjHI9SA2Pjru8rHRvTj5emJ3Turly4/XirRh5Mz/
	hQdND8x2+Vx/qV7VR/VOeouCmGczOBcH4X0ZLP5Rzt00xAXbDGQZ9+vqAa+gYnFdxeF3ugss2g/
	FbfbAe8FmunhqyhCKbCIixrN1Nl1SUuFJ8v1Sf
X-Gm-Gg: ASbGncvGxMpP0XKlcb65LxqLu/VqCw5z5A35sGD2OEZSVkDQ6j4vemccg3zNQp2ZTnx
	B8nLbMMV4GI9fEY12Cy/+Q1JT+4Elebpoal7lk+LqTqZZcMT0YHWNaNL4sjL9RNG7BMA2CZhLvw
	==
X-Received: by 2002:a17:90b:2d4e:b0:2ee:c04a:4276 with SMTP id 98e67ed59e1d1-30151c560d3mr11874663a91.5.1742174655233;
        Sun, 16 Mar 2025 18:24:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNuLTYcAFNsErMybv5eaXjSgyuDeUoOaJqeP+U8oqio3kP/m6M5ZI6zah2RONXWHXVhQ17o6TrOQOKO8cZ5rQ=
X-Received: by 2002:a17:90b:2d4e:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-30151c560d3mr11874640a91.5.1742174654798; Sun, 16 Mar 2025
 18:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-1-df76624025eb@daynix.com>
 <CACGkMEvxkwe9OJRZPb7zz-sRfVpeuoYSz4c2kh9_jjtGbkb_qA@mail.gmail.com>
 <2e27f18b-1fc9-433d-92e9-8b2e3b1b65dc@daynix.com> <CACGkMEssbh0-BKJq7M=T1z9seMu==4OJzmDPU+HEx4OA95E3ng@mail.gmail.com>
 <26592324-c1f0-4ff5-918b-7a9366c4cf71@daynix.com>
In-Reply-To: <26592324-c1f0-4ff5-918b-7a9366c4cf71@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 09:24:02 +0800
X-Gm-Features: AQ5f1JryPj-hCWP_uaH6cYjv69oLlSYyQNPiVp3RjP0NCgptSjazOnHXHVW7xb4
Message-ID: <CACGkMEtapdjiXCPd1JZUF8JP3F1Ks-AtrbFBNGtORYnXPPrBEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 1/6] virtio_net: Add functions for hashing
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

On Tue, Mar 11, 2025 at 1:49=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/03/11 9:47, Jason Wang wrote:
> > On Mon, Mar 10, 2025 at 2:53=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/03/10 12:55, Jason Wang wrote:
> >>> On Fri, Mar 7, 2025 at 7:01=E2=80=AFPM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> They are useful to implement VIRTIO_NET_F_RSS and
> >>>> VIRTIO_NET_F_HASH_REPORT.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> Tested-by: Lei Yang <leiyang@redhat.com>
> >>>> ---
> >>>>    include/linux/virtio_net.h | 188 ++++++++++++++++++++++++++++++++=
+++++++++++++
> >>>>    1 file changed, 188 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> >>>> index 02a9f4dc594d02372a6c1850cd600eff9d000d8d..426f33b4b82440d61b2a=
f9fdc4c0b0d4c571b2c5 100644
> >>>> --- a/include/linux/virtio_net.h
> >>>> +++ b/include/linux/virtio_net.h
> >>>> @@ -9,6 +9,194 @@
> >>>>    #include <uapi/linux/tcp.h>
> >>>>    #include <uapi/linux/virtio_net.h>
> >>>>
> >>>> +struct virtio_net_hash {
> >>>> +       u32 value;
> >>>> +       u16 report;
> >>>> +};
> >>>> +
> >>>> +struct virtio_net_toeplitz_state {
> >>>> +       u32 hash;
> >>>> +       const u32 *key;
> >>>> +};
> >>>> +
> >>>> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_I=
Pv4 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TC=
Pv4 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UD=
Pv4 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_IP=
v6 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_TC=
Pv6 | \
> >>>> +                                        VIRTIO_NET_RSS_HASH_TYPE_UD=
Pv6)
> >>>
> >>> Let's explain why
> >>>
> >>> #define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
> >>> #define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
> >>> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
> >>>
> >>> are missed here.
> >>
> >> Because they require parsing IPv6 options and I'm not sure how many we
> >> need to parse. QEMU's eBPF program has a hard-coded limit of 30 option=
s;
> >> it has some explanation for this limit, but it does not seem definitiv=
e
> >> either:
> >> https://gitlab.com/qemu-project/qemu/-/commit/f3fa412de28ae3cb31d38811=
d30a77e4e20456cc#6ec48fc8af2f802e92f5127425e845c4c213ff60_0_165
> >>
> >
> > How about the usersapce datapath RSS in Qemu? (We probably don't need
> > to align with eBPF RSS as it's just a reference implementation)
>
> The userspace datapath RSS has no limit.
>
> The reference implementation is the userspace datapath. The eBPF program
>   is intended to bring real performance benefit to Windows guests in
> contrary.
>
> The userspace implementation does its best to provide defined RSS
> capabilities but may not be performant. Parsing all IPv6 options have a
> performance implication, but it is fine because it is not intended to be
> performant in the first place.
>
> The performance problem is inherent to the userspace implementation,
> which adds an extra overhead to the datapath. The eBPF program on the
> other hand does not incur such overhead because it replaces the existing
> steering algorithm (automq) instead of adding another layer. Hence the
> eBPF program can be practical.
>
> That said, it is not that important to align with the userspace and eBPF
> RSS in QEMU because they are still experimental anyway; the eBPF RSS has
> potential to become a practical implementation but it is still in
> development. The libvirt integration for the eBPF RSS is still not
> complete, and we occasionally add fixes for RSS and hash reporting
> without backporting to the stable branch.
>
> I'm adding interfaces to negotiate hash types rather for the future
> extensibility. The specification may gain more hash types in the future
> and other vhost backends may have a different set of hash types
> supported. Figuring out how to deal with different sets of supported
> hash typs is essential for both the kernel and QEMU.
>
> >
> >> In this patch series, I add an ioctl to query capability instead; it
> >> allows me leaving those hash types unimplemented and is crucial to
> >> assure extensibility for future additions of hash types anyway. Anyone
> >> who find these hash types useful can implement in the future.
> >
> > Yes, but we need to make sure no userspace visible behaviour changes
> > after migration.
>
> Indeed, the goal is to make extensibility and migration compatible.

So I see this part:

+ uint32_t supported_hash_types =3D n->rss_data.supported_hash_types;
+ uint32_t peer_hash_types =3D n->rss_data.peer_hash_types;
+ bool use_own_hash =3D
+ (supported_hash_types & VIRTIO_NET_RSS_SUPPORTED_HASHES) =3D=3D
+ supported_hash_types;
+ bool use_peer_hash =3D
+ n->rss_data.peer_hash_available &&
+ (supported_hash_types & peer_hash_types) =3D=3D supported_hash_types;

It looks like it would be a challenge to support vhost-user in the
future if vhost-user supports hash feature others than source?

>
> >
> >>
> >>>
> >>> And explain how we could maintain migration compatibility
> >>>
> >>> 1) Does those three work for userspace datapath in Qemu? If yes,
> >>> migration will be broken.
> >>
> >> They work for userspace datapath so my RFC patch series for QEMU uses
> >> TUNGETVNETHASHCAP to prevent breaking migration:
> >> https://patchew.org/QEMU/20240915-hash-v3-0-79cb08d28647@daynix.com/
> >>
> >
> > Ok, let's mention this in the cover letter. Another interesting thing
> > is the migration from 10.0 to 9.0.
>
> The patch series is already mentioned in the cover letter. A description
> of the intended use case of TUNGETVNETHASHCAP will be a good addition.
> I'll add it to this patch so that it will be kept in tree after it gets
> merged.
>
> Migration between two different QEMU versions should be handled with
> versioned machine types.
>
> When a machine created in 9.0 is being migrated to 10.0, the machine
> must set the hash type properties to match with the hash types supported
> by the existing implementations, which means it sets the property for
> VIRTIO_NET_HASH_REPORT_IPv6_EX to true, for example. Because this hash
> type is currently not included in TUNGETVNETHASHCAP, the machine will
> keep using the implementation used previously. The machine can be also
> migrated back to 9.0 again.
>
> A machine type with version 10.0 cannot be migrated to 9.0 by design so
> there is no new problem.

I meant migrate qemu 11.0 with machine type 10.0 to qemu 10.0 with
machine 10.0 etc.

>
> >
> >> This patch series first adds configuration options for users to choose
> >> hash types. QEMU then automatically picks one implementation from the
> >> following (the earlier one is the more preferred):
> >> 1) The hash capability of vhost hardware
> >> 2) The hash capability I'm proposing here
> >> 3) The eBPF program
> >> 4) The pure userspace implementation
> >>
> >> This decision depends on the following:
> >> - The required hash types; supported ones are queried for 1) and 2)
> >> - Whether vhost is enabled or not and what vhost backend is used
> >> - Whether hash reporting is enabled; 3) is incompatible with this
> >>
> >> The network device will not be realized if no implementation satisfies
> >> the requirements.
> >
> > This makes sense, let's add this in the cover letter.
>
> I'll add it to the QEMU patch as it's more about details of QEMU.
> The message of this patch will explain how TUNGETVNETHASHCAP and
> TUNSETVNETHASH makes extensibility and migrattion compatible in general.
>
> Regards,
> Akihiko Odaki
>
> >
> >>
> >>> 2) once we support those three in the future. For example, is the qem=
u
> >>> expected to probe this via TUNGETVNETHASHCAP in the destination and
> >>> fail the migration?
> >>
> >> QEMU is expected to use TUNGETVNETHASHCAP, but it can selectively enab=
le
> >> hash types with TUNSETVNETHASH to keep migration working.
> >>
> >> In summary, this patch series provides a sufficient facility for the
> >> userspace to make extensibility and migration compatible;
> >> TUNGETVNETHASHCAP exposes all of the kernel capabilities and
> >> TUNSETVNETHASH allows the userspace to limit them.
> >>
> >> Regards,
> >> Akihiko Odaki
> >
> > Fine.
> >
> > Thanks
> >

Thanks


