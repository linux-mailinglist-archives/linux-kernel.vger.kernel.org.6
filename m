Return-Path: <linux-kernel+bounces-236638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C482A91E539
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028FB1C21641
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1016DEAA;
	Mon,  1 Jul 2024 16:21:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450D816D9C5;
	Mon,  1 Jul 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850902; cv=none; b=CN/1VsHGdUwV+OsfzXS0xgdgnHDJ9fVOTHoB4qdtjtl6tVyIOKjDgWuqro71YNm++wPOBXDNrlaGX1R83/RU6+akb5FEcmMTrEZPPS8cL/9rCrbMfgiaF+bOlaJk74H/0h2Lkdu4uAjZ9e0obOuGjDRaZwcDaDsL7fcH/bnLepo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850902; c=relaxed/simple;
	bh=M6IYo8b0Q1XF3SwYUmG4CG4tqJzC1dEx44Swa5frpZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR4+B7NjucZ6OZMBUaUCO8iMOt47qk1gaGgDb9HRlQ9AxC4KizoXX9YegmFdWKGAglDSuWjpLDawR9fVLTGm81aQt3KNfGJWI3zXJn9idxEyBtXFQ1ZKWDYMVqD+gsoowFdc2UgjeOyXrbaIjF9a+v8e3EjCqX9JC3obBTVEAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 975CC339;
	Mon,  1 Jul 2024 09:22:05 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDD453F73B;
	Mon,  1 Jul 2024 09:21:39 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:21:37 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH 0/3] Add Per-transport SCMI debug statistics
Message-ID: <ZoLXkWur5TZaQzkm@pluto>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701142851.1448515-1-luke.parkin@arm.com>

On Mon, Jul 01, 2024 at 03:28:48PM +0100, Luke Parkin wrote:
> Hi,
> 
> This series adds support for tracking Arm SCMI statistics, [Patch 2]
> A config option to enable this, [Patch 1] 
> And in [Patch 3] a selection of new debugfs entries to present these statistics
> 
> These statistics are per transport instance, and will be a helpful resource when
> debugging the SCMI and running tests.
> 
> Based on v6.9, Tested on Arm Juno [1]
> 
> Thanks,
> Luke
> 
> [1]: https://www.arm.com/products/development-tools/development-boards/juno-arm-dev-platform
> 
> Luke Parkin (3):
>   Add Kconfig option for scmi debug statistics
>   Track basic SCMI statistics
>   Create debugfs files for statistics
> 
>  drivers/firmware/arm_scmi/Kconfig  | 10 +++++
>  drivers/firmware/arm_scmi/driver.c | 61 +++++++++++++++++++++++++++++-
>  2 files changed, 69 insertions(+), 2 deletions(-)
> 

All in all, seems to me a good start, please address or dispute my (and
possibly other reviewers) observations in V2.

Thanks,
Cristian

