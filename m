Return-Path: <linux-kernel+bounces-446096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7889F1FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF43166B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966BA1991C1;
	Sat, 14 Dec 2024 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xU5dQtHj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6D1925A3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734192083; cv=none; b=S5ZCOuhepxYLAEnIVx/puMGVzDKD7s/VMwZLxnQ0boXP7KBPdAiYnEDjcDEFhUW4wgS0ElOzonpDBsdlraQRBRAiIriYsJq65u6ibUPrVgEQjSjERm8sCtDTTccgkQlkvfq7LPepwNY1K2u+tm+dIrxSzox65JtwpdGqU3lH2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734192083; c=relaxed/simple;
	bh=djCkpaOEEQOt3dJ6XDBzVVotj3XZNCPmkRaNCWtfNKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsssciTJTCHMYpm3t0RQpfS+tO7ZpYTgrUKRNctkIospzLCL1DUPyeIsgfCzjFSRj0+JhGwnOrh8EYx3NIdYlPSNHe5sv4jc+6z6km6rLzTwWt/CdUdfyRHqpLsr73IomkeH4XZe17a+UFe8SXOT2LmVsbHtGWaJGJLH2Da01QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xU5dQtHj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3022c61557cso26780861fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 08:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734192079; x=1734796879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=52OmguDOAfIxjeQcqf1HnSRCwwgdXocUlZ7XVYEBwug=;
        b=xU5dQtHjD/n3i78eHFfu9aWgjFAb2tiWLo2KCzm/eOx09uerF5MvEGIvqG2WfnjhAB
         sN+obNNmRn4xKv9x52DErZsPZ6l50JF579UC2dSEibqPg6bGFomhKsB7QTZYz8xA3hoF
         Zo4MWm8UKcGLyMBYQO0yvbmWBHrlQNALB6rk2QhhogWipRNmKC01yvzZoabcjDCdB4kK
         2QJ8BNd/cKqYL0K0qPAdQFcxe52ooaYicpubXru/pNFuiLDxrykTru/BgdLo60O1g10c
         CCMZ+ZSWmixTwqyZz0DKZt3GBseGy7BlBmsQVx+stgEka5XuJ35Jmd/PdlfJuwpTbXbH
         jt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734192079; x=1734796879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52OmguDOAfIxjeQcqf1HnSRCwwgdXocUlZ7XVYEBwug=;
        b=df5kHel7mhMJFodCIkd+yxSq6VqqVtUPJZtO3aHXvUXRMfK+UVmqvQdkzHEMMzfi1+
         n45JzJuVq8LhlcHZPsAP2Hb9JcZq01vAGJh58lLSBZFXmWQGe5Ax3TgvpTjf/U0L1bgD
         HQeegj7OPB/fNoBKjXWAVCfkdXN+Nyle2WQjtTZnymWl2cjCrvUJr2LIK+WDGuSRNeE9
         UzJI0iz8qDO0kcr8dRtsBc5q2tg3V4FwfAb3qhWDSFmsMqRN3fz8pEgTb7yQA9/hLjjj
         kqgIXll3XoOXgNHHvyOvCOYH1vpB9pYbF+GZ4fo5L0b0inQ7PC8vzMXv/MH24Z6DsDWr
         DohQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxrTNMQCNFy0OdYZWCV5TdZSLxgEoaY3iow+8+aiJImRFrSdibWbu/iayyDCFpGKYbkBjdA05LuYHRGmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYSyNdXjoSAmip1VdmSiUvY2FqAvf7iEr00aY3dLzaVf0or3p
	ceDNd0IvDpHUjpe3PellHhaQDn8PaIwWDm9Ef2GX5BMEcKhAWCiRQwianjF8ZNE=
