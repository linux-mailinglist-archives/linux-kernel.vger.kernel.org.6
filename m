Return-Path: <linux-kernel+bounces-310368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EAA967BD5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 21:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CD51F21839
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13470502B1;
	Sun,  1 Sep 2024 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JVu7ETfq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9f4A2HIF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169F42A9E
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725217278; cv=none; b=L3lgwnHoOpQv4XyAMzEyGwZWrrtUK+LOBxrm4RFqSDgXKK8tATzF5h/Hi0drv9a1TVJdGWMAxbdC5U+XbgYgg/+BHVLR7mAAmL1tr2Bm4Y+4ghAh0LisgcLt3X5kLZByHGpTZ9icdV7RZ7oc7zFicp0A0b4eO5nqLOQwfmVxisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725217278; c=relaxed/simple;
	bh=8HtcUiLcMM5sR3w8AhpC3DIbHKHIpe+RUVi9cJm6fQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O4zx5Y5R6Ho90EDtw55aVPpZyMMSjtRlrVJMl3wTH9k9KIZUuWnBvWIQdFvOc3LMGbvvVsoNcrQWmUYZqdVnBAvd9KgUdxk+vTyUCvaF8mxYMBBRFZkizRwD90T5YjukD0p1qYzypGbsSOuqPmt99MM40jJguV1Qd7TIAqcA5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JVu7ETfq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9f4A2HIF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725217275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cXfkiBOlf/RqyhNT+w6XqIZjnQZ/10/eK5LzncWRuc=;
	b=JVu7ETfqZAmFpE1I5ms+M31J5rXAcHbak8Y4P2y8hWahvXAGFA1PFykysLuEVg0RbeTwXX
	X4zhx7C3o+Zuo7DgloujyZOsUqvRaxQFJ4MpNy/eqB5q0x9Epe0MdBhrcV2K0lHRHE/vZP
	6k2x9IpWSu3czdgqIWHiNGbhCehvV/vjJQ1qu+IuvLtpMn7spjzKKkeFwU/wGDqGqivBct
	6D/7IOKP6aq5SGJhB9mv954NrcsTu84B2YWk7atzLaD9Qt7oKklhq8JbXWCM0Vh7PlmJ9/
	vlOHTXehdYocExdOJ/mcMJz1b2M7L+WNG1QEJWZO09RdIS/hYkIX4b97tnC0QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725217275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3cXfkiBOlf/RqyhNT+w6XqIZjnQZ/10/eK5LzncWRuc=;
	b=9f4A2HIFGUS2kswaD/CBaTeOzpCGlZG0wAAJwfl/czkD2qW8g/G+uySRxSADE28c6azZg7
	By2+fjGtXb32WmCA==
To: Chen Yufan <chenyufan@vivo.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com, Chen Yufan <chenyufan@vivo.com>
Subject: Re: [PATCH v3] timekeeping: Use time_after() in
 timekeeping_check_update()
In-Reply-To: <20240830015459.2937-1-chenyufan@vivo.com>
References: <20240830015459.2937-1-chenyufan@vivo.com>
Date: Sun, 01 Sep 2024 21:01:14 +0200
Message-ID: <877cbv8ah1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 30 2024 at 09:54, Chen Yufan wrote:
> Use time_after because the open coded comparison 
> does not handle wrap arounds correctly.
>
> Signed-off-by: Chen Yufan <chenyufan@vivo.com>
> ---
> The modifications made compared to the previous version are as follows:
> 1. change the type of timekeeper::last_warning to
> unsigned long because time_after() requires its
> parameters to be unsigned long.

The change of the struct member wants to be explained in the change log
and not in the version history. I told you so, no?

Thanks,

        tglx



