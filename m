Return-Path: <linux-kernel+bounces-308179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033AB965851
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362311C22A58
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183C15572D;
	Fri, 30 Aug 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtQmup2g"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5191509BF
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002553; cv=none; b=CU+jmmd56hEU9Dvi6aYIj8ewbV8shLsuuj6MLJ+lZJAlmE37IQaFN6qHoMuP8g1Rxv7e5Djtg4mcvam3fuhCrDJngrXTNvXeJ4PXWzLde5LS9eP/V7ce4PZL5goRa9uL0Oi5AoUAmG2cxNTno10NDm+xK75q4S/Den7X3QD95sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002553; c=relaxed/simple;
	bh=LtIr9/ZqhyDR/GeeKmVMWH4tGiG5mBvDaWrJa1zm1js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMvNozCyMZ/tXFFVkjN4ri6OY+wCJ0pGsfVxoYMnSIIKIc6bTAdGQLjRibO3//bN1Llf5Q28aBbaivP20lyRReJ4wLx+xNN9JZOun86Jk+MMlMe/eisBwV/3MJFwEXeV8PxtQvtENG3bOUbFeEWOrQ591XRyLZZ1ptQO05QDGk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LtQmup2g; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f401c20b56so22122651fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725002550; x=1725607350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sMeJMps7E2S6f8AwlLA7LKAc9i3wDhfx+fFAsofLaM=;
        b=LtQmup2gzKexh2FaDj8eteELvGrQeB6I9Qa7uG8imTeQWYptD0Bezv/1T0R1UIsCIQ
         TF+h4kBjqlKXbRNgyrHdiZqfwlkwov49pC+Ufmz6n0MmqUuCHYgV5ia7nuLvIk1aHPl8
         gNB1VIJYjx5kV7G+TxiYDfpFLUxfyGWZY1vB2nq5/za9lhYthDs4LEphcWJxGCe/GY5Z
         7kZuXR5d5s+N6F0mPboAR+lKYCWvRsqx3z4nbtH1uU1daG3J9LvqniqrV682DHrS3GJu
         hW8zy6sx0FbS6B/QcYfeWWFkr2BNYyuMNYVmojFLoCiINg9IpTptEcAbtBeQGej9p62G
         mHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002550; x=1725607350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sMeJMps7E2S6f8AwlLA7LKAc9i3wDhfx+fFAsofLaM=;
        b=jVjm2N3KROI6LB0fbY5R7F6ZllfRzppFNXTJqMqlqMbQ1LKaqJmVdGz51gDf9CLjXk
         HpvbZa4Y2vY4VraEUA5iqGfj+cJI3wDXtyYU2oFreiwTpkKBHbUgUt5X/99T9zRcgbe6
         p1vALBXmJKxYmF55ad+qHo0bn0qjm2ceCr0VDNGWimLqQRVPL+xAE19J9doG8nuqH8Kk
         ISvJzQxrbCTfGjAjJp1ieS4sKtQUlGh48FopMNhaxkT+7QnLrLsKUIevuHxyS/7TFs1Y
         Mk6buHlRecEuE11G6FUrLomU8AkGA7H8UDvzCko9yw79jyE3QtdY3ZzxIo8w2rdmNLHe
         FtZw==
X-Forwarded-Encrypted: i=1; AJvYcCVD3mYrzFVxYxYUX5LRUonO2NBO2J3rSAm3tMt67udN+naDnlNHby325E43B6AyiEfYhiWQvMDmLKFCW+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzNDoTOj3u66+voo1K7nET/j3jlWE5Rdhk7aibGP1B/llAmjN
	CHlBEGRVk638cH6/7/sI4GL2aByiVRIPSdseimJM77Tb/L9jhSTmL7rRHeRQeDk=
X-Google-Smtp-Source: AGHT+IHLWJk3wQEYIS+wD4pUv+R8kJp73nMGNuud3xFIQE2+Ol6M5j/0i54RabtBIsiQzJpRT9LT+w==
X-Received: by 2002:a2e:b88b:0:b0:2f4:1d7:e286 with SMTP id 38308e7fff4ca-2f61e0adffdmr4111671fa.18.1725002549259;
        Fri, 30 Aug 2024 00:22:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed171csm5237831fa.26.2024.08.30.00.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 00:22:28 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:22:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] bus: qcom: Simplify with dev_err_probe()
Message-ID: <kmnxctfzpye3oz36ojzr637bh5lfis4sjp7ptzv65byfakatqh@7qo3pmzun6qq>
References: <20240829124118.3256437-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829124118.3256437-1-yujiaoliang@vivo.com>

On Thu, Aug 29, 2024 at 08:41:18PM GMT, Yu Jiaoliang wrote:
> Error handling in probe() can be a bit simpler with dev_err_probe().
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
>  drivers/bus/qcom-ebi2.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

