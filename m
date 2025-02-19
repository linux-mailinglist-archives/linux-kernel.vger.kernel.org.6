Return-Path: <linux-kernel+bounces-521945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91835A3C424
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F66E16F5EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20F1F5859;
	Wed, 19 Feb 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pSfQ12wT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA841EFFAB;
	Wed, 19 Feb 2025 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980361; cv=none; b=AXwiCw9Pfd6RVwO2r4QaT3VWp8E2t9UoiaJ+QSn3I1Zy3ti8nr0LQ3YHSwfz4CngjyDLWisXV9U2clP+Y0WjB/ll463NpBoJUtq8+bJjHhMoexmz/muYxJmnhJsUwsNM6hRhoT+3WKseXqgCwEAEjG5roOHRHbgb+xfdhxMHMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980361; c=relaxed/simple;
	bh=OrLGrf0VcldJLycf+AKOQMmJCpAF0ZOUjFONyu3lEPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n92MkH1DwUmEr7iwGqEvcy2QpLXF1lajRcO0v3EHtIQvSg/fMW8tgv6oKkbhgvPHj4DftdL4D54u9cjt7u+sz1YVzdjWpaHl2c4biQ1W1ZJ5ieaI/oPkFxDx6wdkq6uauHR12KTLSySL6NFYG1+T/PWkYgH9EV2rqru6DtJdbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSfQ12wT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B09AC4CED1;
	Wed, 19 Feb 2025 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739980360;
	bh=OrLGrf0VcldJLycf+AKOQMmJCpAF0ZOUjFONyu3lEPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSfQ12wToDbUbD8+3/bST9PSLCR1bAtkwd8RV6OF5bMTx9EJQHIxyR1zC1E/c+oPj
	 GbfG783vEmbhBcGnj9tvoAuRxCm0SkZTdyy/96IDDFWFtQWcoK33i6+Xx9IhE3XYEX
	 HcEglY/XCv85ahTfEeNrlOY8S5cNvqpGAb3j9904=
Date: Wed, 19 Feb 2025 16:52:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dan.carpenter@linaro.org, dpenkler@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: gpib: change return type of t1_delay
 function to report errors
Message-ID: <2025021915-scandal-hypnoses-cad7@gregkh>
References: <20250218021804.29016-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218021804.29016-1-rodrigo.gobbi.7@gmail.com>

On Mon, Feb 17, 2025 at 11:12:54PM -0300, Rodrigo Gobbi wrote:
> The current code returns "unsigned int" and it doesn't handle errors
> correctly if it happens during ioctl call for t1 delay configuration.
> 
> The ni_usb_t1_delay(), from NI, is the only function returning -1
> at this point. The caller, t1_delay_ioctl(), doesn't check for errors
> and sets board->t1_nano_sec to -1 and returns success.
> The board->t1_nano_sec value is also used in ni_usb_setup_t1_delay()
> besides the ioctl call and a value of -1 is treated as being above 1100ns.
> It may or may not have a noticeable effect, but it's obviously not right
> considering the content of ni_usb_setup_t1_delay().
> 
> Typical delays are in the 200-2000 range, but definitely not more
> than INT_MAX so we can fix this code by changing the return type to int
> and adding a check for errors. While we're at it, lets change the error
> code in ni_usb_t1_delay() from -1 and instead propagate the error from
> ni_usb_write_registers().
> 
> Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>

Can you rebase against my latest staging-testing branch, as this no
longer applies there due to other changes that were sent before yours.

thanks,

greg k-h

