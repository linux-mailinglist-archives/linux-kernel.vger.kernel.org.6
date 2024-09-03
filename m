Return-Path: <linux-kernel+bounces-313939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DFC96AC97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6EE285DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899231D58A7;
	Tue,  3 Sep 2024 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FMrBjT/F"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFF1EC01D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725404538; cv=none; b=XUWFlaWxlVxQ2pNIjqzxC0o9KsATqHR2INvib6MwwLyrkF9Hyg2KEzZmakORpqPG6wPcQij2Z0jtXmCdCspOuQ0k3fiPxz4ITD2jG+7ppNF3K3oDpXGbpbS/mcPpwNJePpYBLTXezE8N2jWOWncVoMvohFJCCF70lnqWf7rbkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725404538; c=relaxed/simple;
	bh=xAABSdKURVgSmQtKeK+lNAD/kQ+UsqBvKNcYILSWpeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTqNWwNXqE/bp8D56XI40c4wKORBlll9mWbIPwZTiSpz0ZVBChP7vh+qHcgc9iKrUW9IcEKYYohFxu1TfaehMyN6Jfp4XdYJ3mc6VvFDjWhyBGzL5Te29zLu4NluzMSREaYydkpMjfTWoSV3WoQJnO0LnsP/znrI1E4sHX4YILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FMrBjT/F; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a7f94938fcso383490885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725404534; x=1726009334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPd0NJnM5+70BVUX6+yFPjyKwQPFAYAo8osJyqIOz9s=;
        b=FMrBjT/FmKRUcN/BZDWSxdbnYGl8yooS/U7G5wDPKId+/BofQGi8cQLH1vxl2QEpMj
         8giyPypSuBbdRSqxqUsdp9UeKuQVSYISqIu6yfkrsl4+OsqOwle545zdpDDP7x8VcYlu
         r2NTOuJdxAeUYApI5uFT59X4TBFswgWfFZjFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725404534; x=1726009334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPd0NJnM5+70BVUX6+yFPjyKwQPFAYAo8osJyqIOz9s=;
        b=hZ7e/uP+B974G1rU8QJjuwxACwvW36twAVaVSrDmi5hZlQeuOAt5sv8bQJ9almx0zH
         2f4ymiGN7KQ7+5zgaywikpqaNmdr11431e6MnyZ7P4/12EtzoidyVuoAy/yNYYym0LyL
         xkKeJ4sy4xoWf9Xcv6f8nb3hg12EmA4uY79Ju7lfCfctMXyjZls0Ia3SdB/8StzJ6aQk
         KyyezF8ABSRVOfjonFEnfEpVP7Bi3B0uyaqwaeISRUpCdZP1aJ9e03NOte3d1DG4fsbW
         TV/bmnofIg6tuU7C1CIUlfrPSAsnA1XJUf8tqpNzQbZ/zOga1/T9q4INaeHyf62MPh9E
         Q3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXNWcg4sAoVEIeNgrSbCCa+4bMDSRY/FDK6tpMMc+f4FGMLr+okaEZ6fsZ8vQ75R8cslEgiRf3kOYtpzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSZp68PY0n+grB4FjDbP4xrBmpKJJ+zdzuiExNmWFKDbeHZw4
	pNXqtkhlb1soX0E/uRnHZR4uFjsc1xITppbSC6wH8nB3n0zFYuUFYz200EpN5Eenr8SfLY9TMMg
	=
X-Google-Smtp-Source: AGHT+IHo5bEHJ1fMt92dmm6kccysBZ73l/TUpNI7PiEq8DyeLALXhRi8+gazuJv8SG1T/vYCN2+aMw==
X-Received: by 2002:a05:620a:4304:b0:79f:73d:d2e with SMTP id af79cd13be357-7a8041b4387mr1987684585a.24.1725404534477;
        Tue, 03 Sep 2024 16:02:14 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c4cd89sm565742785a.57.2024.09.03.16.02.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 16:02:13 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4568e321224so30198421cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 16:02:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqv5t2iuLxUq1pZDdDGVq+blalJu5Buf7BYj8Tqr2KTMxJjDU3bkGHUMB2oWkOE/DT7Us7vbsoHZq9FlA=@vger.kernel.org
X-Received: by 2002:a05:6214:4882:b0:6c5:e40:2540 with SMTP id
 6a1803df08f44-6c50e402582mr60072106d6.26.1725404532653; Tue, 03 Sep 2024
 16:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902071019.351158-1-tejasvipin76@gmail.com>
In-Reply-To: <20240902071019.351158-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 3 Sep 2024 16:01:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W-HRHuL=CCVksq_E+2gDP0XMzN2tbcvLqb3-3Tiu49CA@mail.gmail.com>
Message-ID: <CAD=FV=W-HRHuL=CCVksq_E+2gDP0XMzN2tbcvLqb3-3Tiu49CA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: samsung-s6e3fa7: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 12:10=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Changes the samsung-s6e3fa7 panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-samsung-s6e3fa7.c | 71 ++++++-------------
>  1 file changed, 21 insertions(+), 50 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

