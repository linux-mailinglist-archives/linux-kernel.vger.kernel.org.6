Return-Path: <linux-kernel+bounces-346919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BCE98CB08
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CC71C219F3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915651FC8;
	Wed,  2 Oct 2024 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPU59UPF"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A7637
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727834668; cv=none; b=mn/lt6An/vhkugyeQW25LoWFGrX1/3rW1CB5f+JKU+pnoTce3GfLAYHuui6VU8GeQOqIHZMm9RdZcSSxtayfU9/JhQhKOvyQVk9nUu1bVW22DNUQWSLwD3q7QQbAiwClVR/jUNtJMR5YTHRRp5atDwhSrnqN7I9bPuzOdvhmZ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727834668; c=relaxed/simple;
	bh=rlF+vY6/5ObD1JIeV01tvrzQ/SwRs95L/nLrr93gG0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQU41NUO9Vq3Yp5UI/XXckX7uQlQ6YwtzpYhANNhtIuVnPdyMjefuLxLvHy+Kl0UkbCQPngZl0UZy1dd3h+GJfiu5K7Zxi7rdml4Ey8LZcFaiAGWqVX34F0g7lFAlyBTyCEawR1JGfZRsnyh56JXHbF+SCwoW8aLvZVl+xt76Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPU59UPF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a9ac2d50ffso37090985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 19:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727834665; x=1728439465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlF+vY6/5ObD1JIeV01tvrzQ/SwRs95L/nLrr93gG0c=;
        b=GPU59UPF2BN9e2nA9TXGHfsfxiEV0VP76Ld44/svXqzH8p5e534CrYxK37CEtg+6jP
         LjC4YlHxoI7vHWtqH+C6/RSqr1B2FtC+Lx5/sc10BX82sVZWEWJkS5pVOuYGkJYNvF+V
         dE21v73uOaCC252eqKBhNT/JkNbeFBOPxjpp0Lp6W903FRhStYr/Zh+QvNsUi5xGY5TC
         +T6Yq1cxtgSHF4i7w+zcx+QcQH11bsgo0SF00d+1xJgJ0xSjtj2Sprai/GUJBnQVNj0s
         1vbZFx7SOw/M4fxh6NBqhc3Ehqt5Tp2Tdf7sErkZ4KgxMahg/wqTJv00nvwJagugvytk
         ty0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727834665; x=1728439465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlF+vY6/5ObD1JIeV01tvrzQ/SwRs95L/nLrr93gG0c=;
        b=jbCFIEs3YOXVyBMC02rJUPz9cXQmwDUmGmE6U3q2gGSoI+jyZIbDyClyPVxR3G4kGO
         GVgTKx9mSMqn0B9QRigKj+uvY2kL89KDHdtao61zgEH8iy555XikHK8ngIBrVdLDGX0I
         NmPH27T1iSJfC+CXGGihYscfGkWYQB5b9869mR12/zg+J73SwQ/enuYD3rPqutledz5h
         h4YxdceecpYJjsXf0HNPtcDWHHlrSPQ13EIRF9MtpBhzsLCH0ppwPoibLA6ezUwPbrNm
         sjFpu7BpHNDfZSokvCbv3DwanKU0bGwLe8vWpNR8irWdJiYpSrC8uE0jjpgIg4rkeNya
         +FqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8U5VF8M5KCkKmkpkH9K9mMtWYmqZKS5YV5nss1b9/fzi2Oo+Y/a3W3ANkw/fkL9RAbo77Pa2x/ECkF9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1H4q0+14QZ5hH1xMMI6h0ar/qFeQ/2r45wqreuDOvHw1ThlUa
	s7OrQ2YJFVhcGDDuElVN6Ea4jk9j0tfKSwv2pLuYaYmD6twKMzjypKhP+9fkD25pkgmEEcKWjgu
	a2RcacbywAaoz28XHNL2zuI9uBPU=
X-Google-Smtp-Source: AGHT+IGyxL3vm0uBsZxQ0LGmaJ+qosmP4coEuiaqBsm1BBOIBXNV8by5vq6QxtiOzRXEWSo3AzmcFx/sm+Z5ysn/9Y8=
X-Received: by 2002:a05:620a:45a2:b0:7a9:b4d2:9d68 with SMTP id
 af79cd13be357-7ae5b853bcamr895222585a.22.1727834665475; Tue, 01 Oct 2024
 19:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com> <20241002012042.2753174-2-nphamcs@gmail.com>
 <CAJD7tkaFv_KmF4gM=wb_Rwi7S1Dt4yy+TU=TyMd1R=gx=3eWuA@mail.gmail.com> <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com>
In-Reply-To: <CAKEwX=OPaBCYHSesm7wT_+k-MExQk9b8wzEaEg6z9581YkPevA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 1 Oct 2024 19:04:14 -0700
Message-ID: <CAKEwX=OTq2HaEKGgM4n8M60xh217r=vKs4U-GGc83moS5pcZJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] swap: shmem: remove SWAP_MAP_SHMEM
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:58=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Tue, Oct 1, 2024 at 6:33=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> I was debating between WARN-ing here, and returning -ENOMEM and
> WARN-ing at shmem's callsite.
>
> My thinking is that if we return -ENOMEM here, it will work in the
> current setup, for both shmem and other callsites. However, in the
> future, if we add another user of swap_duplicate_nr(), this time
> without guaranteeing that we won't need continuation, I think it won't
> work unless we have the fallback logic in place as well:
>
> while (!err && __swap_duplicate(entry, 1, nr) =3D=3D -ENOMEM)
> err =3D add_swap_count_continuation(entry, GFP_ATOMIC);

Sorry, I accidentally sent out the email without completing my explanation =
:)

Anyway, the point being, with the current implementation, any new user
would immediately hit a WARN and the implementer will know to check.

Whereas if we return -ENOMEM in __swap_duplicate(), then I think we
would just hang, no? We only try to add swap count continuation to the
first entry only, which is not sufficient to fix the problem.

I can probably whip up the fallback logic here, but it would be dead,
untestable code (as it has no users, and I cannot even conceive one to
test it). And the swap abstraction might render all of this moot
anyway.

