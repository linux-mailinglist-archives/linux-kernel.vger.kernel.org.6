Return-Path: <linux-kernel+bounces-518983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407DBA396AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A55163A42
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFC22FF2F;
	Tue, 18 Feb 2025 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjVsgUK5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986122AE42
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870064; cv=none; b=frdtgLDZ44i4A+qI94ZUKHRynj9TZvDx9iTVVMNPv8FoXUeyBki2KiXI9FVufDiA0itsrcOWmIO351wIAaJgLR4hqoRYWyJvOrjP9Z3Q78N70fB9XofQ2/xRonUmwMNjz9VmqNvZBIKXWNNNmOjOaWRxVwp7Sw3mwKtqLuCBHDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870064; c=relaxed/simple;
	bh=fe956iKUjQC8faK5VpNA71rO2s6rnIr4A8CxWp20J4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jF3Y54a4LSchr8lpyqEgHr9HpGs2il91LbzSyGzfoEq0TX+37Oew7llxgAj5/inVmeg08dB4+lOcuvTlg/c1gd/oiu6lvt+OjX+Y6mYJdzKInzIX5KQAXVOOv+lwS9/KiMivqyPpRjrBj8SYTvGbdWRdo9+m8aY6os66RAFc0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjVsgUK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40261C4CEE6;
	Tue, 18 Feb 2025 09:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739870064;
	bh=fe956iKUjQC8faK5VpNA71rO2s6rnIr4A8CxWp20J4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjVsgUK5z8nMs9p2rlzvmCle0FdpAhziu3ido1cCz+fXcXndXTvpC+fzn86nOTAtp
	 03D2Uf6C67yP2WhPD/FekXHjHk0Ukn0M6h8IgBy/zH47QraAAqVCw2722tl6tXtnzI
	 /wQM7e7odk/S50TW2IgN91nPuc5TVFD3tJ6E9B0sSf190U3WPSE8MSbsyb8zJNgQNi
	 bS+ZCKfVrQlFLvb5r4ZIfTV0v+5Iuq8882D7MLm1z+k7n5QEApzghjm61Na79pRlIF
	 uV4QtHUYiySJH8ryxbiCxlssgx/XANo4vErhPfkztbv9/9S3rEFq/xJlQjlQTbrtWb
	 8/d7E1GdT5doQ==
Date: Tue, 18 Feb 2025 10:14:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH v6 07/15] x86/stackprotector/64: Convert to normal percpu
 variable
Message-ID: <Z7RPZ1UXTnjrdWqm@gmail.com>
References: <20250123190747.745588-1-brgerst@gmail.com>
 <20250123190747.745588-8-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123190747.745588-8-brgerst@gmail.com>


* Brian Gerst <brgerst@gmail.com> wrote:

> GCC 8.1 supports redefining where the canary is located, allowng it to
> become a normal percpu variable instead of at a fixed location.  This
> removes the contraint that the percpu section must be zero-based.

So there's two typos in this paragraph alone. Might be time to invest 
into an editor that does spellchecking for you?

 s/allowng
  /allowing

 s/contraint
  /constraint

Thanks,

	Ingo

