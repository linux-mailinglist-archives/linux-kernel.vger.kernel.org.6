Return-Path: <linux-kernel+bounces-518259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA60A38C64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713C217161F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5962376EA;
	Mon, 17 Feb 2025 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj83HgB2"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF6023716E;
	Mon, 17 Feb 2025 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820614; cv=none; b=YbwhipM4aEdH6lC2n4GLkMF4qiKDJ/L0MHTKmA0rOpqkZcJs5o15rqXUbA6n0eoniYIzR3pzqd61bMtfF251UiumwVafv2e6gYfoS5yulDPBpGIy3s1w0HUMFevf8JNx7FSw/es0WB/b2ICxCUFCtCOiGJAbNztWRI3SUC3+Hvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820614; c=relaxed/simple;
	bh=oWFGxE5dGctrEPb9coH4CCy8xZBZZ9CsQTMTjo0QChM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxogYylKoC9u/D4Wy0jbkc3usZ6qaEGMMgDQrNox5ZrvvTPNEdtPHmpex4d9OgNN42zuLl/OnXJOrkqjKd1XKfL2k7/mXckcKkniAqdbnBpHRC5yEBK5hqnCypmpDqbdW/q3ltTTBhTrH2yCF/Bub1bUooSdjJkaqYVLJ3/+m+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj83HgB2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43971025798so13054275e9.1;
        Mon, 17 Feb 2025 11:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739820611; x=1740425411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KBBGRVrDPOzL/cJXETAGl1eWZIx2QG5N8tUkdFnRiL0=;
        b=Zj83HgB2RpQaEi7eI4ZBEUXxRArhtBBT0sZHd+fJKBxnPddj73vOBnJJcjQYsi0wWk
         3UTUrIFoYpXuYA+1VMjt9O//FITQOeyd+nxJt3RVi58+RIBo0V/zXVN6hV1dOenYOvdR
         b1lYUW/zqPJ4wD/y7VroHbmTi5s30xLCcVXLY7jxpa3IYIxSIwvk2jOgz0WbknKolUzp
         r6qEhq4mkg6rxihoUz9bo7c1v8ltOOGJ008OzD90HALhaQRrc6sas8hCEkuQO1k9WGt7
         aSROP6mVCS8cpVVYMh64Nh7BDtcP6gxTDK1xy5UB1dE1TA0s+sNuyzV/ni+BxTXY/Uom
         atXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820611; x=1740425411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBBGRVrDPOzL/cJXETAGl1eWZIx2QG5N8tUkdFnRiL0=;
        b=gHt5FQRGubKn9KvkOhbgYlKIyteW8RdnBBzf7m1fCqmsUMqX2C1avrkZzhlNm3yeGC
         jnNpy0cvLODvvqses5giLEy8qoqRHb1oeyYq/xFrD9kRLYnSXcl5mibUS2P9AELxIQoq
         Eusg4idyYexFYo08tUpwH68CGTWKt2WFsEx/rXwP9ouZYrrm+jjuFYqPrihmyS/kBtvU
         HtMndRULMZT1DPM0sIsISc7eL0h420kV9f2yO18KtFop4F4I4bR45wfKEuHvi6m3SjVN
         kCgH/zlz5yAzVZQ2XzAF75TCTloOrPvnS9y3p3YIJ+4jF0h5696r61OCxU/VPet+eMch
         Wwsg==
X-Forwarded-Encrypted: i=1; AJvYcCUPCWMY2ggbaYgM10VOC281GUAS9uCyHhd8hDs9l8KVyHgpl4shp+5BATxKMBdpM4EYEbkUdvJH9mo0ZVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVjcFaSCoMIy/aDo5GPEPL8o0TBR5HCIKKCsLt16faOWledX+
	/PaTtkThL0RYIAifkOK0IUp/+ZAs+RNETO1bixRjeduB9DP5xoZO
X-Gm-Gg: ASbGncv57QJI0kI5AUHPpD1bO8AV0N1ZxJ7uCJPs1p9Ht8Z0rq0RGjQ87r9sxS8Ba6K
	MLI4cvkfaVWFzc1kXsVcwQiBNy1syLgvlHSbGch/ZkjqhgWQvJJt5i4BxZhaQm9ighvioaisiJW
	2dPUI7ZMdmknrxn6DwnEXJsKVkzBDDYwW666uhV50OEGSABiz/RLCaqX/FQJlrpfY7/qMYAOt4L
	FbJB+cKOIMK40mkhrCCwfqzGDBot7jUBdnxxuoKm0r9RYdL/ox/7VpFE4PiLeOCj2yg2RNCgaN8
	y+cB+o35aPSRYg==
X-Google-Smtp-Source: AGHT+IG/GTBYMutX0ifvnaDNTHsFLz/DL9WhNAt4ojV3o2SFm28L0BvhF5nSaoivdCJhJhpmzmztPw==
X-Received: by 2002:a05:600c:4f02:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-439930a5aacmr1691095e9.0.1739820610515;
        Mon, 17 Feb 2025 11:30:10 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:bb08:332f:1cf1:cf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439858ec5fasm34378135e9.29.2025.02.17.11.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:30:10 -0800 (PST)
Date: Mon, 17 Feb 2025 20:30:08 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	broonie@kernel.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: freescale: imx8mp-verdin-dahlia: add
 Microphone Jack to sound card
Message-ID: <Z7OOQNnlGCAfWYws@eichest-laptop>
References: <20250217145744.179213-1-eichest@gmail.com>
 <20250217145744.179213-2-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217145744.179213-2-eichest@gmail.com>

On Mon, Feb 17, 2025 at 03:56:40PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The simple-audio-card's microphone widget currently connects to the
> headphone jack. Routing the microphone input to the microphone jack
> allows for independent operation of the microphone and headphones.
> 
> This resolves the following boot-time kernel log message, which
> indicated a conflict when the microphone and headphone functions were
> not separated:
>   debugfs: File 'Headphone Jack' in directory 'dapm' already present!
> 
> Fixes: 874958916844 ("arm64: dts: freescale: verdin-imx8mp: dahlia: add sound card")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

CC: Mark Brown <broonie@kernel.org>

