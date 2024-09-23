Return-Path: <linux-kernel+bounces-333153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95C97C49D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72631F23509
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4415B1917FC;
	Thu, 19 Sep 2024 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="db5wc1eY"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856241917CC
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726729251; cv=none; b=R0xm/FjiN0eNxKHcWHa/c7zA3heDSnWxEjsKPtlR+EUksqgGbgfQL47IlSLJiEpZAOd4RsOCMIHii7yQIqX1wS5lJhno/tpa2Nzcf3GD4N3K0N/wtujipDadypXv8TtrGMaU+rPMD6KGBDqkrxjhaheBoipaZwVYpxCJgaRSqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726729251; c=relaxed/simple;
	bh=ZlYyNBZ5P0ktQm8Ew7h76SoUodYtlPun2q8Ur1DRt9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U0rSe7l9p436efSJBSP1i68zYxpU3DpAUW9AEdc6YBfs3z1bAfAsfj4Yq5UKnyDARyIGrCvqEOVSURCDM8cJujRHMqjYvLhfd8L+Y3YRqfVwtY2QiWuUYbZREtB2LE6iOni6iukVCkfIK1+arS8URPfY/RYFlikoAL+r7pEYowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=db5wc1eY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c3400367so358670f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1726729248; x=1727334048; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXTjk3MDehwblSiBjUQKz60Il4rt1YUNHjH5GGI6KiM=;
        b=db5wc1eYQTZCBjDsjBpfLmNrtcUJjLCJfsDZtz1PgPMb9vS4pNMItLzCHKWNPgU3xJ
         Nkw673SB9AmPpJjLGLfAq1KpPdPsqznMQGTU5Kea3q7oMrSB7qTH0w5oo7/Wb9IPgevc
         J3bIiLB2B+yoy2GFZCB+15ZlLwR98Tyg0qk+gpkeS4Ru2jgsfvGYhJMzC4VSRj2iO5dG
         Baiv6cQPdGJ+6nf+F1BqbCCJMuWGGRf5z0rH+XDOE6kRr7smtqXeK6GDJspOZrvL7IIm
         siV9UNa/I1WXwuGtBS0ATcLZvtmSELeBdz36w8bBPECGrjelGndQEnEJ3ZlAkdPvdue1
         PBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726729248; x=1727334048;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iXTjk3MDehwblSiBjUQKz60Il4rt1YUNHjH5GGI6KiM=;
        b=CB93BwQ108f/F8U9WZd8nqgAmak9m2zPhy/ARENYaDFKSdMfBpqB2aW5nbalRzVwT3
         u2D/dnl4wef6yMRNZyLqQbbr79dc5P9253fGSL5lhucCM2Y7cdzFWkCTrJcJmxF74feO
         qy9rS5EeW+Jy1hjDSV5aUWmTu3puWV/0fZ2S193QdX8x0XLq5NkRH8cyWsdeHBU9CUVt
         TX/ZFbm6ue0ZDm3ceNMveecrDu/30xqCSt1y1j7c/L53Rmi1syV9xclnjb61tkjxVbT7
         Y3R/C32cdvGw0DKpGwo0qpv89a232XTO/nBDr5Vug93pHmswmDd5sovKZSujvlp8aGvS
         gPuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8DUYCWS7j1cV1V+sc98d5ZVw/LGMR27uDQmhqJnahKQkTIfvruCpBqaJlK1LKa0ylkcs38OO9omWMnJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBMzMC614LZQ+2D74gXUp2+e+0XSc49FeDJEcUQL9qFnvID0k
	+EShPlA8ZkLEibaTyfQWgovmeZE4cYu9selv/bGKJhrw88SLMmJFBTxLbf0lFSI=
X-Google-Smtp-Source: AGHT+IGZFFs5GQZVRNRIAHLuv8CZrQv/FXme+c78MPRgdmwHEZgUe9prJacZdcvc7PMm6QqyWHoGiA==
X-Received: by 2002:a5d:6a84:0:b0:371:8dd3:27c8 with SMTP id ffacd0b85a97d-378d61e2b0emr17599903f8f.23.1726729247809;
        Thu, 19 Sep 2024 00:00:47 -0700 (PDT)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613205b8sm674839866b.188.2024.09.19.00.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 00:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Sep 2024 09:00:46 +0200
Message-Id: <D4A2FKPTXHS5.3AHU7ZEKFVMGG@fairphone.com>
Cc: "Marijn Suijten" <marijn.suijten@somainline.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Konrad Dybcio" <quic_kdybcio@quicinc.com>
Subject: Re: [RFC PATCH 00/11] Affirm SMMU coherent pagetable walker
 capability on RPMh SoCs
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konradybcio@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <cros-qcom-dts-watchers@chromium.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240919-topic-apps_smmu_coherent-v1-0-5b3a8662403d@quicinc.com>
In-Reply-To: <20240919-topic-apps_smmu_coherent-v1-0-5b3a8662403d@quicinc.com>

On Thu Sep 19, 2024 at 12:57 AM CEST, Konrad Dybcio wrote:
> I only read back the SMMU config on X1E & 7280, but I have it on good
> authority that this concerns all RPMh SoCs. Sending as RFC just in case.
>
> Lacking coherency can hurt performance, but claiming coherency where it's
> absent would lead to a kaboom.

Hi Konrad!

You want people with the affected SoCs to test this I imagine?

Just boot it and see if it doesn't implode, or do you have any more
elaborate test plan for this?

Regards
Luca

>
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>
> ---
> Konrad Dybcio (11):
>       arm64: dts: qcom: qdu1000: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sc7180: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sc8180x: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sc8280xp: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sdm670: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sm6350: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sm8150: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sm8350: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: sm8450: Affirm IDR0.CCTW on apps_smmu
>       arm64: dts: qcom: x1e80100: Affirm IDR0.CCTW on apps_smmu
>
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi  | 1 +
>  arch/arm64/boot/dts/qcom/sc7180.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi  | 2 +-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>  arch/arm64/boot/dts/qcom/sdm670.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/sdm845.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/sm6350.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/sm8150.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/sm8350.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/sm8450.dtsi   | 1 +
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 ++
>  11 files changed, 12 insertions(+), 1 deletion(-)
> ---
> base-commit: 55bcd2e0d04c1171d382badef1def1fd04ef66c5
> change-id: 20240919-topic-apps_smmu_coherent-070f38a2c207
>
> Best regards,


