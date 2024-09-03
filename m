Return-Path: <linux-kernel+bounces-312727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8E4969A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C8028524B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3B1B9841;
	Tue,  3 Sep 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xu7jRGkK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D151A0BEC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360068; cv=none; b=u1Ik5lENICzQ+d9LbNsjvcFBQXi9W7wJ7wEIzDyBNBk9AYLavdBdd6q54Uy7ok2j+FTB7ceIYkJbNNmYLGYu2e+8Y1BsrjlQncM4Qe9/nWSPe4arPXWs2D8bLf6Lz842Bas/29gULG2Jl1PrDNrGzdOdYhReyTHHEYKDixQGYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360068; c=relaxed/simple;
	bh=8oi/ES7VMNJd+535IRV4eMBZRqghvqMgQqETNkH86vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5KeHishED/CJwpJt79sTbfq96lS6qRFpOj4/gd6FVA+m+t5pWa3hRomeTihNMTKrDrKrJsJF59k3zlmcMPpYTxZyOa2TO7RupzWXeNy9OXlMKGZ6zCufXkuavEHChqgDJIQi4TxwQPVwX2zbDBlao/WO236tFMuGzPy7DP08u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xu7jRGkK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EADAC4CEC4;
	Tue,  3 Sep 2024 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360067;
	bh=8oi/ES7VMNJd+535IRV4eMBZRqghvqMgQqETNkH86vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xu7jRGkKYnj/o/ODxo3gG86MSGDtl/37nSmrvEW2iJwtGt51dzCEV+tIvCfo4YnN1
	 Hingj4TK0HcvSW3O1lZ6QJMKSZywZHPgqCC1Q+UvtTNvLTdrzxALTvl5GGQxnicb53
	 obu2ukdFbbzB8sb1FwdOh0Bx3+n8eX20Om/2wPo0=
Date: Tue, 3 Sep 2024 12:12:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/9] nvmem: layouts: add U-Boot env layout
Message-ID: <2024090308-smasher-craftwork-0db5@gregkh>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
 <20240902142952.71639-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902142952.71639-5-srinivas.kandagatla@linaro.org>

On Mon, Sep 02, 2024 at 03:29:47PM +0100, srinivas.kandagatla@linaro.org wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot environment variables are stored in a specific format. Actual
> data can be placed in various storage sources (MTD, UBI volume, EEPROM,
> NVRAM, etc.).
> 
> Move all generic (NVMEM device independent) code from NVMEM device
> driver to an NVMEM layout driver. Then add a simple NVMEM layout code on
> top of it.
> 
> This allows using NVMEM layout for parsing U-Boot env data stored in any
> kind of NVMEM device.
> 
> The old NVMEM glue driver stays in place for handling bindings in the
> MTD context. To avoid code duplication it uses exported layout parsing
> function. Please note that handling MTD & NVMEM layout bindings may be
> refactored in the future.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  MAINTAINERS                        |   1 +
>  drivers/nvmem/Kconfig              |   3 +-
>  drivers/nvmem/layouts/Kconfig      |  11 ++
>  drivers/nvmem/layouts/Makefile     |   1 +
>  drivers/nvmem/layouts/u-boot-env.c | 211 +++++++++++++++++++++++++++++
>  drivers/nvmem/layouts/u-boot-env.h |  15 ++
>  drivers/nvmem/u-boot-env.c         | 165 +---------------------
>  7 files changed, 242 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/nvmem/layouts/u-boot-env.c
>  create mode 100644 drivers/nvmem/layouts/u-boot-env.h

This patch doesn't apply to my tree :(

Also, if you generate patches with 'git format-patch -M' you can see
when files move easier (if that's what happened here, hard to tell..)

thanks,

greg k-h

