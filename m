Return-Path: <linux-kernel+bounces-358138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E79997A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8211C21AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267515C15E;
	Thu, 10 Oct 2024 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKLk5WnZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081038DD3;
	Thu, 10 Oct 2024 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527804; cv=none; b=j4ngZ4QKFKBFH255OmAzNc6fb+K5U8hNFM1l0+Z1eUwij84N+DRJWRotL4BVQAKbMLqIFf9JW7MIvC4R+k58Il9U3QSKjgIRm7skz9fGlziz+4sIofOayyjFM7U4lSN3DbWaN9Wor+0L4n0lxaBqz0cSYgPM3baAaZiJafngC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527804; c=relaxed/simple;
	bh=BFtA9UlzI+IrQgR25CG8ul8HHroH2zSb1KBlruP536I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMcyWRoPNIgSwTLV/guKp9yg39vNqmAU7EExiQcEkB38glQa58OMDP5im2Jv06RxlbvcEsGYNuTRkBJ2mkJZLh85r9dg0FtNOEV1Q9SbQ7sEmg06xjN+m9C/cEi8iji+1Ifywid8IO2NvSYsfZnjTS0pq16GF6eCgFomid/AWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKLk5WnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FBDC4CED0;
	Thu, 10 Oct 2024 02:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728527803;
	bh=BFtA9UlzI+IrQgR25CG8ul8HHroH2zSb1KBlruP536I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JKLk5WnZlV+4mtAvdjD03RXv5dKPAUlwChlov6f9DAS4uekC7lnHE3siroVpqg4Pf
	 5/9jEi6A5SUfJ68mcrCNlvVgERa0Oi2AyKEyeLx0j4cuI56jfTMnTt/Gi89t9iD9gp
	 oRYTZWm/LcLUhGvN7vhTfEE2t7o6am7SsvD8Ci8CuYnuTfm2fV3ulx0vFHidMj1JMy
	 Y9KQITepxCTS+OmFx5PEmfSr+N4av+qPRB3x5q5omeyzabs3459ULrtA5mGnFZ4YfE
	 ZLxP5HxaeIMjr5T+e7AIFtNYuowWc6+HIUmLIYD3I6tzc35ytSmKbF4idkAJzO3jWK
	 BJSIO53QcXrVQ==
Date: Wed, 9 Oct 2024 19:36:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
 <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
 <jdamato@fastly.com>, <horms@kernel.org>,
 <kalesh-anakkur.purayil@broadcom.com>, <christophe.jaillet@wanadoo.fr>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V11 net-next 00/10] Add support of HIBMCGE Ethernet
 Driver
Message-ID: <20241009193641.17015e59@kernel.org>
In-Reply-To: <20241008022358.863393-1-shaojijie@huawei.com>
References: <20241008022358.863393-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 10:23:48 +0800 Jijie Shao wrote:
> This patch set adds the support of Hisilicon BMC Gigabit Ethernet Driver.
> 
> This patch set includes basic Rx/Tx functionality. It also includes
> the registration and interrupt codes.
> 
> This work provides the initial support to the HIBMCGE and
> would incrementally add features or enhancements.

Please wrap the code at 80 chars.
We still prefer the 80 char limit in networking.
Use ./scripts/checkpatch.pl --strict --max-line-length=80
-- 
pw-bot: cr

