Return-Path: <linux-kernel+bounces-412104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B59D03EA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3641F22BA1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78DD19067C;
	Sun, 17 Nov 2024 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpCVL7zd"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80C1865E2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731848243; cv=none; b=mIHq/GEpUufdpbhkHhZbdqquerNbACx0JGlI7OySdCHkGeiP/FalRWmKPmMVIqZ7526L15UyF+LgRTQFaSMk4cvhPb4LNLzCptdozTNS/NX2potBkczhmopScYAfZSdmc07cCguOXqutYHr8XwDdxqwmpygPCpZQxWAE//1eego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731848243; c=relaxed/simple;
	bh=6C2Vh6o628jIpNAhtgDsohB1br8pAS8SVtDQf4a9oAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FM/mtEa2FYBjCSTP4CjsXvCZb71N1HK5QAMtkIbcluh+x/LdEZENgnAzhiNZOwGoQZQqNHIYemxBRFBeiAlQL2xpgD2NvAqIUygPTkAnR8Tb72ByjY65Lpbktcxhahlpl9uY9FYEWCOz926mkiD85M+teZ0vRc42SlTT2oX/h/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WpCVL7zd; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6eb0e90b729so10417037b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 04:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731848240; x=1732453040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NodmpFT+qxaaF/PGLm9mRIZsGR/VQH6X8ujv94bXnj0=;
        b=WpCVL7zdHPiD5aSY5K6S7ElNDcKRprQAN3bsExpBtfLlnHjecB64XyEqtoK54GQfyJ
         3vhlRSBCl6g28OQR9zxXf+iSC/aG8URhIAbs06NNuqcIPFvt7QF/jAXMSCqZg0ISU+Lo
         38HVaZs3UuBnAXkLEj8k9u34KOmmwstD4CoLgOTVgLwlbXeybCNmxB+mAMXN5D7wvv+d
         vABuDqzjUC5J1B22MtHDb589hwEGpLX2CYyB6VAo7SRLtGCNpULQV8VkBQyBp9aYdZkj
         2g/PjKyrQH8e7RkUhWM9dbsOC4BmsOlMQHFHZVCiyQ3dPIeHlONcdyvQ21mzkGfEv7uO
         bc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731848240; x=1732453040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NodmpFT+qxaaF/PGLm9mRIZsGR/VQH6X8ujv94bXnj0=;
        b=kyEi5wxfrlnuxsXFz7t81Mb4jbWUo4KSJiVhnVl5CUZmS8m5nAsnCCOp7Bx3v+yPI9
         bB7hwzS6myrwAOrc0s3ENrvJK8RY2/EL7LHN9WpQgFS/50E6hFtBU4fcyTNrIsqu1CZ4
         H6Qh3BdPfLFcIz5kevh6rm71cqlBYFqt7PH3aMQ4VqeH4x8J6CvED0hnicgT/sfb3qVU
         4+LMZBSaGUyjN6NxjneNIpJeIUIs5mnObCG5IV/bim8lcVExjz4dHHZAGnhbWSpsRkyi
         S37KI4RHr0o2xIvKqqkQmlZ4j9SZ7yj5ye219N+XqEA+NL2uZ1r0hvyOy0bhWT9Mfg1W
         bTkw==
X-Forwarded-Encrypted: i=1; AJvYcCU7zOq39yBvIL9nD4vvwq0U92qsGuJTz2y9fBbzjAf2Y6L8iruu4w/OLygEiyzVLmDlfjds6s+fGogoLaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl9ZhnCxDO59Fq/aFq49oizwy7KZp+peIwHRa0erEBS72XQnUj
	P9UnmdCZ8XIViOgONqfWOsMwPLVZpndxLk+jA9t0RI9PJf8Rvjcx+vYTj34TCJXI88OwblDtgl9
	fruuzpUsyQY7BqPtNxidt87jSB/lwjScOyhbY2w==
X-Google-Smtp-Source: AGHT+IGHhP6z6uzaMe/SjD7VuC2yupm/LLWj/hEg1VYAOasj1HmGbygRyNh0RqshUk1xmkg0eGSyb+eZTIFDMSpJNeg=
X-Received: by 2002:a05:690c:4b86:b0:6e3:2361:df8c with SMTP id
 00721157ae682-6ee55f1c99dmr80383367b3.42.1731848240497; Sun, 17 Nov 2024
 04:57:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115091545.2358156-1-quic_kriskura@quicinc.com>
 <ibh3n7gl5qcawpiyjgxy2yum6jsmfv5lpfefuun3m2ktldcswl@odhjnmkj5jre> <51f7cfa8-3362-46e3-a9e5-e43d585d4ac0@quicinc.com>
