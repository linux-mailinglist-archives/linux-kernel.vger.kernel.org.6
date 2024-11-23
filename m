Return-Path: <linux-kernel+bounces-418940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B159D6782
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 05:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAF4B20EB1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 04:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9D4A0A;
	Sat, 23 Nov 2024 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJwCohjB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6852225A8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732336384; cv=none; b=pQbREy+WOnDzaTafnWCy7nQd0dDVM7rJwDa7PYiEp2tGHW5dlexF3838KEAlgFuh1IIADr7iT6ty5xGVw5CYLCMUG6utHpWRFZhvQjtthDHYBCYisRZcUKercam9n8ZrY944A64QrfRaDSpzDw2QgHnchha1yDwkTYACFgzGwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732336384; c=relaxed/simple;
	bh=05OUskCpRZqj5cEzov83EbhorcQyz5baklPnEnJ7sRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEYhhM4nCmBbipIgUdDotuetqHBzOkt9z6wrOdO29wDY9FtfIGIiQQTM4MKDiaL9rvzJnT2NS8ukcQ6ZrdhMrfJYXTSwjTvwmOOGdBhkCYH3ifwkNLvgR/4HoG8OYQA2vg4oJZ6PdF/g/RV4z5vekYdfGH+QannO3DcmeuYCEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJwCohjB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f2b95775so4222017e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 20:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732336381; x=1732941181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMGxDuJ/rtujDZFX9z6xbz2UE34eujmvFMapxF8n9e8=;
        b=uJwCohjBPT4b5B7YGT7xcDxWdyOpy3DGkqj+/yncj6umLjPfkhDml14c0dyvzJUQTa
         +OcENtprfsDxNOyUHIVXh94wFC+dYMaCmMumbBHmjJovI2CV3BOkdyzpxE+exfq2gnPf
         RxYwAjdsR+iKkWVH7PWDGtN8Y8n7CJuNLduJ1SVxrljkkMfKE5IqEnNcD4jh2HnLE25m
         c1Xlw+Tf7NzxtwkN4SJM6fIemYlhq+JVuf520beoDnEATVKX8gg1whfEkycTYc5qjwVh
         iepVd8gS5/3tcCFHEZW5yX1YZYLFTVINmdW1oM3/6cGoVAWpFHswTlYvl0cctu4iiNjU
         buNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732336381; x=1732941181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMGxDuJ/rtujDZFX9z6xbz2UE34eujmvFMapxF8n9e8=;
        b=eDzG43um8SoM4iEMnqcuEComXv8TVpC/ffWXgAU1ydbs/uRbWRRNtJOzmmmMgHN/15
         hmGjlcpUQgwMZ3GwlR2/mfAO1sLDrarBvQEaMbu4oBT15AkqYTi7+lI8QrwTEcHLEN7L
         0Goi+A9sjC8GYa6B9jyKtWUG9tjGDY4W6K+HLgj7ZYCdzbJhLgKPVJb9UK0oGcaqA/Y1
         n3mRhIPPOEgYKg8vZ8FXPe1C6swHQ619u7ltQHASHMZFhPuk0O8ek3UI6EHFuVTCM3R5
         4777HFLpTWBiVLUB3oxlO/5IKj3nF3pZ/41oh7MbjyiG+IxtZMVI2BzOivduSgnQSbCn
         ZKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXhSL1r9JL7qEx1SHHVMYWou2knmt444BnBkA7d2OC11MCnIVxFS9ZmE73nGhCvPaHlDrgldJGqU4n6os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqkuqM+x4qWQINmqE7e28nMcMRsbjnk2thYstbpebkxb2U4Rd
	JNRPYdjgcT3fVfX+ULLrnZ9Kkyx02+YawK/IjzXAdr28l9xIq5/ZXoIh+XTqqc0=
X-Gm-Gg: ASbGnctHksn/g3UoAxNmwwTUn0pRXhcJt6qF2LHrAhTbz9oPo7GVhx0Sy4vaz3Sv6Ov
	SYZ3NewOc9HuKkrtEdHjfdT3nJfXKXuGLruAi3ArflQ/mtSpaTVgUB/mIZGatiPzAxBaGiIjG7k
	SaiLL+qKqNii28Jx4nGeqyU6LOxhUuU2AwF8YVkvPk9Cz7XY2JIgFQKdf3YpA3Rf6SFvcPyv3Yw
	t6mfs0WpBRYzHoYlgYKWAvU2VocLur5VK0TNtThJ42G1lwfV5URY0GkZPW05oLfuwKZYU3h7iaA
	7QUz1xZM3VVl7YdSgzxI1rRESlFqxg==
X-Google-Smtp-Source: AGHT+IHLJiA6aYnUX3Lh/TeIP5I3J/OMBEcDuDbvten7DOXiFjiEs6Kd2U58RE+IDTcVG4JwRP8PJg==
X-Received: by 2002:a05:6512:3ba2:b0:53d:d0a9:a453 with SMTP id 2adb3069b0e04-53dd389c91bmr4355304e87.31.1732336381130;
        Fri, 22 Nov 2024 20:33:01 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24513c0sm715018e87.97.2024.11.22.20.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 20:32:59 -0800 (PST)
Date: Sat, 23 Nov 2024 06:32:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v17 5/5] iommu/arm-smmu: add ACTLR data and
 support for qcom_smmu_500
Message-ID: <ppbgnxl5wh4cpkkb2lphealm5cqbdfaxqwizxe2ibrqifat3cu@abmenyqc35vj>
References: <20241114160721.1527934-1-quic_bibekkum@quicinc.com>
 <20241114160721.1527934-6-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114160721.1527934-6-quic_bibekkum@quicinc.com>

On Thu, Nov 14, 2024 at 09:37:21PM +0530, Bibek Kumar Patro wrote:
> Add ACTLR data table for qcom_smmu_500 including
> corresponding data entry and set prefetch value by
> way of a list of compatible strings.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

