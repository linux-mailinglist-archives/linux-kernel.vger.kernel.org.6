Return-Path: <linux-kernel+bounces-209037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8AC902C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358EF1F230B4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24334152160;
	Mon, 10 Jun 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AE0tYdJ2"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B01514C1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718060722; cv=none; b=l3t1WVscEWNZfGWaN2nRMJFjXmN98qaa5e38w71JZBi/Zmo3kDBqk3X5L6TCc0Bs3IG5uvNDREJuekxr/ExaE/JstK2ZktURz1HD6y9PuIt+yoG5so7Gd55BLakv75kehud2+BmIypgR/fx4gnC0r9wBKrXtcN2OCjqITr2OaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718060722; c=relaxed/simple;
	bh=0iAQrERYxy8ofmSmW1ynsHwEiXbQ2uB33xUNEsgQzSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5t5qiBrrGMxd5MiFRcP8erSlH8Q8sUmmgdGzZxLRUByg4CgSPY5Sa/hso+OerQyX8ORD6gcu27yj3C5j6cAB5EoPdXz2w3Kl5RB1OSs2sIbYMovQ4DK3t4PtGwDN0Y2j4W5d9+gKUPC3n6ISPb9iNAQDDhcELB5n3jI2vkpAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AE0tYdJ2; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bd48cf36bso3715192e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718060719; x=1718665519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/1Y/1ng7J+NJ/Pxck+jwlwukOV+5HqrD1XO5KGcJr80=;
        b=AE0tYdJ2BZkVFw6kuSTDLRFwWCFrf+OEpqptDrYDmSsVdqCm031I+jIlgWlZJBaz3S
         efwV/dLjigrLYxOF/zIu/snGHE0lIfJ7hsptCWRnhzNRfv+HUwzExnRZH7wlWj8aUkqs
         nEYTHh0R0p25lfrQe6lQ4lGJqfs2+8gutPBxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718060719; x=1718665519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1Y/1ng7J+NJ/Pxck+jwlwukOV+5HqrD1XO5KGcJr80=;
        b=VpISHGHBkCfcyY8GCVJS3WJUiz60azwrlP6uUjQ26TG9kergXBgYIocsJvVyiqOVPl
         EXsZHE79QZEFunyGSw+YrIFr80bzzlRDA7QuUC2jmrzFNEZWDJ5rM72yBKmPVIDD23LR
         FR8Q8wuPOfPvnSgrKFJQdZjDFw537KM4aWzu3Zt/RGjvgcOkFsbn2cXpvlwWhsBnN2qp
         P0NoMfjXitjMhAmx8GYD4Jqk5DBANDXi6hFp5EhxZ8Reve7fwOlaDPJM/2xKIocfzK/T
         eWyTDfFmpc9LhcXMuppBHgdSyVc2A5H5xg8qhgNfSPXED7fI5oHUX7hvszPVhCbZM2dp
         wb8w==
X-Forwarded-Encrypted: i=1; AJvYcCWoxYH2eQm3dCX3a3HyXqZ5ILq3F14YksmSRv3J8E4BCmh1/rrUKpEBTuWmpOSkDXqTgzefaS0Hr1sa0vuC1L+uUIjHe/v3H87ZUPAn
X-Gm-Message-State: AOJu0Yycu6T+EaeVQWY+38mhfp87r88nrhPye4/kkyV545YZEkh1ZQ0q
	FktvQX8rjAs4DuO1LrUUD2lZyhVDS4XVB5hj0TFYeJLlro1kb3lm6fV0T3n901JflM6EWNLWptK
	AL8H+
X-Google-Smtp-Source: AGHT+IEhO4frCuu4pUOMpIqAwpeN9ij9pSmG5sX7to3iZsaeSL0p2l083pZlgsp4bxbxnjz2qJt2gQ==
X-Received: by 2002:a05:6512:3ca1:b0:52c:859f:9f77 with SMTP id 2adb3069b0e04-52c859fa036mr3564110e87.19.1718060718837;
        Mon, 10 Jun 2024 16:05:18 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c93ffa8f7sm74857e87.239.2024.06.10.16.05.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 16:05:18 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso3667166e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:05:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzhUay9Vk0vslEraebAzHyE0glhvHeeOLlgeodEZb2qD2+/nVKUahD4sFn67/JM7qaZrNR+jIla+a0SSMX99qTjPeC7iAj9ogcokzl
X-Received: by 2002:a05:6512:324f:b0:52b:fc90:acdc with SMTP id
 2adb3069b0e04-52bfc90ae01mr4654385e87.32.1718060717297; Mon, 10 Jun 2024
 16:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
 <20240318-billion-v1-2-2f7bc0ee2030@chromium.org> <20240610152046.GJ26663@pendragon.ideasonboard.com>
In-Reply-To: <20240610152046.GJ26663@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 11 Jun 2024 01:05:01 +0200
X-Gmail-Original-Message-ID: <CANiDSCsO1Cvn-S9gKLJ1ecNdejqy7-VmiJVRCfS82-fFy_BBeg@mail.gmail.com>
Message-ID: <CANiDSCsO1Cvn-S9gKLJ1ecNdejqy7-VmiJVRCfS82-fFy_BBeg@mail.gmail.com>
Subject: Re: [PATCH 2/5] media: uvcvideo: Refactor Power Line Frequency limit selection
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Mon, 10 Jun 2024 at 17:21, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> > +static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
> > +     struct uvc_control *ctrl, const struct uvc_control_mapping *mapping);
>
> I wonder if we could avoid the forward declaration by turning the
> .add_mapping() operation into a .filter_mapping() (name to be
> bikshedded) that would return a replacement mapping instead of adding
> it. The caller (the __uvc_ctrl_add_custom_mapping() function) would then
> call __uvc_ctrl_add_mapping() unconditionally. You could actually call
> the new operation directly in __uvc_ctrl_add_custom_mapping() without
> having to add a new __uvc_ctrl_add_custom_mapping() function. What do
> you think, would that be simpler and more redable ?

Let me add it as a forward patch, let me know what you think.

Regards!

