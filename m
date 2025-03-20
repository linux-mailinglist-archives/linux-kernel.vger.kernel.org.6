Return-Path: <linux-kernel+bounces-569830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4BFA6A80B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384E488043E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686E42248AC;
	Thu, 20 Mar 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ri9+AetM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E0224248;
	Thu, 20 Mar 2025 14:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479817; cv=none; b=KqEG0Sw2psNMBd+818nqgQzCEK+IRLkPHXJQuAJHiEPF4RsH5cRUwS9UAx5y7OSjS1qtVmXkPaHZgt/4rRRNGyVd+fR6G4QNV33iwl1HUG+sq6BDK4IYyyA7vGIGixi561zMStEPguTayK/QAA6dfXtaJJWPXKSgWb3f9Z4is20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479817; c=relaxed/simple;
	bh=u/XfyF24+W2IoMS0SHq/5NLzXd1IMY1rHFTGKwOT2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBPpgv5jO55Vki8lLUBvX9eGFVX5i+uQ2Bp+OXXIk0VQNm+R0aA+o59uCYVcUR4Ul9Jq7IPzLFh5BwN7WWpgCHNZovXue46M+oIcdX76WoGRyUUOs51BCC9FIGEEJF6K6UlLArQT6cgoaELTiWJpoXJO/H8PscNjieN8fKyuUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ri9+AetM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D20C4CEDD;
	Thu, 20 Mar 2025 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742479817;
	bh=u/XfyF24+W2IoMS0SHq/5NLzXd1IMY1rHFTGKwOT2vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ri9+AetMwqnym75N+tpxT7Ij6f3swyJ7S80a8vta48sm5Y7v6SdFdPMenpypCOzBy
	 mDMf1B2HT/Okc8knUSrOU3B/yqTCeS4UnH0pkkkjHp5b8rYQX3G0Hi+NVn2dLmg7GD
	 3KyGUJt+pxazniIrTUk36wBL8igSTy5UxutS795s=
Date: Thu, 20 Mar 2025 07:08:57 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dan.carpenter@linaro.org, dpenkler@gmail.com,
	~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: gpib: change return type of t1_delay
 function to report errors
Message-ID: <2025032004-nerd-germless-a1ec@gregkh>
References: <20250225014811.77995-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225014811.77995-1-rodrigo.gobbi.7@gmail.com>

On Mon, Feb 24, 2025 at 10:44:05PM -0300, Rodrigo Gobbi wrote:
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

As other recently submitted patches caused this not to apply, I fixed it
up by hand and got it added to my tree so you wouldn't have to rebase it
again.

thanks!

greg k-h

