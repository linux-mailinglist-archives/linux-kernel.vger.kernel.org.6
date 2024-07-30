Return-Path: <linux-kernel+bounces-267800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28EF941598
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E11B285D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDADA1A38C7;
	Tue, 30 Jul 2024 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvnK4RBZ"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF91A2C34
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354107; cv=none; b=Tjz6BMnooQUKMq89Egmfi/QPI8MrPWe3LKKu6ADXVAJihLc6o2l7L5gyqxOx/usvf/HWXcPTR2wOTyo1skaP0pKK6EpF5kcxmNnkbw5UmvYTsV3RN8zB+Ln7M5NV8JywD+Hhf5KDkC89Qj3t3LozYtT32kGV3f0QFMKjffCozqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354107; c=relaxed/simple;
	bh=GaXmFaP1JnXhQ67zHiWX0ypEDL6hGeq8fLfXvuMowlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoSXHiNBrbcakeWH+XGaggHcHL2ifSXL5Qfs2UCsvYSNBcwUWR+zP58BLwXQn8HydT6qS2/dtUWicEDb/MhZNAvKef6wKt+nJMJ18pe86cvy0W2VZJ/4D+uPlkBE+EtJC+Vw/IJAYkNfe+jhWrsqX1H+SgHa2YGdg/LVVvwa/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QvnK4RBZ; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7095bfd6346so548152a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722354105; x=1722958905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YUMTdfIhOXXMeKiKn124AIvyqTdCoUvjm0+I3c3GMf0=;
        b=QvnK4RBZHaBTDa228eQsDqE0uEBoAc1x0q6tlKKN11Lp5xw+9wE3oR9V/AF8ybeZ+4
         svxyPRlJljIHUrr2ITh2CErHJvvn/cRpIytO05qEjf+t1mu+YRQuWSWP8E8TIpv+lL7u
         7n9wOzXbyhmTx30vQ9nKfF7Mzxmd3CBmu6SUah9TPQbC5dCiap+/p/e+Migdw0n9iOco
         pSPIX3ObbwKUFAqMFnOX5vvvU6nR+VKM3p4HAUJArfo6XZABEfjTiANetEvQhNUr+DSv
         jhktm6Emhac9NPUEClSDaEGkN8A0x/ifyAlpQ7juc18sg/rofqO1GyA4AqcB38kxgdOZ
         55Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354105; x=1722958905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUMTdfIhOXXMeKiKn124AIvyqTdCoUvjm0+I3c3GMf0=;
        b=nuqTG8dhqjIYwY62IdVsokSYXhc32Xq9vxq15Tpg6Sro2bxehL7hWxVkHIBuleqBOi
         OWkwYxscGJ7WDnUNwrRNB8n2DRzt8+gvWtS5A0Aj/IT6d54iJ8xDvsMBSniCJ+kq7dnG
         HbSOW8p7/4wKH7klB7D36G0bq4+xo7dVX8GZyuDCjhGBG9gTvv7Vho0Ux1MdnQ42BW+Z
         fNPtZRwCc/Kw2JpoPYX6AkHq54SOTjXG+GpjeOYC4m44qU3/1mvt1U7WCL7fwkKCijyV
         ED904yE59YyEsQdw7zH8M5+XYvTCm/Sl9DqCaxF91lLpBquhQktBcWkVFPTDzxpUcHJ5
         oPJA==
X-Forwarded-Encrypted: i=1; AJvYcCXAdXwNQuWc21HQK8JpcKw1FpjeuDnfpDb478m0G7dGWf6kBHOfLVSAbf/GEDkc4GEBvzLxTVu54MwrUi/L17c9JCwudJAQrAXmAgKy
X-Gm-Message-State: AOJu0Yy3+KR6GXjgZonbyQDgxqhwj53LcK1RT+OyQe2vE+A6sv+DJN3b
	8mYhd/frS4V9FpAvdIS8dollNiW2kPo2SUR5Sn+wTc4zX6Sl0ney/61/DXolV8A=
X-Google-Smtp-Source: AGHT+IGAi0AOjYfdQgi1I72Zi8FVSlopeOu/VyqLGs2Wm2TPoLc2w3QjuCw20toB+DZKbDsGP9JBDg==
X-Received: by 2002:a05:6830:358e:b0:708:b40a:fecc with SMTP id 46e09a7af769-70940c04016mr12287729a34.1.1722354104863;
        Tue, 30 Jul 2024 08:41:44 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7095ad4e7f7sm433525a34.2.2024.07.30.08.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:41:44 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:56:05 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Benjamin Somers <benjamin.somers@resel.fr>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
	helen.koike@collabora.com
Subject: Re: [PATCH] staging: rtl8723bs: Fix spacing issues
Message-ID: <50c89422-2ccd-4ed0-b2d9-8337f5e8778f@suswa.mountain>
References: <20240730070518.2850-1-benjamin.somers@resel.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730070518.2850-1-benjamin.somers@resel.fr>

On Tue, Jul 30, 2024 at 07:05:18AM +0000, Benjamin Somers wrote:
> This patch removes superfluous tabs at the beginning of the file and
> commented includes
> 

Please do this as two patches.  Patch 1 delete the commented includes.
Patch 2 delete the tabs.

regards,
dan carpenter


