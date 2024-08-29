Return-Path: <linux-kernel+bounces-307836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4859653A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C551F23B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1718E777;
	Thu, 29 Aug 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCZS39wx"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B718A938
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724975145; cv=none; b=VZwQBP7MzPJiNRgdg/lSf9gUskZRIL7PFbZbTzJ7+EdRQyYWMaPEnY41sM2e67u1oP5sP68I0/YnzxMaAwpi7ueIrcbJSX1Yhw/tVSUXg/Tu4MQyWIvYwws4g70eb/5K/UWBgjZ8YoTr6w40pLnGAyEQ24PbC+3SCB0qJm96DTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724975145; c=relaxed/simple;
	bh=PznsqK0p6k0E9T87D686uSgXj4y2tO8F5II7uB0+Rwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyqJpcJEbQziVQoMF4iolkwx2FvyK5DNcmIh/YahI4pWklRe78fRWaMGp3cvgSs1y/zBo0Fer1oF9kKO4GO0dvzx2dYBzk/zWpE51llbx+m8hPO4nVPBVhyvcWiVXDdw4z3BSVYv2S+/6CZfiOc/2w/guUxwxYtyC7JHjluF1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCZS39wx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf8a662467so6806616d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724975142; x=1725579942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PznsqK0p6k0E9T87D686uSgXj4y2tO8F5II7uB0+Rwk=;
        b=UCZS39wx7viQbk2rmHlyt6SgNhPMcUQEiUxaKmSRHLOhgKR5kWHrs0tBSvHus2DwQb
         f4wEMepv9xUvlGchxrX42O8eAHzPSc6qNXHUZZ8q5MwaEbgfcX5nLL9NQvEcetxJa6Dp
         qwuPAiZkQpBDr3Ivmyes2ASHZlZPV/Efv6QWp/eg2RqxOL6AWEVNjd58gx0gpLMG6DK/
         wnCZurY31WDFansawtIZPyoj/pMTtdoSy2Q73s5c9Db9v7pkcQ54rigbYAX/7TihShao
         bMxuJPBnGJ2veznCT43mDqj6mwSC0GFbDYyndpg7EztCIHRZv6jKCmtGo0brVd4fJcal
         0X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724975142; x=1725579942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PznsqK0p6k0E9T87D686uSgXj4y2tO8F5II7uB0+Rwk=;
        b=mK/Hlze20SEgGfJyLiKsz8gVLV75kMi0YfGl3DGyErf3jwf7wsUzYyGU1X/0Yk7NYA
         rOkNRvri35oJ7VOvVmxHhWLovNjEVEEo/GwZ13YpFht8l4uF3LrGuMqYYnJDFmWQhXlH
         vOCWpUlB6SwtVhri157B4plxX0DDHl+o8eriT2FkY5XKSwnSryc7s+slM9cX3kJx448t
         tgal+0GLn3L8xvkYpF8/c6ZqXT6gPQw47l9jlkmM7q3J5aQTLM1zKLllqIpnPCRzNkjf
         KV+LxQjri4RW4P9jRD5M9svA4qlvg501L1QmY4oZqgqF1bPTu+RXEZyFhWh1ibRs2Gmo
         MVHA==
X-Forwarded-Encrypted: i=1; AJvYcCV4jbK4PgQKgs1Nok8BXn+ad/IYKRVTDMj1Zt8z+68fVzDM2LIoRlG6uVcZ/1Bt1MtMLZt0h/OcxWBiRbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0L+xFmHu/Te+E7hT4AKVuI2D5HopcMRNC8uzmIGMMmVHGNGkA
	gHlkEM+SL7l3nbfFl2wt0rgiq1ezBWPTk13qry1XdrVXbH/asTzZ98F2VeZFY3cFLx5l8UXF6D1
	fyf1+Xn0N6o1G8p2eg5/+1igd22U=
X-Google-Smtp-Source: AGHT+IFu4hzc4hructb8wMHMMH2MKWxDpe3dxSJQpYCx2L/8g+RhM5u2t+dJK33KK+SYcJHvhTEPKtWgyZz1j+j742s=
X-Received: by 2002:a05:6214:419b:b0:6c1:6a71:9439 with SMTP id
 6a1803df08f44-6c33e4f9d92mr46393036d6.0.1724975142225; Thu, 29 Aug 2024
 16:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829212705.6714-1-kanchana.p.sridhar@intel.com> <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
In-Reply-To: <CAJD7tkaqp_3YbK_qsq+v2=Q0r4xwTG9PbbPYjQdpTBu_Z7K5_A@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 29 Aug 2024 16:45:31 -0700
Message-ID: <CAKEwX=PXvLZ0GBgBbxSX5qvB-5dYuQ=5Z88UN3oGmNxFMnMtrg@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] mm: ZSWAP swap-out of mTHP folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:49=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Aug 29, 2024 at 2:27=E2=80=AFPM Kanchana P Sridhar
>
> We are basically comparing zram with zswap in this case, and it's not
> fair because, as you mentioned, the zswap compressed data is being
> accounted for while the zram compressed data isn't. I am not really
> sure how valuable these test results are. Even if we remove the cgroup
> accounting from zswap, we won't see an improvement, we should expect a
> similar performance to zram.
>
> I think the test results that are really valuable are case 1, where
> zswap users are currently disabling CONFIG_THP_SWAP, and get to enable
> it after this series.

Ah, this is a good point.

I think the point of comparing mTHP zswap v.s mTHP (SSD)swap is more
of a sanity check. IOW, if mTHP swap outperforms mTHP zswap, then
something is wrong (otherwise why would enable zswap - might as well
just use swap, since SSD swap with mTHP >>> zswap with mTHP >>> zswap
without mTHP).

That said, I don't think this benchmark can show it anyway. The access
pattern here is such that all the allocated memories are really cold,
so swap to disk (or to zram, which does not account memory usage
towards cgroup) is better by definition... And Kanchana does not seem
to have access to setup with larger SSD swapfiles? :)

>
> If we really want to compare CONFIG_THP_SWAP on before and after, it
> should be with SSD because that's a more conventional setup. In this
> case the users that have CONFIG_THP_SWAP=3Dy only experience the
> benefits of zswap with this series. You mentioned experimenting with
> usemem to keep the memory allocated longer so that you're able to have
> a fair test with the small SSD swap setup. Did that work?
>
> I am hoping Nhat or Johannes would shed some light on whether they
> usually have CONFIG_THP_SWAP enabled or not with zswap. I am trying to
> figure out if any reasonable setups enable CONFIG_THP_SWAP with zswap.
> Otherwise the testing results from case 1 should be sufficient.
>
> >
> > In my opinion, even though the test set up does not provide an accurate
> > way for a direct before/after comparison (because of zswap usage being
> > counted in cgroup, hence towards the memory.high), it still seems
> > reasonable for zswap_store to support (m)THP, so that further performan=
ce
> > improvements can be implemented.
>
> This is only referring to the results of case 2, right?
>
> Honestly, I wouldn't want to merge mTHP swapout support on its own
> just because it enables further performance improvements without
> having actual patches for them. But I don't think this captures the
> results accurately as it dismisses case 1 results (which I think are
> more reasonable).
>
> Thnaks

