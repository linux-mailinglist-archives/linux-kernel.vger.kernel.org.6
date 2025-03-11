Return-Path: <linux-kernel+bounces-555952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116ABA5BEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DE03B20AC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7862512C9;
	Tue, 11 Mar 2025 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeWxFT7e"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57F2222D0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691808; cv=none; b=D9OP01RBPdtLtnStWsm3PbrgHF3QaliWwitS0XtDaLjoGaVVztrTqv5sbNoaE7zeRDGviTtO3W3TcLMJbzpCheC0Be8wZt3lvuS9/vuvVjugAFkC81JbGLAd0rIkgXjgW6f7ZHo4Rv/f74hBgTdtWisjF5heT/XfDRyO7xTS3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691808; c=relaxed/simple;
	bh=mpmz9+gNfBkSRlzf5ohqnrqIElII8nIlcNv4e65+ehc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6nuvjaW/F4HCvQJsUCaJmem1+fU7B8iGc1x12oxorwggelDHBL63lSPZpxpVt/UCZIpoiGy344cBipt9gq6RUX+6D/7HwcXNH9EupfaPGfi5txfqATwNTfybPZkW1nSWWJkjRvllUoicXmazbO7zBfe+8NG9crPq5nyBO+P2hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YeWxFT7e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso16458285e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741691804; x=1742296604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Ee2vMUDZRdjGNIbzmhry++VVeENs1uRLq+FlAoQjWA=;
        b=YeWxFT7ej3p6ZoEtJ9U+m6+qqoV7gGpASnll1yNPnh8olotSNcNoYkG/9ynS2tybyY
         nq7xx1OV4IG+GdRtq9GbApAfUUj1UuX5LaiZrK526enLwIIU8Lud8zwkzxxtg2bxbMAR
         NHebUBel6rwsrh0DbL51vtVjVrBKn517MW2amrAqRLmg+QRBUatjRYSPtx53RQv4MRaK
         gsuRCuF8AgI4wSqzNvJtk5z9LwsCodIQgrHMdXMWjgNziSUYgeA1+tQVnrMIr2ATcpNl
         I0eS5F4HMFQmTQh0PEa4V4LrT1zGa4bmNBBBu2YcYoAW5gndByJo7R3bazV9tTy3219K
         OSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741691804; x=1742296604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ee2vMUDZRdjGNIbzmhry++VVeENs1uRLq+FlAoQjWA=;
        b=c8PcyaaXRDRLcDnvmh6H/IPHRoiK9ASN8c5ZYHpkHSgnIof47SU39GhDqpcetFqDwg
         fqHMDuH1t7No+QkpJl7nJNV8UloBtL0+qIL9TBWC9JNDo7SIdm76Gd/g+QGlQt1gsnLz
         TGQV4usiJOtSjxqT4+oE+XBV3VWOa/8My52+hQBdK4RUF7QGJXZiJxLccyJOSvdCncXw
         N/lh4fq0PF5qCYXKb7TMVYjJ95AkzsfYyy5MLHRPtj0YDriU8fD8SISnAKskosfikQSy
         BX7EGZFt+/9NP8ErHBnaw+yTVtk58m2G8RKpxhcM4oi6YTJ3ViVpuYyaOhzm4079Ge3p
         hcug==
X-Forwarded-Encrypted: i=1; AJvYcCWwAG7BPshZlJuxNSwNbL0EwOD7ihMIE+5oc769nCJ5odAqHBOVmnIxhZDD11f4Ib3TVMevDLIcQPoBPzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvkjMrnTg1t6jND4TyT9GUlfRQoQeMcCV8HjCDPLyzcoloesR
	j1Ep/W5cU+QZFCy8Zx275g3oolxJfqhDbofMwj2muY96HNypnxBBMWtzsy0xKcA=
X-Gm-Gg: ASbGncu9tRmtrjWFbeW+ZsR6agFhLNVp/oR1N3u6efK7W8LnF0+AomtoGiBmtGu7aFs
	shLpnZvR02XFL6GN4+q4F5At9obpRnGwXdiAA1BJfpuEFFO9ZaOt/1JmMZ3ZXrhWJq5lsLreN42
	86p+ywUBAc/47dy1HFIkYsF6Z13PyTu2dIB3AaeSRC+NnaZehNVoAw4zDyFzRfewDQ2uiJSOn0e
	LnY9lCUY1gn3CuR+Iej3x4G22hWmkogEaCVl4Xil5nDPAqtjHKh4mCD6PPel6b/wpckIfpr8W9H
	WINMq0Oc4nQX5uL76vs2ufv2AJJXAs/I9BbXJM1Rw4z6LyiriQ==
X-Google-Smtp-Source: AGHT+IH62B2vN00mbQ7cGtF3KOTyZWYGf3hAB5PaS1iAsRYUThgYmKN7VFoKRyfU1FM6J06fivQQQQ==
X-Received: by 2002:a5d:64cb:0:b0:391:3fa7:bf66 with SMTP id ffacd0b85a97d-3913fa7c415mr10740994f8f.31.1741691804523;
        Tue, 11 Mar 2025 04:16:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43cf0c42eb6sm87876805e9.16.2025.03.11.04.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:16:44 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:16:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vchiq_arm: Don't use %pK through printk
Message-ID: <01a1fcd4-b626-44a2-b850-bf0d8b9efbfa@stanley.mountain>
References: <20250311-restricted-pointers-vchiq_arm-v2-1-a14e1c0681fc@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311-restricted-pointers-vchiq_arm-v2-1-a14e1c0681fc@linutronix.de>

On Tue, Mar 11, 2025 at 10:40:49AM +0100, Thomas Weiﬂschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping looks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> There are still a few users of %pK left, but these use it through seq_file,
> for which its usage is safe.
> 
> Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v2:
> - Fix wrong replacement with invalid %K (Dan Carpenter)
> - Link to v1: https://lore.kernel.org/r/20250310-restricted-pointers-vchiq_arm-v1-1-dd04f208ee55@linutronix.de
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


