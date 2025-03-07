Return-Path: <linux-kernel+bounces-550255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83DEA55D30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667A216B5C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38496154BFE;
	Fri,  7 Mar 2025 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="GCXGxNzx"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A1118027
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741311494; cv=none; b=rS47iPf2B+6w3Is/pkU0PMwafQqXkwTroHV2HqhrUHAok7uGwOjym6RmGO0VkUsc1MI42aYIJpTU+IPFj72ph7TmmWcGEx2k/zEL6hesuGbPk9ZIVjmzvdOJQv5MNx79CldDgIm2WSZig+W0AC+loKqFWVvdS9JSwHThyd5KgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741311494; c=relaxed/simple;
	bh=94x6A3Zw3yyTFfdg3nqgD7OHEUHUN1gOM78nrJlzxXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxbjCQM71E9rVsPErfA1+ZQe7NHMj51GoDAt7sMJW4Y/Bj0qSRqydw+yLFiPi+zKHF1BFKp0grHwDs3zl/nZ9EQEL63/FlFg3dLKXxN2uX+f4VRRASVkmr+V3qOXUqT6dTPT1WsFYrFE7MUJyGR2oQRyDSH+JqWC2I8Sf0nDlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=GCXGxNzx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-474eca99f9bso17327291cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 17:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741311491; x=1741916291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hnkwGAXDjAZ/3Sv4OxDh6yiqEm9a+SObOYwqvIotnsc=;
        b=GCXGxNzx7ELcNrcy+hDbctxnabuLL77Ia/w2gYQjQDTBQ0FJoxsCBm6UGhc3AR+FKX
         azfrABLGqhf4vzRfHsxt7ZO6decQknD0fYCTJLslEX0yME/6pGEFkbuiKJIytUHFwBof
         aIbyA/OxOqqvIZ+S4pXJ0X7Hv2Xzs26Jb078vNV1noIY5YTGCE2dK9SMnlw3ODyf7+b5
         4cCaBXZC0Qi3JIBqPIWk29/hHldNrdx8ZGQyoefiey6dM66XhAX4kXxo91l5h5y03W3n
         vxRXIGt5fe11VGQahjggMCBERDz5Fyn4Slhxr6Wj7shGkGmUS91lfd/7zqunw+G0reTg
         +7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741311491; x=1741916291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnkwGAXDjAZ/3Sv4OxDh6yiqEm9a+SObOYwqvIotnsc=;
        b=PI2ybGcq3NmWGwoh0LuLbeqfswwKv8KlAvmsekZyM06Cmq7J6/81uZPuiP/dSEikKv
         3nKdr0z2L+x4BAGNKHEYSVorr65kRRf8lFxNttMFQLhmHA5u+2mG44Z4Hq92nnR7a4bG
         qJgs7V21DOP2bmo1oMTuOUgtjaEFQyeU0iAbyIhbJzgIp+yqCSpU7WyOWbqsqqTMG21K
         TegvydwSnhVF8Fqzvi6gSQdAxe2RqyTjsQloH7bBiIE0IYcG3mqdzRkm8vVF/CTeARji
         fB9Agfw9RzdvhFn5v4LTpVKTi90C1Kny99Xx9FYBXqC0rRcSKvmvbQsgwDHtByMfTxBl
         GOdA==
X-Forwarded-Encrypted: i=1; AJvYcCWpJB2WfbSEiESU9tvf91LfE91pypJeEZcUsfxts6BZ11pmU+43rH5aThgh2K9koHBwsAS7bGvsbYUUw8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3J6EY01WSKYzdpvPMBHrYinf3ujWQ8/bW/0pyOdpIIlM+Tv1
	OaFa0IN2DCXk1yxAvdD9iSbuM3dGYdyGEUUErWH9718r40Z+E0RapiCfdv/JXXc=
X-Gm-Gg: ASbGncvyI7/skABJmFYG3SX0l9D6aANTMrPd+E31eweGd69W1Bntn55ZmISIWDwSxWy
	e8cdHaf8dcppff5jbWGCf2aNEXIRqqMlVSqJ8NQwdI2SVjMG/LxKpbOYmmy3YN6Ddx/ccyeOy3k
	/kZCZoIxtWmmQZ3VPiLq3VFWOb9ICWdgeJ6wGCfbJycQq1Dttdgo+6/S2/M//I/fr5p62XduoYD
	bpSfbfS2M2FIX0cdtiq4EABgj16DD8jxs2AblALWmXZbJPnuXZAWw9FFQRZjeLnH2uS73Q6NdaM
	wthI27b7e2JA31UAthvsebpFd1Bj6L8VrZRrNgyanTs=
X-Google-Smtp-Source: AGHT+IEtJlC54ZdJ22zSGj3d/VEVRbhunui5bPlFtWGfHB7hXm1qfRGaLDRqCGuEB7XXlk8lmGoUUg==
X-Received: by 2002:a05:622a:34a:b0:474:f1b5:519c with SMTP id d75a77b69052e-47611959438mr18239461cf.32.1741311491506;
        Thu, 06 Mar 2025 17:38:11 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4751db2f139sm13981901cf.51.2025.03.06.17.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:38:10 -0800 (PST)
Date: Thu, 6 Mar 2025 20:38:09 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, yosryahmed@google.com, yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page_io: return proper error codes for
 swap_read_folio_zeromap()
Message-ID: <20250307013809.GB423735@cmpxchg.org>
References: <20250306230015.1456794-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306230015.1456794-1-nphamcs@gmail.com>

On Thu, Mar 06, 2025 at 03:00:15PM -0800, Nhat Pham wrote:
> Similar to zswap_load(), also return proper error codes for
> swap_read_folio_zeromap():
> 
> * 0 on success. The folio is unlocked and marked up-to-date.
> * -ENOENT, if the folio is entirely not zeromapped.
> * -EINVAL (with the follio unlocked but not marked to date), if the
>   folio is partially zeromapped. This is not supported, and will SIGBUS
>   the faulting process.
> 
> This patch is purely a clean-up, and should not have any behavioral
> change. It is based on (and should be applied on top of) [1].
> 
> [1]: https://lore.kernel.org/linux-mm/20250306205011.784787-1-nphamcs@gmail.com/
> 
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Nice! With Yosry's two suggestions:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

