Return-Path: <linux-kernel+bounces-529775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA63A42ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D15037AA847
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284EC265CC6;
	Mon, 24 Feb 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="JU8IdZ8Z"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C814C264FBA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420657; cv=none; b=OGCQJH84iYEqQJcr9biBhHbvecWNdezxBSJRnmtBzPXAdySDmBzDDO8lLl0TIhAzq9tC+ZR2NZmyGxZQLklCv4gbRxWluWzwiVRi6Ba1NdhNb+/tNErJdLflZXCqCSUbVxFmeZD7eOE7XJ+gUujPcU+NbyPA6oHURCbugxRrIjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420657; c=relaxed/simple;
	bh=IgHRIP28Yr331rvfAKunANLb05fctXf/yo4cvTXSn7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmDckxI9Vsu8aa98pCaMbTJWnT0axgtuFk2dBL8KJbAm2F+BEGdXbXaianf1WjE1uvF3Bf2cYYWD8dhppx7IIEKImLvGj0kxeHkYY9aNBHAO30sWm58QwxhTdMQ+sJbzWGWFJ1ayd/s896mPB/eH6DDGiwx7EAEvPMysJZi7psA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=JU8IdZ8Z; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Mon, 24 Feb 2025 13:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1740420653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjyHwCSZNLK4SVIWWoNCwaf/Co4pdr2aVmA/QrJzipg=;
	b=JU8IdZ8ZDCt/ifhh1hA5Q6whezAiqU8735YHxd82xnDW3c4RBmNxkIUBsjkipWbfwvQQZ4
	HbjbPDYa9AzrlyPUehZLxnEXRpWOdjV1J0dYqvuTBM9OAM2XKhRwMacnfczZR++xe0nlgy
	aNIY9CgT7coDH3eINfF+kduJLrOQqoiYZ4bhGpEqOjEO6f1fyDABbbo/wqG4cinRE3b69A
	YgLeg0qbmA0+tbfuUsOS8OUlZz84jj7W+fmWmjwpeHI0l5XLtvn85TBzXm0USVQe2MlEiY
	b7VAHIVrd4BO8MPriYcuCvXBEbDByMPPc77bUBGaFFqIu4wSlkj7ByDsQm5fnQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: sven@svenpeter.dev
Cc: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] soc: apple: rtkit: Cut syslog messages after the
 first '\0'
Message-ID: <Z7y2IdBJbIWOpz8r@blossom>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
 <20250222-apple-soc-misc-v1-4-1a3af494a48a@svenpeter.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250222-apple-soc-misc-v1-4-1a3af494a48a@svenpeter.dev>
X-Migadu-Flow: FLOW_OUT

Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Le Sat , Feb 22, 2025 at 04:56:49PM +0000, Sven Peter via B4 Relay a écrit :
> From: Janne Grunau <j@jannau.net>
> 
> Certain messages from DCP contain NUL bytes in the random data after the
> NUL terminated syslog message. Since the syslog message ends with '\n'
> this results in a dev_info() message terminated with two newlines and an
> empty printed line in the kernel log.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/soc/apple/rtkit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index b7f4654c3341..595efce265ce 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -476,7 +476,7 @@ static void apple_rtkit_syslog_rx_log(struct apple_rtkit *rtk, u64 msg)
>  
>  	log_context[sizeof(log_context) - 1] = 0;
>  
> -	msglen = rtk->syslog_msg_size - 1;
> +	msglen = strnlen(rtk->syslog_msg_buffer, rtk->syslog_msg_size - 1);
>  	while (msglen > 0 &&
>  		   should_crop_syslog_char(rtk->syslog_msg_buffer[msglen - 1]))
>  		msglen--;
> 
> -- 
> 2.34.1
> 
> 

