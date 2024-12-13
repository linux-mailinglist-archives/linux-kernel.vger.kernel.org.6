Return-Path: <linux-kernel+bounces-444248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B29F0354
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F961889336
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97B7175D5D;
	Fri, 13 Dec 2024 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6YAOvUG"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EEE16D4E6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062406; cv=none; b=LhYGWdwW2O92TcfbfiTuSS2vGSO1B+BIINzL+7HLZlRkFoxzRE3j5BcmWnKBcG6IM7M/kGxMvXgu2WQi5hcvgX5NxfWQPs2rmfAS1vF6sJaf1TU3Z1NsC5xgNhv5TWLh/1/jyWU+BH///zZnHKnYetIax51IaGigJn9Ds40dZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062406; c=relaxed/simple;
	bh=P01/0GoHPmuEpkWAv0N7wro68NmfQGGEanTXYNwOczo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgS5rJpVWCEj5tFuU8uBITCk1TwemIsICcSWHGg0NJ1aiuubghABdgZol/cbjkt7Nv2kjbEkuqsmpIKhDgqzmcxoERAe7WkgZyy3kPl9sr0OxiNv7Tk3XJQlXMIQcvaM5oloeSMG3a0pNFA61nGLkUU1C4kc5FUCQtsbnegAGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d6YAOvUG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728e1799d95so1533999b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734062404; x=1734667204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uhXht5TlWW6CeNHzuz55gp9axLJIkTvb4c0JWEpQZMs=;
        b=d6YAOvUGswYQvn4sx5Xzz409DT3A9wRiFs7hyXls7RKX/b0iQbSHVgA9tX5ySaYWO2
         F+xWn7L3KsxniE4JxmQsnfuT8+6vf1d7RKsieUVvMmtbHuTSKxS7P+3yESyJcA2Y75ku
         JLICNjK/FyPPFubP5H7I+LtI4AK65nJTo348m+jeAjFY330orOai9zStDF7JNFpKgSFD
         ocYb7SeuF3E//wbCEwi1TvVygtE0mMNsJ1k068W199B6HiKCym1oH8Su0d2i0QFrCQqg
         x1bGiSYZ8hEJnXF3R7swvAAF/fofDznrfJm5NauHIN7UL47J9ydSVrUbtLqdCxRMmtjF
         nXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062404; x=1734667204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhXht5TlWW6CeNHzuz55gp9axLJIkTvb4c0JWEpQZMs=;
        b=FmMcfIekP94iYUtD8+CfQNOMdoBhFPWClg0+a41EzRhEaEVN0ROwkP4A7PwVwk8ZOc
         3cfWEzornLRCs9B5gVfOqI8UcsHHXPaQul2DvjnhUlwcVMGpcFuUZw7Ze0SqQZIvyr4X
         Rx6DSXXFS5VD9HkDNXFNBn0+fmmkUeYDks+yZmc8ixqlsxgCInovdRWZxpJvOLEao9Be
         l28xmBUov0Rqcn7vjXFLPqpGdhwUO1EGG22QMGonoLH4GMhO4Jn2Sr8b1HGKUbKZqkmq
         oFLy83nyPCyaXlCodweUM21VvreN4ihlFrYikS/FZTBY+Lz4JpK7fEsI5ajrqIWbJPUY
         f+TA==
X-Forwarded-Encrypted: i=1; AJvYcCVSX9ZNZmuQRjIz83KP979RtnU99FLGBB8qB7Hi8Vd0HUh3F1BtQ3aCj1TpkqkdRijPTcQz282wsa9w6mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhmQABo+YVsDvqZCHxDfo3pVrAjZucqaI7suOLHWtmOkMIsmUr
	ioluts1wdi4B6wv60m7Cvodr3ueZ41lzT2Y7vIuO3Z8Yl5qSWyMwMtnwRf7OhFg=
X-Gm-Gg: ASbGncvofJbdlisSkomBf22Wg7riNkWbWRvsHW8vYfSAJWG/FXV8XK1P8qm2N7JACQG
	WUui0+CMXfrLoUORsDwCwyTFhjrqJvfydreUJ84tEXHG/5qYlmNIib5STgOV3Qz9Th0DSWjuel5
	PeN2R54AloAZvo00yBrn43IwmBW/1VY9A9Ld3ziGMoeLuTodyKksg0Qe27J+CZsXiv6GRHxLzd3
	igvWbltrjfZqC+fzEfX2uaCGqkBpxOBRsn0JTeHUz+Yufn2se/cUw9QwlE=
X-Google-Smtp-Source: AGHT+IEGiBKnjCtShkOggoGzo2ZF1oEbdV6d4yrpPr5N759VcuXFZHM+wVdwNBDeb1V2E/ylIgRB0A==
X-Received: by 2002:a05:6a00:1885:b0:725:eb85:f7f7 with SMTP id d2e1a72fcca58-7290c0dfe03mr1559884b3a.5.1734062404251;
        Thu, 12 Dec 2024 20:00:04 -0800 (PST)
Received: from localhost ([122.172.83.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725de3cb93dsm9438945b3a.169.2024.12.12.20.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:00:03 -0800 (PST)
Date: Fri, 13 Dec 2024 09:30:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v7 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <20241213040001.jaqeuxyuhcc73ihg@vireshk-i7>
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
 <20241206211145.2823-2-ansuelsmth@gmail.com>
 <CAPDyKFovtfR7BiXBfH-79Cyf1=rd-kmOoEnEdMArjGUxSks-Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFovtfR7BiXBfH-79Cyf1=rd-kmOoEnEdMArjGUxSks-Aw@mail.gmail.com>

On 12-12-24, 13:01, Ulf Hansson wrote:
> On Fri, 6 Dec 2024 at 22:16, Christian Marangi <ansuelsmth@gmail.com> wrote:
> Hmm, it looks like this needs to be moved and possibly split up.
> 
> The provider part (for the clock and power-domain) belongs in
> /drivers/pmdomain/*, along with the other power-domain providers.
> 
> Other than that, I was really expecting the cpufreq-dt to take care of the rest.
> 
> To me, the above code belongs in a power-domain provider driver. While
> the below should be taken care of in cpufreq-dt, except for the device
> registration of the cpufreq-dt device, I guess.
> 
> Viresh, what's your view on this?

Sure, no issues.. These are all cpufreq related, but don't necessarily belong in
the cpufreq directory.

-- 
viresh

