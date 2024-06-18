Return-Path: <linux-kernel+bounces-219009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAFB90C8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E676CB26D82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399915921D;
	Tue, 18 Jun 2024 10:00:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE151AD494
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704821; cv=none; b=eJ0z5vGU50H3xqUSrYBICF8xsRK+Y/Gk/UzRtKM5SjwjCTM8uTJBxG7p5QRnxYT2UtXkDCudb2Dz9SHU7UOtWDLZZzJJM0liqKoJZdlWNBNCrDZW+AoceGBssifZqOiRC/lpLJB1XeUMy2m0vxNpc8cpX/kuI443ZCzgS629ZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704821; c=relaxed/simple;
	bh=JcZuvcawPm2fSn3ZHWQ+0tvcAkTS5tbg8MUqrnda4mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D18x3gzsRvLkxB6mOfu3o7U1qupPDntbWafT8kj83mtA0WCo8SE/U6Mj/l1lzlXzFu2wdrAAW2pZiGUrw/v7hYS4jspFfkp29iZjvhhA1hJTNj/pX9SZ5/ycJX0X98HsSoHuWvIIpldlOcdkwo2N8gJxxBi+E04/Y+gg4iAnS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 617F4DA7;
	Tue, 18 Jun 2024 03:00:43 -0700 (PDT)
Received: from bogus (unknown [10.57.89.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629F33F6A8;
	Tue, 18 Jun 2024 03:00:17 -0700 (PDT)
Date: Tue, 18 Jun 2024 11:00:16 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Youwan Wang <youwan@nfschina.com>
Cc: christophe.jaillet@wanadoo.fr, guohanjun@huawei.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, lenb@kernel.org
Subject: Re: [PATCH v2] ACPI /amba: Fix meaningless code for
 amba_register_dummy_clk()
Message-ID: <20240618100016.jmwqoe7aq5ttxjaz@bogus>
References: <20240617005044.246077-1-youwan@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617005044.246077-1-youwan@nfschina.com>

On Mon, Jun 17, 2024 at 08:50:44AM +0800, Youwan Wang wrote:
> Defining `amba_dummy_clk` as static is meaningless.
> 
> The amba_register_dummy_clk() function is static and
> is called during initialization. I think 'amba_dummy_clk'
> should be NULL each time when initializing
>

LGTM, can't figure why this was done like this. Looked at v4.6 when this
was introduced, still can't get a clue.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Please check and include all the maintainers correctly and repost this
patch with my ack. I don't understand how you chose the set of people
or list you have included here.

$ ./scripts/get_maintainer.pl -f drivers/acpi/arm64/amba.c

Also please include Catalin and Will who can pick up this patch and
route it through arm64 tree.

-- 
Regards,
Sudeep

