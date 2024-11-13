Return-Path: <linux-kernel+bounces-408306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B395B9C7D35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72ED6283F49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37625206E61;
	Wed, 13 Nov 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jkMivzI9"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ACC15AAC1;
	Wed, 13 Nov 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531326; cv=none; b=ggtMRVF+T7CEv93qNCGsx5RKXvlE5dVFbwRQBDRifP96/5w8iQWG3IX1eBZaeP6DUG3QSAz+hsPewztQtAGpQcW/ymn0GFTdrlj32eeL8ev5pJDsBrIn5Bot+58NMAHvlcaS4rTv7DkXos5DYlTzSjGU48R7LSiBLz/JqIW9t1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531326; c=relaxed/simple;
	bh=SpbVazb+0vIa47aWc/FYlBEeVVbjJbBOzQETXKdZmU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYTY+3umGNdvWEmzU8WDe0+9piOiBAsHpRUOTKbRIOCNuKAnS3WgTLsRgnU72MhUIZ4d5gG+w/AQXsef+iQZ+toEJ/1e4yk7lZ5x+tuTAZnxLoySnc9/J7uIJWlXqEAf83R6O48/JrQeiuDlhYWSF+DhKj2F8uZJjGCa+KXR0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jkMivzI9; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3170B60006;
	Wed, 13 Nov 2024 20:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731531321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oT6RDAGorrpozc7cGqo0CYW2HsUHLsv4C8N1Q7/mPHc=;
	b=jkMivzI9tJLx3be10oF0crb0Bb77pOao+EmePu6fhmUfJTZTHPa5t68QN8JzG8sdcl+lr3
	lHd0mNpqWtsVrIDfMzW5ENltlS6hASiBIieyGthUau7hgNCuwowYpvw3bRgZt98MwMzn5i
	46u6V1RdF1s43mCyQeuWf8mBnVT6oU2D+Jj64XBZEwb3NLmVuPPIDFw2kXzVxWwpPblgNP
	9FtOPH3jDH+WoE4e3QfMvsacPMDRx1ZidztLF1t7vBMZyEQBwGxIXM2M5oEJPlJkMAkjAq
	peD4koZqIpEZ4o3ebc4HpUu6BiWZI5UBAk3zakSz96oEXD+ODwjNrMwDAYy2sA==
Date: Wed, 13 Nov 2024 21:55:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Yiting Deng <yiting.deng@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: amlogic-a4: fix compile error
Message-ID: <173153128691.3601836.5746984703959903174.b4-ty@bootlin.com>
References: <20241113-fix_a4_rtc-v1-1-307af26449a8@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-fix_a4_rtc-v1-1-307af26449a8@amlogic.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 13 Nov 2024 13:57:15 +0800, Xianwei Zhao wrote:
> When compile rtc-a4, build error as following:
> ERROR: modpost: drivers/rtc/rtc-amlogic-a4: struct of_device_id is
> not terminated with a NULL entry!
> This commit is to fix it.
> 
> 

Applied, thanks!

[1/1] rtc: amlogic-a4: fix compile error
      https://git.kernel.org/abelloni/c/6cc79a629571

This needed a Reported-by though.

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

