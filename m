Return-Path: <linux-kernel+bounces-312548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772396980B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93EB28301D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2D1C768C;
	Tue,  3 Sep 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xdqlkKBK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTb8Sjxm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D71C766A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353914; cv=none; b=gDooDwcGORCRvwSh5h2+lIPHLeMClRXVBTrf6BlRfxz4UOAac8cjzIgW0ezCLVCJ+jAYo8/h4b6Uira375RTl9//qlbqDCF5oSTvi/VJs+WbizXZ4RK3tLPs3js75in+wS43tLdm/oY46S781sOR2NE2K2vVBBpLjzsN++5jHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353914; c=relaxed/simple;
	bh=ngHOiCGwHtLTUZRNtNK+1KexXQbOITWiHj9JGGNJKko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=llVSeju/OuFS/5AaJElkB/rpVzu7tzr++WYX8zG6FxPCPaqP2uLZoqTm0p5YZiqjvtY9qZcVkN6KfAS41u/Ie+2HR8h90p3G+F/QO6MTWH38V9iVs2OKvTkfpmIOZ1T6KDKZxo9zk3gJEWxfa8xOPT6JnCEu5p33HESXnlxWzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xdqlkKBK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTb8Sjxm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725353911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tw6+rzaDmavk0plVPOB2X4BRjVrNpKFZ4+nQxEa0JyA=;
	b=xdqlkKBKciEZGr412ji5oMghOPKZi0OmsepX5oACu7gMx03BmfdNsEa0ZohrFEfsBI+Dqc
	YmPaljxO5lf3sy6Un+n3CSlhwF2O4ad+bb9RC0YBg6YhJb9kLoJtwGsg3dcsfm+sYrNwX5
	Om4DT8+N/h2FsATgmSvffSRuUB/ZC7H0b6Zwm41ul20LbayRyRGXFGJ6phj5lC2dpAXWVA
	squEr8CbsZ2T25M+9fG7AhBf/QH7zXfKuIXWUqTtE1Nrm5Lm4fBPlNv9s7RZOGcv4C1SbZ
	F9QRb9knDO+mdkwSmF7n8gFvOhEoQtetDhcOISNme+eTz6i3Ru6P1i2u0wAFqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725353911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tw6+rzaDmavk0plVPOB2X4BRjVrNpKFZ4+nQxEa0JyA=;
	b=yTb8SjxmnSSJEpMo0MQrWkipagG71g2sROfYn2D1SLbdSaV5IuHKPkqJaoDCDP1Z7AXpGu
	BoTA0jVcgg1zaMCA==
To: Xingyu Li <xli399@ucr.edu>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Yu Hao
 <yhao016@ucr.edu>
Subject: Re: BUG: general protection fault in __free_object
In-Reply-To: <CALAgD-6-f4Dax=iiC8_J9Cu-ztYFCAhXSgQCQMTt2nv4Hfe3pQ@mail.gmail.com>
References: <draft-87y1494nw8.ffs@tglx> <87y1498uq1.ffs@tglx>
 <CALAgD-6-f4Dax=iiC8_J9Cu-ztYFCAhXSgQCQMTt2nv4Hfe3pQ@mail.gmail.com>
Date: Tue, 03 Sep 2024 10:58:29 +0200
Message-ID: <87v7zd866i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 02 2024 at 17:10, Xingyu Li wrote:
> it is linux mainline. We already provided a link to the linux that we
> used, on https://github.com/TomAPU/Linux610BugReort/tree/master.

No. This is not mainline. This is release v6.10, but mainline is already
at v6.11-rc6. The question is whether the problem is still there or has
been addressed by now.

Thanks,

        tglx

