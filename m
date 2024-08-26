Return-Path: <linux-kernel+bounces-302310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292A595FC73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 00:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE61A2850C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F1919CD0F;
	Mon, 26 Aug 2024 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="A4BiUbdQ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F376811E2;
	Mon, 26 Aug 2024 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710233; cv=none; b=Ih/JpqNsfgKBxYiF+8ZTO+o4b2xaMnla+NGpVZsVhgXCEKbPDWN3+07JHIHqwOrXMUHH1JH7XCQyBGAvbCmZlEdjE3oDSRBjzwn64xIBgrke8swlMTzLSeSa5hnntsrT3yioU4Miz1lw9CY4BDhObOCMqB+L7IbtmEOgFdFFyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710233; c=relaxed/simple;
	bh=+fhME1anNiXFk9cxwp5HDp73kiuOhd3OZWYnm6kJPZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5dRJsouKIDwUQ1yj/j1jxEl0uKpVCNVgKV17cQNP7BV7Y/bg7qXJuGVCqYi8XNnVDAb8nBHNrxZgXvN4xg+8DjvAt+DO4lzZxL8Yk6zB/BLhmBDlReJK3HcoSg9XN2cT1/ri9dBryeTaSoxqz53wVcYNI3Xm3wUPV8zYZHOxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=A4BiUbdQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2E1B642D39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724710230; bh=bfUnONFBgHJRpBjL0TK+9yVaRb23+Uddx47+9YN6HUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A4BiUbdQotp8Y4IrP97JHP4ZmNl79ktngT3xiZU0VbSDyogi4fXDo8BXhFxb+MU8M
	 pKB+XV5NU9h1opNWmlgyFqi2lJReBBdpptrQZ7AT/ZGH65vZgc+GHjSrSSr2CejGXQ
	 Cv8LjP6V/OM/Y46zCOHfPhwmJwgCvrighzhfQuaCqw26fk0fgGuiYGzZqH9HE9HCwP
	 MR7W8Tma+rw1+yAVBO3GY3gFF5JZ/lwxtlShWdzhmoC9gYzy06qOCS3c8drRQtz50f
	 E3DOVwYyhiyQUcv1A8MuTqL51TZqd11P0Sv9uqjr8aVL4D1Ct/nhuXRjQoJPNDNYxU
	 OHaLc2AYtn4hQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2E1B642D39;
	Mon, 26 Aug 2024 22:10:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: jani.nikula@intel.com, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] get_maintainer: add --bug option to print bug
 reporting info
In-Reply-To: <20240815113450.3397499-1-jani.nikula@intel.com>
References: <20240815113450.3397499-1-jani.nikula@intel.com>
Date: Mon, 26 Aug 2024 16:10:29 -0600
Message-ID: <87h6b75416.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@intel.com> writes:

> For example Documentation/adming-guide/bug-hunting.rst suggest using
> get_maintainer.pl to get a list of maintainers and mailing lists to
> report bugs to, while a number of subsystems and drivers explicitly use
> the "B:" MAINTAINERS entry to direct bug reports at issue trackers
> instead of mailing lists and people.
>
> Add the --bug option to get_maintainer.pl to print the bug reporting
> URIs, if any.
>
> Cc: Joe Perches <joe@perches.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  scripts/get_maintainer.pl | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

I've applied both patches, thanks.

jon

