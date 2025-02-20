Return-Path: <linux-kernel+bounces-522873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE35A3CF77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B27616A279
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F871D7994;
	Thu, 20 Feb 2025 02:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YidyjEca"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E4192B82
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019728; cv=none; b=r+h2spXyNP/kUg+4jqlK5XQBgF2j+nflojgu0RLX7CKRVj25dJmxL4p0kN/8rQGDes+iSz60Mt8qIKzAK2j3IkTRYAVHVp32xwopyU9gb/UgcYnq4uzw3B8joCVgCTHItlDaVGjpORZAxBaLA/2YHTL+9QpKPXCr1e7abHZonJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019728; c=relaxed/simple;
	bh=oU2xwnCvpwWrCAvB7uXjOa1+lUe7xkdGSJGfe3iwsn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVnrnXx0g64/fLjEYAC+Cms7491EkSbl0byXxdwy6QCCKmKPdk5qERSCYI+CSnpSxdPhnSWZOxFA1LdoaU0Xl+a+FiSql9GzsVqvgR0AZDwe9pobVEHkxBeSPqntPenooi4FbRqsRe3qGivPeD01EW8heECPcydHdUgA9VeWfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YidyjEca; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30761be8fa7so4258891fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740019724; x=1740624524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzMxoSg2tOMNdSdKmknVvWlQeKQe3RfI+4wHzR7T3b4=;
        b=YidyjEcaiGrEWrOA7A9p3Zu6da5ui6zAmbEaep4EV78wamW9xlJ9yp3lxnokoemH24
         eG2mw6QGX74c+kMwJhO3O8h6Kvsng4Pr8zoR341HRIU48+6t1HkNLKIe6DXRRrAqkv94
         mxPfpkou1Md2cu9VIqX0gZHOTLKyOfpEJY3hRviHqFlTeP9BCcwxItX7feBf1E37VgCP
         mFYYw94EH69AdbvnFF/S0ICjKf73k2kRgKmooJ2iqf1L8bUP/Z9SXnuPsRW9aIETW5p9
         Nxt7sYXHeipOknPvVofcWiBP94dEHHeM1dBnUVdG/0JQ58r/s2dOa0JadV4YirJyIKkA
         CBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740019724; x=1740624524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzMxoSg2tOMNdSdKmknVvWlQeKQe3RfI+4wHzR7T3b4=;
        b=ida09VM/t/hFkQK47DxB+EFmuPzWSlSxX/wyapdWIl6E1yB+ZHI8Hx8PSQStJOzpI8
         8HxIRlGuswAoUeu5jX0nbC61ip1u8ICZJ7jV2GDOBOJ5JausUP/IU1Oer0yjTYq2sS+j
         kupxxouH5yLsL67nOeGt4XBwdltEgWpnewCbvNY5hBK8S6vpBoYsKY0GRa5/8kjGDU1r
         bMF1tJaP7tqEFFAlowCLM9hEBwmOok59GmFiRzKTL7J7e/y2r+KpBwjFjaXwjNIvn/dj
         HN+esc5AEUxNPLc5SfIQvbR4wFP8wOdmx7HFdXm26V7vGZ1XkWjeOwJcFHMTc2Pg9UTC
         vgwg==
X-Forwarded-Encrypted: i=1; AJvYcCUV3Q9IVW2GDjKabLJTTJ3jBwA+pudtAr17/V7Xi/ScGUgTuQmesPwXOwhvBmEx9gA6na3FpwX4WCgmDdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKmHw+bXHfzCRfo2/Lg/krBSRCwU8PG6DGIIeJdbduOREDrpe
	ldXzc75MALXGPrZ5zV0dB1RnuIv3P5BNkWBRJ/zmhSgApjaeGxtlNLnirYD4Xy9tdU4vruYbIVq
	5CcTxZ0KfdpL7J/lPNSLcAwspnEZSMj/w9uHy4g==
