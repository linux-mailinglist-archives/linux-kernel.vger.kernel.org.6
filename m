Return-Path: <linux-kernel+bounces-362149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C54F99B194
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C1B22331
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E338313C69E;
	Sat, 12 Oct 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QapHBhsQ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2610139CE9
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718460; cv=none; b=t5Dvy4pgRUMTQJ+K3/isaGFHc7JFT0ZYEe1G4FCUGMT4ciQ0Thp8o69LiUu3gvWlyI8km6sCeVGkaSzGaY8ydaj2Rs0FSPjNA4WRduFmMh10a2anEu/6jBCbf8Uih34O6g8Vxrz3CQIFf96+Su/mbuq0yJmmHr+MVfCZ4qO7ADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718460; c=relaxed/simple;
	bh=6sriM8ddV0xlSeGd/m417jYDh9+a3WpfG4nkK1Z8JgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da6zhawFbQxYjlo1PCxWy72XNeaenJc7bmxDDp0hihgeSOzAMBVfzmtVum9nexeUn+ShHk+/yVUag8ABE4qQBy2A0VOnnbQh5UP4m1wmZFC5lNC3bbP8j3AN8AkxJ9mgw824XlsVPkdrDDQeZoEWD/nzLoS3u3uoZkzwbYZ1USU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QapHBhsQ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so421216e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728718457; x=1729323257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhVJE2nKaPLrTxSXxo0fB/smrix5pHzfd/rNW6TY5pY=;
        b=QapHBhsQ7BdKaJ0RE1nImZcaQB+8Iu9ac93Dl+K2SDeCwGB1HGd13Jhfbu7WcQhTBS
         HZvg51Nv9bS8kXe+jRz81wpd72yoj5wsNCCFE72ayqpbkMNd7Aur/roArHrdUkL+QYAm
         R471oZZi7rkaZ+pe/ssgpsn8TjTqW3gEZaSyqFoHdlM8hAM9m9imxV1hnyI7hIc1d4e/
         zcCPGedhBNDOhMD1ujaoieHYU3D8WinZ70wIT+rPFoHaT1g+kvYpHC/SLLbna4idReYh
         0W1W5bVWLxW5S10pqZr7wzuXSa3jED2QP9w+VxQmcM98GGCeXJxvR4E00vksxYQFhsdp
         Ag2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728718457; x=1729323257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhVJE2nKaPLrTxSXxo0fB/smrix5pHzfd/rNW6TY5pY=;
        b=aJm9J1Na10ZtxnXyUp7zjyn3Ol75Ivm36IhXQY78bU91qeHKBnNuR0bIzA5nNdgmoh
         Sp6nbMQEaJqC7uS8d35zzMlri8svakB7NDiRjH9ztXzyE4JAQFlXVKzqs4acOO7ZvxOP
         sm7GrGNLB8DfQ/CyS0SRTeBraBcEdK83gQaBqPbRRbtWaMUaAt5yQmJHXjkQe3U0eGqH
         Hd+9VmGaVbOU8jn2NBFZyDYQVCduC5iL8ouHjmnAC/uwWIZLSGIJrG4Ps7X5q9dSxWar
         owD8EwcHs8XRIp9p16TnHJfX38dq4pIHMGPssNMsFRMXWwbqeio6AdoYWiNY2lmul5I/
         ANxg==
X-Forwarded-Encrypted: i=1; AJvYcCULe/8otWHxzu86hd+avEW2dR6R2CHzFPAoRxqCHBKdeMBMz1nReM+7amyTP6T86e+CYJanPMbYgrpYCaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUJM2GIIoqWRsEa0DgR8uI3EYTpVWAONysEyAR6kv2zmDBSO/
	8OLXPv1Xjtv02m1DP/HM/8HNkuXAsIbJtBOiZ9dMo4lhdqLMKaZ456MLHTyUwgw=
X-Google-Smtp-Source: AGHT+IH5l03WLyhJsAWdlXxU5xngKHzOe3+d8yWUeEvry+VLeVCaBEL7Mc17G2/Gd5bX2cQ/7hL20w==
X-Received: by 2002:a05:6512:ea9:b0:539:9225:43a6 with SMTP id 2adb3069b0e04-539da4f865amr2556480e87.35.1728718456937;
        Sat, 12 Oct 2024 00:34:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c8c0fsm840420e87.112.2024.10.12.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:34:16 -0700 (PDT)
Date: Sat, 12 Oct 2024 10:34:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: x1e78100-t14s: enable otg on
 usb-c ports
Message-ID: <ozpi5m4fagpc6o3t34ngsmwtdrie2m5cjgtem6ocisz525udta@ya5dtg3q7hy3>
References: <20241011231624.30628-1-jonathan@marek.ca>
 <20241011231624.30628-3-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011231624.30628-3-jonathan@marek.ca>

On Fri, Oct 11, 2024 at 07:16:23PM -0400, Jonathan Marek wrote:
> The 2 USB-C ports on x1e78100-t14s are OTG-capable, remove the dr_mode
> override to enable OTG.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts | 8 --------
>  1 file changed, 8 deletions(-)
> 

Same comment,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

