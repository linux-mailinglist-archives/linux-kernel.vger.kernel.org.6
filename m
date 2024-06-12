Return-Path: <linux-kernel+bounces-211707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED429055C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87926B21EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC417F389;
	Wed, 12 Jun 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJ2//WY2"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819417F360
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203960; cv=none; b=hs7KLcTMEX7ZazyBASK8aAagiwoUYSV1yEQBq8qU/1cLbIzvoG6I46xUTxXeIXCTirD9ENNQO0Hv1OpLbP2xeWQhfu2aSQ/9ry2eOskrw9TIi6yFgFU2jbUuh4vQraLmMCNMxDpmsnCnfHEFcYWNEAK2XMwLZErxGMSKm8t710s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203960; c=relaxed/simple;
	bh=QXLK14xztxRqSzKwZY/aZojpgAVTJffJ6v964d5Zw9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvEeKENsP2SjNruAbJNiiSehcErA6EEQtlkuyt37tb8yeyMChgDrAQsw9KC6YocmsJ2OuChK9obf09pXj1nv+IhlsH2zluvrqu0eSDQTA36i0KT27tZ3nP50XIOqJHArVpvlvB/nVeq7ktYaQHxYC10IvD/sTcmy+Lt5iNDCjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UJ2//WY2; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d218ea7750so1350305b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718203956; x=1718808756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlfyFCkUVCs8ONQQdxaEn5ekXCqtc2aYs760svQn/CM=;
        b=UJ2//WY2mwOIs1wNTuxs+ziWaK3nUGQnihOzb9NiWwueFjotACEsOwwbs8td4W/ndQ
         RlXPjyVPLytBTUVg2hStX3N0YY2Se3rZhz2NCdM9m5nqHBgTS2WHlmK9cKDNybK3bNQC
         mOvXXkUOdjqwU9wIxbxdXuxzLJFwnnnuimnhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203956; x=1718808756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlfyFCkUVCs8ONQQdxaEn5ekXCqtc2aYs760svQn/CM=;
        b=SjSr7NxrLp7zQOBq1rYd/dD5xd8hljvGqFSEAnp3qAu7174OHkywFsqCuYUPrNFWF+
         19TolfL4gFrQbd77/LnjtMT+Elj1WIazWOlSeuHfLlQDZowYutMT/U/TuHVH39Umq6OT
         ocN0I3KuML58o7BEQxTz0JGkempElxaq/bWg6F6N8sevtUn2cJT5e/9whDmNX6f11BMH
         2QIHlID0DWDPVRPuCJS9/rXyQ8W2CgxmEBlAb3OTDmM2qMSqr6vl+/HIPTleZl594YoX
         SWJO63TRKkt7eg/Qn/RyaTNZalI+BYUJQn9QJq6rO/jlp1ot5eZoiZRwyi7YwTjOZCc8
         D9bg==
X-Forwarded-Encrypted: i=1; AJvYcCWIuT14rbvvbBRtzQ/jP1ZudFeAsdSJmLsnSG8dVt7DhsJcScVCnjqobBg2XQbAAffRGTMocRwZ5g171YVjE8H2KO/YKW/uGumqpsHV
X-Gm-Message-State: AOJu0Yz+H5TYjKiuMfbWdekSBbq5ba1Dp0wxIm6PSdLycKx/ncoml0Y8
	+1ENfBeExBbhX/OOzECtbII3KuzLElr898pogNxrcHc/spXVR+Er3KaUZyH2rPPY2dE1ZLO8/A8
	=
X-Google-Smtp-Source: AGHT+IHxdThS+anZT7idmREL2mZhRWFzWA6TB1y6N2viC79Z+2weH6NgA+CmLoJ/Tp5EFWMfAnEb6g==
X-Received: by 2002:a05:6808:1207:b0:3d2:1740:c811 with SMTP id 5614622812f47-3d23e0377a5mr2370624b6e.35.1718203955956;
        Wed, 12 Jun 2024 07:52:35 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4415e6ce8d4sm3687851cf.10.2024.06.12.07.52.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:52:35 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4405cf01a7fso345131cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:52:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRMdIE3jxh1bhEOYdFixfUlIhRM0QNVPgxYM0+vPbtB3yuBda3cl37t+gr6So5/qBI19aEWLv1YuD4N9O1o3E3Zb2TB5/0LyJgzR0q
X-Received: by 2002:a05:622a:514d:b0:43e:cb4:1d10 with SMTP id
 d75a77b69052e-44159205ccfmr3828581cf.14.1718203954512; Wed, 12 Jun 2024
 07:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612133550.473279-1-tejasvipin76@gmail.com>
 <20240612133550.473279-3-tejasvipin76@gmail.com> <CAD=FV=VTEzSyTHm-YBwneBgpohK8uu460DER-GcsQWu-z9hJsg@mail.gmail.com>
 <9beb8011-cb0f-4694-87e7-d4c02de80cd8@linaro.org>
In-Reply-To: <9beb8011-cb0f-4694-87e7-d4c02de80cd8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 07:52:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Udsw=XCR204A8QGwVSAxyprLCrrOgmZf+pU+8m-7sQ0Q@mail.gmail.com>
Message-ID: <CAD=FV=Udsw=XCR204A8QGwVSAxyprLCrrOgmZf+pU+8m-7sQ0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mipi-dsi: fix handling of ctx in mipi_dsi_msleep
To: neil.armstrong@linaro.org
Cc: Tejas Vipin <tejasvipin76@gmail.com>, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, linus.walleij@linaro.org, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 7:34=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 12/06/2024 16:21, Doug Anderson wrote:
> > Hi,
> >
> > On Wed, Jun 12, 2024 at 6:37=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail=
.com> wrote:
> >>
> >> ctx would be better off treated as a pointer to account for most of it=
s
> >> usage so far, and brackets should be added to account for operator
> >> precedence for correct evaluation.
> >>
> >> Fixes: f79d6d28d8fe7 ("drm/mipi-dsi: wrap more functions for streamlin=
e handling")
> >> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> >> ---
> >>   include/drm/drm_mipi_dsi.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Yeah. Looking closer at the history, it looks like it was always
> > intended to be a pointer since the first users all used it as a
> > pointer.
> >
> > Suggested-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > I've also compile-tested all the panels currently using mipi_dsi_msleep=
().
> >
> > Neil: Given that this is a correctness thing, I'd rather see this land
> > sooner rather than later. If you agree, maybe you can land these two
> > patches whenever you're comfortable with them?
>
> Applying them, but inverting them, fix should go first.

Well, they're both fixes, and inverting them means that you get a
compile failure across several panels if you happen to be bisecting
and land on the first commit, but it doesn't really matter. I guess
the compile failure is maybe a benefit given that they were not doing
their delays properly... ;-)

-Doug