X-Gm-Gg: ASbGncs/9/qKsOsT6PlnnbLC4LlsqJikhIk4LZuMvWTdm/U6FA/VJAbFvECAIf/dX8y
	bq2cHDVnj7TZMHvTg2+t38OShNKOH+WsxDs/dVsm8KOVAao4AMJFqsNApYrNB6qz39a3dO1nI
X-Google-Smtp-Source: AGHT+IF3/3fgIH0kPsdjO0751ew9g49kVMTVwbqnmwVARgLHdLLEf65naAudyXxcqmXlKBL0A2SGzFY3OSjHOVv7Fdw=
X-Received: by 2002:a2e:7d17:0:b0:307:db5f:c44f with SMTP id
 38308e7fff4ca-30a44dd63bemr19360061fa.19.1740019724073; Wed, 19 Feb 2025
 18:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214175709.76029-1-ryncsn@gmail.com> <20250214175709.76029-6-ryncsn@gmail.com>
 <Z7WOCvQq3xi9wxnt@MiWiFi-R3L-srv> <CAMgjq7C0Yg164SHJcP6wDC0od-xRuBMxLsJJwB0oWavpgsr8tg@mail.gmail.com>
 <Z7W4p0p/Qkke2LTp@MiWiFi-R3L-srv> <CAMgjq7AixL=Jn_c5jQFWWJt5+gPz0O+1rxtTWhzOmo2ef3dWhQ@mail.gmail.com>
 <Z7aU7wEx9jKo3TaT@MiWiFi-R3L-srv>
In-Reply-To: <Z7aU7wEx9jKo3TaT@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 20 Feb 2025 10:48:27 +0800
X-Gm-Features: AWEUYZkH97aGhO_riBep9RjdBLFBO16QqiFUnpPMB-Nduf69I6IlMOZZDA4acNA
Message-ID: <CAMgjq7DoV=ZdHeREeMq1=hKzD_O40NkfHCym1Wo9m=J=cBnUvw@mail.gmail.com>
Subject: Re: [PATCH 5/7] mm, swap: use percpu cluster as allocation fast path
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 10:35=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 02/19/25 at 07:12pm, Kairui Song wrote:
> >
> > > n reality it may be very difficult to achieve the 'each 2M space has =
been consumed for each order',
> >
> > Very true, but notice for order >=3D 1, slot cache never worked before.
> > And for order =3D=3D 0, it's very likely that a cluster will have more
> > than 64 slots usable. The test result I posted should be a good
> > example, and device is very full during the test, and performance is
> > basically identical to before. My only concern was about the device
>
> My worry is the global percpu cluster may impact performance among
> multiple swap devices. Before, per si percpu cluster will cache the
> valid offset in one cluster for each order. For multiple swap devices,
> this consumes a little bit more percpu memory. While the new global
> percpu cluster could be updated to a different swap device easily only
> of one order is available, then the whole array is invalid. That looks a
> little drastic cmpared with before.

Ah, now I got what you mean. That's seems could be a problem indeed.

I think I can change the

+struct percpu_swap_cluster {
+       struct swap_info_struct *si;

to

+struct percpu_swap_cluster {
+       struct swap_info_struct *si[SWAP_NR_ORDERS];

Or embed the swp type in the offset, this way each order won't affect
each other.  How do you think?

Previously high order allocation will bypass slot cache so allocation
could happen on different same priority devices too. So the behaviour
that each order using different device should be acceptable.

>
> Yeah, the example you shown looks good. Wonder how many swap devices are
> simulated in your example.
>
> > rotating, as slot cache never worked for order >=3D 1, so the device
> > rotates was very frequently. But still seems no one really cared about
> > it, mthp swapout is a new thing and the previous rotation rule seems
> > even more confusing than this new idea.
>
> I never contact a real product environment with multiple tier and
> many swap devices. In reality, with my shallow knowledge, usually only
> one swap device is deployed. If that's true in most of time, the old
> code or new code is fine, otherwise, seems we may need consider the
> impact.

