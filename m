Return-Path: <linux-kernel+bounces-281944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B7E94DD53
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 16:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F63FB2142A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0B7158546;
	Sat, 10 Aug 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="k0LhWTl0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766A12F399;
	Sat, 10 Aug 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723301179; cv=none; b=UH6xTCR8Fjud44gpf/lgSkJ4LyT0q7EbFUT0I7Iz/zdX9wXn4McWt/d08FrZ0EMDbbAUOmUlidb7mzAgUpWqh6oy9G93oRvZ2/UHeAtdv9QEq89ZeXEZ6Fi3ZU1aafQT5MleEulQssBjO3OOshLlQtwa+A9l8hTrXiFcs3UGozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723301179; c=relaxed/simple;
	bh=lzHil6Qwan2T/SFedUXURTFzXLXrrYCBaQGtSTWh73U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TEFKJBsRyvxjZVoov0PfXHaIb/TlqSjH+tte6VsbRz+t/tIHDXV//MQIFF3x2Z2UDHhOy6EPJ5zxxwqFH2MXss4psHV92mI/W8jwvw7Cj85qtM7YZpcO5pATKs1Efddjr9jV13Oe9Z+WhoGPEihrxEMpASYNxCJEtn0dHx/5ZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=k0LhWTl0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BD5D8418B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723301169; bh=lzHil6Qwan2T/SFedUXURTFzXLXrrYCBaQGtSTWh73U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k0LhWTl07PptyoJ/9LeGGbytdQdy0jpFORA6gFCMihgitB1W2kibv6CUBXU4ctJUr
	 MmtYcUQPqhgWPk+QvHJVK2zmpHSyTNLP+Zq/b7OzYlyFdR/xtARlKushHkfEXVNBl9
	 M9Ga9BgCOTtP97q2ps2YYXqEvIdo0PgV8AdZmz20s8dYgPB46+H12cv0L7GSnhmnAW
	 RXrmm52ROOXB/3PKjq3FDC9D+0V7ZfyDbHX18PiqRDko74Zn7t/1IFqyGIgrHeyYIS
	 A/x28fBdF61dn+xU2aBHW3cBilw891pvSAJV6arLtqsGzmYOK1CDSdPx2pbgubpZ5q
	 O3N8Yh+7NhOMQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BD5D8418B1;
	Sat, 10 Aug 2024 14:46:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,
 Bjorn Helgaas
 <bhelgaas@google.com>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Sergio =?utf-8?Q?Gonz?=
 =?utf-8?Q?=C3=A1lez?= Collado
 <sergio.collado@gmail.com>
Subject: Re: [PATCH v3] docs/sp_SP: Add translation for scheduler/sched-bwc.rst
In-Reply-To: <20240810100955.14901-1-sergio.collado@gmail.com>
References: <20240810100955.14901-1-sergio.collado@gmail.com>
Date: Sat, 10 Aug 2024 08:46:08 -0600
Message-ID: <87le14bfm7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com> writes:

> Translate Documentation/scheduler/sched-bwc.rst into Spanish.
>
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> ---
> v1 -> v2 typos corrected
> ---
> v2 -> v3 typos corrected

Thanks for working to improve our docs but ... if you find yourself
sending three versions in less than 30 minutes, that is perhaps a sign
that it would be good to slow down just a bit and be a little more
careful.

Thanks,

jon

