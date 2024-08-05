Return-Path: <linux-kernel+bounces-275414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE03948550
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8141F236B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E92716DC04;
	Mon,  5 Aug 2024 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BnaOc+Ez"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5016C696
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895914; cv=none; b=iYs/z2sEZ4lBmthbvy43bS4/Eth4i8UBplqPZrTPpbb4Kbmqk1P2EFfGOUiOVmrCUeSbgCWqlaDneOEb3TnK3qs0YZjwfWoYd+ROXVAn5EUWyB1Ig9NYkZk8sQZBhfsdjdGEcDNFpd9MXuu4Dr5RqOMaQyuWxO0trALrdsdm884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895914; c=relaxed/simple;
	bh=Pp8aI2iKwR2+GXwRveJhNG/mEYK/NXdxdq6bH9iCZlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpfSiD2Xs41AjzAz3gmeHmNz+5Z9KKdjzyGIxgv+idcq4y5KHJKJ0cNuZTq17QCHiuC9G5OCX5rlqTMr7GPDwEbxsHUSlndbWPqJSPoDeYWgEd1eAEuahkJMkIsrtLabNo7OMKzzk+0gsLUB/xhf2YTrIvgKPMWEm632sPNfHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BnaOc+Ez; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722895909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i82Zqt9HJw3+2eWcSnsUdFIB5iBF/cVdpLNcBIBj4gA=;
	b=BnaOc+Eznw4rmWsuRx3tNOPr8LSWsQfKKlg7aMGj0eIiP3ocDM/FZcaN/9CtqBiRtq0sGS
	NnxnRFmrAIlxtzmcfgpdzQYt9/tyQ25XUCMgc+jVzQGGcu80BNNDq7u2qbT91sizhdK3rY
	D0k9WuBF8SS/y1LfX6efZPz57zT+GNg=
From: Oliver Upton <oliver.upton@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>,
	christoffer.dall@arm.com,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	yuzenghui@huawei.com,
	james.morse@arm.com
Cc: Oliver Upton <oliver.upton@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: free kvm->arch.nested_mmus with kvfree()
Date: Mon,  5 Aug 2024 22:11:38 +0000
Message-ID: <172289578015.3402139.7931482525792832503.b4-ty@linux.dev>
In-Reply-To: <20240723142204.758796-1-dakr@kernel.org>
References: <20240723142204.758796-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 23 Jul 2024 16:20:52 +0200, Danilo Krummrich wrote:
> kvm->arch.nested_mmus is allocated with kvrealloc(), hence free it with
> kvfree() instead of kfree().
> 
> 

Vacation + catching a bug while I was out got me waaaaay behind. Sorry
I hadn't grabbed this yet.

Applied to kvmarm/fixes, thanks!

[1/1] KVM: arm64: free kvm->arch.nested_mmus with kvfree()
      https://git.kernel.org/kvmarm/kvmarm/c/32b9a52f88a5

--
Best,
Oliver

