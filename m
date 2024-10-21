Return-Path: <linux-kernel+bounces-374040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2D29A60FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1041E1F23BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C341E571E;
	Mon, 21 Oct 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BQXGVLuc"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B11E2834;
	Mon, 21 Oct 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504852; cv=none; b=jY2w2Rrtcbr80l9ptYbSUPzmWH7l6NRofeUtVsxO4KLtpQ+GcMoHAPmNTh+J2nOJ34GnH3cKQrwGM4pCYKtmWmDgOz0lSqKYHTMpyf9ECI/moDuaF1vES8tJKDvuvKHagxabBkOVYd49Ohi2L6K0sq6gdyHpLYnoXcBTGGj+TXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504852; c=relaxed/simple;
	bh=nWJx9F538qd8WsHYahYfniMsbpkK/g9Eu4QRgqryuDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIxXc2ZSWO+czZsotNchbvgAV8SmNEs/RRXBU3/ZFnoxU3xC3toLFBNZOwDuqg1a7+P4qV8OFwWYnAA72vWrt8oNwl5uxHoQvcylziVrBrFl4tvKv+QLfhxhuV75y9Lh/2uVRFhdxRf8AaEEkEn7heAwz761V9/0Y/WUJv0rOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BQXGVLuc; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1BB4CC0003;
	Mon, 21 Oct 2024 10:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729504842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rMK7niBniSWGtLwT6S/uPquKbfbY50UHICvFHDtW+Ns=;
	b=BQXGVLuc5sSEWBcs9kT/tymqcKmNk95gso+GyI/mfbRC6nyKBZZbFgJJoTtpEwxORqDX4X
	RKkJsmL/xig9zNAMFK67ED0FgORRbyTTla4JyUQHIhHNcQ8P6Y84BQExn5CSNInc9Wn+M3
	GvnRfrqoveVpAriMZoDS3ERJMIo3VBBzHc0HvrSFI1FkLgQaukR8gzlUGkX92fT6RrXDDW
	3y8f/1Xe7Rdw1G+gQnCyulzBFBtMvTPYCURsu/gQtpgPA60qVPK2ep2DUYZNi9p6gI5oLg
	DNfdWfhDatofTLefCIMPebaJA7n022E8a9wUq++JZeUajsLLI1dpBx+E0OdwBQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Colin Ian King <colin.i.king@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: cfi_cmdset_0002: remove redundant assignment to variable ret
Date: Mon, 21 Oct 2024 12:00:38 +0200
Message-ID: <20241021100038.101813-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002172258.958113-1-colin.i.king@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4c9b44e774025d9fd6f8384a7dcd6a6917043650'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-10-02 at 17:22:58 UTC, Colin Ian King wrote:
> Variable ret is being assigned a value that is never read, the following
> goto statement jumps to a statement that assigns ret a return from the
> call to function do_write_oneword_once. The assignment is redundant
> and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

