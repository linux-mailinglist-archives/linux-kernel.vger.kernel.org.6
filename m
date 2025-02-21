Return-Path: <linux-kernel+bounces-526731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD65A4028B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5106D7A7ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48E252909;
	Fri, 21 Feb 2025 22:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0U6dckmc"
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E882528E5;
	Fri, 21 Feb 2025 22:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176257; cv=none; b=u4zTz87JdUDPbi2xvKB0Uqqv/H7G49bzh3HKuad5kyfLl/ML9Sv+jlO7cdBNmStbx0rR9kTkl14yHyW2R6o9fJrobYOItgT26BJ7kSMGmkFiL+20f6wrqHDj/nTqg0GJ13MCsqyLEl04sC376kHdX+SfynnQW+6ZSejN1bLy5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176257; c=relaxed/simple;
	bh=Ci3gisbLXRxROB64O9pHO44MI+ObXvntWq5pIqDL81k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEuafgCeYJGGz9weDfJ6f0z7YE3oHWy0Fluym1Hk7nGj/l4e0SDXVBSo/o66EZjaMHx1888o16eJZs/y19Kh4JPGAubGLiV7IqAbzYOZw6eu9PCAeexMbleMcjMT7aU9u+FplUpVZMJyk91VQYTCcAOdWpEUVT5VvHMOUq1h43o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0U6dckmc; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4Z04Cd1HlWzlrwfX;
	Fri, 21 Feb 2025 22:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1740176026; x=1742768027; bh=Rpv6qg5LJ6vh68awsAl0E+as
	qhk7CuPogw8UREwVqAg=; b=0U6dckmcqX9LtnZXE5xmuCnA3ixG9loGUnrl/dvI
	UEbXsokv+pv7MF+U1z9CNP2p5TJybCDDWW/PGOSBfBhxpRKuoQDnunWzgl7Kti+u
	ybJODXttnYQM8JfLAqqqigh8dRLXWkAA73yASlRQKkAOK25k44DHhEa/X9P0G5fc
	lc30W59Q2VhFKGHzXXoOlOa//iGn0QspjivRW4ciwH+jJAtXVTEab0/OUFQ8d6oc
	8o1jcQHUHyfuyx+5hMZeG1C9I4EKBlSj8G60/NxnKKFzEy3Af7SKtihbP5+JkWTz
	wiXmkEfXeIv5B7W11AWJ1mUbV4qaPzT1f9CSaZKPdozmYg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Wx3eBg_UPJEB; Fri, 21 Feb 2025 22:13:46 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4Z04CX48QtzlrnRt;
	Fri, 21 Feb 2025 22:13:43 +0000 (UTC)
Message-ID: <917f49a5-dae4-4810-8116-9bc93ddcd9f5@acm.org>
Date: Fri, 21 Feb 2025 14:13:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: C aggregate passing (Rust kernel policy)
To: David Laight <david.laight.linux@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jan Engelhardt <ej@inai.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
References: <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
 <20250221183437.1e2b5b94@pumpkin>
 <p7946077-rn30-n3p3-ppp0-80o9n9p07718@vanv.qr>
 <20250221202332.GA6576@pendragon.ideasonboard.com>
 <20250221220201.7068dfa3@pumpkin>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250221220201.7068dfa3@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/25 2:02 PM, David Laight wrote:
> And there is nothing to stop (I think even std::string) using ref-counted
> buffers for large malloc()ed strings.

This is what an LLM told me about this topic (this matches what I 
remember about the std::string implementation):

<quote>
Does the std::string implementation use a reference count?

No. [ ... ]

Why does std::string not use a reference count? Has this always been the
case?

[ ... ]
Reference counting adds overhead. Every time a string is copied or 
assigned, the reference count has to be incremented or decremented, and 
when it reaches zero, memory has to be deallocated. This adds both time 
complexity (due to the need to update the reference count) and space 
complexity (to store the count alongside the string data).

The goal with std::string is to minimize this overhead as much as 
possible for the most common cases, particularly short strings, which 
are frequent in real-world applications. The small string optimization 
(SSO) allows short strings to be stored directly within the std::string 
object itself, avoiding heap allocation and reference counting 
altogether. For long strings, reference counting might not provide much 
of an advantage anyway because memory management would still have to 
involve the heap.
[ ... ]
Reference counting introduces unpredictable performance in terms of 
memory management, especially in multithreaded applications. Each string 
operation might require atomic operations on the reference count, 
leading to potential contention in multithreaded environments.
[ ... ]
Initially, early implementations of std::string may have used CoW or 
reference counting techniques. However, over time, as the language 
evolved and as multithreading and performance became more of a priority, 
the C++ standard moved away from these features. Notably, the C++11 
standard explicitly banned CoW for std::string in order to avoid its 
pitfalls.
[ ... ]
</quote>

Bart.

