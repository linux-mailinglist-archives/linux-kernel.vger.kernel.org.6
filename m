Return-Path: <linux-kernel+bounces-553026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A21A582A6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C35189026A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC65F1A2C29;
	Sun,  9 Mar 2025 09:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ab6N48KY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3ED19259F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512200; cv=none; b=sAHF8hWWITwVaHUqnZF31peZ4y5wJ6KJUtWAHW35GcbcAiljhMZYz2W7phNoLHu/rQKmVweQxNLzbvX53XB1EDIJO7grvCN0ZrTQj2i2pPWA7Yz8huCRUx/AqZTjg1e4AoAywolCBrjO0u2ETjPzw+lOMNsCy5cdB/VEuc2vbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512200; c=relaxed/simple;
	bh=64WZrmgyPkgy2YnI7U81yn6KSZ4lJ6AYo9WRW6tDuIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjAJupv8dfrPnAzTNZJ7yXWiPpgH9ju5CYBwisLlSiDYKnyzb+e0kD2f41ti5YbVfASdV0KDV4hpwvwZaYBvdeaXN2WbifGNNMj3K7/ecnXtUBISzwHb5j2DTFWVVjJN5K86G0+Lb/umewgAVNxN3070Gl2eoiB4C3qy3EMEWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ab6N48KY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abfe7b5fbe8so472353966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 01:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741512197; x=1742116997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WquEMt/nHeDbDu+wCTeJFQKwvIymjPr1TDpYSMcRfWU=;
        b=Ab6N48KYUd0NByEI5BB3psqhklj+00GGIuGJaQNZL4IGNMtzOgG0MyCOJsoSf8Ethc
         T40UWinA5DgG9RXZKSVL8k6xvYFl1N0inDBPZpXwpO1E40NhEwxTTlIKm8KOo+JWTSb3
         Pg2VJe82hNpzRLTxKrZBk1y5bsPdjguKP7H7UTGZSXamqAVnLo7EZXOqACSmksIUsDHV
         VPMaKl6FIKarroYDl1A5Pu3z+UgVDX8wxrypoILOSZ6aoVq3AwBx8+xnKUubS+5shycn
         d92qZronz82QiYKsqo2Y4GbVfbSenxKdEdiS6BxLIAXQ5ip04kP3p2QLHd5ZHy7kGrcW
         Tn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741512197; x=1742116997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WquEMt/nHeDbDu+wCTeJFQKwvIymjPr1TDpYSMcRfWU=;
        b=qztuPm8YtjdGVIlV5dVQO7XZBilu+aNniSZFbQfR9I7xs/6efCjnf74UoTnDSP9JC1
         pu1MMyLo9H88nZBccBxn5jdTF9/D38P3p0C3Pd9ic0sMw6dJ0gnQPgLrgLCJeAONEEvh
         wJykTL1XqNXj0CBpq7DuIOK5i9gQae0JBIpM1kAjUjlhLF67JmKHZ1oyiWbzFgb3LONC
         Q8X0vTKyTvjDVO/q72rYzfcWHXYYjkLizPqzsoHbaCiljbobY5UcjX3LexVWyzoRv11K
         YxGWnVYLPgnbTeb8+sCrGfLkHaOTqvyLw3Ad8mR5+/RAUDPFFAITm4tHg6AeFDltALWJ
         tRQw==
X-Forwarded-Encrypted: i=1; AJvYcCX9tjIHGw7ZG9jkIy1znKWDvuuVo5ka4so6rqldXsTkrcB9ZNHrkXy+t1u/ZsFzn6+f1RFPpdexsYKHSnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZot+WoL7d+IaEQYxV/xVMhO3stmoVq2hSTuVKkUM0dGjOp5vK
	jSrclvanJz0FGWTezaj2mDG1w9gC0z1b9wC5rHqlUm2kfueLk0oxZTx3V7GIUl8=
