Return-Path: <linux-kernel+bounces-563387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C8A640A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC4A1890E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44832192EE;
	Mon, 17 Mar 2025 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFsN35dg"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95B1A5B96
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191548; cv=none; b=cwVawBq98v1UQ+CB7VNNWeQOcfSTeOBBQSzNbTbyNAhYaoVdqY3NSIfc3IKCfGdwPXkMr2HbCIrB4CXLJ5R7L3J2Awzwrq55jAthdmnlpEo6EB3vcIgAEpS4iZm6pssPEvsuYtPKBspNTViIfIi00FyXQhFMhWyfe+p2Y1Evvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191548; c=relaxed/simple;
	bh=G2vibGduTBb4ht3i3PKQRMy9Dmd98eR9I1FTyOeaPLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtd33SvKwmKyceVu22KRsdPIynOo3M4cpu80O00qy9/cSSHlow4cD5AxdZnsvx91SARsEhVuEQreK2hRByDSzuNGF1UeL+F5l1y72CY6S4/ahPe6bAWWpVyjaklel/3uPetUuzc4x1emA86K7e0cIvQrIuf/NqkerKfio8n4gDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFsN35dg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-300f92661fcso2190621a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742191546; x=1742796346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upw8uAtsaSrMPnUE86VOFztOWYUwfbafLAIdnBxyqLs=;
        b=EFsN35dgnr2o6vUSJkigYRiHu36/zDmuPUW6p9L//TW+DNHwwmZiBtIrPLdRwl8lZH
         v/wHjpxKOrJFCXJK71CYifHA1biWDfrxqLwC3od8LBX/3F6BbBtmd38eGzETqwT16vp+
         imoRg11Z9M1EETvCQWyvYJE2puBUtMPhNAeMzn+1p+KWXKcI5lvX6GZreSJNOIkb/rrY
         XbUhyUfrWamlF3EpF0iuVx9zxcHQA+p9+P2P2D4RbkNAaB17Di3nd01QAgwnYMpOREpw
         mJQCo2qUVHxUZGD07XqCPX0cTo8nXcN593uQluW+rfHj0r7Qw0lgHuVSuylVVZ/BzYgx
         VV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742191546; x=1742796346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upw8uAtsaSrMPnUE86VOFztOWYUwfbafLAIdnBxyqLs=;
        b=aXWFPQhfxhW+NUxkv3+IQHG0xRpM5aKQ8yQs/8RaXjte/tEL5yYMc+RFhbGU4PmK4o
         11X1qu5fq2oAoytQ2QIqgZCRizXo7E6ZhcxIkl2+/0+LRYMIgLHIJRK2z7vSf55qyB8D
         pPT5jwRaw4hNFmpiTtIT/iHFMCseAKvFM3s5jmgdxGVfb/3PiFS38G2NpdU3HSNq/6d/
         wIIMpsWBOtABQaAAFNXfYwmhQ0sX7fxRgPyvjb91M+fNxaP7bm/XJsPlch5ufp8LZUQS
         DCM2RRH0c4EixeuEz1yynvCZYTfOJh/xmEYIniVT3QtHAs2ctYc2Pz10Nxjy1pW3hdAZ
         AcoA==
X-Forwarded-Encrypted: i=1; AJvYcCV7A21yEvd/xD3iW5CO8HLjLAP+0HW9QmKEhCR3E5yG2V8H6g1Dhi7N13fF4d/R+bLAibO0o/9M7P7s2vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGjZ1P9kcyGtXac74G7muXiPUuFtu4oRHXm0viodsMsJGuvLuU
	FURys75HqeUUD8dKXrPQrxCA69LdSxiimwiqiXYrDrpwCtGbNxS/TS2qqLPtrWQ=
X-Gm-Gg: ASbGncu+oGSFwyFc0Nu3Ne+SI8FA3EbciossW6BUPi1c5FvuLdi+tGTiMGyH0LGEEig
	WLdrJwRuU8GfpgogFovHCM92m6iqTM5EYmnwfjMsriiWO+h/P9XC/geQrOj79iOZQ/8Wk2wnvsv
	Dn28FGgr6+Pfq9a/Qa0b38t1LTdWKUJazLVLL2pjJQD91ORTbyoIFV0boGY3cBhtIHxBXztDbiy
	rgMIU1vPukFqVbvX7vtsfdkl+8oEvzKCBCO70lL5g7XHJ+VMQJUdlx9HefHLbO1bnxto0zQVQXZ
	/sy6LHpJm3m8ic4+SmmOsulqXjvy7Y79uYh2KN+qHu/GgQ==
X-Google-Smtp-Source: AGHT+IFtexjCDcyLpMQ7w8Tna8IXMKgR/Z0hgY4wOijyqJA7aak89tOVwk16u6S1c8FJcbWL2KbxKQ==
X-Received: by 2002:a05:6a21:6191:b0:1f5:7862:7f3a with SMTP id adf61e73a8af0-1f5c121e71cmr16343310637.14.1742191546167;
        Sun, 16 Mar 2025 23:05:46 -0700 (PDT)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371152948fsm6985187b3a.16.2025.03.16.23.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 23:05:45 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:35:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Few
 improvements
Message-ID: <20250317060543.ebqshqxngd4mhrcf@vireshk-i7>
References: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>

On 13-03-25, 10:08, Krzysztof Kozlowski wrote:
> Make the cpufreq-epss/hw schema a bit stricter for each variant.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (3):
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing constraint for interrupt-names
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Drop redundant minItems:1
>       dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on SDX75, SA8775p and SM8650
> 
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 33 +++++++++++++++++++---
>  1 file changed, 29 insertions(+), 4 deletions(-)

Applied. Thanks.

-- 
viresh

