Return-Path: <linux-kernel+bounces-360556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A833999C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49CFB1C22727
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C417A20898A;
	Fri, 11 Oct 2024 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNLPdkj5"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD011F9434
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728627948; cv=none; b=EmGDNZ28hU68TABMY2QCRxAHfb7g6+4vbKTw/Fzs7mwz1i+3E0IKlAg+WLZatBF1MYg3Z5+qjYhtLjmZYCbbGPUd2sYbwmntVZHQzHdhExVpjcZGKGyavVGJ9ZbKlfqBsvUJXf0wV+VnnWU62+pCDumaWv4DIHL3eAp+xMkoUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728627948; c=relaxed/simple;
	bh=UJoFkmi3YqkhXLyQVgq25QKcgb3JPFgQ8aUBBPPRUXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbeR6gj3QbR3JEL2p8SjegeIzQdsLtJvEIovxh+E6/RJduOrZ595IzShxsIIGhmgauQ0r88QEVHBHgyRAEvY1R2MJz63uo3B+Zz4bUwWg3nHQ2JPBlJgQeLABK8cObWsTGQx1xd+NlzjAQzbjfJ5irmNCUptkJU8yvPOmEdZVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNLPdkj5; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fac3f20f1dso17238221fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728627945; x=1729232745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAWWAAZRi5dwUBX2t+OrlMVPdUe4A/Zp86YxWssIhEE=;
        b=QNLPdkj55RtebF0MAYqAfZ4kRHid9ObLzlPLCN9RI/oTtrHZSVQSia3/H2SqgNumW9
         qWDLCu+dxJQLHYbMujIK0vKdP2ZqpCpYsMoRmBhDLnKOODOraQonPiH7ZEX/sSOqAcx4
         XAaHsoisDJB0kg8bohN8MUikfdObWdnYHQo/ftQgOZT/KEdcviOofO91pldsAnrOgo4a
         4lhxROtWOsMkZswGuJOmnJrK1dJnXdUrR37geMzm5/tLLl3rlYbrImr3VTbL5BzGz7zX
         zvVya1ihtS6g6AEZ6GWt3gXTSHcXmTNFxA8ubF6jHbewjAZsWJn5BrvWRFt9kSKCs/n6
         np/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728627945; x=1729232745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAWWAAZRi5dwUBX2t+OrlMVPdUe4A/Zp86YxWssIhEE=;
        b=bov7IegUotaqjGT8kC4z5+rQFjr7bBzmRFNX+vRWEWiQycjpXi2Qu43fYq1gQMshwX
         gILtcOc17s2IZnCjgT9oYIyx4jQpu3OvXFn0Z+w1YfW7RtsUYkiwl6RoFXIlpGFpnTD9
         B/akwnSxpqugy7BRh3+IYipGKCW5mL03Iihx0dCdj00rkSeEKsd6cx+4SQ9QpV8Tu9QE
         6iq9sdNZO4RuHvAIul70lsPj9x1isba/c/MKbpz8QehU7tqQlaMUiRbwWAZhVv0TcEY2
         2eT7AaWAdCSym5431rOq+Q/qPbMkJ9wrWEhadbHeH6D6+43J1s7jHWn/h+0Yymld1j/O
         yYCA==
X-Forwarded-Encrypted: i=1; AJvYcCV2AAzX3L1tUCWOOQQNOdNGVXNA/lVPpLXxqFJ9ZUtTUBMUDUfNP1ipoYfrnJmltSmmgADgydto0htdQrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuwleGoQ7+g9Tpq77nrJu4PTwZmMV9TVf0t4UkKum8rbBD5Z6
	A82W/EJynoMBjGggjlc4J+ZQIIoQ4v6cFyaIs0UNqBYVwqCKJZSnk3BaTyXliqs=
X-Google-Smtp-Source: AGHT+IEzf03r1Z1fB6lurUUc6qWJa82LhtAXSaLcMJYbciKht7msDN0Dsyh19Ch1AuKML0LDr3EVZw==
X-Received: by 2002:a05:6512:308b:b0:535:d4e9:28c1 with SMTP id 2adb3069b0e04-539da3c6e43mr533170e87.20.1728627944658;
        Thu, 10 Oct 2024 23:25:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539d1b3c72asm269507e87.254.2024.10.10.23.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:25:43 -0700 (PDT)
Date: Fri, 11 Oct 2024 09:25:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
	agross@kernel.org, andersson@kernel.org, linux-kernel@vger.kernel.org, 
	konrad.dybcio@linaro.org, mchehab@kernel.org, quic_vgarodia@quicinc.com, 
	stanimir.k.varbanov@gmail.com, kvalo@kernel.org, quic_jjohnson@quicinc.com, 
	ath11k@lists.infradead.org
Subject: Re: [PATCH v7] arm64: dts: qcom: sa8775p-ride: add WiFi/BT nodes
Message-ID: <yttw2tici2n53m4rflmkcliwwvlm3v4vass5m7lsgf2ebf75gh@ztnroslejkr7>
References: <20241011041939.2916179-1-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011041939.2916179-1-quic_miaoqing@quicinc.com>

On Fri, Oct 11, 2024 at 12:19:39PM GMT, Miaoqing Pan wrote:
> Add a node for the PMU module of the WCN6855 present on the sa8775p-ride
> board. Assign its LDO power outputs to the existing WiFi/Bluetooth module.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
> v2:
>   - fix wcn6855-pmu compatible to "qcom,wcn6855-pmu".
>   - relocate pcieport0 node in alphabetical order.
> v3:
>   - add 'qcom,ath11k-calibration-variant = "SA8775P"'.
> v4:
>   - update 'ath11k-calibration-variant' to "Ride".
> v5:
>   - update 'Ride' to 'QC_SA8775P_Ride'.
> v6:
>   - no code change, fix patch version.
> v7:
>   - update 'Ride' to 'QC_SA8775P_Ride'.

Please consider using b4 for future submissions. It generally saves you
from such troubles.

> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 121 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi      |   2 +-
>  2 files changed, 122 insertions(+), 1 deletion(-)

3 revisions in 1 hour is a bit off. Though,

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

