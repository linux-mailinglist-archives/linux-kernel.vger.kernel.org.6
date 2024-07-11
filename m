Return-Path: <linux-kernel+bounces-248722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7425192E118
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3079F282461
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DFC14F9D1;
	Thu, 11 Jul 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="leyWNcP1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327F14B941;
	Thu, 11 Jul 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683808; cv=none; b=DMpvDIYd8YjlDGqzZWZAPvdSCuKBgI+k8FtFwTfQqeEM+GiErCtmBv6jRA2QaMRQu2f12gaDvltGoard4KxFTxGjGDuRgPEqEz1sH+/xgczqhUNH5ciXh9Z+U1SQZ2qOF2WUnPkpH3mYgzJgjZn9XChJe4kZdNNfqckvNmr8cFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683808; c=relaxed/simple;
	bh=njG1c1iE+smKxzp5uFclvTaUNWxb6SWxOWAKVso7Z0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1byqcb7eTYlQGh18xkklOcv/kzbk2XakKqhLxRfpB6SQVINZImBMeIwvSLLi9dOsFHPLuCUxxKyBhwN51xWiLPd3Tv+wPGBzGAs2oP1eXuKwaUwnUrMK/38ruT/KG2GkRc5rOxqrPlTkdClGCq1L7k4b7eiQ7UURc3aTWFCDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=leyWNcP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D339C116B1;
	Thu, 11 Jul 2024 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720683807;
	bh=njG1c1iE+smKxzp5uFclvTaUNWxb6SWxOWAKVso7Z0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leyWNcP1Dac9G4S7QxdmH6Uwfuj4oxEUKD0CJpQFPFKfqeFEdBFKxJi6MU+H5Q/ZH
	 Tx6JCXNMtRuMXULUwwTqFxz2US3xdWpYcdYpi2eu2UtcXid/4bgYMTYg4jOCE71NNB
	 M2qB/UlsVSOVTf7Y4KSTxxeWJynfElT68DT/xDcQ=
Date: Thu, 11 Jul 2024 09:43:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: omap-keypad -  use driver core to instantiate
 device attributes
Message-ID: <2024071121-protrude-garland-f722@gregkh>
References: <Zo9nofWJ1xg9MgKs@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo9nofWJ1xg9MgKs@google.com>

On Wed, Jul 10, 2024 at 10:03:29PM -0700, Dmitry Torokhov wrote:
> Instead of manually creating driver-specific device attributes
> set struct driver->dev_groups pointer to have the driver core
> do it.
> 
> This also fixes issue with the attribute not being deleted on driver
> unbind.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

