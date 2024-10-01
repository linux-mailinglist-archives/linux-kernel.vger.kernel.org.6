Return-Path: <linux-kernel+bounces-345862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F098BC14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07ED2848DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDEE1C2430;
	Tue,  1 Oct 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="w5jF6FpU"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DA1BE23E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785767; cv=none; b=HrJz10vJ8L1WXNvXugvQB86oUEDK+oMyyPotEBMxTNzVCjs2ZsfChKPuOjHG1upzrgs90h8k/zahSVhpZ4QAMgfMJoSNkFsmLrTFdcMGmTZQrQ3eyekcWXBILGuGW9hoKyezZii9eYQ64+DBGtUFNki2ESIv9CQvKXEef4iahvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785767; c=relaxed/simple;
	bh=9ANdWHOZO65EUhfKQbnCTdlxFLf3DYsPJzXln8axcx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvfmfLFxTX5YhZftw+v9sm2TB+cQI5+9dvJcw/lnTxl6MdKTo8G9rzZqfM0dCyxy5xTq9JkR2VVhpfa+5U/vuCWXI8R0nzZRk7h/WrOXz0pUZXLyWY0PLwJWGdyz8qkUHOlyBpK+dtySaZLR5oHDXvHGF2pbZfJH3o//nBw2UCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=w5jF6FpU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gandalf.ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1727785762;
	bh=IOL1yB3GdxoMW1HTyqHgDC/1e+UI3UkC8AeJmj3ulG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w5jF6FpUeD3Uv/SmBaCCk/0yfLWZrC/7JGscAdQiE0972b/QHeOY+2OyCJO0+xJi5
	 ew2UEKsWUss/rnbSqxDVA7pyW2VkvBiFRXZOXUSOADY/gLy0tZlIQkvZ5ASAA3HS30
	 LksshMlG8Ykge8YPVzPRPbsTMLan783zWSsFyys2gum4x8UFa2jxKbb8tW5GB3gETO
	 ibxrxaE+QZbAFtFx3FDeg98taWQaXCJqAOlBP5ZwCk9mCqJ0pMxO7vNl9wjTAoCpsQ
	 eYZuAxNXvhVEEoFTtWuXVL616rz/hfpFE+UwG5gxI6ekqEfygvh6Xj1wGi74mYhRSs
	 6FEbvaUvVh0wA==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4XHy1G1q3Dz4x4c; Tue,  1 Oct 2024 22:29:22 +1000 (AEST)
Date: Tue, 1 Oct 2024 22:29:18 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/sstep: Unexport analyze_instr,
 emulate_vsx_load, emulate_vsx_store
Message-ID: <ZvvrHpD-v4CuDqsm@cleo.paulus.ozlabs.org>
References: <8ecdbd907a8a92cbf9c7308df13f9d19f5ba5621.1727777273.git.msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ecdbd907a8a92cbf9c7308df13f9d19f5ba5621.1727777273.git.msuchanek@suse.de>

On Tue, Oct 01, 2024 at 12:08:47PM +0200, Michal Suchanek wrote:
> There is no modular user of analyze_instr, and the latter two are only
> used by sstep itself.

As far as I can see, analyze_instr is still used in
arch/powerpc/kvm/emulate_loadstore.c, and that can be included in a
module, e.g., when CONFIG_KVM_BOOK3S_64 = m.  Or am I missing
something?

Paul.

