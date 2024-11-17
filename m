Return-Path: <linux-kernel+bounces-412062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E117D9D0346
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 12:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F792B2244E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFD1547FB;
	Sun, 17 Nov 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Bvpzp0A2"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3653EA9A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731842961; cv=none; b=nq+H1UOVdv64WB6tP3lf5bG96gdzpoJ5QYc2sKiP9bsLP0dY86td1AilAtVBb7v/UaVcc/Q9wdaQmXGz7rrMMRWtiMioEfmTShxfC2oHMeKqigFpQ0LLz7xo2fpaQ5qo362Kofxqodb79HKFN6Gi1TgOpGLbDa6YNQgVOI992aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731842961; c=relaxed/simple;
	bh=PSBb+Fx6j8MqoaoYmqM6Mk179B1/iW4dbopQjEhK+JU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCl0lQ//7PHOl3ygk7+XHJr842YgFQcK9nZzKAKpaTw/3T/VRcSVwPMNp8LUT5qOXY9I72mj8mGy41C57COvYB0hkZmHgrfhUNIo9FqUj+hji7PxZoY0ZeEwcEhW6pNjitx6PqVo7305RRvOWrdsSJ+xZQak3R39FAbuWZmCPSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Bvpzp0A2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731842947;
	bh=LwloFIxi3u3sTNfvSTU4Cv52KouL8YzkskRDutCjz4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Bvpzp0A2UCD6/jvuPEqth7dkLgcz6V6FTxMxZTXN1UcyMzVaOauCZOWsW2IyA7003
	 zsgjxBTRvpo3h9YkvL6h8bViy/NV3Rh++1+pJrIwhvo8He73EveEH09POo5/oX/So3
	 7zEvQT/AkvqNGb0kJG9kLMea1MoctyHLKyj7gkLCW9p+Uoh8O+AeejGXlZJaMtGBaa
	 BDosg9uVw/ckhbw1bRzE1auLJtwYMhbcrhTFR2ve6T7oadvH031DYYfe3hJiVPvsuR
	 q07q0Le0/gUWjBKNzDPDAOALCp6ZNrwYXNu9FdpxvByKy+73LaNGdwR5JPoTVZELuT
	 59ZSFTlPehK5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XrpS23y4fz4xD9;
	Sun, 17 Nov 2024 22:29:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, geert@linux-m68k.org, arnd@arndb.de
Subject: Re: [RFC PATCH 08/10] macintosh: Remove ADB_MACIO
In-Reply-To: <c1c01965-ac44-4d8e-aff1-3f6169bdd3cf@csgroup.eu>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <20241114131114.602234-8-mpe@ellerman.id.au>
 <c1c01965-ac44-4d8e-aff1-3f6169bdd3cf@csgroup.eu>
Date: Sun, 17 Nov 2024 22:29:08 +1100
Message-ID: <87mshyxfnf.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 14/11/2024 =C3=A0 14:11, Michael Ellerman a =C3=A9crit=C2=A0:
>> The macio-adb driver depends on PPC_CHRP, which has been removed, remove
>> the driver also.
>>=20
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   drivers/macintosh/Kconfig     |   9 --
>>   drivers/macintosh/Makefile    |   1 -
>>   drivers/macintosh/adb.c       |   4 -
>>   drivers/macintosh/macio-adb.c | 288 ----------------------------------
>>   4 files changed, 302 deletions(-)
>>   delete mode 100644 drivers/macintosh/macio-adb.c
>
> What about:
>
> drivers/macintosh/adb.c:        if (!machine_is(chrp) &&=20
> !machine_is(powermac))
> drivers/macintosh/adbhid.c:     if (!machine_is(chrp) &&=20
> !machine_is(powermac))

Oops, missed them, thanks.

cheers

