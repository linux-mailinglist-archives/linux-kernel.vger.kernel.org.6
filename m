Return-Path: <linux-kernel+bounces-227498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930591523B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5382EB2366C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5419CD02;
	Mon, 24 Jun 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY5uqnkz"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BD19B3ED
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242828; cv=none; b=DddLF9+79Q018U3dogTP7hJPrDTMQwlBjyR+n1Xz1zZNqQqLhjDEsowR/NRnvipWcXJMyNQhTXbLpWkniKm76c4iPI8JJbjxTpCI29bSpf6e0B3me8BFeUCo5yKaGAD35PULRjkLGQddwwl6owSpQib0nbzDb1AokoMQAYsjpAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242828; c=relaxed/simple;
	bh=mZJDkaLe4ItV7kwLQX1qs2ZAs4VlyrhLtGpA7B4NUR8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VofAur+v6zBfNkQzI26xHIRjsRwYNLYWClgjaxQMN4UYZhXTmATtJOgoKUHoVtAczLNuSEu6QRQjJ9ohk+tgax7ooO+tHzxaPQxH+tb8/QivGcD18EtgoidkZRtFv2VeudlHqb/9sXWwmWlH/Y0z7m66YSnUZfma+MqXgB6fAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iY5uqnkz; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-63258caaa91so41205107b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719242825; x=1719847625; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VHhhBBRB8rhuYmKapjgWgpG4+G3I2uB8l3zW0POFr3I=;
        b=iY5uqnkz+f4TC41FryJ/tnc0lm2Ruy3W+NAUCS2G24qy6TtTGpX7CLxE455bFtqMHj
         VYrtl4px1y5Jbk6rrx+p7K0+mQ18K36z2C/SFHNI4e77crCRV1WKA04QdC6T+P7C67MO
         8vmxdVAxpM7UY4h06VOmytXMzhnQTiVJY1P6FUjKaWG3EKXegUI+ZIdoILEXxUf7li6b
         EB9JNfoiCu71YBHVnGh1FG5R/6tCpLssnn8RMUrddEDdzASEIwQAbInZtVaJ9rs6caFU
         et+TrJk59IhvlB/O4P82p8XLmOMVSaDof+LxclRKYNx2U83IO0oHSEQ1WBVL/SZBhSqS
         v+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242825; x=1719847625;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHhhBBRB8rhuYmKapjgWgpG4+G3I2uB8l3zW0POFr3I=;
        b=hCzDOLx1kuEYtKvzr5KBc8qdGA9deSYfE5F5SMjkEJZThxg/Y9wQ5zhci0fyMj7kbE
         QlRen0JAdimUubHStdtaAWMKSBqpq5EpO7mfBY2KU6pD20zGLr0xjA4DnR99W8nuS6lF
         gZVkTuemxyBG2I8i6v+n6y378cKeLJ/ANIrhoiOsqpVnlJz30GnTVioa7B4mvIS11c6C
         VhuNyCGJrj2bv96Bj4eGtmiRB1xlL3axVXRO05HQswX7alSaRIP81bd0UgbUhW5idEgA
         nntL/vDPK68A35tY1iTB2tzomlOaHTYy2HSB+bDHfl/utqIUprtBEJEReCsCtmK2U6WT
         3yZg==
X-Forwarded-Encrypted: i=1; AJvYcCXF11EyqYzPxshSrSq6RXoAi2whIvxlYSloncWmEGWpPPr+DMZ0g0PR8wP8iU7Xt90Aq/dlpVZ2AfivSn8+HFK0eF+AtnVmp80IVWC0
X-Gm-Message-State: AOJu0YwixYMK53hvX1GYL3J/cd//sFGME9OUy+IAjnfNbW8eqr3HCpoi
	pjJozRs1eRcWHSsITAhlR17+DM7zDCKhQfrsEdaBP+/d1cltUC6ViSA36Q1cig==
X-Google-Smtp-Source: AGHT+IH0xArOWZLb36B6dJSXuEj4YUKCkqiyL/JUHGGKJMOwiH8NjjpjjnU66Y8zzE+DIobA6DJAIQ==
X-Received: by 2002:a81:b184:0:b0:630:4:5895 with SMTP id 00721157ae682-64299f71455mr40316647b3.24.1719242825030;
        Mon, 24 Jun 2024 08:27:05 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64586546d17sm5790037b3.134.2024.06.24.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:27:04 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:26:44 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Usama Arif <usamaarif642@gmail.com>
cc: Yosry Ahmed <yosryahmed@google.com>, 
    kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
    lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Chengming Zhou <chengming.zhou@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
    David Hildenbrand <david@redhat.com>, "Huang, Ying" <ying.huang@intel.com>, 
    Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Andi Kleen <ak@linux.intel.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] 0fa2857d23:
 WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
In-Reply-To: <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com>
Message-ID: <61d19ec8-2ba7-e156-7bb7-f746dae8e120@google.com>
References: <202406241651.963e3e78-oliver.sang@intel.com> <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com> <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-265768386-1719242824=:2162"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-265768386-1719242824=:2162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 24 Jun 2024, Usama Arif wrote:
> On 24/06/2024 15:05, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 1:49=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com>
> > wrote:
> >>
> >>
> >> Hello,
> >>
> >> kernel test robot noticed
> >> "WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof" on:
> >>
> >> commit: 0fa2857d23aa170e5e28d13c467b303b0065aad8 ("mm: store zero page=
s to
> >> be swapped out in a bitmap")
> >> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git maste=
r
> > This is coming from WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp), and
> > is triggered by the new bitmap_zalloc() call in the swapon path. For a
> > sufficiently large swapfile, bitmap_zalloc() (which uses kmalloc()
> > under the hood) cannot be used to allocate the bitmap.
> >
> > Usama, I think we want to use a variant of kvmalloc() here.

Yes, I hit the same problem with swapon in my testing,
and had been intending to send a patch.

>=20
> Yes, just testing with below diff now. The patch is not in mm-stable yet,=
 so
> will just send another revision with below diff included. Thanks!
>=20
>=20
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0b8270359bcf..2263f71baa31 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2643,7 +2643,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *,
> specialfile)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_percpu(p->cluster_next_cp=
u);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->cluster_next_cpu =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfree(swap_map);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_free(p->zeromap);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvfree(p->zeromap);

Yes.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvfree(cluster_info);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Destroy swap account inform=
ation */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swap_cgroup_swapoff(p->type);
> @@ -3170,7 +3170,7 @@ SYSCALL_DEFINE2(swapon, const char __user *,
> specialfile, int, swap_flags)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto bad_swap_unlock_inode;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->zeromap =3D bitmap_zalloc(maxpag=
es, GFP_KERNEL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->zeromap =3D kvzalloc(DIV_ROUND_U=
P(maxpages, 8), GFP_KERNEL);

No, 8 is not right for 32-bit kernels. I think you want
=09p->zeromap =3D kvzalloc(BITS_TO_LONGS(maxpages), GFP_KERNEL);
but please check it carefully, I'm easily confused by such conversions.

Hugh

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!p->zeromap) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 error =3D -ENOMEM;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto bad_swap_unlock_inode;
---1463770367-265768386-1719242824=:2162--

