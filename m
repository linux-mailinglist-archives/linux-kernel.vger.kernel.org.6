Return-Path: <linux-kernel+bounces-399471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A72DD9BFF60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D318B21F43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9C199FBB;
	Thu,  7 Nov 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OHuNbvct"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8D7F9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730965765; cv=none; b=YZVgze+x/4uwQyECWQcSQdyZIroWiry1ukORjf5cuUL3O05zKL3Rj4o9+RdAXINGrReS42zN9sC95DsDQnG2PCYsjNfxieK/9AcsDLp0EIqDBOYvfpGobv3dWYlRB1Uvu5FzQ5pKBzZaq6OnB80MucIld92NTxhDEG2T2myrEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730965765; c=relaxed/simple;
	bh=Z5KIa5+EjcYXaQtJ5CUKjRCce+Nn4x5tsG3QRpALwRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT4C6UVkucZnSfkXdjrKx/5oKdcQaHM/oU2xQfygKq2xf7NaTlC0BUbnXSwjrfQ2dvaIbrPJKL58HGxeXlhXgLZrLFluBWL5QgRI6CpCAmq605aY98DST6yjKAlXwCD4rX3RbpAG/+Lqix4wmy56PC3ebmAAEVp7Sl7/oJuFVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OHuNbvct; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539e4b7409fso746348e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 23:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730965762; x=1731570562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5KIa5+EjcYXaQtJ5CUKjRCce+Nn4x5tsG3QRpALwRQ=;
        b=OHuNbvctu8vBzcDDUrwSu2OJvVy8Tkncf+rvvfNc+pbkub/JY18xzUzWqpa2TQI40D
         j0yxdvJxcGw34ZRr6/vtNBXAoQpWQ/XYAvD3aMFdsUsscFzH7d6Oy1Z7EeD2EKaCuC8q
         CKtQnuUzsKT9OxSCDQjruh9lNXDNZWrjW1Wbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730965762; x=1731570562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5KIa5+EjcYXaQtJ5CUKjRCce+Nn4x5tsG3QRpALwRQ=;
        b=XLJyUqqLLJeseeNuOa9T4Wejt+VHwfGSIKd6kXFmGDghtlndNSp8DA8N5gWw9M8hAP
         tFWnXG6IdxORijHD9Uz3AljF4oJMZ5sj/TeuVJSP1pX6EQeBzCM0utGMD6c8u3r865S0
         zuv0FYoYLHu+N1vCIxpI6dUj/G2wiANqbOHZvIjUiiAJEUNuu430WBQGhD/8DM80s9Xb
         Mjw+MSHUUkLIuunXoSJd2MIF1SXX1bwJ5Ox2J9AMBbQA8rj4W4vDuq6++M/7vEquc3gJ
         WEE6kEvhAR+0pAfE9sqwDWhaWKNHjQP8w6zMPeOvvUAdt9qrYzgy+3kcF5Y0JFJ3BtIu
         Sijg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+lf5j+vSY7wHOxenbgD2ErK//2TmuqV1g3mPO0MHXPLyl7BubzpP0B5XZxb+8oydvTaZ4MTtfXhG9LY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys22Drwlm8Pnnm3uPSV+KjZG4Ist7gUrLsrtiSg0rDYAaBUI8Y
	H0+fquR3DFlHGWIOTx7+2qogY7jvZH+jrRd5VlVyoCtGw9YycWTQG+qoaOtH3so1jvQ1tNsIxKm
	mxfaDlM9CPbtcpwwg82dlCpd4O/PJE1mdfCPo
X-Google-Smtp-Source: AGHT+IGxn2pSbneZDHgWnWUCDZaUop/6c6chaGYhHrU991goYLF9CZhKqopx6hRuSSwvbSM+DLDtcwV7tpySQOVxgHc=
X-Received: by 2002:a05:6512:1086:b0:539:fcaa:d0ca with SMTP id
 2adb3069b0e04-53d81971b63mr724012e87.13.1730965761512; Wed, 06 Nov 2024
 23:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107074603.31998-1-yunfei.dong@mediatek.com> <20241107074603.31998-4-yunfei.dong@mediatek.com>
In-Reply-To: <20241107074603.31998-4-yunfei.dong@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 7 Nov 2024 15:49:10 +0800
Message-ID: <CAGXv+5F3+65gTsmz7Dzrm3QchmKnTECAGzLwJW9uT5aM_jLeMw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] media: mediatek: vcodec: add description for vsi struct
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 3:46=E2=80=AFPM Yunfei Dong <yunfei.dong@mediatek.co=
m> wrote:
>
> If the video shared information (vsi) is changed accidentally,
> will leading to play h264 bitstream fail if the firmware won't
> be changed at the same time. Marking the shared struct with
> "shared interface with firmware".
>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

