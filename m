Return-Path: <linux-kernel+bounces-537563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D329A48D86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 01:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F4A188F14B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4655E522F;
	Fri, 28 Feb 2025 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvQz5kCT"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7004182
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703718; cv=none; b=f3idzo/2r9qizp4khpLSlaW5GDIa0bx7JTLAT423OshL4WYJdEecwck4d+Oo/dDTabh/ldTNRExfl0vk/WEzRXmcRwJS+3cJ01JY0XU4vdpkFc9gPy4NMZaJpAjPzdrq9qtbPxLlvF5YupWP4LRpL9imFRPzzVLBD7rx+5uny9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703718; c=relaxed/simple;
	bh=GOzFXFh70+Yjyf/cQoTW9LJg+fDbHupie/qomZSw2Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHF/wsABn+drdy2hz6n7Z1or1VIJUtdP0EPIc/KvyNaNIHaAVydRFtUhWt+UPAAHn0KgPrdZbiwAwb5m6nco6GuNxXMSCf2A8c84EwtXP2alOqaHnoK/J178KqRMJTmSj8pQlwX3Xcytm1aje4HmTAIDnQPBLwQBPkGSzvuiU+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UvQz5kCT; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72725e5cbccso125215a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740703716; x=1741308516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mambjBaAXGR/a8NgOxwtya3jL9uRTgAKw1NEqKaou4s=;
        b=UvQz5kCTWKj960ctyMkguSC5yF3qdDuJjZmW5c2Cqr66ckKD8E6hwJqqKNhTWFD/mS
         Yr3RV35sV4cs493nyJoqc+iVgQaevjPv/9o8/rBUS2vuJJIvTrEPuzVC6sjX5fWf/qnL
         89gMJFP0TaL5WnD71ELR3VrOS9C18o7oylRhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740703716; x=1741308516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mambjBaAXGR/a8NgOxwtya3jL9uRTgAKw1NEqKaou4s=;
        b=pllRg3HKu8nXie3yaZZub9+/2ll5LuxPUPTW+RWrZwsoJFGQaMPleKC4bQDELQyfaF
         qWIFEj2GiyexZwxPzNeXG2uIiVwUdB5Bn5OZPsa8z8Hb/+xTuCqT1WmSjo7+ahR/9J4z
         pzQcKMeY7bE6qOQoSqekswKgP+mj3XmDTu34SyIzesKyshB2PEoEvW+HPr0Qtv5rOhDP
         +UABYa9AlzbB2bNGuzP+KCRuYwYoZgkqxJkFDXbU3oe40kcqYukgZhCHx6Nor5UlXneF
         9fniP3E7csnMpAR5+iP7MYlJMCuo8D8vGx5yIkkcG2be5V978V6ok8fAmV1ThZ9oaEbi
         +8mg==
X-Forwarded-Encrypted: i=1; AJvYcCWs4ez3mBZP2iU++oNQN34BChP2/ie4Q2j3bKeZnfoQ50ytBVPjNCOeBrVZQz4o+ctOXfCiAg6DQbRP+W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaL+cd1FfjcJqZPLuIbpAcuFWOmfJBNML+Iz4QTXne28WOHGFR
	RwcnK4yMKOIezqTZosakp/7pax58wjIxhFeg70Tc0dPMxiZDUGPoMDGsKuaoShXksf6M08wEnLa
	wbdfJxrL5lEQQvWiuGFVeny8nQNyxDKVcky6a
X-Gm-Gg: ASbGncuU27cc/j/F/DcDhtNL9mnquZwqc5Aw1wckzk2C4y1Z+ps4szjuUdxiFiKFGpU
	RxP0KAk+JCEkHp4rGFsn46qe/jrB32tN7BqTPANvEkQqo+weuSB5n4s3cI93muvCazzCKRDaxLb
	6euUzJMxqWkdSecQnTrHl8HjYTTZ3aawW60fAUZqf5
X-Google-Smtp-Source: AGHT+IHtq3r53vjQyLYRE5/olRbAlnuREoRvRu7BboZZh87Sxp3Nzk7HTBjsC2ak72lsggVPV5qzwgHPgUT2nN2+fvA=
X-Received: by 2002:a05:6808:1312:b0:3f4:13ee:5073 with SMTP id
 5614622812f47-3f558616df4mr285558b6e.7.1740703715878; Thu, 27 Feb 2025
 16:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-5-jeffxu@google.com>
 <899d39af-08d2-4cd9-9698-9741d37186b8@lucifer.local> <CABi2SkX0oGnqM4BDfRt0+7Pcf31td8np3=dVg1ixcaDNoUyHkQ@mail.gmail.com>
 <ea970928-ccea-4314-9cde-b64fa1a7824e@lucifer.local> <qk4m74uscjxdnlchcxolvgbw7ijppzqk57ajyc4m6jjixq5gti@lokjqegpftzh>
 <CABi2SkUprOT=TEDQb62SByjyW+csarKnGypdmxVdktj=+C9_yg@mail.gmail.com> <ba04b513-0eb5-425d-b24c-82c9f9b6c7ee@lucifer.local>
