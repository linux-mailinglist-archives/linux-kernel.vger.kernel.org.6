Return-Path: <linux-kernel+bounces-233680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9891BB6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9766BB2248B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F417415252B;
	Fri, 28 Jun 2024 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zngfVCWW"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F21509AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719566814; cv=none; b=F+DxJ+dvsmIhXPJtKkqa/SXhnQAAft96/XpfXyh2r3HVBSaXpPHWCwXbAnVwHENBKSMQv8FHxkjZly8tNB72D/R0SIlmPqwN6cqyspuCjdAne6xgSY0sY2W4bngu2N1eWeX3xQaNaSCQJ6JRrhT0Otx2s8grspQ+BRveJ+z7WT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719566814; c=relaxed/simple;
	bh=awHqXFlxPP8lfjXkvIjxe0HDyxCZOJaYWC2aPxNS3/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNyHCwAWplz5URd71vpoIfPUqDyUS5+8TZjODfSsmkHsZV3O2rHw5Y/DcZs5BphLobvAPZSJuALDTxVpM6jWkmz0jHekqDJ3BxDO8L4ZP4YtNILqwOltmA9GM1kvEDQ2N0U8gpqx5trtpmcpeSZGGlkS4LjjK707DtONSKJSCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zngfVCWW; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bbf73f334so330489e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719566810; x=1720171610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJY5fes8y/eceaUuSHKFgSKTtu1p3rY5k3qOE9DAYWM=;
        b=zngfVCWWgQLN5gcHqrF1n5pTobnmAJFPEq5EDm79wtcbPWOSsQ7FmFpZ6e2BOjonFi
         5R8mRjlLncGsOJmPO85oaFezHDZ2/kMqD6LVeiuvutx8imBi9zlAQiiy/mSoYOIm2MQ/
         Te30CbVI5n4D+hmPlrrGmnCuuFzGiR1ElzzPrEEqt4LhQjXSQL7j4ZK11nszA93havDj
         qKOtlCs9SjtCyzzQrOwYxPzjxyCG2Gh74PtiHen6fmKOCQTI6gEN+uZc0Cp1h10R5fzI
         EpKXiPwUdQLRM3Ad2QMnmcL11q4UTfmc1PZPKLnp6Sb3d+NHhn0+m+xnZyiV57Gr6wpa
         qF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719566810; x=1720171610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJY5fes8y/eceaUuSHKFgSKTtu1p3rY5k3qOE9DAYWM=;
        b=MSktEHrc7C/jmvqFZ05C41fjzqAdieiq1VjVK8p+bZ3TEaxiRdIAeX1Gmp9byKUEND
         jAaymo8s13sIwe8j0Lk5R7jqcUawT6iGHO4itiZzBBU6elUR3lI+K7SqzezEq/RzQQYG
         K5zzjqQxEn+U4ekKy1a6SLWDROk/kCyaId8RkGqpN8pzm8Y2lOLmo8ogZLnYNqiwQ2Tg
         k7g8QzlDrTx3r8I9tYMRO/RDAXJlMmtD7sQPQs/hBafB0h3V9mxwr2Ltu2VDnSCw8SWc
         cuqhWEtuH5cHzcazfwFiIpSUWo5E1XIZwVuJCc6+gQQo0QcyG5exOq9M94783sjXEFDd
         jrjg==
X-Forwarded-Encrypted: i=1; AJvYcCWlNxS+EktEQH9XHnSsVOKoaaoW6z0MCVYz/vO5Jp+E+hoIlzDIhtGHI4VX6fOFcL9ZZFlWkr5PC9k6gvTXpLcVJE6jd9lxzuowsj7g
X-Gm-Message-State: AOJu0YyEhqZsPn4VOT34KVnN8axPwi+YjwuX/SbXM8cd4Ldip9c0A9iZ
	/xIJH2SgVciIAOBw+o5QLF4EUZjXXDmchqDzzWZFUZyok52ahpDIonLd3U5Fy3k=
X-Google-Smtp-Source: AGHT+IGLI7DnhKN2eEpzMawEemRB3nB1IrQwbGOlffIR7dko/3E83SMgD7+zmlsRDlsu7/SFPzQ+iQ==
X-Received: by 2002:a05:6512:1248:b0:52c:e3ae:2737 with SMTP id 2adb3069b0e04-52ce3ae27c9mr12366756e87.68.1719566810593;
        Fri, 28 Jun 2024 02:26:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab27ac2sm222157e87.129.2024.06.28.02.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:26:50 -0700 (PDT)
Date: Fri, 28 Jun 2024 12:26:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: manivannan.sadhasivam@linaro.org, loic.poulain@linaro.org, 
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net, quic_jhugo@quicinc.com, 
	netdev@vger.kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] bus: mhi: host: Add Foxconn SDX72 related support
Message-ID: <k3vupufeagaaqapzybop45sh7p3hitvcd5xf54nefiucb6fb3n@awtivqfpish2>
References: <20240628073605.1447218-1-slark_xiao@163.com>
 <2xbnsvtzh23al43njugtqpihocyo5gtyuzu4wbd5gmizhs2utf@d2x2gxust3w5>
 <455cd5ee.86ad.1905df8bbab.Coremail.slark_xiao@163.com>
 <31b6372e.8805.1905dfc1c6e.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b6372e.8805.1905dfc1c6e.Coremail.slark_xiao@163.com>

On Fri, Jun 28, 2024 at 04:35:21PM GMT, Slark Xiao wrote:
> 
> At 2024-06-28 16:31:40, "Slark Xiao" <slark_xiao@163.com> wrote:
> >
> >At 2024-06-28 15:51:54, "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org> wrote:
> >>On Fri, Jun 28, 2024 at 03:36:05PM GMT, Slark Xiao wrote:
> >>> Align with Qcom SDX72, add ready timeout item for Foxconn SDX72.
> >>> And also, add firehose support since SDX72.
> >>> 
> >>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >>> ---
> >>> v2: (1). Update the edl file path and name (2). Set SDX72 support
> >>> trigger edl mode by default
> >>> v3: Divide into 2 parts for Foxconn sdx72 platform
> >>
> >>Generic comment: please send all the patches using a single
> >>git-send-email command. This way it will thread them properly, so that
> >>they form a single patchseries in developers's mail clients. Or you can
> >>just use 'b4' tool to manage and send the patchset.
> >>
> >
> >Send again with command "git send-email v3-*.patch ...". Please take a view on that.
> >Thanks.
> >
> 
> Seems no difference in my side. Any difference in your side?

Yes, the In-Reply-To headers have linked them together.

> 
> >>> ---
> >>>  drivers/bus/mhi/host/pci_generic.c | 43 ++++++++++++++++++++++++++++++
> >>>  1 file changed, 43 insertions(+)
> >>> 
> >>
> >>
> >>-- 
> >>With best wishes
> >>Dmitry

-- 
With best wishes
Dmitry

