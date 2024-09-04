Return-Path: <linux-kernel+bounces-314349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C6396B225
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACA5287B8E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 06:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A46A145FEB;
	Wed,  4 Sep 2024 06:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4JB0Bls"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66987145A1B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725432636; cv=none; b=Dy+3Syn6OLuT9DVLtSjU7R4BSiSHGi2sI/Nuk9iHH/AL4Zwq0OJBxrZOM3WwA7HW2pgUDxv/BBN0e9hY3Iwc/dcrQSiRYfkkpD9LlLrraHZRyxhkfa3FG5IHPDl9b8nNuBSiYxJCJXzzmJoClfe2GILXnSwf+uUzj/QKbJHxQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725432636; c=relaxed/simple;
	bh=HpLRa4Rvt/+aAqe7IwAUdh3ViPIKY5BzBPQgUSEG2Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX+xRcmej6sEz2G4Tqw+AHWCMlGH2puEiabjuYOdjoujp90x6O0RL6/RkxW7JEau7n5i1tTioULP7nnj+Uqg6SJssOfq3hCXSNACiJ4vZ5cDNxqEIyjbeoJw5wdqw6+cb3eaGCRGI27Pfg8Bm0sjOTaJg41kWoHyfzntx8PuQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S4JB0Bls; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-201d5af11a4so54061205ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725432635; x=1726037435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=en2oD5qDU2tZ2yKUFz47PNROzUaBtikH/wne/ueokiQ=;
        b=S4JB0Blsry9wagRKRzgguTMN2QY1C70Yw37rOuspCFfPQV9yA8t6cagvZOK5MEiF/k
         jZgjhMr3yLlz69MGdhn+HQxSYG0dX3HPyK1yodFMviKstagw7jR19udvyR8RQwhaBPNn
         mALm8L3gtQMHbpDS1ZxsLJLzOWueynR9hveQ2S4GeoeQDTb0NQAlML10V0JtQEJZ1HYi
         6DTiXGMENEqfEK8vMGUOS3qm3MofE4NGJAseaRic4/XHanZhgEE6VN4gTa/7YEUp407Y
         58HulOvoqeDFl8gvHbNSgk6cluVYbO57OFVfoySmq6G7wrV1W1L6nF+yqXEusOsEg8Kv
         nncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725432635; x=1726037435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en2oD5qDU2tZ2yKUFz47PNROzUaBtikH/wne/ueokiQ=;
        b=g3416S64yEqGFs2RiX+J8X24jDsUx/w9x51Fz93i030K7hpDnGawyO5+JRtWaRk5A+
         QwuTLKTylJdIcU2Yj1igyjet9zvXDleppTeGAtue4DJFN2EM0QXE9tojmCElWHFshU8b
         eXeAkyy0vLWvF2nlhv3Y9nmy2um2PuqzBBryxfrYCl6eTemjFw+zzb/u4ifUdQCo5vKI
         a5VoXICl16kwv679+xy0WCRSL9zhGUhWPNY9TN0SpeOAhfEXv4zzdxIeXtz2JTIVijBY
         HFcbdg607BGn3kQA3Vj8LtQqxtHqx6hbATodjobG+SyQ+gFMJvRTXYsxCVAsjHebGxJK
         ZuzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPmr9qmOd0mDOBMta1tqMzN3D7RI+lyTNgyvtn9d77Eo0fikZGyDimVenyKSGnmvQnSPHUMqCom0pn2Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybt9llMoFybrXFLN9pUGYTF+PyTi/OqnVU1N8uhvWswHhaso0A
	6CPT7X46uo7yoDiE5Ec0GugSoGuw9umL9pWEDyplC74S7t7Jtm1LxVyUJCqUdRU=
X-Google-Smtp-Source: AGHT+IHuXkPrjnRxHzKUt+c3fsqI1O6+trvX9+ZrTiAv83zDvIGejHvXzro9xkUdyvXrL9OT3DDtvw==
X-Received: by 2002:a17:902:ebc5:b0:1fb:4a68:b7bf with SMTP id d9443c01a7336-20546b35bd7mr151754375ad.45.1725432634728;
        Tue, 03 Sep 2024 23:50:34 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae913674sm7704755ad.51.2024.09.03.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 23:50:34 -0700 (PDT)
Date: Wed, 4 Sep 2024 12:20:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: opp: operating-points-v2-ti-cpu: Update
 maintainers
Message-ID: <20240904065032.zetnlmzbswae44mu@vireshk-i7>
References: <20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com>
 <20240903-b4-opp-dt-binding-fix-v1-2-f7e186456d9f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-b4-opp-dt-binding-fix-v1-2-f7e186456d9f@ti.com>

On 03-09-24, 16:00, Dhruva Gole wrote:
> Update the maintainers entry since I will be taking over this file from
> now.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  Documentation/devicetree/bindings/opp/operating-points-v2-ti-cpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

