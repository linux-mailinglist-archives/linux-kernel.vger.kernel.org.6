Return-Path: <linux-kernel+bounces-266583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C619401E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209D1283405
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11C1366;
	Tue, 30 Jul 2024 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYvWbHC7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2A645;
	Tue, 30 Jul 2024 00:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722298553; cv=none; b=bXWxzwaoj35Eu9cLLjSakQCUiKZKRiOBYuA3xwn3/2U5HjjX7X0dUglNjsGByIJ++NWZUSZj8+jJWTiF8W9gOu2DEyXLXKTasYCbikiCbErOYnmj5Pwoya9GgFSjE47eflpYLKHTcIQ7dLx+CGzMdQOAEzT8WkG+QIpzboNwUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722298553; c=relaxed/simple;
	bh=NTwNBco3xInbHZS3PYpxcvKQj5iVvkHsKXNLi+R2DGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNbZ57pWsePR49iq+iEcLtMiizQ4+VDPCh/FIGIFlQaO9deKgFfbi51dX2EiV30GyEwHeSYNN2GTdPnHsYuf12RKlpcQfyPwboEYlF12PpArjrSr2Ltz1woUlAuHBt9OnALbjgNVxmzITRlfoRD/W7hHQ5w9BDk2YBAi2g3ER8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYvWbHC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE017C32786;
	Tue, 30 Jul 2024 00:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722298552;
	bh=NTwNBco3xInbHZS3PYpxcvKQj5iVvkHsKXNLi+R2DGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYvWbHC7YxZdSWRodeJu2Oo9zcZ1k9v7rZOtOxjrKZDhcPhMz7LZNjhpA1Kb4Go/C
	 tmxvofg52FwW10DTneIkDl5AaNQ6DCzKL22Sts/jhCwZJcHDf2FQLjR2dcXjl3SqZG
	 OS2dnMfLplEZIWe9x+Edzp79YdJXMDu5S1s++rQ2NWfPgFxieaHigfi2bC9cLwIwZL
	 cY0LHXcE0/IbiJxeXVTJzLbUoJbsQ8i7QmWL7TEdS5dVPMVfYpMbuPtYUQmzCF0fcW
	 J0W9acZzmtD4DoCqFjUcSW/tV3Qo8lg4Qg86zogo23qNG84lVQuDSeClfST9ZkBTNR
	 0i27KweXE9Hcg==
Date: Mon, 29 Jul 2024 17:15:52 -0700
From: Kees Cook <kees@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35918: randomize_kstack: Improve entropy diffusion
Message-ID: <202407291715.017E39A4C@keescook>
References: <2024051912-CVE-2024-35918-3fed@gregkh>
 <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja>
 <2024072606-outlet-stuffy-259b@gregkh>
 <D4CED3E9-5E5F-4E94-AB59-3EA617213DA1@kernel.org>
 <2024072746-ample-sponsor-bef6@gregkh>
 <u7iq6sax7trmasfpqqe5val5qr7d4odjokww3cxpav7mibgipn@fpxugdvez66s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <u7iq6sax7trmasfpqqe5val5qr7d4odjokww3cxpav7mibgipn@fpxugdvez66s>

On Mon, Jul 29, 2024 at 04:35:52PM +0200, Michal Koutný wrote:
> On Sat, Jul 27, 2024 at 09:34:18AM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > We assigned a CVE to 9c573cd313433 as it was implied by many that this
> > was "fixing a weakness" in the security feature in 39218ff4c625d.  If
> > this is not the case, then we can revoke this CVE.
> 
> If 9c573cd313433 (fixup) is fixing a weakness of too few bits in stack offset
> randomization, then 39218ff4c625d (feature) is fixing such a weakness too.
> 
> Or equivalently, if 39218ff4c625d is not fixing a weakness of too few
> bits in stack offset randomization, then 9c573cd313433 is not fixing it
> neither.
> 
> By this reasoning I'd be for stripping this CVE. Both patches would thus
> be equal. (As suggested by Kees.)
> (Also to avoid going into the rabbit hole of how many bits of
> randomization are enough.)

Yeah, I think it's best to have neither be a CVE.

-- 
Kees Cook

