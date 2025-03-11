Return-Path: <linux-kernel+bounces-556605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6DDA5CC3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA7E3A1D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBA7260A5D;
	Tue, 11 Mar 2025 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wzv6Xeof"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3961C1AAA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714395; cv=none; b=svJyn+m3HzJMLyrsyzBLiH02/8K3zdc9oahhBhFE31IoBg1JSZXbyh1tZoScaFfgdr8vj72Kq6uzRmLOsRNkiVwVzeqVr1g9NZNv6q+fqYKrMuW6KYUKbAwiSHx9Uf8x9cY8dCFg/m+cCKnDa/hcTbBHdaQzCXPcCBc6rOSQ9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714395; c=relaxed/simple;
	bh=OjFDkLVrdX3WuCWKNtMoTtzrEYy6c6KnWT37occRvdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbYKY2LlVV74cryF614tD8yufiL8K5SBadpE9TAHasRKNVZk7VfFhCUKUYXr76iONgsLctvsipO0Hi0E1OLakC2L1vM5rKqKSoJFRA8gF7gA9nDGc6eTsSxT3kiThldKwGS2GNHbSn3kL6qCttzxrxH9ftA3PodtaN8LtQOncw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wzv6Xeof; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30797730cbdso60884241fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741714391; x=1742319191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXqqH4KEKZGZtmnxGZpVEpu/EwdmYompCY/YmOfeggc=;
        b=Wzv6Xeof/z9/Zt/WBRgkcOXpvmsd4pqsIce3kbyYHUfNRpYQKS+/Y69gR6ZOaXn9bR
         tgxgQJIS3VC9yvbb7KCW8s3L5sQP4g+Kb2BC/kqwzjt+c7qOiwOs1k2G9ZW7bYAUUpH1
         zKL9/pJaH1KJVhPvGKWw6/sBiBThXOe16A4jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714391; x=1742319191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXqqH4KEKZGZtmnxGZpVEpu/EwdmYompCY/YmOfeggc=;
        b=ieXCf2dSDQ1/d7nUiDgXB/s+WnZ5ax7Yj2xpEQOkSwGc8IBQ8vzF3O02MqGH4mDpPZ
         qnGr6ZJN8ByoqLQJjZH+gOl2tE7S1Gra1y35H/6X1A5grXY6/JLcc9ekSbEaf85fGwQA
         svNaofkGo2b4zS42qBrXrpB7LZ4RBxa/CNNZHgy7rRXMG8ov6fqZxWWoFhT9Va9mCfjh
         e0mM4Xp+NUbkaVCtXyRCONBNj0o92yEXmU3692zfP4UY5+NgHj7jUErPDHURZmI2fgOG
         GmnrzhZuuRZJsIelmAHfQ+B/sRse8QGat5sUZPSLElxWDDojzUK/exyPos96C5onbjVX
         u5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVwEKkovcqE4M1ObYcds72e+E2FOB3E5WZZkJj26y0BCUSztTZFqjhkl1XqS2VkCGFgPbjzeW5SMdkc1SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOypAiEEnHZLHMsaB4pfvc8e72SU6LxPbY3wfMNb4uRtE9fL5F
	MCGGozghlRNnninbFLhZiTy7nwkyf3TsMD3I35cUx+WqmSk5oPq3k9gVQL/xlnP7w3t44rLuy2T
	ACepd
X-Gm-Gg: ASbGnct6FGyC3H12Ek2hR2PX33ju4c2aIo2+BFPFNe6zV1yZLpN5hdcQUYKRNHutqU9
	Kvv/4r8tPV3ES7kVcTbjXVJMetxdZvJeXJpR6UCLIE1mQUwSfZgNd/lovMqvo1xyK8okEAALX7B
	6VaZ371xYrasbSmZl2ZRquyDbP5NqTa/cK1iAGuEPEQZcL0nX7QUxd4Xua3/Yqz1c4yqnAVty8S
	UKe187od3Kc3XRfxNiqefofkFJgt0eBLyA2swSCjQlwigiqhEH7COHp2wL5uT5w9HR2PY9bAZFY
	WrxQ9qO5IlMKSp4z6ewfiDCQDJ9ILGq0u8POSgbQCCXqpRDMfIU+68M0MipJr0kyTr5gqxoLJeL
	Avk+HiUIMj0vKkHvBGlQ=
X-Google-Smtp-Source: AGHT+IFsgiBA7MA+dqx4CPaDZpJtDvx9f5Y+/8h2p+jV3M4okS1zQs6a8viqLVPjCWDutCivTP5wLw==
X-Received: by 2002:a2e:7207:0:b0:300:26bc:4311 with SMTP id 38308e7fff4ca-30bf45360a1mr67266971fa.18.1741714390873;
        Tue, 11 Mar 2025 10:33:10 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c3b71sm1847288e87.242.2025.03.11.10.33.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:33:09 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549b12ad16eso233449e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:33:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj+rY70+faS/X5THyFOe5kt501r1OMhgcelqMr15UKMpT6prwyg1kWBAxG3Ncdc1TQUz68JlSV6Bm9pZ4=@vger.kernel.org
X-Received: by 2002:a05:6512:b11:b0:549:38eb:d68b with SMTP id
 2adb3069b0e04-549910b5eaamr7637883e87.33.1741714389505; Tue, 11 Mar 2025
 10:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309040355.381386-1-tejasvipin76@gmail.com>
In-Reply-To: <20250309040355.381386-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Mar 2025 10:32:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VBZjnVQJC2mh9C5_mF3Oz_qXmBB=Sw3B-6W=qDAsbWrg@mail.gmail.com>
X-Gm-Features: AQ5f1Jpc46SQirm9tGzN71Qne-KkyVQnyxsbd4VDLmdc6G7lUbX6SjygOF_K9bg
Message-ID: <CAD=FV=VBZjnVQJC2mh9C5_mF3Oz_qXmBB=Sw3B-6W=qDAsbWrg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	lujianhua000@gmail.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	asrivats@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 8, 2025 at 8:04=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> Changes the novatek-nt36523 panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v3:
>     - Remove mipi_dsi_dual_msleep
>     - Change mipi_dsi_dual_dcs_write_seq_multi to use the same dsi_ctx
>       by swapping the dsi accordingly.
>
> Link to v2: https://lore.kernel.org/all/20250307091519.245889-1-tejasvipi=
n76@gmail.com/
>
> Changes in v2:
>     - Uses mipi_dsi_dual_msleep
>     - Changed mipi_dsi_dual_dcs_write_seq_multi to not equate accum_err
>       of either dsi_ctx.
>
> Link to v1: https://lore.kernel.org/all/20250306134350.139792-1-tejasvipi=
n76@gmail.com/
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1681 ++++++++---------
>  1 file changed, 821 insertions(+), 860 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

