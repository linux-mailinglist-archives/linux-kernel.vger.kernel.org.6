Return-Path: <linux-kernel+bounces-269603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD09434BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B079288C42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE8F1BD4F0;
	Wed, 31 Jul 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9GytN5n"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9A1A76A1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445846; cv=none; b=p8wSYdWkm6lqxArbfd1ZvSQCISYsgcmkdTZeEU3bu7pfmnZjQjkLFtsVODmGtnUhjX/AoWWbAOkCGUsNeIeGP8xsLYq7HwfYD6LMtB2zOp+JucZ+ESgs58f78RSAfggNGDqCPNvjkKGN2YF/dizZVk2tIguahYKzoA1MO1bEckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445846; c=relaxed/simple;
	bh=DG9Dsrk5EbbKUqbUuC/SLfjiErZu07ODQyjNbdBQFKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpXTpuwmwiTetxG5SiiSLSg4VXN98Ht30QqfnW6Va2NyntA3PCJCrFr+1NFfH9imwnlDYDyfGUOItIzK4o3HKE9qyh1/4cx3zuvB+kdApdQqq2DI+/aK5TLmzjBp0jGp3t/CO7EbqRojatNL6QGvihOWro3ILthz+bPux9Ra5YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9GytN5n; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64b417e1511so47899687b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445844; x=1723050644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG9Dsrk5EbbKUqbUuC/SLfjiErZu07ODQyjNbdBQFKM=;
        b=h9GytN5nwBTYfLXPQS/7MfFx/Cisp2sMrLJQJHORcLHLB3LaWRGe8atIvjIb2BG4Od
         S+k1zVVAH4auKS8k7XHNNZgjih1qWtIe7u3DhPzSsI9/WSZ/lOj1Kab516vOqPokh71P
         8hFxOS7Ll/qZf+N7NTIa3uinkuq7kdXLNc850HPZa7yz0AiWMk9zpF2mVdc2P4YM5skg
         IVaH0X/YNKrcMA/JQiF2FKUgjpoMCr+dC2aQVHcFbM0K+tdZxPQGfYiLjmAbDDpqdHpx
         jlL54W9gDSJvebhlOzhU77UrbQsDOqEjoIqUVRptdv7EW/9IF6LAhaG+Yad4Vj8jd70d
         TE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445844; x=1723050644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DG9Dsrk5EbbKUqbUuC/SLfjiErZu07ODQyjNbdBQFKM=;
        b=p/9TZ7DdR/O6U9fqFIkQ+6v2NuVyywDkuS1O+Wydwcaak29CKUB+WtTsELoMQR0MI9
         xO9bzMLbLi0WZcfvrE7j478qC5B/kPFDUoQBVKMuGYDP0W5mCHUIdeF43xaCU/tOkSw5
         78U6HsHXtAWwDmeuc1Cd4mYNPpoLaZeEQEkyX3vythTIgnQL9oVfKs9sFo41s/1/fVf3
         4O4/lg2pm4G/eR9QuZVDdpGKZwerzxmRy/Je4gCDdg5xBShwE09Kzc+A6b1nFKBHPead
         lI0ZUNIMnZ4I3VTxJ6zJtH3fc9xx4x/gbX/ibIqsr/TWFh+Pouro3Qg4H/ti0Bs4VpUY
         k60Q==
X-Forwarded-Encrypted: i=1; AJvYcCVS88syK/W02fo1xkvGXsxdpTbAf+G2Pm5kjxvJhGjjMHbjiAbwRsoQD9iwBPYQKmdmJ5JgV2RG4S1Ayzg7d2np5R00pOzLOJXBtDgJ
X-Gm-Message-State: AOJu0YzJiPmAE08r+NMElYkczGYC1ZD9Ba7QfQox9XC6Xq8rKclbuom2
	QAVElnfM+Vtz/b9PmU6bBofIYF7S+lgxNLYoBzvQT3qzErc5t8meoSONmVAbWdtGHtMMAY7p9Ci
	oyFA1bthEvZ/5YoFNltBM46RBnnA=
X-Google-Smtp-Source: AGHT+IFCW0KBtutTT9yo+ccyb6xdU+bDoCL8vXjw62S5YbYqpKMe64BaRn6jyq9lgwFDPjqYD3SPVCD48sQtrx7IcUk=
X-Received: by 2002:a81:8805:0:b0:64b:44b4:e1a with SMTP id
 00721157ae682-67a0769c813mr157755737b3.26.1722445844349; Wed, 31 Jul 2024
 10:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726185825.142733-1-computersforpeace@gmail.com>
 <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org> <454deacb-88cc-4ab0-80b4-006d863a56d2@linaro.org>
 <CAN8TOE8-9=P7p8Tkc+5kG5Sqan+RAWAc7k2VH-p5W9hR-bb_Xg@mail.gmail.com> <0685ef1b-b0e1-4c53-94dc-4d5de5be8e94@linaro.org>
In-Reply-To: <0685ef1b-b0e1-4c53-94dc-4d5de5be8e94@linaro.org>
From: Brian Norris <computersforpeace@gmail.com>
Date: Wed, 31 Jul 2024 10:10:32 -0700
Message-ID: <CAN8TOE-YGSRxjrMNqHWfP7RYKUnPs-V=d_FFJfZtquPedEe+dA@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, linux-mtd@lists.infradead.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

On Wed, Jul 31, 2024 at 1:51=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
> A shasum on the SFDP dump would be good to have some sort of integrity
> assurance, e.g.:
> sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp

# sha256sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
2030d04758164491e414e1d55e16b04803f5653fb591fda50991c728c49c1c37
/sys/bus/spi/devices/spi0.0/spi-nor/sfdp

> Some test in mtd-utils would be good indeed, but narrative shall be also
> ok for now. What I fear is that people just use just a flash lock/unlock
> all sectors test, which is not ideal. We shall also test locking on some
> sectors from the top and bottom, to verify the correctness of the TB
> bit, check if BP3 is working by locking some sectors in that area.
> Haven't looked at the BP area in a while, but you get my point, I feel
> testing is not ideal and a guideline would help.
>
> If you ever feel that you can spend some time on this, help is appreciate=
d.

OK. It's possible, but no guarantees. I think in the distant past
(when I was still maintaining some of this area), I actually started
to write such a mtd-utils test, but I never cleaned it up and
submitted it. For one, a proper exhaustive test would be rather slow,
as we'd want to test all the possible protection ranges, and then
erase/write/read the whole thing. Some rough measurement on my system
shows about a minute for erasing the whole chip, 25 seconds for
writing, and 7 seconds for reading -- which means with 5 bits of
protection range (4 bits, plus top/bottom bit) we have 32 combinations
* ~1.5 minutes test =3D 48 minutes. That's ... doable I guess, and it
could probably be optimized a bit to reduce the number of erase
cycles. But it's not great.

Anyway, maybe I'll play with it.

Brian

