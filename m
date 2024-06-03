Return-Path: <linux-kernel+bounces-199626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8273C8D89AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45EB1C24184
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210CF13BC18;
	Mon,  3 Jun 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b="fgey/92k"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4913BC0D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441838; cv=none; b=ZHYpGf76+fnuKHKkVvPZKxp8Lz95VQkTOFkhxQNnFAxmFnzWhyrpHHAAJ7L7HOc30OnTST5mwXQbUbwPBrM/6+MEeAdPQZitazLzGAnkJWpRBEqcWfv31k0OfFboDkB4DequuC/O+JNsLmkUcz/btD/7w0kBQG3Op7rv+c/LhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441838; c=relaxed/simple;
	bh=75HnoSRRAaP9hNhSzViAYmeLViPIHcEgOvBnEd0i8vQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBeP/rusujCLHFI0WE/arSatqEXgeYsbPKPtXz7A34+B9pGXbNv6wzWclAAQGgK6FBSS2sc6oDB9qbxigA50c/PLfLZBplRqFlh5c+ZdL2IYK3XQbPS9cTbp4DArWk5dnJn1h+O254IUCxF9sU+hdYsDkGwxHBgD4OIX5jk1fhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com; spf=pass smtp.mailfrom=jubnut.com; dkim=pass (2048-bit key) header.d=jubnut.com header.i=@jubnut.com header.b=fgey/92k; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jubnut.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jubnut.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VtNbY2mmwz9scY;
	Mon,  3 Jun 2024 21:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jubnut.com; s=MBO0001;
	t=1717441833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DnmViCedjPxgt3qoNGap+8Vp612SZgwbNZr/IwMSPC4=;
	b=fgey/92kMe5nM79jGNvmKop+tSFQBQqOtzp3FqFIm7A+pt9lpTOJuKN9CD5rAbFUkzxkA/
	fqGXyJOC3DVv8VQiPzYZmeyKlIhGJVs1ICC0pV6xNtB4vZs8h+Ls/AVXR1spj8XvRMG67t
	yIZ8ZxmXQdTrHay0m6J1UBR7eVlfXsT/C3MOsyufxj1zYmUGD8Lb+7C/XGhaoFbaPWVk7V
	xRwVY/6eTdDXk1s00Gqv4aCb5zSLaS+PZmfEB5PgvMaN8PhfgtHgvpft4YbB+pipSfF3Fq
	iXuFVjcphLVuxClsuowDhJHVZ8qB36CazcOQ15+NBZAqwVBcVvwtwshFv6Xp/g==
From: Ben Walsh <ben@jubnut.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Tzung-Bi Shih
 <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 "Dustin L. Howett" <dustin@howett.net>, Kieran Levin <ktl@frame.work>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] platform/chrome: cros_ec_lpc: Add a new quirk
 for ACPI id
In-Reply-To: <c8d765bc-4e45-40b3-a33d-b4cc1bbd67bd@amd.com>
References: <20240603063834.5580-1-ben@jubnut.com>
 <20240603063834.5580-4-ben@jubnut.com> <Zl2NTbhk96dhTV2n@google.com>
 <c8d765bc-4e45-40b3-a33d-b4cc1bbd67bd@amd.com>
Date: Mon, 03 Jun 2024 20:10:29 +0100
Message-ID: <87o78h266y.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario Limonciello <mario.limonciello@amd.com> writes:

> On 6/3/2024 04:30, Tzung-Bi Shih wrote:
>> On Mon, Jun 03, 2024 at 07:38:32AM +0100, Ben Walsh wrote:
>>> @@ -436,6 +463,8 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>>>   
>>>   	ec_lpc->mmio_memory_base = EC_LPC_ADDR_MEMMAP;
>>>   
>>> +	adev = ACPI_COMPANION(dev);
>>> +
>> 
>> The change is irrelevant to the patch.
>
> It looks relevant to me.  The companion needs to get set before the 
> quirk overwrites it.

That was my thinking. You can either update "adev" and use it to refer
to the ACPI companion device, or (as Tzung-Bi suggests) use
"ACPI_COMPANION" / "ACPI_COMPANION_SET" as needed.

I really don't mind either way. I'm happy to change it if necessary.

