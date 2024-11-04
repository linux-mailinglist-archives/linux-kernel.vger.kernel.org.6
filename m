Return-Path: <linux-kernel+bounces-395049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29559BB7CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2204A1C21FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CBF1AC88B;
	Mon,  4 Nov 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="tNznIsLm";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Dni0tHAU"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA625185B4D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730577; cv=none; b=q9c8EZ2Hz9yw//RVWJRmR4x6gD6tFLM/PbBM/ml9+WXCH1PKwSRvxlYtgL/vdLMx3pd/qg2t6dRscH8QZagvYL+7pyd6kfFhNp7SGhxyoondbIhCgT0R+9FgoF6wHczdBIKas6YuziXcASNDBBcLt+aho3dzdjlQfy9EZ7e8abg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730577; c=relaxed/simple;
	bh=ZAdw3ycbQtDIRnnmmbxv15KDyRbeiPm8mNAI3lRZvbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=URM/GzSXro3xIITk4y/+8aeKF80S+cNhVAu6jYa8ev93tqZaWyDPGkNLJ2UKcDFvHqBXZ6fOhH64PJaVagyTJodJPWiokpwTrvmhYgWFShBbq/9UbwWaFTrm2WW7wGefevvoojMxyU55eZzc03NL/hIyyKP93Wa5xwtS0L8Pc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=tNznIsLm; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Dni0tHAU; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730730575;
	bh=ZAdw3ycbQtDIRnnmmbxv15KDyRbeiPm8mNAI3lRZvbQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tNznIsLmEFEazrnPe8pjZ629KrZYVVhe99MOhdfuc6YIEeh+YN7HOw9tXiSoV9ZSE
	 jpzAYUrbfupPU7zJ6sYoMpGpsE6WJMWgws4huCsH3EzaxhEnDwiomXI6yd2W4mhJiV
	 sECGowtPyZlSUiioYMMN4xnyQs0PiMpalmaUt4To=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0D0961286ACB;
	Mon, 04 Nov 2024 09:29:35 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id zX46con-PA7d; Mon,  4 Nov 2024 09:29:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730730574;
	bh=ZAdw3ycbQtDIRnnmmbxv15KDyRbeiPm8mNAI3lRZvbQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Dni0tHAULbW+8RXiRM5YlYfaFPNsSK61f2PJXCpvf6T27XvcjShxeMzqN0D7nl9vY
	 yVTdFb3q7wYAh3gAs91Ww+wugTQGEguZDU5wR+8USB07xd3ZW8cMNwqvotUrvqOpKy
	 HdsJZRH9XJGGD5ptBd6h31djvOY0gs/3s2vadJKI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E967F1286AA4;
	Mon, 04 Nov 2024 09:29:33 -0500 (EST)
Message-ID: <83c50ab23fbe0727edb489b3d59264896331ce40.camel@HansenPartnership.com>
Subject: Re: [PATCH RFC v2 2/2] tsm: Add TVM Measurement Sample Code
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Alexey Kardashevskiy <aik@amd.com>, Cedric Xing <cedric.xing@intel.com>,
  Dan Williams <dan.j.williams@intel.com>, Samuel Ortiz
 <sameo@rivosinc.com>, Lukas Wunner <lukas@wunner.de>,  Dionna Amalie Glaze
 <dionnaglaze@google.com>, Qinkun Bao <qinkun@google.com>, Mikko Ylinen
 <mikko.ylinen@linux.intel.com>,  Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Date: Mon, 04 Nov 2024 09:29:32 -0500
In-Reply-To: <5ef943d9-1ce6-4b20-8c6c-7cba4f1b3ea9@amd.com>
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
	 <20241031-tsm-rtmr-v2-2-1a6762795911@intel.com>
	 <5ef943d9-1ce6-4b20-8c6c-7cba4f1b3ea9@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-11-04 at 19:40 +1100, Alexey Kardashevskiy wrote:
> On 1/11/24 03:50, Cedric Xing wrote:
> > This sample kernel module demonstrates how to make MRs accessible
> > to user mode through TSM.
> > 
> > Once loaded, this module registers a virtual measurement provider
> > with the TSM core and will result in the directory tree below.
> > 
> > /sys/kernel/tsm/
> > └── measurement-example
> >      ├── config_mr
> >      │   ├── digest
> >      │   └── hash_algo
> 
> Do we actually need this many nodes? A digest is 64bytes long (or 128
> chars), hash_algo is lot less, "config_mr" could just print 
> human-readable 2 lines (one with the algo, one with the digest), just
> like many other things in sysfs.

Actually, that's not supposed to be like anything in sysfs.  Attributes
are supposed to have one value per file:

https://docs.kernel.org/filesystems/sysfs.html#attributes

However, as I keep saying, this structure doesn't support systems, like
the TPM, which can have multiple hashes per measurement register, so I
still think the structure should be

<measurement type>/<pcr number>/<hash>/digest

to allow for that.  I even think even Intel will be forced to use agile
cryptography one day: even if Shor's algorithm isn't realised post
quantum, the hash and curve will have to expand to at least 512 bits
and there's bound to be several candidates plus backwards compatibility
problems.

[...]
> It looks that /sys/kernel/tsm/full_report is a binary concatenation
> of 6 digests, with no hash_algo and no hint which digest is which,
> hardly a "structure". I do understand it is an example though :)

That doesn't sound right: the rtmrs can be extended post launch, so
this should be some type of log of all the post launch measurements to
allow the relying system to examine the events as well as the final
value.

James


