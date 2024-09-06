Return-Path: <linux-kernel+bounces-319104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3619696F7C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86772878D2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2A81D3189;
	Fri,  6 Sep 2024 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HxKkYkXK"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF571D4169
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635062; cv=none; b=ILo7XEq5/fHjo4P00CKPT11wgWj+oDTrot/iTTEb40/EsrZxJPFGK8Myw5IZwneP4bZnR0zptKRkc/1d/vFQfniqoodkU931d57uIc0w8NV704JlrCo7iTTMQlkmgcHUWiEoNG81eAxYhieOsCgYBfo4oNtbV5aZ+uctsZix1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635062; c=relaxed/simple;
	bh=lkDxi8SGruT3NFxwYAbh0mR0LE4qtliRV/QNPLXa4yw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPyZrWorODzsXueawbRVuW+br7j5ZsNstgQbQ29lQ4drBTepfjUo//jGQsok1mUAWBsj0O3JEvraMU1DamjhgoBnwo2hvg6+mayqRcbGnsBLxuHRBoUe7clfXXlbUAoTiRfzmZMPEXxrPgIahBe/T7geO6yYJ8bFq9q0Ea8NurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HxKkYkXK; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A37ADFF802;
	Fri,  6 Sep 2024 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725635059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9bdq9pRdZbdusPUWTBl/V2iUlg/kkjhWiEOFq0Lhoo=;
	b=HxKkYkXKO8ABGe8k2+c3Q81SrO7GxGADuHEHXZgiUNMMT4QvuKg1wh8kHf6vVNs6FIuTZu
	P4dbNXYXTrfJgQotLZ6lKdkiJvJ/zUkML0sDYfSGWfkl9rztQ9doafQ+qR/cpwM1nxMqPa
	N9B2St30HJ9L+2syakO6TU9P7SQiYld8Tj8R0BoGPQcSFGMknvIa4FvsRXFXpB1dZiNlfG
	qbpCbY+Z/CtrL3CSlpSil8LHLrrDzzfnLCfiPqCd1DZrcAmIkndbNdP+DWtrb05k64Z+hk
	4xD4EHyo87bB1Mathr9TKXChTrQfx7D70EnqQtsWoUFS2XAGTbcWPJ01+yst/Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mtd: rawnand: denali: Use the devm_clk_get_enabled() helper function
Date: Fri,  6 Sep 2024 17:04:18 +0200
Message-ID: <20240906150418.734840-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240826080408.2522978-1-ruanjinjie@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3c0e167c21721901413e8bc2293642f4ee6f983f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-08-26 at 08:04:08 UTC, Jinjie Ruan wrote:
> The devm_clk_get_enabled() helper:
>   - calls devm_clk_get()
>   - calls clk_prepare_enable() and registers what is needed in order to
>     call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

