Return-Path: <linux-kernel+bounces-400695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B89C1112
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517F21F248EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27454217F44;
	Thu,  7 Nov 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0V068E+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83916215F58
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015478; cv=none; b=X6p1ltQffB/7M9bLUvPZtvIdJx3dHLFPqZt39U9iROFDc3unnz3l0x7IRQSR5xcUUIUlogCK6NqYps+0MqHAl/7eIPBhyyv/UlcnJpwZwhj1/OL0QRBKEOfefZI7oSMnW2Rs4XNbx9m1pdVfqFGXqIevuzAJh9Im3275yok0A0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015478; c=relaxed/simple;
	bh=km7FClHykeOxAjNiBwdUIOV2CU2+UNt1lyW4p2s4PtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev+UtaMBZHVWdlIXIdNGzVE1Ak+ujFBKhFr/k0y5I0rZqKkde4YtZRYxsP02lq5Hp+5smK/eWET++T6XKEvWP6YV9vG9FpsVA9TFuj4ZY+enTaIBl+Tnj7eo2878SUdxWKlUx7IqYvruoYm4nuTQHXrW/332YibHXiESqYNasrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0V068E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971EFC4CECC;
	Thu,  7 Nov 2024 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731015478;
	bh=km7FClHykeOxAjNiBwdUIOV2CU2+UNt1lyW4p2s4PtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0V068E+7lCQBqQxcPXaBSyRtrvQ8HCTt4ubdodPVTww8C6xee8H7ignLsO7pU/vQ
	 kkvLrzyQCfoCKy04+FW18p7yQ1AbuUSJXTplt8zqsrzkO/AMkMgKZLuY0P2Lg6nYwf
	 WXNU0L3sK+2GkZA0rY5htN4ZI76EteBxWXLFGqBg490kaKp0km6/l9l2kdeZ5aFDam
	 7r0F2jJzLXUztBm3o/x/G9t9Z4cp5lm5f/ZJ08IkmN3xtTsCZ+KRSQh/O+6F26YyeC
	 VkVQ1N2C3B4gbycbWPN9Of441VKQmFL8c+BkvSU0to5UZZbbZGaurKwE1qsPw13QjR
	 iOF5IJj6A/s/w==
Date: Thu, 7 Nov 2024 14:37:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] nvme/multipath: Fix RCU list traversal to use SRCU
 primitive
Message-ID: <Zy0zM8Qc0-9SVVpB@kbusch-mbp>
References: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>

On Tue, Nov 05, 2024 at 06:42:46AM -0800, Breno Leitao wrote:
> The code currently uses list_for_each_entry_rcu() while holding an SRCU
> lock, triggering false positive warnings with CONFIG_PROVE_RCU=y
> enabled:
> 
> 	drivers/nvme/host/multipath.c:168 RCU-list traversed in non-reader section!!
> 	drivers/nvme/host/multipath.c:227 RCU-list traversed in non-reader section!!
> 	drivers/nvme/host/multipath.c:260 RCU-list traversed in non-reader section!!
> 
> While the list is properly protected by SRCU lock, the code uses the
> wrong list traversal primitive. Replace list_for_each_entry_rcu() with
> list_for_each_entry_srcu() to correctly indicate SRCU-based protection
> and eliminate the false warning.

Thanks, applied to nvme-6.12. Sorry I missed this was posted until after
I'd sent this week's pull request, but this will make the next one.

