Return-Path: <linux-kernel+bounces-287372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D2C952717
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB79B226C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B613186A;
	Thu, 15 Aug 2024 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is2awu7m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598444A07;
	Thu, 15 Aug 2024 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682259; cv=none; b=XOgk6tX2ln5onDPY/zdLejS0WtyAQNGUwoglN16OcSAB/66UUfiT87MW9I8IQw1BGOSleuAD6rA1NHnP8GBA1Lm+aakrdUrGVvH/i+q4Y4t3nQ8sibP94CyCcK/AJqIAj9NqGhBdWf+jtp3rjIul7LCKXBePkD49dP2O3EaqDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682259; c=relaxed/simple;
	bh=kef/wSVlj0sqeqALFTUw0b0UfDzzyQl08nPrgOm9jn8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=i6hillDDK3X3Z6tdtkk0xrRjxd+/0hDtWpRl7Yu8d18e5kVWVDOULR+XlnO8lLJsCbSvKjlOGHvKFrlgdtOSJq1VYe6oWgcjOeBdWpYQZaBMfSJNTbhDiFUtr2kLFLwzI/GvTKlc22/ZGdehcWO5Gif9hL3GIoAABrFz78zS2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is2awu7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43CFC116B1;
	Thu, 15 Aug 2024 00:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723682258;
	bh=kef/wSVlj0sqeqALFTUw0b0UfDzzyQl08nPrgOm9jn8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=is2awu7mr3G/KqR7oF9FATGrxdvcpUFbqUzBrN3Mj0j9HdxWmMDK41ezRohWH73n2
	 aRc/PC6x37S053U1AnCWNj2zJNTe6qPfyS/maLiPRaIAwZkAmkj2eZ4jhgCn278ro+
	 jIlT0TKe33mNvdjYCfGD/JV8ikp6TH2raZLZYvK4NlsaXmgEW4eqXtzZTTY2TQnb1U
	 gC6eV2TtUq9EzAT3S5jzDT9efDhmtLt9tQeyne+P0AWCqyArOElftoPMAPQmN8oYRx
	 qN8SIJX8mxvXa42bB03ZovTV2uphK0RcBMcj01ml9Kqq00H4GHIQcICjdvBJVwrWkE
	 LoEJvxollO2vA==
Message-ID: <626bc3b83acc5d6283baf6e9d893a10f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240814125513.2637955-2-andriy.shevchenko@linux.intel.com>
References: <20240814125513.2637955-1-andriy.shevchenko@linux.intel.com> <20240814125513.2637955-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] clk: mmp: Switch to use kmemdup_array()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Aug 2024 17:37:36 -0700
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-08-14 05:54:07)
> Let the kmemdup_array() take care about multiplication and possible
> overflows.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied to clk-next

