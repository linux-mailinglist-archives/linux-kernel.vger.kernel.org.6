Return-Path: <linux-kernel+bounces-276694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57D94971E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A41C212A8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB6A6F073;
	Tue,  6 Aug 2024 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XCkcFEVU"
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF682B9C6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966760; cv=none; b=JiKbaQ7wzhWFqh8z2MX4sbJNVWuXUvXKrHjHFwPNWRKKArEpY6gP8sJYSnWEGOlQZ5/TUl5jc7Ic8qvS1Dx9kPurGG2bC3PAaf/tcEaZ8WGC3iJd0TsJlfTkU9aIK1Hp+RxV41jHpNVdk2Wj/tb/F3zLTbNBmYcMJeZYuWlfLzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966760; c=relaxed/simple;
	bh=6sEhV/UwJzHAc0B/xdv8Aikpej2a67uW84ZZ1V4NXJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8gT3mFKP8LPrVtbkiMak5O07WO4HQPeR1Fr9bgYrC9Ixd6b+B3Rem22fToJVO2t2jg+OjeCroyveL5PEi1v1F9DR69+UXV5/WEpXpqmsZfkuAPNpVWm9Isn6dXliBKmChTQG8GAPXSEdKK0xXSDi3/jkwEF6/BKQmpbbcqoNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XCkcFEVU; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-6b5f46191b5so5000786d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722966757; x=1723571557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W2l2GkWTnRzvV1UUGjKmQpo2CkW6GJdcOBrie/UAMQ=;
        b=XCkcFEVUyu1DCSDPHmAG9QRpfFjXFJJV4tnNRR/CsdlLr2u4yBbvx/eTAeacwXtX7k
         ApgLWn4NpShyyjgKKWIGyRR2v0nKGzP9efC+jbDaN+gZS2wp/F8t+8V1hC9ohkTegd6/
         iq2a4YVvoAUdm4g2vnDehcoW5uxFW5I9XVbKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966757; x=1723571557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5W2l2GkWTnRzvV1UUGjKmQpo2CkW6GJdcOBrie/UAMQ=;
        b=EWZei/Qp0LQxRrUy40Nglk5RctDl2bSF6rZmLbyR+hLUYX+hKEt8W5vR72FysWQvxp
         Wtv9kf8+TP04u7wqI8vs7wMlmw9fq6wCdxIzWNz6Q0R6ggM9LQJsszhc7NikOw8yqhz1
         zbRtFVZi44OiKtYnncfGYshhx4gxsIoyGXk1q1MlCC7u/2eh0yxpc/SDaEhSsl9/rR+l
         3/9AHzcKuFVVENwekkuu/RJ41T1E/iALVPP8Tat9rGLy7truCg9NQXiK4tfzwNjIG770
         9FVYrmqSw0xmj5qme4g1GAyfPR9mnqh4WY0VqluzkS5ZItpneDwycbEg/cB99RvFHQXY
         kcnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhSXTaOWpdSQyDfr3e02iBsepjGjE1R56mYODGc9BzKYpnQH0LzS/sKe3NLY3WZfV9vf+kFvM5yyTJWKPddcl5xMry20nSKm7Dvfn9
X-Gm-Message-State: AOJu0YydfCKvJwM4CDgrzyDlY826AtzgmKZnB+DxfT8rBeRcnWE31w5W
	X2qspqMtqkqfhhuvfhAB2gPpjjrDqvW/9ASEQVSLstSKA0Flc5xbDBoyvQ6b9aHgA4FIXutRDDB
	rM2V0IPs=
X-Google-Smtp-Source: AGHT+IHDPimWuX8d7TizmnkH+EkcgGeZcYzVzF+BFAd3NhgGNIJNY9LZWKVLOBcw6983LE7ufSc6Sw==
X-Received: by 2002:a05:6214:4a06:b0:6b7:a8ef:e366 with SMTP id 6a1803df08f44-6bb9833280cmr179732616d6.9.1722966757679;
        Tue, 06 Aug 2024 10:52:37 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b72d9sm48345866d6.60.2024.08.06.10.52.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:52:37 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44fdc70e695so580841cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 10:52:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLFJVj6wajnX3ZiAxlTu3JyOmNCgc+/c54Y3Alg8ySKVcjXfNUuOeH2gu43BERzCfNJH2HGGTKhHiyn8DbN6M9DnOOvF9AaGHSHQTd
X-Received: by 2002:a05:622a:1aa6:b0:444:dc22:fb1d with SMTP id
 d75a77b69052e-451c59c3f0bmr133271cf.12.1722966756828; Tue, 06 Aug 2024
 10:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729205726.7923-1-robdclark@gmail.com> <CAD=FV=Wo2nVzn6qvwSAFAnrFX4wtv6_ZCVZaL1K_DBBFg9DJ=w@mail.gmail.com>
In-Reply-To: <CAD=FV=Wo2nVzn6qvwSAFAnrFX4wtv6_ZCVZaL1K_DBBFg9DJ=w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 6 Aug 2024 10:52:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMJ7b=2tt6_2oTGFXuL8XcmBxuDtQBoWdf_65YyS49XA@mail.gmail.com>
Message-ID: <CAD=FV=XMJ7b=2tt6_2oTGFXuL8XcmBxuDtQBoWdf_65YyS49XA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: samsung,atna45dc02:
 Document ATNA45DC02
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@chromium.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2024 at 4:39=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Jul 29, 2024 at 1:57=E2=80=AFPM Rob Clark <robdclark@gmail.com> w=
rote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > The Samsung ATNA45DC02 panel is an AMOLED eDP panel, similar to the
> > existing ATNA45AF01 and ATNA33XC20 panel but with a higher resolution.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/display/panel/samsung,atna33xc20.yaml       | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'll plan to land this in drm-misc-fixes next week unless someone
> objects. "fixes" instead of "next" for the same reasons discussed
> previously [1] that the dts patch should probably be considered a fix
> and there's a chance that the dts patch could land in an earlier
> version of mainline than the bindings unless we consider the bindings
> a fix.
>
> [1] https://patchwork.freedesktop.org/patch/msgid/20240715-x1e80100-crd-b=
acklight-v2-1-31b7f2f658a3@linaro.org

Landed in drm-misc-fixes.

[1/2] dt-bindings: display: panel: samsung,atna45dc02: Document ATNA45DC02
      commit: 1c4a057d01f4432704c4dc8842b6e888a91d95df

-Doug

