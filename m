Return-Path: <linux-kernel+bounces-324520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365DC974DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2AC4282DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE38154BE4;
	Wed, 11 Sep 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yJJeMvMi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C01552F6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045001; cv=none; b=OxjxWiZDuVS2io3O6uE9Dqp11vapmUstvrftXAo1K4MJ1c+qLuFrJwllIM1/vHXaxEJMHECo8bIAmpX5tjU/UOsryHINPcdPyvWhelCNpNVgwCXlzYvm5m35ffIMd5i6ZR7mh6WdA4Y9pUaN5VAfZqpF3hnsn72AhkqDkJSV1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045001; c=relaxed/simple;
	bh=aP7IhXRVz6iKbZ3mQ8dTFLf6Q7UElVuMGXexy6aKLDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8KxafGkTDJKZOnboi7tGMj5TSCxgiFgYX9S3y8MF3ELomYhFSIsMLWozRUD0F088ScdMFTaLVa27MvRmrUOhi6AgF2+V7n6Ne1gGnYoTqlEkJH2onvCzU0sSaFIoYEGz5+9MH9WZlsxrCUNWUIND63zAoKAGbctBVqHHLKjg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yJJeMvMi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-535694d67eeso693043e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726044998; x=1726649798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHT6/vvjElcN24XJx2jBathBZNoc8HfAFHwmAmE1np4=;
        b=yJJeMvMiecPse3BnCA+suTfvGoVMUydGQNgrngedYA73jLZJFu7oqNlhA2C3b42jBT
         bhgyDrPta17rQtrvVXhp+k+nPVa//wTeG3RrIcCw7WOH+w0rtPmDui5QypvEZ5stDdvf
         qGLYVi7Q+WAxeJvRj6AqhRij5T74jPDbJzbMxVUhIGGeGLpcEZF6Mthtocwn0MZY/xud
         3tUkEd0cUawUnC+Lwak+0RaTOg7f3c63Fim7TcfUc8+qhQA+XpShTyu1Lw4e4BrRsbk1
         QBaR0sMWv6TotVuen1RVHrhAm4e6LdgNSONScEPikGRZamhqOwl3Bh1VL7wPdzM2TC6n
         D/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726044998; x=1726649798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHT6/vvjElcN24XJx2jBathBZNoc8HfAFHwmAmE1np4=;
        b=mCGDBnRP6Lim7Tl4YD5EnIphytS3IwlLPT1TlhR9cb4Uv9/8NsDFsuXzPhU5ri0i6x
         QaqfZ7ZpWblu2V69/eYP1pqtX1k6+nAIKWliz+SWwYAc+0u5nPXsVUaf1tdFtTlzhi3r
         uFfKtzTQDeziQN5q+WZjqw4vvhFuapRDS7nPX3ghChdEhiR+X3abw6IoGnWi25Rm2eHp
         YLwt7AKbJwSi3SDyJVpPDIwgeqb27tIm4TRvCHXBHcJCcr1y5UiDDLslTG5eR5Ow9AQ6
         2FxujiORgnjNlF8WGn9QeIKs6WwGyQDfUEeCbIbLfiUOs4LZI/2hiNvlZzm2nzX0N4O4
         t55Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzsDPh7GZYqxAcXgvP2O7QOaJykEincnNJG3FBJCW+soAw0hZB84x8balvvMUvHRU94UQ2qG9QDYdpDbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIMHB7u4Fdd1E0DkDgeMYdUNvdEavbD8X2O4wvRtaHEXTpaVR
	Qb9ILtvX82/OTUGPaivJ3Z5ikRzwtIycs4QUL5/9ENrWyyzf+7tbbKVNFmorGjE=
X-Google-Smtp-Source: AGHT+IF2tpFKGlAXrKvwxqDPIwjevDQmSakJN0nAUDP6pJ1nObUY+pgWNPR4/mHRoFdNp3Q4T16JCA==
X-Received: by 2002:a05:6512:2355:b0:52f:c281:72de with SMTP id 2adb3069b0e04-5366ba30771mr1919414e87.15.1726044997672;
        Wed, 11 Sep 2024 01:56:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cabd2sm1527171e87.143.2024.09.11.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:56:37 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:56:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	konradybcio@kernel.org, krzk+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU
 Frequency
Message-ID: <uaplmcbkdw5ol5y7y4odrskc3anoix6ayckiboyrfahantwarh@qxg5vnytud5p>
References: <f3g2tvddqyt5vjt6x7h6oirtm2ighnesu2pmtn2br6jpbxf5zr@tprelogpljuh>
 <20240911021025.17283-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911021025.17283-1-amadeus@jmu.edu.cn>

On Wed, Sep 11, 2024 at 10:10:25AM GMT, Chukun Pan wrote:
> > opp-supported-hw is selected for all IPQ6000. Please add more details
> > here. Is 1.2 GHz really to be enabled for all IPQ6000?
> 
> The 1.2GHz frequency is available only if the fuse is IPQ6000.
> I will try to add more details.

You can respond here and post new iteration once we settle on something.

> 
> Thanks,
> Chukun
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

