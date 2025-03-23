Return-Path: <linux-kernel+bounces-572851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630D2A6CF62
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 14:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811C61893928
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA4EADA;
	Sun, 23 Mar 2025 13:04:45 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A2647;
	Sun, 23 Mar 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742735084; cv=none; b=M6F0GOj8mlQYtQkCLHJZ61uLCpWBLBuVe4TSLuYGyBoRDMLLWOs7pyGBYXKLSLwjR2SAFjNAMAfPvbHY40P8UwNeaEvjmP5XM0IyAzjw3YWZ/spJQpAIPs2aITWAVK4u8F8glsFFhyEcSyTGH3CJa+RB+M84pVEqm/lX8IXrgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742735084; c=relaxed/simple;
	bh=Eu9OtonUOTWmJCZeFbbSPfhEvx93eCQIyJoYaBByPhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDzG5l+6Sv0ZvKWlkv4m7QLsXGlJnWgkqVfG7HSWk/CkeYUrYsFpgl0RhMEYYpKhp53Is8Pkwx6i9D6ibrI7P8QhmeN4WLV8D8uFnNn0GSrj/xZ6VWW5OXgRuwbLTuJFRV+DIcLTO+UBj98xNbgrZzQ472BxMuzoCc+D0w4jTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 42A01343513;
	Sun, 23 Mar 2025 13:04:41 +0000 (UTC)
Date: Sun, 23 Mar 2025 13:04:30 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/7] clk: spacemit: define struct k1_ccu_data
Message-ID: <20250323130430-GYB15267@gentoo>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-3-elder@riscstar.com>
 <20250322155034-GYB11633@gentoo>
 <45526855-17b2-4de4-8e12-6320b7d84c8e@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45526855-17b2-4de4-8e12-6320b7d84c8e@riscstar.com>

On 07:43 Sun 23 Mar     , Alex Elder wrote:
> On 3/22/25 10:50 AM, Yixun Lan wrote:
> > Hi Alex:
> > 
> > this patch change relate to clock only, so how about let's fold
> > it into clk patches (which now has not been merged), so we make
> > the code right at first place? cause some moving around and renaming
> 
> No I don't want to do that.
> 
> The clock patches are Haylen's and the are getting closer to
> acceptance.  Let's not confuse things by adding a bunch of new
> functionality.  Get those patches in, and mine can follow not
> too long after that.
> 

I only mean patch [2/7], not all patches, as it's still clock related
but, either way fine by me if you insist

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

