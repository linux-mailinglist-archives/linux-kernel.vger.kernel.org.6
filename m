Return-Path: <linux-kernel+bounces-297104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C711C95B327
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C652842FD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095B17CA19;
	Thu, 22 Aug 2024 10:46:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188A558BB;
	Thu, 22 Aug 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724323589; cv=none; b=QBGya03DBgEF9t2vEwRCjfsOl61l/H2sF6Lb+WKTpVj2TjhgDQBL8YdlcBUMY1y0hmQ3q9Pc4dfaXz0zVWSA0vwPhKJK+5wmB0/i6pDpHHuqVq8Nq5Tt86q+PRSWRtQqKtG29NJkivte34ss5WJ7Yz5ovHdTuJdbmWiMd388Kvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724323589; c=relaxed/simple;
	bh=BjCJ2f3C0Qm7+dwJ1Eu4/pVt4gO9Ij0T2x4Sc9HO9+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW1m9PUfEZpa3uMj20P5Pmp4MFxfG/xKVIQeOx277WQTyjoqR657JpQSjC0XX6Pqsc7Dekf/pf7GOoO1sZY/Sm2PbzNGxDpqpItkYHgLMxLaMHsFyKuYobQG2daFzWGfWi36hoSh0pSPUD/hdCavmJF//CTftxURbVEKcqAeYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9C9DA7;
	Thu, 22 Aug 2024 03:46:52 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14CDE3F66E;
	Thu, 22 Aug 2024 03:46:23 -0700 (PDT)
Date: Thu, 22 Aug 2024 11:46:21 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Message-ID: <ZscW_E33YXF8Nx7r@bogus>
References: <20240816224221.3256455-1-florian.fainelli@broadcom.com>
 <20240816224221.3256455-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816224221.3256455-3-florian.fainelli@broadcom.com>

Hi Florian,

Sorry for getting late to this party, I wasn't able to review this before.
Overall changes look correct. But my main concern is that is SCMI the right
place to have such IO accessors. It is better to run it through Arnd if
he is happy with it before I send him the pull request containing these.

On Fri, Aug 16, 2024 at 03:42:21PM -0700, Florian Fainelli wrote:
> Some shared memory areas might only support a certain access width,
> such as 32-bit, which memcpy_{from,to}_io() does not adhere to at least
> on ARM64 by making both 8-bit and 64-bit accesses to such memory.
>

Is this limitation on the hardware for both read and writes ?
The reason I ask is I see arm64 does have memcpy_toio_aligned() or
__iowrite32_copy_full() for 32 bit aligned writes.

-- 
Regards,
Sudeep