X-Gm-Gg: ASbGnctWkgoqBSwxmf959dvXTzffO3BxUz98wnMbV6IQzLkGLqpbyG6woXZod6/bujJ
	1Q8aHRIfhgxoi5+apAbNdBxGLHfpbgiyn84gwqHD+YUWOdAFdDQV60Xhv4s5TGZpiCiNxGmIX8v
	3RDzW1msR63I8NXuQzyjuvh3AzxAYtjEPhOJHZBuLNSXYYpHh7dSm7xPmPBUcG+RViOH2iHEkSZ
	TrjjPe1gBW/2lwrhuWuojwo3S5KGTnYxqMAmMuFprJAOuzjU1v6ZIULmwqaM4VqJWF0g3u0z9TJ
	hvD2aPPJktITCscZjyUxBhSX9A39LJTB2cbz
X-Google-Smtp-Source: AGHT+IEJRVT5tEabRS8qiSPbOAqG0r3Ssvy5rTdPzfII22ZDgilHlDbeUnMbHUqE4fRYDG7JFW0h+Q==
X-Received: by 2002:a05:6512:3ca8:b0:53e:398c:bf9e with SMTP id 2adb3069b0e04-54099b69e14mr1768658e87.55.1734192079113;
        Sat, 14 Dec 2024 08:01:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c20ac2sm247759e87.258.2024.12.14.08.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 08:01:17 -0800 (PST)
Date: Sat, 14 Dec 2024 18:01:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: andersson@kernel.org, chenxuecong2009@outlook.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, gty0622@gmail.com, johan+linaro@kernel.org, 
	konrad.dybcio@oss.qualcomm.com, konradybcio@kernel.org, krzk+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add Huawei Matebook E Go
 (sc8280xp)
Message-ID: <qdnwj54vloxf5xqkesx3vbqjdwfjnz46ca6epagbxolvjwq75y@3ig2ljaxzxmf>
References: <lwhell4z72srw67gj6gpt2uyqzx4k5dzjw5xs7dab6lbya7soi@tsoh2bcn2gwc>
 <20241214144829.670851-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241214144829.670851-1-mitltlatltl@gmail.com>

On Sat, Dec 14, 2024 at 10:48:28PM +0800, Pengyu Luo wrote:
> On Sat, Dec 14, 2024 at 9:39 PM Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
> > On Sat, Dec 14, 2024 at 08:23:00PM +0800, Pengyu Luo wrote:
> >> On Fri, Dec 13, 2024 at 1:13 AM Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
> >>
> >> [...]
> >>
> >> >> +
> >> >> +          /* /lib/firmware/ath11k/WCN6855/hw2.1/board-2.bin
> >> >> +           * there is no calibrate data for huawei,
> >> >> +           * but they have the same subsystem-device id
> >> >> +           */
> >> >> +          qcom,ath11k-calibration-variant = "LE_X13S";
> >> >
> >> > Oh, this can be taken care of! See [2], [3].
> >>
> >> [...]
> >>
> >> Hi, Konrad
> >>
> >> I want to distrub you again.
> >>
> >> Finally, I found something, after I enabled ath11k boot dbg, I got my
> >> id_string='bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=255`
> >>
> >> With qca-swiss-army-knife (see [1])
> >>
> >> $ ./ath11k-bdencoder -e board-2.bin | grep -i "$id_string"
> >> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=255.bin created size: 60048
> >>
> >> It have already been here. So that means I don't need to extract from
> >> Windows. I just extract it from linux-firmware then give it a variant
> >> name and send patches to ath11k, right?
> > 
> > No. Usually 255 is an ID that is used by a variety of boards. So,
> > basically, you have to extract board data from Windows, add a proper
> > calibration variant that is specific to your board and then send the
> > resulting data to the ath11k mailing list.
> > 
> 
> But how? Is it possible that some boards have no  calibration data?
> I tried to track the access time of files, the result shows that these
> bdwlan* are never touched. According to my observation, these files
> should have been accessed, (like BT firmware on windows).

On Windows? Unfortunately I have no idea :-( Please try asking on the
ath11k mailing list.

> 
> >>
> >> Pengyu
> >>
> >> [1] https://github.com/qca/qca-swiss-army-knife
> >
> > --
> > With best wishes
> > Dmitry
> 
> 
> Pengyu

-- 
With best wishes
Dmitry

