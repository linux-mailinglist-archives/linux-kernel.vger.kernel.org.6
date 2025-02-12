Return-Path: <linux-kernel+bounces-510652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 538ECA32005
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07ECE1618C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F194A1DACB1;
	Wed, 12 Feb 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXAWa6We"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7F1FF1C8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739345601; cv=none; b=aNDv3oEG+Y92aNv8lBmDmjiexMsMInZGGzwm4G7sRnjn3K3YVWQ8OQhhdDm/n9XD52BP9aTl4OntANP6pC5+I41XsPr8EukkHGUZlwfoaCfRYz9bSzEIN2efJlV7oeIzX6MbNohYUm625PefLWZo2t8i/n5V5uICwEI2zWwIvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739345601; c=relaxed/simple;
	bh=hYJSw/8vcXikwAiQGAZCaAebtEtzVdMa9zLS/tqsQfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNO6xq2bl2Mub4Y7/ZUgLpVh02GCGqAjjT17Rc2c6NZkF9aSmJB6i/Ajv9NLEDkfpXLNUeAtOzno8z9ytDqvGZTYVd890Ei46eQJCyyNSPfMA55C02K8PJTDr1qhQCUdOPSMENMmnahjjLHE2PDKo2uXxFkpgXqz7WSYUMljs2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXAWa6We; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5deae16ab51so881063a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739345597; x=1739950397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRzoLQjUR383Rec3XjmkK4huVUopwWO1GBDIhR8udRI=;
        b=QXAWa6WemliXrUizHp6nxKvvlG2yg6kzem78UvjtzxmwwrgiozK2kA5oYDLDbFZvF9
         QXmtLyns0Z9cEDOuMwS/v2HtquZz3oD64KC2h4rdH/5qcPFyuuwGq/aheP4IgjcGgemV
         iYqgHlH8eIdfFmS1r+BNt7Oq2/NHjLgVOFDV3rwkzoWTfstf390fr8mXowIoRtg4XTW4
         bwR8SafpH2xAEQrzS4gSD3LPlrroQtCYVEnbpQyviXgJIXQMNvZLCPSe5Jvq8ltMefOQ
         byzDs51DpeaXvTFBus7gOPxCvwuVcpyQ954drYeSjWLKND2AbuE6dQ3CbymC7awSXfwN
         lozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739345597; x=1739950397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRzoLQjUR383Rec3XjmkK4huVUopwWO1GBDIhR8udRI=;
        b=rCmqfhn/jvRC1IMenKdwXXUM8kb2u/CyXyS3wLI94l2W4GApgAxSkn5J6vJke7UBVi
         8c9x4mfuzA+l85yjEU49jPnkogxi4GE4HP5k4OXmC99+G9SoZd3dd4UdgRxLIjk8/uv9
         h5KFBtuWpNffW0p2kCy0bZcQTW4m24QI2HI0wpkaDPNav8n10lmjlrxJ6VTiCxwv4HrU
         sinUMXwWgN4FGVuvlLznStpGDZRmUQzQog94kqq/Lo+rEYZrsq5ILWBT6VFeuba5qT14
         yloh9FTAxCh31aOEHp7CO2/GEvLknsxBF//hIFocWcwFgmJ+2nnVsCqasKOwcb3YOBGV
         0I6A==
X-Forwarded-Encrypted: i=1; AJvYcCWiDvpoXNGShQVLr7g/H3IgGw0aoZLNwcOKeOZxV8j0NGaZWnfkt9vMgbHa4a31Tue9ecN/oCVkP5dn3sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMRwP9XNb/MV1jl42+G55g2hXpKXxk/zq4K+mLufnaICG3gFsc
	MlCLqOOSzu8UUlgl1FD+ICGlm/lCuxldeI6VsBZyQJ6LB769f6CydTiN5aQopaM=
X-Gm-Gg: ASbGncv9KK/04tGeN/TU2/LFWQEeZTK3BaKi49W+Qw5YctsT/ZQkgxZBUvNA2PMX95g
	aTQVs6i8aAIvBce1D05qmN5nElAHMawVM4X9G9a1/1Q2SUaKTauORrG1Okp+rk54xtfBwyVg+gY
	QsytwY/4jji7eLVfbwZvHWW0RJ4Ccgcdj9lLFU22d6Rm3ppEt7k/IKycSPiEPakmj7fNl7aUPM4
	nAg7WHicUmHaFcGM6Wi9jS24wnmMRz7khNoJQFbNBb/1utG+NwteXAaWNAZuDXpOf7ChHIYZIE3
	uQHNsWLJVZS6al7U7FWt
X-Google-Smtp-Source: AGHT+IHEkyu5VJUntgvHMtsslwDLby1dwnGZEm2O9JyjbaJVp2KAlFWei0TrRWLwCNwYOoR6u4aUbQ==
X-Received: by 2002:a05:6402:5250:b0:5dc:74fd:abf1 with SMTP id 4fb4d7f45d1cf-5deadd9cd42mr5209426a12.15.1739345596558;
        Tue, 11 Feb 2025 23:33:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7b30aeb7bsm696331266b.131.2025.02.11.23.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:33:16 -0800 (PST)
Date: Wed, 12 Feb 2025 10:33:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dima Volkovsk <s0ldw3ll@gmail.com>
Cc: marvin24@gmx.de, gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: nvec: Fix pm_power_off reset condition in
 tegra_nvec_remove
Message-ID: <429e6aa2-b195-4624-a609-e1445dcbd150@stanley.mountain>
References: <20250209201752.66313-1-s0ldw3ll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209201752.66313-1-s0ldw3ll@gmail.com>

On Sun, Feb 09, 2025 at 09:16:48PM +0100, Dima Volkovsk wrote:
> In the current implementation of tegra_nvec_remove, the pm_power_off handler
> is set to NULL without checking if it is actually set to nvec_power_off. This
> change ensures that pm_power_off is only reset if it was previously set to
> nvec_power_off, preventing unintended side effects when removing the device.
> 
> Signed-off-by: Dima Volkovsk <s0ldw3ll@gmail.com>

What everyone else said and also you forgot to add a Fixes tag.

regards,
dan carpenter


