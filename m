Return-Path: <linux-kernel+bounces-240290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7D5926B65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8707C1C218F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCE518C35D;
	Wed,  3 Jul 2024 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gsVE7toF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A3142651;
	Wed,  3 Jul 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045132; cv=none; b=Hv2PifsKQwQXoCGOh+ktFg7esST94UL7Tb/IjyYDQXvTeToyoSKWDzrcB79aIK9gbsY9yNFQhK4xLLBHgWSYxUiXReE6qJPDqG+O6C8NkZQ6maxm5nYrSvRfToZ65TZPHUEwR7CPVBmtkqZf74m8ORoPsXA6iM3UlEGk2FiRYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045132; c=relaxed/simple;
	bh=fNMX6LNmh16dMiXO4z7x3irE1n3zIQb3P1oUmSudkEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kf4P9as/3+7+3cIdp9i/0vMB19CRDUcxOIMoq5ziS9l/TFfO/vJwdgUB/Lfm11MCPDnFBqbpA1O4SXO5PqWii8pG77+rCASA7JccUxzRt+bgj6U9blrQwMx1nbLo53/Xrui7C8sMaQHSZ4lPBIvJ80nT8RpUNVhJCrw4iYQNlto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gsVE7toF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AC9D84189E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720045123; bh=/WvdytxKpPkmEjUXLYygIM/cKdrtdeWcy4Sbmhrp2c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gsVE7toFwGGZooLQoO99u1rbVDXKW+oeLXti6mY+a6w/DarlPNndVXefowsSnwpGG
	 VWQRCGHIR5kqBcrK4CxTUesCwzYGFfs2hXM+IRomIWbjZPZYObIWbhmMsJcnitFN0t
	 Gy47VCw9shVKduFJBjQtH9jtFQVNmel2+CKPzgCWi3MU17rS+cjR8BXDiDTxZ0Sjxq
	 kSVWpd2euQd1UyaGXwwh2C0lNIApAH8OnJyAi8VM4kv62K78jyNNH+tpMD+oKgNySE
	 mvIW43T8oZIy93w1QE9RiVoSDiN4RV7vecwjRAC/HTvTjXZRIPSc19+gDoq5SAsXOZ
	 CFJm9hHIx3x4w==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AC9D84189E;
	Wed,  3 Jul 2024 22:18:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Docs/mm/index: move allocation profiling document
 to unsorted documents chapter
In-Reply-To: <20240701190512.49379-5-sj@kernel.org>
References: <20240701190512.49379-1-sj@kernel.org>
 <20240701190512.49379-5-sj@kernel.org>
Date: Wed, 03 Jul 2024 16:18:42 -0600
Message-ID: <87msmyt8zh.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SeongJae Park <sj@kernel.org> writes:

> The memory allocation profiling document was added to the bottom of the
> new outline.  Apparently it was not decided by well-defined guidelines
> or a thorough discussions.  Rather than that, it was added there just
> because there was no place for such unsorted documents.  Now there is
> the chapter.  Move the document to the new place.

I'll take this for now, but it's truly sad to see new documentation
being added to the slushpile at the end.  It seems better to create a
"development tools" section in the new outline and put the allocation
profiling document there?

Thanks,

jon

