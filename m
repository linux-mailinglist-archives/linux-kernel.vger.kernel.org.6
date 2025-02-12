Return-Path: <linux-kernel+bounces-511532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0670AA32C51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6D51887307
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C6A21A424;
	Wed, 12 Feb 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eOC2Zwzs"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D451E766F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378925; cv=none; b=DK1AFGGv5stbEMfwA+5Q8MQ8xnQ1p1JHy+IFDG2Sb6T6GQWWmFUUNRKO7ut5nm+DZFWuR4YeSxMwmMb1dAEyStbevK48i4NABhaENP9/ArlW4AqEewnLVbjE2YAGm4w9UPcQCCE4Ar/wTB60a58N85oDpjyy3q2/z2Qj277Cr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378925; c=relaxed/simple;
	bh=dqTOM9C16tYEOgJgRBbtam7BsJCZdibciwKGZ1YyhjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YctPMHGrBBhxtOWc466BxKLgVb+Kn5ukK+hUGAGrbyhz7vRi54c+uHc3TM67tdy4C6dpoDQdOQugiiSCnzX9VgNZn71SPuGQQIMeDWMiSSIbD7TBxpC/tqj99QmAydyS7yLmXUu64syz2vyImfkl2qehtHNLLiMbXa+9uZTgKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eOC2Zwzs; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54504bf07cdso4964077e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739378921; x=1739983721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyHRmSw+0ICK2sEynOaKxLDRuSl/oG4kVMvohYL0VYY=;
        b=eOC2ZwzsL2a5rGb/Xis5kMl4eHEjA3BCvwgWSPDalyjMJlRWTftf+HsTI7zlMA5qyi
         z040s0rgebbyiTXi7DSLgq0Si697/qFwunbhlG5ku0+qIyr2uZ3VqrjhKO/4OD6jnD4J
         EJx6Qvy7EbvkoI5LBhWEjUIuO4ywQVmtfCWyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378921; x=1739983721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyHRmSw+0ICK2sEynOaKxLDRuSl/oG4kVMvohYL0VYY=;
        b=ds1ysyKqS0hfjJfNTDmp/Wzcvn3FfSFTvWRP2fj70+O9hG+rpi1hWeGWII54QaCskX
         iMQKPmyoAGX5wFZvSCdOHXOfgr8yOk2Rm8aKGmSnqGnTrCJc2PF2F3H7W3VbDhuaiu28
         mmv3DE/K8QdhdckZARHadx3oCKFm+isFRvqkYPDJVT+5icnEYcaxUN7jG7HE38BaEoF4
         UuLRo/YHiig5XteMVUePYbmKkC/L5+3sMW4h40r3MFN7vMhEKzeEjQKXzQy615Rx/9S1
         fVPnk/Tv8MJL/VJoBOIlXsgIPrueor27d9UZckr0hCYv0bqgmS08Pk2ee6tBqbQ7GPcN
         CVuw==
X-Forwarded-Encrypted: i=1; AJvYcCWxzyELFbda9eeJ5kHHvVnr5U0PGn008OwPeZ7couFdzbDyI7YUvbkAuhULl8TXcwjn+C3HKbBD+putYHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlw9EbWxEji0B8tQac77PQ/O6LkC8Lj2oueasMprcfY6l5Ct+
	Rzw5deAPBZaCA04RKMpIBApzwD6cTnYgDUNOHzeeRRynKZh/EyUruvfMobbrRjyyNImzmamVQBh
	QPwNI
X-Gm-Gg: ASbGncu5M+MOdp2ht22NSZG/WmvlFwxC6MWQUOvQWqHzL3psPOduYLWaewrZF1Hv/1P
	GDCxy6iAcpEpd3ExHEExN3FG3NvKkXkzwj71IA/vYbbC922MF8vX68qlpEgXsNTAy2ktcO2H0sT
	z51jcwEP2DrrNIfgqSwftM2eUFMQK5eNitLwWcCbtLNoxMJPSEM52hNpxd2ef3spwTn2oItVF6o
	ZQVUyk07uXDBhX1JgGmGytI9eA60fyKKMY8S+ewrux3wmf1bxn33dFAV68D0yGnAoCwnEYhYR6k
	F7E6LtfzxojcggR3256yniCSDyrVEKOrfsMXSxCgqQcWkRcJbFCcSQhyFiI=
X-Google-Smtp-Source: AGHT+IFOjKCWhyAhA0SkyzBjzgzIRARSQyQ2IDCr4QPqd3iDolbaDnZsWIJp08eXMh7rikjYR1QF7g==
X-Received: by 2002:a05:6512:ba6:b0:545:e2e:842d with SMTP id 2adb3069b0e04-54518109188mr1272010e87.14.1739378921533;
        Wed, 12 Feb 2025 08:48:41 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54504e74823sm1393925e87.154.2025.02.12.08.48.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 08:48:40 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30613802a04so68371921fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:48:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFxU8cw7PWGxqn5B3MR6uBeJKBT4Xte2XiPXgIZel3+Cyka14tgUvheOfdBSB93m6glnBmtFf678FvLUg=@vger.kernel.org
X-Received: by 2002:a2e:a805:0:b0:300:3a15:8f22 with SMTP id
 38308e7fff4ca-309037d6f62mr16328151fa.21.1739378920063; Wed, 12 Feb 2025
 08:48:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210092342.287324-1-tejasvipin76@gmail.com> <CAD=FV=WwbNAhiMWN_4PRODByWScdnqAKk7yvGP2KJSoEzvo=vg@mail.gmail.com>
In-Reply-To: <CAD=FV=WwbNAhiMWN_4PRODByWScdnqAKk7yvGP2KJSoEzvo=vg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Feb 2025 08:48:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VENY6b16hYP=E78KjAYPzvT+Bim40rcvYjhPdOAk24WA@mail.gmail.com>
X-Gm-Features: AWEUYZnATny9gDH5jd4FFZMoQQDTKHRshaBDolOTR4ufydHKrJxGl6YS56Vgw9o
Message-ID: <CAD=FV=VENY6b16hYP=E78KjAYPzvT+Bim40rcvYjhPdOAk24WA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: visionox-r66451: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 10, 2025 at 7:28=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Feb 10, 2025 at 1:24=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.c=
om> wrote:
> >
> > Change the visionox-r66451 panel to use multi style functions for
> > improved error handling. Additionally, always drop LPM flag after
> > sending init sequence.
> >
> > Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> > ---
> > Changes in v2:
> >     - Fixed visionox_r66451_enable to return dsi_ctx.accum_err
> >     - Mentioned changed handling of LPM flag in commit message
> >
> > Link to v1: https://lore.kernel.org/all/20250208051541.176667-1-tejasvi=
pin76@gmail.com/
> > ---
> >  drivers/gpu/drm/panel/panel-visionox-r66451.c | 181 ++++++++----------
> >  1 file changed, 77 insertions(+), 104 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel: visionox-r66451: transition to mipi_dsi wrapped functions
      commit: f4dd4cb79f9ec3294e5100223ed90d8ae371f168

