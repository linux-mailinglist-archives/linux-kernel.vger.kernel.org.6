Return-Path: <linux-kernel+bounces-394381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8220B9BAE3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48060282F8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6795718BB8F;
	Mon,  4 Nov 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TA95xGIB"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBC618B488
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709401; cv=none; b=a9phpfxzVrE3+LvOeyG5ny6t4c0KURIA0CP3JwasHGOG0NILRifdIfLegpaY/QRKeWKkXxgLMiw+FWzAsJV4QQC9at5zQALhah6bx2fAq3Owf/PtdiHYNc92k6/4dwecH9vb9CG05z+ZH3i16JvDtGLF+uGf+GpCtK1/vV591Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709401; c=relaxed/simple;
	bh=9ER8Gkglev7unCJFU15f9FqH14o/KXHMMbhVZ0IW0j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMy0i6V6G5+rnWY26oRoEcokt8jNjNZmjGqDHtocT27pzIzbr9YasE+lR6PNjQUJT5TJHv60DO+UlBgaOlpW7+sscljHSJ9Xul+1mBf27NUt7zB57DxsqA6Rb1lkg7aEuekgRNVAY6UOpiJvADLcswNpRUSogxh+weWPjBC/qL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TA95xGIB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so32042975e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 00:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730709398; x=1731314198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQNba7SJ5waZLtab98P0tal4zlnqC4t8NTIv2ugdpto=;
        b=TA95xGIBrcyPrv0Qs1ZtChYjW+kRzKYmrabVCOAi/YAEoRH97zA64kPrAvFIXdt0cc
         U/msnGB0L7e1p2jk7Ip6WlU6YyBR0L0PFBNNRS3N+TZ+NWP+MTvJRkyhE4cdPyT0BlPk
         tKrVFwJVEzHqc7BkGzkJWkyEzalYG+D61jtPgzcUpGgdlm7sF5Ek4uvAda2ocjiyp6us
         C3D+jOM/YDEr3rU3BYvEvDbFNgaCJpN3u8yM5LBn5oJSkD5AJeK3kH0mRh4AGeFGkuCO
         vZ6/495dajrZDmOY/DusqXl6arN2CdlriECiu4BxMgBqOzW/wsTuNVZ8JEnuI84VDJKI
         agNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730709398; x=1731314198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQNba7SJ5waZLtab98P0tal4zlnqC4t8NTIv2ugdpto=;
        b=nAh9d42x7g+5ZEAe87BaxdFRk5i+EFLwDBpm3juBbv1VMxM2Wj/2kyQ+ATSQnXU5AO
         O9x+l+YBAspm9czZUxSTNa7rodlMz7rWchgcFG6G/VZd040V2qnAgSdUoNtJC6uB7o/V
         5R1yYviLnNBvIFXqR9/+AGwzHXN4hD/OkWsAd+xaeEqZJn9QYcGA5MtjgHXv2/bNdVRS
         +yM4jSsbQj2YMzm7w6R4BuSAAiq/h4LLUoJOdQsn6YDCi4pTEB+xp+XJjofYfL97QFcm
         oio8niCai7iEwaEFfEMd0x82hfgi7KEzrECPSlBxr4j+5m4F9zQTPLWDCNhQH09vJHCf
         m84w==
X-Forwarded-Encrypted: i=1; AJvYcCXUvseFBKNDrrOSYdM47z9HGEGGkkc8r7zLIlPEW/5P6EpYusTaJ2wkrwXSaV9JFx+wHxdUKQVrkJMHUEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLCZlO9cZvYJ8+yGXfmNA46GSPGRgO38w+Cqxjmh/Ix2HLJ8Up
	TGEWh62lCJLAePsk7jEVb/5AL8PQM5kzLg9wt1FaK81dGwVjpM6pZ7hTUtYYjl8=
X-Google-Smtp-Source: AGHT+IGPyUj8y1xAfEDv4tHM9DTcI25WjBafMXnE7fuz26sXWASQTccZDR0aePOo2zm1sQefiJS5Gg==
X-Received: by 2002:a05:600c:35cb:b0:42c:bc22:e074 with SMTP id 5b1f17b1804b1-4319ad343fbmr291216725e9.29.1730709398454;
        Mon, 04 Nov 2024 00:36:38 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5abfefsm146381595e9.4.2024.11.04.00.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:36:38 -0800 (PST)
Date: Mon, 4 Nov 2024 11:36:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 10/11] staging: gpib: Re-order the lookup tables
Message-ID: <439184c5-103c-4ae7-8232-d771012b9f07@stanley.mountain>
References: <20241103212617.13076-1-dpenkler@gmail.com>
 <20241103212617.13076-11-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103212617.13076-11-dpenkler@gmail.com>

On Sun, Nov 03, 2024 at 10:26:16PM +0100, Dave Penkler wrote:
> Re-order the tables so that the bcm27xx table is used first
> as these devices are more popular and numerous than the older ones.
> 

What is the effect of this in terms of the user experience?  The commit message
should be clearer about this.

regards,
dan carpenter


