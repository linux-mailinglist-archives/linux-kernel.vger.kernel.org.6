Return-Path: <linux-kernel+bounces-411337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B5B9CF65C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009C3281992
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410B18C031;
	Fri, 15 Nov 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4vbMYJY"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663311891AB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703783; cv=none; b=I6SGrd1RtyuqZ/cEzbbJYwakRtqFM2gzAnzowaNAwB9K88lCHA8LbAhwvIcOejOT9/bgUHoIVQDimIvAZM+Eg5VVnugJF/GTSi4b2UCXizLQ3CQPXdwcOlsZg5KtO2KLYbQkxJDBbwdE5L69Mq2itfoYR5U/rdHxolc3xQzlGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703783; c=relaxed/simple;
	bh=wCqpy51QFTJAUw9DssWd0FEM1AkBOeMV4Pd0fnFJ9pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnM7OwtZYnWr3TUqs8Q39j0wtuxh72rAasfhXXsb7usH9Bm2WSFUVpjXqlJlF1l03cHOy8E4eP4HJGXNYSni8AdKikFcW044CCFjiaZDEcIWpVCWgQ8q2K9bW/t6N8LrqNFhICJ1V+dQfRGMwdZcTT3bgJi9XbsUeOPrQsEQBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4vbMYJY; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso9312791fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731703779; x=1732308579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjYoXr1c/e18FI2TdM2K5pasMyhee97taoyWD1KNeJE=;
        b=Z4vbMYJYiQFfNWOl9MgftjDFHmhYf4z5Xa46SmqzrVd6TjKelaXEZKwLVEpxl7GMMT
         ISacNxipuUqWoYkCtCDAOpBMofXEelMMBvo4QFWbnomz3jB5pl4AnK/raU3GMVihxZA4
         s23fFAjCI7fHal3JHY4ZtcMj/qdQt5nMTgdosZiuZrgaqWag4c5OA7dYJMYpKNVhcB4L
         gFfOV+6cpqbHQUodvgKr4GzUvaIFDnvsr4dT6qJzKFxjwdLPrNot+OVdbL/gfikqhTDL
         p2+TSVJWSdt1X3snzb/XNrkulcGs4BuytNyk4FiZxMi5IJLYwNPHMxYGAbmPufh8AnsR
         9ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731703779; x=1732308579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjYoXr1c/e18FI2TdM2K5pasMyhee97taoyWD1KNeJE=;
        b=vGqw2Aq812NMWbvbENZPCv7LqKWXrkTTt9cTwpGK/HI32mQoPRAKUkQUxymyyyryQR
         K1+RGSNMmw8gYHU4HTjk+bYm0dkzJ9eh5Yk0aqN89oplGfza076Y6qkjjHuaJKb0azgH
         5E+H4YQoWo5RhcWGAS5t+0UwSE928+FlV1QOGA24N/ctrxCYYsRdXqZhI4BBxUVcnzZD
         +mip8qSNvOMdaRA7YnfLOclnvwbOmr7/JJBeYHEzz7TeVAvUCgMA70Acz9BKBvskRQh2
         c7cYtlxaLuz02DVnqQ8nZZDP2KfyF27E56A4vA75TEf9kOOSlkz7kZFh1wyETOxUJcMk
         aCtA==
X-Forwarded-Encrypted: i=1; AJvYcCVViS1WdN9HYLGUGktGnK5JIr/KXtG3pjWvWdi/eOqbXEnt6YEaBa7vO+4uFTbR88X7hRN0/L/IsO5IqLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySMAtRoY3y9NjLCj594xWc9i0VuyX4PnforzMQJpy5eYze1zQW
	M4YgOG2Vzfu3rH3jPE4JvZRQ/Uz1ib4NJUtT5nrw7nJa7r3bzTQNa7Dxcn3ZXVA=
X-Google-Smtp-Source: AGHT+IHDw1nSJp6JrS4UrDhL1uYX+VrsqdWEdSsG7SMPlrb85ao1TsV+hOPLPValyHydklEGSDOhZg==
X-Received: by 2002:a05:651c:12c8:b0:2fb:8920:99c6 with SMTP id 38308e7fff4ca-2ff606944f8mr26665191fa.23.1731703779420;
        Fri, 15 Nov 2024 12:49:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff6995980bsm229991fa.41.2024.11.15.12.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:49:38 -0800 (PST)
Date: Fri, 15 Nov 2024 22:49:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org, 
	manivannan.sadhasivam@linaro.org, bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org, 
	quic_qianyu@quicinc.com, conor+dt@kernel.org, neil.armstrong@linaro.org, 
	andersson@kernel.org, konradybcio@kernel.org, quic_shashim@quicinc.com, 
	quic_kaushalk@quicinc.com, quic_tdas@quicinc.com, quic_tingweiz@quicinc.com, 
	quic_aiquny@quicinc.com, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/5] phy: qcom-qmp-pcie: add dual lane PHY support for
 QCS8300
Message-ID: <vfl3mvq7wn5f4ke2df3hsdd65cmhb6lw4kbzpharo75ufzmayt@e4w76fjipy2m>
References: <20241114095409.2682558-1-quic_ziyuzhan@quicinc.com>
 <20241114095409.2682558-3-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114095409.2682558-3-quic_ziyuzhan@quicinc.com>

On Thu, Nov 14, 2024 at 05:54:06PM +0800, Ziyue Zhang wrote:
> The PCIe Gen4x2 PHY for qcs8300 has a lot of difference with sa8775p.
> So the qcs8300_qmp_gen4x2_pcie_rx_alt_tbl for qcs8300 is added.
> 
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 89 ++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

