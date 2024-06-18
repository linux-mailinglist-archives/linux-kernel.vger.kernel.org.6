Return-Path: <linux-kernel+bounces-219111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A567D90CA01
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E7E28BEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD73D158A2E;
	Tue, 18 Jun 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEcvZMOE"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5F158A19
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708914; cv=none; b=gwc8QOhmD0HfV8K/edlyaFZt0W29WUH55bHgu/eQZx2z2Zklb1ONXrurrqyYsw11TDq0DOh6sVF8DvHgeiIjl1kPkJI7tNNn+oHyJAgz6oI/im2umhRJf6UnbhI6wrFICYOgi3ksCljyT8xU7JQU7Vsy6U7E1YlSJog70LrvNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708914; c=relaxed/simple;
	bh=2DEddTNVPP2vZlXXyQ1f+AkVMj17m5QUW665940mq7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUIHc7WjHtiQ0NeYfI9+BfYa4jdX71XlZpOKDvM+9zwr0DAHFimPJ66Wv3ILpK5RrBjhqkZIRr9VXcrta2QjyrYdwPs6FKv+LuLKhtAgU9SbqZwAcGi9u6ZVN0r3v3uSHySMOCQmyfTiExccxmKOXazE8yijGbMVDf/SxFvdX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JEcvZMOE; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c819f6146so7120833e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718708909; x=1719313709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rx8LaT2iJCWh9sAWiRO7uFEZyjt/OGNDwxdgEioegZI=;
        b=JEcvZMOEGu9FoZeESQOv2WWVjJHmxtAL0Us5vdnE0L+4T5Udm0SxDp8yyqG91WJRwN
         OkP97NwiBr6VfAN9fzMW0zXx0jUF2Zaho7QEoZaLlukX+OPFlZRwhpGeIn05SyqNR1kO
         7REWi5NT4V7Nf89e0V++tUMHQOCV2lkJ/1Xsp4IpeUAPGZQh0hTlM24eVunpa/2scIiM
         NOy9ohh1ju2AsYAL0pzN1C5jzydvLFPHLdwS8kACh6NpQnjSkl3aodnNqjcugP8XNyfM
         mN2fvNbtRZMFbZ1QkWlZBraAj0ZXVpcWPEEIZB+FcNbPu21oEzjNaGCwhEHQphpC7Tfl
         /2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718708909; x=1719313709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx8LaT2iJCWh9sAWiRO7uFEZyjt/OGNDwxdgEioegZI=;
        b=VNSxFxq5S/0lH0SRWq76PPRNWZtxcq/bKe//YHqYWJTA30RZ0TCQdJ8AFZ8b9Y7so6
         bSR09K8Rkk+owAKPkuODkiFq8UcMd6YgSs64ozB5JfcY/Ritzy4B7B1rJndSRVFtF9te
         9RSiI+faN0vzJzE5LeBin0sXIrDJrCNhr6Ff8WRbr1ApsxwJGSxfs1DSZVxF2l8HWRN1
         PLnfXKFj6aN8QMpiWfQwhrROAAHG5C5O9wHolOLmQOEVW4cM2Aetq0sT79gB6tkQKnLF
         rYHBNcKCRCdC2wqCFVe8LjhNBz7NC69XE1mWEdOc8Tvqs5rFayG/aZvxI9wtOT5QxOU6
         +6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX0hTP0DBaZ3i+D34yr7fTPr6zA4W3Hsvfvj/CUEz1EToRqFICZJrPsOvVxHcFtcgLTaIzY8etxrGkkyrl6jpd6hJPDTo4sRyjqxpXs
X-Gm-Message-State: AOJu0Yzm1uPkIOiea4mF59j5s1nQ3OkwIN63ypwre6LeFQd2YlwGwnzR
	QB1a5CSAKlwlWiLfFce/9SclIEYF9v/O4Itnp4RbuoZBrjZnU4l1zC78oCHvU4A=
X-Google-Smtp-Source: AGHT+IE8iLnoe7evxfTRQ3fUk5EMJX78UOkrfeDZUvup0x80fKNJfWmM6oYILoqiwu1riUTXQrFZ3g==
X-Received: by 2002:a19:f703:0:b0:51b:214c:5239 with SMTP id 2adb3069b0e04-52ca6e9f465mr7402205e87.62.1718708909384;
        Tue, 18 Jun 2024 04:08:29 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca288858asm1485694e87.289.2024.06.18.04.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:08:29 -0700 (PDT)
Message-ID: <f074d638-ac47-4324-84f7-b7723f18ba8b@linaro.org>
Date: Tue, 18 Jun 2024 13:08:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] drm/msm/adreno: Split up giant device table
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robdclark@chromium.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240617225127.23476-1-robdclark@gmail.com>
 <20240617225127.23476-2-robdclark@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617225127.23476-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 00:51, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Split into a separate table per generation, in preparation to move each
> gen's device table to it's own file.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

