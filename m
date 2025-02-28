Return-Path: <linux-kernel+bounces-539032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D22A4A000
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB3E177356
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F81EF366;
	Fri, 28 Feb 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GDMtPDjC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0K6pYIv"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174326FDB1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762701; cv=none; b=n5A92RhxW+ezcM7so/coCifc/E1rXWIbzJzSxpxhsijcGkUA31w/vWehYaQTfRtlIMY4NaQI+licALdmHMK7+r0ZrJopM5xYa88U0i4FaIYzbSv76KRkZq0rkvscyMKDZ4WNNa+TqwDq7ulqJbk83fk+tQFhHHGV4qnj/gJlB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762701; c=relaxed/simple;
	bh=eUVZaIqW+CB0jfOg2BINXDWYRbjVaHZId6dV5GpMm0A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j6NTtzXsaW51NK/5wBZ6o9EuZfDS78x0c8Ljy/euQ9oav9/HznYlYKACdI/kDBvy7vKKLk5tSAi1x7LB68lOpI+Yr8V4cVPQL+HTWNZxh4BYKhsJllTj5qGYNYSy5PEcCkw76FuAjhavkdl5C9sGMyrzeKtAQwQaXKWyXtbjyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GDMtPDjC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0K6pYIv; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 50EE1114012A;
	Fri, 28 Feb 2025 12:11:38 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 12:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740762698;
	 x=1740849098; bh=78ibwbV3I0RHR/tOF/oW/vYuywEd9IRmwNLiuOP1bIQ=; b=
	GDMtPDjCFpXDWe84i7W2sXZpQNls5nI1+iXNALO2a+Z9Hf662yxy633xetcphzNN
	Fd0q8PsfBIp0zRWAU2WgrrCqBvmivSvWFXmJUfZaHJU2gYmbGHiCdBAgmkBlZw7y
	7H0kNGSavFNjFkDsf70s7HbNSsEYiKmFcIXMvLfV99LSKBG1R5Vc9zIgTHLoT9BF
	8K5Loczn4u1g1PFCJb8RXjI+HGHrfdjMZQEYYHnXSM7TNeix4uFc00TU0bzzh5mI
	6RQ4XaOdGVuw/JsKYhRR+bjQc/RgPmRIFhpQSpgyGcMvt+iGUnDpd97TLZgD7O+B
	VMFiHvYQc/ydwQTMM7egCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740762698; x=
	1740849098; bh=78ibwbV3I0RHR/tOF/oW/vYuywEd9IRmwNLiuOP1bIQ=; b=B
	0K6pYIvewUolHHsJHKe3T7gq59YV8JfRa3L4EL9L+E9cjz9Hxkk4hOD9k/OoLoJL
	KrgiHLWeCTP+idRgJCtOJiUjx3Sz8ovvkZvJmQdaHjOfYQ5ez/v1Tq7L5ZuG1VEk
	uPnOCIxqdfxh6c2MUy+8xuacRc4pRYmiMA8AURrgR169JIbYOmyfkv9A0klqZkM+
	VIRzYpcIHt3IVCbSA5qFFN7A9aS6ERpHQlQzNh5YNdTk5BH2yk6/yrPpBEHwZ8xf
	0n3IZl9ipgPZZKo9D8HB6j3UrNk4PzBoVTS3Mp/YI6jQMllHdzPmqRIxO7V94PIo
	ZbcxW759myKtPFgNoR0sg==
X-ME-Sender: <xms:Se7BZ4yyIAddAWwmJp2jOffIC3TFhIMVrk-b3vyByKxiT6bINR4k_g>
    <xme:Se7BZ8TpW7K0GwEdp-OY1O_qfCwErEXk-2Akkr4gwxZKp1eN_Hf3SuACw95VCrvPQ
    ZWANKYy5-bgbvWPm4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeef
    keekleffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopegrihhrlhhivggu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrrghgrdhjrggurghvsehinhhtvghlrd
    gtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgv
    vgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Se7BZ6X4OPXH0JNnaPip6fg73h4G4bqxlMAGvCKQ2lAJM9X9hx_Qzg>
    <xmx:Se7BZ2iIpStp9Tjmaqm2BHHyfFfCaOuOCRvqfPDKjZiSOc5kMbyOGg>
    <xmx:Se7BZ6BILHqJcBlVKouWhlnRcM18lk6ovErKxBB_zOjBc5ais1UV8g>
    <xmx:Se7BZ3JIgQJzgtEzC5kQmSAZUDFxE6yrP7nDU1C6B3NVdlh4iR5NdQ>
    <xmx:Su7BZ83SjyOAF5MnA5CQxnvd3ERbLaYugye9OZcPJxOyDNVojTHKViJu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5142D2220073; Fri, 28 Feb 2025 12:11:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Feb 2025 18:11:16 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Raag Jadav" <raag.jadav@intel.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Dave Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <0011035a-5816-48c4-9fe4-c0b9db3c8e72@app.fastmail.com>
In-Reply-To: <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
References: <20250227070747.3105451-1-raag.jadav@intel.com>
 <Z8CD33_OWK2LB6IZ@smile.fi.intel.com>
Subject: Re: [PATCH v3 0/2] Cleanup io.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 27, 2025, at 16:25, Andy Shevchenko wrote:
> On Thu, Feb 27, 2025 at 12:37:45PM +0530, Raag Jadav wrote:
>> This series attempts to cleanup io.h with "include what you use" approach.
>> This depends on changes available on immutable tag[1].
>> 
>> Although this series is too trivial in the grand scheme of things, it is
>> still a tiny step towards untangling core headers. I have success results
>> from LKP for this series but there can still be corner cases. So perhaps
>> we can queue this on a temporary branch which we can use to submit fixes
>> in case of fallout.
>> 
>> Future plan is to use the excellent analysis[2][3] by Arnd to cleanup other
>> headers.
>> 
>> [1] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com
>> [2] https://lore.kernel.org/r/2342b516-2c6e-42e5-b4f4-579b280823ba@app.fastmail.com
>> [3] https://lore.kernel.org/r/f6eb011b-40fb-409a-b2b2-a09d0e770bbd@app.fastmail.com
>
> I believe Arnd can take it through his tree for headers as DRM part is 
> Acked already.

I've applied it yesterday and not seen any regression reports so far.

    Arnd

