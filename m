Return-Path: <linux-kernel+bounces-418773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CFC9D6588
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34D1161067
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FEA18BC15;
	Fri, 22 Nov 2024 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XsRd9Cxv"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1521176ADB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313234; cv=none; b=Ki9vh15QYn9aS9Exb+TrE4lgM+ca7jBTstHpsYPlDSMmIWTJvFWiHM98tjoqNlgd72aVSWUwDO5vhUtFy5tYFz4z1xMh8JfLJ/Tl3jdme3hbhR7luflh8HDr8hL2f3xfNWAjE0SO6ugMI8w6LLB8Kuh9/N5utxwLWCCLwjX8j3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313234; c=relaxed/simple;
	bh=PIN+jRJHphsVkVPazk7FABfbX5MCNhJGD6UExaxzGFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2kykRujQ8VbG0Xg8H4DwIuS99TDsnY1qc2drPxSFs75sON6d0u2lnlkKNBCx0YmghewJGDxY7dIruDi3BpHEzXBrT8gG+SeMscStvHtEZ3rWB49/XPyXwJWyOg21Q5Q4AOYTTa6C/vNfjJXxyzrjwGkJphswg5RT0SPEoM1HKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XsRd9Cxv; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Nov 2024 14:07:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732313230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfY0Pf/J5wwf39xKb8ImS4WjQmELRZS9FkgRQ+eWYnk=;
	b=XsRd9CxvGwRA/R7tFTAPja+AHc49dwSaSCQfS4/qfNLc0xp0zLqF29aVLuwnLBhtmMOc8A
	KEBEL1VXtEbRCnu9YEjzzkD2M22Xyypcc/DNWZOyO04ATG0OUhzecpwEVQ5Zou1seFbLfk
	zVwvSjtSC9/2YOZ/N0rfUAq3aSsXqXk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: James Clark <james.clark@linaro.org>
Cc: will@kernel.org, maz@kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	James Morse <james.morse@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Quentin Perret <qperret@google.com>, linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] arm64: Fix usage of new shifted MDCR_EL2 values
Message-ID: <Z0EAhCbhM1B_4vW9@linux.dev>
References: <20241122164636.2944180-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122164636.2944180-1-james.clark@linaro.org>
X-Migadu-Flow: FLOW_OUT

+cc Paolo

Ugh, sorry for the mess + thanks for the fix James.

Paolo -- would you be able to apply this patch directly to your tree?
This really should go in ASAP.

Otherwise, I'll grab it + send another pull.

On Fri, Nov 22, 2024 at 04:46:35PM +0000, James Clark wrote:
> Since the linked fixes commit, these masks are already shifted so remove
> the shifts. One issue that this fixes is SPE and TRBE not being
> available anymore:
> 
>  arm_spe_pmu arm,spe-v1: profiling buffer owned by higher exception level
> 
> Fixes: 641630313e9c ("arm64: sysreg: Migrate MDCR_EL2 definition to table")
> Signed-off-by: James Clark <james.clark@linaro.org>

Acked-by: Oliver Upton <oliver.upton@linux.dev>

-- 
Thanks,
Oliver

