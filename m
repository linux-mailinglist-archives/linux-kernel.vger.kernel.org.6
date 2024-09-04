Return-Path: <linux-kernel+bounces-315686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D835496C5C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB801C21B98
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC631E132C;
	Wed,  4 Sep 2024 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WdytTgKO"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331A4778C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472387; cv=none; b=L3rLH31H+G9KoyKno/0P8qPBGOaZwksL1LqK76pFFcIfQCFiZj89V/igbNfwIUjUcyThI4etkkiKhI3TzXgSeUwDlOocGNCvIBD/dBML7jdCgSf4h2IbZEOafEEr0eiD4y7QvFpKKi5PzVXmXvbEdA+A0d2J4XN2tluN8iY++uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472387; c=relaxed/simple;
	bh=ywbijTZhwyt/6ij0RFa2D9Ro9VsCA+t3KXgXReAdAaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hV54Ilfvh5fUomo4M0unoGfrMnWMjL99tqZAG/8nD/Qq3FRT93NN2eTqPdIbtjFxr0lIWfTAHYxv4vesdJf1F1zUC2CHXftBiIlAuTlzAY3IfsKP9h2FwJHB3hzmuY8jRvq0knDeJ+jVFp7czOo0KztDgfQv0Wq68PGbXez5g5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WdytTgKO; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c35b545b41so9622446d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725472382; x=1726077182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdW1fsDt98LP9wqqPeshnNEnMDj0upLQiCewBOyDU1g=;
        b=WdytTgKO2EekMKhSmQ3vLBQ2G5cInrRSTbQiDBpiz37ipEsYYJ4e+hf1IQ6yzbf8y3
         HQh0me/v7n/urSpE8b5iT1DxAtBjMTb4KmA2tmG852446DCYlIqk5ivqcnmhV2+ElgQ3
         sj9Zz6ZL41bjHA/2iswj6l9FgvyD1WiA+ce2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472382; x=1726077182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdW1fsDt98LP9wqqPeshnNEnMDj0upLQiCewBOyDU1g=;
        b=WpIZo1nYDpgdZfsKO4HMP7Ae11HXFDd6t9Gz5HwM6m4jBsP7FbZYEfFMM72MMI6WOi
         7hzx28xQEviufrXMYhaGgnWNLlFy64vXK4CSrCLXwhTOVAig+ufQBLLRBJRp0PCGdoGi
         fmXk3ymLaRClAnycirc9Zd5kiBEPufUmQ8mYNCYn2MV8VZWPMeyP7Mtj49LzCKQvtaR5
         0+Al1TQg5qEQu0d3ZUVCWE1J6v+B8CLtH0EQcV+9IVc27BFVjfEPo0YuuzuTd+rpTobC
         vRxKMprvensYFEJ+PbakifCdUYBPtMsfB/J2wdxH/Y4oWd6tp101gnhB8UDmjRmXMyiu
         jIwg==
X-Forwarded-Encrypted: i=1; AJvYcCXhoRXLDfWUA6Zu+V35F3foKJiqQNvOe0jWwpsT//U4ubUTA2uKO976zSIb8K9XBjIuW05YG5XJKfVrXCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIJey1bag0pRAREuaAUF4+V3ZpIG3pVp/QTrhv3Z5YMj8e/Qq
	nKop8jjewcrVdY14TdOm4sw/Vv3VYqj2YR083TiwlhrCzNmJcTqmMmWHD0azLY5KVlvH4fF8j9U
	=
X-Google-Smtp-Source: AGHT+IGO/sbQZDHS3jWZypC9YA+WRCVZk9I3vNHHEvuiIZJyJfKPfWpQlPVlSK7ifCJwHPvqO5dsyw==
X-Received: by 2002:ad4:5c6b:0:b0:6b7:9a53:70e9 with SMTP id 6a1803df08f44-6c519221b8bmr53316586d6.17.1725472382378;
        Wed, 04 Sep 2024 10:53:02 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5202de5adsm297126d6.60.2024.09.04.10.53.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 10:53:01 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9782651bdso84943085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:53:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX66xDSXBlUmlE5Xg6eDh4vjm6F/rLuycbiuB0ryxi8KLcODrrCDFWmDChks9g5pBBYYozGiGiWB97i600=@vger.kernel.org
X-Received: by 2002:a05:6214:5096:b0:6c3:5ff2:7db3 with SMTP id
 6a1803df08f44-6c518def5f3mr55548526d6.9.1725472380537; Wed, 04 Sep 2024
 10:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904141521.554451-1-tejasvipin76@gmail.com>
In-Reply-To: <20240904141521.554451-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 10:52:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBDowrFSEKHq9Qc3rJ3kurkn4NeibAW7wR3_nCdvzDYA@mail.gmail.com>
Message-ID: <CAD=FV=XBDowrFSEKHq9Qc3rJ3kurkn4NeibAW7wR3_nCdvzDYA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83112a: transition to mipi_dsi wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 4, 2024 at 7:15=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> Changes the himax-hx83112a panel to use multi style functions for
> improved error handling.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-himax-hx83112a.c | 297 +++++++++----------
>  1 file changed, 136 insertions(+), 161 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

