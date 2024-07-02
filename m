Return-Path: <linux-kernel+bounces-238544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90859924BE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02636B2142E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD486156F46;
	Tue,  2 Jul 2024 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKwm+93S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AF55C08;
	Tue,  2 Jul 2024 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719960743; cv=none; b=sbGS4POS+DXCpVm1hveoB1KUQDxDrfFvhjmyLUXx/nx38UJEJshMcqki8HCkJqTR3RrA4FpEE9ENehL6LSvhF4uLfj1oW0/bWLrGmBhbGmJRaWh11apiNR4zus5wi1lzy6S7o9L8iBjjfe2aZd/eepXdS4NihAyM7MuLs/d83eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719960743; c=relaxed/simple;
	bh=EeliZOwnWyqJK3pXzEfb3LY6JKmWA2NykWMeMiWGrPQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=malsy3RmX7FlCsljxlZajHO2cH/khh0c5bpMyyxlN6f4oKuVxhqPhRF9MJwbNOyDdM/oXTXkPL+4n5d3Rp4R7aRO1HkxT8ClKFzbI+YZeIDVwULeKrN8ZZFyY5avNx/pWfuWuLPhUJJFiuDCqbi0HVeIift2rESp9ldi5Rdgz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKwm+93S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DE4C116B1;
	Tue,  2 Jul 2024 22:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719960742;
	bh=EeliZOwnWyqJK3pXzEfb3LY6JKmWA2NykWMeMiWGrPQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WKwm+93SyUDuMwfU+0zDVdczXvuJlxiByBRxSUlTPmQAeXgax61xTy7pjZ/Biwc43
	 9yi4mYgdZeU6bE2qGSl2cyCD7NhXAX3d2iQEI97gtIorSK10LrHFkiBeLMP2bnFven
	 kTWe4KhRpgMf3yl0DubC6t+9xG6VVsPddBqzvtnp6mByIP6+goK83q3NTU0QsTQqEv
	 xkhd48J4ZQ8RG/tr+wYeI+7yXaHbRcEN3qYI1Jb9eofXJImuPQq0sDLqQ37NS2yvyX
	 1zr9P5Ws6YIwRCfMEyUVRvZ3WGKeLCnMYb41vdJyz3C97xJ3937PbBHuEXVAECXgtW
	 geWRcdpeKfbdw==
Message-ID: <e5592ae06eeab4217003db5bc2665668.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240702125539.524489-1-audra@redhat.com>
References: <20240702125539.524489-1-audra@redhat.com>
Subject: Re: [PATCH] Disable Clk-gate_tests for s390
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, npache@redhat.com, raquini@redhat.com
To: Audra Mitchell <audra@redhat.com>, kunit-dev@googlegroups.com
Date: Tue, 02 Jul 2024 15:52:20 -0700
User-Agent: alot/0.10

Quoting Audra Mitchell (2024-07-02 05:55:39)
> Currently clk-gate tests for s390 fail as the tests create a pretend
> clk-gate and use a "fake_reg" to emulate the expected behavior of the
> clk_gate->reg. I added some debug statements to the driver and noticed
> that the reg changes after initialization to -1, which is coming from
> an error coming from zpci_load(). This is likely because the test is
> using fake iomem and the s390 architecture likely isn't designed to
> handle that. Turn off the clk-gate tests for s390 for now as there is
> no clear work around for this problem as discussed in upstream
> conversation [1].
>=20
> [1] https://lore.kernel.org/all/301cd41e6283c12ac67fb8c0f8d5c929.sboyd@ke=
rnel.org/T/#t
>=20
> Signed-off-by: Audra Mitchell <audra@redhat.com>
> ---

Applied to clk-next

