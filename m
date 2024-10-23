Return-Path: <linux-kernel+bounces-378110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1E29ACB87
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18F61B22ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBB11AD9EE;
	Wed, 23 Oct 2024 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HWKPvmCA"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4422E56A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691294; cv=none; b=IFtruzSO6QU52irkWTv+v1yUcuCKBOhxrRz7Wy3HXwDdvGI7SoJy8MW6epfXlbiQhlo/eff55VdFL25qAW5vPiTIoIvtk6nJ9cSIk9YmU7x35GBQGhfe9Wr050nyKCYZvFT7LCrZnNarKwIoKLmnFP7u94HxunTFtwGqshthLyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691294; c=relaxed/simple;
	bh=bjMKgStpvBPW71++ROSMQxSE4dU5lmCIDA2k1RaLo7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUJC7tvc4JhxAntXBDwKUPu0sY/fWmquZHjboRvyOPisl7tz3RYxzviSXumVZZrIDueICOyx+KYKrTn0HhjmdFWdXD3cfkW/+m2RZESgY733CHmCFgnpPbN37FZP/ueOJE83Jy7sVVFeDAB4abMkegFvXr5IXLoOlIPQaXPyQJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HWKPvmCA; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fd057a993so2259214241.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729691291; x=1730296091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1ErG2T9UQjEKEnbXbgxig/MiNVygt+6QYl0dpxRA+w=;
        b=HWKPvmCAnBMY9j1X0wT2OgpRJ2SwaT0hYQSc5nJzPB+/hyQ3Il8GI+f0p7oAU+eUPp
         DcYGepFlDrqB+TZqkuhFH3c5OsEqvRC2ePkwLu1YRAV4wclh335z7CYA3XXRdSl8ubzx
         /1I3iD4y9vgmEZqD171VlhX3aZl5pSP/83K7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729691291; x=1730296091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1ErG2T9UQjEKEnbXbgxig/MiNVygt+6QYl0dpxRA+w=;
        b=V2Mf94IoffCtYN13Z47/eEc2I+yhh5PivT8/d4tM3NUaDxgfNzuUZ2WPHRiRrIExBV
         q4w759xWS1z/gF7CbEHdyGheNBrP1Qfh4Cs6hmwMk1VgiiE3HtgzIsO8C/waaNc7n059
         BdWAa+KRVEmnNSL2N+Pt0egTkmQKSbRyhzUfH2U9gMjdnZtTGKV1vkzyTDk7TpGtDpHR
         //knBHyjmqpWlgYXsbBqfIfllZ7A7fG1yJhks5I1nhFrYfgdWvHU2+NFcK9zewlEb+s3
         W1mldMIkxxd+Qo4uh8IK09mk4ts/G7jHIvtxzLvIgjd+kAmLwlAixATv2BUuEujGc+KN
         s2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEFmKhW59z2Wr0bzt2ySA6YayRYhgh+zcNRCIOJZoibdOV5cXTe6Q6ZGM5mXyPXkHF+xDtfe7GDxo/5VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1SDU2wSd4JzxUIRMkcYrzPbBtW+2yTXHcjHap6f2d+jcSl2n6
	AqT/Yj8l+lhyJ0GR/d0gZ03VZeXVruEyfsBsVmL1M7JYbnB+g5ma6hgB6gzUlrQhIXrEHXBN1y2
	7/Q==
X-Google-Smtp-Source: AGHT+IFQs1ZylY40+3fx2mUKOGPz0q0B8ZnncYnIdJHEuuhMFgTkbul9a1B9wZnvDNdEKGpqvmN0MA==
X-Received: by 2002:a05:6122:1d42:b0:50a:12e4:2618 with SMTP id 71dfb90a1353d-50fd01b9273mr3294926e0c.2.1729691291368;
        Wed, 23 Oct 2024 06:48:11 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50e19e0dc5esm1024326e0c.7.2024.10.23.06.48.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 06:48:10 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fc0212a60so1791894241.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:48:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiws88PgHHolcbtFtWOXfTOt/I/kd28fpLbhoA/AIIu7ZhzfY7a50pUR0lqamut9lEu5tL3g8B7y+aPfA=@vger.kernel.org
X-Received: by 2002:a05:6122:513:b0:50a:d1e3:82f7 with SMTP id
 71dfb90a1353d-50fd031e55fmr3184053e0c.8.1729691290235; Wed, 23 Oct 2024
 06:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023102059.512352-1-fshao@chromium.org> <9b12aaec-504c-4e3a-a606-240341d8e0d3@collabora.com>
 <CAC=S1niSXkCTLXeCv-0sQh4AQmv6eKm8OH_3yH=TeDoMVz72OA@mail.gmail.com>
In-Reply-To: <CAC=S1niSXkCTLXeCv-0sQh4AQmv6eKm8OH_3yH=TeDoMVz72OA@mail.gmail.com>
From: Fei Shao <fshao@chromium.org>
Date: Wed, 23 Oct 2024 21:47:39 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng=ZLB+vB=kNywLGMdeN1RRted0j6d-fC9ANoyu=ni3Mg@mail.gmail.com>
Message-ID: <CAC=S1ng=ZLB+vB=kNywLGMdeN1RRted0j6d-fC9ANoyu=ni3Mg@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mediatek-regulator-coupler: Fix comment
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:03=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Wed, Oct 23, 2024 at 6:40=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 23/10/24 12:19, Fei Shao ha scritto:
> > > Fix two minor issues in the comments.
> > >
> > > 1. We balance VSRAM voltage based on the target VGPU voltage, so the
> > >     comment likely refers to VGPU.
> >
> > Function `mediatek_regulator_balance_voltage()` refers, as stated in th=
e comment
> > located at the top of its signature, to "GPU<->SRAM" voltages relations=
hips.
> >
> > So, we're taking into consideration only two regulators:
> >                    VGPU and VSRAM
> >
> > The first comment says:
> > "If we're asked to set a voltage (implicit: to VGPU) less than VSRAM mi=
n_uV[...]"
> >
> > ...so, I think that you've misunderstood what the comment says :-)
>
> Let me make sure we're on the same page - VGPU never goes higher than
> VSRAM (VGPU <=3D VSRAM), is that correct?
>
> [ min VGPU, max VGPU ] ... spread ... [    min VSRAM  ,  max VSRAM    ]
>  (min_uV)  (max_uV)                         (vsram_min_uV) (vsram_max_uV)
>
> The longer comment is
> "If we're asked to set a voltage less than VSRAM min_uV, set the
> minimum allowed voltage on VSRAM, ..."
> So VSRAM is the subject here I think? Because we "set voltage *on*
> VSRAM" based on its own minimum allowed voltage? We never set either
> VGPU min/max voltage to vsram_min_uV?
> And it's attached to the line that decides vsram_target_min_uV, with
> the maximum of (1) vsram_min_uV (i.e. minimum allowed VSRAM voltage)
> or (2) min_uV + max_spread (min VGPU + spread)

Ah, I just got your point. Both interpretations can explain..
I linked the "min_uV" in the comment to the one used in code, which
stands for VGPU min_uV, so I had the impression that it was a typo.

Regards,
Fei

