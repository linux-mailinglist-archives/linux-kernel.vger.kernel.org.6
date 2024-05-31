Return-Path: <linux-kernel+bounces-197407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C088D6A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E911828A6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1B17D363;
	Fri, 31 May 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUJoSd55"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8D7F7CA
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185033; cv=none; b=pSiewsQLRKvJjzJoU1jsSlR7QYFkIGgke7LN0N4w5WRp9Skc8kiQON/Xg9BAKZgzfzZoQNLG4gZoE4wGli6owg1FwKqW0SkXWIBIKckGa1jsoEPyzagG33KQcPZUDJnhzj1AZhwrND+orhjvOVwJUZLbQsjf50BgOvYkqUfWwf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185033; c=relaxed/simple;
	bh=f1akKPVORkIyg550KoLiKCAWrsfKqsVFxRZIPvcbZPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1A+rNe3mrHbBPXxdi2dbblnRjmHPK0ryTJqFOPTx4SsvuZ52rIqqJEv8htHFYOdBM9zGLD+SFySRhwQi41/EBJqlURIN3QZAkgnvLdAkriF2/oeL7kzqHowONJRev3pOBga7d2WyIyhyORIENrtMlpH5XtnHXh1U23SzBFsMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nUJoSd55; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52aea6067c8so2962013e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717185029; x=1717789829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZU2ryqJo2RbqRp0VMOW55np9IwacuNJWvzcVOo4CArU=;
        b=nUJoSd55JPTRyfeQ8dBevZkwESFBStpRt6xex/T+Sl1NTf1vWzMY8UxL4FSD1kPkSa
         Tu+5nnLS7Sh2sMfywQHLxB2IyEwLv7Men8VZTrbpBUeZQbkWcG5kGllkwGXYH35mzFyf
         sylGXcIZ7ArzRvV5AqxSOOt1ZaSdQWMnbOw/kZ2Ut5o+7LcuTq4qq0eQBEV18g9JqBsc
         Ol2bEmQHNe1wqOFf+mllnovV+m/uqpLefprlaBZRI9YYdgdkEOR+VEhwsvIYQBkBeZuB
         eSqyPkFinCZCxqC7FbQBXsyYK0dEGVrnDyPM7bIiPXkAK7yOZAsTzax/CLUXXVzaJzay
         DHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717185029; x=1717789829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU2ryqJo2RbqRp0VMOW55np9IwacuNJWvzcVOo4CArU=;
        b=nf6P7pIPHW8AckKhI149xlDEF6Ukc7hwJRlNHYIk+MFmB02mp+nrewOCenlFkFf2vf
         4Q9TpGXSpKuDAYSHCc+HDQfVyj5Hqwj+JrLXycM/AavUoWpYti0tgxBuInfypWGVr3AF
         tfqufavae7u/qXa9G6LwVlz4jld+ni5JvpkmxwuIcxTk+2ivfigYR2re4MYodjl74n8/
         NuuT0jeHxZqgQTxlKzDKNxU+E0kxvX0xFej4WKrMKqhn8lOlX1XGXZxHrWSh/WBCn+LQ
         keSfpdUNvmhaumkygRCsD/WjBe9LZflISi5q7EptzoWlqq5swD6BpsCaLcXIC2WGZGtM
         srRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Z2QTi3sXtLIshYtwQmWzNisKU3CKE8vroWpjuX3AHtmwCxVWYz3pEcgCgQ1IHj3xgDX0gPYCocJMTVAm3Hni+tocGnnLssEQerKE
X-Gm-Message-State: AOJu0YxF450IasGxbsznimdMBq4OEzMhq4fAl9yLmRpZZ/yYrIYYz4PC
	aBGkm4+VN0id9pYnUIrFxVMIE0Tse+VTOXc1v8j77GgUdgZ3UvL+A9Of/RdIi9U=
X-Google-Smtp-Source: AGHT+IFFrDCc8S7OXqYwwrRK/3LCw6k22ohK8j3g2b44ginDvhYF+tDr/CvgM1Z8qwHTb7dniJuQ7g==
X-Received: by 2002:ac2:5101:0:b0:52b:797d:efd4 with SMTP id 2adb3069b0e04-52b8959c55fmr1680065e87.16.1717185028871;
        Fri, 31 May 2024 12:50:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b8beaf911sm206658e87.20.2024.05.31.12.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 12:50:28 -0700 (PDT)
Date: Fri, 31 May 2024 22:50:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: qcom: qmp-pcie: Add X1E80100 Gen4 4-lane mode
 support
Message-ID: <ubyvrmv3giartl6pnen5dbis2yz6y7r6zvihorsqzsfof7q7la@e6xc52ss5qyr>
References: <20240531-x1e80100-phy-add-gen4x4-v1-0-5c841dae7850@linaro.org>
 <20240531-x1e80100-phy-add-gen4x4-v1-2-5c841dae7850@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-x1e80100-phy-add-gen4x4-v1-2-5c841dae7850@linaro.org>

On Fri, May 31, 2024 at 07:06:45PM +0300, Abel Vesa wrote:
> The PCIe 6th instance from X1E80100 can be used in both 4-lane mode or
> 2-lane mode. Add the configuration and compatible for the 4-lane mode.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 42 ++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

