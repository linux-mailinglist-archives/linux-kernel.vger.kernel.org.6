Return-Path: <linux-kernel+bounces-534530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FA8A46823
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3873A941B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FE1224B15;
	Wed, 26 Feb 2025 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="WM/0LC1U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tV02rHzg"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA3F224893
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591097; cv=none; b=ADf73IAkbWaK/ZfPA8xYV0/idQVyVGYxCQRcyoy0aK0oKBHatH0+ZyvTMwr1FpU+o7EyDsUO33RIOVRPxNvO1mWQXv5j8/dqJNCEFa/cwJPiZhOgxRUdTJOQgpEgPUQ2EQ5qpWbEv7L5ceb5pdLWhYMYXgcKWOe1zicR1uopghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591097; c=relaxed/simple;
	bh=X3eyYVt4vGD0YkiOvQPOaR6KKn41whT8TQ6EBFqhtRI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RBBXnp9Wf7LRJzxoYGiwAFHE6nCuiDrtje8lURm85UkUw7qRqINFFPFbqbCBdSrByPPRA2nWBAP+F/nWXfJqBnypERi0Aqu2qkldG5PIBNp2DrucDDV9FEA+TVQZRVDNBBrM3CzVUN5fVFSa8RZeNPFVbhsqCr4A2WZMxAqVZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=WM/0LC1U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tV02rHzg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 43EF31380090;
	Wed, 26 Feb 2025 12:31:34 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Wed, 26 Feb 2025 12:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1740591094; x=1740677494; bh=nUjbFqo2QU1rdCqx9p0fWtYPlF+MFrQB
	YwjU1X0A1aU=; b=WM/0LC1UY6lCx1XQ3RQMgiC5qkWp3PQoHg/zMjPgz+8Gq8S0
	FBenfcrQLGGoc5UF6zmDUP3l5ax0oHuMvWn4NraU7YrxngGwp2oOcZv2UOTxL6mb
	O9wNmTpGS2PzhF32+3LKfli/5XAP3geTi4ZH6stjuRQMc5qeLCg/wuQuMwV2x8c3
	aH4CsQa6Itghgtt93uX13spUhBejo1ZsVVsZZLdNhHOXy3TU2Y0wTmdYgXQ+bqZ2
	JBefG1dr9UPz4Ig3DJGYFgKq4xqjcoCZz1vWwuyr62UyK58tMZMU8NMDyBw4JeS5
	B7Eq9/dkO8h2qiWkNdUvPwaO47g38WHRdaJy/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740591094; x=
	1740677494; bh=nUjbFqo2QU1rdCqx9p0fWtYPlF+MFrQBYwjU1X0A1aU=; b=t
	V02rHzgC1pl8ZK+rDnzopS1aXDVwAw3HXJ313o9+R1x6Pz+0dcp6aEzlpRPWYBTD
	EWyp5iG2UcTRJdF+C00/FzCdJx2+tc6Q9HwgB6SoIRylZqyuVf8LvdGJuERd20WB
	9fpgaji04rE3N7+xwDAUKQpePeaLrJs2csHEt9/UCw0XPgQ+FORYeKGoi9ByLOdt
	mCBuskbLWPeSWDzeNegT8kPp6itF+c46gZpz0aemAFuQWeBtqV1rSBiKWq3nbifd
	LmCFC7FSwtMs8tw/Hl41SXgpt/hcC8pgDx0ZVzHqLPH6WeIXiyuVhJw96/tTOUZU
	+JUTXr8s5v/L0GUmSDwCQ==
