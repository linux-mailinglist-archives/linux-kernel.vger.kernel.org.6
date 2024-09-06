Return-Path: <linux-kernel+bounces-319374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22F096FBBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9AA1C23CCA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97A1C9ED8;
	Fri,  6 Sep 2024 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ne72PVYf"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBDB4315F;
	Fri,  6 Sep 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649287; cv=none; b=ZnBgaaldkGlHdNymd6DkyqIRTo9sqYWYWLzYHlwTRw+c5bhT2tR/mzOarWjQELjTRIswofDewpSfXJa2DSjxifAgVqIkbqJYgof9/3LT0cBTz/O0RGOjFVW7A5TStAGYqAOksfULMWNvexutYqVG7h4p15Yb5YJiTvlAodua4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649287; c=relaxed/simple;
	bh=MpEVbAyPkgS2RIDaDY2kT7HecOMe0wDRZ7Yd1eprxdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kwGq5VJOzR7b6yqwTTwZXUyieswT5lccyWqB4RxVlNqR0W+ZpbRfDTY2I3Udqvij87BFUFVJI7MO78tmPbziuUZWQpsElzJGROcFWONGTGa6eV8OGNqtEgICIkJzLO85v5K3Js3MyC4/I8KM+ufvy5sBnGitp8T3Yzee2fnbKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ne72PVYf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 301EE42B32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725649285; bh=NDIPdnmQy9ilSKlrSZ9WvuqVY9Kkt4YQ0i0oKUR7mN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ne72PVYfK3YAWJva+kDDD6zo20e/ppZDuRCNg4qv+nzgmPhfMlmWuNs3FfLBFzSUC
	 +nSHoThHZfRIJR9e+Ap4V/9rfgLki74Y25GJDSiGFyNTI3/4Xo9DCCRpQ76lOCij0s
	 WqVIwRtQOrRBhZG2ujxRHmNx5iqWIhxAKF+8/IiyQQl+y2X3Ykw5G4wI2vOgP1J+QS
	 u3L4iXD0t8bL5tNhue8XaN67et/+XFeRSLeZnPeUIJR8qQuNRs42Kz7zO78A7BvHmb
	 GKAmPwH3h3VJFw+YsJru3cmy7XQRLUm3szRXVXn4bQoDJsyeANvVDnGMAODjOm2M6X
	 U9D5tXmA3m4PA==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 301EE42B32;
	Fri,  6 Sep 2024 19:01:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Kreimer <algonell@gmail.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Andrew
 Kreimer <algonell@gmail.com>
Subject: Re: [PATCH] docs/process: fix typos
In-Reply-To: <20240906081615.5409-1-algonell@gmail.com>
References: <20240906081615.5409-1-algonell@gmail.com>
Date: Fri, 06 Sep 2024 13:01:24 -0600
Message-ID: <874j6sehdn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Kreimer <algonell@gmail.com> writes:

> Fix typos in documentation.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  Documentation/process/backporting.rst    | 6 +++---
>  Documentation/process/coding-style.rst   | 2 +-
>  Documentation/process/maintainer-tip.rst | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Unfortunately, this one doesn't apply; backporting.rst was already fixed
by somebody else.  Can you respin your remaining changes against current
docs-next and resubmit?

Thanks,

jon

