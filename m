Return-Path: <linux-kernel+bounces-435365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEF69E7699
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E13C165C8F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312711527AC;
	Fri,  6 Dec 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nAD3iraQ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573FB20628B;
	Fri,  6 Dec 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504537; cv=none; b=QLNIjnTih4U+7dtnZPXMXWsJQ3h42SIBJq2Gg3Z8LVve3hIdA13EpjR3OmCCHjpG+4XM3Fe8npn1f9rr2PpyvyqDk4C8Vkey5M+i2cxOzXkmX1m9lg0vyT5Iv0ApR6dvlCNFsDR73u2mxaFvhITvqG2Okc/yDyi4pELZprcD66o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504537; c=relaxed/simple;
	bh=yfenPM9ODdWg9R4e21a6fn0/25fwjaFiu0cv69tMrZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2qnlo2kMws9Xjvn9y4d8i1dJ9gyXGWQcoXbYVUeWPf6l+1aOCradz72TthVdmOhCG9SbgcfRZ5WvD8r9RZ2wYhYfq72fW416LKsMew5p0gas7evVeGPtb+yxlbX/Q3RkxWlMylMwUWT1ID6zK5x34T2H93BTud/K0Fsl6V/YFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nAD3iraQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 71F94403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733504535; bh=qoYyWO2Qf+oKhBLSxdz/BPi+iDGhwGeVa29pxC1vl3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nAD3iraQBMb/D1dPlbUU4yY1TrK/dkSxIulIrmySJyCXfDD4kTTVAJ9KOMaGD+eoQ
	 qz78BxxMiWqNfU/YC9ySE6ize8QXYMIB+D4P/omVazfubYbptbH+r2VqPJW+dYwRW/
	 E4/QJ6aUvhmv+SgccHHKn9QbhnQyT/jETxegBjCJAv7aDcQeScW024IRszm4Ut8mB8
	 ZsHjjyFZviGM8d9va9IqMgT2e6b+iOYF+4qPjNufYxfRg8RTawLABMI3xsJDwoM1QS
	 81oR0+yyu+P9tcy0AN5q0NRtyj0KW1n3PkBhPxidLEA6AfUKRbxwWuihwqGGy+dl4z
	 dzLjF29oTi4fA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 71F94403E1;
	Fri,  6 Dec 2024 17:02:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dave Hansen <dave.hansen@intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 0/3] x86/Documentation: boot.rst: More style &format
 fixes
In-Reply-To: <639b9aef-456a-4f13-84f3-555a0da9672d@intel.com>
References: <20241128152546.2396782-1-andriy.shevchenko@linux.intel.com>
 <874j3gu5at.fsf@trenco.lwn.net>
 <639b9aef-456a-4f13-84f3-555a0da9672d@intel.com>
Date: Fri, 06 Dec 2024 10:02:14 -0700
Message-ID: <87r06ksq21.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Hansen <dave.hansen@intel.com> writes:

> On 12/6/24 08:47, Jonathan Corbet wrote:
>> How were you thinking of getting this one upstream?  I can take it
>> through docs if that's what's wanted, but would like an x86 ack first.
>
> It all looks sane to me.  Going through docs works for me.  Thanks, Jon!
>
> For the series:
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

OK, then, I've applied the set.

Thanks,

jon

