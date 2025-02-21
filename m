Return-Path: <linux-kernel+bounces-526597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441A5A400C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD11441926
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D89F253B4A;
	Fri, 21 Feb 2025 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bLIP6W6N"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFC25333A;
	Fri, 21 Feb 2025 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169498; cv=none; b=hro5uVir42wKZ9np7oEQ//icwSsZ9oguXZt4bIi4CEuTfVyAXTKQcSAA68nJbhfi90YFrgkxJ9SBS2vN8SOdKilt9DrXW0IC7MBKmpK9GqppK9S9AMpnuher5PUsS/avDZAx0m26vXV7hcLpt/XNbwSsdcyxVcD+zHkP77/Shxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169498; c=relaxed/simple;
	bh=bevx+wSluSqWoO5l8ljWh/CaoRN1/CG+nKKg9IxZTfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qWmsFXa3cBkz9VcphM5SA+GN4GMpwyfj4mCwc0Y1kswYcuTUC7OVOdtLoyl6CNi+VE5SMEAYGDirAJ4TdsyaaaEa0t0BZeCRP2gu4edVfiNfoWZthu/QEeCrFkbdfQqs505Y0zoxGF0LymxlGAK9k9sOoqL+HSi7pow4zvNUA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bLIP6W6N; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DFFB9404E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740169496; bh=80w5SdSbcL18mhDzRH7GeyE4C1Z/Lu7UZLIH+V4NHIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bLIP6W6Nex+kMU8HNmUTvRYBLtH6JzgM/e+KbVH9O28PYRa1c3y4vtM+RMMn1TdZ8
	 DJJophpo19P76/AkTYJDvo2wqU/Qz8raHjygW8jF3Uv1XbLokYbZUQPe6kpt/k0dDe
	 GPuZL0K3hc4asgNNdh68N/QxIlS5ENl1hWC/qy4SF82kWmGKryi15sQOagONSwBmor
	 2Rl+3UrALuACiQhVRZ4bUdZtV5XmclOL+ADen58uCn9wiF2xt8kouokEYhLd713omM
	 oS0SseCZwPCJ6GGQ6+3gniJ+ZGP4ziQhAwiGA3fWuR8GIc7pxKUQjaUAsmDn/8S0M8
	 FPAxjB7GR2j1w==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DFFB9404E4;
	Fri, 21 Feb 2025 20:24:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] additional fixes to kernel-doc.py
In-Reply-To: <cover.1739972906.git.mchehab+huawei@kernel.org>
References: <cover.1739972906.git.mchehab+huawei@kernel.org>
Date: Fri, 21 Feb 2025 13:24:54 -0700
Message-ID: <87msefgi5l.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> This series comes after:
>
> https://lore.kernel.org/linux-doc/cover.1739952783.git.mchehab+huawei@kernel.org/T/#t

From the previous discussion, I was thinking that a new version of that
series was in the plan, right?  Just so I don't lose the plot...

Thanks,

jon

