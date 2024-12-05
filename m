Return-Path: <linux-kernel+bounces-433004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E47CD9E52CD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A9C283B13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4EF1B0F19;
	Thu,  5 Dec 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pEVEdXrv"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682F199223
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395536; cv=none; b=Mo/6oyIj7MBwPtNm+Vyd8GtGwRtkz5P4qG/COI57rJ8AksjuESZ4zlupXd05DcOffT9zjsfiowndfamGLcoh6RE+eR/ecee8dhyTIG5F1Zrwtvl8uEm9GaYRIJPhZ5h/fK1SuuUa9sdCtY333R6ydXBFyd+7f3NBoA+TeYXwRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395536; c=relaxed/simple;
	bh=4Uri7Y+YVnb+hu2KTTaPPkBHIkOlmugJlKRgqXdrzp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N9xvgE3V9quQBSsgFd7Yc7Fao/J8erTm/1nfz8/lzCS6gx7w0Gfcfox31yoDF9bLrzifqUnNsWHd8DVFKvyqHXgYSbnqLz4yQaZxMRKr+8F5rKfhe8+SpUKESjtAOI7mr08HZZQyVo+EUcIXQPbaN8OV3F7eGoTUaAOW7e9dl90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pEVEdXrv; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA1B24000B;
	Thu,  5 Dec 2024 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733395533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Uri7Y+YVnb+hu2KTTaPPkBHIkOlmugJlKRgqXdrzp8=;
	b=pEVEdXrvRy6+WU+HmfasxfEXMV0l+SDmkdUlMBE+0hoRWA/FHTbe/xxHLUtU4+Ayb6rikg
	NCa3acN6UVUYI5OvZk3hdqNfufHHs0EbXlzxVa43hc+ft0HqxfvMbAPNgSmQjXwLo1Xf0W
	la0lbt9ki+VOKKwd/MEc0ZgGm/4Z+0xDQaf3RuohTezmfW9H28q8gfW+Ry2lpyIZn7hVuj
	mqwQ2OZ8oZkOlfA5EKWk1ObL4Zp0nKmoetel231LCeSKOl6PoMdzGdHjgV/gZ+GTC+bQJi
	CKCMtKwzvYRxn8RNhMWKsPIouTSn19rRuEuc+qdby87M2mN1HbYClXPqP8B31Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-mtd@lists.infradead.org,  Joern Engel <joern@lazybastard.org>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,  Fabian Vogt
 <fvogt@suse.com>
Subject: Re: [PATCH] mtd: phram: Add the kernel lock down check
In-Reply-To: <20241114154442.25920-1-tiwai@suse.de> (Takashi Iwai's message of
	"Thu, 14 Nov 2024 16:44:41 +0100")
References: <20241114154442.25920-1-tiwai@suse.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 05 Dec 2024 11:45:32 +0100
Message-ID: <87o71qv25v.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 14/11/2024 at 16:44:41 +01, Takashi Iwai <tiwai@suse.de> wrote:

> The phram MTD driver may map any memory pages no matter whether it's
> reserved or whatever used for systems, which basically allows user
> bypassing the lock down.
>
> Add the check and abort the probe if the kernel is locked down for
> LOCKDOWN_DEV_MEM.
>
> Reported-by: Fabian Vogt <fvogt@suse.com>
> Suggested-by: Fabian Vogt <fvogt@suse.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied to mtd/next.

Thanks,
Miqu=C3=A8l

