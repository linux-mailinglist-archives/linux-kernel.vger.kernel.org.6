Return-Path: <linux-kernel+bounces-283896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0A94FA13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4704F1C21DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C5A19AA56;
	Mon, 12 Aug 2024 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGsw+X65"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4A1304B0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503535; cv=none; b=OWZ+Doe8MqZSmva1kqk33XpJfwbg76jfFq8N+UQUQRo4fNQXmfaOjyEm+wOs915g2D09GUBzONQeRpvyzonUfSX6rwB/fKqCmAYuggBpwIMKVsO26/mBUkEPJ82wbN0Zl9jB+OgYxrJetUhhqTX7GQzUyQs5YllzVOkvqB6VDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503535; c=relaxed/simple;
	bh=xYBrtbgvzkQ4GyvpSQQbdMCurCd8oLKiu1gJWQAyAxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcXgzleXSgyVkxXfywLXMiQUdJyaigg+vmWktXeKrB0WzKj/zu47vKbpa3n6OO1DvNbYoslwKK0DFCy8iLGN8lXgQptTqBHHaVtv4+Upgx478FShNP2U49JW2IFYTFF+arMNNJoeHU2HPbQmTS8YW70gsk62HTmhisuYN6nFtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JGsw+X65; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d067d5bbso320574885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723503531; x=1724108331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R5ybnevxBtj+R9uSFEmpvuFSAZVoFC8EhL88LHQQz0=;
        b=JGsw+X65+c8N7YYqs191bK5BnRDQREPlf/Z3dEtQIadzVRwH1RXklY5JX7BSkwfAzP
         t3qYW1i5yKx8RqyYIMhIQTVdCyOYAmT3HUNvLrU9lWBmU3clpTLC4D87/hY7Qy9PWAe5
         V1Jou8fkbInlR4/BR6kRU4h0lLQjr3iF6lcF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723503531; x=1724108331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4R5ybnevxBtj+R9uSFEmpvuFSAZVoFC8EhL88LHQQz0=;
        b=gCd2NA7vxsTpDQeOwU4GFHm6sojRor2HlCDrVoTUOhqXM0W7J42VIVZWDEqPJh0Jse
         QpKTG2PifTzM/XnQ9mSZBqaqkaweyOhZAnt9FsjNDXFCiykk5btyLwkHyFUiXWxhxsHQ
         REIxw8fllPiLJ7CBi/qRFBobErR7Gk4f7Hv1Jp2trUE62Yg0Ek6K0UASTgGTshJCnpPi
         JAAdrnMNWGwXl3RcRyPxa19ssGZUmE1ffM8wtml0felller9imPS1mDGyuPrND0scQGh
         LXDw6ePx3Nto5ifNZlj/a4iEbDrgenfYFDiTxF27nSGAhnVe0MI2SDRa3CV4lzv4cbf0
         LsEw==
X-Forwarded-Encrypted: i=1; AJvYcCVkLT2oyOhap3HCP+57j34OJWh0l055iNG4r61vND2N+FIn1WQeZ0mGdCsSZjrVyQIXYORG0DVz+6KD14Mm+y99AXoULXfLAKr7CXe3
X-Gm-Message-State: AOJu0YwNBFsJmdnQ8r7tfP2n0KH+9FoRd/kj+ygKmdfusU1i4uL8v/3X
	yD1Q9+qANcvN78BkV127CaZgWMoxtKp1nq1Da+WL9k6NKVMMmAdTXLJxwQGfAbvgRYiTyHqdG0s
	=
X-Google-Smtp-Source: AGHT+IEbykdu/FB6Ek+wT0vHU5nZ0t2L0d9HL4o29JLf+D/kWv9/BI/1ENaHR6ntbgyN1lpEZlic0g==
X-Received: by 2002:a05:620a:294d:b0:7a3:49dc:e6e3 with SMTP id af79cd13be357-7a4e15d6ce1mr176096285a.53.1723503530764;
        Mon, 12 Aug 2024 15:58:50 -0700 (PDT)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1a8129sm27105091cf.5.2024.08.12.15.58.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 15:58:49 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bb96ef0e8eso26013266d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:58:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUtFaU+Xu+Z7jTt8rXi/Z+OycjIRjzG8sog4rXn54ixxoUpTEppam5KCV3svueNWWXXApyWtpdTOEReMWw2nIifxxrxHhKupaZ292vi
X-Received: by 2002:a05:6214:2e4a:b0:6b7:9a69:f5f8 with SMTP id
 6a1803df08f44-6bf4f79c2b0mr24926066d6.21.1723503528446; Mon, 12 Aug 2024
 15:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810045404.188146-1-tejasvipin76@gmail.com> <20240810045404.188146-2-tejasvipin76@gmail.com>
In-Reply-To: <20240810045404.188146-2-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 12 Aug 2024 15:58:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xy6ce-E=MpAJ-gknc925vD+RwiatX4AZd-Z-EZmrcPjA@mail.gmail.com>
Message-ID: <CAD=FV=Xy6ce-E=MpAJ-gknc925vD+RwiatX4AZd-Z-EZmrcPjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mipi-dsi: Add mipi_dsi_dcs_set_tear_scanline_multi
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 9, 2024 at 9:55=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> mipi_dsi_dcs_set_tear_scanline_multi can heavily benefit from being
> converted to a multi style function as it is often called in the context =
of
> similar functions.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 31 +++++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     |  2 ++
>  2 files changed, 33 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

