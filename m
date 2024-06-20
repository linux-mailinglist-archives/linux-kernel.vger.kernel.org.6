Return-Path: <linux-kernel+bounces-222898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4896A91095D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C541C219AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0471AF69B;
	Thu, 20 Jun 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0P6wIfa"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA41AE0B3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896197; cv=none; b=ra2QID90/cAjgkXtbf3WvKovVW8RJwEWgV8PCbCZTImDzzQP2pKILpYl9Ma3cgeeiRwJvYt6l34KaLJzFHRlQsiJO63oVz2/3TFRMZLUAQiN0V6sQD5w8OX2rrldG9ruA4SiiP16cTzQqa3AjMr30qJhGRAP2g0tZTEeZnVRrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896197; c=relaxed/simple;
	bh=mfiwSIjC731sExU1owoEvvO8FCSEVIoCYkKggzTldDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7npCpNW42kWP8nsfWeVe1Ah3uV81ONnPKf9juHjlzUV6d4xXo+qSJsp6QQi6Rxm9npKd43wNlUpIEqe2qVPMr5LMKqUgQTKeoBHQF/AhCdgXqkTUqP3nCayyjwlD2WdGLlMKfS4HJgQksCJX6cWxNQ40Dc2+CHrFBAk3HYHgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0P6wIfa; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b78ef397bso1864778e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896193; x=1719500993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gK+thIDawbMI8D6X0tNOPUzlxQcTHptuQx1Z2ceRXM=;
        b=V0P6wIfamtHqFfdSKj+7giMe3rhe9Saloyfx06RP4zZ0dxam+nYkdJLhiYR7zFY5Ie
         qkHDnkBjV3Qu+1IxADNrakETXBVYpu+Ynzjiu7SwMfGjctAmni9ecnygedl+kMEgFywP
         p8q42rahO6+xzGYFuQISPWf2Xu4eEEvG2P4HDc7wldGhBPcq13FOI6N/Bg4Xo/zLSu/c
         6o8bBdsxJDeMwGQFzVEnDN9DjIl2ohosU7qsGOnJgIab1pHMWpCL9JKuVcb/TYMSPBvz
         LL6B72fExJ34Jn2uT+YyrqVrdUAXJcS7uLZWnF8jmyOe6+cp2mUO5jWmphIaWC6NX8f+
         VOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896193; x=1719500993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gK+thIDawbMI8D6X0tNOPUzlxQcTHptuQx1Z2ceRXM=;
        b=bB0UAvixFJVAMOmgeWSsr1xV9acI8LsJDQ7o5nHnt9D+SjEpNRI7IHMdkqkMh142g4
         AfVOiA6ARDjIoiR9Ac0q5FlSEoBpqFBZwFJ9WhiIaiZTgDOqqtl/4O62gcYrYai3JivY
         zfoQIO0e+CnOBQNMG2FMtZA7Sr5Sb3N7t2doPqRrJIr3ujfWeM7DYIJnGPcSyJOVQQZh
         TBIJ+QTDe6qgGxcx47ydY7EMzcEQtg8a/NTFZRKZm+3qKAf2/HkyBBV7rWOC4UiaDLZK
         6N7iyY61ocvfT+a/L7MDh7FJQqUWOjhjpzr4VvQ3GTA7rkIpNzLq6JuI26F6qk77Yjd0
         J/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXRS+E2QKFSqnN3rq6h67OKR3DoofJcRVOHncKw4Xqe/y+NAxHAtKVZDrEpb2TQ6qDhtQ2Nnbp+n/5NY4ZjUUg1sVPk2TcwZ1DA8FXq
X-Gm-Message-State: AOJu0Yyl73iQLaWS9KpMRXHP46OihJkjtn4hJDtEYrnlXMI1ktkad30E
	e/6pkqGnIb7B3SlImyvFaB+CB+7SFED6z+expnRPWmWTsGd1OX9b7n+E5d8GIcs=
X-Google-Smtp-Source: AGHT+IHZ7VSN2wu7ZM55UCXbxtOpvLmg+Rz6tqxnMXIu8tRVtuNvG3de09teEXUPAPTQMcqu6Cz87A==
X-Received: by 2002:a05:6512:31d4:b0:52c:c64e:b902 with SMTP id 2adb3069b0e04-52cca1ea264mr1869080e87.27.1718896193490;
        Thu, 20 Jun 2024 08:09:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2826269sm2091191e87.61.2024.06.20.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:09:53 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:09:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	quic_rjendra@quicinc.com, luca@z3ntu.xyz, abel.vesa@linaro.org, quic_rohiagar@quicinc.com, 
	danila@jiaxyga.com, otto.pflueger@abscue.de, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v1 3/7] pmdomain: qcom: rpmpd: Add IPQ9574 power domains
Message-ID: <jfh2xygjdoapkno2jrt6w7thlylgyp2tk7oaczundhxvi26qel@ahtskgn4v6sp>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
 <20240620081427.2860066-4-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620081427.2860066-4-quic_varada@quicinc.com>

On Thu, Jun 20, 2024 at 01:44:23PM GMT, Varadarajan Narayanan wrote:
> Add the APC power domain definitions used in IPQ9574.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>

The order of the S-o-B's is wrong. Who is the actual author of the
patch?

> ---
>  drivers/pmdomain/qcom/rpmpd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 


-- 
With best wishes
Dmitry

