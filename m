Return-Path: <linux-kernel+bounces-513762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAFEA34E61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727F216B2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A969245AFE;
	Thu, 13 Feb 2025 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PytED/t5"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F2206F2A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474559; cv=none; b=PlVdokg8xTWhkvlSkVgIbAeCLJEfLaP8ouH1AVFRp4oaKlxtO9rFEJ3KMHdHSB2XDBVeEO6UuUyvpCuM5dyqNpJTceEwkU79vO2DWsOFTY4RFPpGTAskHFoispgKAMuETmkO1ISHRx8J0m4DO7PM9lQywQAOTeT8XU3ZoXIwnCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474559; c=relaxed/simple;
	bh=2JThloxUyfyuhVrqHr9s4DN08EuOJ1ZLg2Fj1NEToYo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ANT78fQQPQr5aD2heQOb6YpGgCZKGuBA/Ami527pByLbU+/EgS3e+KR7NVsvMhBg1n/BM6nfoeQ8Klj6sb1DYBgfiRKTDUrm7qijs7ZFoQttjMRGAUKLKjsytx/1LJFP+A2XrK8XRvfuz7TIxDHql5MdTI06ibFIxz4SGMnan+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PytED/t5; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739474554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JThloxUyfyuhVrqHr9s4DN08EuOJ1ZLg2Fj1NEToYo=;
	b=PytED/t5cu7u/liNMVixD1Es1RTFKkCVbdQSteskYtODi3aXRW4wk/vOSTLfJO2u1D9rCS
	zl657A59/oqFY3xXLecXGcWJRngc461QPH74tH5O/aBjNmIJAvJtv3D0o51hXQ+kIz83i3
	kCHVYJoCGDYxg6TIgeyJOZ6Q3IhzV3M=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] scsi: hpsa: Replace deprecated strncpy() with
 strscpy_pad()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250213191455.2249104e@pumpkin>
Date: Thu, 13 Feb 2025 20:22:20 +0100
Cc: Don Brace <don.brace@microchip.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-hardening@vger.kernel.org,
 storagedev@microchip.com,
 linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4C0B65A-27A4-4FD8-8A70-4C07B8090A58@linux.dev>
References: <20250212224352.86583-3-thorsten.blum@linux.dev>
 <20250213191455.2249104e@pumpkin>
To: David Laight <david.laight.linux@gmail.com>
X-Migadu-Flow: FLOW_OUT

On 13. Feb 2025, at 20:14, David Laight wrote:
> On Wed, 12 Feb 2025 23:43:53 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
>=20
>> strncpy() is deprecated for NUL-terminated destination buffers [1].
>>=20
>> Replace memset() and strncpy() with strscpy_pad() to copy the version
>> string and fill the remaining bytes in the destination buffer with =
NUL
>> bytes. This avoids zeroing the memory before copying the string.
>>=20
>> Compile-tested only.
>>=20
>> Link: =
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-=
nul-terminated-strings [1]
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>=20
> Wrong.
> That will truncate maximum length strings.

Yes, I sent a v2 to fix this already.

https://lore.kernel.org/r/20250213114047.2366-2-thorsten.blum@linux.dev/

Thanks,
Thorsten


