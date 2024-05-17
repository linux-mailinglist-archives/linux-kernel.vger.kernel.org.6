Return-Path: <linux-kernel+bounces-182394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93868C8ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFBE1F2529A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236A913DBBE;
	Fri, 17 May 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hG4WayiG"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4EB63417
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966392; cv=none; b=rBu3inBkAyL9wNDUEvLVNo341ADAOhUrid4/H1lHsrvHPdXWVYqbl9CE1VZICvG28f+1ieqjFvI+sBQS7TznLDowYu8Y6ymms2+/pasMUM0Owez0m5YYfn0siTU4WqLOa0t7LOdNSAQ0XMuwiY5QeCuz+oFjwHy7iD1d1wSuAX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966392; c=relaxed/simple;
	bh=9lqaZiLXVqQKz34hEpjrAlMK+jXub2IrwnL7zPj4nzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hg/oIlqaL8OYAcD99gKiF967XU3deTkfEQXC9SEm37VNQemUD/kr3Kdf1dLj6uXqoBuVVif/Tv384NOMI/FydKi7SYZtmROcRXYbFL8SU/4/kvdhzRQetJCQXqqIxuWjMQuPPnVix4rxsS2XbHRvD7DTtc8fTj3G/m3tzO7RmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hG4WayiG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43defa9d4f9so3919451cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715966389; x=1716571189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvj+oLK1oxIlGb3spxeAPsEXiUc18MOxDzwp6iBcUmk=;
        b=hG4WayiGYyPDiVBlmxymH4zHBC63q5748vMAbjKMeb/wrx8kI+sWf6OPTSCU/8km+T
         zJaV0djUFuNaCf5tmjiKKMvDq4uRBpq3wTa1PWWBTMAZxmWkbDg+fIzAXSxBDcC2F/5I
         nmxmWdq0d4bTLx3KTNMRCZAvbXNbXbKBDnNqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966389; x=1716571189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rvj+oLK1oxIlGb3spxeAPsEXiUc18MOxDzwp6iBcUmk=;
        b=rO2DptnNLR9Kdtnl52zJv8ZI9INvQDAtpB3aCZWItGq+SxWQSNqIirENoKI2zqiW+M
         ATgCor5sCKr0mcGDio/+B6UvZIHNAJrc0Ov9ISGIZQ7wYvKAcdObgrkcCTLkGGiIlFcR
         huO9/03b3ZIb3kYQnHK4x5v20swigSn0EAgpoLTTEGZVdBWAGfstGJ6iV381TIXMowop
         zPqCJEVkE0S2PGm3NvxhJx3FFCyjsmUq4JddpsC83nKxyyGrZcOilQLYqnGM0JaCXKm0
         7JvY4+BjyfpIEJMfN8xNA0WxANAEoU9NqKPR7tchP79YeZtqfIEmpwC87HzR0np0AUBc
         qggA==
X-Forwarded-Encrypted: i=1; AJvYcCXKeeznxoS4S2yY/OLPa1QuuCwEn/wIq5pURSsXCuJzI5L5r/izmHzCKXT1d8dmMGZ80ICnCp7FAdTRdIJsgkaZ/0kX3uPhKKdM0pBk
X-Gm-Message-State: AOJu0Yy/JbavBZDUyqC63zzQSvk1gVDsgKJpGFKSdfl6DTip2zo/DZKC
	pFNQkaNus7hKo1WcfnapzFGwYtL6ulVmEOKIc028F4Kdhp0wDG4bw3JCTFMBLmjNZJ+avnde1Ns
	=
X-Google-Smtp-Source: AGHT+IHKBMpx4AlbklRZQ1Oz8s/lGoz8BcrdPJUIwMr50qw5wfvvALbarAF+UvpNr4rHpMOk90gAog==
X-Received: by 2002:ac8:5a13:0:b0:43a:ed8b:75b1 with SMTP id d75a77b69052e-43dfdcd70c5mr290712711cf.43.1715966388849;
        Fri, 17 May 2024 10:19:48 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e1a4c85efsm68162221cf.93.2024.05.17.10.19.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 10:19:47 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43dfe020675so23371cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:19:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsFl9XUJ0szCfUgXPJjp7Tu9Ithjowz5apRDiQg8LILTBBe01q6JW3+m/N7Lwx2ChJshfgP4IDmtJS8tTi0naWFGRpta+084VumEE2
X-Received: by 2002:a05:622a:410e:b0:43c:554e:b81 with SMTP id
 d75a77b69052e-43e44c22ee8mr3422401cf.23.1715966387328; Fri, 17 May 2024
 10:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513161343.1.I5db5530070a1335e6cc3c55e056c2a84b1031308@changeid>
 <20240517163742.GA525@willie-the-truck>
In-Reply-To: <20240517163742.GA525@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 May 2024 10:19:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UEXjD=w41Hj_gE--DXhkSjNdfPnkc7X=FrZJ5_90Jq0g@mail.gmail.com>
Message-ID: <CAD=FV=UEXjD=w41Hj_gE--DXhkSjNdfPnkc7X=FrZJ5_90Jq0g@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Don't disable next-page prefetcher on
 devices it works on
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Stephen Boyd <swboyd@chromium.org>, Chen Lin <chen45464546@163.com>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 17, 2024 at 9:37=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Doug,
>
> On Mon, May 13, 2024 at 04:13:47PM -0700, Douglas Anderson wrote:
> > On sc7180 trogdor devices we get a scary warning at bootup:
> >   arm-smmu 15000000.iommu:
> >   Failed to disable prefetcher [errata #841119 and #826419], check ACR.=
CACHE_LOCK
> >
> > We spent some time trying to figure out how we were going to fix these
> > errata and whether we needed to do a firmware update. Upon closer
> > inspection, however, we realized that the errata don't apply to us.
> > Specifically, the errata document says that for these errata:
> > * Found in: r0p0
> > * Fixed in: r2p2
> >
> > ...and trogdor devices appear to be running r2p4. That means that they
> > are unaffected despite the scary warning.
> >
> > The issue is that the kernel unconditionally tries to disable the
> > prefetcher even on unaffected devices and then warns when it's unable
> > to.
> >
> > Let's change the kernel to only disable the prefetcher on affected
> > devices, which will get rid of the scary warning on devices that are
> > unaffected. As per the comment the prefetcher is
> > "not-particularly-beneficial" but it shouldn't hurt to leave it on for
> > devices where it doesn't cause problems.
> >
> > Fixes: f87f6e5b4539 ("iommu/arm-smmu: Warn once when the perfetcher err=
ata patch fails to apply")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
>
>
> Just curious, but did you see any performance impact (good or bad) as a
> result of this patch? The next-page prefetcher has always looked a little
> naive to me and, with a tendency for tiny TLBs in some implementations,
> there's a possibility it could do more harm than good.

This patch actually makes no difference on trogdor today other than
getting rid of the scary warning. Specifically on trogdor the
ACR.CACHE_LOCK bit seems to be set so the kernel is unable to change
the setting anyway and has never been able to. We are working on
figuring out how to fix the firmware and then we have to get a
firmware spin before we can really see any changes. I'll keep an eye
out to see if performance numbers change when the firmware uprevs.

BTW: any idea how big of a deal these errata are? We're _just_
finishing a firmware uprev process and there is always pushback
against kicking off a new one unless the issue is important. Given
that we've been living with this issue since devices shipped I'm going
to assume we don't need to rush a firmware update, but if this is
really scary and needs to be addressed sooner we can figure that out.

-Doug

