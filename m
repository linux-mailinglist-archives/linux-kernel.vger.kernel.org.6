Return-Path: <linux-kernel+bounces-560112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAEAA5FDE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9CA421C28
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A761D5AB5;
	Thu, 13 Mar 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaB2WuN2"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614616DC28
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887301; cv=none; b=NdQtPEuGl0NuJb5APdTfLu+xOjtqZFI9hailEVnaQAaK/i/PlwqkHgc3mEUrHZz+bd92tRhXEck8tJjMYg9CYQtyGiW5jAtiU5SWpsb5GWWS6ffJ/KlI1Q8xpTSEQepY3K+ZH1215DTEfGGJzXIQh/ssZGfBUk8pkAce5NFPk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887301; c=relaxed/simple;
	bh=teNW5gIZaqNNqnPivdYVGhV0iuN3q+s0pOAIQRfvUdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBiP+5IYp7ZBNTAhLj7gWpZ1PLBzDMvAUsjfjcFVjfva3EEQ9+BMEtES+FbJtXNSUKRDOe+uija/f7FABvb9SL2U8VbXk5+177P15gD4chzIi5AvKXVPGU//B2e49Hlki37vDiSsZmYJL9g4MXpP4sPIxQBid9loCfDtuus7DNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IaB2WuN2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfe574976so8244565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741887298; x=1742492098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oXkYzz2Ho7HoWYUA45E8jVGK6oEmHJXqvRS4IbzYytA=;
        b=IaB2WuN2w7gYjcHt1Uwp/c0H3IvM4cm2xe9st2dygFqSTtb8QhJfAaoI4J5/TzekFD
         8yyo8Gx4O7veB5CKFARZ1cppceVT3zLRZgWEwkAs/vT7sfLq5SKH+wKslk+bxGewCx7M
         tFmFfB2LA9ujzxcCdQbS/wJuGWs1GL4cetnngLE/BVrdZ6T0tqjSar9DQCHhdFDHH5xE
         Jv3t7J/7bCs36+OchcNEOnn0LJFw2sJsW/AK4Lhf9CK7aOf0HBVicIxlqxwyL6Q0LNCu
         bT1UnNAxQ9omQ4NKBlzSaLU/sp/JuD749GEOsa5czywnrJvc/ksKqieZcbiwf4zHP0z6
         3gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887298; x=1742492098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXkYzz2Ho7HoWYUA45E8jVGK6oEmHJXqvRS4IbzYytA=;
        b=coduOLWLFiURo5JkSmf6iqS4PFvVTVvKMhbubJUGdB6nVg631rHGe/rt6oGjca50xj
         xrK99rxDW3Y6ubHCgXSnyAGke91AY9C/5gB8Vk05KwadcX6BXqGbzSBGhFmE93rGgNHZ
         7ZvrTaKk0ODr7wY7Chs7/uVPmZqlQTofsjM4QQST1YiTLaO/jHmJkcILT8JEhGsgVXcD
         q0oK1y+ujS96SXOWgZC4onAS631Mh2xIeyM/3jViTE8KfgPaUbLXys7h7mont1NoMtKO
         SmbDlVfx+7BLVPGVHRF4xFSiXMDRkXTBux4E08DzgjwqK/MGJfnH/XgoOgNS7tGGWcTw
         8jBw==
X-Forwarded-Encrypted: i=1; AJvYcCVp/4/ohoZYq8/jcHVJMrkfykozuXtcF0tIJxCikq13DS2ELzMoqCcJRlO6DxXWA/mkjR5kgzgjjo8x7yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweXbVUgGeFaWs6DhAaKLLs4aYk/ClorBRGA8jQKveiSi6Gq5XD
	Qjm3zeoyvdMArhyQCQKx557dEFx3WtEW63wAQTeXOYhyKmuiMqiXJYkjumuuL10G8aXwOSpe+5h
	ZsQ+NlUSS6t7SOd65nLSc/mLhjOro7MM4p9/bxw==
