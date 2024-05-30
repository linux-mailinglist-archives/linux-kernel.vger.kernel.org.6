Return-Path: <linux-kernel+bounces-195424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070648D4CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8B7284730
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD1D132138;
	Thu, 30 May 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2pXEVbgt"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776E17C22F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717075843; cv=none; b=Pwbqd8fkHwbXp7Xe7kmVY5nTK1mqo4EUQ3tPt7MO/5ai2e6hszux10rfDRUKfNDYCEFuaoTbm7GJ3KRqSCkTNhQLRJEE0sIPwlES/Fy3Jtn3DMrc2VwI698LiS5/PiwQXE03H/lJkAjIxFilM9KZlpvdRbqb0dYOUYpTm4cg9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717075843; c=relaxed/simple;
	bh=EbCIr2vQd6v/UepcBv0vSQxRCcD51fuU44nOE8Zqcjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=om7EEuyztZSVq51VoCYpyEgAfXCzx1WOCrrKGJxSb9L2ZcJysKyjJB1v+wmz+6GosUQdaAoSMlzBae/4ErpH9kcQGDqbzmIROj77x66WJXFVhisEtl5GOCQJ1FSR7rLvNhtDnXRy57pgbmPUpn4N3BIMMpOvEJ8GmnvaR323yTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2pXEVbgt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43fe3289fc5so279241cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717075841; x=1717680641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZXkKgvuTnGu9jT+KUX2KYjiff1KxpNRdNPNMddfEKw=;
        b=2pXEVbgtfXNQJ5sh1DI8ef/nsyKgQYPEqb3anFO4GRJgSXCMSvuup1WZ8Hp0Lpi7W/
         UdXAvRY+PsZnPBMLTBtPsCGjiXRHCa5vEXsVvkB5Ob3wqfwos8v9raLid2XIgqkYaPp9
         i5qtTcGFXJSvYRp9/QzMzp2MLtsGmV62jMgSlmYU+Q6U5puBVf5j1okpy6XbZs+59g0A
         ixn4v81VxNAMyZx9++924/+D+lcU2B6izFXzj6HztJ1aUn59zV/D9eMESBgmfIEgrS8I
         bpqNWb/W0XTk7A0b2/hwheYYSUzaD+oNxV31J055d3AeBfUNFogJGiTOxRMKcJDWN8Qp
         YKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717075841; x=1717680641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ZXkKgvuTnGu9jT+KUX2KYjiff1KxpNRdNPNMddfEKw=;
        b=ISIFPura3XAUCdbmaYmS9m6VHhm+gmUblvWEx2hnwt4+9jZh0P38fzgwB/o6Twvhx9
         ASni/olmN1cchSrSjX0hS+Y1SFmz6/RLQ+yGCjKisVEh05WNBfHnMWjr/dWWo8bNPqd2
         Z+pdHbHYKKvB5M0hn8aRmQqHzKAC+VSS74eUuORFKZhc05UE0RPgMb/nIoSeQLuaGM4H
         6j6JDARVmgQheDA1pKb2pSC07pHna79b9ysmIVdZdFGLCkR5SHrI7X7DQ2rNQHj6vSbI
         1UQVGQWsZt5PN2myUBgQX73a+XnRc0L93lgOnraXJv17Yd9IlvwEvAPnrkoez6EVRYFC
         hcHg==
X-Forwarded-Encrypted: i=1; AJvYcCXd/a5rDzDp9XRaxBvqkfyNUgh/CQxSSO+KWenJyep+Y+lVDT7y3Sm1EOgpxfPuDsFRq57XIY4Gc/IQBA+52fW+aMkCVOUAg28QX+DG
X-Gm-Message-State: AOJu0Ywm/sCKVUfozOhGqLo8J/Ze0l2btNw19wT744G3p0/P9/V0tsN+
	scS8FyIw6EP1zQIuojOdPMk+AFVEX94yEL5JG8TSsFXna4fK1kgARl1Ls3xqoKBcrW/d6EFSMtj
	f0dtXtRbx9yiQ+AwgwACBDUYGhNaFRvsqRT/3
X-Google-Smtp-Source: AGHT+IHp6ul6mGglbYpgjttSroYSPr1ojKdlWjH9/BeOaHLo+Qgzs0pC8gze9GA3WkL92NKLQXVOpcB9uIriM6v4gDU=
X-Received: by 2002:a05:622a:510e:b0:43d:e294:3075 with SMTP id
 d75a77b69052e-43feb3a29f9mr2840601cf.7.1717075840883; Thu, 30 May 2024
 06:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530082556.2960148-1-quic_kriskura@quicinc.com> <20240530082556.2960148-2-quic_kriskura@quicinc.com>
In-Reply-To: <20240530082556.2960148-2-quic_kriskura@quicinc.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 30 May 2024 06:30:23 -0700
Message-ID: <CAD=FV=V1Z029z08j3ppTyHmHEZ_MpN0WKDMGG7GgkH9rieUiow@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sc7180: Disable SS instances in
 park mode
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 30, 2024 at 1:26=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> On SC7180, in host mode, it is observed that stressing out controller
> in host mode results in HC died error and only restarting the host
> mode fixes it. Disable SS instances in park mode for these targets to
> avoid host controller being dead.
>
> Reported-by: Doug Anderson <dianders@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 0b766e7fe5a2 ("arm64: dts: qcom: sc7180: Add USB related nodes")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

