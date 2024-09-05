Return-Path: <linux-kernel+bounces-317498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F35396DF27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1C4282BB8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFE919EED4;
	Thu,  5 Sep 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P33b3tU5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD234AEF5;
	Thu,  5 Sep 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552466; cv=none; b=WHtFCJxS3LoNj/C/w9YlkYqvk/Yxe8ljpJgQNEU6Cge4StZzSrZTDsGL4zlpErwej3ucHQPI1TP4nc4Wuq2xtTIofXE7TqQ/TlZ2kiF22r5p7lI08MXBzMpIg3G2ptIl8+vV4QrTHKnBgUqX7lTHpZbeFscGxOoJnAvQ2vf37tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552466; c=relaxed/simple;
	bh=gE4cIYVvpMUsnGYIYOONEV53n8Erqn9pZiaYicry22U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njSqdYL0ZF4scP88YAZjfTFNvzdDa7CPwHtuBb7LrQmegZcr5BInVzt6JSa78Mooskq3AtGgH5q+I+S15KxwSyYWjw+5QGPH6mfJ3PjnwVU0NwOh2AxuDOVj8zf7Zm5zg3DWVfT6jyAbLMoxlJyDltMt2ch+TCIF8geC1EJv89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P33b3tU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288BEC4CEC5;
	Thu,  5 Sep 2024 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725552465;
	bh=gE4cIYVvpMUsnGYIYOONEV53n8Erqn9pZiaYicry22U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P33b3tU5RBL0T3XS7IDCEgY4bHXCPjLsYKFCaUiEtTQMZpHE/tS+/bQOr6whA9za5
	 DwTR7WoHwGDFNvvObYoJ5YypB7evESL2cx3uti2JjLK8i/uax+kRqq+kKXQSvOWzm7
	 KrGtBFxX0Pxz9Y6dR4GOvQmpWnhELjalRgAfG655eKqJn0p1UG4s4oBBoCIQD6ry4F
	 LT+oCMe1zDUvRjrAUFjQJnOfS/tfNEo9JhpagHpZBuJhzjOOCI8lrmEndWMuLnPYwY
	 qpkDsJ6giNcZgDXWxSocpPJexMd4Sxx+h7GwLCHgMXjZkiA9j0KSuc1U9CsXbkcYAH
	 TzKKczFJz7QjA==
Date: Thu, 5 Sep 2024 18:07:41 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform: cznic: turris-omnia-mcu: Fix error check in
 omnia_mcu_register_trng()
Message-ID: <csrrgt4lzrzgdbanq64lhgxklhfcn62f4lkdxfkwaoxxoexre2@33ccc3g4wbmy>
References: <2b10f2e1-82d1-4f33-92c4-e0cb28b9edac@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b10f2e1-82d1-4f33-92c4-e0cb28b9edac@stanley.mountain>

On Thu, Sep 05, 2024 at 04:16:53PM +0300, Dan Carpenter wrote:
> The gpiod_to_irq() function never returns zero.  It returns negative
> error codes or a positive IRQ number.  Update the checking to check
> for negatives.
> 
> Fixes: 41bb142a4028 ("platform: cznic: turris-omnia-mcu: Add support for MCU provided TRNG")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Marek Behún <kabel@kernel.org>

