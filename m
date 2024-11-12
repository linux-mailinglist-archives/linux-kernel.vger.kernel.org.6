Return-Path: <linux-kernel+bounces-406249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C8A9C5C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4E81F2318F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E766206055;
	Tue, 12 Nov 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cnlc05KE"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE782205AD0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427034; cv=none; b=bi9xc7fWiXEy1bl+87fjdjHDqWcZBOilbnMq7zXC7t6qx+wCNfS5pLNJV5kfXU5cx33OBC4pKtQZv07EKn4qvFV/wcrfLCnS+/AGk6UA+1W2zeY+RglwT2SZgIMBQiMq/ngm2hlzHgCG6WUdsPcxezMCWXyJ1xNCAAYu0LUgcFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427034; c=relaxed/simple;
	bh=1jjU2f1tjrQe5+VqBCl3RvHzuSsE0kITI7vbRrSnONc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdzTobhWKj8fL/P9GbNYPIO40hZCCRlRbGnBrBER6ZwPZcUefZ17wl9iiUvTVzOmBh1+Hf48U+ucif9e7RZ7ixpxzpnkf9/5roNwFg4BDHlXo7pHJ9qKeLS9HQOX0Jl/bcQGiyP1tN0CL/grU5U0ruxB7LkLEwM+seeD6Gsh09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cnlc05KE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ea15a72087so45389737b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427032; x=1732031832; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TUxAz/Z2gbXGo+S6Wkm3HXVMQ/72U6UPILm/sEMm+BM=;
        b=Cnlc05KEeO0fHQVvfFGc1hVDKVn4IPxTmHNYs6vXf//JRS02xDzU0//9TzcYvthLKF
         6rNKopAlTHGee3Hg0hwLaGharxA46/XreYD/tmgl36f+Nvk+sdnqEKX1r0S5Dgm+n0Ay
         8KBuRK8oM0uO2cJdZ2+Cenk7pxj3n6z0vG/tlH45N0/82wD6FXE8GQpDRjgwLJ7tzCH4
         zLVkTif0/yjLpxAXMxv0a3i1fOT8aJah8DeEuEwvIWRxq+24pR+yv7l9h68XCoMBrCXB
         tO/l+osPhoxNyfGEnumfrVXXNIBe3EaRy/DLzy0dxuQqUHFVGGNCkfCyhzkJuH+4nncd
         NhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427032; x=1732031832;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUxAz/Z2gbXGo+S6Wkm3HXVMQ/72U6UPILm/sEMm+BM=;
        b=tKzTCE10QiF/YlfB8Wkdq2e62IdPaBOi5SaTAY6DGVkg2R2NP9xvKtVa1Yj+Ov5T8k
         dnNNc8/T8J+kT0xQQlH9I8gE3M54XVIR/k2J6lsX4ft8jzfHbwnWLdqFH41G3V6HaUDc
         5+/0WZHLBGcdzxzsKMXckm4q4Mv5NtTmP3vYtKuhm9XY3FGlRY18UpYLDjZV2TNCBlk8
         9/Y9gDeDGUlbMxWTpfA7u5NzCVs7byv0CZ1PhO9H+AM090NfHsw3bdTsAlHyRBWGw9OZ
         7abXoQf5TsT9Km+DGJ0+3FR5c8qgiPmUW7qfySrA/z7vaimZHnAvmNdBcoCCji4W8FJR
         hvNw==
X-Forwarded-Encrypted: i=1; AJvYcCVTYoNFrQuSbJYyEF2hsBpf56oEVolulsLqULPgmzUIKktasfHF33w/EtskghJjga9YM90A6lwqxq9BPq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlW1b7x72GB/fif+7ZcKnX8aCX7zhy5cl3mkrDiuz5arHcpKR5
	un92JbDuZWDsuc1Su96ZrqgS9SD5PVMvdstTulCJI7roxxgQSdWMbB3Is70ZPjdcuhKfwKG0meg
	4iOJaCudfwUqdqYXXgUu7DgGXT2uq12qI8sABMQ==
X-Google-Smtp-Source: AGHT+IGxKvDCTnSu9K5GtsvLrHqik42J0uKIcJLRzwwShC9Gb+pV36cVlENq/Q4s/ju5EfTbb7FM2A5VXJd6NdZBAy8=
X-Received: by 2002:a05:690c:710a:b0:6ea:7e37:8cec with SMTP id
 00721157ae682-6eaddd74f16mr163974757b3.2.1731427031788; Tue, 12 Nov 2024
 07:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112002444.2802092-1-quic_molvera@quicinc.com>
In-Reply-To: <20241112002444.2802092-1-quic_molvera@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 16:56:36 +0100
Message-ID: <CAPDyKFptAh9fm8CBqKisQKg7Hb3sL_8XJC-GPdVXNJz5t2U4VA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pmdomain: qcom: Introduce power domains for SM8750
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
	Tingguo Cheng <quic_tingguoc@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Luca Weiss <luca@lucaweiss.eu>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Jishnu Prakash <quic_jprakash@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 01:25, Melody Olvera <quic_molvera@quicinc.com> wrote:
>
> Add power domains needed for the SM8750 SoC.
>
> The Qualcomm Technologies, Inc. SM8750 SoC is the latest in the line of
> consumer mobile device SoCs. See more at:
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/images/company/news-media/media-center/press-kits/snapdragon-summit-2024/day-1/documents/Snapdragon8EliteProductBrief.pdf
>
> Changes in V2:
> - squashed bindings into one patch
>
> Jishnu Prakash (1):
>   pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750
>
> Taniya Das (1):
>   dt-bindings: power: qcom,rpmpd: document the SM8750 RPMh Power Domains
>
>  .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
>  drivers/pmdomain/qcom/rpmhpd.c                | 26 +++++++++++++++++++
>  include/dt-bindings/power/qcom-rpmpd.h        |  2 ++
>  3 files changed, 29 insertions(+)

Applied for next, thanks!

Kind regards
Uffe