X-Gm-Gg: ASbGncvJhitFTIo41FVEMU8YH+iWaG5/sBBv8CxB4yjUTUbYbCQlD8LRRbRCdWS1WC6
	eq5Sky9jxmR1il+cMlVUl7kTDI3XxKZSlA0PPrwRx0GITn6o5MReymaT5TkaNQdfy5q6gsxK83y
	I0fVKBh8iimvAGHpElOrTPMgPvo75QgrrsxVPIto1IihtLgpJnEkvOfpeEsM5HqfVDM5SOAQ==
X-Google-Smtp-Source: AGHT+IE1c9T0TY/pjJhjtchTkkrxDWqZJglz/azIkv2TkxGPgH3NolVO9vmQFRaJtQOUi7YI3c4g7vzs00zqUmzqNzw=
X-Received: by 2002:a5d:5989:0:b0:38d:cf33:31d6 with SMTP id
 ffacd0b85a97d-39263b006c5mr11690959f8f.3.1741887297667; Thu, 13 Mar 2025
 10:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311-wip-obbardc-qcom-defconfig-interconnects-builtin-v1-1-675b6bc57176@linaro.org>
 <CACr-zFC=mPNeeHMp9XnSby+cMQaPWt_3s8iUiCN+EnVPeGad8Q@mail.gmail.com>
 <uljqxwfgl26txrfqvkvzzpj6qurgmwcbuot7gu2u6rwjaqgncb@jeuyi4mexjff>
 <CACr-zFDSFizYmrVN-dV334n1kq17UB9k4FxrV20NNQCQMhzrwg@mail.gmail.com>
 <92dd35a2-d1cc-4f2b-b3a8-5752ec33b0d3@kernel.org> <CACr-zFCYWEFPO8yExp_8hOQdVtC9Zwu1ZOZNksSeyyS6Ht0e9A@mail.gmail.com>
 <Z9HjMyjzE9XlqrEj@x1>
In-Reply-To: <Z9HjMyjzE9XlqrEj@x1>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Thu, 13 Mar 2025 17:34:46 +0000
X-Gm-Features: AQ5f1JrDO9V43KtazVC9qZW1Wz_qdtZmiVsFJZOGkGi6dHNCT7HLwGuh8qsdaME
Message-ID: <CACr-zFAHGcQtwSz0EF0kt7_PUXxwi3GZY2BmAVedbLjh3+4LhA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm interconnects as built-in
To: Brian Masney <bmasney@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Brian,

On Wed, 12 Mar 2025 at 19:40, Brian Masney <bmasney@redhat.com> wrote:
>
> Hi Christopher,
>
> On Wed, Mar 12, 2025 at 12:10:56PM +0100, Christopher Obbard wrote:
> > For reference, I am working on updating initramfs generation tools in
> > Debian/Fedora to include the required interconnect modules. Currently
> > the interconnect drivers are built as modules in these distros, but
> > are not included in the initrd. That is where my confusion initially
> > stemmed from.
>
> From a Fedora and centos-stream-9/10 perspective, we have dracut
> updated so that the interconnect modules are included in the initramfs
> by default.
>
> https://github.com/dracutdevs/dracut/blob/master/modules.d/90kernel-modules/module-setup.sh#L74
>
> Let me know if you are seeing a specific issue with the initramfs on
> Fedora and I can help you.

Awesome, turns out I am wrong and the interconnect drivers are in fact
present in the latest nightly Fedora 42 image I am testing:

$ lsinitramfs initramfs-6.14.0-0.rc3.29.fc42.aarch64.img  | grep interconnect
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/imx
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/imx/imx-interconnect.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/imx/imx8mm-interconnect.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/imx/imx8mn-interconnect.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/imx/imx8mp-interconnect.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/imx/imx8mq-interconnect.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/icc-osm-l3.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/icc-smd-rpm.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-msm8916.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-msm8953.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-msm8996.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-qcm2290.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sa8775p.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sc7280.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sc8180x.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sc8280xp.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sdm845.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sdx75.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sm6115.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sm8150.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sm8250.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-sm8450.ko.xz
usr/lib/modules/6.14.0-0.rc3.29.fc42.aarch64/kernel/drivers/interconnect/qcom/qnoc-x1e80100.ko.xz



Thanks,

Chris

