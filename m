Return-Path: <linux-kernel+bounces-353964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1AC99354B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACB91C21546
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090CE1DD867;
	Mon,  7 Oct 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R3IlIP1V"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD38139CFA;
	Mon,  7 Oct 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323207; cv=none; b=fLKZLvqfv86zwATfJMFquvsYMjHcbVWUGsIan41eyvn0zDUr90o6qzUU3GPfmWCXTRM+tYfr0vEIPUAUf4sPS/62RI/YzXLsO/v/HOJDp8M06wit5jpluA74W5t4TkbveUie1kMMISPvs0MGwLNWEiIi13BUpIKfT3FZ3SOVPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323207; c=relaxed/simple;
	bh=ydEKflDOj5PrICcHyjRMmVQw/oFNuhMHmHCSdva7xRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QWpfQCPvyJL9F19h8na4UeXF8O3dyb36dsp6ll2k2jZ5hUWR7xHEh0QiWWfNHU3zNbrw7PD1GwEr7COA4Bj5AfpwtKyKchC2zOrx4gRq8lHtp8pynMKZHE0d6aD7HBKLJWi3XdB5GJuo7JdDFALo3nZ48qrXD3qDVu5oOWju7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R3IlIP1V; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1237442B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728323205; bh=QSvvjs6UH5sL67koCBe6p+EInqHQJWIsplo9r8KQsw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R3IlIP1V08NXxd92HW0GBZ9/UFQjak0X8TYHrfJw/rZkDmPvDsK/JmL6MMjgXP/6l
	 oeAtd0qNHOTJfN7ghVzAXZuM+kiuJ9kWORuhdmJuS0OQh3Gm7IEfVQvaQzIzjTcWXm
	 /V5Ar4u1cnRff0MRh9r82/CKSVzgu/wnQgjoPLNxY3xEg5oV5yOYFpZiCkxn2tBese
	 LtDtaMJhpHRVN6KG3UhB9oEXPA5UnbYWiknllTsLvlb9rqlhXcVK4x009zbRfUk8XN
	 c28AqNMeY5C4UNTyqa+CAhNx5R0fr07gmpn0BDD2tydTnL+6chh91Sl2N4Wtnz4ViU
	 +d5g10y+nVlsg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1237442B38;
	Mon,  7 Oct 2024 17:46:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,
 Bjorn Helgaas
 <bhelgaas@google.com>, Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 Ricardo.marliere@suse.com, Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado
 <sergio.collado@gmail.com>
Subject: Re: [PATCH v4] docs/sp_SP: Add translation for scheduler/sched-bwc.rst
In-Reply-To: <20240912171144.15398-1-sergio.collado@gmail.com>
References: <20240912171144.15398-1-sergio.collado@gmail.com>
Date: Mon, 07 Oct 2024 11:46:44 -0600
Message-ID: <874j5niz5n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com> writes:

> Translate Documentation/scheduler/sched-bwc.rst into Spanish.
>
> Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
> v1 -> v2: initial patch
> ---
> v2 -> v3: failed patch
> ---
> v3 -> v4: corrected reviews
> ---
>  .../translations/sp_SP/scheduler/index.rst    |   1 +
>  .../sp_SP/scheduler/sched-bwc.rst             | 287 ++++++++++++++++++
>  2 files changed, 288 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/scheduler/sched-bwc.=
rst

Applied, thanks.

jon

