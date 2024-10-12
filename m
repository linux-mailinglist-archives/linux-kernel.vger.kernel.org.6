Return-Path: <linux-kernel+bounces-362144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E961999B18A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FE92845F3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC413C9C0;
	Sat, 12 Oct 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LiyUwOTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2913BAEE
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728717996; cv=none; b=k5xvdXgBnCI7yhr8FRuMEWT+ZhN6oeoG1pXkvFCniuCKJj99RXHs1baydIUvOmPRTnlxTLgvvyytt1lPtIvsy5rIAZnMXWGwn5bmGegcPVjCCEJKqu/3r8G9eh8hpxQUiIvinMMUhFaw/zF0jSJeVGbVSexcyfQfpV2LQCOW4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728717996; c=relaxed/simple;
	bh=gI1ih95moOKJ9npRm7WLk/FmhUmmslPpZnuYyfrwxhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmogF89DdBdR/dwdPSyY9GEk3P4e6qHcnWHisMb72VIawyLbtysittnt0pr3PpQVVqby02FMxbXXdof30ueb5j0ZSat7/EUHSbhS5r/RJc6Q5Psc4yBiP55evRfA7YwRILbMlSgh5OkCkswphsN4U5gcF7nG0EIGooBQA+QPnyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LiyUwOTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D76EC4CECC;
	Sat, 12 Oct 2024 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728717996;
	bh=gI1ih95moOKJ9npRm7WLk/FmhUmmslPpZnuYyfrwxhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LiyUwOTd4XdstwNo+Xt58sWTyXLfaqfktP00ITRBQ5gFozsgbNW2/iS5Vb7H42ed0
	 KEAWhopgbqpSqiuBLSEhErJYAUIZAnvupGU+qbMK0OHehVUWFThGBTwSV0onHYZe0c
	 J0ifwrBQl1MZNdVaWAbmZ4wqsDHBJkTTv2dH31mo=
Date: Sat, 12 Oct 2024 09:26:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH v2 0/8] misc: keba: Add support for additional devices
Message-ID: <2024101204-proximity-hardiness-ff0a@gregkh>
References: <20241011191257.19702-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011191257.19702-1-gerhard@engleder-embedded.com>

On Fri, Oct 11, 2024 at 09:12:49PM +0200, Gerhard Engleder wrote:
> Add SPI controller auxiliary device. The SPI controller driver is not
> part of this series, because it should target spi-next and not
> char-misc. Additionally a driver for the LAN9252 chip, which is
> connected to the SPI controller, is included. This driver only
> configures the LAN9252 chip in the right mode and provides no user space
> interface.
> 
> The main EEPROM of the CP500 devices is divided into two sections by
> design/factory. Therefore, provide the two section as separate NVMEM
> devices.
> 
> Add fan, battery and UART auxiliary devices. Similar to the SPI
> controller, this is some prepartion work, because the drivers will
> target other branches than char-misc.
> 
> The series starts with two small cleanups.
> 
> v2:
> - separate commits for clean up (Greg KH)

Ah, I wasn't saying "this must be done" at all, it was just a minor
comment.  But thanks for doing it!

greg k-h

