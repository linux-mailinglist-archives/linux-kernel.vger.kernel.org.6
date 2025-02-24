Return-Path: <linux-kernel+bounces-529770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB793A42AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1F37A7751
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799AC264FAA;
	Mon, 24 Feb 2025 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="KzGuzFwz"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD227BAEC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420585; cv=none; b=CDeuJBqDwtz63ttwOKryiCJ4Nrllu/qgPPWoIEcYEmnVnPsH/KMOj0UnfEho9S+no+TfCqATgeUWXwvCI9UFri1Ul+6Y8ZVtGiJ3qXQWJeAawO4TVkjem5u7JkRYy/Jt1OF5CUuiB2EydOl8cJ9oa8jp7aYYuZzqQBSTQyvg4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420585; c=relaxed/simple;
	bh=+biPdGM2m07+krLN6dM0bs5s598OWWMgYVsk4soqUBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjeJLhiS5wzP2+wcGtBU0kvID4LDBwnBiK/8Ovig8dhfkURbmw8Hf7ZgT2eMASfX5UKN1T5zT5qrCKfszHmUXYgBhy1vatsHjshoA76ccI9OFmUwciO9b8mFhIhOgVC+8XwyFsUYm0ZBx9HG4y0OqLJppLkRtWn9ZepfyQLBj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=KzGuzFwz; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Mon, 24 Feb 2025 13:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740420581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dCf5LqC48vAXtMhWrnY55abItj7vuNet4puF6xMEx1o=;
	b=KzGuzFwzVUZA8z++JLJuMsaluarmUd4hi6J59xuNydwpnDCqShcI9fvjgPi3dBPIftFarm
	ido4UpUcUdee+gp8FoXmS0sn9VgmaNTTncGPyStbyImI2fWI4I2CM2am7Nz+j8X606/ArX
	LKnawVpZCDtJwvHKWf+2yU/SRTk/lzW31vusI0gdTnhrJdLMUqkymInU2NlIsNuo/nOp6x
	QW/Y/n0VcEsHj2O2ZyJgeb2dVT5XzfGSLO98WznNTludm4wkUTFccBaIVb+0GOnbPz+gvw
	uY3xBL+6bu70T4usVXNX2GtLDLSby/XsFVtZ25S5YzgJ3f4jwttqENA5ScbLag==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 2/4] soc: apple: rtkit: Implement OSLog buffers properly
Message-ID: <Z7y14Q3ifu7U1tHI@blossom>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
 <20250222-apple-soc-misc-v1-2-1a3af494a48a@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250222-apple-soc-misc-v1-2-1a3af494a48a@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

> +	if (ep == APPLE_RTKIT_EP_OSLOG) {
> +		buffer->size = FIELD_GET(APPLE_RTKIT_OSLOG_SIZE, msg);
> +		buffer->iova = FIELD_GET(APPLE_RTKIT_OSLOG_IOVA, msg) << 12;
> +	} else {
> +		buffer->size = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg) << 12;
> +		buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
> +	}

The shifts are suspiciously asymmetric. Are we really sure this is
correct? My guess is that both size & iova for both oslog & buffer need
to be page-aligned, so all 4 lines should be shifted, and the bit
offsets should be adjusted in turn, and the lower 12-bits in oslog_size
and buffer_iova are reserved. But that's just a guess.

Anyway if this logic is really what we want it deserves a comment
because it looks like a typo.

(Likewise later in the patch)

