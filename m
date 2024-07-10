Return-Path: <linux-kernel+bounces-248033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02A92D78F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0D3283568
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A4195B04;
	Wed, 10 Jul 2024 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgBp41Pl"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B9194A62
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632960; cv=none; b=FG+xnyqB1/rVT82k9+KMY8Jlr9ZFW13thoT7BCC6Qj2GIfAkNqVT6smGK1DUPo/L59VD7xw1b+AYa+6dzLWTKVg4mWqGpH+mqF4drtTpsoxZNU5oPA0ubrVmHhJBqncrYA8b/rplAiQISxEAdzEaq5kfJ/YiYPPYLNyp5GWL2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632960; c=relaxed/simple;
	bh=Uo4AsETtYXAveM1Xc57Wf8CaUxSqYIgmAdQWMhqNmic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXZ4QHztt9dYO8kDiSwXSlchIxOw+9jimpbVUNKkj6+XdVPucozhLfDcd1Y07ywuoXE39ywAqf3sZcX/IfLeQ84pGd3l59CLuT6QX5JlwLNdAk2C0wwCcG7xq1m2ld/7VqiwbbXgZaTYxPcolKmHXBePpzJh4nGo5iU4PHRBbW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DgBp41Pl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b6199ef089so290726d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720632958; x=1721237758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOdeMjN8zn02u2RJwNFjQMEU7jlojgabQSgPR5kH/Pk=;
        b=DgBp41PlMfgrtnl8w0gmLYk3pxF1rm+Nk8hiVrGqLP+3/27YCM9clYSpy3gnZex/1B
         z+D3FxtAGevs1/9RygyzsM93vq9nI1AMHtPC5VWTF9vBN80Hz92jSJs4zo96JGcjLtNi
         DQodPsSgBQNb5s3vxLCO+g/Qs3NnzoALdEj8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632958; x=1721237758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOdeMjN8zn02u2RJwNFjQMEU7jlojgabQSgPR5kH/Pk=;
        b=iEdfLdA5GqboYJ301GXVHWhT+4p2aH5AxDOuCnnuV0kx12NDDXUXmEk6ZeBpGNNbyB
         KQPRj+Wvm1qC9E6rKiqUANF3G3csHssSZVNkhH/LHlAjZGwNGLPXV01SEvtbBqJUMK+X
         EuYJ3F7og7xOuOAvLKlyvLZYRPBL97mDxyskaXwCpAIauCNxcYn92m/qecjaBdvo1o1w
         ysYIv3zBXzJA1pNU7frbmLFNIT6HPNrCZkEGCwr0IFK5zZlypt6y3s4Tj1dhHUjKUYjH
         YoUyJi8MIFY+i1t8wWPddRkptbpnNENH2qcw3ichjHZStueK64DogH5Inbo/EOP9pw2N
         0urg==
X-Forwarded-Encrypted: i=1; AJvYcCUv4Z0k+eYYAGXY+OVgtTs651vy0BwAx2Pu1cXRCUX74QoHk8RgHcyJ5LWa0cQHyuCkqexn3vNBP0qndYyLqKfEAuztbwGsxg2ajMvx
X-Gm-Message-State: AOJu0YyO24/DHUhv+jryKj5glSSLneZw9Ab5d96LD2kZhlD5zjHbJoc9
	KPdKRYdidQ8CjSeWYTz5hk+Ao7E6WAbe5NxwzogQBHTnxlf9yERbjcRsYURWBKiBz1JOu3SRuL6
	kUw==
X-Google-Smtp-Source: AGHT+IFTzTnTeAdKEscCxRfXMcUFUBjGwTOsVBCBcWzJW6im4TYLNFn5oTTMNQhzcS4LbZ8e3sVGEw==
X-Received: by 2002:ad4:5ba2:0:b0:6b5:eea:dc00 with SMTP id 6a1803df08f44-6b61bca9528mr62867486d6.21.1720632958267;
        Wed, 10 Jul 2024 10:35:58 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8ad29sm19022336d6.116.2024.07.10.10.35.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 10:35:57 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447f8aa87bfso30131cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:35:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcWm/ddWWc6dRc7xKRSlrLsOSBz7dq7ml5kh3mIJMzW8HyOaxxTWGs24BwwNK0qJfGfN+UQwfpba8AGm6ZwRBfE7ZCR44OMZvZ9Gcp
X-Received: by 2002:ac8:7773:0:b0:447:d97f:9765 with SMTP id
 d75a77b69052e-44d0b00f42cmr42181cf.16.1720632956811; Wed, 10 Jul 2024
 10:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org> <20240710-x1e80100-crd-backlight-v1-3-eb242311a23e@linaro.org>
In-Reply-To: <20240710-x1e80100-crd-backlight-v1-3-eb242311a23e@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 10:35:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=rL9Jr91BXFX+a=X+SCjYX7vGhztbh9tEUVn9iLViJQ@mail.gmail.com>
Message-ID: <CAD=FV=X=rL9Jr91BXFX+a=X+SCjYX7vGhztbh9tEUVn9iLViJQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] Revert "drm/panel-edp: Add SDC ATNA45AF01"
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 10:05=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> This reverts commit 8ebb1fc2e69ab8b89a425e402c7bd85e053b7b01.
>
> The panel should be handled through the samsung-atna33xc20 driver for
> correct power up timings. Otherwise the backlight does not work correctly=
.
>
> We have existing users of this panel through the generic "edp-panel"
> compatible (e.g. the Qualcomm X1E80100 CRD), but the screen works only
> partially in that configuration: It works after boot but once the screen
> gets disabled it does not turn on again until after reboot. It behaves th=
e
> same way with the default "conservative" timings, so we might as well dro=
p
> the configuration from the panel-edp driver. That way, users with old DTB=
s
> will get a warning and can move to the new driver.
>
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

