Return-Path: <linux-kernel+bounces-421496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC19D8C19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318B0289CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E455D1B87C4;
	Mon, 25 Nov 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="P+jbzPmv"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B721B3943
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558592; cv=none; b=uHJcAh9cMRM5W8E6MDN/9yzhA6zQJ1q9e43iTfIBgeS0KNw4+YTUJsZdGMNNVZGxIfA0E0b0W+/Iw3Yhhw11uNaf9GBomUlqol0h4IqPjSt80mekIBEjIPeLbsXs7DTJpq+mBj6XdPPBzTG40F+ROolOu18LVrgcyL9QUdaarVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558592; c=relaxed/simple;
	bh=qyTkOzOfdv9wfIlug+XIK1UlJnV1xfG+wu6Iqqn3gWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3gwsAlgQkZY8c/YuR5YfA0BKkLwGIAeMJDeM3RXA42zLT5BmMmPdJDxCAxVH/PmC/5ii2c0d7tHagaxogirwKnTFaZhR1Zy/zAb8knvSSlqJIfeUeDLbYCb6u9Rtw9a9IunNyaKgmJKtrMYfl/wHTIcFEXBDEa/kRkMtR8KIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=P+jbzPmv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 95D2040E015E;
	Mon, 25 Nov 2024 18:16:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ulSLEzZmkjqH; Mon, 25 Nov 2024 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732558577; bh=TtPxj8YCUU4UzpTyOmjP8ktUmk5Z+XtUcACWjbiSgfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+jbzPmvL3Ta6HzFpuy6XuNdcEnwP6Xg20u0aiZNtMliWKSiGTm7S1FmMmVOVCe0A
	 PMks3dbJTHX1iRof8REzHKXSW8LHI/TZB96hqu6PI9kfCr1HOaLb2iw9kuco+LFwkL
	 OJ3TyfBzLNHaspKOGG+PpajdBs5s7jaxPzp/8nkFvMEvpPr+7b+N7avCE4awKDE5Ca
	 rLdwGrgtKPHZwfQYD+93oOZtblZW1C3jLx6tdoAQX8bVLPBG9vbfug8f1UNPrnY1HE
	 8xcodQqxKeAYSyjVcFq406fIDenFGcWi6JPeqe0YRvwgst2X0u0+vk1WyqiRfI3M7m
	 UtvL9rtdZvqAtRYNb8taw4i2817DBHJvCyyILwLDELq1/5psZQ8C+7ty8zpEJYGV1Z
	 M/F0S5Kr0niYnVOrYs49yWD1D1rvzOyhJXZChk/44fq8gCGRYrys0fVjP9ZgdVaUn2
	 nQX0pML423jZeW9Vg50HRkEyFswgr3XiBcI6qn7rmzUgoxQ0soeZdCg+zNx9MPCvAX
	 91t3fHFri9+oFrWtZBMt33FeVA3kPThIl61EGmLtLKn0nY9n+YcEN6IEjigqur5ugo
	 QCAgIjnz3RDCKbFchQ58plQuAuhe4gb3UePKb6J1m1fiQYzqnQ6uOiK4QZ7wHHbaOw
	 e5Ujol00xBODZ7W6xZgQXuAc=
Received: from zn.tnic (p200300ea9736a192329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a192:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD6D340E015F;
	Mon, 25 Nov 2024 18:16:11 +0000 (UTC)
Date: Mon, 25 Nov 2024 19:15:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Brian Gerst <brgerst@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/boot: Get rid of linux/init.h include
Message-ID: <20241125181559.GEZ0S-3yJidKJrV7W7@fat_crate.local>
References: <20241122163139.GAZ0Cx63Ia9kgYgRIr@fat_crate.local>
 <Z0C3mDCngAf7ErM2@gmail.com>
 <20241122170227.GAZ0C5I-F8AUpwCAcG@fat_crate.local>
 <Z0Q0PJzTMg_Or22I@gmail.com>
 <20241125102223.GBZ0RP375DufF0QQds@fat_crate.local>
 <CAMzpN2gysxoKsjGhdSwykxQ1a_F0pZG=j6Y76QDgSmNG3V7SPg@mail.gmail.com>
 <20241125170922.GDZ0SvQj8FgK0ej8F3@fat_crate.local>
 <CAMzpN2gB1WKruX0UGiO72Si1KHjcC_KcbAOK=-9TAO+cmSpFQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMzpN2gB1WKruX0UGiO72Si1KHjcC_KcbAOK=-9TAO+cmSpFQA@mail.gmail.com>

On Mon, Nov 25, 2024 at 12:31:05PM -0500, Brian Gerst wrote:
> To clarify, what I meant was to remove the -Iinclude/linux flag from
> the compiler command line, instead of messing around with ifdefs.

Ha, that's a cool idea, thanks!

That will be the last patch in this series when I get to it eventually.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

