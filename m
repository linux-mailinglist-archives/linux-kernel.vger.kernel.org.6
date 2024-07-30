Return-Path: <linux-kernel+bounces-266535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D394014B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B12282DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325516F278;
	Mon, 29 Jul 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtWuEpUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44E18FC73;
	Mon, 29 Jul 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292670; cv=none; b=e2Tx2y9iHuIKGozVrVAMRs9eh+5gSw7QNmyBwxWdF9MtxUloKZK4TwOApA54x0KqcYdSehC8pzQ6rAJ8x9uJZiDgQOr+yJpEWmMqpjSEPWWW472yXetUTsN4E2rE9mDuyfrQIVT4N9XJ9AWZBpx6qiDmViZQiwNirYGSegOZLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292670; c=relaxed/simple;
	bh=zmh7rUVAPy6mXYCuUirLvb1/uv6F+IcJKUz8oAB+2MM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Gv8d2LYmVPj0TdrlToxmKn1w7zyh54dcFgjDSRUU3u0+P8ccY4+oqtG58Myty/C4iSsF5UDbaxJzsPttHL0/ILc9pFCLIYU4F3sGNofwbAFxjW22bke303J2nIvQOy1Mb68Vpli2RUlQ4+u8XVzb2XRiqYfeiHoehK1LNxUzpso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtWuEpUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ADBC32786;
	Mon, 29 Jul 2024 22:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292670;
	bh=zmh7rUVAPy6mXYCuUirLvb1/uv6F+IcJKUz8oAB+2MM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AtWuEpUQAgO9zkfkztnaB/jEEoYwRcsVmrhkFMplDzlt+krHiX6KATHRTnqzggLMs
	 oiMRHKIBuonxKgEp5r8Se2ugWbxUxaRqAHLhxumKat+hutKWQAPSNXROxxknCAnG0q
	 +1Uv9KJ2Chx+K7JVB1cGl5SK/335/8zJZuceqA39tijseNWkKJWEImVjHGmwVwZtVv
	 0yb/mo3qjK1vh870E91gENHqLrAuUUeNBgFBmYFmwLqJsz1YJ4F2MNMPeVPabsPd2f
	 w2SIyDNfvYJZxJs3VwrBrwkLxQz/DZew/OmPk3WrxSGiF4pc07d57AIIf7DUDIfMgl
	 SEKjyWba8iLYg==
Message-ID: <4b5eaeac198a915aeedd3ec0e7b25da1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718210513.3801024-7-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org> <20240718210513.3801024-7-sboyd@kernel.org>
Subject: Re: [PATCH v8 6/8] clk: Add test managed clk provider/consumer APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 29 Jul 2024 15:37:48 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-18 14:05:05)
> Unit tests are more ergonomic and simpler to understand if they don't
> have to hoist a bunch of code into the test harness init and exit
> functions. Add some test managed wrappers for the clk APIs so that clk
> unit tests can write more code in the actual test and less code in the
> harness.
>=20
> Only add APIs that are used for now. More wrappers can be added in the
> future as necessary.
>=20
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

