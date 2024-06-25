Return-Path: <linux-kernel+bounces-229349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8407A916EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62731C23091
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD6A17966E;
	Tue, 25 Jun 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="q8Sqjgkm"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17D176231;
	Tue, 25 Jun 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334748; cv=none; b=WvBV/hJ/LhbASsc6BPiwFSed1A9n9ZqT65RNhP3Lr79uVlzTkBxs7Ekjfu/LrDzGBfET3liiCcyP52/G+R7fZYkHbETP+zJVHEJBmOxFLeHxKTO4UaV3tx2c1/ys0BIpQPk8phaDLDu2LZ+dL5SXqTJE5I9E5WXLz5nykVg9qKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334748; c=relaxed/simple;
	bh=5qIOOAHvfAeqOEqFJk5OafZk8hgaDep0cVZ3ujVYezs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeQX0ayAtlGJPVlQvOPaKEW0A6WktGWa1/WcLfbdGazLZ1X5/gpyG2fNKCpwryxLRSpbJuJyBqNrRbfFtTo/Syx/aWK0v/tOW5h/xDi0g4LojLe34Ax3MHzSr3cqfDM6aZyR/L4Km6ZbKMoU6eEw4iQm5sKYxZ3bOGPWKYJyFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=q8Sqjgkm; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 71CF81F929;
	Tue, 25 Jun 2024 18:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1719334735;
	bh=IJrbabNzzBhzaeJkC2PMJ7DZ5x3aT19bK8M4kEef8AY=; h=From:To:Subject;
	b=q8SqjgkmfCwcsM+l5Y5mU8tNqLXP3CDky56Zt4Qzae/FiY4ek98/49rK3XoM4wyu2
	 r4HI/vWIRvOwkdrrZPQPtz9dXDKD5meMaDUGH/0kg6Z8JYrM5YCrPvi1B4JZhtFNf7
	 Kq49EXwBz16C4CmWreSdQkh5OylYFhzV2wwTKWL6E3IDx94K9eF/ATQtDMI0/atluN
	 g5VdXNLNZI+WYLmp8KdnxX+noVF8i4k+2JvcfvY7fqdXnUIN3q6nZJPoRyyHUlwHCN
	 YBikm+/4Vx1/lUsg17go1VzmlNKkVC8+VAtvuetwy609/MJfElcYyj93501y/cRGUs
	 MJCq+Tl2NiDfw==
Date: Tue, 25 Jun 2024 18:58:51 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: k3-am625-verdin: enable nau8822 pll
Message-ID: <20240625165851.GA26676@francesco-nb>
References: <20240418105730.120913-1-andrejs.cainikovs@gmail.com>
 <20240425135610.6c6ysoejefuazm63@privatize>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425135610.6c6ysoejefuazm63@privatize>

Hello Nishanth, Vignesh,

On Thu, Apr 25, 2024 at 08:56:10AM -0500, Nishanth Menon wrote:
> On 12:57-20240418, Andrejs Cainikovs wrote:
> [...]
> 
> > Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

> > ---
> > This patch requires https://lore.kernel.org/all/20240409121719.337709-1-andrejs.cainikovs@gmail.com/ to be applied,
> > if not the audio will just stop working because no code will ever enable the required clock to the codec.
> 
> Thanks. lets wait for the dependency patch to be merged to master, and
> once done, please resubmit this patch. I am going to guess for the next
> cycle.

Would you mind picking up this patch? The dependency is now merged and
this should apply cleanly. I can also resend if needed, just let me
know.

Francesco



