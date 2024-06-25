Return-Path: <linux-kernel+bounces-229182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B4A916C92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42634282456
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257F17D358;
	Tue, 25 Jun 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7dUx6U5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A017D351
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328133; cv=none; b=UTMrtuWHsguw5jRjOpLKmYKEpERY/HyhCorRTR9FDEboOVD/vyt0eqEYlwS3r+ed7epGxeFa7LKJoReGAHTh66U/fO1ocr2eOL5gXLeLKDLGnotzNPwlv9tR/5sioq1RHR5GuDwrLi9dqqODw3LYvTFwqXImZYBzpyNtNTtnW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328133; c=relaxed/simple;
	bh=lGaxAjZvEV3dbJpHuohnFiYBEAdTg+tQEwP6KE/nRz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBL9h1tWzcneFy/BFWJXOCPy7eKR41K4kjXwi3BvKylPojnDhztqgVCeDZTWIBYjqPf7DqHt6WVyfWdvdXrDE7FpMS7DKbrVN4dIgXmW7cDfsFkcv4Cg971clT2JaVIAxARVcG95S8UfdUJ2VMnN97/JxUNDsTrTMhU13CpGRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7dUx6U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEA1C32781
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719328132;
	bh=lGaxAjZvEV3dbJpHuohnFiYBEAdTg+tQEwP6KE/nRz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F7dUx6U5RiCv+jKViL89PQ7cmmz6kAiMNHhMlUh2ukjhami4a6lUMzECHTBgLNhVd
	 dnA1Lhm7rjqHlt2cBChtFvHk4HfCuq4BU32S5li9ZL45F2kBp9zRFvjK05AnzSJDBd
	 peauFnkYqBwDiCLNIc2SekA6AhSFHyA5YxvEh61Ikn49vgFmV2tvefEZTWo8JPBc4L
	 hClbDu45aEQ2X3GjloqauJTem8cDTU0+J5e6lwuVXeDxGYHtiWku2soIWU0C65DY5o
	 Wf4JFegUyuNvrF+CiygWMjFL0VNZBkUDVQRnAxW++QwNMHGT4dFjMGNLmxWvQ3lvvu
	 xfzlif3CXDRCw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so69457091fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:08:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/Vil4oK/LvmvRL4GVGJoKhDUOGX3V4Sc8rH4IOtniSxV8jGzF4XIhHfHjONkq7gvBz3peQjaspnQqSDjMOmS7/T7oGb3Kdtu8jv/h
X-Gm-Message-State: AOJu0YxATLCuBc4NmQpHF5ju2ZNzRjPQwb1IxFfRJS7Bxx+FqlBYBPtL
	m6XA1m1JFKb2eb7ZtMMhLXASS3VvGprE8BElP/GZa/ysDMxkyLdlCock8r0FkSMg3AyzIs6NUNb
	0f6FwRxv2Nyxz4Q2xHqr0tqa3Vbs=
X-Google-Smtp-Source: AGHT+IEGwkPRDCr4Py07NmScdo/sz6GLj+KG6FN0NXQ+1o93IVB5nvNWLoSqaQv/30Y1zZy8jKTil5/de5ay/uqGIUE=
X-Received: by 2002:a2e:2e1a:0:b0:2ec:5357:b63a with SMTP id
 38308e7fff4ca-2ec5b2f0343mr43601571fa.35.1719328131552; Tue, 25 Jun 2024
 08:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-jag-fix_gdb_py_symlinks-v1-1-36a0f0217fbf@samsung.com>
 <CGME20240620215200eucas1p1ec09426a22ba26b3ce5ee0a949ad3c9f@eucas1p1.samsung.com>
 <CAD=FV=U3=d91J+Jw50=xKexhyKYjUQQ_WXQ_UdOTZeou4_=n3A@mail.gmail.com> <20240621101824.bzuupiqctfoeyqfh@joelS2.panther.com>
In-Reply-To: <20240621101824.bzuupiqctfoeyqfh@joelS2.panther.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 26 Jun 2024 00:08:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQi2DSddEOk8v0wQQYsNC0DVXq5H_KUWrpWoH3Vgsfv3Q@mail.gmail.com>
Message-ID: <CAK7LNAQi2DSddEOk8v0wQQYsNC0DVXq5H_KUWrpWoH3Vgsfv3Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: scripts/gdb: bring the "abspath" back
To: Joel Granados <j.granados@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:20=E2=80=AFPM Joel Granados <j.granados@samsung.c=
om> wrote:
>
> On Thu, Jun 20, 2024 at 02:51:41PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jun 20, 2024 at 12:48=E2=80=AFPM Joel Granados via B4 Relay
> > <devnull+j.granados.samsung.com@kernel.org> wrote:
> > >
> > > From: Joel Granados <j.granados@samsung.com>
> > >
> > > Use the "abspath" call when symlinking the gdb python scripts in
> > > scripts/gdb/linux. This call is needed to avoid broken links when
> > > running the scripts_gdb target on a different build directory
> > > (O=3Dbuilddir).

For preciseness, please rephrase it to something like this:

 running the scripts_gdb target on a build directory located
 directly under the source tree (e.g., O=3Dbuilddir).






O=3Dfoo/builddir does not cause this issue because
$(src) is already an absolute path.

This issue occurs only when the output directory is
a direct subdirectory of the source tree, in other words,
srctree is '..'


See this line:

https://github.com/torvalds/linux/blob/v6.10-rc5/Makefile#L254







--=20
Best Regards
Masahiro Yamada

