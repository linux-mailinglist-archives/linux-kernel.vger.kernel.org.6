Return-Path: <linux-kernel+bounces-397372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933E9BDB21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395851F23091
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73441188920;
	Wed,  6 Nov 2024 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpzHXRfG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DC10E5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856320; cv=none; b=t5eSM2Q8ogqgJibD6IT8atwDMbLgv+sIw/WXMQ95JFlJ370I63/bcqkzbEpDb0Lt458OG7DYYZW9m4n1LoUZX5Bi8odSvfETBY7aTTgArZg2PVfBT0r+r6a/cnR0EsaFCRIWniXVEj3TY3EZ7b5hTSA34iu2DlIWSEM3zyhtgqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856320; c=relaxed/simple;
	bh=fT8AtDv5DwsgoMU0PRZNf3pRIW6L8xNWRJUpZn+xEKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+tIP8HGa7s6xAsCHind78MocLg71r1O2XKJN2BrGpyjozyGASiWZjrf19FD4Ag1IB8SiOWYyNfvSPMeHI9hpjkx+U07NPC4ldVSjrfB85D0HeGWYfH7Krr7nKUrtBODwdSTvwCVjrfAhYSM5KNx9WzhpYEPIj0fo2DO9BrqXPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpzHXRfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F496C4CECF;
	Wed,  6 Nov 2024 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730856320;
	bh=fT8AtDv5DwsgoMU0PRZNf3pRIW6L8xNWRJUpZn+xEKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IpzHXRfGwVugLXj/VOnjcQe0yhzOmLoiYTPX7sN3RHu+OOg4Im+/UstARvk1OJudP
	 mHpofW8EbXwXgOEtB7gWieOSeVRyh4XUBMGsuuACRD9494FZ4oAkUqldBoDbF42OR6
	 WCyZvdVlGzgAp3O8na1T4MygAwSIFw+fGiJK71HLHzdVKLlxRy0SZ9QOLmgvr4CTHb
	 ImlXjfOm/U2RZVOohDtQTK6gQAgDqNbpZq/W41IJHjmO5rqx3I8YX4IfdwUUB/UIiF
	 xF7Ok//aLwxWMVPVICzibNWkcGReFtDD1dwp5S4lmcrmc5vJ3nkOfzwPFKoiBeEjQk
	 NbIHbJ6fek+vw==
Date: Tue, 5 Nov 2024 15:25:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <ZyrFfzLEFDjOTAHB@slm.duckdns.org>
References: <20241031073401.13034-1-arighi@nvidia.com>
 <Zyqq9fnsOg56aO7S@slm.duckdns.org>
 <Zyq4VFpbaKXERdDh@gpd3>
 <Zyq5cX9fLE-3wZSx@slm.duckdns.org>
 <ZyrBcDvFVtSFPhvG@gpd3>
 <ZyrDTzVSQtNBcZ-x@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyrDTzVSQtNBcZ-x@slm.duckdns.org>

On Tue, Nov 05, 2024 at 03:15:59PM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Wed, Nov 06, 2024 at 02:08:00AM +0100, Andrea Righi wrote:
> ...
> > I think this is only possible in a virtualized environment, in this case
> > LLC should be disabled and NUMA enabled. Maybe it's worth checking also
> > for the case where LLC > NUMA...
> 
> I think the current code is okay. It just needs a short comment explaining
> why it's so. A cleaner alternative may be walking the llc sd's and verify
> whether any two llcs share the same node sd as an ancestor.

Or maybe just compare the total number of LLC sd's and NUMA sd's.

Thanks.

-- 
tejun

