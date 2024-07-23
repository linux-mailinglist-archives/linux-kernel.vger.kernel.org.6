Return-Path: <linux-kernel+bounces-260448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEB093A95F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7B128421D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE541487D1;
	Tue, 23 Jul 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPcTpFkQ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6F145B28
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774024; cv=none; b=dO1Bf4nZV7B9jctL9fIcL7YbyzZgvHeHi2LOjsf2aRy2p5PEm3oeNCos/H6koJgCsfWwfOwc5ZdFJoazdSip+3n1KdORQR10bGRFs9dMxNmpAUrStRBnJ4RhvxWIOd/w9gfrnY8jXtalmB7ejjcV+thOZJ7OxoCuffnbWQ6yGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774024; c=relaxed/simple;
	bh=63USzCuOrIEi4I4bD3Vm7DFEBWvOZ9FY5vEVPQO5sQY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pz4gPYlk+K1xP0Oq3y1F4R8rZ1xEfIBPon/+2T9yj3a8R65tzFF3IgO+/03TeoflpWCpJ9r6NkX3QOfAsx5fVK9kVKwrBqfebXC3EVlxJZRh1bQGN2AY5fx0viSE51dg3ZWTcFLbBVi37P7DuVV9YjUSHwL5fSYyHwvlzJPJuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPcTpFkQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so4877a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721774021; x=1722378821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q3mkLfi75bktV04lGcBA26LNoz0C344sgj/vvRDdCzE=;
        b=zPcTpFkQK6vhZgqz9dLu79zN2VizhgJDN2gUI+ng9e5zLCD2+Zebqdjv1mb7G0xx5I
         VBY2DmwP9kJYDK2fPpYHdW+zHATPifxH5TRE+CAH5zKakiC9bVqvIFCBNXhGjThNH2/r
         +gaSWIuwkZn/+Yx9sx73DmzqT7t6B/SklR/s35Y60u0eidFLtoECbhAWfdof7WXZr/s9
         TP3zRD61sPBAWuBNVAcJhdPGteql2/V12UGcC0cIWm73DOlTXReFRzWL5DWCsbiziYDP
         eYZiLxSOyrdJEG/YwYnRFbnuxHEx1Orx9XcsZVwToMR4HS1UJ5P+BCY6IXvRIZ+/ayT0
         x1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721774021; x=1722378821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q3mkLfi75bktV04lGcBA26LNoz0C344sgj/vvRDdCzE=;
        b=d+MlKtGjQDXvmD6f8UMeV0psEV6VoNA+mCsvOWZOTBJ5fimsbsSX4Ww/m6diP+qcFR
         M6EampajUOTaOhTyjArbriZfWkLz+BFNadXdn567pwMYUzmGpaS+54KF6VFKnKIImIUJ
         XlX8biubIG68CQILZ2lqMPXIVOVItX5rI6mcgH5H3N8HUXeM4Jf90KQkCQRwhypb4YsK
         u800fEtjuksc0h+sBnFgjL8cEB4vWWhV8YPy9NzwKjZUtiPoFy0lSEIBsCBq3otfpTb9
         iO6NNQ8bAS113jyzgAXSRz9YMO2Ll6Fop/FBqXzAtIEi8VI8rEZlyWej/Jl62GzA5ZhY
         upaA==
X-Gm-Message-State: AOJu0YxA3eIUhSmM2oKc6qdv0CZVQpQQxvh+UHwDkEimx3bEgCbJiUte
	AVc66IF4YcQgZrGPTHUoRIVEsltsLAM75KBE0yaKL7tJL/c/p4A29UfmIcvlpaFdDfz/q/qQphi
	o1tZ1dLULr6kOaHY1JTWyfDQiIHnmbHJGOlftramzodoxEa9IC0bX
X-Google-Smtp-Source: AGHT+IGeOW7JaWcpNZYzE3kpMjTA6BzpmkskszrTJLRe4FR5DTbPa0ffwCAX0UPPE2FArmcxhDv7J57hTuttarCll2g=
X-Received: by 2002:a05:6402:2554:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5aacc18da2dmr103031a12.5.1721774020901; Tue, 23 Jul 2024
 15:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 23 Jul 2024 15:33:27 -0700
Message-ID: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
Subject: UML/hostfs - mount failure at tip of tree
To: Kernel hackers <linux-kernel@vger.kernel.org>
Cc: Patrick Rohr <prohr@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reverting the following 3 patches:
- 104eef133fd9 hostfs: Add const qualifier to host_root in hostfs_fill_supe=
r()
- cd140ce9f611 hostfs: convert hostfs to use the new mount API
- e3ec0fe944d2 hostfs: Convert hostfs_read_folio() to use a folio

appears to be necessary to get the Android net test framework to boot
with tip of tree,
*without* the reverts we get:
  mount: /host: special device hostfs does not exist.
(if I don't revert the folio change then it mounts, but appears to not
actually work)

This is likely related to having an old debian mount binary...
but it is not *that* old... the base OS image was built in October 2022.

root@uml-x86-64:/# mount --version
mount from util-linux 2.36.1 (libmount 2.36.1: selinux, smack, btrfs,
namespaces, assert, debug)
root@uml-x86-64:/# dpkg -l | egrep mount
ii  libmount1:amd64               2.36.1-8+deb11u1             amd64
     device mounting library
ii  mount                         2.36.1-8+deb11u1             amd64
     tools for mounting and manipulating filesystems
which is from https://packages.debian.org/bullseye/mount [oldstable]

https://www.debian.org/releases/bullseye/
The Debian 11 life cycle encompasses five years: the initial three
years of full Debian support, until August 14th, 2024, and two years
of Long Term Support (LTS), until August 31st, 2026.

Thoughts?

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

