Return-Path: <linux-kernel+bounces-295782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E695A170
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1837B1C219B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACDE14D296;
	Wed, 21 Aug 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXXsHuD8"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DED513D8B2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254523; cv=none; b=NmpWrDT4QcY0GDn6HBrX/7p3A+kO0MqSoHZTmrKRwQgjVc2bcIBVOLpvcQ10kOzNP7w0nrZ38JpqHJJdpC35W3eqU2X5XvOj4b9SMtWq7tvkTuZRhU34l46gY2hbSpJB6gqhGDv7fGWcBcmKfLUDSYR7lcscbzeHrGcAb2fsg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254523; c=relaxed/simple;
	bh=q0aRixnhWUWpxjM3Ck4bjrpb4pe7AI96MxRCxkxtVwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hf99U1plqQFB9vEX0PviSEis18ez1B+oc0GddzE6HO7ZBkftH7pd0QlqpKcPCbiS8EoxmUIYk69Bm/rhCw8KyGYCuIVNNVz68AezUx5BSBnlfonjQZB/Izx24J6U4SomOZn/h1clx69xKsbtOKYQ4RCovnqhpQBx9kfMTHpQAPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PXXsHuD8; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5c324267aso3956810eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724254520; x=1724859320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B92SIehQD/sLMBWjePhjq8cDV+wlqZQrnnvx6Bm71co=;
        b=PXXsHuD8muxBu9u7zISm/280RncJXoB7bBQbyDhwKHMlVmEuc/BCXqyh2l/i57uE/H
         fpA0qchv5IyhMZIan0fgEzcAZcB/cWP5FeWguolLSMb2v+S0C8all8ZwXhn7nMJ+24a8
         +q+KEW9xVxw8iw/rgxJWBU4jhIzCq6IqGfySZtxopgBw3lGHYb5Whvsab6tZFiBB9cd7
         t6IGpxGZy6VFgsRrvIvl4y71yJKjoKpvTyNgLZSwi/fkoylfhwmdYtyL2pk9QyjUKARH
         KrAbnMOYPY3YERhnibbFt+PRYgrdnD0rNyeyNIMvMKj4UkARHddu0WkZa4KrzRybg3K8
         zcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724254520; x=1724859320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B92SIehQD/sLMBWjePhjq8cDV+wlqZQrnnvx6Bm71co=;
        b=flDzv9AHXFA2gq1s0tq0/JcoWxy/tSn5IUANErUAqkIwZj3MLVj1/r+Eyxdf92VeEw
         EmeCJNy5kmApnKILUDZAEclh6K5/NKjJhYhBgQ4Hqt4D7jIJnMM42xMoifkS6vu7ZxBV
         kXjdO2jzIe4XnZt0N9BqlQHQTaEDJcikter97NeOBbnEETkEOhQbWEuTI9Npzz3zuqDE
         LBNoDKygh3xs2Z/6DM5AjKoOe2Wq8n9F6w+BVhn6lRjbsZAX5cRFAVI4/42mukrVuSVI
         eMvG4hJEiQKeI3oXkUjsVQRm7m0WFjHgvu4cSxug8/gukflsnHaMPiR69ZNwAcANLijc
         ry5g==
X-Forwarded-Encrypted: i=1; AJvYcCXE/jDUYdXQFb/k35PMbZDvEsXY1RxHcdoQ6wmw67xXLrCwbrEyJayiLbkdcd3AcdTqb8OEFCfa+5cvaWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27Pi6dHlDfkvwE45S4qdDmWq4SyE9+DRNEoOAq/KrLerNLGgv
	wHf8VuPt9HqUJhpYWnkCMMzmzqzpc1lXJwu7x9EGF/DY744w3lFT3CJuxZTHeTwOMqEOEp07mm5
	wXwzj9N+RLkMyggAyna/fwpeDCv0oyW88VBdJMA==
X-Google-Smtp-Source: AGHT+IHtjLVFoilgrnbbIQMVwq05/DqJA4CW2+AENaI/70z5AgIJxpdFSd6TduzT2Mi5cnCvDMGVL39BMCO82c2hHq8=
X-Received: by 2002:a05:6358:310b:b0:1b5:a060:678b with SMTP id
 e5c5f4694b2df-1b5a265b26amr290392655d.3.1724254520067; Wed, 21 Aug 2024
 08:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819233628.2074654-1-swboyd@chromium.org>
In-Reply-To: <20240819233628.2074654-1-swboyd@chromium.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Wed, 21 Aug 2024 21:04:43 +0530
Message-ID: <CAMi1Hd3=1S0Jktej0vv0ZJna1Z=Kb6WHEzpbxuHFHdCaEUKWrQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] clk: qcom: gcc-sm8550: Fix shared clk parking breakage
To: Stephen Boyd <swboyd@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, patches@lists.linux.dev, 
	linux-clk@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 05:06, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Amit Pundir reported[1] that a recent commit 01a0a6cc8cfd ("clk: qcom:
> Park shared RCGs upon registration") broke USB and audio on sm8550-hdk.
> These two patches fix the issue by skipping the parking bit of the
> shared RCGs for devices that can't run so slow.
>
> [1] https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com/
>

Thank you for the patches Stephen. This series fixes the serial
console garbage, audio, and USB-C host mode regression I see on
SM8550-HDK running AOSP.

Tested-by: Amit Pundir <amit.pundir@linaro.org>


> Stephen Boyd (2):
>   clk: qcom: gcc-sm8550: Don't use parking clk_ops for QUPs
>   clk: qcom: gcc-sm8550: Don't park the USB RCG at registration time
>
>  drivers/clk/qcom/clk-rcg.h    |  1 +
>  drivers/clk/qcom/clk-rcg2.c   | 30 +++++++++++++++++++
>  drivers/clk/qcom/gcc-sm8550.c | 54 +++++++++++++++++------------------
>  3 files changed, 58 insertions(+), 27 deletions(-)
>
>
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> --
> https://chromeos.dev
>

