Return-Path: <linux-kernel+bounces-356984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E419969E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B05284A25
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D9192D91;
	Wed,  9 Oct 2024 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UNrue08+"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408C19149F;
	Wed,  9 Oct 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476603; cv=none; b=IgXAFQJP6E7o6d+ekaR8ZA4R1c9j9iqOQUsU0ZhQ38Lp0M9ALEAi+HKy9aAb0uK1EHMMjAduoUqP2clS0FD2h7wNCsBCpREe5pGsFttqiBTXEP20EOrYvZBEaW8TCGxbjMjPoSb58V+qCs+1diolrqY3EPfy7k3RYI2aho+r1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476603; c=relaxed/simple;
	bh=xnWivR6fcBquYslR7NRqmfuc9xvRUA4PTFWiLdEpnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jr7+qylFotOEDJ+8YkaKCzU1ZFFixMYVU0KuKj4YS1g3HMEIy0+91M+NchkpMQPPZhKbq6WMkROPqpPbn+qamlLs0QyrEgYVCJ/sJUjrVayUiJ/rK/XYYQhoBslXN3ePPFkIiU7AhNARcV/AMJQXE1TQw+j+6wktOOWjKpX6fTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UNrue08+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gVi8LwdnV8xpyyxW1DNsL6wEgg2JRlgKhN4PKMnARNA=; b=UNrue08+6PTroR13z8mTw8CNCM
	/gfkprZTO6N7C2LCcDn7K83dfMcakY+kPth8ujKBzp7oWP3um/UUPcInLcU2vrOzAndkXLZ2LSCJk
	8JlLk4jRe/LO0GsnPk1tbNzqC2PjDUgDbKH6RAI4TTnyhsqt46jv8v36qaZBnfdNkaqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syVii-009Uh3-Q1; Wed, 09 Oct 2024 14:23:12 +0200
Date: Wed, 9 Oct 2024 14:23:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Stephen Boyd <sboyd@kernel.org>, lvc-project@linuxtesting.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [lvc-project] [PATCH v3] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Message-ID: <b2489acc-d997-43e7-aeaf-c662b6fd3253@lunn.ch>
References: <20240917132201.17513-1-adiupina@astralinux.ru>
 <af7dc028ced22413210701a5e2e05990.sboyd@kernel.org>
 <d05d9ebd-f954-482b-878b-9dcb422821a8@astralinux.ru>
 <c2250a7cd0e2af5077ade91279567c3b.sboyd@kernel.org>
 <a79dda0a-258d-4567-b473-44aabe81b649@lunn.ch>
 <20241009-29749473966747300f3d1d3b-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-29749473966747300f3d1d3b-pchelkin@ispras.ru>

> > I would say, let is divide by 0, so there is an obvious kernel stack
> > trace and hopefully a report of the issue. It can then be investigated
> > in a way we can then find out what the hardware actually is doing.
> 
> Is it worth adding some kind of WARN assertions? Or actually just leave it
> for now as is?

What actually happens on a / 0 on ARM? I assume it triggers an
exception, which will give a stack trace? If so a WARN adds no value.

	Andrew

