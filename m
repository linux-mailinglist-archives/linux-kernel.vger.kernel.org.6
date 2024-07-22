Return-Path: <linux-kernel+bounces-258874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF564938D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3651C20D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346F16C437;
	Mon, 22 Jul 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl5bn9u7"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8714F9E7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644357; cv=none; b=SsibAfQqtX2f7FOE0YMIs00qU1z/j8bWN/u1jWCihodyaujrYvC50BkbZNxSfxYeGacaBmwtAnVRzdDG89tXnOoneCUY67/yIyDSBUUsBC+MLf9Mt8Iq966VTtV/iO9pNFdCQzvOhDXyVi04nvdLyGqSMaIL5Pqt8/3S/ivO/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644357; c=relaxed/simple;
	bh=lzxrng2ips9k4km0fNurQAEEStELmLC0Wc5XsDbqmzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT+d6NJPmQ57BdZrRPzXn5v+bG+bIJmDZvNVvQ9m7nv5skKjMG5KtDqVEc9Scah6MiwqfUsJulxT8DiHUcwWzqEUsDas3+ngP0GXx/Zq4DlLJT9kFYuDik5BDZF9eQ+5LHgyljB6322v2QVyC/gCDUpaIpucTH44LelzpRvma34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl5bn9u7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd9e70b592so3941115ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721644355; x=1722249155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzxrng2ips9k4km0fNurQAEEStELmLC0Wc5XsDbqmzs=;
        b=cl5bn9u7kYBhL/TDY1aFo7KFZWkfvQNKnzWyHigqOAC+T7b9y3uEZ/slpsXUemSBTm
         OaL24J8cB+vwpXGHCN1taygWp9fkwrCD9JrVmccULfyoD+vsvJV6HPJ7pHZyVJ2Ayi5H
         pBSNAOWM+FKiAB8fooOF0ceIJpGVubV/k4v6WhRNT/wj0luSBYI/lMS0TkOLxvO9pxiJ
         X+ANqshjwwv5ON/Nbxj6+Krc2TGfskIU/GE63VwukoQLWrd7qP2ypuFvX14c3rku304u
         T4P0xj19XWhd9O0FlD7V5wcaTJ3m33HlrJGzeNWrQyGUclpH/5O7RGuPp3ZX/IbHXGzU
         ZZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721644355; x=1722249155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzxrng2ips9k4km0fNurQAEEStELmLC0Wc5XsDbqmzs=;
        b=qR5gjzMg+n05fsjukUvahzVxf1jzr16VL5c4Ae95ASIROgAxlUhH5DNTPDXPqBoLqY
         R6ICB9OD6SkSjy5yW0UQCCzKLRyQLH46ZTvfOneVpKOLS2VxmyU4xA7b3TgibPvuZWp1
         snbjZdFttDNGS3NxtMzt5wyU7b9RK3yqsd0c+GUEYZm8JLAV6qNV1tG8pWEhGi8rZ0rL
         SLS1BRnrhAlAskCQfqO/4DiJFnnZ8yHRhSgnSKLLsAXE4KDFirUp29baS8/tQopZ0iPa
         uOl3LFVDeTUIULz7pBLal6QNIRlwFQ0XUyOqrimDUex8LZz6YnkjgaTjLW0K1cmLemNs
         DkVw==
X-Forwarded-Encrypted: i=1; AJvYcCXMF2KAH/mj6gCZuXcNIYU7GHycbwPAtAuqnIJ882ubvt38GfSldxUBUYcWcFIVv6OI8fElwIvbXfMoT9tOZv1d4iiKfj1j8Vs6x/1u
X-Gm-Message-State: AOJu0YwRp5T9pAOybmV1Zom/+EeX3ixXlnaIpzQ6LcMLWZ3xlrMIUdaW
	HUOd4qBZx1EW80+WDSkMK2Tu0OcIxe+N4Jxg3atY9E334/vW+wCe9hMBUqYU7M9khNMtZC3MVOO
	q4rim/+Sq3G0WbNpgYxpGwc3s49M=
X-Google-Smtp-Source: AGHT+IH12NObTTgq+EuiB7GVeSjPcrP/tKmAkOKK1AbEOE90Kfz+JuJCIHE6zsm345U+8TJMhqbYIzl/vSCbFkSoxyQ=
X-Received: by 2002:a17:90a:734b:b0:2c9:90f5:cfca with SMTP id
 98e67ed59e1d1-2cd274dabb9mr2774216a91.42.1721644355292; Mon, 22 Jul 2024
 03:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722084952.608770-1-linchengming884@gmail.com> <D2VYGD0191M5.30VXXMSA7N267@kernel.org>
In-Reply-To: <D2VYGD0191M5.30VXXMSA7N267@kernel.org>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Mon, 22 Jul 2024 18:31:26 +0800
Message-ID: <CAAyq3SZ91aK=r8S+u0aWNsR3g6zoVWp7Lx51B1ygCFBe-kH5Fw@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: Add support for serial NOR flash
To: Michael Walle <mwalle@kernel.org>
Cc: tudor.ambarus@linaro.org, pratyush@kernel.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, leoyu@mxic.com.tw, alvinzhou@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Michael Walle <mwalle@kernel.org> =E6=96=BC 2024=E5=B9=B47=E6=9C=8822=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:20=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon Jul 22, 2024 at 10:49 AM CEST, Cheng Ming Lin wrote:
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > MX66U1G45G and MX66L2G45G are Macronix serial NOR flash.
> >
> > These flashes have been tested on Xilinx Zynq-picozed board
> > using MXIC SPI controller.
>
> I've asked for a changelog. Now, what you've sent is a v2 (of what
> seems to be a split off of a split off). Before sending out another
> version, please carefully read:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>

I apologize for the misunderstanding.
The lack of a changelog is my oversight.

> To be clear, please explain why this is a split off of the larger
> series, what has changed (or if nothing has changed then state so).
> Why did you split it even more (before it were two patches).
>

The patch Jaime previously submitted included support
for octal DTR mode and added the new octal NOR flash ID
with RWW feature.
However, these two things should belong to different patch
series, so I split them apart.

The reason for splitting them again this time is because
I think that adding support for the octal NOR flash with
RWW feature should be proposed after Alvinzhou's v9
version, which supports octal DTR mode, is accepted.

So, I independently added support for serial NOR flash
without RWW feature.

> Honestly, back when Jaime submitted these patches, I already spent
> way too much time to review this stuff just to get it dropped or
> handed over to another employee who then comes back very late.
> Please align your workflow at Macronix and get an internal review
> and some training how to submit patches upstream and don't put that
> burden on maintainers.
>

I apologize again for adding burden to the maintainers.
Moving forward, we will ensure everything is internally
reviewed before submitting patches. Thank you for your
patience in addressing this matter.

> Thanks,
> -michael

Best regards,
Cheng Ming Lin

