Return-Path: <linux-kernel+bounces-430408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B19E3095
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0027F282891
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B34A06;
	Wed,  4 Dec 2024 01:00:59 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CD63D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733274059; cv=none; b=B1+uC0n9kLtPrYz1UFrK4B3ltpZ1dgPPJ7Snacmz5yUz2tJRn88AwO64eGn9u+Hd6H8Zb95PW4yHmYa8C1XW/sdZHcca8No6YMJI3msjrkkVbRLuzc2huRggiBoOCD1FQFqOAOe4wRVpMCpHpTM8hOgdDZp3VapBVocmGJ8Qd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733274059; c=relaxed/simple;
	bh=/lQLdECaRezrUJgMaHGlGz3SW6AauzJ2QRxRn74zMJ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FISmaLnXwFYVl2W8XQ874ML3h6DqyGRpZJznhEbG9v6orDL7Ia3GiOa0rfAV1zbDO9iyE9KlbrvHgC/PWOfPE5t8iBWYbxEFAxo7zTkbevQc8RJ56lyd72AE1S4UK/HuCebPQCJurZzh49XN4tWq/5+jvV5Gn5CQ16bIF6KT+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tIdkI-00000000590-1zBW;
	Tue, 03 Dec 2024 20:00:02 -0500
Message-ID: <e63226d5a0e3e2c942202972c099617aee999c1a.camel@surriel.com>
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use
 it in nmi_shootdown_cpus()
From: Rik van Riel <riel@surriel.com>
To: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>,  Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Date: Tue, 03 Dec 2024 20:00:02 -0500
In-Reply-To: <20241203150732.182065-1-longman@redhat.com>
References: <20241203150732.182065-1-longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Tue, 2024-12-03 at 10:07 -0500, Waiman Long wrote:
>=20
> Another way to fix this problem while allowing panic() calls from
> NMI context is by adding a new emergency NMI handler to the nmi_desc
> structure and provide a new set_emergency_nmi_handler() helper to
> atomically set crash_nmi_callback() in any context. The new emergency
> handler will be invoked first before other handlers in the linked
> list. That will eliminate the need to take any lock and serve the
> panic
> in NMI use case.
>=20
> Signed-off-by: Waiman Long <longman@redhat.com>

I've seen that panic come by a number of times, but
never came up with a good fix.

Your idea certainly looks like it should work, and
avoid all the issues along the way.

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

