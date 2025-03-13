Return-Path: <linux-kernel+bounces-558649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E6A5E90F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2733ACC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D2C2D1;
	Thu, 13 Mar 2025 00:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="It5epQqq"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF7523A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741826823; cv=none; b=sA20YFUTlT4fwMzy9pzxjpurw7LadHlOd7o46dciyaClTqMK+KsLuMdpWp4id189qnDhRyB7fmkD6VojHox7/m9YfrcKU/y1usPKpy5zHarLGa56fZ4FEKEEPTOqX1NgvzHvCKM3wZhhr0QYKVZ4o0ED/Obn5iTB9aumFuTuGkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741826823; c=relaxed/simple;
	bh=WPU72+Y1ga+DiactL+y7ZYRgAAU6hBeWyVS/OFb7HI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5NW3SaK8GPKFaBMaYj9kKb3KsR7EFOSQrfTyc3dlYlmbxHEZkTknuQxIcbVD9nm1ntKkDhsOQC9WTDxxVvzytXpJhE2D7++xsZWR/ACGYus5eFFQhLluQcdBlnMBJQ8gr8yrsc6d0aNTtp0w06llWoJu4PBtt0xtkF7dLdNsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=It5epQqq; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54954fa61c8so407126e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741826818; x=1742431618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wOPhYxd+v4ASdWl9NlF7B1oiomg9NbTmCV332MQzSY=;
        b=It5epQqqJkJSajDxGWygGe2IEhPSrHbi7rsDVOJQ/vJmaxFHUG8v5nWGEyybQXZSMA
         VbMt/4/4qE568rSK8sLtuyVpo9Q71EzW1idLubvwboY3YehJk4G27cHTzIqPG/6z507O
         ito3V/ghj/9fNMDsLPqzg/xmSXek2TSazRsOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741826818; x=1742431618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wOPhYxd+v4ASdWl9NlF7B1oiomg9NbTmCV332MQzSY=;
        b=lJdKxlIGMkI3rg8Q82n8IakOqmuHjZev+X2QwycWWo4LpkwiFDBOvKJUex/PbeXPzo
         XIICOiWjy069PUuAiOJ+CsBYGiB1gFqiGQN+GGn7D2m2AlCEmOZEG+Uss1RMIfS2Ux82
         o9EdhmevRysqMoCoLpYArcSrFjWSTFBfLSvGXCp8psjFmB2czKfb9XNdcCHEEyNDd4B3
         OmOl4rQUTCyDUCzFnAZmDYx8pmZ+JFYx6fTCVfyVdWGWS8c2PlRYr2gMVReKwMWpeueb
         Mfyko5NmgZkffepcC53N31hn1nFrgL0cfBM6A50bSGs1hwdUzkQ5TZnS5yXrqAPbn9mu
         dV8A==
X-Forwarded-Encrypted: i=1; AJvYcCXNiAGyQMMciUPX+nPTzhjoK8V7j9xBEf5aE7mRUiQETgl3Om/pfi2KWpRuFmmFahoQlCpYf5cgJnlsADo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwreVKGT+Adoyfeh3ivO4+d4PZQUuhuVTkCaTnKLYTL97xIXptH
	kRL0njaXFKJ7Bjozl+N5DdPoE+3bqW+fm8Je49b8VoLEJcctl+jeRktnWH/qutraWT4n01cD32J
	ZcKBY
X-Gm-Gg: ASbGncvD47vV4vD1bA5VHMlK+4/2rtrmfkfd/ZawNpNDhw/QEWHD1G7YxnL4lr+xV9f
	AjVj7xWo2hmentQgrmnvvMzIkTSocSkgwhlXzc3ZLLpj6JtsUEcnJqxb5/XD3M99S1TkB0x+nQG
	u6OCTcmkn5sEvcJxva5SwpSoyNGB4nLXVchj5KtWqEFPjD6emgDNNmyeAnST9U6K6SXmCTifTKy
	RKQ/NyCVZDZo1zgU5yipOafq4dexHAqmJvECxAC5eyVxfTXYZ85kPtlkB8iFBDbOwOYsnrVtwKk
	FuJob2OOHoE0HDliP2BNcXk4DnIdnq9bqEldHZMktS/ioT9G3mzQAuX1rGYIBNq6NTqugy0c1T4
	BK7IEjBMb/CbgSBeColWLwgQ=
X-Google-Smtp-Source: AGHT+IE7iXGMtHlGjes3a1kLgbi2/1OFjcyjkyS7c+08Eizx5tM4/9W+cHxUepi7jmVzf0b7lfRU/Q==
X-Received: by 2002:a05:6512:128a:b0:549:b116:240e with SMTP id 2adb3069b0e04-549b1163221mr2602974e87.24.1741826818138;
        Wed, 12 Mar 2025 17:46:58 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a85b1sm37850e87.27.2025.03.12.17.46.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 17:46:58 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30795988ebeso4794891fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJwQx+7JAVlVeXqO0pzdPbTBSURwz05S1HJ+bePZUVGwRMxK27a0EiHk8Vwk3yML2Px2i6vL2pSsHzSas=@vger.kernel.org
X-Received: by 2002:a05:6512:281b:b0:549:4bf7:6464 with SMTP id
 2adb3069b0e04-54990ea9485mr7115862e87.38.1741826816614; Wed, 12 Mar 2025
 17:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311091803.31026-1-ceggers@arri.de> <20250311091803.31026-2-ceggers@arri.de>
In-Reply-To: <20250311091803.31026-2-ceggers@arri.de>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Mar 2025 17:46:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9WRjcxfYRtBWUe+twqjqkmW4r_oZYo2xJ4PctXgBQxw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq0-SLDcKeX8oiWyKvQkAVrt3keer7p83h3mGU_CX8qI6SRix9M-0SOgk4
Message-ID: <CAD=FV=V9WRjcxfYRtBWUe+twqjqkmW4r_oZYo2xJ4PctXgBQxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: check that dummy regulator has been
 probed before using it
To: Christian Eggers <ceggers@arri.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 11, 2025 at 2:18=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> @@ -2213,6 +2221,8 @@ struct regulator *_regulator_get_common(struct regu=
lator_dev *rdev, struct devic
>                          */
>                         dev_warn(dev, "supply %s not found, using dummy r=
egulator\n", id);
>                         rdev =3D dummy_regulator_rdev;
> +                       if (!rdev)
> +                               return ERR_PTR(-EPROBE_DEFER);

nit: it feels like the dev_warn() above should be below your new
check. Otherwise you'll get the same message again after the deferral
processes.

