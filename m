Return-Path: <linux-kernel+bounces-412090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93DC9D03C8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7054128774F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36971AF0D9;
	Sun, 17 Nov 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TfOshlQq"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263619ADBF
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731846338; cv=none; b=P/8n+O4rpowD/dG0u+yZkQ4vh3yepQLf/aSn5dpAeBvMFlLensFJQq97Jo2+gW9eXPaFAXj7MzBakhFn9aP3u6lBBOnj+kuTg+SMmuV4zYbUsslInjju84NR77aLlR99W+qVQu8kk6xGT2h7Io9wGY9IIdhMJfGZGnY65WNyPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731846338; c=relaxed/simple;
	bh=QQwwTiLK3wZNeeI9/yEyP08hQZvyCrpjg6ffIkYXVrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CtYBuuIsBWrhzC0fzqODlJOzqORkOwSYT3D9lYKdr5mcbrs8sl0pNwHRmwtF+64KobMn6RH1OKbhs2rjtnxoDMAY+BuHOWCICvGa0nEWpxZALskctdHYXPRXBUONFvbbAsDkU18OzofYgnv42Ai0VGM3UCDW3/HV3fMNgJm75IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TfOshlQq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731846333;
	bh=BPCvHt5zy1SV5b+ejHZjDE498sS62YWrSVug9774VSo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TfOshlQqU9L6ENwIq1azGYyCZD0tb1Tu6LCXV4AXOQRzTa8ZY4NBwMU27RvkczcJQ
	 rKbQnWC7wAMfGYuNuczp20EykRPkQGdnIgHfv+W8NyUpABrrzo9A2NpYQuR6+uiyO1
	 5uKBRXqZoM1xYSeyKQFSqg7GWHD5jgWWoBuiASGflCz1C2SuVdUU8P/H8FZuN+3WaC
	 0/YQ3NlDH7IerRfTax+frJYsPCvS+DudC5xfVlR2c4U4xMb0qZsbtczzlcy+oW+HiO
	 9o4M/ihLJgLSh4JT4hERUGdcQ9L2Oj0CMtwTl0DfVvzWof1LWcFSOg+i1R6gRlhdnA
	 TioyKzUNDjfZg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xrqj93Q4Sz4xfG;
	Sun, 17 Nov 2024 23:25:33 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241106212647.341857-1-robh@kernel.org>
References: <20241106212647.341857-1-robh@kernel.org>
Subject: Re: [PATCH] powerpc: cell: Use for_each_of_range() iterator
Message-Id: <173184539750.890800.15564743052815788450.b4-ty@ellerman.id.au>
Date: Sun, 17 Nov 2024 23:09:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 06 Nov 2024 15:26:46 -0600, Rob Herring (Arm) wrote:
> Simplify the cell_iommu_get_fixed_address() dma-ranges parsing to use the
> for_each_of_range() iterator.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: cell: Use for_each_of_range() iterator
      https://git.kernel.org/powerpc/c/f3ef7dbda9b589cdad833001e4366eb80977b7f1

cheers

