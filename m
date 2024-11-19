Return-Path: <linux-kernel+bounces-415028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A99A9D30D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D38283D82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2E1D2715;
	Tue, 19 Nov 2024 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gR3R1FjX"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216D417BB38
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732057910; cv=none; b=SgOQ1rtUwVxxkh8/ZrPoWPXMJ3xVQnt66ht5q6VKt34aSWn5sKOt5D63FSrCfVixGTwkcNkAiUvrVvWKoQmEzVUaOAp9HzgEdlK4ZSGGYW+4oU9cgrQAZ8TXBCuWvh4m1RLRThZDJGD62i8dBhmc/4B61cLqGPQdSADRntrvYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732057910; c=relaxed/simple;
	bh=zjJV71WkzGL/bOhiEY3AE6fRz5GkyYrLQMtV98PgjZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A80Kx2w7mqK0wp2g1UXBS/uyqOIT5gtsEK7ebjgU4QGwU2lWU+e6rJ3ydUDMEpVyFRekFhDHvBMQKKkJgEHmuQOpqQ2T+dEMZ+/0cjrjKm2Yc4+wON8IX8XNHqQqC4kwgEcQec+glP26NgtW/ujTmC8A+K8HSq/0iRLL92kdeGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=gR3R1FjX; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732057896;
	bh=zjJV71WkzGL/bOhiEY3AE6fRz5GkyYrLQMtV98PgjZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gR3R1FjXUX2v+ysac7N2oTEbccebCURUjTU/DDFXrURMssYftDedF0C3tODDXpYH9
	 k5kgGaQUUIDI1B0nNBV7TkXbCO8svc2bqGGWnkc/pccHI/owxIUBA5WLQTyeSXb6JC
	 wy5NX8TpHc8JQ+WMa83V8KhLkn9/WI2JodrzGkLsdD2y5c+G5JefeRfM4CtxpaGIVk
	 hjnXIZaAViHQgzuCa+1aSTxRiBg+oZKiVqJFWaLXX0TEcavlar4dYff/MruNMt3UXo
	 We6ULeFkiRejaCkmYMGQZTrbX/yuHvH/NvIF6r4dKb9yPNnYz/1BnVxzSt0eSjqW2q
	 i/w3YlDSCLY7w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XtKxh1dVVz4xqb;
	Wed, 20 Nov 2024 10:11:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [RFC PATCH 09/10] i2c: Remove I2C_HYDRA
In-Reply-To: <CAMuHMdWtqNsmO=t=OF-2R-gA+khuKiGQOrBXRigE62bNjnUxPg@mail.gmail.com>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
 <20241114131114.602234-9-mpe@ellerman.id.au>
 <CAMuHMdWtqNsmO=t=OF-2R-gA+khuKiGQOrBXRigE62bNjnUxPg@mail.gmail.com>
Date: Wed, 20 Nov 2024 10:11:37 +1100
Message-ID: <87y11ehl92.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Michael,
>
> On Thu, Nov 14, 2024 at 2:11=E2=80=AFPM Michael Ellerman <mpe@ellerman.id=
.au> wrote:
>> The i2c-hydra driver depends on PPC_CHRP which has now been removed,
>> remove the driver also.
>>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thanks for your patch!
>
>> --- a/drivers/i2c/busses/i2c-hydra.c
>> +++ /dev/null
>
>> -#include <asm/hydra.h>
>
> Looks like this was the last real user of arch/powerpc/include/asm/hydra.=
h.
> drivers/scsi/mesh.c still includes it, but I don't see why it was ever
> needed in upstream.

Thanks, I'll remove it in v2.

cheers

