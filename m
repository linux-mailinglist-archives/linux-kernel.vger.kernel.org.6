Return-Path: <linux-kernel+bounces-553067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDC8A582F9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BA4169CA2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C5018C008;
	Sun,  9 Mar 2025 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mw6d6KP0"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0270199949
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515588; cv=none; b=VZgtkYkDLPF3B27szuPSwzsB4fIv0LIP0ySLw6mzq/J5aFNvsktQmxYTqyEMJLZCRf00mWjWz3jKUd4EJNnuD+DrljmSwr8sKrRr4IZJtGP2Z5LXldyHAEux5CX7P0jn4FOQpicqh5Rt/tYKSV1BLMybUN7fH0bX4qcChe5EAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515588; c=relaxed/simple;
	bh=Rz0dhl+0OSiXEy+n9YrxBnJOx9ffum11zQsQG6UtEok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBWJayxqoAvUmyBv9EZmPH6HiW5n52d6pwpBhH5/Qjp0+CtuRopIHysbYlpEqHhrAtsYv76TsEg8DO0f69pK+6zmGTFp0UEmQ5oxxuxJU8XGhA8JpH2jrci3BTGZPYR/IIDBoz9S4EqTXJIfumjJihDxJOwwq7jPDgelrKktZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mw6d6KP0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307c13298eeso39004861fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 03:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741515585; x=1742120385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s2IN28UcJK9AIeEgePs+AKeLtN5DfXNmrIRckMBKOk=;
        b=Mw6d6KP0AR4AESDAWb621eIf/0fKTsS4+52EWi4D18r/3LWKydb7Xx21oXk51v5itC
         GNzpdYHVa90GsaDYIDWk/spKUrX0dS7QYgtYIGEl9COgBPAyzXUaPzHPzwb5B2jSIJjS
         BXtVV0DBpe5PCK+6/m/HY5EAQlWTxkd12EfHUZpaa01s8kwzd3E4dlYVNvy22hX0rJzj
         mN3DtFH9dnDo+0GCrHOq9JW9BARGOSBkq+W+jNCBr7lQT4X2vibaR42pQzmcQuVjWh0I
         va/U2s9ovD2+gr+kBDn2oZF584kbhLtKSkVP17AcwlkUgqojNoMbXvidiXUVkG/k1IdD
         hrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741515585; x=1742120385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s2IN28UcJK9AIeEgePs+AKeLtN5DfXNmrIRckMBKOk=;
        b=dZYzJFgrpvyvsdaO6IzMo2lU13slQ/2xT9f5P47efkp4ImMUXX3mbKRbuIt09RFVCU
         xlkmhJojApciS4w9Oill/+um6SmfjL6A1FpQpNr4J58YcIRQHPJJbwMH3MwwijEKRtvP
         1x/iLo7mTkDp/nyPRHeF3fmNIgvRODUX1bP/bLkUnKineH0U3QVyV19nEWVQB7Ypv/to
         7eGv5tNasodcPSGMwE3xoYN/SN19a/PfZk/sEnQAtRgA+KsOE/M0nX24QLi3yB75z1h8
         I9cc3icvwmAvo5GFoIABD1mahIfTA+DMNAqUWfGT869xRd2ApPZswGmGyaY6dhVyW9nZ
         bidg==
X-Forwarded-Encrypted: i=1; AJvYcCWoSzBs7ziz0nP540ti3C6pOrAqYJ+LWyZg4AZKe+OyoisXH3L3zhZGJM+qv1m3y2gTk2okOFW/CfhTJGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6K+trsrM6aI+sk5oNHWQTwhoanPMBUlXkmG2CxtAzyVrnkkQ
	5pnZiwww9/CkJ8CxxUJkXb5hSGJGVeky8Lk8PAwSL2n7NvxgjctEYtWsNu3Lx9g=
X-Gm-Gg: ASbGncvr3pI8QY+uKXss8bAXDhH9ic29ANwDn6tL1iu6GRvhA1fBHmk6gnt55HlefV6
	n9Z+EmNbavVjol4LGNmWEAwsEnqaq7IZhDZBb8TeCc6yq6sfRohFk+5xh/8peV8tJct/GYDAOga
	MLRfngzeJqGK35L4uNfkG9ff6JIOgOsIrF60zNYb8ZILkHJWIvJwDe8g2du3OIa1pQzNw3yU3UZ
	hGi0CZGozUjTdKUqSRrp59Vuu2NdwmfUCoppzYXvObHsRrzQ7EcrkIDft/CZlhjhjhGxtBNG8rQ
	Dwv5L069oxZ2van8OIltqSOOl4knWvBC68SOnMhUmIcjKam4U8Y7USHLf2oBOF9WS2u5rbzEaHX
	ooFnO1DQrBaRS4RVjyFXZdyRSz04JzuGncZ0=
X-Google-Smtp-Source: AGHT+IHlBdJ1qjhe/o7S4dso2ZCEpH6o3JPt/ko/A+fRZieBU37zQ/ClCK+PPXWZo0QJwKYGgx8DEw==
X-Received: by 2002:a2e:a985:0:b0:30b:c36c:ba96 with SMTP id 38308e7fff4ca-30bfe3eeeafmr15772901fa.1.1741515584802;
        Sun, 09 Mar 2025 03:19:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bee0c8565sm11460361fa.53.2025.03.09.03.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 03:19:43 -0700 (PDT)
Date: Sun, 9 Mar 2025 12:19:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, quic_jesszhan@quicinc.com, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: reorder pointer operations after sanity
 checks to avoid NULL deref
Message-ID: <s3zlxsj6gsmoz3rc5fqopi7etfibaurkz5oo5wgvurebx2z3zt@t3h73v5lcmhi>
References: <20250309095525.7738-1-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309095525.7738-1-qasdev00@gmail.com>

On Sun, Mar 09, 2025 at 09:55:25AM +0000, Qasim Ijaz wrote:
> _dpu_encoder_trigger_start dereferences "struct dpu_encoder_phys *phys"
> before the sanity checks which can lead to a NULL pointer dereference if
> phys is NULL.
>  
> Fix this by reordering the dereference after the sanity checks.
>  
> Fixes: 8144d17a81d9 ("drm/msm/dpu: Skip trigger flush and start for CWB")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
> v2:
> - Moved Signed-off tag below Fixes tag
> - Moved dpu_enc declaration to the top and initialisation below sanity checks
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-- 
With best wishes
Dmitry

