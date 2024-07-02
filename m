Return-Path: <linux-kernel+bounces-237202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676391ED5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65FDB227B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5FA1CF8F;
	Tue,  2 Jul 2024 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KorU8lBD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196B946C;
	Tue,  2 Jul 2024 03:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719890015; cv=none; b=V/V9wTvFfYjOFo2ynoLZrQ/jGpHIUpm9Sjo/E0IpZ0CSF5/udDxMdFdsYYXibz6pQ2ldptcoKSzAhrp6BuDL0yl91Z27JXoumlq1FRYSyle4tBBGVYpyqsrqozn4dtxC/fb6S7Hz9I9pioxBGPOcs5nRNIz9doO+tMvwPKnDvPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719890015; c=relaxed/simple;
	bh=HagQN+8X1KFDCWOclj9PUz3LOxErZo8SCPgVJpyWgx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGAkkJNg0BOMt5MatCyA3QyHhywj6hSFn3SlCQlEc6a73Iml5qaTVQV8dmcNuCbfQswDtL9sjGYKTl7QwssF1UrxvG8es9ftSMGRUt5UtWWQLp/ocXpr87z64us9SBJl+N1ksBnIfCBTXsujRP3ss6ZTsi44tNw+M1R21ClL/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KorU8lBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219D6C116B1;
	Tue,  2 Jul 2024 03:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719890014;
	bh=HagQN+8X1KFDCWOclj9PUz3LOxErZo8SCPgVJpyWgx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KorU8lBDEn2fp+u7/rbTen3aBUkPKKLdvNz0pRJvn7dAshdDtJwPn11GvMiHWcUuk
	 3QMO2H0gSDpBE80uYXfHVa/WhS+RBzaIAyg3ZLce5TNs+I04u02igRli5UhqbRnxCt
	 wM6fb30Kq3K3loai2XPQOT6mrG186he9bAwjD16N1acG980czOrGdXKbqzDW01+XO2
	 XjHUjNWO4VXqswDeiDD0MVxoOcK5vzDrZyqEBN3HQ4LBmMSR5OwhjRLoY+DHD54Cxm
	 FFTJVZ1ErdQVRyjSR6D+fuzxY099Gfco8OvQbG+TmwtOVMLUtuVIIji/FwUkN4LbAV
	 6mgp1ED5qpy0w==
Date: Mon, 1 Jul 2024 20:13:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v7 06/10] octeontx2-pf: Get VF stats via
 representor
Message-ID: <20240701201333.317a7129@kernel.org>
In-Reply-To: <20240628133517.8591-7-gakula@marvell.com>
References: <20240628133517.8591-1-gakula@marvell.com>
	<20240628133517.8591-7-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 19:05:13 +0530 Geetha sowjanya wrote:
> Adds support to export VF port statistics via representor
> netdev. Defines new mbox "NIX_LF_STATS" to fetch VF hw stats.

These count all traffic passing to the VF? Both from the representor
and directly via forwarding rules?

