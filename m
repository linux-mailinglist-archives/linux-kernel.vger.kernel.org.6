Return-Path: <linux-kernel+bounces-435338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A6F9E7634
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC160288648
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780BF206283;
	Fri,  6 Dec 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="f7gYNgkj"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467E20626A;
	Fri,  6 Dec 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502999; cv=none; b=OsfB3ZgRdosygKdVbW/xtUYj7x/l4BYQwdEcqCI2QMQc1Q8CXS5tEl8m4ay03pi5TUMGCa69cdtcEJvVyQxQeEd9VIfr+NLWsMVKhIPkgkSx3Uhr84CjD453Jk47JsJgSkVga85/doqlPIpDwazJOZHdtt/rAGWkehrHTGb9BZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502999; c=relaxed/simple;
	bh=UT/s6Z+qXoJK9X///j9ZNhlZGMn6BtvYjOz52KRCCww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uWMCCeAUUjlUM7FQOpJaRksFYATq/YjkVBviL8d4Rax28o6FfLrPI8vE7WDe2BDVSJWVu2P8y3pxJiFWHp1tcbKFlMm46LHig1yqA33VhoQ8VLW7On1au3QTXugjhINNH+07C15kdGEMc3co+gX/sxGHZSR6D/IdixWu3E6R5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=f7gYNgkj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5E130403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733502997; bh=JwIAgTfyF70TLKWq3TFDEXub86tWAYVvyzoSVJbrCTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f7gYNgkjB9VNlZtVuokBTczWhranSGQ24lZog8uT16DV5v8w6TFsqWy62vucvYoTl
	 IX66nnvlWFDCPwOC5sQznTq0+STam4iKokb+Ba0hvITrmEWb9IdIAVnOncmnLRLd5d
	 o0ryrPpI96OVGXwZzDJndp/m42fCNy+b3cku6f5VsME1n5GRfRuTlacdncpgjD6W5V
	 QCIZOhfNVxvxVhKE2ThXNIJnXC3C24prVnZworQNqRWL+rEz/CY26LdbiTUpKWebY2
	 TOTnbDXKirbq1y8NsVzWZxcz7BN+nbah7UR6erFSAgGdLBgi6hXbs+j9lFQ+2q1E3w
	 cw1NYdwRo/y/Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5E130403E1;
	Fri,  6 Dec 2024 16:36:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Sebastian Fricke
 <sebastian.fricke@collabora.com>, linux-doc@vger.kernel.org, Johannes Berg
 <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, workflows@vger.kernel.org
Subject: Re: [PATCH] docs: debugging: add more info about devcoredump
In-Reply-To: <20241130081107.552503-1-rdunlap@infradead.org>
References: <20241130081107.552503-1-rdunlap@infradead.org>
Date: Fri, 06 Dec 2024 09:36:36 -0700
Message-ID: <87ldwsu5t7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Correct a few small things in the devcoredump synopsis and then add
> the devcoredump APIs to it.
>
> Fixes: a037699da0a1 ("docs: Add debugging section to process")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sebastian Fricke <sebastian.fricke@collabora.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: workflows@vger.kernel.org
> ---
>  Documentation/process/debugging/driver_development_debugging_guide.rst |   20 ++++++++--
>  1 file changed, 16 insertions(+), 4 deletions(-)

Applied, thanks.

jon

