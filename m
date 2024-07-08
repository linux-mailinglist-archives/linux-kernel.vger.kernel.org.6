Return-Path: <linux-kernel+bounces-244887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125F092AAE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442C31C2117E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FFC14EC41;
	Mon,  8 Jul 2024 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOU3SJ6m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18820DE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472842; cv=none; b=CRRVgbANtVjMh6EHCZSIPKSnRuzriPOJCcl3t5vGjosmu2sDueSbd2zeOpDsry6Ik/J1UBbpxZY0LlueSwlc5qGIou4ORwnyu6Ccv3Gs3eiIpZIQ6GsKKQ/oBjt172cLRRWaziw890001eyKm1g+eWkOsI2hnCefWvfRejS+qpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472842; c=relaxed/simple;
	bh=L8YH8jz9n1wZoySLoa92P8odJeZQ9rAEncrrj7IV4WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLMLqv7oOQU3wLkv0MguZnFgk3MSPjF08NLpW646+dMuidWwsM93b5/OsR1CQCiX5ElnbG7V3kY4omtGWsywYyCEUd/WxB3pmJUNZH4qL+qNKdcB5C6YoXWbCLmha3SNJyJH9BK6k3YYWTgDlX+wKY5nbRF5Dn1cucbfY5LG+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOU3SJ6m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720472839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cFqRthfbsSdjt+c678nPva0J5xGverzYDIQbIkQstA8=;
	b=dOU3SJ6m3ZXhp9o7Gn/vjLFdVtcaZoCa0o41kGNR4mPveuNlBedhJXs0fQEQBwNcbg9QBD
	HtcyWgYDrQGCW0/BVbbsT5VMr5xma9JFXSZkIDhLZKla8Bb8Q17jTkQLwQWdkFxLEWSvMY
	L633xwj9C+m5WJlqs5vlolz1tIc9beY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-o2oHz7LwMFmd4Ak2Yt8VLw-1; Mon, 08 Jul 2024 17:07:17 -0400
X-MC-Unique: o2oHz7LwMFmd4Ak2Yt8VLw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-426620721c2so17687455e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472837; x=1721077637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFqRthfbsSdjt+c678nPva0J5xGverzYDIQbIkQstA8=;
        b=sHjKz41TVbhLiblOaqBrfEdyo5aCyh+7a/NvEIMBeflSZ/cfav9saI2Q2PMXpaYC/H
         +ELH1FHhTAuRAtlt/Am4Q9mzFaxzMMDI6lsTAzGe09RfyP5oFS7hSKhRcg0zjQDwaGBd
         xnB7VTqvb6dytaU5jbaJyS9aQj4uNG9O9Hlc7R3Mf2DWiiPNeUY5TuyD1CsSoH8garTL
         cWUbITAej55+bYz6aLbSUKsxQVvgrWX1VlJlcZIcMVdbwE0xf0bVYOPniDL0IuF6h0Q0
         GUX+HxlEH1LI6pz3qZjxx1PFgI3Fv906/h4dYMARS6ryUyzcfy1TG93Ygv4ncrfF95GI
         Kaug==
X-Forwarded-Encrypted: i=1; AJvYcCVIBVmcPSGjK/GrI8HvsehvtCCT6bI3Bv0/m6zbH7dM7PedZi7CEKoulAntC9A6pQLn1YUGLtoOQOpGwl0HDR1edjU0G2J0XznE7MC6
X-Gm-Message-State: AOJu0Yx57euiQGEfBVXwai8rCSPXFf2yuPlqNugxxivzOI4Fh0qaYx5z
	Kiulvs7QmS1RgFIU7fuLGfdY/wBctipMifk8RQFa5/lkEEzhx54jrV8h/RT9Ill+Eur/uUl6CSy
	CDxN1NoiZQSl671HBoufKp15hY74fJ9HWRI32vxBEP4zuoYreG3VBm3SF0rnDAA==
X-Received: by 2002:a05:600c:4a98:b0:426:5269:1a50 with SMTP id 5b1f17b1804b1-426707da1a6mr4450345e9.11.1720472836872;
        Mon, 08 Jul 2024 14:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWOtEfljcKGLvuBNvpw3i/hd/jPNNrk3kagEm0uLHE35JpntWw5a/hT+IC3JuzZw+mS7Am4g==
X-Received: by 2002:a05:600c:4a98:b0:426:5269:1a50 with SMTP id 5b1f17b1804b1-426707da1a6mr4450275e9.11.1720472836490;
        Mon, 08 Jul 2024 14:07:16 -0700 (PDT)
Received: from cassiopeiae ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f76c2sm11492425e9.28.2024.07.08.14.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:07:16 -0700 (PDT)
Date: Mon, 8 Jul 2024 23:07:14 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org,
	chrisi.schrefl@gmail.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH v2 2/2] firmware_loader: fix soundness issue in
 `request_internal`
Message-ID: <ZoxVAiNPqdGChvH8@cassiopeiae>
References: <20240708200724.3203-1-dakr@redhat.com>
 <20240708200724.3203-2-dakr@redhat.com>
 <ZoxOHxHze2ynJS-q@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoxOHxHze2ynJS-q@bombadil.infradead.org>

On Mon, Jul 08, 2024 at 01:37:51PM -0700, Luis Chamberlain wrote:
> On Mon, Jul 08, 2024 at 10:07:21PM +0200, Danilo Krummrich wrote:
> > `request_internal` must be called with one of the following function
> > pointers: request_firmware(), firmware_request_nowarn(),
> > firmware_request_platform() or request_firmware_direct().
> > 
> > The previous `FwFunc` alias did not guarantee this, which is unsound.
> > 
> > In order to fix this up, implement `FwFunc` as new type with a
> > corresponding type invariant.
> > 
> > Reported-by: Gary Guo <gary@garyguo.net>
> > Closes: https://lore.kernel.org/lkml/20240620143611.7995e0bb@eugeo/
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> 
> While you're at it, can you go ahead and extend out selftest coverage

I think that'd be good and I thought about it. However, I think it makes more
sense once we got a few more abstractions in place, such that we can come up
with a Rust test module analogue to lib/test_firmware.c. What do you think?

> for the firmware_loader so we can test Rust too? Could these issues
> have been caught with a selftest? If not why not?

This patch isn't actually fixing a real bug. Which is also why I didn't put a
"Fixes" tag.

It's more that without the `FwFunc` type indirection and the corresponding
invariant the safety of `request_internal` isn't guranteed formally.

- Danilo

> 
>   Luis
> 


