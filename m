Return-Path: <linux-kernel+bounces-292508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05194957047
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3813E1C22E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBB8176FDB;
	Mon, 19 Aug 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TO0yTWsV"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AC177982
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085009; cv=none; b=pLqXBbgB4ny/1uWSRuuaAVhxO0bsX2MIuIt/xxqyrGZt9f531L5EDayV5TdgHbU9VnCdeK0OgMK+cXnFTUwexGdVYT+SX1VpGUWGKM2rQBcaE00Itpf8+h2SWvK32rToMGuzIrSNWS7CfANuaE/6u1BKB6fAJsmcYFQZpWDTp0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085009; c=relaxed/simple;
	bh=I1Z1n3rrR6OR2iWXF9jZi7wK2L+kNvSXn1vHS98jUSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJq1sSKpIGmLPNWwyt7PENpgVE4KSzATXmW4fTGqfnrLuLdpgIGTWucNLMwK0/LdVYTWLDPMVHtJbbb5xqyvfT8oaBDLRk9li1ajZvHaetZSBMyTkVvcicwfEB4C4fgOGqT48pO1wL5GquPhhBkWKY5ogs3BfE+BMDDCjNGnBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TO0yTWsV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-530e062217eso6039603e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724085003; x=1724689803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmHJCtcZ30o0V7jSxKUFqXXdgkHP4PwVCzNRud2qkuQ=;
        b=TO0yTWsV3JQcd22gRXzcpkD8Bw+pRt8TDXcP3qGGNgmgImml80E5KWdk4whkDStLxS
         dI0ElQ9OFoGFSVRriJasPaJ4dgHgbCBHs9Nm6Yjjpb7msjT9ewKsD1xeGpt3IEIfn4XD
         Nr1DHWfdcRtSFDs56YG77c0BQApb7zx/s1blY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085003; x=1724689803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmHJCtcZ30o0V7jSxKUFqXXdgkHP4PwVCzNRud2qkuQ=;
        b=oh8CpkVZeD9oimMWU1rIXu09a+2xDq/102sJlPgjdajBIU+d0v56sDs/b0ZX5a4QAB
         O8XMpxYhThLjv+jmBmZuQQbUGk91Z3NKV2hGh6mPFVqmfToYwnDt0kIt0Fgm2Ha0SUAU
         FAXLRx5Z1u4MJrNgeb1eUUNtiP/VSSU9KyAjcBsZMdk5a5kGWk7WojR1mvmQsysW1H7/
         YeoJSwG/3WKHZeR+q1LLYD0R4gnAwCKYp9mF9KbOXTRsSlH7LgIWT16YDSpu5+s0CNyO
         liaIElUz7xOdvWfOWUP52GxLxQVMmdfysXT+KcY96TQMXLoLbEPiZQ92vLBywmHtc6qs
         EA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPiOxNWjCQGJwePCPILbOhNeNa8a3BTISxsZYk+/nY0JxYFj+WZGVAYKDNWgjZF9qibUw3V4v5d023BhdYg9474amIUQqD7Ae8CMBA
X-Gm-Message-State: AOJu0Yyzw9XjNy6Si9bO73YDe5euE84GvCE1ewRgd4hHQ7W7kHefrynx
	H4MB3vnPYEz01aE8OKdQUHC0S2OJ9Bhjkd6LUdFgnC8d2Yz1frzX4MBV9HH23h5TJT5C6Fcpvma
	caw==
X-Google-Smtp-Source: AGHT+IGVBMX3VRVGfQeZAFri3EJldNitpbKjX7M4x/MlZokA6lrfP4O92MW0vVfpLiSUsrgNfaMmDg==
X-Received: by 2002:a05:6512:33ca:b0:530:aa4b:81c7 with SMTP id 2adb3069b0e04-5331c6ea686mr7950886e87.59.1724085003230;
        Mon, 19 Aug 2024 09:30:03 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6760sm649829766b.23.2024.08.19.09.30.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:30:02 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371b2e95c34so1160556f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:30:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3Vt88KaOov448U2yTCZ5/JmshdLOUxDanMPQ7GRS0f6eOMrg5vz8IeOZx5rlzcqbfxJriPeR9615gXCOwNglNT9lAKsHmSUAkwaJK
X-Received: by 2002:a05:6000:1365:b0:36d:2941:d534 with SMTP id
 ffacd0b85a97d-37194641714mr7416013f8f.36.1724085001389; Mon, 19 Aug 2024
 09:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818072356.870465-1-tejasvipin76@gmail.com>
In-Reply-To: <20240818072356.870465-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 19 Aug 2024 09:29:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W3OB5BUT=Dp5datGEin735+Bhhd+SiKazqdC-uW0ag6g@mail.gmail.com>
Message-ID: <CAD=FV=W3OB5BUT=Dp5datGEin735+Bhhd+SiKazqdC-uW0ag6g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: mantix-mlaf057we51: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: agx@sigxcpu.org, kernel@puri.sm, neil.armstrong@linaro.org, 
	quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 18, 2024 at 12:24=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.co=
m> wrote:
>
> Changes the mantix-mlaf057we51 panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 79 +++++++------------
>  1 file changed, 27 insertions(+), 52 deletions(-)

I'll leave it up to Neil if he wants you to respin with the
upper/lowercase done in a separate patch. Given that Neil is tagged as
"DRM PANEL DRIVERS" maintainer, the paint color he wants for the
bikeshed [1] trumps the paint color that Dmitry wants. ;-) With, or
without the upper/lowercase patch split out, feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://en.wiktionary.org/wiki/bikeshedding

