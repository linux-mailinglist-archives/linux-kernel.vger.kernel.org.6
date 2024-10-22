Return-Path: <linux-kernel+bounces-376356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6409AB035
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41971C2217F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70B21A0AF5;
	Tue, 22 Oct 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tS056dqB"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17581A0737
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605370; cv=none; b=EYM5b0hCfJ5b86CfIEW5/AKxgL+H5y+dvY29sWwK9EHi2ln0SFSOiZuPGp07BcFdpPGz9LWtEeGHjFjqub8uRP6i3EVJ6AjhrlQfZnHsS37RBXQFJ8b0I1c9V+pFh4ipiZYTT7TMgE3uo+xwSKRyr/ym5E1L1zWhkQqc/pzEiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605370; c=relaxed/simple;
	bh=/pS5vqqoSRD872l4pw+0rXrLxLdDPnIUcYWrbdyEl+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRf8BFsOWs1dputcv1wjzbptl9iI1bac2fQKj8s1u4+n2kZECDHAznDv785dQEHCmgyGcskFne6zDYBJwszpadT2YOdth/vdQJI7mWadtNliF8GnJDuLc2Ugn2b/RdPgeqnSmy5zdkKVHZRrWsrOtxNHxRoq3LMkpsLH60Myhtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tS056dqB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e3d7e6f832so54560177b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729605367; x=1730210167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDLtvhMz6PcWfZhVz6kUWAuewo8GBV/2rwOJwr5Q+iQ=;
        b=tS056dqBTKGzg23vC6WAfeoazPOS8TnK5xrLI6Xs7otPTl2sBc9CCoY2UCyAKYDq6f
         xzC4eGpXtV8xi3X2FfyFWEKM0KyMNXFSbbzRQyiTPP2AiaTdwUBALXzpfzVVg5gWYoUV
         qkiE8y84xpU/UE0ZVKn9PoLW1Tp39CI6qCosvAJjAsTG1NaJP7dcgh/hiv5ERs8JFuNL
         OMgCyVSvN0PEY/HbRttkuvnMmatMIpCvydZiILma/+o374/+0K2msBuiR6Q+bByrcJCn
         xbNrYJsPWFU15f+YwIzx//+nB+Q0V/ZSrwYFSWk/y+BI0OAbjC+PugkMWg2Jveos8XYD
         94fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729605367; x=1730210167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDLtvhMz6PcWfZhVz6kUWAuewo8GBV/2rwOJwr5Q+iQ=;
        b=UdoRPAbnIWXqMgkO7E02TP0K9MNC7MOcChdev+txlp61iHj6+liyHIRqKBB28yadwc
         0Wub7sPNr7/Mb+mbzwD04OdjQVv+gJLSR/mNB+QvaRfhcYehXVHzlROdmJth4FwoN0L4
         HhZ3fzR0uhDm9PlG5YUKT+VGMls5aK52/cuFnsO4NzHjOzghy3kV56LQASP5gIbkNXTJ
         YXiUR5emxK5erLlC1sS5VrFN1uP+eECGEr/VJxeI1lf78nctUC+oAoqMJI30mH3MTgpF
         g/sIjc14RbOWSLiDW1ELGhVT7PzopyFwbUBMqyI+JYG4KSxJJt222espGokg7XwFIrSR
         nNbw==
X-Forwarded-Encrypted: i=1; AJvYcCWh9mxaojNB//ONBKHutZNID+haHSiIst65E61R5nj3aDZg5iXfiOCteD3FJg5YjbCRympzq5D0F/OFYNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdEtzPiTyKo8+i/JfPKWFL/XjtUMgMeJXjdWgfh3vH5SUyaZV
	zG+I0Xx8mwC9SevZHZdJuvzjOApNDRVe95WBC2jIhiikN2hVKRqNo9X2fqZfCYIQd6mQ5aVbOm5
	KP+72X9KOG1CWG5dRfVRqC2WovsdA8tNzIzs3Sj5RrWdVOxR86xg=
X-Google-Smtp-Source: AGHT+IFpmhM2z2KDin6GRhjxZIQ5R+mLzT187UDQAB/1orWo3bN3jQ1rEzWwIZFAogs3JWkBJ+YU+ZNAkgJe/aJbZl0=
X-Received: by 2002:a05:690c:f8f:b0:6d3:f9a6:e29c with SMTP id
 00721157ae682-6e5bf9a0846mr144026337b3.12.1729605366851; Tue, 22 Oct 2024
 06:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
 <20241001033053.2084360-3-quic_miaoqing@quicinc.com> <smgbishqbin4kcpshqvue3ivvfko2l6rj2w4ikwydosbkq6kde@pdbzhklj7znm>
 <1c5f5c93-db06-4490-af2e-bbce2d184c94@quicinc.com>
In-Reply-To: <1c5f5c93-db06-4490-af2e-bbce2d184c94@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 22 Oct 2024 16:55:56 +0300
Message-ID: <CAA8EJporsVmyhvYV4QDnTJPh82A-JZz3u1RkChe=MumGidmLSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: ath11k: add firmware-name device tree property
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, ath11k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 13:20, Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:
>
>
>
> On 10/22/2024 5:57 PM, Dmitry Baryshkov wrote:
> > On Tue, Oct 01, 2024 at 11:30:52AM +0800, Miaoqing Pan wrote:
> >> QCA6698AQ uses different firmware/bdf/regdb with existing WCN6855
> >> firmware, which is customized for IoE platforms. And the 'pci-device-id +
> >> soc-hw-version + soc-hw-sub-version' may not be enough to identify the
> >> correct firmware directory path.
> >
> > Why is it so? What makes it so different from the existing platforms
> > that you can not use WCN6855 firmware?
>
> Just as I said, a new customized firmware for IoE devices.

This answers the "what" question, not "why". Please provide a reason
and a description. Can the hardware work with the default firmware?
Does your custom firmware provide additional features? Is it just
signed for a different SoC? Is there anything else?

> >> The device tree allows "firmware-name" to define the firmware path,
> >>      wifi@c000000 {
> >
> > You are describing platform node, while the commit message talks about
> > the PCIe devices. Could you please clarify, whether it is a PCIe device
> > or an AHB device?
>
> PCIe device. The change is for sa8775p/qcs8300 those non-AHB boards.

Then why are you patching the AHB schema and why are you providing a
platform-based example? It makes it harder to follow your arguments.

>
> >
> >>          firmware-name = "QCA6698AQ";
> >
> > Could we please follow the approach that has been defined in the commit
> > 5abf259772df ("wifi: ath10k: support board-specific firmware
> > overrides")? In other words, instead of creating another directory under
> > ath11k, create a subdir under the WCN6855/hwN.M/ which contains your
> > device-specific data.
>
> Sure, thanks, will update.
>
> >
> >>          status = "okay";
> >>      };
> >>
> >> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> >>
> >> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> >
> > P.S. please CC linux-arm-msm for future respins of this series or for
> > all other submissions that concern board-specific DT data on MSM
> > platforms.
>
> ok.
>
> >
> >> ---
> >>   drivers/net/wireless/ath/ath11k/core.c | 12 ++++++++++++
> >>   drivers/net/wireless/ath/ath11k/core.h | 11 +++--------
> >>   2 files changed, 15 insertions(+), 8 deletions(-)
> >>
> >
>


-- 
With best wishes
Dmitry

