Return-Path: <linux-kernel+bounces-548731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC1A548AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1351693AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29F420CCF3;
	Thu,  6 Mar 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXIN1VTT"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12B20CCF0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258881; cv=none; b=b90UeH7na1RpZD+34z6bnza6yqz6zJFX2iTxLuFWKvaP4A3EiAo3LJD1PpfUoTxSCP7S0tUrdhFLhwZ/lcpDehSWaNpxV+/NleB4xpibyphd8rXygIHH14wumJxr8pU7xSCRApPZ52+bd7ZybzGFtyTIfeeexhA6tix+RDdtveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258881; c=relaxed/simple;
	bh=fF0AHv0s3S+dBIkriG8rfycx3SWlry9DEa+eTSo1+Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7rNcIdFA1/JrH8ekbjOVlSRG/QQuQ2pmqmxNl1VaFRxS5ilPZlujfCaBgepRSPxapgwvpgiiCFf75hXZBLZxEO5w3f1STRupm3mXOIqS+BNICyUeHUavzMtjVoBVRSK+bEq5vFSADsYH7auUDcfD40pranaaFxEmwNXwS3IKBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXIN1VTT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso360916f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741258878; x=1741863678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufdypkJNjHswejxJubFk9kEYQm8Yr9F5qH7/Hz14nEU=;
        b=zXIN1VTTTw2CqhlyeLaxW2YtNmml+KoAPBVDknget7P290ejT0JEnNHLL7EXWAAiZ6
         4EL5IuZaHbIa3vqd+28Jj1QonSHkoKmlar+A5usyq8JYvmQ6Auc7dfrWREYuzhBMbsq+
         nuBrDnWuRI9bVxIElm5sng4eLCNBFgQHmA8NqE/haxyRoryNZWfFHRZ13mkH1a/YQpA2
         J5EhZWW9iCXryUjorLglIKbGcACMgrDgPu8xl09Hxvp0vj7NS5bn5l8rIfpUm4dwzgj3
         mM1LJLGoJ0OQqqezJ9Gm8kzArwWubH9cw08PJkMvhCTtK/Svm0TEtWgTxeM65yWp0iB9
         KPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258878; x=1741863678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufdypkJNjHswejxJubFk9kEYQm8Yr9F5qH7/Hz14nEU=;
        b=Y75vop1pcUSSBOsK2CjCwOeoQi0x/4OndHSpaaJ2zfBJvdvg1GJ2HpgJO4uQfWYFg4
         L2QL/kR9J9496uGSQw0TtDl26JIy+UwCW+DmyySVxfB0kQv4JwF5i3pdILJKJIywSTOp
         ndyf0/fxaeQtyRwQuv6OzX1zFLCRjFa0ROH55ZfBWoiAHZF6QR66hav8D8MkUaCyUBVh
         4lXEkh1LYwpZnDGwoGG4P/FrTnNZGil2pTF298I/sjheBdY74VNTsE8G6v6kQADL59mL
         DwbpdaoJOLsstwzGkRsUDiGA0veNtElBivoqHCxXHGj72cV7SUjFPoRWdWDIVdGg2Pmu
         umnA==
X-Forwarded-Encrypted: i=1; AJvYcCWTazD6aIb19ERgf/0T50TJoa0J51Ock1+XvmxAOfS5+qL5Z7ktC7xze7C7TI0bzww1GE7p05GgEeGqkP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVft73g7MVWPso9WX/wxdgaHjr2Z5S6xUvDEuvDdC1sSJg/rF
	Lwm3zRufhgPr1pSZyRTug7RA80L/IFA/w5OmlNhec+G+3hpXIuae1l9lmY80YAw=
X-Gm-Gg: ASbGncs6KvWwxpI78uRuzDtfBs1hAI+J//EUpxRcpX9ao/1CpbIA7LeFmBZt5c7ssv9
	/HH6r39DGBkfSm/VQlLvDji1BnVlaULLzqfMkO1DgLGQVKa9e9ZIvafUSXrQNydiQw0gWUvHXsu
	dx8HWD3GiUt2XL8tMzdqdU+LLLFNmrZ+42mYTPyUds7XtwHcN/jIdtquaq/TVQr7UQybsX17K4a
	POj8qAfF2sukH+SxOE/suAJwwWJX6IVHMYFvEEi1Ge3rOYklDtwjpDknQ4LF+sZL395ZLgyvK/y
	oDyVYGlVNmDXn5sI3591ZPNgGqntyV5nTGshoBMEqFE/0O6XZQ==
X-Google-Smtp-Source: AGHT+IFaNI6+FuJB441Zt0saVFEq17tskKV/m1XJhXDsSDNyn2Dt0uqOjvxwn86BlqWjcXdpYtDX5A==
X-Received: by 2002:a5d:64a2:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-3911f741aa8mr5660504f8f.24.1741258877759;
        Thu, 06 Mar 2025 03:01:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8c327fsm16444235e9.13.2025.03.06.03.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:01:17 -0800 (PST)
Date: Thu, 6 Mar 2025 14:01:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: zuoqian <zuoqian113@gmail.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	viresh.kumar@linaro.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: scpi: compare kHz instead of Hz
Message-ID: <c6b8aa98-b5d3-4fc4-9f5d-4bf2471c3d6a@stanley.mountain>
References: <20250123075321.4442-1-zuoqian113@gmail.com>
 <20250125084950.1680-1-zuoqian113@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125084950.1680-1-zuoqian113@gmail.com>

On Sat, Jan 25, 2025 at 08:49:49AM +0000, zuoqian wrote:
> The CPU rate from clk_get_rate() may not be divisible by 1000
> (e.g., 133333333). But the rate calculated from frequency(kHz) is
> always divisible by 1000 (e.g., 133333000).
> Comparing the rate causes a warning during CPU scaling:
> "cpufreq: __target_index: Failed to change cpu frequency: -5".
> When we choose to compare kHz here, the issue does not occur.
> 
> Fixes: 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
> Signed-off-by: zuoqian <zuoqian113@gmail.com>
> ---
> V1 -> V2: rename freq to freq_khz, change rate to unsigned long, and
> update patch summary.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


