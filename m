Return-Path: <linux-kernel+bounces-180309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2D8C6CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4407281E63
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4615AD95;
	Wed, 15 May 2024 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ugk4nfFu"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25061591EC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800679; cv=none; b=ioUTvLDvEVQbRyafZfNGpiCQ3Vdt1h8zpPyVXUgcz3XGuJSDFotAsX211BKSzeJvOs2IfBhA29L5N63L9Rdn3Vc0YFqY/P0rdXLwuTw0KgYSlA3KydI6Rtsl9HqurqrDBGAGAcHCPo6zneu1GYZRpCHmisKkWydoAZaSr5cFm/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800679; c=relaxed/simple;
	bh=CPp/HTGSY2HiQLDatrLtpTGFshesDpce0Bi4vdjYKoA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxU6jEgpOodslRYg1yPbp23unu0PT0JSUUZQuxnh5SYskLa1IS8YUFsDw4kvxX+P9Gs4wlUZR7o/vNauci7oy3t32i97Ztmvt8dbsHm3hd5Qm5gEBbCV3OFeNdHc4+YM0YJXPMCRE13pxgRvFmHX7CNX5ZlHApcVjcczlrbEaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ugk4nfFu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso6768073276.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715800678; x=1716405478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPp/HTGSY2HiQLDatrLtpTGFshesDpce0Bi4vdjYKoA=;
        b=Ugk4nfFudEGnmxbeMe3fqOScBd2csDTdrrIrc553IfAIMJtcBbrY9xyd11GfZa7zpq
         9g8MesNTlkcq5BNdZyJdbG2ltgjJ6HeQHjF1PMlhJQW/o8QhHDmrJmwal5UtP/BQ5K9a
         d/YRZnPsUJnZAGkfgFNMAcmo85SqcBJbmRw6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800678; x=1716405478;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPp/HTGSY2HiQLDatrLtpTGFshesDpce0Bi4vdjYKoA=;
        b=wtA4f2Ul92a5jMZUhf+QoMCC5rWks6q8UiOMI87X45P4mkXYtQ86IkFCerUwjYmQ0K
         eTaQBe8lMTDYBaxh4Zq5fhMwbmn9r8ZkTRxfEh/6N/yrdigfg/UnmUGPCE2fNEv1VeCU
         TzvWH0p2LQS3E/zmsrQDcKvv89us4gWrXgmyO+CyTsimn7n6//P4xU6on0+IMdao+vtI
         RRhByGlayBRI/AG3iIOnGMskzSznr3VfioqHkUVG45bUx8/vBqIKox7dT5l+o6eqcB/0
         ZJ7uZss3a1bVdM8W01IabrusRuTnFl1PcFQRyTUfCxN8UENvGggiBHz+myy74K3KuzYp
         1vqw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+nn4JSaz/BfyUrNzbh+7KoWvyXAp5tXPfKUz4q44sMt6YbEzTaXHD2gWENfTPoAFVVBa6S0MC5cXnt3yH20w4QfUzQbWX7yOI0O7
X-Gm-Message-State: AOJu0YxMaxx18y3ZgSd6ry9QvtmBo56pMhuT7BXkA+5HNweB0G5IS4f3
	+MllHaeW/Evz+HUbj8J3EyvHFu2QnkbIgLwszY2y7IjqSP0KA4IRJj6Uocv0P8ICXIp6o/3eYpW
	qNjz1FxYg/i7kzTrmYX98jlHPlF3+7DqG+q7N
X-Google-Smtp-Source: AGHT+IFwkFXVASVtHHXe54Bdbs+H/MUnSJ+K2O/gJn4A57/o9XwLM5LjW5jlvs0cYMn5hlnXOzinjk+dbmRrXQRVB6Q=
X-Received: by 2002:a25:900b:0:b0:dce:fd56:b213 with SMTP id
 3f1490d57ef6-dee4f324ab4mr16873966276.7.1715800677723; Wed, 15 May 2024
 12:17:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 May 2024 12:17:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240514-ufs-nodename-fix-v1-2-4c55483ac401@linaro.org>
References: <20240514-ufs-nodename-fix-v1-0-4c55483ac401@linaro.org> <20240514-ufs-nodename-fix-v1-2-4c55483ac401@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 15 May 2024 12:17:57 -0700
Message-ID: <CAE-0n50nygK8+0yVUx6MQPwG7+07J+MuGcN1vx77RPZOipffPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Use 'ufshc' as the node name for
 UFS controller nodes
To: Alim Akhtar <alim.akhtar@samsung.com>, Andy Gross <agross@kernel.org>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Manivannan Sadhasivam (2024-05-14 06:08:41)
> Devicetree binding has documented the node name for UFS controllers as
> 'ufshc'. So let's use it instead of 'ufs' which is for the UFS devices.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

