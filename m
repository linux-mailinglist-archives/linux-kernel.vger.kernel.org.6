Return-Path: <linux-kernel+bounces-361232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992199A55C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E04C1C21BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A1218D99;
	Fri, 11 Oct 2024 13:47:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D1C8F5E;
	Fri, 11 Oct 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654435; cv=none; b=hCKIjZCcYluOykxGy/byU1cxI5gotFHAUDaOsdZkGn0WNR/UQG//9pbQx1I3HhU+8CO+nO+PPPZbJ9cwsz/+YxQTHFBm8cmyCBh6Bm9HpdWdyLYqcI/FLBm6f+ATZYMKQZlvP3+Nmy4ZFKlFmIvnpaUBY1EbNAGBNQ86/RzAtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654435; c=relaxed/simple;
	bh=4hWK7owCdQ8AZEtitrIBPKLbtijxQ0BNhtAY2CySHqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6k+YgeaLWmMQqmMPl/RVBYat/hNUw0gK2/wAjagAh9lIp+2c8dP0qkO9cP8OxlU4wz3AJE0b8pNapKoClZe/zV8/j6S+KhWtBq5xX5jCvJ5Mer4v/OHB+unisjsdN90TIJkyDr/RUCowHz/YdI9DBln7VzccoscwoipBmRM/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B45E2497;
	Fri, 11 Oct 2024 06:47:42 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82FF23F5A1;
	Fri, 11 Oct 2024 06:47:10 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:47:07 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infreadead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	"moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <linux-arm-kernel@lists.infradead.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] firmware: arm_scmi: Give SMC transport precedence
 over mailbox
Message-ID: <ZwksW2q6-wrY_tKZ@pluto>
References: <20241007235413.507860-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007235413.507860-1-florian.fainelli@broadcom.com>

On Mon, Oct 07, 2024 at 04:54:13PM -0700, Florian Fainelli wrote:
> Broadcom STB platforms have for historical reasons included both
> "arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node compatible
> string, in that order.
> 
> After the commit cited in the Fixes tag and with a kernel configuration
> that enables both the SMC and the Mailbox transports, we would probe
> the mailbox transport, but fail to complete since we would not have a
> mailbox driver available. With each SCMI transport being a platform
> driver with its own set of compatible strings to match, rather than an
> unique platform driver entry point, we no longer match from most
> specific to least specific. There is also no simple way for the mailbox
> driver to return -ENODEV and let another platform driver attempt
> probing. This leads to a platform with no SCMI provider, therefore all
> drivers depending upon SCMI resources are put on deferred probe forever.
> 
> By keeping the SMC transport objects linked first, we can let the
> platform driver match the compatible string and probe successfully with
> no adverse effects on platforms using the mailbox transport.
> 
> Fixes: b53515fa177c ("firmware: arm_scmi: Make MBOX transport a standalone driver")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

I was hoping to find some way to avoid this workaround....
...but I failed :P ... so

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

