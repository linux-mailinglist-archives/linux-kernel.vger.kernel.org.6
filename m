Return-Path: <linux-kernel+bounces-271149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFE3944A28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6215B1C21B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFA6189BA3;
	Thu,  1 Aug 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2pLgUA6"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65614189536
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510676; cv=none; b=IPfcnZXj94rEETxuOL+UL3byRjnDxKLLnkyULjxylW26CBmK4iXo9iP8AtkZBUyam6grhk7zKV/lOvDF7A6TqFzxyIXbAu7P7rD7cTdFiWE+ZvQ9Uu29JfCoIALloGdtd5M+H7leUP/D96JtYbFsfPQtQ7rfxmGBL5zdpfYg7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510676; c=relaxed/simple;
	bh=onHxWsInCEUNZL02MWAzhkY6TZ4nGpiCTSI+v+pCri0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD9UWYYwyIpd+IQ4LoSrgo/5ZgSb3Nk+tXY2/6Pr7NAKrmCfXwHmnWQKxcHHKiQ/Cia8/rE78GuycPVQ6fd/FfrE9Y8NvP4GRmPgmKtb699Sx1YZh7GDS9i5uNVse/yx855RnUvtlI/e1I72jq6kxKqncNPRjMD7ZnGYCZUOYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q2pLgUA6; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d1c655141so5144485b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510674; x=1723115474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JBGFxD6jahE3TXwzjss0XWvpjFEEt8FVaR1X4PNMwA=;
        b=q2pLgUA6EPDLxR38JpbkL2h4xjaNoBlqFLkaVfXVHUvn48jXy9pKCyAGXIA8TryHA6
         O9S6mj5+n6AUSgpaC3RNRiEkAdnvIK/uyTSg7m2zHNxG+2muo5aB3mY3sYF+WbIlKTGB
         R43xyIrNAvT9QyM5C1txSgafKHo3MzVxtTx0Uh0AfGcABxqIASR/0KaHoZccpQj0GUDY
         c1WUXfJwbE+zIE2TKgEYZykaVpkQXq5cQfYBmR51HPgHQV16BgLYIjRWFByfwjoDfnj4
         39GSosl2Z3kyB/E2/qj67SOxLPV01zoynMIKIpJ4MbEQm1MpdLJY1SwgkJSezGMkBkwk
         sq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510674; x=1723115474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JBGFxD6jahE3TXwzjss0XWvpjFEEt8FVaR1X4PNMwA=;
        b=vn2RDKn1R2HqKncz3PJKKSPi2iblBwJ5GRJtLj9zm+7v/LFy+zhs71dOnd+1vNa0ix
         bhlkkemFLLB66dAeAY3TgRuibd8/na5nlYhQuaNHwc8Ow5/AZlvg1rEOn58FKbw1EEUM
         Q36GqYqzieHZDNuszx9tkHE2JLozx00w/Bg9Mrd/8vptzUp6kETIP2dXOE2qdp1Wa5yd
         ypK6Yd1bIOdTRQ3eNkYc2rxX+tXMbKGL6QljA92SnwM8m6bAAEJHalD4cEJMD36BwHkh
         eoAI08sv/7FWZkwOX24zJTK39tr0N0qmJKIV98McEJ/uK3fd3m7vYv04uK7zj/xOSWx8
         3/MA==
X-Forwarded-Encrypted: i=1; AJvYcCUuwow9KpkeyLlEHm55oTZp1/F7EGZH9mWdQ4hc6s2J3B0pZkoOa4zaxoz7O7L+qmWtXc8dPVfoLANHSeRVj8cb8GdtdDU1aMHgn66+
X-Gm-Message-State: AOJu0YxekfYtgN4IidJMhlWnOrqr3C6Jgb/7vbwhfE+Tw3J3NHMtALb1
	Xki8VfH4mhsmfHlxUipyFIxbE6OtflqnxtHTGIrh4fEzF/KA8JamUCn8qZ4CDA==
X-Google-Smtp-Source: AGHT+IHqPM6SHkoj6Vhah2++836HWIGjccmsoYPBQTMXP6Uqgnf4FBlSWurf5IC+XtA/PWvxNY0bNw==
X-Received: by 2002:a05:6a20:7f94:b0:1c4:ce43:7dd1 with SMTP id adf61e73a8af0-1c68cf82a04mr2602801637.20.1722510673570;
        Thu, 01 Aug 2024 04:11:13 -0700 (PDT)
Received: from thinkpad ([120.60.66.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa468bsm136893295ad.255.2024.08.01.04.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:11:13 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:41:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, gregkh@linuxfoundation.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/8] Enable EUD on Qualcomm sm8450 SoC
Message-ID: <20240801111107.GA29707@thinkpad>
References: <20240730222439.3469-1-quic_eserrao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730222439.3469-1-quic_eserrao@quicinc.com>

On Tue, Jul 30, 2024 at 03:24:31PM -0700, Elson Roy Serrao wrote:
> The Embedded USB Debugger (EUD) is a mini High-Speed USB on-chip hub to
> support the USB-based debug and trace capabilities on Qualcomm devices.
> The current implementation lacks in below aspects that are needed for
> proper EUD functionality.
> 
> 1.) HS-Phy control: EUD being a HS hub needs HS-Phy support for it's
>     operation. Hence EUD module should enable/disable HS-phy
>     accordingly.
> 	
> 2.) Proper routing of USB role switch notifications: EUD hub is physically
>     present in between the USB connector and the USB controller. So the
>     usb role switch notifications originating from the connector should
>     route through EUD. EUD also relies on role switch notifications to
>     communicate with the USB, regarding EUD attach/detach events.
> 
> This series aims at implementing the above aspects to enable EUD on
> Qualcomm sm8450 SoC.
> 

For the open source community, EUD enablement means they will only get EUD ports
enumerated on the host and nothing else. There is no public info on how to use
EUD nor are there any tools to make use of it. So what is the purpose of
upstreaming it in the first place?

If the goal is to use EUD only by Qcom employees or customers who have signed
NDA, then you can just supply them the out-of-tree EUD patches and tools to work
with. There is absolutely no need to upstream the driver support.

So for this series and any other future EUD patches,

Nacked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I'm really tempted to send a patch to remove the EUD driver altogether, but I'll
just wait for the response before doing so.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

