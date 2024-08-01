Return-Path: <linux-kernel+bounces-271799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9080945357
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36353B26A9F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E8149C68;
	Thu,  1 Aug 2024 19:25:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109F148FF7;
	Thu,  1 Aug 2024 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540328; cv=none; b=B7Lgvtm3CRI4rE9zFSXx2J6N8CS4GrpAwVRMe01Km3ZnwwQRDNCDf7e+Nus2TZEXjIotc1WPzBhY6Yjl6ZZRKrhV2+nJnBbOn2cE6lrNJlRy4GgTjnTMNOknxEVFs9ZIIzchwAla45xWDQ2Ty2PricV5VjRpDNnwlxNfApEigoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540328; c=relaxed/simple;
	bh=wpEyC2yS1w+ByM2ydXaWeT6bQKUiBfgu53MTQEfT68M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3wh8f3yi5aTW9S5gKfWCDFMgjJRKZAZr3p8uNpvbtKdE0xp0z2iXLSDmdrcHO8Pezeo8yfB79IrXtTFFcsqXbwqCm11wQDVyg0D8E0Gaanw5mVaJQj0r3hOzwctSB+sb50YUkFIwz94B38yZle8zVijM2VHMhvOO0jDRPxiq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A8CB1007;
	Thu,  1 Aug 2024 12:25:52 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 222F53F64C;
	Thu,  1 Aug 2024 12:25:24 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:25:21 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, ptosi@google.com, dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com, "Michael S . Tsirkin" <mst@redhat.com>,
	Igor Skalkin <igor.skalkin@opensynergy.com>,
	Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v3 8/9] firmware: arm_scmi: Make VirtIO transport a
 standalone driver
Message-ID: <ZqvhIeZYdsYPtgHV@pluto>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
 <20240730133318.1573765-9-cristian.marussi@arm.com>
 <08e07522-f1ec-4e2f-9b9d-e7129e1ad228@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e07522-f1ec-4e2f-9b9d-e7129e1ad228@kernel.org>

On Wed, Jul 31, 2024 at 08:11:21AM +0200, Krzysztof Kozlowski wrote:
> On 30/07/2024 15:33, Cristian Marussi wrote:
> > Make SCMI VirtIO transport a standalone driver that can be optionally
> > loaded as a module.
> > 
> 
> > -const struct scmi_desc scmi_virtio_desc = {
> > -	.transport_init = virtio_scmi_init,
> > -	.transport_exit = virtio_scmi_exit,
> > -	.ops = &scmi_virtio_ops,
> > -	/* for non-realtime virtio devices */
> > -	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
> > -	.max_msg = 0, /* overridden by virtio_get_max_msg() */
> > -	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
> > -	.atomic_enabled = IS_ENABLED(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE),
> > -};
> > +MODULE_ALIAS("scmi-transport-virtio");
> 
> Why do you need the alias being almost the same as module name?
> 

My bad, it was just to place some sort of alias...but not useful really.

Thanks for looking at this,
Cristian

