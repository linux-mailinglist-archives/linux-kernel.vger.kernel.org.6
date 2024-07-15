Return-Path: <linux-kernel+bounces-252991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297E5931AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D04283429
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4495B13B5B7;
	Mon, 15 Jul 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdW+4odl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06917BA4;
	Mon, 15 Jul 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071538; cv=none; b=k57HhWClnxYtG0oqHtuf2jR7uiZ4pR31ktlCR8UVrWaStVlvH0MD3ZbvIar9+q4AZyPwGwRt7DtLhetUoSFxMTmJ9vtTVxtEOlbSFrUgcW2qzxRl9BpLlFmc9gRtXY8skTJFOWnHGHARfLsznQVnOx/GTOuU5Am7IVve6twah9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071538; c=relaxed/simple;
	bh=zgGW0nC3fo2mSgZ2+PKTAHFJmhpsrAGkAwYKuSpXcEg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mqsgHE8HGN2AQr1d6MCFV39Ay/ZA0PaaSWs4rzKGWsfwQBv642rHdMhGskjI7ir78ErqG0+0eugS46vLZTvo7XcaJ4caA5EBL733mzp7G1qAbJe6e/d7ePV4Ff1C8P5BRvJjNN/RrkAHfPas/gU2ErI/7xNLCPAffEjT1aQo5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdW+4odl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066F9C32782;
	Mon, 15 Jul 2024 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071538;
	bh=zgGW0nC3fo2mSgZ2+PKTAHFJmhpsrAGkAwYKuSpXcEg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=MdW+4odlFlSvhhQ1Aw3xLa93GLZbXiPyMXzU5PkpmFHWCZ3Z7qj+5btzCYrBJXEep
	 q4hnFrRK0Mtju0jlmKy4/S51M9dN/Ks0XhoDghyzRXcioh6d0IxSnzajK7ZGOd7o2M
	 mVCm6JPQxvTfszDFfF8ye69RS8EPPd9AwvPOUehcQpYvoMjL/s8CjTHXLBRiEszdm7
	 eI1u5yAkIbokK4PBelM7uZrG1RGfgm8UdWnAhKSyMd/YOU4yYS3cQxMPE8ByKXRJfn
	 XYKzCQDUtY5xx6bLwc1t4N0IKWIrqQ+izoIL8ce3bew7kONEsYAEv/dgRmYROtaHUq
	 sv+YJUUtm12wA==
Message-ID: <18373d55bf8ae9d898395d776bd99a9d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201246.1802189-8-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-8-sboyd@kernel.org>
Subject: Re: [PATCH v7 7/8] clk: Add KUnit tests for clk fixed rate basic type
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 15 Jul 2024 12:25:36 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-10 13:12:43)
> Test that the fixed rate basic type clk works as intended.
>=20
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

