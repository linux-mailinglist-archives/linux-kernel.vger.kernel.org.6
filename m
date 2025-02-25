Return-Path: <linux-kernel+bounces-532487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117DFA44E63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 026DE7A3A92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8561A2567;
	Tue, 25 Feb 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnJV8tek"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F51A3142
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517759; cv=none; b=NnTC7QkLYjNV5Ha/s7k5ivA1u6/E8np01IOb+PHsoqC3GcxIe223ieeerbo3keofizphXImxAi+2qjEbMG5dHCxTLDbd+V4fhr7813OxiIkm5JUxC5JHd7zbbieueMJ5uR7UctJESl2vXW8P/I1ZV+MgjaLSvELyRDh4t9g1vEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517759; c=relaxed/simple;
	bh=f9nu/gjYpScp2GZzc6dQlyISc0mFy1UpPKMQt+2+SPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov/KD+sJINj5z2grAkCXmFAceU/qn09qz8FD/PN/LxgOhBpsDzlEaO+6ObITiMAHYBgiZQLJ1yRuN5I7mG7+uxiHA4SzvHX8mV+TFfm/KeRG6hZRzmj1plBUazCubMUlOS5w83haqeWKkqqNb+jgZp08/qgmjkVQqUjb/e81Ylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BnJV8tek; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3072f8dc069so62853281fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740517755; x=1741122555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4XoCEWv2ZTyY24QshaT4Wp49xDJ3qBHY1WAxKeHvOQ=;
        b=BnJV8tek0H2lBSDSA1XJYLnSTGkX5dc7IAY3Bcy7+6xD5yTFyClsz7CB9j2aKrnjs2
         Pwr2aY4vrxkpZQaMaz8clZQhNxTSNvZpvy4U5eWAd1F6TSgBF5ARLJ3vo2vgrIQA0nyc
         37TMXeGfvF9gJuYAHcmcWQNCM6lYq4h3eIqFxxa6O4uHgaU4RfqqHQfK9mprkU3QnsVh
         UoExr8p2tBvij30C89bFkKXq+E9ZyyD0YveWloESi7rb6LMJ7lnxd83iZpeUYTFKt5cA
         hpdkr0aQvbL0gEKafcJgwd1u1ZksD8FwvOvU+mzSxaiSWuaFjSRgulHcJ8d1vSLC4tOA
         s6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517755; x=1741122555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4XoCEWv2ZTyY24QshaT4Wp49xDJ3qBHY1WAxKeHvOQ=;
        b=JwWVm2DAoLXtQSzN9ndERA42CmQLlxgQ8DCvOY2s/koYsyAYPSauLbh1lTGe9V3U6k
         5Ksl85+4FZQzatsxOJJv3+/a7rP8Ntm8Wm8ogyw4zFrKpJhGdOJ9MscMrMj0zNUjXnqq
         6Q6ieXIs0yZ0D2uH8aYPBA+eOGvSds45/XDm1iQviN1wRkTTtA7p3/fBeXyHsDAlw9R/
         Pjtjqq/amEKLQBijCaDRhwXaOqnkVn4g1fhcns64J0MaXLI5H0bl85cLwnmrmWuMAYiY
         NyCnvIILfltXwb1NZ9r82hYSPAVwpW4vgb/0ET8NwJoSkjuUQ0ElxU8bbXwBxtufyt09
         2+vw==
X-Forwarded-Encrypted: i=1; AJvYcCWpFWLyMXbkaucK6qP/+LCqtqE67zRSbsSIf/V4g4iiqW4eUupAcZnHGuol+tDWqh6QW9gAmwmtX8hCBrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLr8l77zhuNN6Hx4wFgaK20YJqpj6toFcCqrm54+2c73x4vhP
	iywP31CxB1fg1Yte5EWrHehWwr5bOZ69HD+A61lz01ihZtMLcnsJEEtcxaKf59c=
X-Gm-Gg: ASbGncuCjcHjjH1t14Dl7hRGMqtwC7hbeaaOkCc/+aFv70cySjkxqWaSzCPvVDjxU4+
	79c0C0q4uVcd8WZUkZvsbopEXoLzbuqGRXjdDmCbhJl6BQ+z+QcfD7YiTQOmwQqdUvfA+mt/qkg
	1gkQv7UGT1PJBEqyx/MpBVyUqUHzkLm6Wm4WJYG8geByYy2QrPt17vHhjhfoB+RIUB1Gb5ZNrMj
	Pg2Cnuli9xo/eaLhulX7k7RZfH3up3G8xh2Siq7ZRKZ22ub3NI98T1TjgD+BLJQRzsoRYZbp46s
	OG8B50/i4HEQZuid6LCgj739xxPTbDTuvHARE1iTSc6+fTLnyMMQ3a6gyegzWuHPlsY2GiYaRmn
	uqejwjA==
X-Google-Smtp-Source: AGHT+IHZW6d9rnGPSbTopC+zVuHs8+WHbIcOmyVc/br2TV9KZrFgTMvD/wPr004/MWm+y+QcUxD/DA==
X-Received: by 2002:a2e:9c02:0:b0:308:e9ae:b5b3 with SMTP id 38308e7fff4ca-30b79132d13mr10353661fa.1.1740517755543;
        Tue, 25 Feb 2025 13:09:15 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae82d6sm3139931fa.110.2025.02.25.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 13:09:14 -0800 (PST)
Date: Tue, 25 Feb 2025 23:09:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	david.collins@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] thermal: qcom-spmi-temp-alarm: Add temp alarm
 data struct based on HW subtype
Message-ID: <n57hjxg6v7z34qmlvygfwakol45dtj6jgma56w3xqxbj67op3x@5n7yoyydnxm4>
References: <20250225192429.2328092-1-anjelique.melendez@oss.qualcomm.com>
 <20250225192429.2328092-3-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225192429.2328092-3-anjelique.melendez@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 11:24:26AM -0800, Anjelique Melendez wrote:
> Currently multiple if/else statements are used in functions to decipher
> between SPMI temp alarm Gen 1, Gen 2 and Gen 2 Rev 1 functionality. Instead
> refactor the driver so that SPMI temp alarm chips will have reference to a
> spmi_temp_alarm_data struct which defines data and function callbacks
> based on the HW subtype.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 103 +++++++++++++-------
>  1 file changed, 68 insertions(+), 35 deletions(-)
>  }
>  
>  /**
>   * qpnp_tm_get_temp_stage() - return over-temperature stage
>   * @chip:		Pointer to the qpnp_tm chip
>   *
> - * Return: stage (GEN1) or state (GEN2) on success, or errno on failure.
> + * Return: stage on success, or errno on failure.
>   */
>  static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)

-> qpnp_tm_gen1_get_temp_stage()

With that fixed,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


>  {

-- 
With best wishes
Dmitry

