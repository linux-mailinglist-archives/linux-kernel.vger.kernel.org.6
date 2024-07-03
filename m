Return-Path: <linux-kernel+bounces-240068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8143C9268CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386B91F22EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4A31891B6;
	Wed,  3 Jul 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="AvkZ881r"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA67183075
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033373; cv=none; b=uc8ZblTj0+GZ1iyQEb8CRxJOfeahNJU/6N0nzV0HmKSEUUmU68X3EOeDe1h7xOEOmQ5/VPx1dTlmgT1/di1cvdPUVwhMLy5yToR6VlGLDfgPp0qJPmVB8rWvgM4urOBemmHnHcbNIsxpj6Tz2MnJdqibIizEi9RaRlKcqco8Q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033373; c=relaxed/simple;
	bh=NCK07WgmJilnpjTCGxUktyi8UNtcBim7wUs73C1Aoss=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I3YQCtadCrfBZMNqxlSXg8LcY+b6xFIdCpDfHkbSHBNaQEU3+mJWlofBBkKr56yxZMXbFSZ9oYMaJ8vOkxxLa4RFTXSsfakTwkIdBjHWXOBd8ce9dG+E2VblHh6NddFvOZ4XnXSdqkG6THmKPfYqmm+2BxZTKYiSrvuiBUbPEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=AvkZ881r; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa244db0b2so46692705ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720033371; x=1720638171; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR2WZFpu9F/eyrknYOVvW0A0ylVQU6Yd0yqZ9Xzk2UM=;
        b=AvkZ881razoEo5WBNwOTfGuhVNA9rpWsUdrMy1iMWYhLpzMnS8U6KONU80l0TGcOev
         WLPA8kZIeAqR87lFNwm0DeIyV2qWu6kImY44hhIIqIfvka6/5Ggc/9QrQ0Q6t0aMesHZ
         FiUmnB22VWTPePXmncYjHUZFKZfEjf2lOImCxyg8JO8aQybUxZf/6Aoy+a1k/msY8bDH
         TnIPOIjqs89btE2xywFxyFiFObRo7zUKQ7oA0wPgu6tXmQXWT32wSAXqyVVJzibXDmTq
         FeerNm3+4k9wMaZYgtbLO1hPURX46T0stl48oXg235EdS3kb3aLOHYE7xmJQ++5Uj0V1
         g7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033371; x=1720638171;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR2WZFpu9F/eyrknYOVvW0A0ylVQU6Yd0yqZ9Xzk2UM=;
        b=leOiqkJn+AfFT4GTQtiSHAf8uLm/42V/G/Tu80YaDzea5u4OLVDQahhP5Ax7glZ3w+
         S+sPx7kk0UUfew8rm7QU0bnBGnO/qRUZaT7sPwixNs9EN1HYlO0V9gbIMj/bchE9j1LA
         yHAJzGv7jn8t82y0TszyfClLaBRGAXeODbR/8QdsCLX81w3J10OjLRuw5NPVMM3Y8XWf
         jFZ2Alp15cMhNg93Pkp02P1Z2BoDDF6tyctk4Q1EU+ccQmaD+ZKUwPZCz1nE5A81qb6o
         7TLogdG6TteJkfOXd08aD90y4IXB0CWaqA5f80hhVSfdVarDJBF73J6mXvvn4tsihKQk
         cLJw==
X-Forwarded-Encrypted: i=1; AJvYcCVdHBOeIdmlPOT9jDvTFw2XAO9XmU82BpvhnEGsg6ro7TdNOcsR8sZ4BC8xDGU+mmrQ8sX9vQZIQw0zIw2/qC8M0EhyczQV4xPYA9e3
X-Gm-Message-State: AOJu0Yyd8FtWQ3mFPjJhTQQP0KkLO2x0yIp0UuDv1oHpBuAAxTtT3rS8
	I5O7ZDAOeGsCFmxzeqrNSFrAiGV0z2B9FAaSzfqqUGS62pUqhQeYopRbBZIBYbE=
X-Google-Smtp-Source: AGHT+IHOXF6EBNQCbpT1v/yymwkerRoZt4wfhxb5Ia/193m68mpPf++GQAxANRbGvPnXQGS+XO5Phw==
X-Received: by 2002:a17:903:1c2:b0:1f7:2d45:2f1 with SMTP id d9443c01a7336-1fadbc7f2d8mr91782835ad.15.1720033370590;
        Wed, 03 Jul 2024 12:02:50 -0700 (PDT)
Received: from smtpclient.apple ([2604:3d08:8e80:cf0:34b3:a7ec:924a:312f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596d55sm107100645ad.277.2024.07.03.12.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:02:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] m68k: cmpxchg: Fix return value for default case in
 __arch_xchg()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <CAMuHMdVTqsqrDTKGTGoLd_3FPk9S6wX-qXYzipJ+6yW0q0L11w@mail.gmail.com>
Date: Wed, 3 Jul 2024 12:02:39 -0700
Cc: gerg@uclinux.org,
 dhowells@redhat.com,
 linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <21C8794F-EA8A-4C4C-A51D-DA7D6900CC74@toblux.com>
References: <20240702034116.140234-2-thorsten.blum@toblux.com>
 <CAMuHMdVTqsqrDTKGTGoLd_3FPk9S6wX-qXYzipJ+6yW0q0L11w@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.3774.600.62)

On 2. Jul 2024, at 00:21, Geert Uytterhoeven <geert@linux-m68k.org> =
wrote:
>=20
> Hi Thorsten,
>=20
> On Tue, Jul 2, 2024 at 5:42=E2=80=AFAM Thorsten Blum =
<thorsten.blum@toblux.com> wrote:
>> The return value of __invalid_xchg_size() is assigned to tmp instead =
of
>> the return variable x. Assign it to x instead.
>=20
> Thanks for your patch!
>=20
>> Fixes: 803f69144f0d ("Disintegrate asm/system.h for M68K")
>=20
> That is not the right commit.  The issue was introduced before:
> Fixes: 2501cf768e4009a0 ("m68k: Fix xchg/cmpxchg to fail to link if
> given an inappropriate pointer")
>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>=20
>> --- a/arch/m68k/include/asm/cmpxchg.h
>> +++ b/arch/m68k/include/asm/cmpxchg.h
>> @@ -32,7 +32,7 @@ static inline unsigned long __arch_xchg(unsigned =
long x, volatile void * ptr, in
>>                x =3D tmp;
>>                break;
>>        default:
>> -               tmp =3D __invalid_xchg_size(x, ptr, size);
>> +               x =3D __invalid_xchg_size(x, ptr, size);
>>                break;
>>        }
>=20
> Although this was not a real bug (__invalid_xchg_size() does not =
exist,
> but is referenced to cause a deliberate link error), it is good to
> clean this up.

Thank you for explaining this. I was already wondering why I couldn't=20
find the function definition.

Thorsten=

