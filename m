Return-Path: <linux-kernel+bounces-292634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3242795721A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE581F246EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9313176233;
	Mon, 19 Aug 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2sldeMK"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C543A17557E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088361; cv=none; b=tOJI2uCitHYMtS+sIMKSFcSvyMldKvpoPyYgt3rIlvfEuKOG3KpcZ/iz7Q338GfvePVHUq/3VetfafyLTeIQnxvr+HzJUna+HmlBOXsJSn9iZXWWrSmF0AXl1lWtWq1vhxQXNrqwj07g7+sF0noSwfbsu3KydX29uA/CV8WG6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088361; c=relaxed/simple;
	bh=V8HqJZq8ou5qqu3gnI9Q6yW31ZSw3/U0vK1iIw+2vLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toAhDfeSHH0Z6cRX9jZe5Qh1BKoIY3zBZt+gDWTO6QUi+1UJwK55K2q5xlij0jCY8a2Oh1MwMgiegTjru0+mY197DUKUJ2WWcTnzaNuvZHZHm7Pj9dPAYa3ZQMfR+6ZSyMSvhd6aXThPLNpfVr9AKk4gvmbV8wmHtBPfcb82Y2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2sldeMK; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724088357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjXIgrQkbNbdREGaeSmiEsu2NJFDyg3k70yEW2RV1tI=;
	b=v2sldeMKhW8eJfG+muN64Qp4PR999jCGAV6mnCRNxSDgC4jjnTj65/nmmgps0FTCDPlVAZ
	PeIAx4O4z7VyjZkiwaHGX1+SDUJPmeGXbfajfOPfqPnZufNNvrEh3CqZepH1pgSn/aIx+I
	cawaL39lc9vEq6DUOW98JmSS3CkLrS8=
From: Oliver Upton <oliver.upton@linux.dev>
To: linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Zenghui Yu <yuzenghui@huawei.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	wanghaibin.wang@huawei.com,
	maz@kernel.org
Subject: Re: [PATCH] KVM: arm64: vgic-debug: Don't put unmarked LPIs
Date: Mon, 19 Aug 2024 17:25:47 +0000
Message-ID: <172408829923.848017.11368160825024844050.b4-ty@linux.dev>
In-Reply-To: <20240817101541.1664-1-yuzenghui@huawei.com>
References: <20240817101541.1664-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sat, 17 Aug 2024 18:15:41 +0800, Zenghui Yu wrote:
> If there were LPIs being mapped behind our back (i.e., between .start() and
> .stop()), we would put them at iter_unmark_lpis() without checking if they
> were actually *marked*, which is obviously not good.
> 
> Switch to use the xa_for_each_marked() iterator to fix it.
> 
> 
> [...]

Applied to kvmarm/fixes, thanks!

[1/1] KVM: arm64: vgic-debug: Don't put unmarked LPIs
      https://git.kernel.org/kvmarm/kvmarm/c/2240a50e6294

--
Best,
Oliver

