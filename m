Return-Path: <linux-kernel+bounces-285323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36F950C12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DC51B24CF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5EE1A0723;
	Tue, 13 Aug 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xw596g/3"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5C1A3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573010; cv=none; b=KJfvyxJOnp5x5OBaEO5mmnCGde8nqdif1DptgceQ130WLj9ccsLl5lsC2qHUkWpOEaNnqZo5lsLHoI9Hv3xBA1GNdpwXoXbRq/WtkJS4Ij2G1tFO7a1Ni8vqRz1iCA8sqTAUcmmE0NDMrkRTMchTV+BTp01Z2hFGDtnUKl7UaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573010; c=relaxed/simple;
	bh=QXUcFaLwITePpQRNB8+teEsrqhSwVSnqSs3cYyMB5nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfNFlN/wyvQK2glRF3nWBcnpQPBGtCGKMffhvhmRf4yx+yzLQY2KpJ3CABUcFQ0HicTUp8X3tiKpbFMr5MLYy2lFdKRpSt3mMp35aNN66IpNlnPKgHF8R36H8S+bat0DCORyIbxz9yEkqH309b8bjG9GlVQ9qplOYxesqaau8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xw596g/3; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a1df0a9281so365167485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723573006; x=1724177806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01RAQRrnky8LUTuttXkx947DobRI/6KygC35LnslJMQ=;
        b=Xw596g/3sIESNoB/7fPU9FlhVauiRLaXIFmS8hrLTxhAb/lg2Ttb1bBD8cPRBgnCDh
         2wUbvLaph82WegfaES0/POWNZdFksi2QCO2ou9dbtWr8lQwHgAhED2Lb+lPh+bTX589S
         wBKtz+fKCMP00kA8Vr5yR37GwYj6l/n2D1dp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573006; x=1724177806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01RAQRrnky8LUTuttXkx947DobRI/6KygC35LnslJMQ=;
        b=lofEEl92C1sjQoFO6HxGCcrDx5Bp12ct5g2h7cS0z1rx6vyL+4B6efLXy/geWraaTB
         rUQRvW0adOCJ3MkZJxUTC9xNqfTg3eZNAfPkL1JqFI7FAkCK9FKli1Ff6uvp7hp+V5jV
         adDP0jbQAQerNuJaa6DVE1kwJT9YttueqaRUx729c2HKfZchivBHkbyRl6AUG/MDxmhz
         sd3o5r0KiXL1qRD/jzdHeYMqsUHZjs72MjE+LCbX/X9y3h0unsHhsTfnLTjtiFx4Uh0L
         wmJq4z7CXTW1VSCNbZrf4j9dbY63DTwDwCC6jeah5Uhoazm69fqs8WkmsOlQ5uy6On7u
         NZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/lop13yXV3e2Y2u6aLkbqmoAw2wcn6ruPh+wW0MHH8H1vwoUjtp4t2+FGeMLdz2dDM4AZDtO+4+GiV/8+IH4I3K3XjWw4lFWrXSMM
X-Gm-Message-State: AOJu0YxQGjmgiUKQgMz8bKiQKX6OTLx4WeGhB7YCM/qoPk8YnBJX7+oH
	oEWePZHCdoU8LxIpg4GgzvG73LjNGuYjKygbk9lUOltd5oifS1/vxWyRF0mNRfq6h2lrSRSjQVE
	=
X-Google-Smtp-Source: AGHT+IEFQFgbpm6wECZSDYGDZT1N5J9qxmhl5+HOxsB+R4MzAk3KUuPcgvmhut37zqftOa72SIQ+/g==
X-Received: by 2002:a05:620a:4141:b0:7a2:16d:8428 with SMTP id af79cd13be357-7a4ee3310famr60153285a.27.1723573006380;
        Tue, 13 Aug 2024 11:16:46 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e11130sm362143485a.125.2024.08.13.11.16.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 11:16:45 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1df0a9281so365163485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:16:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbtHwWngeSblgEcJmBr0NWM6IFsEa6MG/NUzNQf5niGfbeWgvY6m5MYZ2frfIBzNhUfsl1heZKUEP9hWZMYu6ccoGMV89CXYWX8kPS
X-Received: by 2002:a05:6214:5d8c:b0:6bb:bdf0:e49c with SMTP id
 6a1803df08f44-6bf5d1e2401mr3362066d6.31.1723573004873; Tue, 13 Aug 2024
 11:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806135949.468636-1-tejasvipin76@gmail.com> <20240806135949.468636-2-tejasvipin76@gmail.com>
In-Reply-To: <20240806135949.468636-2-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Aug 2024 11:16:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xqe2Fx-3Xgqxni1L+NB3-vyhD9NwrR1kMOgSn5=-mukw@mail.gmail.com>
Message-ID: <CAD=FV=Xqe2Fx-3Xgqxni1L+NB3-vyhD9NwrR1kMOgSn5=-mukw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/mipi-dsi: add more multi functions for better
 error handling
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
> Add more functions that can benefit from being multi style and mark
> older variants as deprecated to eventually convert all mipi_dsi functions
> to multi style.
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 194 +++++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  10 ++
>  2 files changed, 204 insertions(+)

Pushed to drm-misc-next:

[1/2] drm/mipi-dsi: add more multi functions for better error handling
      commit: 5ddb0a8aa8e4754a8fb77e284e0d6f46c2350f88

