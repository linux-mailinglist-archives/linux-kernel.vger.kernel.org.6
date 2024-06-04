Return-Path: <linux-kernel+bounces-200583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA08FB21B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86AB4B2263F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101E145FFE;
	Tue,  4 Jun 2024 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfiliTvn"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364D145FF6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503958; cv=none; b=XZoCM5eokeJ2t6PLBWfsBue65NHvYn+vfYo5d0t6d+YMroZYMNAOksRgNI/DvsOhOnUphZuaZlJt7uaiIAEDf5pPzvbeUFZmd+crl18DolCyAWohAOuWHhrLnDKBk+sMf1upMLaYbkup/s5WfgQKXoA46qTOVcs5fEMlnoIp6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503958; c=relaxed/simple;
	bh=s1VCyyJJljzsAGyKD0o7mdCoAu+eLFprs/YEVsgvPA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2jI/4Yp1Z5OodVzJRbqZC3vdB3qyV8KzXa7UahSrwMXjKHZAdPfIJNAY9rWALLEmKDKliUGahhosPi1TxINak7z9pv48mcwVqv6aGPI3VsudEFISFfrPae5sZwDgHfo14vbnK8oIm4c04bNa7C+qqFyvpy8mCdw0xS29z4y1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FfiliTvn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so9679033a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717503955; x=1718108755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9gS0OyJH72V5TfYu3VmbBAJJsXIwwQ21Ck30Dm2cAY=;
        b=FfiliTvnArvh3SByvoAAV/xMv7XPhD6qoBLnLSUlSJjDfx8kIuHIQtasx2vLbNgEfn
         EdPeK23fBf46DLNcyzwk7G/EGkPQRXJ19PAi6bv545zVTBJ/bVtc9T7Bm9T6ejNvAoOM
         TE7OLRtcnNqVkjry8QXaAeLh1Wuqzi5OwPlGF0Ldn9dg0VDaj3gQFVmPuFd4NMRa0Y1w
         3T24TUCguST8xqYw1o0vmFSDpvOIOAa5SZ9urigwamu+0Ro9OB5CiH8YH4nOTnt9Cbz5
         19getvDlMcUFhcZPCcT1FoKCtL2WNPHWe+gcAfyoX/Vqu2Giusx4MluiYE5YW6nD/FzR
         hW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717503955; x=1718108755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9gS0OyJH72V5TfYu3VmbBAJJsXIwwQ21Ck30Dm2cAY=;
        b=oOYJtsoZGQLuFAw6DnrYB7SYc7FpH6OhX3F8YCmFWDA/mKOlBAx5AdrjcaBEBfJsBi
         mBHi3Zb/lQAcB+yZGvNsyz/qula6EBPvs99weiHXVDNJMfkLmMAtTXvFrcpcOJWb8n0S
         PE17sXaQXMpTHnb5tJtaVGxVhjDsIuLA0ez0vJR1UPn+5Dk8lKZGNmyk5sPML5vYhHh3
         u5Y0zSvGh6uqbTM7JbBRSm1KrRuqz4oRvuS/btB8IZ14+lR4FI8BdAOf5EiiaFndOq8r
         JXgEbxR0dMnXNtrcSCQrf6gMeMu+NI9BbAGely4f6k54iaAA7h+Rkh+dDWX9HiLl2SzZ
         84tg==
X-Forwarded-Encrypted: i=1; AJvYcCUm3Lk1uwq82qMbinHRMLVadPXbBkBNH31aheEy7Z2H+ZrlTleWcDv4nfrvv6ADphE9mzRiKcauR+OiBzMix4jMI3QjGxP1tRHVMTd6
X-Gm-Message-State: AOJu0YymHNWFrmm/v2Ogf+XvVc/rB869k4AUklOvt0Paj8CRNYjOWHNO
	9hHwh22fnNmKDEpe/Og2Ju2S1PWeSqLbaccHM5PdBDF7R2gq9gDXlZKDRcaY/bM=
X-Google-Smtp-Source: AGHT+IEN9f8uev3FXprfAoYc9A1GaTXa2CrF6gqcTsV0n51gFLuo0b534nnOFA35YyhTJtD3rOTrFw==
X-Received: by 2002:a50:aadc:0:b0:578:5f53:f017 with SMTP id 4fb4d7f45d1cf-57a7a6bb3ddmr2057448a12.6.1717503954639;
        Tue, 04 Jun 2024 05:25:54 -0700 (PDT)
Received: from linaro.org ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb825esm7298469a12.32.2024.06.04.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:25:54 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:25:52 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: qcom: qmp-pcie: Add X1E80100 Gen4 4-lane mode
 support
Message-ID: <Zl8H0KOrfuF91kpZ@linaro.org>
References: <20240531-x1e80100-phy-add-gen4x4-v1-0-5c841dae7850@linaro.org>
 <20240531-x1e80100-phy-add-gen4x4-v1-2-5c841dae7850@linaro.org>
 <Zl27FJVU_YHokCiD@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl27FJVU_YHokCiD@hovoldconsulting.com>

On 24-06-03 14:46:12, Johan Hovold wrote:
> On Fri, May 31, 2024 at 07:06:45PM +0300, Abel Vesa wrote:
> > The PCIe 6th instance from X1E80100 can be used in both 4-lane mode or
> > 2-lane mode. Add the configuration and compatible for the 4-lane mode.
> 
> Same language nits as for patch 1/1.
> 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> I tried this patch along with the DT changes and the link on the CRD
> still comes up as 2-lane:
> 
> 	qcom-pcie 1bf8000.pci: PCIe Gen.4 x2 link up
> 
> so something appears to be wrong here. (I noticed the same with your
> next branch last week.)
> 
> How did you test this? Does the link actually come up as 4-lane for you?

This is the PHY part. The controller needs some changes as well.

Yes, as of yet, I'm not able to bring the link up in 4-lanes mode.
This however doesn't mean the PHY sequence is incorrect.

But, I agree, maybe I should hold on to the PHY changes as well until
we get the controller side working as well.

Thanks for reviewing.

> 
> Johan

