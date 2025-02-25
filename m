Return-Path: <linux-kernel+bounces-531675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 804EBA44366
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BD07AED2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87A026E62C;
	Tue, 25 Feb 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skYlwuuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108E256C76;
	Tue, 25 Feb 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494686; cv=none; b=ImKEmT9JLIrGKWMnEbTrO/gf6Q2pFUDbUPyMLzOP/bQb6EwnhE518TDLV/SVchgzquWZV6UgKCr09VrMszqN3oir6pu6Fojj0DvixXrFXgvcTwXHaD0OhhM+qPEeOiXcmF3moQC5CvrpiNFE6PevOj8IKVUwgAqbO+zwTU0RPiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494686; c=relaxed/simple;
	bh=/3ml7Kskfcfy5qsd1jZUgWGxSJHDFLyVZ2qAdRQNTPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMAwMBrYfri2Z+e6mP1TBb+KEd5D9e6k00eHmDXxZ9C3bE1SdanZLKfZHmQTgjj2GBra+CeD9XoF3r0oa0YqrjeU6Z2Ot5N9W/c4piQatTvHtSOz7KHCf2kfl5f7I9y19cSYgX2osMoB81l1g8TP6iSl63vMWpDWp7mGOEBvvac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skYlwuuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F895C4CEDD;
	Tue, 25 Feb 2025 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740494685;
	bh=/3ml7Kskfcfy5qsd1jZUgWGxSJHDFLyVZ2qAdRQNTPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skYlwuuwTZ7IuY9AUBFLIZJCK5nYah+iJDn7/KwZQoFwkK6U93EhfQJTFk94hQaYW
	 SkmdZG9T4EdIFQXvePcgCfmrDN88DrkyfbJQYCyF7AEOj/fvbhvLKK5lKbuFba4PG3
	 HJlJhzZZLoqs/wxFdAMM9SZO8j9F2/1xMaOxQLhOvbny+Ru3amdgQr38yyYOJ8yfzx
	 4dB1soNIp8qwtoG6vq5jccdAc5HRFx/uHBAbbizG4ZkujDRzPoBSDqJr97YTifckOj
	 08UNBo3YRkTmf71hPg5ek6dY3Q8UyP8fkzEmMVqPOAAhmVHS1GT3Wrerui+QCFT6z1
	 qcia2xcR/lWHg==
Date: Tue, 25 Feb 2025 08:44:43 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: linux-kernel@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] of/platform: Do not use of_get_property() to test
 property presence
Message-ID: <174049466882.2361149.14230010976182522638.robh@kernel.org>
References: <20250224-of_bugfix-v1-0-03640ae8c3a6@quicinc.com>
 <20250224-of_bugfix-v1-5-03640ae8c3a6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-of_bugfix-v1-5-03640ae8c3a6@quicinc.com>


On Mon, 24 Feb 2025 22:28:01 +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Use of_property_present() instead of of_get_property() to test property
> 'compatible' presence in of_platform_bus_create().
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


