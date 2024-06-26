Return-Path: <linux-kernel+bounces-230607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E4917F27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2536DB25459
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE5E17D36A;
	Wed, 26 Jun 2024 11:04:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C642AF1A;
	Wed, 26 Jun 2024 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719399853; cv=none; b=oGurCkvv/VEvpKG7R6dMziZrIZKeL3yuBkCZUTS2lDaMeIyUB0jik1BV3T5kzKG4xxuXTPoOtKGfmkMllzWtS62dKThaC9RqY6BuuTqsglb8iAz7vSZT5oHMBSgCXtv3sE8gScoTZFh6d/fjQzmAjJCC17ndisVNlz72lRZMESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719399853; c=relaxed/simple;
	bh=0t1EMeOWHdn653rQVHnfbTc8/KMugDwJR2jM0D/+Nxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnYX99A7Q6r1Pmleb+5TWLtEemVK9vSH61hSGTvzPCrOX2p28aosi/ckEEvDSzUXX21mqD0oJJKe2wdsBiBuiE7KazWf/mJH8GJHnb8C70boap+At9rohjVKXCuRFAhOkvZYyAwZinqkZmaTfL0DGtp/b7Edhfh0JIV8s0b4/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A920339;
	Wed, 26 Jun 2024 04:04:36 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 352A53F766;
	Wed, 26 Jun 2024 04:04:10 -0700 (PDT)
Date: Wed, 26 Jun 2024 12:04:07 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/2] firmware: arm_scmi: create scmi devices for
 protocols that not have of_node
Message-ID: <Znv1p3FDiPSUNmBM@pluto>
References: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-scmi-driver-v1-0-f16d777e004a@nxp.com>

On Wed, Jun 26, 2024 at 02:58:38PM +0800, Peng Fan (OSS) wrote:
> Per

Hi,

> https://lore.kernel.org/all/20230125141113.kkbowopusikuogx6@bogus/
> "
> In short we shouldn't have to add a node if there are no consumers. It
> was one of the topic of discussion initially when SCMI binding was added
> and they exist only for the consumers otherwise we don't need it as
> everything is discoverable from the interface.
> "
> https://lore.kernel.org/all/Y9JLUIioxFPn4BS0@e120937-lin/
> If a node has its own channel, the of_node is still needed.
> 
> i.MX95 SCMI firmware not have dedicated channel for 0x12, and no need
> of_node. This patchset is to support protocol 0x12 without the procotol
> node in device tree.
> 

With this patch you change a bit of the core logic to allow for
protocols not explicitly described in the DT to be instantiated, and you
use a static builtin array to list such protocols...so any future change
or any downstream vendor protocols that want to use this, we will have to
patch and extend such protocols[] array.

Moreover, if anyone DO want to use a per-protocol channel in the future
on some of these protocols, it will work fine with your solution on the code
side, BUT you will still have anyway a DT binding check error when you
try to add that 0x12 node to contain a channel description, right ?
... because in that case you will have re-added a (supposedly) empty
protocol node in order to containn the channels definitions and that wont
be yaml-compliant, am I right ?

IOW this solves your issue in the immediate, while adding complexity to
the core code and changing the core behaviour around protocols, but it
wont stand any future addition or different usage.

For these reasons, I still think that the cleanest solution is to just let
protocol nodes to exist even if not referenced anywhere from the DT (your
original patch to add protocol0x12 I think) simply because we allow
per-protocol channel definitions and so any empty unreferenced protocol
node could be needed in the future for this reason.

In this way we'll also keep treating protocols in an uniform way.

Just my opinion, though, I'll settle with what is finally decided
anyway.

Thank
Cristian


