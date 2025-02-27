Return-Path: <linux-kernel+bounces-536821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 472BBA484C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B52172F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9391B0F26;
	Thu, 27 Feb 2025 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OOIogdiD"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA81A83E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672579; cv=none; b=RS31qhRSIgp9C6esOdKppNJhkziyYmP48xJityGmM8j36TE4ccgXVcCB6qQquD65WNw2jed/0GT/iofTnZ2uA/kPg88a10hwKIPKFWD2y3Z0yy/8zSafijkAYkv+CeFc43xw0hbK8cPlE+WJ2UZy/neOO8xv3nCIQGKrB0ntZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672579; c=relaxed/simple;
	bh=vvmQSQ9bG7LyD/zOH8DXzpjJRKelZZHC5MkRHwo+th8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De0HQ3ufONss0kFCgF3SvJ8SCzBUgVtmsaWIT8Raa8mfPj2uV7y+lljBbuQtPja7zTzGIoSNQ1DPJ7705o7223moTKge0k0pk2zkn5NBTUwYAZFUsCGh7wvsM4IZNbCFRWWOYc+R346jiNPufngwEQ7xMg2Bv7iQwR1Ph0IVc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OOIogdiD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so10748591fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740672575; x=1741277375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/VUsIry0p1NFH0lewyTgEe2QgpPTkg8i3AfM1Pq08c=;
        b=OOIogdiD5ezp1fmcU7+U3ej5qTAUzafzCz8D2VYFGXulMRNiKrwj9FfqXOHs5/7kvS
         FQTv5vZ53apCzejYyv4ybAvhhWCr0nxalcQKw1jG95Pd8rWk50DeJ8MqVdHtcqE2ggh1
         BwdlsInaVhDG9PGo+P/UglsqGVj375ZHa0HqD+93YJmy51znXHtQ3/N8AYcgnzYjcjLd
         zNsEVTuXlCJEAu12f4zfaM8fDX1N5tEC/eaOaKx1DMbtmiDwMVFcwcxg6qU3vHFgh0TF
         S2LKGgrlhhF4OCYWX1qx+CwrFuH2ICfOb4DhOnSp8HhImkH8DcS6tlfPr/IwtBqeOJfB
         xi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740672575; x=1741277375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/VUsIry0p1NFH0lewyTgEe2QgpPTkg8i3AfM1Pq08c=;
        b=VUIYHIbpNjH0bbPnD83iZpvUrGOz87O710oGqPyL18kDxWHqLnu94W+3be8EUk5Awk
         DC6rBEyz6aNsEw9k4LVjFbrMnErXCMF7CzKO940D4ONcLTvX5YZxiy8v5YDSkLDweLKu
         uEs9OdVExvGZ5H9JcHlqsCx9QBeSyGgd61gkbkce1pw/Yk6sMq0XKtwq/OAFqpRlKSxh
         vmV7eurNUzsrURl1hKoTHUmzsalBMMWEjmqjKME7kEZIWTtHNRR7hjSuIDExfyAILL5a
         InojZhMAj4ruIrRySLJ/92Rbyaw9K0sAMgBso5I3/K1sdRvhl37XK5I3r5d/qPJO390v
         2phA==
X-Forwarded-Encrypted: i=1; AJvYcCW3qJOv/DN03DGijDaplxUREf+dwtvatzgaxe0rzPyuOtsGSOvjJgrSNLSKROdIZRa5u9LAah+V8nKYUoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9k0DcSVihENFIsrX3swg8X9fCl4XCzC3aCbbwKy+gJbrevjhn
	kK1j7nsxYqii3uLRWs5uwsmTJ32Dglm9euwzc4w99fLL4lLE+b57tvkh96ugack=
X-Gm-Gg: ASbGncsc1SxC4n6hUjaU5oDsrrbBqS2mqiVY76eLYDlslFsraOmDjrfSf1Dj/YzNi20
	di4rWkYXm0RdipSKhAmzaJqXIfw+q4Xq5Te43n43ETAF2TKmXDk4tN9m+YHkrScFjFSGLiqBel+
	BzWoPzzVi6MXI2XJIQ8e20Gs8zoKTn8ADBXPFmkga5zx5/BSTj/wpnFr9nMLei24NFzcKJVlreO
	s2fmBJMvG/krWjn46yq7sOTJaLLC7XCo2tnyFcSyadi32eTJewJ6u+hByXSX7lNm83xElBh7Qwg
	44F/79EjQuNL1N9GyRmWbB5CQz8JptubkZQ4135nSIjdGU8QOcnVRRITHgNyb9ZRAb6bCTK/uwB
	bZ83sCw==
X-Google-Smtp-Source: AGHT+IGantaj4iOEBsmehQufqCtLyP839fLFIF8/OzQyOmwBYnvU25Q+3zna/G2tIKhQxmOj4KjClQ==
X-Received: by 2002:a2e:908d:0:b0:308:860e:d4d3 with SMTP id 38308e7fff4ca-30a598f6c62mr97724201fa.22.1740672574881;
        Thu, 27 Feb 2025 08:09:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8685f43asm1964521fa.82.2025.02.27.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:09:34 -0800 (PST)
Date: Thu, 27 Feb 2025 18:09:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Odelu Kukatla <quic_okukatla@quicinc.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Mike Tipton <mdtipton@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 3/7] interconnect: qcom: Add multidev EPSS L3 support
Message-ID: <7lqkbkor7w4qm4esclm4i42eq5pq6nbxnouoz5ywklkstgvbj6@rpm3rssyarsq>
References: <20250227155213.404-1-quic_rlaggysh@quicinc.com>
 <20250227155213.404-4-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227155213.404-4-quic_rlaggysh@quicinc.com>

On Thu, Feb 27, 2025 at 03:52:09PM +0000, Raviteja Laggyshetty wrote:
> EPSS on SA8775P has two instances, necessitating the creation of two
> device nodes with different compatibles due to the unique ICC node ID
> and name limitations in the interconnect framework. Add multidevice
> support for the OSM-L3 provider to dynamically obtain unique node IDs
> and register with the framework.
> EPSS topology includes a single master-slave pair within the same
> provider, the node linking logic is simplified by directly connecting
> the master node to the slave node.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 37 ++++++++++--------------------
>  1 file changed, 12 insertions(+), 25 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

