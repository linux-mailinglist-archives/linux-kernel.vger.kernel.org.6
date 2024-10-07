Return-Path: <linux-kernel+bounces-353357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E7992CCA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A52282FA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA91D359E;
	Mon,  7 Oct 2024 13:13:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0913818C015;
	Mon,  7 Oct 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306833; cv=none; b=Wtcqw/othZ3scOqp3yEzOeXnbnxZV+tHLA1/8s4v8ykQ+8V0DIPr8GVF0jYHWbQOX9688ug9BMZLBBWXWASuICA9ljj8v6uTOgNFzJlqbY92U7RP8aPM1Lw8dkkH2SfWjri9a7rAIW/XVS+QS6Z/gsEZk6U2PLmajaLEv/8PR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306833; c=relaxed/simple;
	bh=ObfpsJxhlhUPGfb20+r5FkrK8XmgkHEAeNMGnFYXuHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaWLGDOx8w7rlCppzZ4oylgu3990X1yBofCrOHeCqEHP18/E7RC84ESspTBgTk4f10MXinhZQ4NUZrzQv+qHGvQOOhQ/OQJWwCfKuC1FUn1uW54cYHDB3qcpHctpm0dlrcQyY5fM6jpZp60sT2d5dVzeVA/yTylSmxBM96orCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E12D2DA7;
	Mon,  7 Oct 2024 06:14:19 -0700 (PDT)
Received: from bogus (unknown [10.1.196.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1622D3F640;
	Mon,  7 Oct 2024 06:13:47 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:13:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infread.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	linux-arm-kernel@lists.infradead.org (moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] firmware: arm_scmi: Give SMC transport precedence over
 mailbox
Message-ID: <ZwPeiUwT7OAgxXFl@bogus>
References: <20241006043317.3867421-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006043317.3867421-1-florian.fainelli@broadcom.com>

On Sat, Oct 05, 2024 at 09:33:17PM -0700, Florian Fainelli wrote:
> Broadcom STB platforms have for historical reasons included both
> "arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node compatible
> string.
>

I assume in the same order.

> After the commit cited in the Fixes tag and with a kernel
> configuration that enables both the SCMI and the Mailbox transports, we

^^^^^ s/SCMI/SMC ?

> would probe the mailbox transport, but fail to complete since we would
> not have a mailbox driver available.
>

I always assumed the node compatible match happens from the more specific
compatible(on the left) to the more generic ones(on the right) from the
compatible property list. Looks like that was a wrong assumption then ?

> By keeping the SMC transport objects linked first, we can let the
> platform driver, match the compatible string and probe successfully with
> no adverse effects on platforms using the mailbox transport.
>

I don't have strong objection to the patch itself, happy to get it merged.
Just curious if my understanding of the issue is correct. I think Cristian
has more detailed query, so just responding to that will suffice.

> Fixes: b53515fa177c ("firmware: arm_scmi: Make MBOX transport a standalone driver")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: I8e348e3e0deabdc5c1d596929d7f9134793f346e

Spurious from internal gerrit repo ?

--
Regards,
Sudeep

