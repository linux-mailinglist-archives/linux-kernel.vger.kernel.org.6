Return-Path: <linux-kernel+bounces-199230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D348D8429
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A35281A77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB7412E1C2;
	Mon,  3 Jun 2024 13:39:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45012DD94
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421966; cv=none; b=hZPHsNY3McIIidVVWmvkDHhmcALLsKcDyr8Hx0+21uWA7MaIhZjL8uBQaIoFlvo1vAiDMo3ubcge9bVbwxZqC8ZGwtdxgf9I+V6V0MeBWybnB86FhUkssmVRuQZoJcOqNvvbHnFQ3/LTS0Yq49RL2FlIm9fXo/mD0qMkARBytts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421966; c=relaxed/simple;
	bh=OahMZUYoVHVoUKzOotRrQHjhatSUK3OGMQ0LIAqYYMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d91cmnI1I9bxBBVkyDAQZcpwi0a27AiFyQlg976X/PgXZz+BX8n8h6ClhQdkpOUDUWR9z7lPDQKZjlBWRQpLRVx0eQ33N1VeQa9ubwRkilZu5Qi6SHa0tteANMIG0AaluaxT+aKon109sVZbwWPMzDRVnX71vm8LQC4qjxWEmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D791042;
	Mon,  3 Jun 2024 06:39:47 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6538A3F64C;
	Mon,  3 Jun 2024 06:39:22 -0700 (PDT)
Date: Mon, 3 Jun 2024 14:39:20 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: ARM_MHU_V3 should depend on ARM64
Message-ID: <Zl3HiBX8ih6Sret6@bogus>
References: <e00498fccf6dcbcf63bd24a137bfc7abd1b98345.1716967720.git.geert+renesas@glider.be>
 <Zlb_txl4CqCfxWZz@pluto>
 <CAMuHMdUyW_RxfUaxnyWVzPsdXQWqCQbgZ+avHskinXkrSFqhtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUyW_RxfUaxnyWVzPsdXQWqCQbgZ+avHskinXkrSFqhtw@mail.gmail.com>

On Wed, May 29, 2024 at 01:36:42PM +0200, Geert Uytterhoeven wrote:
> Hi Cristian,
>
> On Wed, May 29, 2024 at 12:13 PM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> > On Wed, May 29, 2024 at 09:30:45AM +0200, Geert Uytterhoeven wrote:
> > > The ARM MHUv3 controller is only present on ARM64 SoCs.  Hence add a
> > > dependency on ARM64, to prevent asking the user about this driver when
> > > configuring a kernel for a different architecture than ARM64.
> >
> > the ARM64 dependency was dropped on purpose after a few iterations of
> > this series since, despite this being an ARM IP, it has really no technical
> > dependency on ARM arch, not even the usual one on ARM AMBA bus, being this a
> > platform driver, so it seemed an uneeded artificial restriction to impose...
> > ...having said that, surely my live testing were performed only on arm64 models
> > as of now.
>
> For that, we have COMPILE_TEST=y.
>
> > So, I am not saying that I am against this proposed fix but what is the
> > issue that is trying to solve, have you seen any compilation error ? or
> > is it just to avoid the user-prompting ?
>
> I did not see a compile error (I didn't enable it on any non-ARM
> platform).
>
> But it is rather futile to ask the user about (thousands of) drivers
> for hardware that cannot possibly be present on the system he is
> configuring a kernel for.

I am fine with this fix but I have seen quite opposite argument. That is
not to add dependency if it is not strictly required.

Also since you state that the fix is to avoid users of other archs being
posed with the question that they may get annoyed or can't answer, I
wonder if the right approach is to make this driver default "n" instead.

I don't know what is the right or preferred approach here. I am fine
either way.

--
Regards,
Sudeep

