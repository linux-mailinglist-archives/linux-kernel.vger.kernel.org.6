Return-Path: <linux-kernel+bounces-317737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8609E96E30B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2211F274ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE3918BC15;
	Thu,  5 Sep 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="oTL7derR"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FC9154C0D;
	Thu,  5 Sep 2024 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564073; cv=none; b=ICofjLA5Wsj4d+wmoM1Pydh0IRO26KZi76F2EYanL3MNF8xMp1sIx9jx1QRxJ120RZSncyLcjsLf/0F6N87oK0YXZ074krUGdWnG/eDnHwgNqDmhcwDu8MAmhADjiIWUD/ZVpUnV8JzEDLqaGmtYPQn/yH2U8vEmmWKOVakGMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564073; c=relaxed/simple;
	bh=qNQMBeI26xquITfvfDfCCw/hqV4JRWLizdX65mwYFKk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TUrLIbl0PD0b2Obtx+8EbDC4lE4EYVaxekE6ZrXaXecgWDL1Cm9EtoSQv5EUEKVwbm9/XZVkkMYyqt4m5D1DEOpYqWJBxA/ts5SLZFNMw9ywd/fVJKKLrcqVeegURBl/OZsyb/7cQMA7YA5b4TxFJ7p6BpWMiPijWNltjJP8NlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=oTL7derR; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2A6F142B29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725564071; bh=AzSd8iuwXxps37fo6A9UbQLK84K97jQS9+j9ZwKbwH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oTL7derRl1H8ouZzTVEWzB/3o3S8BwgaDQYb0anRXESFOQCCT/eVHVHgLrNg2R01I
	 CaGkv5WjtZNu6VbXjHAbKU1PRmWdPdxb1bs43z/u6Et6w9v0u1l4hL8F9ug7cxK9W3
	 AqJo1uiuPm6CW0u5aMQ7y8BRv+VTSj1Yr2+xD6FRESPRG3TlTsGRO6RuVrqdolsp5B
	 fVXZx34/tPwqPztUtQsrxy90vMPIHQHuyRBs2TPcFtuIoa/KYmSQWKVz8cLWb6eNyl
	 vfI396jv3w3CXHDQTuN2XgjpT1NTz76btagev0uFpW2uZ0ODBASZo0gDTQdgMA1S7u
	 91lu9C9Uo3hHg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2A6F142B29;
	Thu,  5 Sep 2024 19:21:11 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Takahiro Itazuri <itazur@amazon.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Takahiro Itazuri <itazur@amazon.com>, Takahiro Itazuri
 <zulinx86@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH] Documentation: Use list table for possible GDS sysfs
 values
In-Reply-To: <20240903132533.26458-1-itazur@amazon.com>
References: <20240903132533.26458-1-itazur@amazon.com>
Date: Thu, 05 Sep 2024 13:21:10 -0600
Message-ID: <8734mdj49l.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Takahiro Itazuri <itazur@amazon.com> writes:

> Using a normal table, a line break in the first column would be
> recognized as two rows. Uses a list table instead as in MDS.
>
> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
>  .../hw-vuln/gather_data_sampling.rst          | 36 ++++++++++---------
>  1 file changed, 19 insertions(+), 17 deletions(-)

Is there any chance I could get you to turn this into a grid table
instead?  List tables are entirely unreadable in the source file...

Thanks,

jon

