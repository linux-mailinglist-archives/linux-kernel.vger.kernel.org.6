Return-Path: <linux-kernel+bounces-294721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C04B95919B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4981F2239C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2365C1C01;
	Wed, 21 Aug 2024 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e1NYuWdh"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DAA81E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198961; cv=none; b=SGapXMib/uY8yEgs5wsDL/RjnE/iq7iyAQzcI8I/oVxkGwV+rAqdsBkp0rYDXRXb4mPI6NCsHOTYnZ7UncybX1YDFBRiwDk53+WM8HJ1iQwfejHw3s7xh8ayCr//C8Ryp3/zRCbkMWCCqBPq1bOEX41Daz2dJjaGPysx7V+hfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198961; c=relaxed/simple;
	bh=ULK09Y6pw1Vt0XCwkz5zUt5J6laTryExCqBDkb0Noeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ5uV1JQlOYdBprR+h2kl3oQuI+/HzOyuxhfQC47WODlA8ZWVxfnTnMyUNgrIRUX9DomYR0nYCwlfFlQ6tgkwdYU/2ZBo2UzV1EHFpvR8cYx+yd6m/GGMOICAeq1LTXCeyCcyTgTiJ+8LdEIr4CDrzudiV5+c5J4xOXvf4wMKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e1NYuWdh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20202df1c2fso1540345ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724198959; x=1724803759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gISpsEQLYXnx0kpDFKV4wChjYDdWYDZzEmJhmXv/Fkw=;
        b=e1NYuWdhqf3hxtmRbVkrlIph8iTcKrk7IHNoFeZoswajIw6NOefHkN5ETg/zNMbz72
         Tr5G9F2e4gc8RHB6Yl4KrmGeLHdnN4mlf4UKkqbhnaa58VMubDUH3KE7B5qmNSKtaYMJ
         AZsKex4BkPT6amsXFpPClNM4biH7bT0WIk+OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724198959; x=1724803759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gISpsEQLYXnx0kpDFKV4wChjYDdWYDZzEmJhmXv/Fkw=;
        b=Pi8sJH4VvyiVvIl/2VOJgsp9Ae39qv8M6GJEk0VHgek8jBlvt3MSeXVAY/2fbyJKwA
         fYQHRaJnhn77s5UnKBTUL6StT49+a2ozJc/nYehK3jFTOQDjYMyZJgN7AYpDelES0UxY
         PW2AYFPSVPUrbMIKWcuIPaXX2MGILJP4HkTQrulcWrwz0coyP6pxQC4izLu1309LNO8Y
         g6h/lV2vSKDT7FMzQjwOY053G1U3nsp0P2XolIoVXl2Of9mSg6DBe5iqR9C9ZWVN1YtY
         4bwzlRzkAxm+FQ7O7rLjE7gCBqwbHJGo4HA6kqlcLP5aOXyAg2jXsbAvY9dDzhknKZzW
         mCZA==
X-Forwarded-Encrypted: i=1; AJvYcCVr5wop9T9k/GZJy8jG+9p6EvES79d/uvS247zPpYBCM7VyqJPx/eOBPAwxayoJoFbjE9tBYwsvSQtkAgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlRH4J+gKza+1I747FnPLikcklvgOgWe07so6XUjoiq62BHHc
	wl1ymyig3BRv/2dXFuQIgcsExdUBDdUMykVkhXmVLZeY5tEfv9Z5aE3egz/VPGhpDdf+X56QudL
	6SQ==
X-Google-Smtp-Source: AGHT+IHcaZLJ1LBnhpR9AaOqzSBnEjxH5aDE/bKg8uDeKvcjOkTREtlsCXfpACG8ETOx/aNd18QOxw==
X-Received: by 2002:a17:902:e746:b0:1fd:8b77:998e with SMTP id d9443c01a7336-20368073122mr9301615ad.29.1724198959146;
        Tue, 20 Aug 2024 17:09:19 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:a823:f22:fc71:fce1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031953esm83594775ad.90.2024.08.20.17.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 17:09:18 -0700 (PDT)
Date: Wed, 21 Aug 2024 09:09:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Tejun Heo <tj@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: fix null-ptr-deref on __alloc_workqueue()
 error
Message-ID: <20240821000915.GH12106@google.com>
References: <20240815070339.346160-1-senozhatsky@chromium.org>
 <20240815070900.GB12106@google.com>
 <20240815072427.GC12106@google.com>
 <Zr4lN63t25Og5/0G@DUT025-TGLU.fm.intel.com>
 <Zr4rosIiK2a0sGhc@DUT025-TGLU.fm.intel.com>
 <20240816023831.GD12106@google.com>
 <Zr69QOysEfYXkMwb@DUT025-TGLU.fm.intel.com>
 <ZsO1-gCkeGuskOnT@slm.duckdns.org>
 <20240820235412.GF12106@google.com>
 <ZsUvAUnCjFp_jviq@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsUvAUnCjFp_jviq@slm.duckdns.org>

On (24/08/20 14:04), Tejun Heo wrote:
> On Wed, Aug 21, 2024 at 08:54:12AM +0900, Sergey Senozhatsky wrote:
> ...
> > Well, this will make the tree unbisectable (for a range of versions),
> > because the errors in question break the boot.
> 
> The span is three commits with one htmldoc fix commit inbetween. If anyone
> is unlucky enough to hit that, `git bisect skip` is going to do just fine.

Well, OK.  Can you also pick-up the null-ptr-deref fixup?

