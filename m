Return-Path: <linux-kernel+bounces-220911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD56690E90E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551CF282D01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35C0136E30;
	Wed, 19 Jun 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4N+24W4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B55044C6C;
	Wed, 19 Jun 2024 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795557; cv=none; b=qrpdGpF+lf8S5ysyvilIE3ywBkYj84Ksg8YZiqhOY8GHZipMRfDqxsb881f6mF501+1aq+/7Pg3HxXF7LZ6p+9q2UkZaEyuZJd9M7WQ5pG2OVhXM8NPfBsQU7mpaZhty7m+bP3uprmpX0BrSENXVtKFX9MR23/WlVTm3grYwMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795557; c=relaxed/simple;
	bh=O9nhu/+Qvcd4o30VuBzlUYrvaX7bpq5z3EfEXG99SKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGK9NtywQYEpwuEUbwrNGN6ko/hBUwTwYRZoub0gKYFc7nN1gSVSI4G/R/1t+3vIbuaFTNrm36X0ZP/H1rjA26mIZN0zrYwkiWhnrv5WpLIAUMdD840cVpRMw7kirVKU2am4aaYu+G/vnjjEfGy5Ehbj0WetIa6nQngcE8DSbVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4N+24W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19465C2BBFC;
	Wed, 19 Jun 2024 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718795556;
	bh=O9nhu/+Qvcd4o30VuBzlUYrvaX7bpq5z3EfEXG99SKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4N+24W4GUYywKfd1i2dwkIWWjD5HVHCyj20kf4BUsnWhLyOC0niZaYsukQyT40AC
	 2cgc9CdRNQ9UYlL567COAG+eEsCsaaYz7Bjjf/BuRbPMghM6N+gH3kSUnHCod578ka
	 owgCGNYXKzNSe9xhYHuxjicp+EojR0lPu1ySPu9DtJIk5UGQ+R+PpgcJ7lgw6wJn7H
	 wbXW8fAyzBbE+shz836a92bqhZWS5U8nEjJqT+kj+3UxNke3DIvp1kv2vIYyP19ZJO
	 WmxtGLpsHi6YFkw/K9yq1nNcYGbcH7JzWIjko1e67vTvTBVbbAPjOG0FLsqthikwpC
	 1XuRgZXPux22Q==
Date: Wed, 19 Jun 2024 12:12:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] clk: thead: Add support for TH1520 AP_SUBSYS clock
 controller
Message-ID: <20240619-tapping-jaundice-471811929d96@spud>
References: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FObDbNoTBAgucHoG"
Content-Disposition: inline
In-Reply-To: <20240615-th1520-clk-v1-0-3ba4978c4d6b@tenstorrent.com>


--FObDbNoTBAgucHoG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 15, 2024 at 06:54:29PM -0700, Drew Fustini wrote:
> This series adds support for the AP sub-system clock controller in the
> T-Head TH1520 [1]. Yangtao Li originally submitted this series in May
> 2023 [2]. Jisheng made additional improvements and then passed on the
> work in progress to me.

One thing I noticed on the dts side is that the GPIO controllers have no
clocks provided. Does the AP sub-system clock controller provide their
clocks too?

--FObDbNoTBAgucHoG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnK9HgAKCRB4tDGHoIJi
0nOtAQCGanWyMDVqpiwnBPcON68b0Uar/qqWSiQrmJT0LkotFAD/QrasnNc1TUTV
RH7Wx87PHTMMHt9BO/UguDi5bJ5uJQU=
=LFxV
-----END PGP SIGNATURE-----

--FObDbNoTBAgucHoG--

