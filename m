Return-Path: <linux-kernel+bounces-273160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5794650C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9205DB22D14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EBF7D07D;
	Fri,  2 Aug 2024 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gXFHRcZz"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B031561FFC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634131; cv=none; b=oT/m5D0TRb8HXX99JfE6dVcR6+w+8IxFV4LTEBA+s6iYRUOe7JnvayJootnFMixPGfCoYdbkRtJ6xugrhNTEgcflP40TxNvyS4NLRGXCvRkgZfk127+5c6JOhUQGLtDO+QfFa0mcV33SA7uAhcXzGeCzDG6bi7Au/9kaTg1p+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634131; c=relaxed/simple;
	bh=WN7jJ3nf7CHBz22oHbq/tKlKILDM9YNVW8MOqXjd1ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X+rhfqVzhHNO8Q3ula6wlW5LF2p47ZUcPtXRNtUH/dMAUIAl0zB+SfpjxAjAOj3DNtU4tWuHT6hpIkTce+/ULhHDfZaDfdnkp8B3ue+haJYVzIMDsOLqFVdifuwBFmNUruBT0mJPIbaWWrcXTM4/3PTqfzTYOhG9IEoNifjM8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gXFHRcZz; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb55418470so5858027a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722634129; x=1723238929; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMW8zWH3sgkyB3+T/7tBKxCaj1AwPJoaz/vVGiO/MT8=;
        b=gXFHRcZzMBNblyazZEE/XVyLIchoSIR64SK3cx9enSjvu/bayCJcAywYeHg9609f8S
         V/crvFFNjwsgmEWQbJRaB/kXk17Y93grbDhQjse04dVIf41/wFnu7jRDT9kXMV6CUcFZ
         aQWraOsF5k34k2vApw7WDE/dB0+7yQlqRhW6dKQtAmmxJ/cRqbc4MAR2d9GrmpVI9IZr
         CDhm3KgHKL8jOEVgL32AJunIl+wp7Ee0musKmnJnxOmGRwkncGQDM7nUkty5AnO49+Kv
         OKXf1zd0WNDPpkOMB1qtN9foiBYqhF2nxgoWj4rGjkWFMFnMOYSROwqaImMde+ELm4x9
         4/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634129; x=1723238929;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMW8zWH3sgkyB3+T/7tBKxCaj1AwPJoaz/vVGiO/MT8=;
        b=D384sqNDgmZcptAnnwAbdhiBeehJcM7ffGtuWCye6dZz3OZxOl+8sQmQdBy2vqThSn
         wqcLFpSQIZjsNGQFddAtOJOju8kXsnF29ktFEkD8KzLEbNFF69m/ihBIMiSDFeTpzjPo
         KUuRTEeRLcizedUDOXbiWawJd87N3yRWceGNORcG0zYlJ+AjF97pzZF+fAvjBn5nsmOY
         RGZ55KDJw9Q5lI9CJGiCA6iLBNBf6PEun0mR4XYNBH6EI8jMnTEyQlueBtPdi3iidt8P
         /TBPhz2Rfi/SzzblD2OaNF+teMnZdO+47dQQrxISSkXik+9XM5+1gTAAcE1BosU4rZy2
         330Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGhLzoYXwUy8GstaUin8CcbzfYAKHsa/cvche6sp7SrvtwP2Ri+5ACXrN7zDYLZy5PpilHpaNRDYJt8Noj/ZPxBhuhzhx2RvvxEh4s
X-Gm-Message-State: AOJu0YxBWs+qP7xvIpm510aqv/McXw2Lh/sq6UMSdM+NbLAOBxyWUlTK
	cFfa0VRvkbtUKoZMCRT+lSzmO4PpJPl1B4rYX3veqPlCtJSg8uaishkT/JV5q/Q=
X-Google-Smtp-Source: AGHT+IFVEH4+a524h8vql+LKjqdYm+GmMyMR5wj7IULexiLyVyQlE7IyjMz+91toX+HxyX7vHxx13w==
X-Received: by 2002:a17:90b:83:b0:2c8:647:1600 with SMTP id 98e67ed59e1d1-2cff93c580fmr5743241a91.9.1722634128886;
        Fri, 02 Aug 2024 14:28:48 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf69a27sm2230143a91.5.2024.08.02.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:28:48 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Akashdeep Kaur <a-kaur@ti.com>, Markus Schneider-Pargmann
 <msp@baylibre.com>, Vibhore Vardhan <vibhore@ti.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: add CPU latency constraint management
In-Reply-To: <20240802210642.3366046-1-khilman@baylibre.com>
References: <20240802210642.3366046-1-khilman@baylibre.com>
Date: Fri, 02 Aug 2024 14:28:48 -0700
Message-ID: <7hed7662cv.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Hilman <khilman@baylibre.com> writes:

> During system-wide suspend, check if any of the CPUs have PM QoS
> resume latency constraints set.  If so, set TI SCI constraint.
>
> TI SCI has a single system-wide latency constraint, so use the max of
> any of the CPU latencies as the system-wide value.
>
> Note: DM firmware clears all constraints at resume time, so
> constraints need to be checked/updated/sent at each system suspend.
>
> Co-developed-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---

Oops, please ignore.  A last minute "cleanup" caused this not to
compile. Sorry for the noise.  :(


