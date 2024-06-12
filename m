Return-Path: <linux-kernel+bounces-211665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A74490551A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1DF288387
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E50817E456;
	Wed, 12 Jun 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTE6xpBb"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B37FB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202439; cv=none; b=K+lGM0ISciUtFyeACHB1wqsNuwZgrva5wEQQ+qD3AwxH+CEslW1gSwgegp2w3bK/3BkcHjMkbV96TC/FDPjVQt0I0Jk1MYKHGX32Rbbgqdtdt7SOZf4qufWbQTvAdW7s3QJ4BApxywNo5Mt4sxbVeTtkWBx2Auv2DH34AsmuBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202439; c=relaxed/simple;
	bh=WvrdNviMX5TzKJJ8L49b4Qix7SQh0JAWUMwXtKICv8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XA/GADIAC2zZvvqJnbAzlQCc+nZ76cThF/kYdmpyYOflHkzgoD/Mx+RlOot5uEwyDrKped8YiK4BpBRqyx/Ici2AcPC2ptMtRP/20bUjfseENJXsMZdxuuPBu783gJVzg21arPuc3jgwsgVFX5SZcdLv3MC7t2/1du3Ri0enFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DTE6xpBb; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dfe41f7852cso946629276.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718202436; x=1718807236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7Z/F2lTFqxBQr8f3YutkrSgp/gPqby12XW1md45flk=;
        b=DTE6xpBbiJqy5Tk4viU4rvjDd5KhzmomcToUw3vUSDOT/7bNI665Yvmpc8fjTX3GUE
         dq/VMr0FCbY6H0ey+U0/m38rugLNgzav983+Mk3D5gJ1LaXWJDTMyw6ofmSq3Mw4F58Y
         xJlJesv5gE3Vbj28viNGr/ogALNftwSgXyFbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202436; x=1718807236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7Z/F2lTFqxBQr8f3YutkrSgp/gPqby12XW1md45flk=;
        b=vhVSuHcpwlRTmt0Ek55YW9cPqHC2PdXtEjO2Q8sxvnzkJbyLHj6M8Skly6iTl0Eoyv
         A3s82OR15UHC33eV0m7/5s2n1ixDVuNzZ2VKWKKq71El4E9N8YEXKacItRro+8dJHBf6
         b1fgH65vEfSBFTRzYYIKmbFxj3PwU5/jZgj03jFDmWR5UG9Mm9c8aCdYTN+I0ELuOOO0
         g/qdhE8/Mk1LEmrRVcS7CiO0curD7t+5H8XmBhSkY6GfsRcDPOEDBIoI5Drxub5BOPTQ
         dwIAKv8g+ZNXCuI+ps+HWbptC2ASebjLdx7xtLPemmEijYDHuutoI5qhe1L5+Nx5AGdc
         AGeA==
X-Forwarded-Encrypted: i=1; AJvYcCWuAG64U4aeEqh8HE37aE0D8HzqUTIjUlHGl5EPyzsBgxU9dZJY9nystvCfkr9ONkgyMOTY6PO3qa7PSzF17gq/Qdva3J6oePuMWVPs
X-Gm-Message-State: AOJu0Yzv2Vaa5LoZbIcl4rhRMBcRwLJigyzpp1s1XDAWSeXpSQDiszi6
	3QZ9lnNRt8DLFyEtqFTc1ah2klTOxp7lcOKqWQeLV8Yq77XNvFSdI28RE9ooYDAqtaYpmwDQm4E
	=
X-Google-Smtp-Source: AGHT+IHu0U25x9X1Pg/v8WLMtA+jnT0Qcgs9vOse5k6pZim/CJTqQsh796il9mqCR+X3DXzdESA02Q==
X-Received: by 2002:a25:aa42:0:b0:dfe:fc2b:56a3 with SMTP id 3f1490d57ef6-dfefc2b5738mr480841276.56.1718202436573;
        Wed, 12 Jun 2024 07:27:16 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4415df952d9sm3915061cf.88.2024.06.12.07.27.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:27:16 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4400cc0dad1so464451cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:27:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjqkSUpMlreotRpZhQc1PQ1RaD605q0DpXERTHOWO4/xOpNfQH5nLiX8RxLGrE4J65hLe0AWYiKjtfN3H0f52Md07Or72LWC7q0uAx
X-Received: by 2002:a05:622a:5a9a:b0:43e:295:f160 with SMTP id
 d75a77b69052e-4415a39f97bmr3125261cf.24.1718202116182; Wed, 12 Jun 2024
 07:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612133550.473279-1-tejasvipin76@gmail.com> <20240612133550.473279-3-tejasvipin76@gmail.com>
In-Reply-To: <20240612133550.473279-3-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Jun 2024 07:21:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTEzSyTHm-YBwneBgpohK8uu460DER-GcsQWu-z9hJsg@mail.gmail.com>
Message-ID: <CAD=FV=VTEzSyTHm-YBwneBgpohK8uu460DER-GcsQWu-z9hJsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mipi-dsi: fix handling of ctx in mipi_dsi_msleep
To: Tejas Vipin <tejasvipin76@gmail.com>, neil.armstrong@linaro.org
Cc: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	linus.walleij@linaro.org, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2024 at 6:37=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> ctx would be better off treated as a pointer to account for most of its
> usage so far, and brackets should be added to account for operator
> precedence for correct evaluation.
>
> Fixes: f79d6d28d8fe7 ("drm/mipi-dsi: wrap more functions for streamline h=
andling")
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  include/drm/drm_mipi_dsi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Yeah. Looking closer at the history, it looks like it was always
intended to be a pointer since the first users all used it as a
pointer.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

I've also compile-tested all the panels currently using mipi_dsi_msleep().

Neil: Given that this is a correctness thing, I'd rather see this land
sooner rather than later. If you agree, maybe you can land these two
patches whenever you're comfortable with them?


-Doug

