Return-Path: <linux-kernel+bounces-284143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA894FD87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F842841D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A5237160;
	Tue, 13 Aug 2024 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh1zSZDE"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BC2374C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529067; cv=none; b=B8SukuMxdfbvUcnYVQY96CDPJW8hCwNMlcWBiGsKhWlSdFjCkdr1XS6jueYvv1G7/hYBTAwmpu+Q8QT2gkEu5wjEb4Z0IqWr40O1UvVqb96BpP4/K+ocdTBwwXktmn9M7DG4372ZxuuRmKYln1abXtbBaT4ApQ2uv+22CVlEAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529067; c=relaxed/simple;
	bh=LBYhYSX2Qg62AU7ZHZ8GuRF+EyCAChlYIjmWAnHyslA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag+fZ3JidMwnCxk7ZYAnpZmDConhE8EZ6CSyS9pI8/EvaYSdN46mprLylLMJZy5dC0L2JW4qkQ2aPAF5oUamYXqF7avppvW+fw7KOhGU5byilznTShjrqnEJQP9SSvsYtOyWdPr2PFw7cQoDo+UlAk01AKcNojIlkNXCkuZu6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh1zSZDE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7a10b293432so3621257a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723529065; x=1724133865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJLsE7Xr/p93PhEhSOjWGpmLu5pfF3uWp3jc7+NUeN4=;
        b=jh1zSZDE5V4xvF2ahW7Ha7v/vLkehU3i1phRhGYvWooXJOcuHDbNcmzoZUg37pztDn
         2nWO2ga98RRpaAFHGY+cfCnNW0GPB87/RVmwoSII3Rn05dQBY/D0sbAMeXbJTbCSl/zP
         JSMEA4J4zv+wnziLA4XnflXzSMdhJ/ordRWNly2Biyy6gxYD/eQuTvLjMfdBxUZyfsCW
         Rk3TKxk2Wn7G1BCBMu7pwWZC3G4a6siW7orHXZdP4Lefytb6B+Y4uYiMvyuYha3ytLk2
         3STNQfojxjK/dsalqrFvJomsYLyJaHiFkcxYUUMsPrso3RbhrQObs+DlXKPNRY3BKwxp
         k7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529065; x=1724133865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJLsE7Xr/p93PhEhSOjWGpmLu5pfF3uWp3jc7+NUeN4=;
        b=fnlGXXY8W489/aVv+5a3jrELhMezr6poBx6iHYpddYDka/POADPoJ7PRFphrloCJDX
         t+IQWyJ8E1u15BJ8pQmTfbToKzKCquVN8qi64ZaDWuaLGTDetc3ehqMob3+mIdZ4FBJ3
         YA5QcDf43h+WoUU9VA67kcgDlI7YeQ4dG9yHly7OsYGedsXa4k/rH5c3w/IEhKK5ccqJ
         E0cyCPCZLVc1TCQG1T+9XJj1QEjpit9Fv8lcIvkC13HJcU6xKCvuOJxUNH82/qgyPx2+
         KEdAccsoKRdhuGVJzbvmKtSMHw+ahOA84zU71UoLm1xeeLNicBjgUhwOmCPU2R7i8Uo+
         J3aA==
X-Forwarded-Encrypted: i=1; AJvYcCXHk0qFI82El4t94e2SHiZI7BhWLRdGYAhWrUvS2HxCp542rhpa+ZXnniOBKMhgGiRa07+d3DukwabrdGcVwc0dszk36+Mm+LPNR5eK
X-Gm-Message-State: AOJu0Yx+qB5b3+0C8Dt1fnjn4rxEm/qoqwqSv2g2ubwsqWG3Bze4bGGz
	QfbnMt3PWCTJbbTNUF7PP5W2RiZswOM4RMpI720NEo5oZh6xJ0bcS6pT+UsgwpVZWyHCB8an91K
	Wds6ZnZOTWqLiAARcGg9R+BwYBvoNdU+W
X-Google-Smtp-Source: AGHT+IHqhg7Fh7b0TIq7m0lUpP+gnrWZRgw8uTbB2WK2/ABQlNCExOmUDrbZ+YpR7/f/tAtvyqerpK34MsO1kNQK6hE=
X-Received: by 2002:a17:90a:d794:b0:2c7:ab00:f605 with SMTP id
 98e67ed59e1d1-2d39254ebe9mr2709394a91.20.1723529065033; Mon, 12 Aug 2024
 23:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718075356.488253-1-linchengming884@gmail.com> <20240812105630.2b71ed19@xps-13>
In-Reply-To: <20240812105630.2b71ed19@xps-13>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Tue, 13 Aug 2024 14:02:44 +0800
Message-ID: <CAAyq3SazQFSU9C5Z5YURP9cFdc6gLNJfF2ReQ9Z_-GpzVWhoeQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add fixups for two-plane serial NAND flash
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw, 
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=88=
12=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:56=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Cheng,
>
> linchengming884@gmail.com wrote on Thu, 18 Jul 2024 15:53:54 +0800:
>
> > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> >
> > Macronix serial NAND flash with a two-plane structure
> > requires insertion of Plane Select bit into the column
> > address during the write_to_cache operation.
> >
> > Additionally, for MX35{U,F}2G14AC, insertion of Plane
> > Select bit into the column address is required during
> > the read_from_cache operation.
>
> I guess if the plane bit is needed for your chips, it is also needed
> for other whips with two planes? Could it be possible that we never had
> support for devices with more than one plane and you just fall into a
> common issue? Maybe we should always add the plane information when
> there is more than one plane to address? Can you check whether this is
> specific to Macronix or not?
>

I have reviewed the chips listed by each vendor.

Micron offers MT29F2G01AB{A,B}GD, MT29F2G01AAAED with two planes;
however, only MT29F2G01AAAED requires the plane select bit when performing
program load or read from cache.

Link: https://semiconductors.es/pdf-down/M/T/2/MT29F2G01AAAED-MicronTechnol=
ogy.pdf

Winbond provides W25N04KV with two planes, but it does not require the plan=
e
select bit for program load or cache read operations.

Therefore, we should not always include the plane select bit when dealing w=
ith
multiple planes.

> In this case we wouldn't need a specific fixup.
>

Based on the above perspective, do we still need to use fixup, or can we us=
e
flags to determine whether the plane select bit is necessary?

> >
> > These flashes have been validated on Xilinx zynq-picozed
> > board which included Macronix SPI Host.
> >
> > Cheng Ming Lin (2):
> >   mtd: spinand: Add fixups for spinand
> >   mtd: spinand: macronix: Fixups for Plane Select bit
> >
> >  drivers/mtd/nand/spi/core.c     |  7 ++++
> >  drivers/mtd/nand/spi/macronix.c | 66 ++++++++++++++++++++++++++++++---
> >  include/linux/mtd/spinand.h     | 17 +++++++++
> >  3 files changed, 84 insertions(+), 6 deletions(-)
> >
>
>
> Thanks,
> Miqu=C3=A8l

Thanks,
ChengMing Lin

