Return-Path: <linux-kernel+bounces-355244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BA7994DEE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117C01F2207D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADB81DEFE6;
	Tue,  8 Oct 2024 13:10:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AC1C9DDF;
	Tue,  8 Oct 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393057; cv=none; b=dtNzHaDeFhZSO6KvTfUS83kfmBRwXqgAf1cFE8yQ7pbsaQOw+tlf70IJhHeDEtLh9/NeNRzhxrZyx8iTDZ9jv+kpQjYUKXAn4Sd65Y2F1ab+o9eIDEMI5z3BXJnicCZGDyfE7YgPML8ZFsbOQcaJr1T38R5726a5CXNwuQ41m48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393057; c=relaxed/simple;
	bh=2s8dV9YOqtVti5t7YCAWcy0ZoMDL0K8qWHAHfPmPQ6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZpHSIU5Cz4mWz3I7V00bw+VFWs9y2nFZ05P1SwrAoMjR07U1M91ETiOX6E6nPK4xHzOu+6wT7nw1NfAVH+2/FImUcGJ83ebVOu3vlhFNVo4xquack+f8P5f0hs0Ws4n+uLiU8Lg1B2tLlLyOfgKeJEPRQs/RiZTNJ4olUw61sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D983FDA7;
	Tue,  8 Oct 2024 06:11:21 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.77])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A8DE3F640;
	Tue,  8 Oct 2024 06:10:49 -0700 (PDT)
Date: Tue, 8 Oct 2024 14:10:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-arm-kernel@lists.infread.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	"moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <linux-arm-kernel@lists.infradead.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] firmware: arm_scmi: Give SMC transport precedence over
 mailbox
Message-ID: <ZwUvV-w05UpQroRk@bogus>
References: <20241006043317.3867421-1-florian.fainelli@broadcom.com>
 <ZwPLgcGeUcFPvjcz@pluto>
 <a4f403e8-44eb-4fb4-8696-ca8ad7962a00@broadcom.com>
 <ZwUlDT_YupBSZjMJ@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUlDT_YupBSZjMJ@pluto>

On Tue, Oct 08, 2024 at 01:26:53PM +0100, Cristian Marussi wrote:
> On Mon, Oct 07, 2024 at 10:07:46AM -0700, Florian Fainelli wrote:

[...]

> > There is no recovery without the patch, we are not giving up the arm_scmi
> > platform device because there is no mechanism to return -ENODEV and allow
> > any of the subsequent transport drivers enabled to attempt to take over the
> > platform device and probe it again.
> >
>
> Ok...so it is a workaround hack indeed....but it seems NOT to have bad
> side effects and there is definitely no cleaner way to make it bind
> properly...beside fixing your DTs for the future...

As I mentioned earlier, I am not against the change as it doesn't have
any other side-effects and just accidentally fixes the issue you have.
But it does sound like a hacky solution to your problem. What if some
other legit reason(theoretically) it needs to be reversed again in the
future. So I am still interested to see if we can fix it without this.

--
Regards,
Sudeep

