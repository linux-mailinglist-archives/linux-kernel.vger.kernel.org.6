Return-Path: <linux-kernel+bounces-304182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB4961B84
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3F21F24887
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7A3AC2B;
	Wed, 28 Aug 2024 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnZ8AztX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F6BA41
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808733; cv=none; b=RU12Oh6fuqXXvo54tA5u+dHL2TXm/CF/CRRJy0qsEsg3fqOX4WyotCIo3uhPUpSe8CAGFmDD87wpRCNX4bkZbxsgq3su8S3ND4i1wQ77olYxBIiDUNAPuPrbO0IC1z/rLi7plRghm9bfx04ssLbLDuWuGeTZgqfzP2WQL3Tk+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808733; c=relaxed/simple;
	bh=4q4wPHNgcWarct+BgJwMmUgsPcTHD8HpihPMy/2tmFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7LkJglxMdTpHxllyG9U9Ha3mj2AN1gPXI1ecpsboNHxmbczONXHyewNjiMYkXjSOJyA/SQ4O0zG/qMlQZ/d/Ff+bTIv3XEHetWoxMrFwzDq2NyBsIk9yKhwHPeIZnOvBLuCPraPIURU02tHQjuBw6PPOXyGNdw8Z+H9/W4NdNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnZ8AztX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724808731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eks8IjaD4ScDQe0q+7kEErXd6fLDVnTENBhfmNLrOac=;
	b=BnZ8AztXZ7wS2F97RuHJKvyWfuAAotUnBvawQ7FtQIF4ql1FG/pta9p4VtJqOICSubA+dy
	mij9IdhhJ8g34MZ4DtS7esARwph24XN4tXfoqIDepEQDcsgLpRhsWt/3Dg6d428bkQjPsw
	cUOlZoiUBAGxMFzuBQdj/Ht9KoQ1pVk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-VufdYdYjM8mJ81il7Sc-yg-1; Tue, 27 Aug 2024 21:32:09 -0400
X-MC-Unique: VufdYdYjM8mJ81il7Sc-yg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-715cdf0a53bso391192b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724808728; x=1725413528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eks8IjaD4ScDQe0q+7kEErXd6fLDVnTENBhfmNLrOac=;
        b=TUM0rKVL8YNwdPrFs2rQ2jA38gQHaLnGUVTKy8akdENUOvUADguw3Lsyik64ABQmir
         ExxU69AbgKxfhyTFsfDdbMbu9PL5xjWmTktjbrtwtqy6sea2oysosmQF2Il6R2jiO7mJ
         NF0gyrkhaKacK3IKnqr7lkuq2A06G1KTjFEikEEUyCZwH6I1BrRtU+tGGFtNW2FFGTEl
         6q9Vc4uVi8qcpQyi29lNpR8lUmQR7tm1ICsMjWQ4hUm/GkyJvhLYgSggeStzuzZjqIer
         3dIJm5bBKlH2HjG716Lwcnj0SaT4bZhSYmvuzsNaKm8KyxL4Ky9bxXPn39AagyL453wB
         3WYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vnx2gyZPJBrz/jqSuPU+WBEMOClbvibzcu0F7v8DRrM61Vvtg413jYc7Kd9YMHNm61X4Bc1k7szOT9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XhvLFAtGVDcB4WFzXTvpqOlaT/XF4cpSKCbDedHoEkj0mMC6
	fEYeUbwuSfuHesVokUClSKVbjA15Wy14B7IefoPBmlTxmlMRL7J1tXQqZG9HadjYShYsUybrk0w
	51AAxefyPh0O9lfSAWDfGEcoN9Qc8twrWvZp9+9KVeguXOTQuxdrsEauYh/z+ZKwkG2p6/5HoWp
	3+VRbSanE36P4kHqrZKYWr+l6mANaLRfVa5Ti/
X-Received: by 2002:a05:6a21:680d:b0:1c4:d540:46c with SMTP id adf61e73a8af0-1ccd28e8e88mr353002637.47.1724808728478;
        Tue, 27 Aug 2024 18:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/+RNaL4SYm1MCvP/OC2E6KqG/eCVWCm4/PId7l0YdOCrduuHAlXyb1dKzaCh0nQKYdjA11tjDkUTIJ0YItvc=
X-Received: by 2002:a05:6a21:680d:b0:1c4:d540:46c with SMTP id
 adf61e73a8af0-1ccd28e8e88mr352973637.47.1724808727964; Tue, 27 Aug 2024
 18:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826074452.1490072-1-yukuai1@huaweicloud.com>
 <CAPhsuW6NOW9wuYD3ByJbbem79Nwq5LYcpXDj5RcpSyQ67ZHZAA@mail.gmail.com> <5efeec29-cf13-a872-292c-dd7737a02d68@huaweicloud.com>
In-Reply-To: <5efeec29-cf13-a872-292c-dd7737a02d68@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 28 Aug 2024 09:31:53 +0800
Message-ID: <CALTww2-Z7fp3O2ZELT=HQsxVqfFs1KZGMgQ6TJ4VKgBbeV1dhw@mail.gmail.com>
Subject: Re: [PATCH md-6.12 v2 00/42] md/md-bitmap: introduce
 bitmap_operations and make structure internal
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Song Liu <song@kernel.org>, mariusz.tkaczyk@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 9:15=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/08/28 4:32, Song Liu =E5=86=99=E9=81=93:
> > On Mon, Aug 26, 2024 at 12:50=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> > [...]
> >>
> >> And with this we can build bitmap as kernel module, but that's not
> >> our concern for now.
> >>
> >> This version was tested with mdadm tests. There are still few failed
> >> tests in my VM, howerver, it's the test itself need to be fixed and
> >> we're working on it.
> >
> > Do we have new test failures after this set? If so, which ones?
>
> No, there are new failures.

Hi all

I suggest running lvm2 regression tests too. I can't run it myself now
because I can't get a stable network connection all the time.

Best Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> > Thanks,
> > Song
> >
> >> Yu Kuai (42):
> >>    md/raid1: use md_bitmap_wait_behind_writes() in raid1_read_request(=
)
> >>    md/md-bitmap: replace md_bitmap_status() with a new helper
> >>      md_bitmap_get_stats()
> >
> > [...]
> > .
> >
>


