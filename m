Return-Path: <linux-kernel+bounces-422542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748CB9D9B24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A52B2C5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AE1D6DA1;
	Tue, 26 Nov 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LhvdyQnB"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF01D0DEC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636784; cv=none; b=pKnIrTygJcAL/XcO/uPceRCHrmm+rGa/Rkp0wg2g8SG3U+Ghq1iDvFPj/+L3lu9uC/sf3eAq1j38TrT3eWP/7bh1cqli7eDV+Sovb54Meo4Frpb61Y2UDJYrk3dSI7WLcb/0019Ewe9jRtYuuPXBroCYxfiXsfF0k8P1y9Hjd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636784; c=relaxed/simple;
	bh=3tV9aRSKikT8zMp5zCwaFs8edwtZuaY6P8FxCJluN2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoEDXw8+GhHGxZWWIi+Cu9xX4eLzvkAYpJ6Wu4zMy14Ic6fqjaSwCVBFWAPZo9/uQS4oA8zJpFvybDW62OifpwQqGxTX7HUhWkg32jge4XMZv2zm1PXvgRel1q9id/q+8ICzefNsQzCto6oscG8qsoF0qq1jYM/9DDS83OinmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LhvdyQnB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732636780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmF/6x31FfYxPFDBDRNPF1RJ1ndUJpnTkS2ByH7P/BY=;
	b=LhvdyQnBtXR72Imp/QRtE+uP3eXpCVDl/VxdZdgRJi86CAOlTjndAOiogcAVC9bKZRiKXS
	qhzTBM47YfdE8BvF/TRXp9KwSUL0O3R58NQ7ti0oXtSZk8N9puq2eimm9MfCWYtgaTwZSB
	jM/QtcWCt1YMfedRxX8O7N8mgJE78Uw=
From: Oliver Upton <oliver.upton@linux.dev>
To: will@kernel.org,
	maz@kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	James Clark <james.clark@linaro.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Fuad Tabba <tabba@google.com>,
	James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Fix usage of new shifted MDCR_EL2 values
Date: Tue, 26 Nov 2024 07:59:25 -0800
Message-Id: <173263668481.68510.14862173366195490038.b4-ty@linux.dev>
In-Reply-To: <20241122164636.2944180-1-james.clark@linaro.org>
References: <20241122164636.2944180-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 22 Nov 2024 16:46:35 +0000, James Clark wrote:
> Since the linked fixes commit, these masks are already shifted so remove
> the shifts. One issue that this fixes is SPE and TRBE not being
> available anymore:
> 
>  arm_spe_pmu arm,spe-v1: profiling buffer owned by higher exception level
> 
> 
> [...]

Applied to fixes, thanks!

[1/1] arm64: Fix usage of new shifted MDCR_EL2 values
      https://git.kernel.org/kvmarm/kvmarm/c/d798bc6f3c17

--
Best,
Oliver

