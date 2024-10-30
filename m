Return-Path: <linux-kernel+bounces-388367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90FF9B5E80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441611F23891
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F31E1C3B;
	Wed, 30 Oct 2024 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQeC3Vtd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CXqsILW/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E51D1E8F
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279640; cv=none; b=NKjgvyvl10D/S9aLCvQLkVBDk1+NN+JRXMe+Ej4YSnRfcZssR56SRp4rI1FuUyI4fwd9l3Oph0tFyf7zAe+yFwUBeEyvOK85+LUyqLGGLLWj+eH1KzLXqCiYEnVEjW1BJymZFDn7qOKdjPysdFoqgV3BNhX5kfCF4HPHRMOIyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279640; c=relaxed/simple;
	bh=VvUzrjTq5zbeM/19YE3MCt3lSpd0GYq5/AuaZ6IIkZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iCdVVbFPMssdiPnEAwCSTvGROUeyqVD/BpZc0St/TVYzo2NsL7mIMOPPsEacZHNWUnVrwJoUvTPs8hHxCILHYqR3+asDPX5YXcBubiBpfuzBvsp3UQYIPPsK/f9hvofToU7Oj4X65/K34B8w2gB4qQ00X3U2dfTkAlwoVwRoKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQeC3Vtd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CXqsILW/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730279636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnLl5YVZlzygORjZnoELets1dKI60Te27IMTbcZTIHs=;
	b=dQeC3VtdPb8VOMj6ZeoBaGLt8rikiF9vgdu0CahLbAoSGtbRZNV4NxclWRIGcWroqo6Cwl
	BCHH/V4hINW7XG6I8IIdy3l+ahpdJw11COxroIeDaBqSKTEQ6xr4rs3KOJFeMc/2KfqVu0
	9ZTZ/EgnuTpb7oSVdnoSe4bZ2aLIETS5U/5J0S0Sn3ONFhuTKZ7d/aspkZuf1v2rVJaNmN
	Y1uN5Fru0/bXI82u0lsvnv9hDfSk+am35el2QPdZsvP8ECJNG+k2kV3dLfDzKKLCHzhnnZ
	oO6foVAyo5JWxaZe+cVXvIkjY/Sf6QKYchGu4pxVvi2gDmkLqv/K/oD44HrVkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730279636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnLl5YVZlzygORjZnoELets1dKI60Te27IMTbcZTIHs=;
	b=CXqsILW/SNdZXCvxmsFwYef2RRaFFbjh/oGL3TTGPMI3lJ8fV6sfYSakupyiHdU9nAGsY7
	5AnnnrWPld4Oz+Bg==
To: Hongling Zeng <zenghongling@kylinos.cn>, linux-kernel@vger.kernel.org
Cc: anna-maria@linutronix.de, frederic@kernel.org, zhongling0719@126.com,
 Hongling Zeng <zenghongling@kylinos.cn>
Subject: Re: [PATCH] time: replace call_rcu by kfree_rcu for simple
  kmem_cache_free callback
In-Reply-To: <20241030031506.77064-1-zenghongling@kylinos.cn>
References: <20241030031506.77064-1-zenghongling@kylinos.cn>
Date: Wed, 30 Oct 2024 10:13:55 +0100
Message-ID: <874j4uymuk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 30 2024 at 11:15, Hongling Zeng wrote:

Thanks for your patch. Some nitpicks:

Please read and follow:
https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

especially the section 'Patch submission notes'

Thanks,

        tglx

