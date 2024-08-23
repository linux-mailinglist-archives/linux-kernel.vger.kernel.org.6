Return-Path: <linux-kernel+bounces-299422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E495D460
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEC1B21340
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A570A1922E4;
	Fri, 23 Aug 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WP5kf9sb"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA2018FDCE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434418; cv=none; b=JS7Q90M8Rips5gcRC8GpLcymrcr1BsTqPcLNOa6vm4NniuIrJ9UUwKW/t8ksksbnBJvfEGnwK5ssavILGpoMZywHftBaFA52O4L587fVqtWEC9n1c5QfnuVjACSfI+OjpM0gKc8e4amn1q6T9iKjW1bUtt2+g4AMyKMGg9q1Spk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434418; c=relaxed/simple;
	bh=N089ifLbeTW8qCCACTyokSGPtgYUtwc9Ea3m9PRxESg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udFucOJ22wnAoKsxX62HNSTOAfX0nVhkH4Tt2UpD/g2HE+u1uafxh4+GYHTlg08cT0udqUnObu1Dr3r/DWrHL4cAN+V4fy3IGPLKguMYEpqBgf5xJYw0tRl/whYpFlnGXQXkPXhm8bzYJjwghBDPWdhEgrGqp+Wt7buVr405rJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WP5kf9sb; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CDF86C0003;
	Fri, 23 Aug 2024 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724434407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5mTqTOdc9pSBs6vZN4P0DsIlQ2ECczt0doqqJU0yUE=;
	b=WP5kf9sbcqcUiCOpn11scWXFR7bj845YG4FJTG5BzAX1T5+IyPix/seAo8lLqtEc4W0Rdx
	zwOwGoacHnzqGa9wjdePOy6wN9ugpA7/TerjhXkp1tf4o4Oc/tuVIUR0HG71hdvi8hnmfw
	S5LJCyijwqkLhmld95Havvml8cqH/J+jQoG96yNAnauMibgog88LwpMlX3HBBGR+mlMMez
	zpoBch/GMkZFQJkpt/hsy5mXeXxWVZCxNLFtzTBfgFlZ8txAvPfq0hWW1ydSKpWPasPew2
	JfBXz4G9+Dehz8U1Pq435vYT6T5i0Do0IpHWz9UcTPl2zwbu3zvCEP5gGd4RJA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: Use of_property_read_bool()
Date: Fri, 23 Aug 2024 19:33:26 +0200
Message-ID: <20240823173326.441823-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731191312.1710417-22-robh@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ea265e483eb3d9750c7cfc642dedd5be31dc22c2'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-07-31 at 19:13:00 UTC, "Rob Herring (Arm)" wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

