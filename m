Return-Path: <linux-kernel+bounces-197153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3048D66DB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D1A284C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C515B12C;
	Fri, 31 May 2024 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK6OZ4oS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DAC155CA1
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173085; cv=none; b=ixTgL6jJ4GZTIDvv/AiSR3wq1dQFJcnbhLZHTCFggGqPC5U0zC6xZT9z61PGDyR4rgb9kXYWmLAyY/YwTXzkUv4FNFJ/lQZxp19qTs2lJYW9YaHf/FqGXBdB496UxxU76VMuitrSnZBfJZci65qxDbMsBfVhyaXZyc4S4SQFp/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173085; c=relaxed/simple;
	bh=gW5+IhYIVTfSyyZzpp7Cg6cBbmiuzcL52EQEZY9WgeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUHy/KidZpr4suoh4xL9tdQrDUWvNmUIEspn+ut8DZN0+K445cLhOwcLz/sxVznMryR67rxctppyqhmfAzW4urKQdau/g1ICV3+sNqxF/UPjGT72uBSBNCjJ2vkXH9TVNujd4UESm1HpYGBUIxQ6Qas+yMv50hIJWYb1p08ja5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK6OZ4oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE5EC116B1;
	Fri, 31 May 2024 16:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717173085;
	bh=gW5+IhYIVTfSyyZzpp7Cg6cBbmiuzcL52EQEZY9WgeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VK6OZ4oSBr5tBWO+1LiZIbQAMIGGTSbML01M2Z4+76j3EO61SmHFWp2huE9n66PGR
	 BEDOS5DgW3HDvuTYUUbxVM23pspyry0vbU4oO0dg8eVvTY2fbS+QV15CdXnTG3fZAQ
	 JNAZ3uFHTW8eeK/jGmR8eiRGc70ULD+4qiA72rTyx5CTYdGDPkJHeBxKU9ib+hdhM2
	 UuvYr1bDWkKCLUduBGbnvbje559Ny0sy8/HTUhv1Crdwzn1J/ziLI6RNYit9o+RNTH
	 dGnDAgSdJPneiPW1K3PeI1JJAmMJxNhh2mAYy90jM8oA8DSTNswQZTM+byXJDps3XD
	 XWAoKzsVSa2pw==
Date: Fri, 31 May 2024 09:31:24 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc: Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: Current state of the sysctl constification effort
Message-ID: <202405310930.5E2728A@keescook>
References: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7823ff95-1490-4c1b-b489-a9c05adad645@t-8ch.de>

On Fri, May 31, 2024 at 12:50:32PM +0200, Thomas Weißschuh wrote:
> Hi Joel, Hi Luis,
> 
> most of the sysctl handler preparation patches have been picked up by
> the subsystem maintainers and are available in -next.
> 
> Only two are missing:
> 
> * utsname: constify ctl_table arguments of utility function [0]
> * sysctl: constify ctl_table arguments of utility function [1]
> 
> Both of them are going through the sysctl tree anyways.

This is great! Is the target v6.11 or v6.10 for these?

-Kees

> With this done it should be possible to also queue up 
> sysctl: treewide: constify the ctl_table argument of handlers [2]
> for the bots to chew on in -next.
> 
> My local builds are still succeeding on the last submitted version of
> the patch.
> 
> 
> Thomas
> 
> [0] https://lore.kernel.org/lkml/20240518-sysctl-const-handler-utsname-v1-1-27a6c8813620@weissschuh.net/
> [1] https://lore.kernel.org/lkml/20240513-jag-constfy_sysctl_proc_args-v1-1-bba870a480d5@samsung.com/
> [2] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-11-e0beccb836e2@weissschuh.net/

-- 
Kees Cook

