Return-Path: <linux-kernel+bounces-525020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC36BA3E9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 02:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3FA1895239
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474961465BA;
	Fri, 21 Feb 2025 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ytz5Y/va"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099638F9C;
	Fri, 21 Feb 2025 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101052; cv=none; b=NTnrjUYAJL79HsfLvDheQ7jACXvIAWLRiMKRN97OR3mDP7F75/sdx+4qRlXDvZckyAwLwXzDscHFh+VbzYBkFIyqJpbVKBN5nczunG/F1IVwOJmDdYfLFrOl3ZDlL9pYg0MfX0TlLhyvtQ6trZITmSXGU6SdVLit0otcFddyhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101052; c=relaxed/simple;
	bh=hqZKFDLTOMrzQKtspknBKj50AVQN8SLJSCfgLLS1bhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK87QbCuhmM1Ux1lvtLNHaSsYNuzQHP1vRrKCUelYnKAGFAO/PBWosf/Xd8c3OC7+AOv7HAd/FOHD/D/ogxBvNR2SI42U9UiFcyvYfDeNJWePULiEDrRZWfv2LVjZLglfmTLM8cxqlInNHWM/3HrRVB5+fy/iHBMC6wno6KnBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ytz5Y/va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E6BC4CED1;
	Fri, 21 Feb 2025 01:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740101052;
	bh=hqZKFDLTOMrzQKtspknBKj50AVQN8SLJSCfgLLS1bhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ytz5Y/vaKiaWJWtkOz5WPtfXI3knJ7sGHTkebOBBaLTdJ/kuHdOtMY5GR6BuGW7lq
	 f0rHGa299dbPrjPdl+kvFWN1leqgr4vmeGXpkBkNWngY8ZfG8Wl9rqFTSYZ/oPiSU/
	 i0GerMOy9hcDybtOisT1pVPNZjD0VhQ0qRtdlbMdhAWMezRQ+fVAqyYA7zvtXBE2CA
	 ckj1RuYI95Q22GCf1P7izCJ1QU4JOim8nzyJNtnlNUMXfS1lFvZCWbtw5TgapCzU4B
	 ui2vpZM08BV3C6hx1xpwCfnKvVGwDoxUSzO7Q7qW7Xd5wkE56Qk9owcT1F6JjCJFLJ
	 lspqA357FcTnQ==
Date: Thu, 20 Feb 2025 17:24:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, <lokeshvutla@ti.com>,
 <vigneshr@ti.com>, <javier.carrasco.cruz@gmail.com>,
 <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
 <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
 <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net v2 0/2] Fixes for perout configuration in IEP driver
Message-ID: <20250220172410.025b96d6@kernel.org>
In-Reply-To: <415f755d-18a6-4c81-a1a7-b75d54a5886a@intel.com>
References: <20250219062701.995955-1-m-malladi@ti.com>
	<415f755d-18a6-4c81-a1a7-b75d54a5886a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 15:37:16 -0800 Jacob Keller wrote:
> On 2/18/2025 10:26 PM, Meghana Malladi wrote:
> > IEP driver supports both pps and perout signal generation using testptp
> > application. Currently the driver is missing to incorporate the perout
> > signal configuration. This series introduces fixes in the driver to
> > configure perout signal based on the arguments passed by the perout
> > request.
> >   
> 
> This could be interpreted as a feature implementation rather than a fix.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Agreed, ideally we should get a patch for net which rejects
all currently (as in - in Linus's tree) unsupported settings.
That would be a fix.

Then once that's merged add support for the new settings in net-next.

Hope that makes sense?
-- 
pw-bot: cr

