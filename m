Return-Path: <linux-kernel+bounces-181898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4A8C8301
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A519B2164D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7014629CF0;
	Fri, 17 May 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="fCQKzEXp"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0A23758
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715936926; cv=none; b=j5qcRiWaJaNz2BJSc0hr64una3FWhMm3UpKZCnPrLRLhTe38QpsvHx+sCpwQIfgRO8K5Fxh/b9B41vn914CYl+UW9Ogr3L0bqX7aCfXHpkoBK7+okQ3Em/w4IbKc2dYPw6qws9OQgVqWEthf9/xw5Xq0hvwR9bs/oeG7sDR5sYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715936926; c=relaxed/simple;
	bh=TEHtCpgbdlqVzF1zXyzG1Szb517FKtFzCdajAHVAtmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJu+yIduO4L70oIXYJ092GCyiepq2wmRJIw6qwDQ6TOTGgJsbh2IqLWyjM/ClHosKfp0ipTxCAfjyvGoq/TAsBsis49tpdulRBrEEolxzrs7TMwkr/1Tlh5FVHhuqM/+xqxW8rbbUr3aamW7vZ+4D+Ff4Mh3Yv1SuzD00joR4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=fCQKzEXp; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59b097b202so335334566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1715936922; x=1716541722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xwh3lnhUhd7oHBvNUUgJZI2n83eK0ml7NC11m5y4KDs=;
        b=fCQKzEXpavPM+TuuR2ydaqtoyHospQaCnY360d1397CsR/nVbCTa1Qy0Q6YgjGqt/L
         tkD71mYnNkf4JPg+za0s+krI91AaiQcmsYTm4eo+hR1+6FJ+qk/r5PdHGmxxoOu+1SCX
         F9V6iL22RWAp6X/30O+cd43S0eAmvVGbO5AUngW1ROKKRaBdzP0CjmFdyCyKzmBiHMny
         XTxVCY32sQO2rL7jTXyskzCSalfN9RyM42mpoT51TCTfzB3+een6ul3CRmKuVeFabpZG
         jAaJH9a6IS9HafT9TBmAZe1RcPATh6djiTWWBCIZnVzt7R7M4BGByqqfEZGdWKs9ZCyh
         SsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715936922; x=1716541722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xwh3lnhUhd7oHBvNUUgJZI2n83eK0ml7NC11m5y4KDs=;
        b=LhAasu5b7bl2BTQdig056b6WqeaGIj6+Ge4BUwIgAKCE40A26iajVgZBhcOZHhehJO
         dLW/msn0QJw9KRStXy5xD2I+i986tKI/Ef4gVoCW8IXNXaEBGHb8fITy5c66jv5oCvp4
         AFO5ooAaM541aaQ9/PNkos7N4WoEg+nFU3f+ju5kgzMTRXmG3zBgoseFnIxvZV3ufour
         6u6PGIW3FnJsw9ihUIGZCyR7Cux0Mx1TVXVH9XwCfth7QEpnFKu1hFEE3a8SkE+9BYIu
         fI8jTqDg58xHodaV/KhqQgND4pGUuSd3FA4BPybsojapLSluGLwdsxbFHBDU/PEylisQ
         3QeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtOH3k7qJQr4AfHsMhIR7pq3KBUDzhubMgrVv/u8tjSfSSpzvjPzSvUrJZ7hLhINR1fHate0vDSd2KLoPutHzp7OdITCRdKBFGzGv3
X-Gm-Message-State: AOJu0YwQH2v2ATU39FIvyNsYpIDUpum+du75l/xy1BTHHC7dqe3fj16Q
	5/mhL/Ie4c8KrSHmwyEa8bVAarbPaWpzBVHm/oDhpY3E4C32XZiVJSWqDwyAuIM=
X-Google-Smtp-Source: AGHT+IEgG+ysyN5p95zBEB/teN7eTbSrbUtVmUotuv5u7b9gbXK+Nvx5y+aX5ItM1vbciitmK35z4g==
X-Received: by 2002:a17:906:4886:b0:a59:a83b:d435 with SMTP id a640c23a62f3a-a5a2d55aa50mr1373772366b.18.1715936921554;
        Fri, 17 May 2024 02:08:41 -0700 (PDT)
Received: from [10.91.1.133] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17886sm1097162266b.210.2024.05.17.02.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 02:08:40 -0700 (PDT)
Message-ID: <40730e9f-ae2b-4b56-89bd-f839876271fe@nexus-software.ie>
Date: Fri, 17 May 2024 11:08:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] remoteproc: qcom_q6v5_pas: Add hwspinlock bust on
 stop
Content-Language: en-US
To: Chris Lew <quic_clew@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, Richard Maina <quic_rmaina@quicinc.com>
References: <20240516-hwspinlock-bust-v1-0-47a90a859238@quicinc.com>
 <20240516-hwspinlock-bust-v1-6-47a90a859238@quicinc.com>
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20240516-hwspinlock-bust-v1-6-47a90a859238@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/05/2024 00:58, Chris Lew wrote:
> From: Richard Maina <quic_rmaina@quicinc.com>
> 
> When remoteproc goes down unexpectedly this results in a state where any
> acquired hwspinlocks will remain locked possibly resulting in deadlock.
> In order to ensure all locks are freed we include a call to
> hwspin_lock_bust() during remoteproc shutdown.
> 
> For qcom_q6v5_pas remoteprocs, each remoteproc has an assigned id that
> is used to take the hwspinlock. Remoteproc should use this id to try and
> bust the lock on remoteproc stop.
> 
> This edge case only occurs with q6v5_pas watchdog crashes. The error
> fatal case has handling to clear the hwspinlock before the error fatal
> interrupt is triggered.
> 
> Signed-off-by: Richard Maina <quic_rmaina@quicinc.com>
> Signed-off-by: Chris Lew <quic_clew@quicinc.com>
> ---

> +	if (adsp->hwlock) {
> +		ret = hwspin_lock_bust(adsp->hwlock, adsp->hwlock_id);
> +		if (ret)
> +			dev_info(adsp->dev, "failed to bust hwspinlock\n");

qcom_hwspinlock_bust() already prints an error on failure, you're 
printing a second error here.

Choose at most one.

---
bod