In-Reply-To: <ba04b513-0eb5-425d-b24c-82c9f9b6c7ee@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 16:48:23 -0800
X-Gm-Features: AQ5f1JpGUcOCdr5zrX3g_BrVkhytRR2N2kSp3XD88QAhkjOS5BLQ1YE3wTDvUZY
Message-ID: <CABi2SkV6JJwJeviDLsq9N4ONvQ=EFANsiWkgiEOjyT9TQSt+HA@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] mseal, system mappings: enable arm64
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:43=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Feb 26, 2025 at 09:17:10AM -0800, Jeff Xu wrote:
> > On Wed, Feb 26, 2025 at 9:12=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250226 00:26]:
> > > > On Tue, Feb 25, 2025 at 02:26:50PM -0800, Jeff Xu wrote:
> > > > > On Mon, Feb 24, 2025 at 10:20=E2=80=AFPM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 10:52:43PM +0000, jeffxu@chromium.org w=
rote:
> > > > > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > > > >
> > > > > > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on arm64, co=
vering
> > > > > > > the vdso, vvar, and compat-mode vectors and sigpage mappings.
> > > > > > >
> > > > > > > Production release testing passes on Android and Chrome OS.
> > > > > >
> > > > > > This is pretty limited (yes yes I know android is massive etc. =
but we must
> > > > > > account for all the weird and wonderful arm64 devices out there=
 in context of
> > > > > > upstream :)
> > > > > >
> > > > > > Have you looking through all arm64-code relating to vdso, vvar,=
 compat-mode
> > > > > > vectors, sigpage mapping and ensured nothing kernel-side relies=
 upon relocation?
> > > > > > Some arches actually seem to want to do this. Pretty sure PPC d=
oes... so a bit
> > > > > > nervous of that.
> > > > > >
> > > > > Can you please point out where PPC munmap/mremap the vdso ?
> > > > >
> > > > > Previously, when you mentioned that, I thought you meant user spa=
ce in
> > > > > PPC, I didn't realize that you meant that kernel code in PPC.  I
> > > > > tried, but didn't find anything, hence asking.
> > > >
> > > > Jeff, please stick to replying to review. 'Have you looking through=
 all
> > > > arm64-code'.
> > > >
I checked the kernel code and couldn't find any instances of kernel
unmap/remap system mapping in any architecture. But I could be wrong,
so I've also included developers from different architectures since
V1, and hoping to get some insight.

> > > > I ended up doing this myself yesterday and found no issues, as with=
 x86-64.
> > > >
Thank you for double checking.

> > > > I said I'm _pretty sure_ PPC does this. Liam mentioned something ab=
out
> > > > it. We can discuss it, and I can find specifics if + when you try t=
o add
> > > > this to PPC.
> > > >
> > >
> > > PPC allows the vma to be munmapped then detects and falls back to the
> > > slower method, iirc.
> > >
> > Is this code in the kernel or userspace?
> >
> > If PPC doesn't want to create vdso for all its userspace apps, we
> > could instead "don't create" vdso during the execve call.
> >
> >
> > > They were against the removal of the fallback; other archs also have
> > > this infrastructure.  Really, if we fixed the fallback to work for
> > > all platforms then it would probably also remove the possibility of a
> > > remap over the VDSO being a problem (if it is today, which still isn'=
t
> > > clear?).
> > >
> > Any past thread/communication about this that I can read ?
>
> Jeff, I'm sure you don't intend to, but I find it quite disrespectful tha=
t you
> ignored my feedback here (and elsewhere, regarding you ignoring 4 sets of
> feedback).
>
I'm just interested in the details :),  If we know why PPC needs to
unmap/remap vdso, then there are additional data points to consider,
when we develop pre-process level control for this feature. But sure,
we can postpone this.

> This?
>
> https://elixir.bootlin.com/linux/v6.13.4/source/arch/powerpc/kernel/vdso.=
c#L236
>
OK, you meant the failed case ? i.e. when install_special_mappings
failed ? That is a case that I haven't considered. It looks like error
handling, and I was expecting the install_special_mappings to never
fail, maybe I'm wrong here for PPC.

> Was [0] a relevant discussion?
>
Sorry, I'm kind of lost.  This link doesn't give a reason why PPC
needs to be unmap. If it is due to CRIU or  other user space apps,
that is not an architecture dependency, maybe a distribution
dependency.

Anyway, we can postpone this discussion for PPC, I don't mean to make
you spend more time responding to me. Please feel free to ignore this
one.

Thanks.
-Jeff


> [0]: https://lore.kernel.org/all/lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyus=
o6jcy3b2dq@7ju6cea62jgk/
>
> >
> > Thanks
> > -Jeff
> >
> >
> > > Thanks,
> > > Liam

