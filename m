Return-Path: <linux-kernel+bounces-446043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0489F1F08
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC6A1884821
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD8192D8C;
	Sat, 14 Dec 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEfcoWpE"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219A191F89
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183574; cv=none; b=LyKlfjmHi8P2VGKOOJFIEfdpyk8gMqsJai68nL1fSP2Dp53CpjsU0ls2OwPK5kAQMcZo5rxCBNZ1hqFPQ7irs7QKF4KhMJCAAwaMPjGbV+QUlRt/gP6pmOLCKnFR4+cJo0yrgDyqBuKOfbWAI7MjpGeDTw25aS2zKpqCsTMx3Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183574; c=relaxed/simple;
	bh=uCCTyowJytqPjeU0yepVW6ZTRMX3ONlee0DNAXnNUZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uebFArBaijgCH31KJQ6YDsRr7Y31j8KHkVmZoMuTy0G6EN1KTisLtipHo7/p2I+5+MFfb6LZ5VIjiKa8JIqtw/DCMZCmZwkZkmZJHtNJOnZms5vy0mFy1p1yw6suNBfUhyCXNNa1sWl8svnWMaVSWjmJttGQ68zidYhJcAa52mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iEfcoWpE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-300392cc4caso31141701fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 05:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734183571; x=1734788371; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PyYLiYc+Kz4TS/e32iRPlnuJpX7Gz5eKbfwdorLaoU4=;
        b=iEfcoWpEi74xTB9YuVx+oaXlc510z+LughYijBiQc41m8PHiJISfTuaJSPaugpVuiH
         /MFfAkXV663Fr86vxeS9aEUiAavuAakOLIvek3kTF3sKCGnG3HQb45lh6wcEwEEgwDNW
         Fw/EYfU0tOwfNuNKRZDPapEeQKx1UbpXHNU11GRnGQvxMxsaqApzxsDyw8l9aaBHpMeV
         nVwLmS1aACTuoRBCoMIKG39N1Yv11Xp0Htnd2fndyBHy9zEKvPSA5fjXS4PbqkDnZb9b
         XyrQjcQ5zJBbaDxYdCBMjDtx/R79Ze5gB0ib3H5qXHNGO0xVXmPSrfJlHzJZVxUUJC/B
         x6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734183571; x=1734788371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyYLiYc+Kz4TS/e32iRPlnuJpX7Gz5eKbfwdorLaoU4=;
        b=UpU3hkIFL+FYcZ7KfLJ3mUzivvitq5GnFQ3FFhwDgkME9O8yyv3ZZNBCWIa3aYGLrq
         hlhwa/sG/H4/WmRUy1DJJbyQuSAQyuHQXUGT/GR/nlFoDMSP5uYINAtb2bk8dUC5UbqS
         B+eZQoyVtMRYHB9Di+0AJY+pjIBTuBnOXz95/SnQmQRLoTFscKea9buAUpN2ojCG+7bk
         mnc9qGC0Z25anxwzDgU6SIjddYULxdT+FGb0ZUF0Yw4ji99t3wDvtXV5cfqN2EHSurZS
         6OYOqIOQ/yirbI4x6q6R6mfneLEL4ZYOFgEltoOW8jWGzDkIp0T83nXigBYQkdDyNb1x
         1R9A==
X-Forwarded-Encrypted: i=1; AJvYcCXPQxAmmR18HnUWhr03Ryb6pnCqj7GXvrMI2M9GcjxpFsMFy+DnfmzUhgY4K7OsTMZeOtyoCPVfkFPoXKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Qm3+vAPegLM+u/+l16PefkoOJyZtMHk+nixAPJ+hveJSjPQi
	zAsBz+BsZMEL9wXA9qmzGgMI4ptlYQg81KO1IsXfUYOdWN/c6cA1ktfGc9pD3cY=
X-Gm-Gg: ASbGncsSldsP8KXw/hcbdjfYFNAwHF4OkgzR9qW3QJh0+USnA6ZyaEW6epqlzSeShm3
	7ERObVfM1QggZH+gE2SknCTjrDOZfaxatnNnEND8Xws4eAB/LcVr0oIieH8INfvit1EUMsnKhAl
	2bggynFoPI5wpst1Z7IAugQvrKkSAZTJyntG4mPxNwEBRabTUous/phir6PAi0oYnYIHFL7nW+t
	RuyYcM4WMLDpPgsd3P05fm5Cf6pwcAd8TGdpE+4rrchHcOm6xmr088hElEOG5wFKcLid7G7nkR4
	STawbFcv+41lncAHUEH9SFsRv1m/cc7bgYxN
X-Google-Smtp-Source: AGHT+IFiGcfkBdkpjQAPcZxAxvnDue49Lcam66Ov/sQHEPWgB+rp6vC1TwupJiCBCPo5zIatJCwGYw==
X-Received: by 2002:a05:651c:1544:b0:2ff:d83d:9155 with SMTP id 38308e7fff4ca-302544f9757mr21690611fa.27.1734183571029;
        Sat, 14 Dec 2024 05:39:31 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30344061e1bsm2427441fa.51.2024.12.14.05.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 05:39:29 -0800 (PST)
Date: Sat, 14 Dec 2024 15:39:27 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: andersson@kernel.org, chenxuecong2009@outlook.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, gty0622@gmail.com, johan+linaro@kernel.org, 
	konrad.dybcio@oss.qualcomm.com, konradybcio@kernel.org, krzk+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add Huawei Matebook E Go
 (sc8280xp)
Message-ID: <lwhell4z72srw67gj6gpt2uyqzx4k5dzjw5xs7dab6lbya7soi@tsoh2bcn2gwc>
References: <20241213085100.564547-1-mitltlatltl@gmail.com>
 <20241214122303.653935-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241214122303.653935-1-mitltlatltl@gmail.com>

On Sat, Dec 14, 2024 at 08:23:00PM +0800, Pengyu Luo wrote:
> On Fri, Dec 13, 2024 at 1:13 AM Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> 
> [...]
> 
> >> +
> >> +		/* /lib/firmware/ath11k/WCN6855/hw2.1/board-2.bin
> >> +		 * there is no calibrate data for huawei,
> >> +		 * but they have the same subsystem-device id
> >> +		 */
> >> +		qcom,ath11k-calibration-variant = "LE_X13S";
> > 
> > Oh, this can be taken care of! See [2], [3].
> 
> [...]
> 
> Hi, Konrad
> 
> I want to distrub you again.
> 
> Finally, I found something, after I enabled ath11k boot dbg, I got my
> id_string='bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=255`
> 
> With qca-swiss-army-knife (see [1])
> 
> $ ./ath11k-bdencoder -e board-2.bin | grep -i "$id_string"
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=255.bin created size: 60048
> 
> It have already been here. So that means I don't need to extract from
> Windows. I just extract it from linux-firmware then give it a variant
> name and send patches to ath11k, right?

No. Usually 255 is an ID that is used by a variety of boards. So,
basically, you have to extract board data from Windows, add a proper
calibration variant that is specific to your board and then send the
resulting data to the ath11k mailing list.

> 
> Pengyu
> 
> [1] https://github.com/qca/qca-swiss-army-knife

-- 
With best wishes
Dmitry