X-Gm-Gg: ASbGncu+UwTGklMxcXiNpD8AaUZfMidAVTBr7eXUkXqFNPAuep3tQNb3li9uDpxhomR
	+1iS3RDbmyh6DzHO++BUGrh5cd1ePHolLKyRh/n5lkE4PVOeIFNXRPelrHFlzKNUbLipLfYYEHY
	L1s8emf3Ivf0C+Z9NlJSsQC47UB7VFaUhrm2N5R0BKqLqpIA9VrR+uYQ3v20VhXGfdC57nt3soa
	Nt+DX3OY3FYggTmJ/Oi7z9H5XbTLt3AJqoCsjX5Cn8j3P9/+/hGYwAiIe4f2m1aNWU1NZDrd2yd
	XJ1uPvaQd8feUAnU9ELYQ3TtDW8jDHXE8IbQVGCKDg==
X-Google-Smtp-Source: AGHT+IETCUltWmQN+zLCmKRFkdNtCxZ4Os14U+jDnEz2nSP339omXsmyTsnb1B+RdPyq0H+r5s5iRw==
X-Received: by 2002:a05:6402:1d4c:b0:5e5:b53:fd49 with SMTP id 4fb4d7f45d1cf-5e5e229e46emr24575900a12.3.1741512196682;
        Sun, 09 Mar 2025 01:23:16 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fd48sm5071517a12.9.2025.03.09.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 01:23:15 -0800 (PST)
Date: Sun, 9 Mar 2025 11:23:12 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 0/4] arm64: dts: qcom: x1e80100: crd/t14s:
 Enable Parade Type-C retimers
Message-ID: <Z81eAMoXb9li4lba@linaro.org>
References: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-0-380a3e0e7edc@linaro.org>
 <ea9344b7-6646-4329-b8f6-45d2b51f183b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9344b7-6646-4329-b8f6-45d2b51f183b@gmail.com>

On 25-03-07 23:03:07, Aleksandrs Vinarskis wrote:
> 
> 
> On 2/20/25 18:42, Abel Vesa wrote:
> > Since the driver and dt-bindings have been alread merged, it has been
> > agreed offline that there is no point of holding on to these DT patches
> > even though there are some issues with plug/unplug during suspend in
> > both pmic-glink-altmode and ucsi-glink. These issues are being worked on
> > meanwhile. Merging these means that even though this will provide external DP
> > and USB orientation, plug/unplug during suspend will give some splats
> > and render both the USB orientation and DP broken. But then, other
> > X Elite boards already have these nodes described, so lets bring the crd
> > and t14s to the same level.
> > 
> > These patches are just a resend of the ones found in v5 and dropped in the v6
> > patchset of the driver and dt-bindings.
> > 
> > Link to v5: https://lore.kernel.org/all/20241112-x1e80100-ps8830-v5-0-4ad83af4d162@linaro.org/
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> If you will be respinning, could you please add link-frequencies to
> enable HBR3 speeds, similarly to [1]? Alternatively, I can also send
> fixups once this series lands.


It's already re-spun here:

https://lore.kernel.org/all/20250304-x1e80100-dts-crd-t14s-enable-typec-retimers-v6-0-e5a49fae4e94@linaro.org/

Waiting to be merged.

Lets make the HBR3 enablement a separate patchset as I'm not able to
test it in time, if we want external DP to be part of 6.15.

> 
> [1]
> https://lore.kernel.org/all/20250226231436.16138-1-alex.vinarskis@gmail.com/
> 
> Thanks,
> Alex
> 
> > ---
> > Abel Vesa (4):
> >        arm64: dts: qcom: x1e80100-crd: Describe the Parade PS8830 retimers
> >        arm64: dts: qcom: x1e80100-crd: Enable external DisplayPort support
> >        arm64: dts: qcom: x1e80100-t14s: Describe the Parade PS8830 retimers
> >        arm64: dts: qcom: x1e80100-t14s: Enable external DisplayPort support
> > 
> >   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 321 +++++++++++++-
> >   arch/arm64/boot/dts/qcom/x1e80100-crd.dts          | 474 ++++++++++++++++++++-
> >   2 files changed, 785 insertions(+), 10 deletions(-)
> > ---
> > base-commit: 50a0c754714aa3ea0b0e62f3765eb666a1579f24
> > change-id: 20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-325cdb7b097d
> > 
> > Best regards,
> 

