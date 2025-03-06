Return-Path: <linux-kernel+bounces-548834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABCA549CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C173188DE77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB91A20AF78;
	Thu,  6 Mar 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYBbgkAn"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD131156225
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261189; cv=none; b=TCG//LuCEj7Kww4uD8CK2deyoNW48WIpSwrPHWp3tCJt/NU+j4Q6qrwlREKGTXfLBqTanROS3ph+ycFy1rwiKddvqUu80opvJnByXYaStu678KUzA7/KxhkQQfGFhANqsvlYQw80szZhE6291zI3pNdeu9iav+idHdPgSuYu8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261189; c=relaxed/simple;
	bh=r8MoCqYNCe4c9qiwvRf0xvcKFpCn1DtHAUefcThDDSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxL10y2MYTZECnuKslw2DSNozSpCCw2ac3OSKZ2SdzOC1LjzW6pT+hGbPGo1aovwGw4u+exqE7bcY+DE4jPq/bPbymD5gDTA00qhrxWNUU+seiZq+da6ILmR2CkTzCvk5maOqsI2Vg9ZL7gOO2jgzuxmpGUIRqfrrtKIoHMAG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYBbgkAn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fea8d8c322so1224832a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741261187; x=1741865987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9sq4YJ2DQyZHH2kbpoDNtjyXycKYdNphmP6Nz8SeIk=;
        b=mYBbgkAnFlE+onG9dd6lF4sZAWFuLaXIbj/IUViab9BlITFHcExT1s96AJdSVwjRJE
         gUAeQ9EYVfo0h+K3RfYtmR+q3fIRVlteAcF7jyLyNzKQhiOSvEhBqysdUCbK1BYdUSTs
         BLQpgsNhR9ZJTkySIN0qZ33dCJALHeagCMUMgPt3tkFS5L/e/OJzfwbaDKZ8dgJRsvAI
         /HWWKDfqHB5Nv8FTyGlcoEZz7obFnvhSn6PlsfX7QqUUEJQU0jjM6Nz6R8I6smempo/Z
         2yV+Lz/O7DlUjIHQG9zkq+oofMuckZR5C7IVsh4WxKQQby1/69kNnBNsG8AUb+YmQaY2
         AiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741261187; x=1741865987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9sq4YJ2DQyZHH2kbpoDNtjyXycKYdNphmP6Nz8SeIk=;
        b=qGbBsvmjq96BqdJLIF+iF1YVrp4zSQ+u5FXVU5kg/GETDT20nVJBOwE6E+HllTD/PR
         oIOxIYT38ChQT1THxdoasWo1HsYjDAVvJMANSC9kSe6LyXddlUrSrTagoomj7KcSODKd
         aXSsFKO7quwi1U8pZ5zzgYGW4TxMbyDWDEAk4YeRWn66GG6rR7mxikWYG9Li7cgAaR1A
         wfKWbvgXaDGsj71TYx3nghV1wumbMptUgRNhb31j2qIf+y/rFssDNk6w9/GqZxtxB/wo
         FI9lCbMPyr7a2QZchHlyVCM5yfYKkLgnCSTHt7a6ySKZwaL3nCvrpAFf3YApzOGdn0qL
         +vRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsCYx1qf2a2TQH6Gvy49mjRF24UYnytAZWk1T76iuor8l5CZcj5qRFhs74aIytPr5o8Ef226YSOlzyjB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwajijGoFZeizn5uijLUjLVMv46t5m9756icau7XZNFWkFG9IKv
	TQa5myJPDXGafOsvkLvzMUtYuxw2E4aXVBbQPIr+sePbkOd6JSwUVR+g/d9+gamZr7dKNyuk1tl
	GqrPdl59etM381WSEmmEHmAvS6Gg=
X-Gm-Gg: ASbGncvKV8h2ivCCl+vRxUsds3kL9RNioJfVhFg9U335OBSySHuna40SQmZVfzaVxNQ
	5s2tsMJ6QnEibltFn4NhOl7YjaBWD0SUiTsaMHb2tqddt1nRZGajhmp9TXVraA2jCbepgxy7xxb
	XpJwSFEQCI3YvdgbmM+AShhP+gGg==
X-Google-Smtp-Source: AGHT+IGs0+c/x0S+rEnB9r9arTUQu+Vq33cCnvRawv0eZWYUAB4OlHgVB6iO4SL5SpyXzI91b16wKcUF2KfbZN7iDSg=
X-Received: by 2002:a17:90b:2494:b0:2ff:556f:be1 with SMTP id
 98e67ed59e1d1-2ff556f0c2amr6549409a91.1.1741261186979; Thu, 06 Mar 2025
 03:39:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211063028.382169-1-linchengming884@gmail.com>
 <20250211063028.382169-2-linchengming884@gmail.com> <e5458a0e-528f-44ec-a0f0-543472ad3b85@linaro.org>
 <bb9f8a80-4662-4ab1-b9ad-6899977c3827@linaro.org>
In-Reply-To: <bb9f8a80-4662-4ab1-b9ad-6899977c3827@linaro.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Thu, 6 Mar 2025 19:39:34 +0800
X-Gm-Features: AQ5f1Jp7ftJJkR8tfGcMH27z_ma1ePnjFVkBFADoZ0Hv_21ZXLggZXYjswmbA0A
Message-ID: <CAAyq3SamyhtCkd47939dKWCZN3ejaDvM6EJzwizWVqhNW=27bA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: macronix: Add post_sfdp fixups for
 Quad Input Page Program
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2025=E5=B9=B43=E6=9C=886=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:01=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
>
>
> On 2/11/25 7:20 AM, Tudor Ambarus wrote:
> > On 2/11/25 6:30 AM, Cheng Ming Lin wrote:
> >>              .fixup_flags =3D SPI_NOR_4B_OPCODES,
> >> +            .fixups =3D &macronix_qpp4b_fixups,
> > For your next patch that'll drop the redundant flash info fields, you
> > can drop SPI_NOR_4B_OPCODES as well if these flashes define the 4bait
> > sfdp table.
>
> Any plan in doing this, please?

Sorry for the late reply.

This matter is currently in progress. Since collecting all the chips
will take some more time, the project has been delayed. Once I
have all the chips, I will start the verification process immediately.
Thanks for the reminder.

Thanks,
Cheng Ming Lin

