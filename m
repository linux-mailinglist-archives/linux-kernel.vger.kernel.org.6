Return-Path: <linux-kernel+bounces-300384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D2A95E308
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7A2281F06
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B4D13DBB6;
	Sun, 25 Aug 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9XL0DvZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02hsZpPU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6F801
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724585037; cv=none; b=GKj1zLbPX7DIMkyn0HZWkOvamu0KIEmXuUGXrj6fzS+8HwIogwSP3aMhwJ6pXfWqgOR7bC54Y5Gf+vNYaytpX/k+OycMpeIjyobkquBT5rHD6IaZLMdXAtSuRROS9Ce9Bh4wS9b9SpbxMmZhHQZXPS/5nj/vbc7eGsJmqmxmjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724585037; c=relaxed/simple;
	bh=phIBximGO8C+QS5XjbLmi0ZuHk5KlTRqqv2vvuGoYhU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kvbkhJr1bszyjgtY2bMlMpvJhG0aRXqg+ks99bdqd7G8+PYowNmWjdkmSpMXD1y3QxyCeqzy7lxdieH+ehFovKfbhMYL/3Ih4yjbAXdh4SGLOJ/VK1I+IGV8SA/LjtDe1tMxOBZqHmpbZoWE+yi5Z/G+PSBAuJRf+hHFsmDlkuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9XL0DvZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02hsZpPU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724585034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5zECInlo9vw8WRSoMIP7Ro8+1Ly6STN1jxbYOdY6+k=;
	b=q9XL0DvZY4pp1UItL0lnzH7omYGoqaVNbEhUKfW7/SF/vHJeCvxU/k5EPmtLZFn48/MIwY
	0wJNbtspXLObkln8H2Zzzwlr3b/6uBn63oCTWzl5t/vWqRyinr/OpMFhCvyevqCVbn/QOo
	M6u3B7NHQyoiPcIKK7e9RLLVWc4t5XLtFhpriVV7DzN9JW5fB0FC7TL7YhzBMW4Hn9av9p
	6mKGHVPhfyew/yLYPOHXxLP8xVV+3dIzPXpr3KxGEhkSRcsedOWFAy+wBGzme0flaDAL0s
	mqOXHLGkbYKky+9DWGpmft5PCd8ZVfWs+PRknNeqHKzgMd3qnjbhznOIKIRzqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724585034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5zECInlo9vw8WRSoMIP7Ro8+1Ly6STN1jxbYOdY6+k=;
	b=02hsZpPUqcHGG7mXCK24rgRCEMDnw0UJagg6gzoqJMxFeTkPDroU5atjXwLXUxpWRIfwo8
	AMjjOXu/237fA5Bw==
To: Chen Yufan <chenyufan@vivo.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Chen Yufan
 <chenyufan@vivo.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: Re: [PATCH v2] X86 architecture (32-bit and 64-bit): Convert to use
 jiffies macro
In-Reply-To: <20240822082449.34601-1-chenyufan@vivo.com>
References: <20240822082449.34601-1-chenyufan@vivo.com>
Date: Sun, 25 Aug 2024 13:23:53 +0200
Message-ID: <87h6b8g81i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 22 2024 at 16:24, Chen Yufan wrote:
> Use time_after macro instead of using
> jiffies directly to handle wraparound.
>
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
>
> The modifications made compared to the previous version are as follows:

Please put such version information below the --- separator so tools can
strip it off when applying the patch, which avoids editiong

> 1. Remove extra '+' in the header.

The subject line still has a incorrect subsystem prefix:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

Also 'use jiffies macro' is not really informative. Something like

     "Use time_after() for jiffies comparison"

makes it entirely clear what this is about.

> Use time_after macro instead of using
> jiffies directly to handle wraparound.

Also here instead of 'time_after macro' please use simply
'time_after()'. It's uninteresting whether this is a macro or not.

Thanks,

        tglx

