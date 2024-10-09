Return-Path: <linux-kernel+bounces-357148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B33996C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE661C21A14
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659A1922F4;
	Wed,  9 Oct 2024 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="J8lsXEZc"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824819924D;
	Wed,  9 Oct 2024 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481422; cv=none; b=SPcls/blhXAaUdWk0FecGwqJjIDY5SBR61KqD+ooCdRZLdJeskoK10KE0pJFxh44LVoNeyQEg8tjsml8hMeZ+MmGA4aB8IYXZpE19YoULSM1QSPEJPtQSEVg+ByaX3oOiJpDzEHZcZQwwkKvnavH0G9JENZsil5mc3xfFCyAQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481422; c=relaxed/simple;
	bh=m76lqjqbgB4N3bLVwBcWoYAkErMcbvIx1UiDoaT3L1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmbiDnWUN6EE7h8hFZPoes7T9nr1dg1mW2tZeOHoOxY/ktqAR1Ri3zGsE8LBM56Ly9ZI0RUE4GsZGU10WtR6EVSkmUZFQynWKhwytknCf3RJkQpzYjPasye5KDSvjkaOPrCyd2YZIp1le7YKo/sKgQma7SliSbFrR049n1xf26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=J8lsXEZc; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5980A40B279E;
	Wed,  9 Oct 2024 13:43:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5980A40B279E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1728481416;
	bh=GVRtHN7Axm3yARb70hga4EFE2y3Nh25dRQGuJxv40EY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8lsXEZcAqmJ8mRnfURed2wH55iJLZJMq/t3gbpsLkgErXNMfeD1LhB/jtXLigOB8
	 pFsCh+5dsoIK95x0iWupZVKEW9pgpzJdOOu2s03lg3lB9GKC1R6ttNCpb17p3qXgn0
	 7wPNP2B+ZlubLIiNJkfkJBjw9uw1h2IbpJmBJ2Dw=
Date: Wed, 9 Oct 2024 16:43:27 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Andrew Lunn <andrew@lunn.ch>, Stephen Boyd <sboyd@kernel.org>
Cc: lvc-project@linuxtesting.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Alexandra Diupina <adiupina@astralinux.ru>
Subject: Re: [lvc-project] [PATCH v3] clk: mvebu: Prevent division by zero in
 clk_double_div_recalc_rate()
Message-ID: <20241009-fc03180437255c79b67ad576-pchelkin@ispras.ru>
References: <20240917132201.17513-1-adiupina@astralinux.ru>
 <af7dc028ced22413210701a5e2e05990.sboyd@kernel.org>
 <d05d9ebd-f954-482b-878b-9dcb422821a8@astralinux.ru>
 <c2250a7cd0e2af5077ade91279567c3b.sboyd@kernel.org>
 <a79dda0a-258d-4567-b473-44aabe81b649@lunn.ch>
 <20241009-29749473966747300f3d1d3b-pchelkin@ispras.ru>
 <b2489acc-d997-43e7-aeaf-c662b6fd3253@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2489acc-d997-43e7-aeaf-c662b6fd3253@lunn.ch>

On Wed, 09. Oct 14:23, Andrew Lunn wrote:
> > > I would say, let is divide by 0, so there is an obvious kernel stack
> > > trace and hopefully a report of the issue. It can then be investigated
> > > in a way we can then find out what the hardware actually is doing.
> > 
> > Is it worth adding some kind of WARN assertions? Or actually just leave it
> > for now as is?
> 
> What actually happens on a / 0 on ARM? I assume it triggers an
> exception, which will give a stack trace? If so a WARN adds no value.

Oh, I see. I should have better said "adding WARN assertions and bailing
out with a default value if they are violated". Thus avoiding to have a
division by zero exception. Non panic_on_warn systems would at least
survive in this case but still have a valuable trace.

Somehow more importantly, it would state in the codebase that the condition
is very-very unexpected and most probably won't ever happen but not 100%
sure because it depends on hardware behavior (as I perceive reading the
current thread).

That said, if adding such WARN-bail-out pattern seems unnecessary and just
wasteful in this situation, I don't think we have any options other than
keeping the code as is.

