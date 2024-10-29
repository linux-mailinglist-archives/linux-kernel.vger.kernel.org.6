Return-Path: <linux-kernel+bounces-387000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE9A9B4A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39504B234E6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E5205ACF;
	Tue, 29 Oct 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypGWqM0X"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C5FC12
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207281; cv=none; b=EU/uUw+icEgE7DfM3XZZMXLDXujS1THHG94Gx9yLYeyXi6BLPoY/p3bHHHtMyYErprLA2z7JDdX8ImCzUas5/bQoAVjwOOXGpDtLY04Ksq3V/hkCs9a/wr9YpDZorB758lws1XrZ5/2S+ZhIA2jziW+rjW4kCZ4MzzK7sBn/8NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207281; c=relaxed/simple;
	bh=85Ye0r9TZOBVlQMo4R1ybVd4JlhVObsGwckkiekjpnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M97nCyTR0H0FX9NJNxJZ1qa+pfrLxIEJykwiYe0bHtjm/3zEAxFxSEefonMJxoM6UJfLyvyeQTwIwo5vypSJk8HM7c8D6YV0zsKtkKhEXKWkHaQWFlfb8ArNio1wM2rgS9B0M6k6hGAEZwtyrbFjmfSK+3yhufyS18nMhhv8kAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypGWqM0X; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e35bf59cf6so61539147b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730207278; x=1730812078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KXHekSwgT6SRlnWvXoVmeTYgjWGAZcjIx97S+vgepj0=;
        b=ypGWqM0X/r6N9XIEbO8nAzX9LxzWTJZ5r3QZ8F72pI/0qhlx2sh26kzvz4NFNpOcts
         gQVwkNROD4du3bvfYAFb7v/xLHd0OKRKKMziqjv+G/E+zmT5yJBY46SqhZiED5MTtszT
         aGMW6CSNnk8dWBbrCdPu5L9Cn4y4jiGd0a1iAsdghVtLWSLWfq5oSiI1H97V9cBxS6qv
         e4dD3KJMd6ZuOjA1Zvj8k5CCN1S1edOYpNjfcXEU9GE3n7ccnEAuODgSraa/z9Hp/zf0
         u+MttfZRf5AOVxQrO3++8MFwpNsBz0N3nRUdrM5k8CIQ/QHe0TodqJOb+RpF7aFX0p8g
         Ce/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207278; x=1730812078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXHekSwgT6SRlnWvXoVmeTYgjWGAZcjIx97S+vgepj0=;
        b=h8HVCpatbp0n6H1jbEKZrTNF8aMgGKExp62Ayq8Qp4nM+V+bDfT8P0XTvQHtM2XY6u
         GDUuM8+D35GM6wDF75jvCuJdO54CbtNbUYXv6FIHoPEaBuO7rIHZaKyXvvIo1J/hixzS
         3iUYTzPrv/C99tzx8WDOV885OaNHMoFkb1IpddS+S0gyGcXhG4iIZOtMDIk7nA+/dKrD
         mog6eHN2U64mJ6mAzG12SYX2Pim+7MjRvXh9Xzg9omUL8zRp02ity+f6pP6blKAE8OTG
         yKchry4HD3RQmGbOjk/o1WtaQZb5A7Aw87ceBsj2MXuISb7DdAXPtd12XE+1qlHD5HgU
         vENA==
X-Forwarded-Encrypted: i=1; AJvYcCX/nxE8VRKG2zstHCCewm/36jOl6WC+Wii7YKbN6IUAKeaDGro1Zos3TKDj24+Jx39NeuTVoq2BjTADKiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzKP6OoYtg3Ru2K+KwBj/qubTlzc9sAkxlQk5mNMU0Nu1r1e9
	t2Z0NctxvqwtlACnWUJLxEGEEKadheY6d5+lTYxgR9tkTJ5tkqzzhFMBknvMW24osndlslKvivW
	J1xKpl4UvS3p11JocDISiUXheviZ0qc+JdRMdEg==
X-Google-Smtp-Source: AGHT+IHj9OTlxdJR8GjjT0lj9iYWjEfWV85e5BvOY8AhmVekrLVQxaevX3rMPvyJoLnemY99zIOi0kIpjYdxeNaL9eA=
X-Received: by 2002:a05:690c:488a:b0:6e3:c92c:1d57 with SMTP id
 00721157ae682-6ea2b66687dmr12809857b3.2.1730207278483; Tue, 29 Oct 2024
 06:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-0-f0778572ee41@quicinc.com>
 <20241028-adds-spmi-pmic-peripherals-for-qcs615-v3-2-f0778572ee41@quicinc.com>
 <j4ggfrynyoriseef5r5x6uwgo6cespll2np7uitc64yagoa6pz@r3ro2cpqrrry>
 <38cceae8-5203-4057-bd8b-f20fe3656474@quicinc.com> <ZyBF3ygQnIdr/k/N@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <ZyBF3ygQnIdr/k/N@hu-bjorande-lv.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 29 Oct 2024 15:07:47 +0200
Message-ID: <CAA8EJpp27RJa=6s2W6ks0aeaDONkYXq6xetSbepF7zR4zrFnWQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs615-ride: Enable PMIC peripherals
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Tingguo Cheng <quic_tingguoc@quicinc.com>, quic_fenglinw@quicinc.com, 
	quic_tingweiz@quicinc.com, kernel@quicinc.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 04:18, Bjorn Andersson
<bjorn.andersson@oss.qualcomm.com> wrote:
>
> On Mon, Oct 28, 2024 at 04:40:36PM +0800, Tingguo Cheng wrote:
> >
> >
> > On 10/28/2024 4:23 PM, Dmitry Baryshkov wrote:
> > > On Mon, Oct 28, 2024 at 04:03:25PM +0800, Tingguo Cheng wrote:
> > > > Enable PMIC and PMIC peripherals for qcs615-ride board.
> > > >
> > > > Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> > > > ---
> > > >   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 15 +++++++++++++++
> > > >   1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > index ee6cab3924a6d71f29934a8debba3a832882abdd..37358f080827bbe4484c14c5f159e813810c2119 100644
> > > > --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
> > > > @@ -6,6 +6,7 @@
> > > >   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > > >   #include "qcs615.dtsi"
> > > > +#include "pm8150.dtsi"
> > > >   / {
> > > >           model = "Qualcomm Technologies, Inc. QCS615 Ride";
> > > >           compatible = "qcom,qcs615-ride", "qcom,qcs615";
> > > > @@ -210,6 +211,20 @@ &rpmhcc {
> > > >           clocks = <&xo_board_clk>;
> > > >   };
> > > > +&pon {
> > > > + /delete-property/ mode-bootloader;
> > > > + /delete-property/ mode-recovery;
> > >
> > > Why?
> > Because boot modes will be supported on PSCI module from another patch,
> > reboot-modes are required to remove from PMIC side.
>
> That implies that the reboot mode implementation is device-specific, if
> so we should probably not define them in the shared file.

Most likely. Let's collect some more data points first. It's probably
not worth doing that just for qcs615-ride, I'd like to check how it is
really handled on the SAR platform.

-- 
With best wishes
Dmitry