X-ME-Sender: <xms:9U-_Z55QMmbaue7jPjXhTOPc2yJOxWxGcVdJtDRShFRS1JaB_8pNiw>
    <xme:9U-_Z25jeFUVG2jM6psDfQiMtLOJbP-HhX1KBmJTmfIaPw-mbaxz7JZVTM67ccVtn
    uKKftEi6v8ccc7LeGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhesjhgrnhhnrg
    hurdhnvghtpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhs
    rdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlh
    hinhhugidruggvvhdprhgtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsthdprhgt
    phhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9U-_ZweCX5KzNvhd_NpFBh_R4tdc8bGHGWS51T9n5Ct4tKBpTQiqMg>
    <xmx:9U-_ZyIT1FZTvA0dG08CxtLhYmTRejfkzuVcFFTmUlnnCY-fbDA3yg>
    <xmx:9U-_Z9J1GN3EYlpS2kbuxwhhEiIxLmsQ5z9DeMih4_F-cAgjffjR9g>
    <xmx:9U-_Z7xyw1f3v0lL-nXRwO76DDO9t1sWzdQeD7tvALwEXH2AT_S8xA>
    <xmx:9k-_Z7i6Koc12ngnRQwYUsJfAY3Ds7vuT0_vRi3o4B_Q3IEoHlXC_q6b>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A5F55BA006F; Wed, 26 Feb 2025 12:31:33 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Feb 2025 18:29:17 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc: "Janne Grunau" <j@jannau.net>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Hector Martin" <marcan@marcan.st>
Message-Id: <dfef22a5-1f36-403b-99c4-2d910a38f9ea@app.fastmail.com>
In-Reply-To: <Z79JyhOQUI_LV4oV@blossom>
References: <20250222-apple-soc-misc-v1-0-1a3af494a48a@svenpeter.dev>
 <20250222-apple-soc-misc-v1-2-1a3af494a48a@svenpeter.dev>
 <Z7y14Q3ifu7U1tHI@blossom>
 <63c5cbfe-4751-4409-9be7-2fda21b09503@app.fastmail.com>
 <Z79JyhOQUI_LV4oV@blossom>
Subject: Re: [PATCH 2/4] soc: apple: rtkit: Implement OSLog buffers properly
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Feb 26, 2025, at 18:05, Alyssa Rosenzweig wrote:
>> >> +	if (ep == APPLE_RTKIT_EP_OSLOG) {
>> >> +		buffer->size = FIELD_GET(APPLE_RTKIT_OSLOG_SIZE, msg);
>> >> +		buffer->iova = FIELD_GET(APPLE_RTKIT_OSLOG_IOVA, msg) << 12;
>> >> +	} else {
>> >> +		buffer->size = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg) << 12;
>> >> +		buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
>> >> +	}
>> >
>> > The shifts are suspiciously asymmetric. Are we really sure this is
>> > correct? My guess is that both size & iova for both oslog & buffer need
>> > to be page-aligned, so all 4 lines should be shifted, and the bit
>> > offsets should be adjusted in turn, and the lower 12-bits in oslog_size
>> > and buffer_iova are reserved. But that's just a guess.
>> >
>> > Anyway if this logic is really what we want it deserves a comment
>> > because it looks like a typo.
>> 
>> That guess can't be true for syslog since there's no change in behavior here
>> and the syslog endpoint has been working fine so far. This common code is
>> also used for other endpoints that request buffers and there haven't been
>> any issues there either. The size is just passed in "number of 4k chunks"
>> and the IOVA needs no additional fixups.
>> 
>> 
>> The entire reason for this commit is because this common logic just didn't
>> work for oslog. Our u-boot fork uses the same logic as used here [1]. We're stealing
>> a chunk of MTP's SRAM to make hand-off to Linux easier there. If either size or
>> IOVA was off by a factor 0x4000 this would've never worked in the first
>> place.
>
> I'm not suggesting things are off by a factor of 4k. Rather I'm
> questioning what the behaviour is when we're not 4k aligned. (I.e.
> the syslog or oslog buffer does not both start and end at 4k
> boundaries.)
>
> If we're aligned, all our bottom bits are 0, and hypothetically we're
> putting 0 into "reserved-must be zero" bits.
>
> I guess it's inconsequential if everything is 4k aligned in practice.
> But .. is it? I don't know.


For the common buffers at least we sometimes _get_ the address from the
co-processor when it e.g. points to its internal SRAM. We could access any
buffer aligned to a 4 byte boundary in that case because it's just MMIO
access then and I'm not even sure how strongly the buffer passed to us will be aligned.
I'd rather not zero out bits there because we just cannot be sure those really
are reserved.
If the co-processor only asks for a buffer we'll grab it using dma_alloc_coherent
and it's going to be aligned anyway then.


For oslog there aren't even any "reserved lower bits" in the message. It really
expects the down-shifted address on the wire starting at bit 0.



Sven


