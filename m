Return-Path: <linux-kernel+bounces-285324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19961950C15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C87E1C22750
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30F41A2574;
	Tue, 13 Aug 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xe1g7+hQ"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB9A3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573018; cv=none; b=UAIpkwaKLwNFC7g0Mk3EKL1bk/M4K0Szli9idgzMA/D4Rat54HRzH0afpx2Oz7yW61O9iAGZ9ACzszbgEvPRuFkSM9twbV4s3ahB4xS11ksZwXi/wO9qPkNgARCXUgFihnQpmshP8vIH/hh3EXaOOM+PSCo5gYCdunw5uLMdS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573018; c=relaxed/simple;
	bh=sjMYIKq06qPMriv/ID1G2/Hnlh8vnfgx2+1vtLqc2Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B66ddQi2JA5skLYE1soY6fu7X0j0pLZanPEoenf7elnKjC6rvDEPoo9mT1Ckwed/JuYmplxRgeX9JPKZWrGwAxkelWUWdsV1V/eayu43NQOp0OsThJ6UFQSAe4QpDTPZZ8hqyoPN6xw1/ooKKmX+yDhukB5aojI+FJxpeJ+mBcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xe1g7+hQ; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-493d7455231so1867687137.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723573013; x=1724177813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb//bFg6w3kBWyz7jCIoc0uCU2L7eORtwe8AvBhyGXM=;
        b=Xe1g7+hQZEmWzMxyFxtZZXJfGihXiKUilGebxoCsrQ5nNwzMnSegS72wGw9xqlrfCD
         +NbQ1vVjqWowLWUuYu+PlCwcr5ElNZuVX4xFaU+cM6GxqmF1fUH7rL1MSYMgx+DbjqnD
         tz9QLfZUDqhfD4uOk2QlhPadvSDz3QnPXumjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573013; x=1724177813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb//bFg6w3kBWyz7jCIoc0uCU2L7eORtwe8AvBhyGXM=;
        b=eJbCvCnkFC18iCEqeC/mBkB5fH6G8yAXiFV+zGB6RRP5RsH0BycqZZqOMezc3qgjie
         n1ra49zjlNjApNo4VibKd/xxLtEjEnkiW50W/pXG4XzHEF4oRht3q5jzYB0iHyofs6tX
         Grw7a5xUkWbPbPemwvPF9o/kf/ViuRDFEg18HaWC9zBhyjlpBlOTJPYgTanLPW1fmohz
         7DtaOaCuS1CvQ32Y7cQmdR3vq5SxBvmjNBqtzq62EsM9X4L3NTU+wrQs/usASweE4JgV
         KhNP+yQ+f1MyqvH60ZF+q3VgxGh80HfqEQxiBRK8eNHD0hSL7eLv7BUOd+mvBaITzOBJ
         vFZg==
X-Forwarded-Encrypted: i=1; AJvYcCUkYmO6NDP756V0bF2fCyZLANPVbGD/72g4BuTNoKscS+feyFtE7FASNhjRFOPWw5gvgmq3EJohwDrGiUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVlL70/D00lHwCUJ9kb/P+vQhBA9crJNEDu6aGd/FwIWODYUpv
	pzUxl5HMqoDgASy5ExNdun5dLMreddRvomgETRDIgrGNxgKhk2/khAeIUrKYHmgBViZNBCNNTRw
	=
X-Google-Smtp-Source: AGHT+IEVUOUC/OHv3nhdsBem4UqT794v84Tb1r0MYSa27QUfhEcHYG7DRTiKHphOUxvTV5OQfhZCIw==
X-Received: by 2002:a05:6102:c90:b0:494:fca:fd93 with SMTP id ada2fe7eead31-497599d93c3mr602416137.21.1723573013183;
        Tue, 13 Aug 2024 11:16:53 -0700 (PDT)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c5fa95sm36100736d6.6.2024.08.13.11.16.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 11:16:52 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7acf213a3so31086816d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:16:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/lkfirCWCoCWhDYnaEmz2tidduEEu0RSBBX3ooWimjiZE1Q5I5+Yt5vHmCwE3TxTaptN+TN/+WPLHBYc=@vger.kernel.org
X-Received: by 2002:a05:6214:4603:b0:6b1:e371:99d9 with SMTP id
 6a1803df08f44-6bf5d15a44bmr3257676d6.8.1723573011530; Tue, 13 Aug 2024
 11:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806135949.468636-1-tejasvipin76@gmail.com> <20240806135949.468636-3-tejasvipin76@gmail.com>
In-Reply-To: <20240806135949.468636-3-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Aug 2024 11:16:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wi9qCm3L+Cg-WxwGEm+xs-M-aKTNRvpFPs-Y3a6m4KrQ@mail.gmail.com>
Message-ID: <CAD=FV=Wi9qCm3L+Cg-WxwGEm+xs-M-aKTNRvpFPs-Y3a6m4KrQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: startek-kd070fhfid015: transition to
 mipi_dsi wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 6, 2024 at 7:00=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> Use multi style wrapped functions for mipi_dsi in the
> startek-kd070fhfid015 panel.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  .../drm/panel/panel-startek-kd070fhfid015.c   | 115 ++++++------------
>  1 file changed, 35 insertions(+), 80 deletions(-)

Pushed to drm-misc-next:

[2/2] drm/panel: startek-kd070fhfid015: transition to mipi_dsi wrapped func=
tions
      commit: b080a60731ad909eae4463684acc23d322e93579

