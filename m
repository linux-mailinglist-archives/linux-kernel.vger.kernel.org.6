Return-Path: <linux-kernel+bounces-427020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E409DFB42
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2343F28268C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573621F9412;
	Mon,  2 Dec 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVnrarOD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A76481A3;
	Mon,  2 Dec 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124726; cv=none; b=TrIauMQb6gYI6nlT7N7Va01/zjjJUmlHPmOXav4tcj5BGZSCMyXE90TyEBg4ZlYYHzkJ7eaCzIUDO3K9nePnu4T072iTT7LQizRACqwEy3yCFHocxRXbRkM6kRKUA2HGXPzyXA8g1nRz3bggFMxceNIprohgmn5abKJwbuBdOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124726; c=relaxed/simple;
	bh=rrI/w0h27qiFcRLiB1wSawa+cqjjA8wFsGznCJjR4Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6QEomnhOIiP/XqDrD2hAE3boVXtZsspkWDGFHPVNeYhGXcXd4V4gNh+gJ8AQNyHxd23OAjt6RSMYkuV1RmokifCgLEPizoQsGu2aYxnDZ2HaAy4s/A0FOf6ir1yvduN253JicpV4r39kXYstfmsMjpkfAtSXTRWsIOgIWvILyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVnrarOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7C0C4CED2;
	Mon,  2 Dec 2024 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733124726;
	bh=rrI/w0h27qiFcRLiB1wSawa+cqjjA8wFsGznCJjR4Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVnrarODfqLQ655qPXx1I73QfWdmJix3/vb2TRHKMx0YLVgmd//4wXzmckszFqsjH
	 yOOYoZFS/65WMV2vvrT8I/ayW8liEswRMbMG64dJGLJVdjXXpZnduPRGbNG9BOPk0V
	 sn0JXNhBRCeE0veG9XDNhc7+mFiMkeMFRWajAz/jzJ3vIXUM246j4pjCfaktjCPiE0
	 GNazn+X7TRxKOsGZKv7hgz68Qt79VJ88ECXsuTm9Pqj49mSMWqYrBBJMoLAntKucYP
	 CCfCUkX+xAjKhjJAyKTECJ+8TnTf0QgpE3khvN7uTIbnfIHnMGc+TEH32MP2uwtYGN
	 HLlCJU4YBUdBQ==
Date: Mon, 2 Dec 2024 08:32:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 01/18] clk: imx8mm: rename video_pll1 to video_pll
Message-ID: <hdpndzf6jpywogsdcgl7wwmqzgbcvhportoieieohfmp7dwmyq@l6eujnohfe3s>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
 <20241201174639.742000-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241201174639.742000-2-dario.binacchi@amarulasolutions.com>

On Sun, Dec 01, 2024 at 06:46:01PM +0100, Dario Binacchi wrote:
> Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
> name used in the RM is video_pll. So, let's rename "video_pll1" to
> "video_pll" to be consistent with the RM and avoid misunderstandings.
> 
> The IMX8MM_VIDEO_PLL1* constants have not been removed to ensure
> backward compatibility of the patch.
> 
> No functional changes intended.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
>  - Added in v4

Wrongly placed changelog.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Bindings are separate from drivers. Always.

Best regards,
Krzysztof


