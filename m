Return-Path: <linux-kernel+bounces-567289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D57A68433
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45FAA17C67A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1024EF62;
	Wed, 19 Mar 2025 04:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TwDT5kQH"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774921171D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742358249; cv=none; b=Yb9HLsGjDfAFrmp4AfCzyUoim6CdYJNQLB8o/GBsbT3CF+4yZun4xMwbvRoZlA7gFMPh4KHfFLzmVCBVAAwF8MZtZfxeYMkgLP6QubdTWe7fGW4LkDgKE0/gXG0VHAjQI+nS8fcyQn6ZxRgvnMMST3v98kKDq/1DvnZQbI82sfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742358249; c=relaxed/simple;
	bh=a2qNyugN9w/uB1pJA1qv4/kcNutyjnqoIx8nMHelY60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0yR7c3jl6ldAnoiQDeEy9rVA8xGob9ukn9yn2eVgb2yjvx3BkKBU48DwC+/DLb3kWllnWnuNLF75s6SLf49ZY7kfylvHySKfXKtIeW2u8hSJ+fkW4FQFcb4EOdkxAkCdLq7RnVGhJR4bxcFJVN7wd8x0Chf4RLH1d83wqgyefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TwDT5kQH; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so7625017e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742358246; x=1742963046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2qNyugN9w/uB1pJA1qv4/kcNutyjnqoIx8nMHelY60=;
        b=TwDT5kQHEcklNi9oBDswGarfPdqSLId8VXtGPpX8TnBwzmhrixtS0ubzF121bGusjo
         PD+c0JbT+hoOEycAuZ8kqLPPftddfha/pCHAVmqcrNmuECw+oivi/4eyrQ6B5bm1DP6H
         OI6Z09d/4xQQl4nuaheu77HVwuuz9BidE3er4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742358246; x=1742963046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2qNyugN9w/uB1pJA1qv4/kcNutyjnqoIx8nMHelY60=;
        b=tx6rC4/yS+e8GvHS+rs52QI8EiX78CrppJyWfDtI2CEOLs/rGU80XWaQu90jWDLyWF
         kp8cSy9XYUymQKBIUs23tPjgznevbrES/8Kkw7dByU+USao4IhlZ6i7NClDTa8Ce4kYd
         8qDhh6gSrJjHhZiByWScZk7QYrycWDNlvyrVxRtj7CWyVyfv3vr0MnvQuMoQv0yCRHsg
         /qIjyJAmGQfo2sa5NWLfZo7I9D1OlR9bu8be49oJgmLZIG1UpDnBEqfUwa8swcnPyTwh
         oJqtNdyrSDKwatGiV6i8pBA9EBNQdHW63rvyTKHKVfZ68lwDks2Hpi20RLAP6w4crupE
         x8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVPD3oDyQu9vhg4FeqRcPiDGJeXqM+9WJYRRwsOM/ffUqmUuKg8EXbQt2KDzhb/jypdFvp2R1XQ5XzG5ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEXSUtdk1kKV0A04Nr56iRsBrX3O2DTMiqvZpNgWBLDj+m7ap
	BKZGcpNXW/xBzS5OdatdoEYvB6kR8Rg+lnEZhKY8h+a7IxJi8gKaSvRvT92uFIimLAdVvShPW6B
	PU0fJc3t/c0aWvxgI9I86LYlMF7rFdY/ytHK2
X-Gm-Gg: ASbGncsEvfPX79ufH8L6CyCgHD1wPgdPyfAdF8agxFMDg8oczk84yHs/NAjHxF8X55u
	wsNn30Nua8wL2hnSZlvefFeBpm+cm8biTxAZUxAG8hEj9WBirOmkQXrpXBT+3eO0hbBt1963jYA
	1qVdac+z+mHXSIwmeGsJ+GtC/fo2t7q8X3EC/CxuJp2OQ1Zg0v3plx6w==
X-Google-Smtp-Source: AGHT+IEWZEscaVFUOUAsNjIprCbhq625oZrV53qjtBJsRwdVvGNmpIniSb7MX6P22AGKIV1DoFhBcxyYIRqcNBKHkLw=
X-Received: by 2002:a05:6512:2342:b0:549:8cc9:67d1 with SMTP id
 2adb3069b0e04-54acb2050cemr276298e87.38.1742358246305; Tue, 18 Mar 2025
 21:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318102259.189289-1-laura.nao@collabora.com> <20250318102259.189289-3-laura.nao@collabora.com>
In-Reply-To: <20250318102259.189289-3-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 19 Mar 2025 12:23:55 +0800
X-Gm-Features: AQ5f1JpqtWWWC0q87IWTa2_visyDIAAE7HlagkjknGbBQwFRTMIurzAoihaTquM
Message-ID: <CAGXv+5E-G0BY5q_EsxOkEEJvqXaX5=Y9PWqNbwysLEFfU-UmAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8192-asurada-spherion: Mark
 trackpads as fail-needs-probe
To: Laura Nao <laura.nao@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	bleung@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, chrome-platform@lists.linux.dev, 
	nfraprado@collabora.com, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:26=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Different Spherion variants use different trackpads on the same I2C2
> bus. Instead of enabling all of them by default, mark them as
> "fail-needs-probe" and let the implementation determine which one is
> actually present.
>
> Additionally, move the trackpad pinctrl entry back to the individual
> trackpad nodes.
>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

