Return-Path: <linux-kernel+bounces-279915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4012594C359
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716651C2221B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76AA19066F;
	Thu,  8 Aug 2024 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FrY8Ujw6"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF619049A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136873; cv=none; b=NFztPl4VlbRoPeNNNVgdDfHH3jV75Ka02ZTBeR33wuOB5aSauS8ciyHC+56adeDOjqiHHn061fK//4fPYtkqgUs1CbLkBYqOHXvPk40bR6Z1iT/zvd4Ynw/Z52bH5B2xPFuU8ujZTyzLn3+DX5cTcLRWR/o/KwltRqiqA7FHwm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136873; c=relaxed/simple;
	bh=n1CckrRpxHusTNjhXFfmCWXWaNGy0qsTYBqlNkvgqk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/mhoTTLc0YOXqWz8njJl1Wnuzz3Ukk/V3mgetQQZBURkiVyJuYnASTL8S7WYxr4/apx0JnNsXTwlI81XYGVnKw6eZRuUWVfkB8TGAgScGw+wTMKxYQ8r1Zw9pXWoe6XaLxUcUBS0iPCfow32CxCqNrbM7DkNg9PTfpTnktWGEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FrY8Ujw6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723136869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTGYHwhlXrNgcnqJdaAC4NJzJ7epnTy+OOYuWbGCTs8=;
	b=FrY8Ujw61+pqGjGoDbK093NopnMYwfH05klZqL+VL4ZZe1sNwmKdDAQAdjHH8xGO+QWWqn
	D89XBukPOnCfWfDPV81XZOPQ8u3nbvbfh7NdyTpEdrcdEIYVLiqfoNwRCycCgzUA5KLaUL
	SHmKzkclZv1xQpBNYzl5bDHjEhNrzeM=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>,
	wanghaibin.wang@huawei.com,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com
Subject: Re: [PATCH] KVM: arm64: vgic-debug: Exit the iterator properly w/o LPI
Date: Thu,  8 Aug 2024 17:07:39 +0000
Message-ID: <172313677516.561165.2999728205776923887.b4-ty@linux.dev>
In-Reply-To: <20240807052024.2084-1-yuzenghui@huawei.com>
References: <20240807052024.2084-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 7 Aug 2024 13:20:24 +0800, Zenghui Yu wrote:
> In case the guest doesn't have any LPI, we previously relied on the
> iterator setting
> 
> 	'intid = nr_spis + VGIC_NR_PRIVATE_IRQS' && 'lpi_idx = 1'
> 
> to exit the iterator. But it was broken with commit 85d3ccc8b75b ("KVM:
> arm64: vgic-debug: Use an xarray mark for debug iterator") -- the intid
> remains at 'nr_spis + VGIC_NR_PRIVATE_IRQS - 1', and we end up endlessly
> printing the last SPI's state.
> 
> [...]

Applied to kvmarm/fixes, thanks!

[1/1] KVM: arm64: vgic-debug: Exit the iterator properly w/o LPI
      https://git.kernel.org/kvmarm/kvmarm/c/01ab08cafece

--
Best,
Oliver

