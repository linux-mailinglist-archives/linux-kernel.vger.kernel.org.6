Return-Path: <linux-kernel+bounces-302253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD0095FBBA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E32AFB2195E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BD119AD8E;
	Mon, 26 Aug 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MgdQZ1D7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FD13DDCC;
	Mon, 26 Aug 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707986; cv=none; b=nF8aOZ1sAKcXc8sSTTYyIKSCFNyPQQUzTRAvtpK/eT+yGDrSx94KH4OCT2TxCYCXa0+qh8amSdaIijdw7uDEk5yuPQl4C4Fp8NY/36M9enu5KIN69Cr6KZ8IzyS6r2iwZcWz/e8w+ZfzHSN0nr3+3sZNt0lUNbj1J3uiEVxYZvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707986; c=relaxed/simple;
	bh=rxaiCu02QBShSy2WmXGw6/bGsdHHxsBZRgpyAUKZLoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sebAh0L7KwjcqBNkUITn9+CIZu17M0QSNAHYPM++d6bu7X6Q3MQVfwIv17IdHmOtM0cdQ8ISGyAcdO1POaKP5a6V/2zkYGeAZ6IGdmPQ1v8ERDCHSUlY0R3GI061brcCzYJLsJQ1Lzt3lafIC51G4xJ9tMFuAdGzOHuwcYa4czM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MgdQZ1D7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 111C141AB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724707984; bh=YtaBziYY/ptBg8RxKGKKAElm8QgPcdw/na53MiL5j+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MgdQZ1D70yS+Ndu+hRAQv4NAAucDqNEXhRrYm2azUy8O+TYN/eoGYI6kWI+is1naT
	 9qqleALnT9hYdrotd+WCl5TzN6DihTRjv+MubPNYsVhJWSEJ50mo8PoiyVoI18LyG8
	 LU2iq4XiffWyjIgko61lAONqVxkHjKZdzIjbVs/OymTMvqf247LrbwN4tArHapLprS
	 oldVaHPDz0BQl29OrpAdGZX64+RobrVGCzwXwFn2bLjyr+7zuEFS2u3Qe//TUEiO05
	 Et0fpxQC6RInmvNshYAiyzSI/+/5Tl36AUECJvJhonsRb/2QEfU4suF3e9krtyodNf
	 1U18alTRXYyGA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 111C141AB9;
	Mon, 26 Aug 2024 21:33:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,
 Carlos Bilbao
 <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Sergio =?utf-8?Q?Gonz?=
 =?utf-8?Q?=C3=A1lez?= Collado
 <sergio.collado@gmail.com>
Subject: Re: [PATCH v3] docs/sp_Sp: Add translation to spanish of the
 documentation related to EEVDF
In-Reply-To: <20240824095402.7706-1-sergio.collado@gmail.com>
References: <20240824095402.7706-1-sergio.collado@gmail.com>
Date: Mon, 26 Aug 2024 15:33:03 -0600
Message-ID: <87a5gz6kc0.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com> writes:

> Translate Documentation/scheduler/sched-eevdf.rst to Spanish.
>
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>  v1 -> v2: corrected the commit message
> ---
>  v2 -> v3: corrected typos
> ---
>  .../translations/sp_SP/scheduler/index.rst    |  1 +
>  .../sp_SP/scheduler/sched-design-CFS.rst      |  8 +--
>  .../sp_SP/scheduler/sched-eevdf.rst           | 58 +++++++++++++++++++
>  3 files changed, 63 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/translations/sp_SP/scheduler/sched-eevd=
f.rst

This file adds a new docs-build warning:

> Documentation/translations/sp_SP/scheduler/sched-eevdf.rst:4: WARNING: un=
defined label: 'sched_eevdf'

I went ahead and fixed it with this change:

-:Original: :ref:`Documentation/scheduler/sched-eevdf.rst <sched_eevdf>`
+:Original: Documentation/scheduler/sched-eevdf.rst

But I *really* wish I didn't have to find and fix such things...

jon

