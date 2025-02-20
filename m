Return-Path: <linux-kernel+bounces-524751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD0EA3E6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD7119C535B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FFB264620;
	Thu, 20 Feb 2025 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WL38YEcX"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25D26461F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087043; cv=none; b=LLqlo0Dv7+xlxrx6x2TJKc7cRK1QGHsplsVFBn4ocHjd/lcPsLtOL1257sXmhzcvJUyFehcMa6mVnreKXIL11IQMuA+iRe/Lodi+rdmvgGoyCKwXz7m+iN6YNiUzIts4MFrU59VZ8pB00M9wipbYOOAnYPlDVc/f0EPVXS24MHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087043; c=relaxed/simple;
	bh=4IlTTn57fzjGT5neuC60L+1dIx72n+UtfQr5bV/D27w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByeO4nHwAZMZhrPcZxWpOoMpMyecEThquG5h/kbvrhbNz2+9WUu7rc55tYApAzjLCvarWVXdvMwAI29aCqURYQIDSjGGeS2kQFRhBA0OFmi1QTFryGasfx3+vU9z02C+esKlc3QYidDtwJAByT9rWHAVKMbtgAK/sZP62uactrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WL38YEcX; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fc0c06e1deso650199eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740087041; x=1740691841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFd/eiSziPMZWtzl8X1O2OHBJVjEs/2F5XFS5d1bJIM=;
        b=WL38YEcXKPC5A0lyLdMO7ESMN3vYT7V6skgjG2buZyS3+afeDPTUZht0CCtUF1YJOk
         Oicd1U730PU7/dz7EA/HsDsY8nJGhqC0Tisr08+LNMhN3ijhaHe8A0vRudxfLW18SA2A
         +Zr5LvEhyrVhT+AHZHYphBUq+VtTqNIymabTUHMmEjQuWT83mmF7P2J1UHXez1nFb74k
         ZQnWV3bRZDXRKbBBjv5jQkkN3hcTyp/xH/sjVh+SAytNMSONraBoP1r7uwSlQafQTpZ4
         caTqmQa/GdrZRZewMS0M2xcjm60HgBhcpKJ+1fwsU88+02wN1Yi4fW1poviJqUDYPPs3
         8CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087041; x=1740691841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFd/eiSziPMZWtzl8X1O2OHBJVjEs/2F5XFS5d1bJIM=;
        b=Jjg33KaxPU+5ZzdTawwKo7qRBbQDDgwctGEDfUm3C83nGAfJ4mS6+UF7qXScY1EhSr
         mOkOn0eiiYmCZB+hp16KgiKIi0IgcLvg7cKGnxO1thZWkszpAEc/sl2/hMdNWxZEhju8
         n31h0ibjsLaFL07WVIZ8QYkHnxEdWvp7Dw8mWLVAvh+7H30UbBcjnxU5TOUDXqwUTnnM
         H0JaicAr+AL50EHbYOF62lvyZe+Nyv4BSNGclmhk/v8LFOVphR9fIIYvj3rgTsCdT4s6
         Sak8LLV2WqyL5G7xtTBeTzT/k47qxRIiqMGDRkBzWSPJHovcMYcdXzPtK9Q45GjOMuZx
         KnlA==
X-Forwarded-Encrypted: i=1; AJvYcCV4dgCY/FXxVgbXb3E32x66VxTVrXR+X3yCGEG9zFTmsGbEeMeeuxD3o5rvqtBU5f2BbmSteePwPe1m/3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR1+89qc4a/LXMWxjirw11Gkm1Y1g/Bbjfic+EcJO4PfmAhFLf
	9CqK2HBeX3MecsCLPcyTY0vfa713w+6JwZAmCq4ZR9ZFFqfbynf9eX2G+jRiZQA=
X-Gm-Gg: ASbGncvCTQM3Tri++h29vNT1L4VWHZStgpEjfgWSsRlS3YxfTCg3bBCdzwgIpLVJdVR
	LchNJbLbmqUdqnCHWeDoLWkW6HUJFpTBXKBOk/Dkzh3OK+AyTKh9gPC/2Oa19ibnHw3BsPJdjin
	mkztWdVYqyBQ82s2O8GvodMpqY1AuGs2b8JaaUKwUQoiBBYHo4WR7mYFx+Nvc7Z/JMRODOxZK+J
	bt2Yk/9QSY6gCbdTCR6jPVGrqPErRQdw0/oLd+/+kg7k6uMIRsJ+smyFdxWQ4aGB2UMy4LN+56U
	HGLwkaPe23yZS2eqWMCgdJVBXGmlZbui1rHYFWMefOczXV1PtqBE
X-Google-Smtp-Source: AGHT+IFqWxbZFRA1rz6PvPU2XODqbR9hz70tJhTG/+Dqectftq8EDR8raj5yvtCTiONyxW3BNF1Olg==
X-Received: by 2002:a05:6820:1612:b0:5fd:50d:49e4 with SMTP id 006d021491bc7-5fd19648f16mr652519eaf.7.1740087040824;
        Thu, 20 Feb 2025 13:30:40 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fced377d94sm1875193eaf.32.2025.02.20.13.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:30:39 -0800 (PST)
Message-ID: <63e98010-860c-4d66-9cac-4f37d5e08f5c@baylibre.com>
Date: Thu, 20 Feb 2025 15:30:37 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 07/17] iio: adc: ad7768-1: remove unnecessary
 locking
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <f866c5e181e9e77f4179c44a857cebd60dce32d2.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f866c5e181e9e77f4179c44a857cebd60dce32d2.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:17 PM, Jonathan Santos wrote:
> The current locking is only preventing a triggered buffer Transfer and a
> debugfs register access from happening at the same time. If a register
> access happens during a buffered read, the action is doomed to fail anyway,
> since we need to write a magic value to exit continuous read mode.
> 
> Remove locking from the trigger handler and use
> iio_device_claim_direct_mode() instead in the register access function.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


