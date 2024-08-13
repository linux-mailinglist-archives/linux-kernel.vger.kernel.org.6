Return-Path: <linux-kernel+bounces-285530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AEC950F10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E81C23C70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38E1AC442;
	Tue, 13 Aug 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXiVzV/u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583621AAE2A;
	Tue, 13 Aug 2024 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583747; cv=none; b=VFUmCo3RqFJQctv5Rb1b4TvWnoOn+bYY4o+KrwGLBhSllbOCDfeXRNLaplLT+pp2EYycG/IEkG860/HmRQwVaLVVoM/1/n8Htxx8ZTcG3EcEYiUaWivFXrOemD1ekvPZSAtKsVgZHtKZ8Unydj2MUzPPELplwC501TA4OSlIJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583747; c=relaxed/simple;
	bh=rSwDVF8qOqv0gAiryqavCgWJLB9AkPc63lVNLtkQKnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyG1dGTGi0t9zj6XlsNMCCz8pZ2KBI0TSUOFUWt5mUDLMb0IKbp1NaKl14AW3zl7ch2s70pRAfNW/7ie9MAFFumveWIBqdgMkjAmN3Re8aA6DOw/5tTHHdEij5TffM9wCJN+fhIbnQAXXSE9Hp8EHLIkeRqzA2arCa35WhRZMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXiVzV/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07A1C32782;
	Tue, 13 Aug 2024 21:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723583746;
	bh=rSwDVF8qOqv0gAiryqavCgWJLB9AkPc63lVNLtkQKnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXiVzV/u5K7RZfb+zEHX+CIurQRja1BC7HzW8w6LI65CE9COJ0E/vUDse6xAe6k4d
	 nHlukMq1cBX4GjfcUniwWRnvlc7YFRQzZRb2JeVzMTSmv6/DcYTFToZyxLHsf4iJei
	 4n6L4PjaGlC2DqZ4UoxvSfV7Oni2g2SUrlbwByh3NoK89n4L9x3gnmKiKFZP5MTcg0
	 aEzFDK2c7DS12BRgpauhKRFKIBJGeYpZFD42nNRqK4ox8g2fSBgYRpeLfj2/AH/lgz
	 0wjHLN/JndI3Clq2YX/gyBSXU53J5nrQb97qDdMtScOCGSm9LCnRgzV7mdh+99qRDt
	 KLNwROcFQ9JQw==
Date: Tue, 13 Aug 2024 15:15:45 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] of/irq: Look up address cells via API call
Message-ID: <20240813211545.GA2038268-robh@kernel.org>
References: <20240812100652.3800963-1-stefan.wiehler@nokia.com>
 <20240812100652.3800963-2-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812100652.3800963-2-stefan.wiehler@nokia.com>

On Mon, Aug 12, 2024 at 12:06:52PM +0200, Stefan Wiehler wrote:
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  drivers/of/irq.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)

I have a similar patch coded up, but then I wanted to try and make 
things stricter WRT walking up parent nodes (no FDT system should need 
that). So holding off on this one.

Rob


