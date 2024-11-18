Return-Path: <linux-kernel+bounces-412716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258EE9D0E41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BB71F22E80
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886984A4E;
	Mon, 18 Nov 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W/gS2zRE"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C560E55B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924913; cv=none; b=HcbWDkj+i3kAJvIkpZGs7dcE8qUzLWBCvD+K4NCo02SwZlrb8nHuuiTrykFnXchE0p6GhgnCcHDweW4hk+wqQdG4VhFWW66Z0V+WaahGSM0dldWD2MXFMUfCK3wsyA8lQWWWI9bvhzigoFf5kh4hB6pnFNbAGWMdye3cjDZ4fjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924913; c=relaxed/simple;
	bh=Fj2uUiFmkbeg5lVUVotw2IvijW0/06lt3zzXM5D2Ujw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fJh2Xu3QHFrxIE5Eh+wiPYQtjLVflaHlfU0KdRdlUe9uMw/GzBsn1gPZ+c0HNTyvueboFY9X7WAAFvXGbkyH0wrMpjpSj5TfA5PTelvgpfN4e8mh7Ax9WXoeiccb+srJBWibR0yHQwZeR34UGE47KHLcnu0FwE5wNeb98k72ypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W/gS2zRE; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 525706000D;
	Mon, 18 Nov 2024 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731924903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj2uUiFmkbeg5lVUVotw2IvijW0/06lt3zzXM5D2Ujw=;
	b=W/gS2zREqtrfpNSW72krlOAfn9iQRConqSvn+kdOfPrTcQB8GJzFhSg2+P0NscuMYeXgzV
	S/FpK1uNsYgCprZjbE883iThzxF5F3yIU7xGz5Xvc5mbj4BPsM9KliPc3kX5nN8ksSycaw
	mBXuPAMXuMjbnjKIZIv6KQQlFCygbphfp0VCxORF/2cNNkXkDruMBgvGwoGo6Gc1FwUe7m
	hePPjRcHA8UBPIxuqYTcK/4uEP3dhd1P1MvNlf/eyDv8ABbuJpxvqvyb1uhjNcgc4Wdmm8
	qvrufwDD6ScN1oZGZhG4tuuXFFVaXteHCmSy0y3a+LjhvC/hExlStSTE9Dj+3Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andreas Oetken <ennoerlangen@gmail.com>
Cc: Andreas Oetken <andreas.oetken@siemens-energy.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,
  linux-mtd@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: core/part: trying to delete partition with
 usecount > 0 corrupt partition
In-Reply-To: <20241115085516.1852668-1-andreas.oetken@siemens-energy.com>
	(Andreas Oetken's message of "Fri, 15 Nov 2024 09:55:13 +0100")
References: <20241115085516.1852668-1-andreas.oetken@siemens-energy.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 11:15:00 +0100
Message-ID: <87ldxg26hn.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Andreas,

On 15/11/2024 at 09:55:13 +01, Andreas Oetken <ennoerlangen@gmail.com> wrot=
e:

> Check for usecount before deleting debugfs and sysfs entries.
> Otherwise deleting the partition a second time leads to a kernel
> panic.

What kernel version are you using? I believe this bug no longer exists
in mainline. Let me know if I disregarded something though.

Thanks for the patch anyway, it was clean.

Cheers,
Miqu=C3=A8l

