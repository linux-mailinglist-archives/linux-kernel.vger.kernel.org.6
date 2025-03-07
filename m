Return-Path: <linux-kernel+bounces-550729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29088A56359
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632C216C871
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD571E1DFD;
	Fri,  7 Mar 2025 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HZGOpmwZ"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A42E1B4254
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338911; cv=none; b=JndTKuuhHE6S8SJEi/bNch1YHqFXg7Fz1wzSMHYbLQlMCZwrcrJXNXx3BYpvyGlG00wytoiwkBGH9FE787OU5t+PR4kPvGsDZbN0cO4c+UtP8dn8lC9KmFMEID9S12xxZ+7T/UaWn8qeU2HC8V7jsJmVSXTZBmggKfirP3V8/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338911; c=relaxed/simple;
	bh=oV+Zmq3swvvGTbNPzuFOkRVQV5N1AJGr7hewufWRdkQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tpz7qUPElEQlQdNwKU4R2P0MMjK+SbPE8VUqhDfRSQr/Ox3+4b674GWuPJ04j8WNy6yRnwy8t4n4MgfVC53WvQbkQNhxXP+XCVs9SiIlSVE+ir7QHyF7JO7MT6MvGV1huJN5NZYhksYdoB8CEz+GL7JJaEXHYze68sqRW+nir3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HZGOpmwZ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741338903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oV+Zmq3swvvGTbNPzuFOkRVQV5N1AJGr7hewufWRdkQ=;
	b=HZGOpmwZeDtvBshXRH9pxbogeLnwo9LSdNDNaB+0LJENivrNNg0mfNorlL+UckmbPPm4WL
	5yKXdzkJlGY3CES+E6SyFmkWFtig0/Am+TEBKh645jko0SqRYUq0xs+szA1neQP+ZPKUvZ
	mznBiNcRTnW88pPqVxZHjI81RAJJC1E=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] m68k: mm: Remove size argument when calling strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <e5e10808-5cca-243b-304f-4aa8db1d30b6@linux-m68k.org>
Date: Fri, 7 Mar 2025 10:15:00 +0100
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5216B227-6174-4C0A-9126-B8861473A0D3@linux.dev>
References: <20250302230532.245884-2-thorsten.blum@linux.dev>
 <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com>
 <e5e10808-5cca-243b-304f-4aa8db1d30b6@linux-m68k.org>
To: Finn Thain <fthain@linux-m68k.org>
X-Migadu-Flow: FLOW_OUT

Hi Finn,

On 7. Mar 2025, at 00:24, Finn Thain wrote:
> On Thu, 6 Mar 2025, Geert Uytterhoeven wrote:
>> On Mon, 3 Mar 2025 at 00:07, Thorsten Blum wrote:
>>> The size parameter of strscpy() is optional and specifying the size =
of
>>> the destination buffer is unnecessary. Remove it to simplify the =
code.
>>>=20
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>=20
>> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> i.e. will queue in the m68k tree for v6.15.
>>=20
> The commit message says "simplify the code" which is only true if you=20=

> never scratch the surface (i.e. it's simple code if the reader is =
simple=20
> too...)

strscpy() automatically determines the length of the destination buffer
using sizeof() if the size argument is omitted. This makes the explicit
sizeof(m68k_command_line) unnecessary, so removing it shortens the code
without changing its behavior.

Both macro calls expand to the same code, and I find the shorter version
simpler to read (this doesn't mean that strscpy() itself is simple).

> Commit 30035e45753b ("string: provide strscpy()") was a good idea. It =
was=20
> easily auditable. But that's not what we have now.
>=20
> Patches like this one (which appear across the whole tree) need =
reviewers=20
> (lots of them) that know what kind of a bounds check you end up with =
when=20
> you ask an arbitary compiler to evaluate this:
>=20
> sizeof(dst) + __must_be_array(dst) + __must_be_cstr(dst) + =
__must_be_cstr(src)
>=20
> Frankly, I can't be sure. But it's a serious question, and not what =
I'd=20
> call a "simple" one.

I'm not sure I fully understand this part or how it's related to this
change. This patch doesn't change bounds checking, it just removes an
unnecessary macro argument.

Thanks,
Thorsten


