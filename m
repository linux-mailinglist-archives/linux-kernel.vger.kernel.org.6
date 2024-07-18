Return-Path: <linux-kernel+bounces-255966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC4A934723
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D098C1F220B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E083D966;
	Thu, 18 Jul 2024 04:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b="AJXevFJb"
Received: from smtp-outbound2.duck.com (smtp-outbound2.duck.com [20.67.223.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266F38389
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 04:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.67.223.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721276930; cv=none; b=mX7b+WpH/dszi3krgEAxTC293RqH4DglbvV1PM6Kv4gWUMBMMJunJrsz1qF1LHVieh60zDnTWUgn9H70oGbMQiRBaDzCv5yHJC+VgL83IO/f3Gc6DYxTjF2laKJe8JioQufECdZlD6NWVD8opDid9UhxojW1KHX9H8y0G2A3Ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721276930; c=relaxed/simple;
	bh=uGmYkX/il414SzMLrlXQtLMd5aniBrjc2NutAo9I05s=;
	h=References:Subject:MIME-Version:Content-Type:To:Cc:Message-ID:
	 Date:From; b=IZD0q7kyT9vc148BIXQj2Lz5GBBf6rSFcB+ZJ+O1hqP/vAsW9DevSE3TQX8WoaPaoJ2IuzKeByXp/nNJYNCeP9tPYuHwaLkdVXlX8JLJ0TpwtS3DL6TVJMW2O0sz16jtEWwa+MtVfoQx8lwQcsoYYVJYGUbmew+LeQ5j+UAz98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com; spf=pass smtp.mailfrom=duck.com; dkim=pass (1024-bit key) header.d=duck.com header.i=@duck.com header.b=AJXevFJb; arc=none smtp.client-ip=20.67.223.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=duck.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duck.com
References: <1a61d10f-7974-4fb5-ada6-f2c40c55f2f7@leemhuis.info> <20240715100424.GA18686@willie-the-truck> <1a61d10f-7974-4fb5-ada6-f2c40c55f2f7@leemhuis.info> <37EBD2B9-3314-4F42-8DDB-5D08242959E0.1@smtp-inbound1.duck.com>
Subject: Re: Boot error since 6.9: Initramfs unpacking failed: invalid magic
 at start of compressed archive
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Bar: +++++++
X-Rspamd-Report: DMARC_POLICY_ALLOW(-0.5) SPOOF_DISPLAY_NAME(8) R_DKIM_ALLOW(-0.2) MIME_GOOD(-0.1) R_SPF_ALLOW(-0.2)
X-Rspamd-Score: 7
X-Rspamd-Action: add header
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Jack D <wm2vdghq@duck.com>
Received: by smtp-inbound1.duck.com; Thu, 18 Jul 2024 00:28:46 -0400
Message-ID: <99EBCF2A-4528-4F8C-BCEE-0B1178F28088.1@smtp-inbound1.duck.com>
Date: Thu, 18 Jul 2024 00:28:46 -0400
From: wm2vdghq@duck.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duck.com; h=From:
 Date: Message-ID: Cc: To: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Subject: References; q=dns/txt; s=postal-KpyQVw;
 t=1721276927; bh=uGmYkX/il414SzMLrlXQtLMd5aniBrjc2NutAo9I05s=;
 b=AJXevFJb0R9TChQC+9R/4DVNsy25n65XWwa/cNbZOJi1CDPwzSJTcVdDFcIm68x4WESmjY3Sh
 TrkW8ZzCllA7bTPYjSGDoZKzffZV2APwUSttRpoAHjLPLRKiqTOlAS3BNmMqmLufZN6W8XjvLWm
 qZeurh0EFM4dpv32QNTHxXo=

On Monday, July 15, 2024 at 03:04:34 AM PDT, Will Deacon wrote:
> On Mon, Jul 15, 2024 at 08:24:04AM +0200, Thorsten Leemhuis wrote:
> quote from https://bugzilla.kernel.org/show_bug.cgi?id=3D219014 :
> >=20
> > I'm marking as arm64 since git bisect identifies the first problematic =
commit as:
> >=C2=A0 6d75c6f40a03c97e1ecd683ae54e249abb9d922b
> >=20
> > git bisect log is attached.
> >=20
> > Any kernel tagged v6.9x and later fails to boot with the following =
error:
> >=20
> > [=C2=A0 =C2=A0 0.420154] Initramfs unpacking failed: invalid magic at =
start of compressed archive

> My guess (based on times I've seen this sort of thing in the past) is
> that the kernel binary grew in size and the broken bootloader is loading
> the kernel over the initramfs instead of parsing the 'image_size' field
> in the boot header.

(I hope I got the email formatting for this list correct. Apologies if I =
messed it up.)

Yes, that was it. Thank you for your quick (and accurate) assessment. The =
commit
increased my uncompressed kernel by ~1MB. Not much, but enough to cause an
address conflict.


