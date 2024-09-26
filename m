Return-Path: <linux-kernel+bounces-341146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6565987BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE7281247
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC141B07A2;
	Thu, 26 Sep 2024 23:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8SyBWdJ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A561B011E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393240; cv=none; b=ltIHGTa9wkXNy+9OIm4UaUyP4hMHKX2PmvrMJ3Y/2KQZK0obn2La6zIX/YzA26Fs1VhCf4TxK3fT6rWX9ildVB1AEGU4FhnL9tJLCwESMMJsZkukXACLGlJFiYXKOD3VH6u8ILMGzHc+UaeNm80jH1OqmwT/RBeyu2wv1N1KtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393240; c=relaxed/simple;
	bh=fx7K/mz4fikq62YLJ6+zsahiQDQ0OXGdABBlahkyUno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIUWE6R9GZTXNmyrwTeGE0I02fFIH/iIj3hxMtCjjGX4OTO38Nij3rhXCptY5qOt3r0mwiJjtmwB4wXGKQvLrHZ7QQLNTv2hsMWHMT5iULfOuU7EiNS6Pzu85YvRnkwS8N1LNOtGI9+7FRJpm7FbwwkAl6NN/mM6G8naweLww1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8SyBWdJ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f759688444so15163711fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727393236; x=1727998036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IoNC6BVZ2fLi+HRsxToPea1sroQQFnP/kfPiFNU6dO0=;
        b=B8SyBWdJXtkqJXQZHz/rKBLhOvp6drMvcSF5/BlgrKRs43jEQO8AzraJZGFj2s/8C3
         uPH4rqpHMSg0cJZFr/KZ8//Yzy1Tmy0ns0cj/yBh9w5CcrcktKSLcrasbVXfBihXPCZF
         s5usJGJZ/+zAItL563ZOP79iaPRckPs0xSgwvPZcrHhjd4rs9DzoKNrPCC28T6cYMvb/
         4nUp1zqBmbWSnF/V4WoKVGQmjaKzEb0NBk9Z7JYqLo1bY388U2Hz11Gq8o2RjpWe7hg1
         raIpiS9TtNz9YsyBuv0lxb9Nd1KHMauquI185h+RrgcEib79Z8Xyr33tQErEQW3POldA
         mdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393236; x=1727998036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoNC6BVZ2fLi+HRsxToPea1sroQQFnP/kfPiFNU6dO0=;
        b=S9jdJ8MfHMjn/i9Fl/jBqOmT1KruV6Z16O5CO/6fBHxTD1cz6IgLR+GE0ifoMC2IaP
         ANMAGTORrF9t1dQNvbAUAQ8/VYEIuT2TXBBWNKw7iR+TMMY1ubA2SmsnYEagabng81cH
         u/m6uqVMxIb3nCUol6FCXxcfRHNejb4IPC3DuVXjbESIKn9keWzk1eoi05Lw+AYhAP9Y
         KRjabKP1+yfCx/pKuNeo79bwhsWd052KM3JOej/n9toy3ZN2qv7qSz2xyXQtw5v6QK4U
         dBhkC5FJCGgeOQrPgNnkdC9OM9LpeBwFbJDCN3RYdvv7ONlaNjKvZhBiifP65YDICLRn
         yg2g==
X-Forwarded-Encrypted: i=1; AJvYcCUMEV6v1BdiwiYTQRbc5eLrbVmf2eNAljMKgJ8HvPg+gYQiPapEejOamt9j81cnRDR089V93PhVkg8yWSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGyFyibjAYF4pj0EqVLZfsrwdi1SlM7dEkP871KLXSmQXVl4WA
	jvzNB3i71Zd3PchlUcONeXMwKAaK1pn5dhw4Ktnqh7G6WIRlPsVfTTqcOlmPRwk=
X-Google-Smtp-Source: AGHT+IEcGx8oLV0iBIEWwnPzrMO/IAKlzV3D62xAJBneYKfVCJ6Ui9C9iNqsavwlpr9+gA7xcn6JbQ==
X-Received: by 2002:a2e:a54f:0:b0:2f7:6e3a:7c1d with SMTP id 38308e7fff4ca-2f9d3e497ecmr7502781fa.15.1727393236491;
        Thu, 26 Sep 2024 16:27:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d45e1b4esm1121041fa.64.2024.09.26.16.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 16:27:15 -0700 (PDT)
Date: Fri, 27 Sep 2024 02:27:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Min-Hua Chen <minhuadotchen@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-smd: make smd_vreg_rpm static
Message-ID: <2j64vxito7j6zoq37cdliekkotrjzr65ohck4e7fkehy3y3ji7@t2f7g2niaohr>
References: <20240926231038.31916-1-minhuadotchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926231038.31916-1-minhuadotchen@gmail.com>

On Fri, Sep 27, 2024 at 07:10:36AM GMT, Min-Hua Chen wrote:
> Since smd_vreg_rpm is used only in
> drivers/regulator/qcom_smd-regulator.c, make it static and fix the
> following sparse warning:
> 
> drivers/regulator/qcom_smd-regulator.c:14:21: sparse: warning:
> symbol 'smd_vreg_rpm' was not declared. Should it be static?
> 
> No functional changes intended.
> 
> Fixes: 5df3b41bd6b5 ("regulator: qcom_smd: Keep one rpm handle for all vregs")
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>  drivers/regulator/qcom_smd-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