In-Reply-To: <51f7cfa8-3362-46e3-a9e5-e43d585d4ac0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 17 Nov 2024 14:57:09 +0200
Message-ID: <CAA8EJpoxzEdJ5d8RtEb7a6=NHvCVhnisK7QLpqpp8EBHAvsBhw@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] phy: qcom: qmp: Fix NULL pointer dereference for
 USB Uni PHYs
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andy Gross <agross@kernel.org>, Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 13:51, Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 11/15/2024 9:29 PM, Dmitry Baryshkov wrote:
> > On Fri, Nov 15, 2024 at 02:45:45PM +0530, Krishna Kurapati wrote:
> >> Commit [1] introduced DP support to QMP driver. While doing so, the
> >> dp and usb configuration structures were added to a combo_phy_cfg
> >> structure. During probe, the match data is used to parse and identify the
> >> dp and usb configs separately. While doing so, the usb_cfg variable
> >> represents the configuration parameters for USB part of the phy (whether
> >> it is DP-Cobo or Uni). during probe, one corner case of parsing usb_cfg
> >> for Uni PHYs is left incomplete and it is left as NULL. This NULL variable
> >> further percolates down to qmp_phy_create() call essentially getting
> >> de-referenced and causing a crash.
> >
> > The UNI PHY platforms don't have usb3-phy subnode. As such the usb_cfg
> > variable should not be used in the for_each_available_child_of_node()
> > loop.
> >
> > Please provide details for the platform on which you observe the crash
> > and the backtrace.
> >
>
> I got this error when I started working on multiport support (begining
> of 2023). Initially I tried testing on my code on 5.15, hence this patch
> was raised on the same.
>
> The 2 qmp phys on sa8195 and sa8295 (based on sc8280xp) are uni phy and
> the following was the DT node that worked out for me on 5.15 codebase:
>
>
>         usb_1_qmpphy: ssphy@88eb000 {
>                 compatible = "qcom,sm8150-qmp-usb3-uni-phy";
>                 reg = <0x088eb000 0x200>;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges;
>                 //status = "disabled";
>                 clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
>                          <&rpmhcc RPMH_CXO_CLK>,
>                          <&gcc GCC_USB3_SEC_CLKREF_CLK>,
>                          <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>;
>                 clock-names = "aux", "ref_clk_src", "ref", "com_aux";
>
>                 resets = <&gcc GCC_USB3UNIPHY_PHY_MP0_BCR>,
>                          <&gcc GCC_USB3_UNIPHY_MP0_BCR>;
>                 reset-names = "phy", "common";
>
>                 //vdda-phy-supply = <&L3C>;
>                 vdda-pll-supply = <&L5E>;
>
>                 usb_1_ssphy: usb3-phy@88eb200 {

As this is a UNI PHY and not a combo PHY, the child node should be
just phy@, not usb3-phy@. See
Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml

>                         reg = <0x088eb200 0x200>,
>                               <0x088eb400 0x200>,
>                               <0x088eb800 0x800>,
>                               <0x088eb600 0x200>;
>                         #clock-cells = <0>;
>                         #phy-cells = <0>;
>                         clocks = <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
>                         clock-names = "pipe0";
>                         clock-output-names = "usb3_uni_phy_pipe_clk_src";
>                 };
>         };
>
>
> I was hitting the bug when I write the DT above way on top of 5.15 baseline.
>
> In 5.15.y, the SM8150 usb_2_qmpphy dT is as follows:
>
>                  usb_2_qmpphy: phy@88eb000 {
>                          compatible = "qcom,sm8150-qmp-usb3-uni-phy";
>                          reg = <0 0x088eb000 0 0x200>;
>                          status = "disabled";
>                          #address-cells = <2>;
>                          #size-cells = <2>;
>                          ranges;
>
>                          clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
>                                   <&rpmhcc RPMH_CXO_CLK>,
>                                   <&gcc GCC_USB3_SEC_CLKREF_CLK>,
>                                   <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>;
>                          clock-names = "aux", "ref_clk_src", "ref",
> "com_aux";
>
>                          resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
>                                   <&gcc GCC_USB3_PHY_SEC_BCR>;
>                          reset-names = "phy", "common";
>
>                          usb_2_ssphy: phy@88eb200 {

Just as I wrote, this one correctly uses phy@

>                                  reg = <0 0x088eb200 0 0x200>,
>                                        <0 0x088eb400 0 0x200>,
>                                        <0 0x088eb800 0 0x800>,
>                                        <0 0x088eb600 0 0x200>;
>                                  #clock-cells = <0>;
>                                  #phy-cells = <0>;
>                                  clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
>                                  clock-names = "pipe0";
>                                  clock-output-names =
> "usb3_uni_phy_pipe_clk_src";
>                          };
>                  };
>
> IIRC, when I tried using the above sm8150 dt on 5.15.y, the phy_create
> was (either not getting called) or crashing. Probably because
> "of_node_name_eq()" didn't find either "dp-phy" or "usb3-phy" and cfg
> variable was NULL.

Unless somebody backported some patch in an incorrect way, the SM8150
DT entry is correct, while SA8xxx is not,

>
> I can try reproducing the issue and get back again in a week.

Yes, please.

>
> Apologies if I have misunderstood something and this patch doesn't make
> sense. Let me know if I have made any mistake anywhere (either in my DT)
> or in understanding.
>
> Regards,
> Krishna,



-- 
With best wishes
Dmitry

