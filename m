Return-Path: <linux-kernel+bounces-201209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50A18FBAF6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435651F219FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2114A099;
	Tue,  4 Jun 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mbvevDWT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mkEz4XzH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2A83CDC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523536; cv=none; b=tTnf+/6Eqx+PfZkVNG2ZrU7EJwWqVo8jeFGTi6DvwH+zDDw4Lw82G29rl6ftaC47QNuGanIGO3eOGf/I2IdDeyGgscLQ4N9yqCtEKyBKdiQ4Y9H/Flk/Qcq9Zbl5SO2hoKAQneItZonLNVEnsEfYRSgJieWhNy//2TAz6d4hEv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523536; c=relaxed/simple;
	bh=ObM92fs3vutFxUO66O8NIEaKWUGFmmLYBBsBEXAGlsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lqcc7ArhlE4jc6aZ4c5mEtdu+zRh6qv7keUhI8RYGuHWf9ponvHFToq7uZcE8Kx5GxWMygvuE0BlSIH+6Tt/9lwp2kOyoT+EaoGHLxEvnJ16UWDbQYgs3L90Pqj7Fhxky/cLwKhKKTG94fWJvTz+uyGGECmH59tehdOVNi+7964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mbvevDWT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mkEz4XzH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717523533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8PY4ZBGr/rJpSyEvYDRtajfc119mKAXLCFNFSOR7sc=;
	b=mbvevDWT+USEsXjkJsaaJtLY7Qb/VJK8mtHlDbZqjUsL7KmXv+/K63bYNHv4cv8lMIsYdg
	El1nWxEcJYZX/ghtQtc8aYJc4YUNLLTRE/+NlrzjGmRffNAXcwG2Ec8XVGRHQl14qduKTd
	SYeiGH5nWzqojs19vcwdXDz6DKndjkGqaizCMaKQnfRLbD8lfn1L3yZoCRfHAAmNumJukE
	m+wIGQf3u5O33RCfs2t/Yn0ACzdxqZB8aWnSHyMHVzBKRhsm/tpqcYwJX4/46hNvN0hGyL
	g+ESg5csO0UoFMxuSiRbOpIoINki4Obz0SsbhTIuUjRVUup2Gpejd4CAueXEfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717523533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8PY4ZBGr/rJpSyEvYDRtajfc119mKAXLCFNFSOR7sc=;
	b=mkEz4XzHW6uzBvl0pS4WOmzY2zgclRK8bAb9u8iRl/RQ9HgjQ+JIBbXX1hw96BAmtgVX7S
	1x0g+e+Bg/lgHRCw==
To: Li zeming <zeming@nfschina.com>
Cc: linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] irq: chip: Optimize the irq_set_irq_type function code
In-Reply-To: <20240604080914.38019-1-zeming@nfschina.com>
References: <20240604080914.38019-1-zeming@nfschina.com>
Date: Tue, 04 Jun 2024 19:52:12 +0200
Message-ID: <87jzj461f7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 04 2024 at 16:09, Li zeming wrote:
> Optimize the position of ret and remove initialization assignments,
> making the function look more aesthetically pleasing internally.

And thereby violating the coding style guide of the tip tree:
Documentation/processs/maintainers-tip.rst

Which also contains a guide how to select the subject prefix.

Thanks,

        tglx

