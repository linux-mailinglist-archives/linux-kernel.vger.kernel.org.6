Return-Path: <linux-kernel+bounces-237823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A97923E88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0CF1F25256
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549A71A0723;
	Tue,  2 Jul 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFYJZJYO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FED19DF60;
	Tue,  2 Jul 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925942; cv=none; b=JxmTJ6nTMg3hAzOHyU/xuWR7YvWk65b4CUqsfkFFf/9E+cV4/55z2jIFDfDDfEIxEHQ/DF8lIlDyQaGEd2ImUmvt8hpTybD8H8FpeiVui9lZ7w4q6A2biW560qJNEoztU3azlpPTfdPd3DAtu5oN4H9NljIzxRcXWMcWoR3n8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925942; c=relaxed/simple;
	bh=p+lBJAEBNcH6mzYX4tBdWs7yrDOUKpDqlewKL2RMD8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX9krxPfC4ly+xKkDD0yUJK6zgycdytFepSeyJPu3rjguD41+ydvZbM5ri2S7JBbsyan8jKtJt71I3NdG9GbfGEx4En7vG6r8ubvINTgTXmiSzv0dc+BkkQYnzGf1It7z4zYBEqdAFboNSY68uExYBDIc0Zqv8NQv06ZdAjV2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFYJZJYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578E7C116B1;
	Tue,  2 Jul 2024 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719925942;
	bh=p+lBJAEBNcH6mzYX4tBdWs7yrDOUKpDqlewKL2RMD8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFYJZJYO3UR/3JWTw+bvTFiEj+fr6L7XT7a4jC19rbfuBFMi4S0T8fGsD+eSBjewI
	 K9a3ZEcwOQVT5Nsh+a0KgW+CY8TfpnUoiGva+XKt1StQdIDJTDzycabrADOekJil3E
	 8s5NbGjb6wVA/0pqtQtgT5dMzjiqaSqNDtzZFB1tdXm3mABF1tvoAMLVmyKIDVXHJv
	 hKmuH4M52gqxev+CuvLb5yARGsQDUp+sNun3kWzjd6f8LDobhUbClixczDpp/4J4yr
	 fz98pu/Jf5Icaaql8W7xvXXHYRoVyonMczAS4BAr92Hhjdm5vE/ckI9RMEdwhtzsdp
	 F6Zt8yZQ8Cwtg==
Date: Tue, 2 Jul 2024 18:42:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ma Ke <make24@iscas.ac.cn>, linux-phy@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Swapnil Jakhade <sjakhade@cadence.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: cadence-torrent: Check return value on register read
Message-ID: <ZoP8seqQxMFb-kS2@matsya>
References: <20240702032042.3993031-1-make24@iscas.ac.cn>
 <def496b0-ea98-467c-be47-77d965bb3a88@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def496b0-ea98-467c-be47-77d965bb3a88@web.de>

On 02-07-24, 09:43, Markus Elfring wrote:
> > cdns_torrent_dp_set_power_state() does not consider that ret might be
> > overwritten. Add return value check of regmap_read_poll_timeout() after
> > register read in cdns_torrent_dp_set_power_state().
> 
> I suggest to improve such a change description another bit.
> 
> 1. A return value is stored in the mentioned local variable.
> 
> 2. Unfortunately, it was not immediately checked.
> 
>    * https://cwe.mitre.org/data/definitions/252.html
> 
>    * https://wiki.sei.cmu.edu/confluence/display/c/EXP12-C.+Do+not+ignore+values+returned+by+functions
> 
> 3. How do you think about to avoid a repeated reference to a function name?


<form letter>
Feel free to ignore all comments from Markus, regardless whether the
suggestion is reasonable or not. This person is banned from LKML and
several maintainers ignore Markus' feedback, because it is just a waste
of time.
</form letter>

-- 
~Vinod

