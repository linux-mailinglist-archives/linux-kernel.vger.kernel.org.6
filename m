Return-Path: <linux-kernel+bounces-346437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A23298C4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAB31C2383F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198411C9DCD;
	Tue,  1 Oct 2024 17:45:42 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10183A18
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804741; cv=none; b=gLi6KFE/zIZnsxa0KxWvm2STncnR8ju5l8CDFXOZeGOLMbvj0AsXw0hbFVRhPiR1z2+Cih07kPxSxgPkL1pBxgafUoCLqrMUqhb3Hrk0NvPnw1Xh8ejTgna1k2VkFcA6MjJZGyCq7L1jaovv3p9cUNTWfeBnOEFKBVIBoTq046Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804741; c=relaxed/simple;
	bh=DLrGVR5I51eWZmQVsVj3sBzGYoZJ57oy66lwlKYAoIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NZHEbZD55KQVOUELD2gwpsNhWWxhaUkiy8jWTT6HyizjKHA2bv8Cvk+VgDTjznr5lKzv/edkmsUTzdhQjt83Ijn6kJ6/OEb93SuX1CldrfrSq2z3cbMXcw6BSviLLVCEJNt9gjOluVDX4TfxqVhU8l/zjCRv/F+DgGGFCSiO8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XJ5222qJZz1sCHZ;
	Tue,  1 Oct 2024 19:45:29 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XJ52162xwz1qqlS;
	Tue,  1 Oct 2024 19:45:29 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id LF78uprEGrCi; Tue,  1 Oct 2024 19:45:29 +0200 (CEST)
X-Auth-Info: 7h5n5BAu6U5VB0e9OLmE9R2wPe05A0O7O44zh54h4945uSrLdX2X5kjpbnesZ3MM
Received: from igel.home (aftr-62-216-205-6.dynamic.mnet-online.de [62.216.205.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue,  1 Oct 2024 19:45:29 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 8E6732C19B4; Tue,  1 Oct 2024 19:45:28 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Miguel Ojeda <ojeda@kernel.org>,  Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Arnd
 Bergmann <arnd@arndb.de>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler-gcc.h: Disable __retain on gcc-11
In-Reply-To: <Zvs5ZHCc4MGkE8XK@kodidev-ubuntu> (Tony Ambardar's message of
	"Mon, 30 Sep 2024 16:51:00 -0700")
References: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
	<87bk0d2c51.fsf@igel.home> <Zvs5ZHCc4MGkE8XK@kodidev-ubuntu>
X-Yow: OMNIVERSAL AWARENESS??  Oh, YEH!!  First you need 4 GALLONS of JELL-O
 and a BIG WRENCH!!...  I think you drop th'WRENCH in the JELL-O as if
 it was a FLAVOR, or an INGREDIENT...  ...or...I...um...  WHERE'S the
 WASHING MACHINES?
Date: Tue, 01 Oct 2024 19:45:28 +0200
Message-ID: <87bk03zphj.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sep 30 2024, Tony Ambardar wrote:

> On Tue, Sep 24, 2024 at 07:29:46PM +0200, Andreas Schwab wrote:
>> On Sep 24 2024, Geert Uytterhoeven wrote:
>> 
>> > All my gcc-11 compilers (Ubuntu 11.4.0-1ubuntu1~22.04) claim to support
>> > the __retain__ attribute, but only riscv64-linux-gnu-gcc-11 and
>> > x86_64-linux-gnu-gcc-11 (not x86_64-linux-gnux32-gcc-11!) actually do.
>> > The arm-linux-gnueabi-gcc-11.5.0 compiler from kernel.org crosstool
>> > fails in the same way:
>> >
>> >     error: ‘retain’ attribute ignored [-Werror=attributes]
>> >
>> > All my gcc-12 compilers seem to support the attribute.
>> 
>> That ultimately depends on binutils support for SHF_GNU_RETAIN (2.36+).
>
> IIRC from working on the original patch, older linkers which do not
> support this 'R' flag would simply ignore it and not error out,

The assembler gives a fatal error for unrecognized section attributes
since binutils 2.15, and emitted a warning before that (but the gcc
check uses --fatal-warnings).

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

