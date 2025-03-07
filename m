Return-Path: <linux-kernel+bounces-550649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA49A56271
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178861897C0E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FEA1B4240;
	Fri,  7 Mar 2025 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErLB7r+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2F1885B4;
	Fri,  7 Mar 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335402; cv=none; b=sdLtH6ilNleDpHJl21dKEMlTW2Qxx36cyOkKLOuetY+YOOmNI32KkCtDl0D+poF6wMs2wSxurOPe6V/Ql1WTQWEJOsr73+BIIxkgGRaxMY/raVWNvBL+xui0J14DoZHjjTHV4PFR68pzuPUZep2aY4prkJ1ZpJIeoAKv5qlkBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335402; c=relaxed/simple;
	bh=DEVRT3pYUTzTLAgL5CavIfRYoF9HgZxDGxwhWCp6/R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyYZJgkHvMKMoh/foiVFG/jLwTO3t1SJTSpQI4Zyo0u/0XCi1RKe+T8MdxtgjVPuIrOMcjoxeS3MtXREKMp2Pue7GCS+eZN2RUUzivoGabgxEip0ajs2lfvWtGjcMvGxHdqXo68CCIB+XTzcaiTfkdCKktXgIf/vy43m0jGsbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErLB7r+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F7BC4CED1;
	Fri,  7 Mar 2025 08:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741335401;
	bh=DEVRT3pYUTzTLAgL5CavIfRYoF9HgZxDGxwhWCp6/R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErLB7r+PME0AvpLr3Uk77LtGmuAPKrLDCGGk0MonxsZLFZO8/gYN1aJuuVHfJMr7j
	 ZqvX9b1HxwVz9lGKboQGqCKrsrk8Hmz+FUC2EI7HCr9p63FhHHCM8VCdKkiz6xmiwJ
	 S11pJzDLVRMWK0f9bVmDRg0yxj1NCEnqeeL282iAd4X8D62weuS/D7eCAK+1YLmKPR
	 jed64eIOKI6SZqvhmvK42SMkUNKwOwokWvHRzPPBWj6XhrvukYUrmaS06Ri+T+1B28
	 4xYaas6OuVYbqrw+NWuLJZI3aUp8MwXEEgL3UgH3gGOZYh7iw8NaZaokmv257pq1U2
	 loRCy+nPVMMiA==
Date: Fri, 7 Mar 2025 09:16:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@4d2.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, Inochi Amaoto <inochiama@outlook.com>, 
	Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
Message-ID: <20250307-gay-apricot-porpoise-9b0aff@krzk-bin>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-3-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306175750.22480-3-heylenay@4d2.org>

On Thu, Mar 06, 2025 at 05:57:47PM +0000, Haylen Chu wrote:
> Document APMU, MPMU and APBC syscons found on Spacemit K1 SoC, which are
> capable of generating clock and reset signals. Additionally, APMU and MPMU
> manage power domains.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> ---
>  .../soc/spacemit/spacemit,k1-syscon.yaml      |  80 +++++++
>  include/dt-bindings/clock/spacemit,k1-ccu.h   | 210 ++++++++++++++++++

Filename matching binding, so spacemit,k1-syscon.h
(or vice-versa)

With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


