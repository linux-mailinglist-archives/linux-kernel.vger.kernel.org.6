Return-Path: <linux-kernel+bounces-522453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1892CA3CA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE40F17A48E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9082528F2;
	Wed, 19 Feb 2025 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="N4/a9lUP"
Received: from 002.mia.mailroute.net (002.mia.mailroute.net [199.89.3.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598682528E6;
	Wed, 19 Feb 2025 20:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998544; cv=none; b=qcelu+yeIMEhRCpjmnCmiPGyUNlQbDwJs7deKk+L5AFYO+iy15yOjojKE+FYlwUQtyOsNX7GUXC4uGXn8YKAEj/Ss+3l5F6QQh6Fr2+22v7GRogoEQvdhDSZaFjZQ5B/zmjJZqIsebt1JgTGx9h0upLeJ0cd6FoZ75pZ/7lYcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998544; c=relaxed/simple;
	bh=czMByyYReIpUlR6GzNLR1SALmS9l1XM4mmWYhV9IfLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIqGokDytUTUiklRAH0ORJ6xlmcSufXCpBHDQNiyy/8C20Xb/Sw3S7dvK2HbAbu2FYOmM3rrMCy510O4p15s1HZoluYxGsZbRIOMma+ekIMWzf/D3wyISwAjSYvivxpuq52IDn0imSKJkfCPEa/PQI31Fp22g/5EfFH+nhRW7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=N4/a9lUP; arc=none smtp.client-ip=199.89.3.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 002.mia.mailroute.net (Postfix) with ESMTP id 4YypVg5hFzzlsBGD;
	Wed, 19 Feb 2025 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1739998346; x=1742590347; bh=czMByyYReIpUlR6GzNLR1SAL
	mS9l1XM4mmWYhV9IfLM=; b=N4/a9lUP5L6UKs/agVhzbsZ0TIWrZE/+ExuiLCb5
	0qFSMK8zpFReC0lckEdW/kEeGlbsGBY5HME5QA/U2VWvDwpYRafvkM3I+h/dIIt5
	lXGlgENhlQRokMW5QW8Lx39uOaXKp52xjE7fDfhZbpK7S2mg5QyP28CXpDlsArs/
	jBeh8I5yx0BW3nK1wXtLg5k+PWpiN61TTjVANrTN96NCqW0jMg7RPBYSizMx1hFb
	Ex/ikitJQuXDZa/r3hoLBAhCcgZKnSmuJi+7sojAXW+uE8llJnmOJ9XnC8FQtnN7
	rkengsBmMoO2fzrIA1jZoqBUa0VbULqvPK1jdEdT96g4Dw==
X-Virus-Scanned: by MailRoute
Received: from 002.mia.mailroute.net ([127.0.0.1])
 by localhost (002.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pk2laRYKX8zR; Wed, 19 Feb 2025 20:52:26 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 002.mia.mailroute.net (Postfix) with ESMTPSA id 4YypVV3frrzlsCZW;
	Wed, 19 Feb 2025 20:52:17 +0000 (UTC)
Message-ID: <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
Date: Wed, 19 Feb 2025 12:52:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust kernel policy
To: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Kees Cook <kees@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <202502191026.8B6FD47A1@keescook>
 <20250219140821.27fa1e8a@gandalf.local.home>
 <202502191117.8E1BCD4615@keescook> <20250219202751.GA42073@nvidia.com>
 <20250219154610.30dc6223@gandalf.local.home>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250219154610.30dc6223@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 12:46 PM, Steven Rostedt wrote:
> I do feel that new drivers written in Rust would help with the
> vulnerabilities that new drivers usually add to the kernel.

For driver developers it is easier to learn C than to learn Rust. I'm
not sure that all driver developers, especially the "drive by"
developers, have the skills to learn Rust.

Bart.

