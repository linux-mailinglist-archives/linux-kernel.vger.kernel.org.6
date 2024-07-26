Return-Path: <linux-kernel+bounces-263546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CAB93D787
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD61F24B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086F17C7C9;
	Fri, 26 Jul 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XCxNU6jq"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A711C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014506; cv=none; b=bnH3gghxEOu2kE4tsNpbJDKJYNJyk5OuOGo/ozzAfODcUG6gXIp+AdXBPOlRRde0pSACwCOMdf7Kis20/4DHpVemcsgXNg+vMSLIJbGAdXKojtqEUl0Fflv1kR59Lno2v30T6yWdc4rnM8zb/gPGewlwDXzSf/mweXMloz7uOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014506; c=relaxed/simple;
	bh=5LkTendabGPMxDT4rutz/XYLovL/hCobFcqlN6eCpCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HX69SxnkiS72x8ig+FexjrKaPKJiBoRANvj9vN6bCIJ/DyUF/C6LAACQPeTSzwY4gHC1XW3V+TDnip4WucloCO255Oh0MEBP9/H+aSPOibEu7yY5MFu5D3ILdeVVepUoZXO7E/NOi4d1Aoi0jVOXyoKp460E9/6YnpI3Sil7SrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XCxNU6jq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b7a3e468a9so6473446d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722014503; x=1722619303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0M2ezyARf722kO0n/gneWi2HryULYqa+cG+Yc2z4K0=;
        b=XCxNU6jqryNIMT2jEsS6s3fE65vK/fPDPvNv52f6wjgOClaMgPN5/u8wG1E9qOjxft
         01n6jY2U/IgT7wk5CVgVfAaoVDBbHlT3pgRC/bQ0nnMZr7a1QNsJ3LoSEXTxek9W+n+o
         yz+mzpYeqQNKYxSG8AOyDLXBNA8NdBwDJg9/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014503; x=1722619303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0M2ezyARf722kO0n/gneWi2HryULYqa+cG+Yc2z4K0=;
        b=WDlpiRExIdjNY+Wciyru/UGQ8CxtswQbrGBSSZuzOJU/1MyThvpgzBwBz3qR/Azjuy
         f0eIKo6c2Kr7RrIQOU0YknXt0I07GHiLXK50p+0ABxGhMobGIOQLsXUlvoGd7B8XAX9L
         +i2KtQgaMYBn3QB2TIVYvEnQt6LRxOF26BLUThsQ4tXjaR9JfBzg0TvgIdZZml+clmSH
         g12COvTpvwhqhjfD4eRqgo1Cnwj4L/AZywl3IoSMGou5kBug7N62kARZic2Rdpt4iAiM
         Ug9chabeDJUCDY3ewMyyHBfF/WPdFDpU8ycMz3Cd8IA8Ia/d36ReeoiPH4G3Q4lpiTsr
         +ApQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNAtQcGcCdapg1h4PCCdw50bdrohPqzkUFvobfncF3Qv9otVr1IvL7osQPPuv2j/15aAvLM2wk/E6KtYGmukKaWZtJfHzqHYMNLJMV
X-Gm-Message-State: AOJu0YwmBvdflZBOEZMhR+zhjXuDvvK+ebh5Szxu6UoOs4hdrihocNDT
	kmyVUN/uzDy+l942OdUV8WPe8JyViMvKNEdra8bzgP9bQTUXSe1n7cpCjbnryNExIvHVQcPvEPY
	=
X-Google-Smtp-Source: AGHT+IHjzQAF4vrhv3aKMIy1SnfydFL4VidK1nFB4hrw1u9PN+cHB6tTslnfoxuj8IjajCLjmQr0Bw==
X-Received: by 2002:ad4:5ae7:0:b0:6b4:fea8:6bfc with SMTP id 6a1803df08f44-6bb559ba16emr8499636d6.10.1722014503418;
        Fri, 26 Jul 2024 10:21:43 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fac19c5sm18419096d6.112.2024.07.26.10.21.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:21:41 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fdc70e695so18711cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:21:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWChq3eCeHcWLhzqBADDXWFktas0JCFTYj+LBVFl7lfbhwyTNIpl1VR0dlI1HH/lVHXIegQZO4WYV1JQo23O/buNaluixysaAd7qWMv
X-Received: by 2002:a05:622a:60e:b0:447:f891:d41d with SMTP id
 d75a77b69052e-44ff3b38036mr3576011cf.18.1722014500672; Fri, 26 Jul 2024
 10:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725115229.3416028-1-zhouhaikun5@huaqin.corp-partner.google.com>
In-Reply-To: <20240725115229.3416028-1-zhouhaikun5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Jul 2024 10:21:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XGBEB2JjvugPqPRdZhvtr92H+UXy_+_dYBacZrsvpnGA@mail.gmail.com>
Message-ID: <CAD=FV=XGBEB2JjvugPqPRdZhvtr92H+UXy_+_dYBacZrsvpnGA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add CSW MNB601LS1-4
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 25, 2024 at 4:53=E2=80=AFAM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> Add support for the CSW MNB601LS1-4, pleace the EDID here for
> subsequent reference.
> 00 ff ff ff ff ff ff 00 0e 77 04 11 00 00 00 00
> 00 22 01 04 a5 1a 0e 78 03 a1 35 9b 5e 58 91 25
> 1c 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
> 36 00 00 90 10 00 00 1a 00 00 00 fd 00 28 3c 30
> 30 08 01 0a 20 20 20 20 20 20 00 00 00 fe 00 43
> 53 4f 54 20 54 39 0a 20 20 20 20 20 00 00 00 fe
> 00 4d 4e 42 36 30 31 4c 53 31 2d 34 0a 20 00 20
>
> Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Applied, thanks!

[1/1] drm/panel-edp: Add CSW MNB601LS1-4
      commit: 9d8e91439fc3890de55eef2bcfde97470b7dc04d

