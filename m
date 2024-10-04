Return-Path: <linux-kernel+bounces-351555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E669499130F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7496282D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BF91537AA;
	Fri,  4 Oct 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNoFQWC/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3B231C9A;
	Fri,  4 Oct 2024 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084775; cv=none; b=PdFQ72R08WJFyAK3OhGMI/C+NmUgnHoYE7uM6LpsgmKL24hRP2E9ZPuOYfe2lYJkIVgWkkMWjdhjIgySOsp2dlwWk48z1sIQSskII5ullKqphWJULInILCERv4HC37O01PVJ+rALJtc0oLiPPO7BkTAHP0BX4DioQYPKyAcZSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084775; c=relaxed/simple;
	bh=XZD8AWXXeYonIKpnrgciS1G8nGRw4jqoPi0spttb7Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCfwd/2oVfFatrJTjHJsRePuKDaS38a4BfTjbuwJplxjco7pc/kKd4RYSX8ccMHZaZ11KOWefhPosa/WVXIkxhHF4H1oyNSXcbYZrbLWLBnfaKsQPy5ZLereOsUdOiMLO1kcIySnuaaFNT3YAjCNGnaUGMbSOeszwPoVvN87fq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNoFQWC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B1CC4CEC6;
	Fri,  4 Oct 2024 23:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084775;
	bh=XZD8AWXXeYonIKpnrgciS1G8nGRw4jqoPi0spttb7Kg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SNoFQWC/+lwU3aWyQKG+T+MnWFSBO/w8vmhNba1p3LyT7hdu3gd5nD62q9WJdo3eb
	 gilRE1g0YCvZI9GRBYLmoUHdrzoXB0xpoyjb5bcxuMq37pnkzUo6dc+lXVGqw96Hrf
	 A8LqInOmzz72MlAEp7Djy0au9BVaTh7XkNGK2pDibOgoegPZYPkgXgO779sv1RGvT0
	 Ej5hyKWFgoOVMBhi934HYyeF+FZGqqaaIDVWLoy3xtLoLm3/HQtIQR9kNTP4L4VWE0
	 WKaaFDlV3bJI6wWVTbYJ9AwB6mLLU8MnBU00K5ykc+E73WO1emletMqg503Esk/RuZ
	 s21U9ooCPxhuQ==
Date: Fri, 4 Oct 2024 16:32:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 00/17] ibm: emac: more cleanups
Message-ID: <20241004163253.6a41a52d@kernel.org>
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 19:11:18 -0700 Rosen Penev wrote:
> Tested on Cisco MX60W.

Thanks for including this info.
Looks like there are various "sub drivers" in emac.
Which one(s) is Cisco MX60W using / exercising?

