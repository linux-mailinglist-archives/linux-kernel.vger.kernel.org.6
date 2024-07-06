Return-Path: <linux-kernel+bounces-243290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FF929410
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C174F282D95
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CFF13665B;
	Sat,  6 Jul 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b="sDgCJDyP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uv8yGezz"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A81EEF9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720276504; cv=none; b=sVLN/6HU/bOAToCb7APVmWSd75694MZ2e7M6krMQfZg8uyO1phF04Boc+4/AZu2YZiI6Sn0HWciankCnGU45Zlo1Wmm+daiHaYeUVIS4KjsbS/bGU816fEsdvzgzK5W+tvBvvN8sl570Qd/hPS68L/iWpHHWGG6+0hI6faz6MTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720276504; c=relaxed/simple;
	bh=fHrwS3k9EqpTdVF5FaQm7SzeovZ9Nnch0MRUETcMtC4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HMPi3f/zcIbQsTL92/ER4FjG80qsK/temCgvCIdLZ59aKzyUUL0DFVD00GyujSo+Co0zU8VTP28aqIm23qK3DeSwb4cQlTNn4+eXR2NT6h6xM3XXgTSMJlxDcrMJV8yDqs8GLCIU5ZkVy8ODrwp8wrCofwZDsJn3o8LHV+ZAeQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org; spf=pass smtp.mailfrom=owlfolio.org; dkim=pass (2048-bit key) header.d=owlfolio.org header.i=@owlfolio.org header.b=sDgCJDyP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uv8yGezz; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=owlfolio.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=owlfolio.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6E395138016A;
	Sat,  6 Jul 2024 10:35:01 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Sat, 06 Jul 2024 10:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720276501; x=1720362901; bh=fHrwS3k9Eq
	pTdVF5FaQm7SzeovZ9Nnch0MRUETcMtC4=; b=sDgCJDyPiigGlY+PCI4HCAZWNe
	TFO//Qf/tzcIa9h7LoSqSZQGw8KVGTJvhTGz/PgUYdGW2LavXtUzgxE1/1295b/O
	/WaJpYVHTimnIdfDa+kVZbcg+tWNzjTx0dtXnGM5lJlHM453FVvZVFukA6MA4beB
	Iqn8mfissMDy6DRPjqKcknq+zg/a+nddpJUFW9kjjXCLYEJiT8W2kQexUnh7CB7Y
	vkvX6lNoUqnsnCyLx3XacduX9iVmsMtNaAiHHJ7oCBBv7nUdICB/joOONLR+pO3J
	Jupbq6N+ZBkjCT6xxJZpmNt0md5i4hkZFEaLj6b4c5T8L01P9BxfnuZQHXiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720276501; x=1720362901; bh=fHrwS3k9EqpTdVF5FaQm7SzeovZ9
	Nnch0MRUETcMtC4=; b=Uv8yGezzS556LtGP4ee5tLo+HSXPAu+MVZO/KPvrjePf
	voZOy6T2OwPFJs3tKia7bNz5lufupzBTB0m3rTdWKtXAhVy3xY++EL1Bnb3D/CJP
	GmiRFa4avqg+ia3hNj91c/FW+F3hSgu3b8IvBOovhuhPHjawj2GC/aIUJA0D0epb
	zQMKXtuAfM6AoTmjjAJ5JaIIauZbS4tWt6JbhbxBt8h+sMZJln9tKIIohBHhof3w
	1FXPxg81OUIYzUdzLqqD6pBa7KWaAznp378MGglvYmmUPJ0oflOKyhBUhNCBDiR8
	0rODdXH8KwFo7zB8RJHR3Z9OekpiGmxLRPo48kKTDg==
X-ME-Sender: <xms:FFaJZhXKiqQWWj1J1ES1ebAqQz3ubaleVLzT_sU5c4yxJgibrTd-rQ>
    <xme:FFaJZhkF-YnRJ9KqA5xCFnknuQkCwlXm47_N0iwr14RRz3nmQbcVqW-tPWuaMkXpR
    ZEqQMuDgTb5XVfye8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdgkrggt
    khcuhggvihhnsggvrhhgfdcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenucggtf
    frrghtthgvrhhnpefhleefheduhfelgeehgeejveehueeihedvgfeuueetteelieeiteeh
    fefhleduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:FFaJZtb5B9K3tfkggXpRcmQbkhGDNLZsKhvfLPSOCfvn1s4QMyrtkw>
    <xmx:FFaJZkUQB8K3Tb1FccRg9J0ghCQ4LsJM0-QtHqdGo9tMepQloaCuwQ>
    <xmx:FFaJZrmvfweZ3xCzLKQB4mxaeuabA886ZNjYeUj0W62oIxVp1w0S3w>
    <xmx:FFaJZheksNYJjA2Zo87_SORY5m-LdI7bksHWN16vwrcbkdRbjlS_aQ>
    <xmx:FVaJZu8PDcsacTdcj2L43SBWd5MrifrVllgJHbYGyF2rGd_Bw9PkTf6M>
Feedback-ID: i876146a2:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id ABA52272007C; Sat,  6 Jul 2024 10:35:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a9724690-98f4-4ddb-841d-fcc9150e54c7@app.fastmail.com>
In-Reply-To: <87sewmzvn1.fsf@oldenburg.str.redhat.com>
References: <ZobXdDCYBi8OM-Fo@zx2c4.com>
 <CAHk-=wiGk+1eNy4Vk6QsEgM=Ru3jE40qrDwgq_CSKgqwLgMdRg@mail.gmail.com>
 <ZoiaWz9mG9rb0QND@localhost.localdomain>
 <87sewmzvn1.fsf@oldenburg.str.redhat.com>
Date: Sat, 06 Jul 2024 10:34:40 -0400
From: "Zack Weinberg" <zack@owlfolio.org>
To: "Florian Weimer" <fweimer@redhat.com>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, jolsa@kernel.org,
 mhiramat@kernel.org, cgzones@googlemail.com, brauner@kernel.org,
 linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>,
 "Adhemerval Zanella" <adhemerval.zanella@linaro.org>,
 =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cristian@rodriguez.im>,
 "Wilco Dijkstra" <Wilco.Dijkstra@arm.com>
Subject: Re: deconflicting new syscall numbers for 6.11
Content-Type: text/plain

Without commenting on the rest of this...

On Sat, Jul 6, 2024, at 6:01 AM, Florian Weimer wrote:
> The arc4random implementation in glibc was never intended to displace
> randomness generation for cryptographic purposes.

...arc4random on the BSDs (particularly on OpenBSD) *is* intended to be
suitable for cryptographic purposes, and, simultaneously, intended to be
fast enough that user space programs should never hesitate to use it.
Therefore, Linux+glibc needs to be prepared for user space programs to
use it that way -- expecting both speed and cryptographic strength --
or else we shouldn't have added it at all.

zw

