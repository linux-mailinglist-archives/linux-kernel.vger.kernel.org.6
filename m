Return-Path: <linux-kernel+bounces-274798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C0947CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AB41F23469
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ED212EBCA;
	Mon,  5 Aug 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEorueC7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972739FE5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868258; cv=none; b=OODJO4k9ynCN7/qi03KLOnTqP4SRI0/TU6JautJa0Q/Rr3Chmvo6lUJs+KNa2KedGNj8XwU6S/E19ntsZDFlHxF4z/kSv3bwQ4fPlwu8UELeUNDt870FhZj1ltJq88SsGS5oEL15gkRbeP+AQIp0msA/LxUa99J+A/fMGkKDE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868258; c=relaxed/simple;
	bh=C/7sQovbNSh3gKEW2EqyFjkIz9Q38h2okXnr6MrPQ5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8xndv0UFfdKP2UnUxwwALEuTOJCdug5I+A9q3ztK+4avCrmLAmXDSxZJOtk6klxoqbFcHFP3u89B2ROSbhkFtNP5EPxhni9tnI6H71SDprs32NWIrrKYtd/k3uzTXfkzhqop0JxjQNTu4SNvwG12/+CSpa2WVHnq53+l0bpC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEorueC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBD3C32782;
	Mon,  5 Aug 2024 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722868257;
	bh=C/7sQovbNSh3gKEW2EqyFjkIz9Q38h2okXnr6MrPQ5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rEorueC7Iu8prd31Skyhb0S97r97VpIUiFQTysHATPk4lnlMleJnoLppPAWJShSJA
	 ihkKUdANndZrC8LtZ9ZIY/4RoF/01q8hUgb/8ZqXMLpq4N9y6sNc11RJjks0g5NSN5
	 7gj1rM1poWv6LJflnmuddXwsukI/2Hd0TqBlDAizCdd/FUJe75IB4b1g8gGmvgABdX
	 9CnSxLWbNoyfv/5e5+YKcLLkqoipAyTqrieE5xCH/HJ4j5FsotIYpmCPE9lUYF5gE9
	 YDJ+6xYAiRRhdAxQLA23Wy8RB0sJ5+GJCYo7rSfEwySddDhWcPJ5TTejdFaJngeYbo
	 rl13JrR5gI8Xw==
Date: Mon, 5 Aug 2024 16:30:55 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 14/20] mm: Allocate kcompactd on its node
Message-ID: <ZrDiH3bLxCKsVQkc@localhost.localdomain>
References: <20240726215701.19459-1-frederic@kernel.org>
 <20240726215701.19459-15-frederic@kernel.org>
 <a3693b53-8c5b-4c8c-a02a-8873771bdfd2@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3693b53-8c5b-4c8c-a02a-8873771bdfd2@suse.cz>

Le Wed, Jul 31, 2024 at 05:07:48PM +0200, Vlastimil Babka a écrit :
> On 7/26/24 11:56 PM, Frederic Weisbecker wrote:
> > kcompactd runs preferrably on a specific node. Allocate its task
> > structure accordingly for better memory locality.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> could even squash it to previous patch since you touch that line anyway and
> it should be a no-brainer

It looks like a no brainer indeed but I'm very careful about introducing subtle
logical changes ;-)

Thanks.

