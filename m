Return-Path: <linux-kernel+bounces-570548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE9A6B1DF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AB3488658
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2322256A;
	Thu, 20 Mar 2025 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUfAhmA7"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3420215173;
	Thu, 20 Mar 2025 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514908; cv=none; b=biUy3Omd+Uf+yDPtS4Ob+DpUx2EeJH+uOQqjXWMmGWjeL1M1yErT9HJDHOmwEcHWThsB8u8Q3ae4/GXGFjFdPnnWOw837StZLLMaoCFaeQ8mANBG/ZUBGZ+0+B3fkqtfCfl7/hphnK/wwKhAXBBPmCCpCx8AnrRqnX6wtJbqLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514908; c=relaxed/simple;
	bh=AxZkezrGAMX+pdr5euJkjZ4La2uvoa+PlC/XIA5YGqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmVBwu9OJbIUYEgVwIPM5Hv9Szr94QU9K6RddIr7xWjnLNdF5AL+mImN65SDi2hIvfg5RD58XC7+HbUHNyGuii4p9zJ4KhuL9VIECduqlc1Aq+A9CGw4+Nk7bui+5VXz/21y8iIpshc4BucCUS2yE0QnvlyuEchz2T5+2e3xMCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUfAhmA7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff5f2c5924so318524a91.2;
        Thu, 20 Mar 2025 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742514906; x=1743119706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIVIdC5d/C5Rmy+h10dq/y0QQVGBAirXrpPQsEqFxPU=;
        b=lUfAhmA7LFanJuJ/bEf4bG+hqsh3m1JEATwGG0c5i90211QhyOLf772MxPTG/gc5tq
         A/ANlueANYcG33X808R5Eut0yKRmLejLSlswhbFNTcKb9VgBH7aCXAT9jk1F7JW88Ae+
         9Ua4soyjPsZHWL+vfNKU7QFPdN30+Xe3sdlglGr/3ey5Dpyh8ICpT+9+PRTAzZmqdPOb
         j+1IbwbgEuzCjlqe5Aj1ZFOBR34nhLUPmPdbr7FQLv3gb631LCyZC5mi5LXJUBRubvQI
         jdX6r/LbWV7YlCqcxPLua4LS8CE32lysy4dKtUjQ9N4o/PmB4qnJNkkDuFVEzJ9uPdow
         U0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742514906; x=1743119706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIVIdC5d/C5Rmy+h10dq/y0QQVGBAirXrpPQsEqFxPU=;
        b=wxOUk7QXLQNmJldhsJ7250ozKIncjDARrdnwUTfnXQ/+zjoZv6D+63aZf4EVnoCV7V
         GiMeo6Edm2e9DSWQ92q+2ave5VAc8JHWclxbak34EzKKxHVX0ymyJVPJL5T1kKK3j5sK
         48mEXdoiAdg+HNcxBl+15hksKFrC0Kueqy1HYugpabzwoZ60wbXvDZ1ZfnGcZ7Gf7/MS
         jqLuuqH1sDa+RZtdenWE7P2/qAiG+14hl39UKTvfzYba90pqkFsTJePp1xzzKB3E6iwX
         NmYGal9tuBqxcOUoAeoSX/fGS0g1+p31F8MbGfMwK3OdDXFR4JDE2dRvXEqEhYC1G6pa
         48cg==
X-Forwarded-Encrypted: i=1; AJvYcCUDFbsrK9OHHCSOkgrryEHqDMpbgQWtU0ykBVJokMUyl9YhHdvVSbp6YKkEJ0yhDW/BKhAboPnM4eo4PWRY9Xo=@vger.kernel.org, AJvYcCVVmImtT7rdPG06wsoS3Wi9RWJPT5rD7pmLFkLfrFthXjrtIg+XixFiy3fzvlzGto59CYSEvgsVAy07Qu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMHx7jyv22gSu2LgEptBxIuCGdoXq94xTHw5ynROv2g6gGetj
	MOmoc6vv9XyZImUQuafaYKPweJKOUaG2dwhe9n/5BAiTG8AkNnbo2zffAYDaSuWIwNY0/2PrM7e
	fQFJl7XXzsjC0da/stcyt6bewzOQ=
X-Gm-Gg: ASbGncsP8iybRO1EikIO1R8/39ZLWIRhnK8dVRbun1Qcs9dR7//MQJf1Zv6Ofl/c7TZ
	yHPc1IyhY6dVsypefG9XjEJZi8UPGGxppSWw6BjbvtW2Uzv8uzeYOwobtwJzy0Qrhy+aa8tAar5
	XUBow7j6ROwyVgtgSfDN8pWTpPWw==
X-Google-Smtp-Source: AGHT+IGfdHlnzRHYSIHYYgHMKPdlv2H/Ji4j0FUvm66nHeooeYNFFQ89NWgA6dQ0Gwrv9F54A+bz7TOyVntbxcbywHU=
X-Received: by 2002:a17:90b:1647:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-3030fb1fbc7mr718879a91.0.1742514905986; Thu, 20 Mar 2025
 16:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317185345.2608976-1-abdiel.janulgue@gmail.com>
 <UiefwZ9WcVV7q7YyERsbNIYqOxTWUWEO9aZNxThH7uRFkjE4LDSUtaVdiLeShk_JYe5RJLD5MgFC9IxGUuzTEw==@protonmail.internalid>
 <20250317185345.2608976-3-abdiel.janulgue@gmail.com> <87senajxlv.fsf@kernel.org>
In-Reply-To: <87senajxlv.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 21 Mar 2025 00:54:52 +0100
X-Gm-Features: AQ5f1Jq1ThF_jw6pT2v6peIUaC8tVEOnl1vZNqKRtE1gyTKcmgG-a1i82J0xr94
Message-ID: <CANiq72k_2dknw9CWj=yxMeBBrvMjPp5mhu=H++BP_wTVCHtnew@mail.gmail.com>
Subject: Re: [PATCH v15 02/11] rust: add dma coherent allocator abstraction.
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	daniel.almeida@collabora.com, dakr@kernel.org, robin.murphy@arm.com, 
	aliceryhl@google.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:13=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> The wording of in the other doc comments is different than this one and
> the two next ones. Consider aligning them:
>
>   Hints the DMA-mapping subsystem that ...
>
>   Tells the DMA-mapping subsystem ...
>
>   Indicates that the buffer ...

These come from the C side and are copy-pasted, so I suspect that was
the reason -- they may want to have them in sync, so I didn't touch
them.

> I think it would be nice to have a description of what a coherent DMA
> region is here. From Documentation/core-api/dma-api.rst:
>
>   Consistent memory is memory for which a write by either the device or
>   the processor can immediately be read by the processor or device
>   without having to worry about caching effects.  (You may however need
>   to make sure to flush the processor's write buffers before telling
>   devices to read that memory.)
>
> I think consistent and coherent are used interchangeably in the kernel.
> If so, can we settle on just one of the terms in the rust code?

Abdiel has the diff ready for this, so he may send the patch (or you),
but for the moment I decided to minimize changes -- up to the
maintainers/reviewers now :)

> > +// DMA allocations potentially carry device resources (e.g.IOMMU mappi=
ngs), hence for soundness

Nit: I think this should have a space after e.g. or a comma -- I
didn't touch it, and it is a TODO anyway, but before I forget I
mention it here.

Thanks!

Cheers,
Miguel

