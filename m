Return-Path: <linux-kernel+bounces-198842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0085C8D7E33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A0A1F24DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809667A140;
	Mon,  3 Jun 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hLPOwia4"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A0758AA5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405984; cv=none; b=i4L/rAwEx80Zw8peCL/B3uTEisYs3UObDFQGMQ7mpZvd8/omjiqLvjk8KIJoaeQUmyoprHUesK+ktDL1MMLjDgoQNz+NKYhomsPD8tVt7dGT/KybsRIlo9pJGUR02lHHVZSeI/7OQrHtAoQpcS9XHbPu4UYShvu+EbmdwyLzC48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405984; c=relaxed/simple;
	bh=QKqlw7KFcPgtNXrAPz88Db59XEJsKjSrvWdIHK4P2Uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o1UKsEehTdQMEMVXEQs8u1fGwNQWf3liewOyx2vOrdLpt+z6acP0FvHBHYM706fAKVVCyeyABfA4bv0KLatZS7DKSucGMzx52XN5pKicSr+TG3TRgsjpXmZx0Bz6ekVRNI0PJXdl4tpl1iXMPEvh9edYTT14C5UlnfhKJoK9jRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hLPOwia4; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QKqlw7KFcPgtNXrAPz88Db59XEJsKjSrvWdIHK4P2Uk=; b=hLPOwia4RYd5asUVOYfpYiL6C7
	uYaK7lkYHmGms+G+wl2lUHyzltZUoaj2Qs+hXhH/nO5eLXdby3sZ75tRO0d+Iv4bnVLheBc1YZR3i
	MuNdwTcDEMQ8HFiLoxcqQ1BdYlgBhlTeacFSDCNO/K/UpGi0/DZbyb9u3Cr8ZimarZvEhXRYm8M0z
	Eh7bvKb8CePtmFQOozuDKtjbHPA5csgXFQQ9hmBzUBoWGkLsxsJFVh7bfUYZ2XYK9R75L9yf6+08g
	5nTtKUX8Uk3ufsnboI++B2MzK3NfqPOgPDaLR8xzIqSQpJj1RsSoMbfYD/zU1VGacOjBjljSZCut9
	T3Mwd5TA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sE3kU-0008Y4-TT; Mon, 03 Jun 2024 11:12:59 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sE3kR-0002Kd-0n;
	Mon, 03 Jun 2024 11:12:58 +0200
From: Esben Haabendal <esben@geanix.com>
To: "Michael Walle" <mwalle@kernel.org>
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>,  "Pratyush Yadav"
 <pratyush@kernel.org>,  "Miquel Raynal" <miquel.raynal@bootlin.com>,
  "Richard Weinberger" <richard@nod.at>,  "Vignesh Raghavendra"
 <vigneshr@ti.com>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] mtd: spi-nor: macronix: workaround for device id re-use
In-Reply-To: <D1Q8LSUGXEIH.1N6HH5514YIJV@kernel.org> (Michael Walle's message
	of "Mon, 03 Jun 2024 10:25:44 +0200")
References: <20240524-macronix-mx25l3205d-fixups-v1-1-ee152e56afb3@geanix.com>
	<D1Q7BU6PJ356.1CTXPUZE8U6XX@kernel.org> <87frtuigo3.fsf@geanix.com>
	<D1Q8LSUGXEIH.1N6HH5514YIJV@kernel.org>
Date: Mon, 03 Jun 2024 11:12:58 +0200
Message-ID: <877cf6ie3p.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27294/Sun Jun  2 10:29:37 2024)

"Michael Walle" <mwalle@kernel.org> writes:

> Hi,
>
>> > In that case, I'd rather see a new flag in .no_sfdp_flags
>> > to explicitly trigger the SFDP read. Then your new flash would only
>> > need this flag and doesn't require the shenanigans with the fixup,
>> > right?
>>
>> I fixup would still be required in order to enable 1-2-2 for MX25L3205D,
>> as it will fail the SFDP read, but actually does support 1-2-2.
>
> But you (probably) don't care and we also don't care for the
> additional speed. So, I'd rather drop that code that is just there
> for that ancient EoL flash.

Fine with me. Because you are right, I don't personally care. I don't
have any boards with the ancient 3205d part.

/Esben

