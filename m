Return-Path: <linux-kernel+bounces-515732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F27A3683E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE9216E6AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384F1FC0F1;
	Fri, 14 Feb 2025 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KFo2QU8K"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B611FC0F4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572047; cv=none; b=sBLUZBiHg1VliZjKYqUIreaNa81xbM5EcfsIFjBtIqIByTr+mc8MjgAPs9y/Zr0yDwgLSIQf/C0YGgxyq7PQzd+0v2NQZfCkk5uV59nKljIcmexUJO48sIzlYU/5GdTaFIm67T9pWWqKdRmHCMcWUjuPc6fNXf4YWDHfLdzBGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572047; c=relaxed/simple;
	bh=PBbNBcIUzTTSdz9tVw4pdA/QWKQr5U/yTQvU7YXGWdI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YoT34Zxut+rKD6Uc7ZOAKEZODgJ8YRLeXzwzOyPgjeS+ODsm4ljf6BkHjvf2y14nmP9BkJeOIZHn9NLqHqBkAOkpQWSu8xRLAX2hpP04Z1MqW5ObTDZ+2Z4+lkWomZK4eVOwex70+Gy93jBhJEnYj3+7nnIHeDEF2gEI3b2d2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KFo2QU8K; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739572033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBbNBcIUzTTSdz9tVw4pdA/QWKQr5U/yTQvU7YXGWdI=;
	b=KFo2QU8KPWyXHnULt/2kQRKYCq51Vlv9GbZ1JS5HdlPvahulfeEfgSMYCh3HqZmA1ZKfJK
	j+6kReZbc3QYyKY1NBUsfk2uxeMNWxrzVEd01H6J9A5AdKWLJ/ewNwQ62gvwOBM8/TUope
	zJBW22EfFYHyeiqVA1b94Os6pYpWUbE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH linux-next] tracing: use strscpy() to instead of strncpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20230124121703.1e3a1ac4@gandalf.local.home>
Date: Fri, 14 Feb 2025 23:27:00 +0100
Cc: yang.yang29@zte.com.cn,
 mhiramat@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 xu.panda@zte.com.cn,
 linux-hardening@vger.kernel.org,
 Justin Stitt <justinstitt@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <13330090-9D89-4AAE-B59E-7353AE319654@linux.dev>
References: <202301091939219689840@zte.com.cn>
 <20230124121703.1e3a1ac4@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

Hi Steven,

I was about to submit the same patch when I found this one from 2023.

On 24. Jan 2023, at 18:17, Steven Rostedt wrote:
> So the above will *always* return -E2BIG *and* not end buf[] with '\0' =
as
> if strscpy() returns -E2BIG, then buf[] is not guaranteed to be
> NUL-terminated.

The return value is not used and the strscpy() documentation in
linux/string.h says:

"The destination @dst buffer is always NUL terminated, unless it's zero-
sized." and "Preferred to strncpy() since it always returns a valid
string, ..."

Has strscpy() changed since 2023 or could this patch be revisited? I saw
that Justin also made an effort in September 2024 [1] to revisit it and
to remove the deprecated strncpy() here.

> NACK!
>=20
> -- Steve

Thanks,
Thorsten

[1] =
https://lore.kernel.org/r/yhv3rzg6vhgwage27cyvg72t4vwf5x3tdtj3zjipryzvz3u5=
5x@c33q753uxyi3/
Cc: linux-hardening@vger.kernel.org=

