Return-Path: <linux-kernel+bounces-193520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5F58D2D54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D391F25A19
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7591607BA;
	Wed, 29 May 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKBKp2TZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="81g5Bwjx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0167715F417
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964440; cv=none; b=VPUNk+88RaqO+G4TqKheiMAxh7tgGFvC3WZe+++pUuuTfXCtC0SmW47sD93rLJ/zUXcGdUhgT79ek+/dHyLF1YZxe3DpaobjmlsRdmG3PmKFFcexZjYIHSAWFCiQJN7K6UwXg5/PS6D2axRZ2JVIYZsL1xiTQAjIN/bumpdnFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964440; c=relaxed/simple;
	bh=zbqHMBELg8onnZxF8qJjAEKesjCHoQAEOACipj7FrHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nhFyFouNSe2+PTLeF6mr03pKwq2NFDTEbBHf7wJs++VYbKhz1Qy7n1vxuwGZCktEfmf39XxHCX2TSIk8txFGS8uHHS+Z39Kfh6zDaPcnE/z0KCjEJ/WApyB9Mtzs0s6GqnEFZyGA+foyChONp4NiZtIzZhxxQAYSaW2EA+IOaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKBKp2TZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=81g5Bwjx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716964436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zbqHMBELg8onnZxF8qJjAEKesjCHoQAEOACipj7FrHo=;
	b=dKBKp2TZ3dWpAvpfzNXr5n3Bv22278GmncociLF5efWtmt8Rm3jdyHN9gSPwRKX5vcqlEX
	Z55JUICXtgCkk+8/Jyl+VfeDDy7u3KS+oF93oGvvZN1xOBq2TSnWZLBJBTP3suCbOBWHIf
	PezHsMsrQPa1/qMPB7Jh2bUcVUCj79EbaNXoSNjj00AilWc7i45wK9fKlVN0+kABXlHbzv
	kxsRHGGbWd+NBn1jClqlK15gAhtnIcu9T/Z2sEzoPvXaR33zvR0qWwEj/5WmNJ0gFwqv8+
	YnNabwXdImDBcxtMCzUHGJXg267KlKor4ZQgHoZV6yk/hqRJMC3h8IOKrRZfHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716964436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zbqHMBELg8onnZxF8qJjAEKesjCHoQAEOACipj7FrHo=;
	b=81g5BwjxUJ0rOx1MAshsGFpXgAgIulzoJPmZxQI6qnQRgHcCoNAPmdhxituOO1L1GMyDhd
	iBG/bIjhc2Wo96DA==
To: Petr Mladek <pmladek@suse.com>, Xiang Gao <gxxa03070307@gmail.com>
Cc: rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-kernel@vger.kernel.org, fengqi@xiaomi.com, xiaoa
 <gaoxiang19870307@163.com>
Subject: Re: [PATCH] printk: Increase PRINTK_PREFIX_MAX and the buf size in
 print_caller.
In-Reply-To: <ZlSewPTyQ-jMpW5n@pathway.suse.cz>
References: <20240527091929.316471-1-gxxa03070307@gmail.com>
 <ZlSewPTyQ-jMpW5n@pathway.suse.cz>
Date: Wed, 29 May 2024 08:39:25 +0206
Message-ID: <87y17tktze.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-05-27, Petr Mladek <pmladek@suse.com> wrote:
> If you need to modify the code to add the extra info, you could also
> modify the buffer size.

Exactly this. Your out-of-tree patch to add extra info should also make
the necessary changes to the buffer sizes. It is your out-of-tree patch
that is broken, not mainline Linux.

John Ogness

