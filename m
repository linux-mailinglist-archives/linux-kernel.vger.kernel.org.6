Return-Path: <linux-kernel+bounces-177623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B21A8C41C4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA57328292F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D804152185;
	Mon, 13 May 2024 13:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lvJ2QozZ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D721514E5;
	Mon, 13 May 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606568; cv=none; b=uOPmUh03J2FZ6pHhzmKgl3g6RMDOj5ygtf36pSBoV+6C8gX2WGbZY/LiQeNYRgl7CoOcPEOG5zQq8XiCA11ML0D6a11pT0aDFJDV/d7veItjy7pHdmM+0TngAUcBB3TBlxj3MFTD2QPJNnxkN5oPnymgzvDoxZ55XEktPBPpDWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606568; c=relaxed/simple;
	bh=lGR/JTEovinL3WNGbtd8OB9QpmQr1FfHG7dzJAzXTU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DLTRUi02Fi4YMfgXRAj0plzzI3/Y+TsGDn66npAX7rooZLnbMypyI4ehuo4TBmGQPnENHNWVnmmVcFGRDC5qqgawHew3CIoBH7j+EnZCf7aR3EV1N+nTKUgWkPSuLM9ICBPrHQO+ynAZoQxjR8HYS9mvGlHC8TZpwGIAbgA5sRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lvJ2QozZ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ABDB947C38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1715605990; bh=lpf6OUFZvm7ObQIuIT3AZZ2LQqZ6RrgRPjzd6o2GDF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lvJ2QozZIYvV7Jhup+iJxGOO0xSdy1/3hOb0/Wfx/N1jq/norVViXbs3WjUSXoi/Y
	 S90RmL03HVEIgSwwvPum1L2qbWlrrdPk/q9ZIAlqzQCAMKQiV9m9Ex0FL3jrHQ5KhH
	 ONV0eZxdIW7H/hh9GARRYGKOjvhT0J8iDW8vLZjzID6B7qg1z2QtTdWfLTbQybC1vg
	 K0u5vAjBKjomM0ucp88hRQht/28ch80Hbu33+oQ3IP4ABz0VDMFMJ7i11Wxz/4NKKK
	 DXP1NkIB6bcJKDtZLbGlLH/vZjRD8JV9h75Ah9VQ9n6lSg1U9xlUgMDuSUMfSvvQ1K
	 /LO4ig5/NHBIA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id ABDB947C38;
	Mon, 13 May 2024 13:13:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Diederik de Haas <didi.debian@cknow.org>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] docs: dev-tools: checkpatch: Add targets for checkpatch
 tags
In-Reply-To: <20240513102237.112376-1-didi.debian@cknow.org>
References: <20240513102237.112376-1-didi.debian@cknow.org>
Date: Mon, 13 May 2024 07:13:09 -0600
Message-ID: <878r0dam8q.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Diederik de Haas <didi.debian@cknow.org> writes:

> Make the tags directly linkable by defining targets for them.
>
> Closes: https://lore.kernel.org/r/8090211.0vHzs8tI1a@bagend/
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  Documentation/dev-tools/checkpatch.rst | 216 +++++++++++++++++++++++++
>  1 file changed, 216 insertions(+)

In addition to the other comments, I have to add: you have said what you
are doing but not *why*.  All of these labels clutter up the text; what
use will be made of them to justify that?

Thanks,

jon

