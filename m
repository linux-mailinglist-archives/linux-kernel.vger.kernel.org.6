Return-Path: <linux-kernel+bounces-313280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61096A30E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BAB1F2A1BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD18188A01;
	Tue,  3 Sep 2024 15:40:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6643718891A;
	Tue,  3 Sep 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378018; cv=none; b=Z1/RyOapRzQw09V1SBfCUiktU1gIq4P8WuBxOTROalevcnFViy0JmZvGtrIWDnbhdBwhnfjld0vBQcmGyLGB+qjnj+U9k5N6A273PrrBUW1YxZUj/f2L1r/4BLbZ2giiPZbeFKkX2TW9XZXV7O27VM0AMFwnFZA/XBQ6TweAZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378018; c=relaxed/simple;
	bh=XdgZeiDfpysWm9lWTgXqvjatGdoyBFeI3d1tG17BlSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgDGWY/roHEfdUu/IaTXKzopfsy84C3IFf98Yq3csnsjj3ktg9bOO9rJc71dh5vgUnEK0tZY5/KqD0B7xhWRBrD1QCugw+xNyyAKux+/JKawgvvR8otDydncLX1xXBI1gYG+thKS8dQyC8/MaauaI43lLPnmKQdK/cLF0aMB0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A13FFEC;
	Tue,  3 Sep 2024 08:40:43 -0700 (PDT)
Received: from bogus (unknown [10.57.81.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B479C3F66E;
	Tue,  3 Sep 2024 08:40:14 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:40:00 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE" <arm-scmi@vger.kernel.org>,
	justin.chen@broadcom.com, opendmb@gmail.com,
	kapil.hali@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
Message-ID: <20240903154000.GA2080277@bogus>
References: <20240827182450.3608307-1-florian.fainelli@broadcom.com>
 <20240827182450.3608307-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827182450.3608307-3-florian.fainelli@broadcom.com>

On Tue, Aug 27, 2024 at 11:24:50AM -0700, Florian Fainelli wrote:
> Some shared memory areas might only support a certain access width,
> such as 32-bit, which memcpy_{from,to}_io() does not adhere to at least
> on ARM64 by making both 8-bit and 64-bit accesses to such memory.
>
> Update the shmem layer to support reading from and writing to such
> shared memory area using the specified I/O width in the Device Tree. The
> various transport layers making use of the shmem.c code are updated
> accordingly to pass the I/O accessors that they store.
>

This looks good to me now, much simpler. I will push this to -next soon,
but it won't be for v6.12. I have already sent PR for that. I want this
to be in -next for longer just to see if anyone has any comments and
doesn't break any platform(which it shouldn't anyways).

Just hoping if anyone looks at it and have feedback once it is in -next.
I will apply formally at v6.12-rc1 and report back if no one complains
until then.

--
Regards,
Sudeep

