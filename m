Return-Path: <linux-kernel+bounces-347803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A671B98DEE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BF61C239EF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD061D0DC1;
	Wed,  2 Oct 2024 15:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZjZa1En"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA531D0B8B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882679; cv=none; b=reESyW1aF3wCzZ/Q2rX2BjVsArIQ0p3/TIvzuP2+j3g7E0H0bSK6Ev1U0RH+fwLdtLHe6S+himvnipSVOTJBVfVXSnujmCpjaCFO22R5uwV/RpxU0qHqke40HobaN3NkO7ZbrIGaZDsqh4xELmbxVx4mxChTtkscmVjdaXIFVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882679; c=relaxed/simple;
	bh=bPnrv+HkRAGytcAkr5R8I+lRMPVsPl7CqN9Y077+LiI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kLEDKQ013sUnuEUBtq4RyHEe+zkvcme9b3inDtxYzcpFyAR52swfN+WWWtVufdKC++1gBZMj2VJ2JDS6WX9kDBQJ+NNG+IlGzwPg4ya6Nw8rwaMitOS18gH/05hwz97eri2E2pxjGZfbfl1YXrCg8tjUdIAlOjHb65WdeZYSfH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZjZa1En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5395BC4CECE;
	Wed,  2 Oct 2024 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727882679;
	bh=bPnrv+HkRAGytcAkr5R8I+lRMPVsPl7CqN9Y077+LiI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=CZjZa1EnmncntFCxkHZDfITbm9teGs1OtSidlaUGNVJUXtpMT207zY074IiDbKgK3
	 KjMvtKpuhGzy/PTP9rsAIDwC7sgYMimG5hwY4/i1xOAcFLYJL76uzbouhxLwdB3xra
	 NH+0n2e1Q5F/i4jwsDQ9EKgNZOJqKFQHSFm9XJmLycQ/RQizZd2J3i2mtmmzZ4zikv
	 HkSd+OJNejZ5LFebez03/twBQFkbCcwD3YXyv7l5E2FKYIdkL05tP5xXE2yz4aOM6U
	 NhoMh/qtSgBdDuVm7F/68nERKordfRbyN/+YRhqFtQHsVIr1liKaEJ1/ukf63+oR3s
	 FJd/w/8ZCyMuA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, david-b@pacbell.net, gregkh@suse.de, 
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240912031530.2211654-1-ruanjinjie@huawei.com>
References: <20240912031530.2211654-1-ruanjinjie@huawei.com>
Subject: Re: (subset) [PATCH] mfd: tps65010: Use IRQF_NO_AUTOEN flag in
 request_irq() to fix race
Message-Id: <172788267808.1443612.15059714333202893067.b4-ty@kernel.org>
Date: Wed, 02 Oct 2024 16:24:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 12 Sep 2024 11:15:30 +0800, Jinjie Ruan wrote:
> As the comment said, disable_irq() after request_irq() still has a
> time gap in which interrupts can come. request_irq() with IRQF_NO_AUTOEN
> flag will disable IRQ auto-enable when request IRQ.
> 
> 

Applied, thanks!

[1/1] mfd: tps65010: Use IRQF_NO_AUTOEN flag in request_irq() to fix race
      commit: f7efea4fcf4b9f5d48e690f4f327bafbabcb953f

--
Lee Jones [李琼斯]


