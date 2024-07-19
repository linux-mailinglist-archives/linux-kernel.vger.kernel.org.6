Return-Path: <linux-kernel+bounces-257551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73767937BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D81F22BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 17:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C297A146D49;
	Fri, 19 Jul 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cmA9nsco"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D437146D57
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411365; cv=none; b=MkVwLB++DL0YeuDwyAMQvjfKA4zY9zSlhCUjvfxlAKyoABt72KrxlRZNMF+5+a8xhbfCZzEdNjGIEsqzoIGqENZQwg7ufFYL2IobgRUftsmz3gri6fsItQEYd9tjahkct3U4JhSMXz/QIER+JzrIBa/EiIg86hD0F4W4hCSyTmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411365; c=relaxed/simple;
	bh=NMnrCKod1zrNGwQ1DRNctFN0wjuyxtr733FEv/gsD5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Na6U0ewpFFSIbKD6bln78hgZc8IFunV5L+oyFQ1oOXi61XYUX2qgkyjyLPHOBMLoeO/wMthPdudZIB1xUcYM2wgMqPIT6gDoXmE8tqcR0UHSseRLSPt7SKFGMpWayQAHA/RW2aDnHqRgGS0cSAIAoU0nxWdpMiqXJReSqRmonRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cmA9nsco; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7039e4a4a03so1191048a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721411361; x=1722016161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfgwwc2r3y6LJY2+fBZz5scVHiOZDENMtfcc2xc+/L0=;
        b=cmA9nscotJ9d9YYd1R1iMYxrhLF/5Qz5Os1v7lHmxXVhNte9nnxoozbOh3rCKlPsJG
         1Sbch+HEjTQHYwN2ld8bJHtQDQJSaYVL/6wGvfUchSRgVJoI9xyi9TWPjeoWRro6Sfi5
         BUeJLnSgnsFNVwHGgo4+GWf91CQj8StwgKmyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721411361; x=1722016161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nfgwwc2r3y6LJY2+fBZz5scVHiOZDENMtfcc2xc+/L0=;
        b=f9sV6LVN+ygiCIbtd8h0DFTr+y2i7S/J4kkRTUPuRDxmprrgqOxyXkJBQDdI6eZwOt
         7zTCbKzvV6Kjg26xVXz3nLuNsLnelmXo4IXkSQD0wIxh6XYFFIanjmiCbXBDbHXbCp6D
         HD7VdRkIMpEwcFAzYGBzhhA9MeX+5Wuvq7cSbETR81ClaOwLr2KvTZXumQYcqyiATRGG
         ga6Fx7sAyqoSG5YI/GFxB9QT69Q24jKuehGjCnEiWvHcyon/kLeL0jH+MaODjevBi42X
         cZDLi0nvxpBRIFVwgF8RMJrXhTN7cOOo9MpJ6SqP75we4+LlPgi/GCRrsMn59cV7Hje6
         MRxg==
X-Forwarded-Encrypted: i=1; AJvYcCX+1Hfum0zY2RDnvb1E36YNrgaK1GcIajeOhUgjEYRzPOiuboPGf2ps1Pxx+FJUUjQmthv4hcNWRZpeTPizOiYRmehjBq1DkPGPbbm/
X-Gm-Message-State: AOJu0YzCTyP7DvQdp9wOkSCW9dkgk83BKBJilRWgg/ALt0VduxXipCBP
	qNHrly7OFvsQUV9C7fCIeyz2DDE3+LUr7cUvrANfTBi9zz8njXfiY4zq7lpSqH5RCOYvVvDH+AQ
	=
X-Google-Smtp-Source: AGHT+IG5EUmw2OB0iP6Ot2/x6/pTSYTK2nBpveI/JcxD7RHwbOeBMa2Hi//puaKCDu30nFuHe12Mzg==
X-Received: by 2002:a05:6830:2807:b0:703:6003:11f4 with SMTP id 46e09a7af769-708fdb2292dmr560803a34.14.1721411360744;
        Fri, 19 Jul 2024 10:49:20 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198ffe928sm112187285a.58.2024.07.19.10.49.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 10:49:19 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44f9d7cb5c5so229481cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:49:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeXpiC+MsKcSAYd0Z85Qin2wEo26Yhu70gog3rYCHuu3AY66WMmbTDtTWnk92Ky3Twq2PdBfE/l0CgrxPxJd3bCsjK/OaIizoQnd6A
X-Received: by 2002:a05:622a:5509:b0:447:e8a5:fb27 with SMTP id
 d75a77b69052e-44f9c86fd18mr2794581cf.25.1721411359169; Fri, 19 Jul 2024
 10:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716121112.14435-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240716121112.14435-2-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240716121112.14435-2-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 19 Jul 2024 10:49:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W1_m0dDXM8+Gbfcv92H8_h1wgh8u13iE03nYOT-tOtYA@mail.gmail.com>
Message-ID: <CAD=FV=W1_m0dDXM8+Gbfcv92H8_h1wgh8u13iE03nYOT-tOtYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel: boe-th101mb31ig002 : Fix the way to get
 porch parameters
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com, 
	mripard@kernel.org, hsinyi@google.com, awarnecke002@hotmail.com, 
	quic_jesszhan@quicinc.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 16, 2024 at 5:11=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> The current driver can only obtain the porch parameters
> of boe-th101mb31ig002. Modify it to obtain the porch
> parameters of the panel currently being used.
>
> Fixes: 24179ff9a2e4524 ("drm/panel: boe-th101mb31ig002 : Make it compatib=
le with other panel.")
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Changes between V2 and V1:
> -  1. No changes, Modify the commit information format.
> v1: https://lore.kernel.org/all/20240715031845.6687-2-lvzhaoxiong@huaqin.=
corp-partner.google.com/
> ---
>  drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I assume we'd want to see a re-post of this series with patch #2
comments addressed before landing? What do others think?

