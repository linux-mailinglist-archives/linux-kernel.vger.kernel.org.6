Return-Path: <linux-kernel+bounces-397719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073879BDF7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EA51C22E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FE01D0169;
	Wed,  6 Nov 2024 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXpxlDey"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F3199FB0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878632; cv=none; b=EJQOQgt3SDOu4lmVedgbpCPnE0OIrqqBpDI3Fo5OBPyTS87w7RggFmJcjMboRur/Tc9bzKDrm4PKlkr3wznpD1LS0TVIggS9Ec4cEGUGYjXZ4U0FTztyyDZKq4M/aDXXJegxNgPuFwtPpqKd9NDv2hvHyrz/ykNgBPMkOoO6DkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878632; c=relaxed/simple;
	bh=T+IDxfnEDhIbzwhDwnYLVo8b5mJZHz3JOJrvtUZgZUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDGzRXSTjTx4fRTyUWysVi8uesS2F45M0Kxl+3mquq2PrTBzMkl4YgLsK/6P5Fj+4tRw9IjBASUd3esDRobVnNJU27K7RQzkDECj4AgG65MJW0WHHgCSg52VGzNWbhEVAP2kYrDFvx9uHGqjlQQ1LODySTOCA5WVQqkOXu3BdhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXpxlDey; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539d9fffea1so6532356e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730878619; x=1731483419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xBr3nMrr1f+V04w4SZ0IWUu6Cb5RyUO9D91ndFpL84=;
        b=mXpxlDeyB7/qoPH5Nmmk3gGt7jc/h/qhyodAN9BdeRkI719HVImXmCbYHm35JItEjR
         hxS1wnDq+LXFC6EdgvM4VkJE71u7HxRgDpm7bi9G3YKnWcl2KArfAL+vHe6XZgoAQaJn
         srUEwBK0zv5Wsii3oGLrVwZ/sBAcJe08+T/xXH1nuusUr5TSWSAjdPW4KN+ul7OkfuDL
         pIC3W+2dHU/hjAtE1AqudlZF2lCIwMk6zkPAErgUh4BKerd9Ke1Qc8uZTn7lFDsE6ZDp
         CXaIjUvmzHXEb/1N5tHmkqNvvpVHwsd6oiD9i47Oa5s+hxwzdZWYDcJRPhb1doqO3Bq3
         LpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730878619; x=1731483419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xBr3nMrr1f+V04w4SZ0IWUu6Cb5RyUO9D91ndFpL84=;
        b=fvwuhLyn1Xp7VGkvOq4aNTFzgn8GAkz8WK6PKXD1wuY44M0bDlUhyM1YF17qss6Kx8
         HAbaAnlvqWuAF74Pi+QTt9ukdROzEh5YLikwJDpRki7Ca/o4z/uscqfsJbJFgO5hQt6+
         mOtkTWTN/dIS+iemvTcQ5TdCjTMDzJBFhfVYXP0ff3rnZFogYbOl6lBjjXi9uyRMGODB
         MpmP1yEJNQ/7OTdD4ngFj1cPjFW6sc2rGKlm+6n7sYWPbdAohZe+0u1FKA+swpGFy99i
         HxeuBF0N1oExEekr3l0PEUVCQM9R5NKMbHkvkDewEB3ML4INB1xp8wKwkF0/D2iYcHJk
         E8wA==
X-Forwarded-Encrypted: i=1; AJvYcCXv7ebRNYaLwCyfw5F+0vTt9GOX0TAsF2uBgBGLyVjBi/stqCzx/fuvVB/z1j4I1zt9bshk8lHwlIWjXiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPjRhdCJPNMS0CoVr3MN6Vqncq2CIogBULOE02mT1Scrj06ufy
	BwEbBYh7xVxFxQj+s5jEA5NWtVSGw2wzAMmES8C5OqsV5WLkiAl8cP4UKikySXk=
X-Google-Smtp-Source: AGHT+IFYDqIISjoUL85nMRIGPu671NngEQq2CYpjOQlQooiQOP6StYmNoX9XGKAhYB1b9IQWouSWdQ==
X-Received: by 2002:a05:6512:4020:b0:52f:c13f:23d2 with SMTP id 2adb3069b0e04-53b3490ed8fmr18329343e87.25.1730878618811;
        Tue, 05 Nov 2024 23:36:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc961dbsm2398693e87.43.2024.11.05.23.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:36:57 -0800 (PST)
Date: Wed, 6 Nov 2024 09:36:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, bhupesh.sharma@linaro.org, andersson@kernel.org, 
	konradybcio@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qcs615: add SDHC1 and SDHC2
Message-ID: <347uhs7apex3usmfpzrpwakrzchxactwtc7gs45indkzez2vfj@n75dc3ovl3g2>
References: <20241106072343.2070933-1-quic_yuanjiey@quicinc.com>
 <20241106072343.2070933-2-quic_yuanjiey@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106072343.2070933-2-quic_yuanjiey@quicinc.com>

On Wed, Nov 06, 2024 at 03:23:42PM +0800, Yuanjie Yang wrote:
> Add SDHC1 and SDHC2 support to the QCS615 Ride platform. The SDHC1
> and SDHC2 of QCS615 are derived from SM6115. Include the relevant
> binding documents accordingly.

Which binding documents?

> Additionally, configure SDHC1-related
> and SDHC2-related opp, power, and interconnect settings in the device
> tree.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 198 +++++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 

-- 
With best wishes
Dmitry

