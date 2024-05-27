Return-Path: <linux-kernel+bounces-190297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 199928CFC89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9467281CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAF012F398;
	Mon, 27 May 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQzkiltm"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B943AB5
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801177; cv=none; b=iPpNaENDT/HDpXF/psT9EwB4AqomqvZmOdWcc5sWxy0USE4Jwj7P2d135IZ38mJtqbjVAKF8Ojv3e33rUSw01BuEpGbcsI52bJhCNK9hR1rIYen2hpRDAwcT5xlFk/TgvCFRttyAzOQ+Xax0WNoWJK2azy9T1PubrkiieSqkb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801177; c=relaxed/simple;
	bh=yeWq7PptBSEXVPZHgU907rlJopbotDI3LqGqN8c5hPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq0cFM8ppSjBAnHUiU+qObYxchlAzHIDKR1KXF61HMzdvOtHp8gYMHJs5VlWg+P5ci5bbJCrLW/d/7XwvH9CZiCmBsejGQeBvJB3al4b/Mv1lMsWkmbJP+LfN0lg0QnzYleTpKubtnUuVqHH6pxWJxtXhw3VdD9zQgWrs9qZ4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQzkiltm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-529646df247so2938995e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716801173; x=1717405973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVceIqP9YyNxKt0fPIDPd2dHMyzB268dzk68jIx5hOg=;
        b=TQzkiltmCrG09VNPQTrTahV2PT4ek+0Z6J5bML026SEL3hO0/3YaAHr3sBIaoQA1uw
         XzBnpcNbvcuafN8Uor4IseCPkoBNypk2anWAIo3h3NnC4SAxNN2e/q/0p2V3ab3Cjzp8
         CGBgGOxFNMLW5PIOQ+emDDPxqrH0v59TD9NW+7IHcC2ZzU3em68bPu2obl04iCooxB7B
         l95OyAKcSAAljBc/XnoUOddyk7w+i7wIGsEvOMFTy+Mwp/alUVBRLKnrflydN8dHPKHk
         tdd9ckxNV0A8VBD2HfLqG541sSRDRv13rI5X7w66G6QoXUwqRzPiD3ArAzzOh7hnOm1g
         PQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801173; x=1717405973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVceIqP9YyNxKt0fPIDPd2dHMyzB268dzk68jIx5hOg=;
        b=rT1J/Eg+Z3y+Y93gbCw3RoDpJMkw8Ots+v0na0p7Bz9dYlbl0fOH/7Q63j0Cqdn6EM
         HpKaLNw9o2B4eo6qsfIFLVkbbHZh+kpfg02/nHwPt01TyBzMZsQqJUWz/y11Ar2ezL9Z
         +w2y7q9H+7Z/q8pz3Myy+31pg7DJAWVqfERQK9FzGqm3zmtMt1Eemq92OO+78JoAIoXl
         oO6+0dtBO3z8bG+7x6umLGammku+ctqx1MuhJoYXbE1enCyk0jbITTj+hVNTL5pk4HVJ
         42Z4WzaIxMujaFP+m5MvWuSzcDXDWxhR87G/XNsVDmolZXSfCt3c+HhFVf8OpC7+m1Nr
         csng==
X-Forwarded-Encrypted: i=1; AJvYcCXAFkR8HpeSDugx9tN/cuMAZS09mgA+Gt3nr2R2ybURgnr1h+WSo3UCEKRXLYEOQKLndKSDXCjXtkqcDkjLmRF08QkHrW58eiXYW/Tk
X-Gm-Message-State: AOJu0YyTYQ0IhNe03CiTlPAvR1KNnXDbHG06MUxlIBsZYogr12HaT8l7
	KV+38Zvtts93+Phxup2KaiWZ9Vmv2qyt/oQ9mCBps+5R3J9zPhvxL5PWGntVU1POUH11XG9/SRs
	e
X-Google-Smtp-Source: AGHT+IG6zzcx3yui5stYLzYjZDbUcQG22Q+aKQ5vxWXJ3dzImRH2zg+o8nDmrIbRWr4Lda0oHMTC4g==
X-Received: by 2002:a05:6512:3da7:b0:529:adb8:dfc9 with SMTP id 2adb3069b0e04-529adb8e04bmr2665170e87.66.1716801173369;
        Mon, 27 May 2024 02:12:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970c330acsm491093e87.197.2024.05.27.02.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:12:52 -0700 (PDT)
Date: Mon, 27 May 2024 12:12:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: Re: [PATCH 2/3] phy: qcom-qmp: pcs: Add missing v6 N4 register
 offsets
Message-ID: <n4mqyer56b6nnt7oce7bsdsjntws6alqkyqu7dw55btnutv7m5@gzuzigwkw3ld>
References: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-0-be8a0b882117@linaro.org>
 <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-2-be8a0b882117@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-2-be8a0b882117@linaro.org>

On Mon, May 27, 2024 at 10:20:36AM +0300, Abel Vesa wrote:
> The new X1E80100 SoC bumps up the HW version of QMP phy to v6 N4 for
> combo USB and DP PHY.  Currently, the X1E80100 uses the pure V6 PCS
> register offsets, which are different. Add the offsets so the
> mentioned platform can be fixed later on. Add the new PCS offsets
> in a dedicated header file.
> 
> Fixes: d7b3579f84f7 ("phy: qcom-qmp-combo: Add x1e80100 USB/DP combo phys")
> Co-developed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6-n4.h | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

