Return-Path: <linux-kernel+bounces-406698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAE9C626A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01972284537
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0D0219CAD;
	Tue, 12 Nov 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="r0g1SVty"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023220ADFA;
	Tue, 12 Nov 2024 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442733; cv=none; b=GV238+dC8TFE/AbKo6A+aTqG1al2UCPQbvCqJprIKXZD+K4koXtw5y5+/OZq0A6KAHgocsWUoY3jV+LW9E7cwIbGPCNmAqpROWPKJoQYmlDTjkdp7eFoMEh8ZGvPxiwHuvUPdwgsskVSCyGdwB8+GuzWHEweHREXFeltvpnJIrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442733; c=relaxed/simple;
	bh=HRQi7qZ84SzxT6R5y8pyPh/3g1Kkxkb73S8upyksdjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n6qul3sAbX1gKNQxTlWY07Kfv6l64MKIJ9dXQU2SHinXwk4qdUfHsAgvHQE9cngMTJixu2dMfWOoYhBHcdQ+o//BHX1JIs6bctwdYueJg/SgvNiK1zZyvfMtvBpXxka5rbAdfJ5Lq4ivrAgxKFQAlThM3lbk6+XriVhim/r+qVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=r0g1SVty; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D16FD403E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731442731; bh=diGWZWEG+gb5ruWl8mK8yLLNUJQe8L2w8Pu0qT+Tshk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r0g1SVtyR8yzPjAb00kMvl/dEpaemmQI0EcNaTJ3W92WH72oEgy7ozfCxmxzjTezb
	 kIsOMLujwBbtkDwOhuQ0HNAKyg9QjF/o1bTwGzshK6wgkQ61Dnz0kdR2O4ZKk0ql1D
	 48zXHlZ8dvNe3Nf/vbN8fSiSmxtl/k2zTh663nxBm1tmluJrzUR0skbk3tc/Ma4QaD
	 vcsdnqouC4/xbbtrk7ZgtV+cIrv0VraEdAoUxg1gXzGLtlsHfvyWzfQiNVY8R3ccBq
	 9cu8x6WDo0kwjbBcXhsrXvnY+iVw2mpJWCJSWNFJDzEIcZ29/Xy3IWk4/8vYlVQf6b
	 WJrhT4lHXY59A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D16FD403E4;
	Tue, 12 Nov 2024 20:18:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>, broonie@kernel.org,
 dlechner@baylibre.com, u.kleine-koenig@pengutronix.de,
 Jonathan.Cameron@huawei.com, pstanner@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, anish kumar
 <yesanishhere@gmail.com>
Subject: Re: [PATCH] docs: driver-model: generate kernel-doc for driver
 model using script
In-Reply-To: <20241107033303.97509-1-yesanishhere@gmail.com>
References: <20241107033303.97509-1-yesanishhere@gmail.com>
Date: Tue, 12 Nov 2024 13:18:50 -0700
Message-ID: <87a5e4qk7p.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

anish kumar <yesanishhere@gmail.com> writes:

> In commit 63dc355 ("remove the driver-model structures from the
> documentation"), the kernel-doc text was removed, and users were
> instructed to read the documentation directly from the source code.
> However, using the kernel-doc script to extract and generate the
> documentation is a better approach, as it ensures the documentation
> remains in sync with the code. Additionally, it provides users with
> a more convenient way to access the documentation without needing to
> refer directly to the source code.
>
> This patch adds kernel-doc annotations for the driver model to
> facilitate the use of the kernel-doc script.
>
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/driver-api/driver-model/bus.rst    | 4 +++-
>  Documentation/driver-api/driver-model/device.rst | 4 ++--
>  Documentation/driver-api/driver-model/driver.rst | 3 ++-
>  3 files changed, 7 insertions(+), 4 deletions(-)

This does not work very well...

Documentation/driver-api/driver-model/bus:8: ./include/linux/device/bus.h:3: WARNING: Duplicate C declaration, also defined at driver-api/infrastructure:3.
Declaration is '.. c:struct:: bus_type'.
WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -sphinx-version 7.2.6 -function struct -function device ./include/linux/device/device.h' failed with return code 1
Documentation/driver-api/driver-model/driver:5: ./include/linux/device/driver.h:3: WARNING: Duplicate C declaration, also defined at driver-api/infrastructure:48.
Declaration is '.. c:struct:: device_driver'.

Please actually perform a documentation build and look at the results
before sending patches.

Thanks,

jon

