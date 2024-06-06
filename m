Return-Path: <linux-kernel+bounces-204614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 703BF8FF229
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE095B3093F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E11DFF5;
	Thu,  6 Jun 2024 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FzesJHVY"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458C198A0F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689102; cv=none; b=e5aJdvDAnXJVG/qSnJ2FBru9g1QYSnTiAUzjIUTxSrGYkZMBHrwD0aM0Kqm5EsWl8MCIwIQ6q3EFfwmH6v4+YPKAg74z2fjbGpY9qwCYVwVYJE2JTeF4JDw9BkDswwTdLOtfXOlwhy5BhVybagRcoNAp77VQOLsLTXuqvhrtF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689102; c=relaxed/simple;
	bh=vbFi6Ir0YQXvJY5W+Cjh8wTHOqNP+0lx+B5Yq8nTAaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnMqqzz4FLf88BpUL7JYq8j60esTg7KN2dU7Y5e+85P0vWZe6yHgOnZixbjAQC+18Mbp8vqfPkHgqe9Nxt/bsVke3mwiQqVWM0Zl1HylCZ65Cv3mh1EbSyTnwVg6mD4Yu2itGQA9EZOPMoikaqgkwnBFf9GorNaSxDnKItWDd+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FzesJHVY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6aebdea932aso4979676d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717689097; x=1718293897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTfArhgeqr5paLlpWgE1fa5MPN4uTVnEfjUxQhkMxkY=;
        b=FzesJHVYJ6WqRWiZ0TsfmAM75QPVasbxD14GdLRxzFbZI+rrOueXkYKQrqgS+OM83c
         clbB71DeGRgF/n620U7ykldqcIaNn2JyXVAqXo9H4ItWcp+oRCqS4O8VlJ4MS6duvsoT
         IKyT2NNguwALgb9+2C9PTmFrzToi+I4VSoELI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689097; x=1718293897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTfArhgeqr5paLlpWgE1fa5MPN4uTVnEfjUxQhkMxkY=;
        b=uR6uD881HPddZUDIsfLASavRcCcXzhSlVpEyzmWdAFeHduzSu/MA/nrtpeR1OxPwqK
         PMy0uxSbXFFk2HZbT68AT+ZF7Ve1iRT3eSueLnToDIFkMwrUv5yjjivESGBoZSU65kqz
         Q6Vx95wTS84mQLhhxw7EGU81ekBduzVmy2ziykSHR8kDXHdR7yDfDQNozCWX8fX+jBpX
         hoyzvngqVlfmRK3maNimgbKkr6/TBHcWWXwfSm4KAHekaDMYBx4owrqdwTpz2+aQLYWq
         iFEkz+0ohPfTAD2IFUymjqFx2LbDs/j61Kb6ly2HK0BAm7G5JtdylQBLVvjfy5+L8lf/
         2pjA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQPCiEzMbpcq1Mi5Dqj36iIgFAL1oxo0IfUV4cqKOqVUKFfj0IZPDJ4jsZrmrDveklcOYMPG4LMEpqkAM/Z6wiFDo5rG63X+Az8ak
X-Gm-Message-State: AOJu0YwSJvEcCue5R5cyF313Jzr2qy7orWVeVc54+ln908+vfDKwndla
	DJwxU7fdBn+VPYRKsm6OBR0mX83FEnbvnFxEnlYqexhEpCX2w8sh2rWwHsCeAnHtUEr7u4TDDaQ
	=
X-Google-Smtp-Source: AGHT+IGJpmuOU4QfQbVxzX6gT6LoJSexw5UG4u4sv2v+Sx6OWzOP0eCOvmQaSr+3+Zdb4pTDrp74Nw==
X-Received: by 2002:a05:6214:3911:b0:6ad:79e7:fe43 with SMTP id 6a1803df08f44-6b030a77899mr65681246d6.55.1717689096812;
        Thu, 06 Jun 2024 08:51:36 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f621413sm7404056d6.9.2024.06.06.08.51.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:51:36 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44024f5271dso366471cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:51:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8nYsq7X66yi6RxMkTUs0zG7sBXO46iLzh1csS7DUo9Kd/GGihVMVDvpJx3G6Ga1/0YmOkyGrooaSSDMZEvvshfGWQffOMIYAOlvOw
X-Received: by 2002:a05:622a:4d04:b0:43e:cb4:1d10 with SMTP id
 d75a77b69052e-44037247b8fmr3980461cf.14.1717689094600; Thu, 06 Jun 2024
 08:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604214233.3551692-1-swboyd@chromium.org> <20240604214233.3551692-4-swboyd@chromium.org>
In-Reply-To: <20240604214233.3551692-4-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 6 Jun 2024 08:51:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U9SX20Ckaa2VqwXk=jqjYZvdMMqzXd1jwucPuPXpKkSw@mail.gmail.com>
Message-ID: <CAD=FV=U9SX20Ckaa2VqwXk=jqjYZvdMMqzXd1jwucPuPXpKkSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7180-trogdor: Make
 clamshell/detachable fragments
To: Stephen Boyd <swboyd@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	patches@lists.linux.dev, cros-qcom-dts-watchers@chromium.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, Pin-yen Lin <treapking@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 4, 2024 at 2:42=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> w=
rote:
>
> At a high-level, detachable Trogdors (sometimes known as Strongbads)
> don't have a cros_ec keyboard, while all clamshell Trogdors (only known
> as Trogdors) always have a cros_ec keyboard. Looking closer though, all
> clamshells have a USB type-A connector and a hardwired USB camera. And
> all detachables replace the USB camera with a MIPI based one and swap
> the USB type-a connector for the detachable keyboard pogo pins.
>
> Split the detachable and clamshell bits into different files so we can
> describe these differences in one place instead of in each board that
> includes sc7180-trogdor.dtsi. For now this is just the keyboard part,
> but eventually this will include the type-a port and the pogo pins.
>
> Cc: <cros-qcom-dts-watchers@chromium.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../boot/dts/qcom/sc7180-trogdor-clamshell.dtsi     |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |  5 +----
>  .../boot/dts/qcom/sc7180-trogdor-detachable.dtsi    | 13 +++++++++++++
>  .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi      |  9 +--------
>  .../boot/dts/qcom/sc7180-trogdor-kingoftown.dts     |  2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi  |  3 +--
>  .../arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |  3 +--
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |  3 +--
>  .../boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi |  7 +------
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts      |  3 +--
>  .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi   |  5 +----
>  11 files changed, 31 insertions(+), 31 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dts=
i
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dt=
si

Reviewed-by: Douglas Anderson <dianders@chromium.org>

