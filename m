Return-Path: <linux-kernel+bounces-173874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B918C0713
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E0A1C2140F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7693132C36;
	Wed,  8 May 2024 22:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="niFLhDAd"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B79132C23
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715205836; cv=none; b=XONGuq9o+ZboMX24YkQT8h5X/vqJszsq/GHPhY/NjE01bAkbk0s8+zTbDjxu0VPc0AwBdik1esReR8A6HaWRYfmZdP6qXvmbyCRQmOWQeqmTIJuKoyiZNPDDHll1PKW1BdjE09LJnn88MNIuSAenl6IXcQFjSIMNMxwHzttZiSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715205836; c=relaxed/simple;
	bh=96vmw9sZP7htVh/QPL6h0Ai8HcoMhL+MI+Xk9QD2OX0=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j93AqqSk4pyL9ra/BuK/JTfXfYjp8ocYAkCqCIAQ71SfGvs295mMVhO8fRQUEX2XHRQxRgoWiaI2zHVZwm6kvCr8fGetN4GfmDsJiASQ1kTPpaJQTLX4LB373wjDmmDSyla3JLl8GfKczF1LIZ33bAvv3uf9iajRj47I2tmiSF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=niFLhDAd; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de45385a1b4so245320276.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715205832; x=1715810632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96vmw9sZP7htVh/QPL6h0Ai8HcoMhL+MI+Xk9QD2OX0=;
        b=niFLhDAdEWOSfzZEXWpD0nv7vClze8dbf+j4xkB2NgV8q/xCR82TxKPi/b6IcMPbeG
         z0QBMVeIsU8ss/lH/GXDX3YT+wA8LvXuN5/iDAoZR+dS2tvUHx53thGkkWZFpGkR6tLM
         NCwOSbz8wE2SbhGKB6+fKCn2hHAo2i+yVxVlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715205832; x=1715810632;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96vmw9sZP7htVh/QPL6h0Ai8HcoMhL+MI+Xk9QD2OX0=;
        b=fZ8N7iU0zxEL+goe5aybV4242gzdMOktN5QJCNXnUxgmczWjMbHBrD8bMkaId62frF
         FLaWq90DoWWr9Zb1tVtJiizK3+YZLOshbu/zzGsZDtDbVaYzajSnllXP4utvejuxyFmh
         rOlob/Q0RUtkmc62jy7bLX7zkIFuQ6lLtdljgOz3yJ2qbZ8ugdj47iSj64PCk1EOOf5n
         fzc6VZSarVtsak+HdJ2ebtp7WsdbTl6H/7PCBhdEi2cfTVDlwdXZE/wh9xjDur8HKWJU
         x3IlZivbBYNdOCq4PExVhJWNCSmQdA1t9QCO8UgC5FDR98wEUhNd3TRBlHqLSKvm3HJb
         f15Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSx865eVHM461ILJiQEruq9AQH2MkMNajEakdNaTzHCddWptJg9QrWjgRujSvG48/3eoTxK22a48X6heloNBebokaQ/gfEqvqCrPOS
X-Gm-Message-State: AOJu0YxI+FOfzyWwlXvnD2BIMQS0oWDxvOJQ64GeEWjVkbUdbiJTv152
	xHpoiNy+QyistrVCqllNPTgVA1ZZxSxxpZl0l4ymVyab6SeoqLLccGmwXQgzyl3xT7v0UpwGHDR
	+QcqaEN5RJOKYQvPHYwLMpCWMLAg6IWaj2fiy
X-Google-Smtp-Source: AGHT+IGV+P68fPaEtQm2PeJISJUIhS+PtZ4zxOJL+5m8uOShfZjtjoYC4aTyUsAJcLofHgE4zkZtzRKSS6k1GmygOa8=
X-Received: by 2002:a25:c549:0:b0:de3:ecc8:a0be with SMTP id
 3f1490d57ef6-debb9d8ce90mr4661286276.20.1715205832681; Wed, 08 May 2024
 15:03:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 May 2024 15:03:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506150830.23709-6-johan+linaro@kernel.org>
References: <20240506150830.23709-1-johan+linaro@kernel.org> <20240506150830.23709-6-johan+linaro@kernel.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 8 May 2024 15:03:51 -0700
Message-ID: <CAE-0n53sfgZhmFTE=a0HEp4n=DrfsTPhK865yWYAdji7tsi7wg@mail.gmail.com>
Subject: Re: [PATCH 05/13] mfd: pm8008: use lower case hex notation
To: Bjorn Andersson <andersson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Mark Brown <broonie@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Satya Priya <quic_c_skakit@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Johan Hovold (2024-05-06 08:08:22)
> Use lower case hex notation for consistency.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

