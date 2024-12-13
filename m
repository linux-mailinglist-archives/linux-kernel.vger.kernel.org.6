Return-Path: <linux-kernel+bounces-444723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF179F0B95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39977161C08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0F01DE3BD;
	Fri, 13 Dec 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga6vJJy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7804A21
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090385; cv=none; b=Om69BYdLRYDcgQj+LS8raUqRDL1aq7BoUCrW55SbX3nvptbvGw1USgHpH/6SNzlQgTf66DlAJ9f0e3x9zegxb7lNp6oaN6xY5F533mZogszVU4kHczZUbFYkG96EbIkZCAOHzzgyarOxZvukSGOcKkJq2Mqn+SHLedyOXICi1Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090385; c=relaxed/simple;
	bh=1LJTjOx7kJx7q2mytF+grEPfxYG6mPmq7VZvVuE7Nzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvEEj+5HTqeBRNSb0CZ1fwi0EuJMmeWQUb3ins+5UVTiw8FpbDJwIdoMYzPyZAKwHxX5cRCVa2iEHAm2Y3rXMQO/yZKEFEJ/MRQUbxO8W98kTR0KWzZ3SoYPulU+pbFmS20MRbx5ypDYTUxM7I+EpypL5a5ucTSTb5FbQvFiFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ga6vJJy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D7FC4CED0;
	Fri, 13 Dec 2024 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734090385;
	bh=1LJTjOx7kJx7q2mytF+grEPfxYG6mPmq7VZvVuE7Nzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ga6vJJy9Plt8rk1ZLRU0bSPuEEIFFP2NqMZ14P/0k78uOtrRzmJT9MR3QaA9haWSo
	 gUUXUPwAVnTYsPGiYkA8V6YjKyalKDhOIvkczNBD7KGwWGv5g/x5BbfXbRRSQszI1F
	 geoEG7xNXHypBybJOy49Thqk+6h/zux7VvR6IQLOuw+v1AE04G3zspHzqdrs2SDTka
	 PQ27MD+bupU6M46eKS7qz5ZPI5RCCBdsyqdUqTdUZnpogDyaVmIE+2nAo8J6drEgWr
	 DmbcHUFGaBT9QaDX65+w0C6gw0Cd7jFb1R9C6I83DglShv8SVKS5sf6gh1rm0gSE0Y
	 y9+1nfDq9wnNg==
Date: Fri, 13 Dec 2024 12:46:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 06/19] soc/qman: test: Use kthread_run_on_cpu()
Message-ID: <Z1wejvFpGLFMhLJ9@localhost.localdomain>
References: <20241211154035.75565-1-frederic@kernel.org>
 <20241211154035.75565-7-frederic@kernel.org>
 <986fee5c-8537-498f-83ec-65a7c7c7a71c@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <986fee5c-8537-498f-83ec-65a7c7c7a71c@cs-soprasteria.com>

Le Fri, Dec 13, 2024 at 07:27:03AM +0000, LEROY Christophe a écrit :
> 
> 
> Le 11/12/2024 à 16:40, Frederic Weisbecker a écrit :
> > Use the proper API instead of open coding it.
> > 
> > However it looks like kthreads here could be replaced by the use of a
> > per-cpu workqueue instead.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Thanks! Feel free to apply this patch to your tree as it's a pretty
standalone change.

