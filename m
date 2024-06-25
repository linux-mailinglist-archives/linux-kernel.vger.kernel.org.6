Return-Path: <linux-kernel+bounces-228472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D732916065
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D69B2248E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964E5148302;
	Tue, 25 Jun 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS38ITQi"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4DA1474C5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719301853; cv=none; b=Q8RNQpk+picBUGXEVKsU+k3iG1LnERDJgZm4OYdb9bun+JPC7n3tb5KlOewCxoFV4psx+pHCI2cB/tKlQOq6eP3quDkPdgbaDkY6WMyQuubVHtc4CEbrBd/J98d15/JWLWQ93quSS9PCnqDNOUP6UG1FeXBeyoeMSySNWPEL/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719301853; c=relaxed/simple;
	bh=8jxcS8tRiE+LFLUa/aufartj472cje7N8ZY+g8JTF0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owlFwsAX/XsAn5PpMKKXuKaKJSolouTmYBA43u0N4KR54qtyZf4jxZuCG4vG+DU+9vjWr1bxMknC+SjRr6KN+k1waW2TckfieBrXLnLmuqETHK9klt9TzFYjMAjXLy85eDuT8+617Prmx5+xUyGqHt6kvSFYLqiHZg4AozQpl08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VS38ITQi; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e02a6d4bdbeso4744367276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719301851; x=1719906651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0RTZZV3+tH/geYdSF4ruzYz0JFAprmpnlQN133kk76E=;
        b=VS38ITQiRMwGC1+u/9xemE1zv0NLpgbDMwRTLRxiMb4baqTlOmR5E/+p7Rlcbtdkye
         ujeL7Kdhm4bwY8izNNZSApnCuyR6itlpnMJ03fCJ03Dl5+fvl+n5VphuOuS4X60N1SFA
         JbHpFuEjgSFQJLWMIm9SLKHHViUZKBDJWY/O9byjUr0Ew92kvgL/EpuJJ84Dc5ORUQxc
         5ZRNftUEKaq8CDNS2qCxIKhB+mhZCHpQrXq0EUqctGSIfsS1y73w8jFq6QwWE2T4FlPW
         GPL54RT2YxRfuuIAmAEm0DOHsfFjUUAG7S7YsuWKpcwa4bM0JusdTjOGO0yjcgHaHard
         qM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719301851; x=1719906651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RTZZV3+tH/geYdSF4ruzYz0JFAprmpnlQN133kk76E=;
        b=s6NjBWusNsDMu4RVC8z5jsFKaOK01OxrEDi8FFUcfTEOBoZfH9XpaJYngET6+KNee/
         D/BXS2HtKRew7qZof16qqXAltE5tdK7FLf/HUPX5beG35W58erSqjvBieahq+PIGlfjg
         Uzp7/Xn+V1BG3qYQm2BQ9/SLJUnovmMi/heO/HXkjCI2sx3g/5Dvi+HlDKra15g9Lwar
         i7xD/TlFSTpVgo7WcRu/Z8cA71uL+HsjqjWNPaTIT1MMCxIeSEvJvenhPi9xueFtJXnA
         jjWXrHDl/dqVFBEfiQlW+ZoHhSBvGh2grJjNVvwwVIJComiyPTH+CeDddm+O7E9nDea/
         qeIA==
X-Forwarded-Encrypted: i=1; AJvYcCWIBNIv6K6svB4hg3kZf4dw7fP3U7tfaUGyA0w3IJDWmqNAFwJJJS6jd1HWwJMAC2Aq4UtadcEmlHXgOSPp2mICgjeCNu4vaNsITMQe
X-Gm-Message-State: AOJu0Yy+kkjhlvvU0qBsfJmEU8RIdtB8U0l456XN6SZ9AjeG1HHpMwm4
	KgPNOjsg3Ge4Bq7PEqDt7jd/sYju6DEAyH7SM3f+8vQfnQMFEyoDaghZVn5eWS1GhgUNAPzsZyb
	gp1RDN/xW6frc7SaGre9t8VJw+/wvzcztrKfoBQ==
X-Google-Smtp-Source: AGHT+IGQ3OTSR0KC1/SpE/IADAGxFrimSZmnBj4lcnGkw++5Ft8jUp7w1CXLdHosE9cv9AXQbpTdIr7RsWD+lOF76b4=
X-Received: by 2002:a25:dc0c:0:b0:dfe:2488:c056 with SMTP id
 3f1490d57ef6-e02fc29d8d8mr7663761276.23.1719301851256; Tue, 25 Jun 2024
 00:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com>
 <20240417133731.2055383-6-quic_c_gdjako@quicinc.com> <CAA8EJppcXVu72OSo+OiYEiC1HQjP3qCwKMumOsUhcn6Czj0URg@mail.gmail.com>
In-Reply-To: <CAA8EJppcXVu72OSo+OiYEiC1HQjP3qCwKMumOsUhcn6Czj0URg@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 10:50:40 +0300
Message-ID: <CAA8EJpr3GYimirDz39f4n-3hDAxFWzo+9fdY6MAuxaNguouVFg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	iommu@lists.linux.dev, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, robdclark@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com, 
	quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com, 
	djakov@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 21:05, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 17 Apr 2024 at 16:39, Georgi Djakov <quic_c_gdjako@quicinc.com> wrote:
> >
> > Add the device-tree nodes for the TBUs (translation buffer units) that
> > are present on the sdm845 platforms. The TBUs can be used debug the
> > kernel and provide additional information when a context faults occur.
> >
> > Describe the all registers, clocks, interconnects and power-domain
> > resources that are needed for each of the TBUs.
> >
> > Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
>
> This patch now prevents interconnect drivers from hitting the sync
> state on SDM845.
> The TBU driver is enabled only when the ARM_SMMU_QCOM_DEBUG is
> enabled, which is not a typical case on a normal system:

Georgi, before I start acting like a bull in a china shop and sending
reverts, any update from your side?

>
> [   26.209151] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150c5000.tbu
> [   26.217228] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150c5000.tbu
> [   26.229926] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150c9000.tbu
> [   26.238008] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150c9000.tbu
> [   26.249068] qnoc-sdm845 1740000.interconnect: sync_state() pending
> due to 150cd000.tbu
> [   26.257127] qnoc-sdm845 1740000.interconnect: sync_state() pending
> due to 150d1000.tbu
> [   26.265159] qnoc-sdm845 1740000.interconnect: sync_state() pending
> due to 150d5000.tbu
> [   26.273189] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150d9000.tbu
> [   26.281206] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150d9000.tbu
> [   26.289203] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150dd000.tbu
> [   26.297196] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150dd000.tbu
> [   26.305201] qnoc-sdm845 1500000.interconnect: sync_state() pending
> due to 150e1000.tbu
> [   26.313207] qnoc-sdm845 1620000.interconnect: sync_state() pending
> due to 150e1000.tbu

-- 
With best wishes
Dmitry

