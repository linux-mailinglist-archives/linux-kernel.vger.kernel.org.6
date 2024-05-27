Return-Path: <linux-kernel+bounces-190296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4738CFC87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C0F284001
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F369D31;
	Mon, 27 May 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kngFFUnW"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26AC43AC1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801125; cv=none; b=RwJhZIRESMJcENcVcOfFqkqpQZ0J6fM8u1we7EY680nt0tEUdf5Q9/hS1KIekMSxJ9I3MYpSMBHeJC3O6YKYer6MWS5aDRwCRPZvtUHqQz7xewLW+RVXaRT3Kqdp1aKNS7/b6JWcTqyiuh9vGxR73ORK/TZonROvrd8O4Ppyz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801125; c=relaxed/simple;
	bh=omcsLZ7jw4cIgeKI7+pOxM3lKFlYforKOKUhCXnfXhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm+z3TBmNiRceeiMIOArSQCvZYA/UBLjNSEJoPeNd5TtmXSol8TbNvPKjidjge5KaxR8dPcG+FF9jnzhn25RHGhRAeFs6D6cfvMKU5vC0FyzLE7vcU+gcb+y7COmIYsOZ8mRowiYpS/Bx3Rby33/R60CE+VsK5NKFrTDpkUpbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kngFFUnW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295ae273c8so3159319e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716801122; x=1717405922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUzLCXQfyvzXsr//tlfSdUGJTNMyFZqlL5VzENiEL3M=;
        b=kngFFUnW3tKsxDCNuDr4DPB6l5UrKnG1smIeso6+uZUE1XUb2mHaT01Uy2PRPkfwKE
         hITrvqZSEmwSSSjrWvw6ixQLyEOc0gzrX+ah7qoMGCH4AQxhj6f7fmTg/ggxqED197bX
         7o4ZQbcNkhGvbkVPNdg+pBG8H8HcJ84NCYPfaj4pqXTWsWo1R24bjMWSJNsYVsVs2Mr6
         4lRFWvU+WkSifQm+TP6QEFGngwNUPk2TEIvN0lbT6kgjgO/4eWStKmwOrODIM6yHjdlt
         a6HzyYKqA1jpRwaMuOiRu+J+VdXO+jpfBqRQ6xnFdbxw23CSQX3jip4UlcH1Ex8p9Kox
         7CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716801122; x=1717405922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUzLCXQfyvzXsr//tlfSdUGJTNMyFZqlL5VzENiEL3M=;
        b=Hap+M1Zq+orxt9jvRd4PmIms6b5bLMSq6V8gZfzmn1cuiCsoMZpqgqle59qjVtO1a4
         OWLTUQ4QAFtHJr4fGWybfdq23KBpIUS47QP1wmkBaSo98cchFDGLzKdkgDj7b6jSHf7O
         lxyTGJZHmFUAPdnHlJ1B9lG4Wws9tj2WqWu3EZzbovMDSTAYduWz0QDTvk3l4DABgUsg
         8cAs6lDKrUvBRRDKs3PDE9Uho8U7E5Ilqi/YWfM+fhTfOVZv7O+1wcFJLAYV/xHlGTgD
         dXGq/6zNglbBfRbyypicr7/5dLhvqp5c9NWP1rIxWygJUrJMDw8E66JXJUPcxIl95B83
         sD7g==
X-Forwarded-Encrypted: i=1; AJvYcCXAm5Mpzpicbn0OUTLPiEk+RLvShuOHnLu1VPdowlRiAYrgdiu6cy5cj/KU/mtjGjrZ8iFdO/LkryiOOqqH6Q1QxXttxlHxq8Ga9DiR
X-Gm-Message-State: AOJu0Yy159AfUaq27LK6py+8btE1UtomXYxi7bC/+FlYMIplWCLkGml1
	dhvCflsO6vuyMnQcZBnfidyHdC3da+lWL6zmKi1COnHVJpTReLVfpMjBOI7iLQFgA/N4SNlYqPI
	7
X-Google-Smtp-Source: AGHT+IGZUS1FjnbDcOXz2+j+YI5pdcfqWxmUeNluNfPOnSp6/vDkxvdWPICE9xHhyGrzoIUDBj6LNg==
X-Received: by 2002:a05:6512:2395:b0:528:9d15:240e with SMTP id 2adb3069b0e04-529663e6272mr7225372e87.43.1716801121977;
        Mon, 27 May 2024 02:12:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b21dsm526727e87.173.2024.05.27.02.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:12:01 -0700 (PDT)
Date: Mon, 27 May 2024 12:12:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: Re: [PATCH 1/3] phy: qcom-qmp: qserdes-txrx: Add missing registers
 offsets
Message-ID: <z5niadir2squ2hxthp7t4f3eijczd26q4l5l6sk6qd4zzafiah@epcsoym66hcq>
References: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-0-be8a0b882117@linaro.org>
 <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-1-be8a0b882117@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-x1e80100-phy-qualcomm-combo-fix-dp-v1-1-be8a0b882117@linaro.org>

On Mon, May 27, 2024 at 10:20:35AM +0300, Abel Vesa wrote:
> Currently, the x1e80100 uses pure V6 register offsets for DP part of the
> combo PHY. This hasn't been an issue because external DP is not yet
> enabled on any of the boards yet. But in order to enabled it, all these

Nit: '...in order to enable it'

> new V6 N4 register offsets are needed. So add them.
> 
> Fixes: 762c3565f3c8 ("phy: qcom-qmp: qserdes-txrx: Add V6 N4 register offsets")
> Co-developed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_n4.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

