Return-Path: <linux-kernel+bounces-215868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E11A90981B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 14:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527761C212C8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019C45028;
	Sat, 15 Jun 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8QHqyIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9202E400;
	Sat, 15 Jun 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453389; cv=none; b=ViZLE82Mpd9C0YScM51N9OyhSCQqoDt77duTn5E6wRTToB8y9zqetqEm37DOECqJBSVZOUS+ODLK4FV1HTrrQqXzNkcj6xoazzsulxJepSJZIoRcAHal86QBuK5fqSy2Ly2VSRS08fpPd4pO/R+hhpPr4t+SP0X7CfIIjQpTiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453389; c=relaxed/simple;
	bh=e56elCVsYhzaI2+hNiUznG1iV4hQkayq6NJHiVNEkgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwA0aBMhwpwtrWjyfenbf4clyt60RzKEf4Xe6aXSx71OvhvdxFhcWkqu9QOsOevilh1NujtwTH7LU16HGaFkpl8m9TVOAAknu0PjAeuvUx+QK+G9lwvSUN88PDv8XWW/lkJy5bbMHmhjxu/8lnp5NRu6Fo35xOGv692IfvPXd7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8QHqyIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060BBC116B1;
	Sat, 15 Jun 2024 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718453388;
	bh=e56elCVsYhzaI2+hNiUznG1iV4hQkayq6NJHiVNEkgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8QHqyIv7MXOgxrbk/AJH2SpyB7L40J7K7ndde7X39Cq8n2QYUWRPoIUwYkTmhqTd
	 1K1KOK2Em+fC9JCQLUPvKDvQTFr866jV+y/D6Sxx8ViLw+e+Pgkn8sfw8/9gljZ68a
	 uIGxQ5Dao3My7H8NfMRxIu2NAQoCfnIwwjcTZdiwoJhifaTRuFKAlgHJIrDFhmHZVI
	 1etSEhGwfqceepTDWDENFI6LSGWavfL+qEtKYhUtXZ+0nB3MIbPCCq9hvqgdxIDYep
	 GXAde5qysJ0se1WzT28N9wNS8S+bq3+maUtAsWXx57qq8tTKhgRrRQmWRVGg1VJufL
	 f4kj0IPYgdAVg==
Date: Sat, 15 Jun 2024 17:39:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 1/4] phy: ti: phy-da8xx-usb: Add runtime PM support
Message-ID: <Zm2EiKTNR_cdLLoP@matsya>
References: <20240528102026.40136-1-bastien.curutchet@bootlin.com>
 <20240528102026.40136-2-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528102026.40136-2-bastien.curutchet@bootlin.com>

On 28-05-24, 12:20, Bastien Curutchet wrote:
> Runtime PM is not supported while USB PHY can be turned off from
> register accesses.
> 
> Add runtime PM for the USB2.0 PHY. The PHY is entirely shut down to save
> as much power as possible. This means that gadgets will not be discovered
> once suspend state is entered, and suspend state can not be left without
> an explicit user intervention (through sysfs). That's why runtime PM is
> disabled by default.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

