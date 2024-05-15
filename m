Return-Path: <linux-kernel+bounces-180308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3698C6CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C5F1F21B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D616415B0E0;
	Wed, 15 May 2024 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VaVjYqTa"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2A015920F
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800647; cv=none; b=pOh0hcogtWdch/LJRwtJcsVeV4qGQonrigsdVvsjApySb8XR9R9Zfk3DA68jzV29cS70xrK3DAPuhad8Ac/ouuVkAkvQJkAG0fCfAJQkb5k97offl87er4+dAkq3g0XISjDNJFmTzD5zR5HhZ7IQOE1Dumyj7QZYkq+zcegqKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800647; c=relaxed/simple;
	bh=2wOSUNfTJLFeeO8pVhd+GkVyVWXNaK2KlYom7vpA//o=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqSQjrEDUM4q4aq0yaUTz4mMs3JVT/fUt9L/RyOCs2zVBN6hg2/FDAiqNcLU7zxwprIfpKaY3m1VVwIeyuQsRKuqEpepEtxdiXxtsWW+lPjhlt4YueiN9a0m/+/5LTwpVHBxEUM7oXNTcYCbxmhHdT9nxUzJJEerPcE5ecxU9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VaVjYqTa; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-df1cfa7f124so1134313276.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715800644; x=1716405444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wOSUNfTJLFeeO8pVhd+GkVyVWXNaK2KlYom7vpA//o=;
        b=VaVjYqTaqag5ahciEsniuQeiaaM1+WmSRLj7IXRyvHoUt2DH50yTedQ5Y+ummo9hEn
         8ibYsnVWXPkJrxQEpwQXEaVs7XGLeZFLK7BqoePSkso/7QRO87sDMaieV3dLy3HJfPil
         NCPGqIv2fz2hMHLsN1IVkdzj3PL341mKrhO2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800644; x=1716405444;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wOSUNfTJLFeeO8pVhd+GkVyVWXNaK2KlYom7vpA//o=;
        b=PBJtR9Ukj8szQrJpLaJTPWsOdGCZrkzKjaNNA9BmtrCCivOGOV6qF3Vc4g1u6eJw1Q
         TxnAFO+l+LGycqZ6YX2SSMxnkCO9UZ/ARVLbxFWznjG3Kzx0evojqHQyH958n5uqNwM0
         WHK7dsZYMsTxKm2xjrWgszM4zFfAyjzfauBGiy8wiEYoiACTexGHf1ilfLhQ9ZRojhF2
         HNZzydPVMmgwEyB6RTWvsvRmmefMJHp0g0XRe4x0xEe+jbi+7tGvpg+IPE6kp3GTE8wk
         U05Act1lwVY8UrplgvtqqpA9yqAzIK1LaBOkIRt/CbhxQ/+xwhEugWjdM5ZXLMOG4Vpp
         QJHA==
X-Forwarded-Encrypted: i=1; AJvYcCXYvmEOyHZSCt30OabhzW2+qalFulCbeURvRAr3WCCgm0Z3pUHCBXvYZc+ze/UQkm4uc4PHhWgbbecxrYZ9sbC0tNVvcRJ0gagbAYdQ
X-Gm-Message-State: AOJu0Yx2KqNPtL+vMbWf0wxxa9UYPL3UBvU+aCOGfpI9rQgEDKjJKgDo
	mMstroRpzlvR4mNAkJ7dQaB784kBNya4OQVlV98arcG9VBiDd1JDpCwXfagsjU92aFxMIyLLkdf
	Je7VgyyKQJshWbzjdC1qB0ZpmttQxGTiSMPal
X-Google-Smtp-Source: AGHT+IGovPGHDhP22BqWNaDOxfm72F+WXpO5BaZMtM00OAugcjSUU6eQQoWzKsASpiWzzblUTpSndz6EgU420El/kfY=
X-Received: by 2002:a25:2e0b:0:b0:dcf:3ef5:4d30 with SMTP id
 3f1490d57ef6-dee4f2c71dfmr15357241276.17.1715800643992; Wed, 15 May 2024
 12:17:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 May 2024 12:17:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240514-ufs-nodename-fix-v1-1-4c55483ac401@linaro.org>
References: <20240514-ufs-nodename-fix-v1-0-4c55483ac401@linaro.org> <20240514-ufs-nodename-fix-v1-1-4c55483ac401@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 15 May 2024 12:17:23 -0700
Message-ID: <CAE-0n52AYOgG7S3acMj4ZJOvAwNLvQnnv_P8=D+fMYZb0csoBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: Use 'ufshc' as the node name
 for UFS controller nodes
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

Quoting Manivannan Sadhasivam (2024-05-14 06:08:40)
> Devicetree binding has documented the node name for UFS controllers as
> 'ufshc'. So let's use it instead of 'ufs' which is for the UFS devices.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

