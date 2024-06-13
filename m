Return-Path: <linux-kernel+bounces-213357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41CE907426
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F771F22703
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B71E519;
	Thu, 13 Jun 2024 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8lEOC4f"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1421DF71
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286365; cv=none; b=L8ML8U/4Rx7biqrs0p1NgcfYYohUU6MRlkPATm+6hU8Ybm9fHihVQqSeW6NueIO10vzUgs8yMZejat744Qm6JJGeCm/+6tDqssOTIrP8fo7S0EQ0RidCLW9bK7uvLiifxAMpwbeHW+Q9ixRQdvTT/HAOU0k362kF0kTghJ5zw3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286365; c=relaxed/simple;
	bh=y1LCLqTQpgjlSACujMB9iRZQRD/4Q4qxBaYK7DnQBy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjK7vi4H+e1aK1eSvFKNzkhWvT9lAOdK9QVbskHUBPmwnizvswo+Ms0l3ACHDsUrpNPspTqaFrhws7wHz3jBSXfthfea1XogTSbJV46OEZriRsNgdmJ0Sy28nplNPlujCg/aIPJY34HZ5CUwENPe4r+/EQwl9bSjF+6Vzh8Hrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8lEOC4f; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so1450467e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718286362; x=1718891162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1LCLqTQpgjlSACujMB9iRZQRD/4Q4qxBaYK7DnQBy4=;
        b=F8lEOC4fWpB8XZbGtBGxf/aT11zmqwpmlnQbm3gqYmF7NZ5MgK+srCTA2YHn58SiAR
         Avm0TnVdbl880FF9CLYyM44ckwatEjTvYtK32K2qItTg07XNkfu2FEUNwfe/TbOqxmSl
         m1sVHmymD0TRk6dp71rcyAair9Rj0omnW0N7XiKQaa3O/9DOWog626CikRxL2CZhSGoo
         hClFKTxEMIyNdRkJ9qwhrbw3JDhSLZZI+wZ6i1xerU7fXJswY+UOfhD0T941HN+A9323
         uvFw43NChiQfmUdKVVnN6RKlvLh8CxGhAlzhHPk0lqoRJDC4Pxx+XM8tmwnDOss4g4OB
         GOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286362; x=1718891162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1LCLqTQpgjlSACujMB9iRZQRD/4Q4qxBaYK7DnQBy4=;
        b=uhinBWzxt3lnbh60pZF6uyGmKqqY8eFNY9QCt/1r5rDQ6JlUBMl3kKzzd0iTSvzmma
         Mnu0Yqncye4jv3Nj0Aa21RNUphPMwoMRF7+LPRVIRad4sfEq5fpUFXvKEoXM1wv+ZTzz
         d63x2fBVN1OSiTy2yzbo78hQgbVz1DIOrHt1TsvSmqIbLzQBkjYtk8GeZYBqb9s7oAof
         eo2P1lQsF47wRn66myC6jqp4ILPOjY/FPYh5OiJT8keWbDZ3NF8j1R+y4Z/KTTHLyDiF
         BpJ8VqLJ7b6fkZd1cT36EhQReAOiaC9YscLDj+IQ2gZCexIcxiVLRc6Jdvz30bpAa0/w
         bB1A==
X-Forwarded-Encrypted: i=1; AJvYcCWNSB0DHvR4nKhXMwz/M0c1WS3TDzHEKCT3UFPCVkJfAVPc+kZyagqavCsdfOCyCbZLdOdqh3gTs2SFAQ805aGPRzKWQtEIDI6nQrfk
X-Gm-Message-State: AOJu0YzJz8Dgj0qlU5MDiJ4g+k4W+z5qWGp6EvJxW1mVD2fwxYclw3q/
	sDGFjPcCO1zlEzhKvNjTk5MOl/ygrXGgY2EpBixBr00bsQOrphmG7Vr0hI2xnNdEBtg1Ell+Pbj
	Acwm6CnK6AtVHq9n9geg342t/HvY=
X-Google-Smtp-Source: AGHT+IHzJ/Adcm+S3iQK/vRtS0Wlj08YM9YFWFMFMkj93AANbkW3iZj5+3KJbwCR2LidvL4eCAP+Jg9MfDoGNQQRoBY=
X-Received: by 2002:ac2:46d3:0:b0:52c:9877:71b7 with SMTP id
 2adb3069b0e04-52c9a40b1e1mr3656409e87.59.1718286361823; Thu, 13 Jun 2024
 06:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610120209.66311-1-ioworker0@gmail.com> <20240610120209.66311-2-ioworker0@gmail.com>
 <CAGsJ_4y4sKXbq4_ra9tTD-LWgB-x-HECyouxm_9r_N7Kw2We4g@mail.gmail.com>
 <be85ddcc-88ee-4f8d-9f73-b388f4d47b71@redhat.com> <CAK1f24kWHWL=nT2uDp=GF6dLp9AYuEVr4=ipUsWGK=cf9Qbfbg@mail.gmail.com>
 <CAK1f24k24dEYWsoQ3avPufaL-A1EaudWtscLpc6XeVOdrZFcFw@mail.gmail.com> <59d82010-c24b-4e83-a9a8-0add8ba1bc82@redhat.com>
In-Reply-To: <59d82010-c24b-4e83-a9a8-0add8ba1bc82@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 13 Jun 2024 21:45:49 +0800
Message-ID: <CAK1f24=ZMJoScGc9tz3J3fdu7win3qe8zv8N1N7HPZWODxM8qQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mm/rmap: remove duplicated exit code in pagewalk loop
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, willy@infradead.org, 
	sj@kernel.org, baolin.wang@linux.alibaba.com, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, mhocko@suse.com, fengwei.yin@intel.com, 
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com, 
	libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 9:29=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.06.24 14:43, Lance Yang wrote:
> > On Thu, Jun 13, 2024 at 4:49=E2=80=AFPM Lance Yang <ioworker0@gmail.com=
> wrote:
> >>
> >> On Thu, Jun 13, 2024 at 4:27=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 13.06.24 09:52, Barry Song wrote:
> >>>> On Tue, Jun 11, 2024 at 12:02=E2=80=AFAM Lance Yang <ioworker0@gmail=
.com> wrote:
> >>>>>
> >>>>> Introduce the labels walk_done and walk_done_err as exit points to
> >>>>> eliminate duplicated exit code in the pagewalk loop.
> >>>>>
> >>>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
> >>>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
> >>>>> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> >>>>
> >>
> >> Hi Barry and David,
> >>
> >> Thanks for taking time to review!
> >>
> >>>> I don't think "return false" necessarily indicates an error, so
> >>>> "walk_done_err" doesn't seem like an appropriate name.
> >>>> However, this is a minor issue.
> >>>
> >>> Agreed. As we only have a single walk_done user, should we instead
> >>> remove "walk_done", keep the "page_vma_mapped_walk_done" for that sin=
gle
> >>> user, and rename "walk_done_err" to "abort_walk" ?
> >>
> >> Yeah, I agree that 'abort_walk' is better than 'walk_done_err', and le=
t's
> >> keep 'page_vma_mapped_walk_done' for that single user ;)
> >
> > I just realized that there is another walk_done user, which is
> > unmap_huge_pmd_locked().
> >
> > Could I keep "walk_done" but rename it to "done_walk"?
>
> Sure. "walk_done"/"walk_abort" might sound better.

Nice. Thanks for the suggestion!

Lance

>
> --
> Cheers,
>
> David / dhildenb
>

