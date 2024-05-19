Return-Path: <linux-kernel+bounces-183049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978AD8C93CD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 10:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EDD28176F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B118EA2;
	Sun, 19 May 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESZunMs+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1A18B09
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716105606; cv=none; b=dGWDNQLN1qEmbaU9xsxHqfbjG/f5ZmoRlVhS1A3vDdEnfsiMXEKp4usim29KiGr1KbszdMnCUOHyklGqDIu8kyW4FZNvEfAnrQGiB5gnZiB/lyTdyBm+lnCKhG4qjmH72U7D9q5tTnSONLiTdsLtpgN4Xg9qsrjmpxc/vCzW4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716105606; c=relaxed/simple;
	bh=m4rWVSXHJ6/Vt1/TsqI+krQspjxUNxM2H7KmtGzkn1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2nHTgjVmCYILz2SjQLKDbenLTL596jYrZQM/ACTHvBIslz0PIKVgh0Bxq6hg9apZYSeo9nNVYReAnBM7mOIFEz+8FA7qXy4TGAuCgECskd5L6NQKurmNh6cfAJTQntfUhjD0nchM9aO1aIiZTF6hO4NP2sGO79xVW9LLkWukzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ESZunMs+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52327368e59so3689866e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 01:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716105602; x=1716710402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ki1c9fDiZ1GCrj1ZoT6mLgSAUoMndehPLBXp5wK4ZPg=;
        b=ESZunMs+CDqwKXHYC/2cCFn3nkLjWwyo9R+Ybnzq+H6sa+9o/cf5T9+8uBkXnUjC24
         1ZQMboy9sxzx6dNjY2ZH6PXwAutwhwQVNDVn7aC3XO8/Fzai/EkSqB3xPAk1Nj2T6LRt
         Tg/uoA1fUzBZglv0y+xmaP/nkKmcA4c+k6A+NuzLg0/lh8dY5BkiOKpCjmA3z1Ci9kl2
         nqWRvnD+HWbVUyb/VdPnhMIVWxBPLwOZZfwEarESicdyOjXfRSLngWRo5b37fH2yYcTH
         FQm6uIB2E3Eef8LqH7GaEwdqZufa1H8FA6PaNpCPsqUKNFSL5QR/K1x18wqTDbc0URQ+
         0toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716105602; x=1716710402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki1c9fDiZ1GCrj1ZoT6mLgSAUoMndehPLBXp5wK4ZPg=;
        b=ibr+9K7OIb7X46Bbio+8YhbGERc7EbNAsAoFxWa4h1eFDT1QgQvnJWbiXXjltBAetr
         +PbmrMC/MBM32jPB6qcrlOuea0NASk8MWR9b1Ff/WapcMjXiiLvF7Q384j72CjEoIXzf
         vdMtnkF1a6cSD+woFjeH7b00YXzGmoj5j1HqIM7Fh3dhUFe/YunC4HF9rGn9mrUJwLBy
         qEbYhS/80zXLThaHeoSL8MpM5D4uZN0LvHr1fBviyal/tZ5piL536lRjEDJX92ixQv1p
         8c9V2mw0QyiSK6ON8jsCvXsIM+4RmDMcMRTBjxIXsTLxPbtDbWQH0fGx2O6n1ljjppoJ
         dWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnuNyLY8sNuEclV/OnY/JNW/bcUUZk/MxJ7WhjaOqEAHCabRqeFHAUPAPjpf8vsuZ66nl9li2xXnTpTtfE8leG02nc0fjwt/RoZFlI
X-Gm-Message-State: AOJu0YzeX52FCwCUFSnZLp90kA2NcFfKB7QCQwH3+CR9voEI8EHp2TWy
	szKYhC9dAq4oW0CRtMwD1XtrpyKM2sNWF/C11pNld9LzeiapbP5EZL2TBwxbeKg=
X-Google-Smtp-Source: AGHT+IF0LURVQ5dYBvsSGbruvFCB97XFgZLY94N0zD6E2Ytq59xIKVYQNiFn8mBYpdi+1fGK9bErCg==
X-Received: by 2002:a05:6512:3e1e:b0:523:2ed9:edf9 with SMTP id 2adb3069b0e04-5232ed9ef10mr14396484e87.63.1716105602221;
        Sun, 19 May 2024 01:00:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d7f38sm3839288e87.183.2024.05.19.01.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 01:00:01 -0700 (PDT)
Date: Sun, 19 May 2024 11:00:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, megi@xff.cz, badhri@google.com, rdbabiera@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: fix use-after-free case in
 tcpm_register_source_caps
Message-ID: <begphn3f6rdcwgmyewnk6chmws643zd2gcucphntjcrpwhxxmp@75v7gll7non6>
References: <20240514220134.2143181-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514220134.2143181-1-amitsd@google.com>

On Tue, May 14, 2024 at 03:01:31PM -0700, Amit Sunil Dhamne wrote:
> There could be a potential use-after-free case in
> tcpm_register_source_caps(). This could happen when:
>  * new (say invalid) source caps are advertised
>  * the existing source caps are unregistered
>  * tcpm_register_source_caps() returns with an error as
>    usb_power_delivery_register_capabilities() fails
> 
> This causes port->partner_source_caps to hold on to the now freed source
> caps.
> 
> Reset port->partner_source_caps value to NULL after unregistering
> existing source caps.
> 
> Fixes: 230ecdf71a64 ("usb: typec: tcpm: unregister existing source caps before re-registration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

