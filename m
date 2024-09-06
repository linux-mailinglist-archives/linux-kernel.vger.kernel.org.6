Return-Path: <linux-kernel+bounces-319126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D25C96F80D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887111C21CA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823671D27AF;
	Fri,  6 Sep 2024 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gYAYxQwu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48151D1756
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635843; cv=none; b=Oto+eJFDRvNKlgaZefNzbzX35bj11FsRq7rHgkbR8+4sHdNUFbwT8Bp7JWJChN3XnGv97D7RAMHk2sOXRdGLHnrQxfOjjqTshCZUSPtusDId1fI4kxxQ5dxQQKIgpV8QLXqFmw0RkA4i17mLSq86NktbQfz+JLPdKXTq7qt+O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635843; c=relaxed/simple;
	bh=wtbeWJ4oRhe8S5tQH8iXzJ+NJYHniqyTR5KaXMZFioY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M76/UX6uGD7ZmFhi94hicQYyGHcmKtSokD/usP7UDY1w9yEKZgPRrw2ROI+zI0wv3xcAJ7LwR7rObchI2SqSgBdp0EEwX3BIobCr2mmD8B7rRRoMiFgiVgQUWI1eg9Qq+tWabt/Iv8PQG6dHT2hCg5x9ShXcZyA7AbSwO0yQr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gYAYxQwu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ABPkkZCq5Y+kMmkr2td0P/7bCpHOvoPFWkbKXV2GW7M=; b=gYAYxQwupYTWByCSvjAEQt/X0V
	zqhDvCaWHnBf56yo1QJ68roOx4JizlZIV5DuXdy9ERQXCzMbZ47CIdS8AQ6Kila5AL9zvQ2xuc7Ta
	x/w0/7XgtbObD/qq8PiiuGRqzuXJU8aTRi7XZpetGyYPI1gIkjRTrIRml05AjflLYEhITTEx496ma
	UtfaYK5TMF1BdmTlW6Eu2/6ph6z8cgswA+1/tEDe0uNRbZP8+80hLQIyf45TDgJc6ChLtJ8spW0Id
	Y+6FmqqXzoGwoUW2KnGuXcw8ekL5rMRdw5Q+LuFe1RQslqhmgD7fEmohpH53/iXXq9vRZdXscOzM/
	tfYHJSHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smai4-00000000grj-2KCc;
	Fri, 06 Sep 2024 15:17:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 34C17300642; Fri,  6 Sep 2024 17:17:16 +0200 (CEST)
Date: Fri, 6 Sep 2024 17:17:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Generic hotplug support for a PMU with a scope
Message-ID: <20240906151716.GZ4723@noisy.programming.kicks-ass.net>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <b97ab074-3889-47ae-a66f-46a2f8a99005@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b97ab074-3889-47ae-a66f-46a2f8a99005@linux.intel.com>

On Wed, Sep 04, 2024 at 08:44:47AM -0400, Liang, Kan wrote:
> Hi Peter,
> 
> Gentle ping.
> 
> The patch set provides a generic hotplug support to facilitate various
> specific PMU drivers. Could you please take a look?

Seems nice, still applied, so I've queued it up for the robots to pass
judgement.

