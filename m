Return-Path: <linux-kernel+bounces-447262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC39F2FB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C131883560
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6832046A7;
	Mon, 16 Dec 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="ghpk8Kob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NK+Ddy1N"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3C204595;
	Mon, 16 Dec 2024 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349430; cv=none; b=ZcJZAIRVYOAKyYN2QVhXXxWwhYzZFZpSC3zI5J9SDBEiKnXq27jQ4RzWoVub2bysTnOy52PYAOP6sHkn0/AuKcBOZKBsb+5kHLHNeG9GDViaVnKqZC7x7H5s1IKYUyd8C22CaamajSku8ZQXf8jvBV/JxHW7O2/u7A2li3eUKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349430; c=relaxed/simple;
	bh=+LEGVFBSxypDm/FSzGeDaE+twdIyDmd1Fh+q4tlS6Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IgBkRSuFCQ3C14DHGhKPXgrRPlZPqVE1+sLD7cod5rXRMLd6GAfqpWxIsC09Fpyljhp9ne7Fs84Yk2SEm1Ec5aoCSHHQKer/BvVH5u36AtsJU3eLDRGnPJewF4vOkHGoPbmKwhDKASR9F/X9vhJnU/My5q50Vo3H7qGj03Kliro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=ghpk8Kob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NK+Ddy1N; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3C5111400EE;
	Mon, 16 Dec 2024 06:43:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 16 Dec 2024 06:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734349426;
	 x=1734435826; bh=z9j4g314qRp+uvtm3fdfTzVHKZRmV/loMgiI78Ackoc=; b=
	ghpk8KobgVLPbc7IsrAsyDmQOsMeBEwQqSf3AuQXWjbf5mEN5wqkt4uildSaHzY2
	ImOnEpp9aRJIzg4OIZ0oHa9EMPRloTjD+aBKNtvZXkeEK/TEnfeAQ2N6mgPvSEb6
	yTWNzxk059KPpBJu+b10glqQEBavp8zlyODzZimjOw5by0Dn4R34VyB0x2NK0kcj
	11Dj3HC0NfKONUvyQSv/kPbh/n6JEDJ8J5oSJIGmPr5ej8E67AeFel6sX506AjLE
	OyOLfrpH9KnDACRrRTANml/ffsJb78Rvi5LPLmauyCJhShh25+inuSJpiJLaNcPD
	m728cBWV85ptG/32ZNCnxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734349426; x=
	1734435826; bh=z9j4g314qRp+uvtm3fdfTzVHKZRmV/loMgiI78Ackoc=; b=N
	K+Ddy1NT4cM1vbgmmixSquCJTvWakS8jZ2cgIeSnfjEnoy/sWc5cUZ8tXnQZQLN+
	v+ut5m6y9EttwNjo1hMBGwIogdWh2qiKDRlbCu7FwZ9fVuSYKTOn5x1+pOsr66xX
	WE8NqGKiGsfhfWWECmmZOwroYRxKb7ev18NVW2Woo9D/gJV3B5vxor3EMo2xpB1w
	5jI4zGEoJYRelNREskVzR1qyx/afVXB/PgMK/b/7/dbOg9AJN4yq2r9Ouhq2OR4t
	Yqa50V1Umn4h1HtXCWxrpiqzmRb6/81mMiwKc81iG4athZ2/EwJAhgz60sr6UGIS
	vN7eoTJxVFbJLLaBFRYZw==
X-ME-Sender: <xms:cRJgZy9yojoLa0pEK0KbDhaKop7EUqK1e3BkHC7SK8eIeGhedJoK9w>
    <xme:cRJgZyv0Cje8oBIkG9GH7GMPEAMfwvsxvLTdmFwmCwjUCNiARPYVqCb6KhCgbGVv8
    IVy74jHzu0l6x_hDg>
X-ME-Received: <xmr:cRJgZ4DwDKCwJc8JiJzW-ZsRTs39im6Tt4vU7UbZx2wjotcr9YFUK4VVgh7fMvGXF9Bn_uyvQyGyeMy5p-i7VtdPvlWrXAU68Coj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomheptehlihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecugg
    ftrfgrthhtvghrnhepfefguefgtdeghfeuieduffejhfevueehueehkedvteefgfehhedt
    ffdutdfgudejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghlihgtvgesrhihhhhlrdhiohdpnhgspghrtghpthhtohepvdefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlhiesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghsseho
    rhgrtghlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtiidprhgtph
    htthhopehjhhhusggsrghrugesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhirghm
    rdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:cRJgZ6fSeMAORWITVU0GpWrWM5AkYWcz0mb3oPAbD-sq5nCT4yBxew>
    <xmx:cRJgZ3N_68B46R30fMj15_eGV3bnNz-u9u5_L1aiUZMzi8gDb2vF1Q>
    <xmx:cRJgZ0kysXF_2JQMpve0XqkCHIVH0RlpjtwImWG1OaoTdFq_hbPAKg>
    <xmx:cRJgZ5uQibfxXH8aLLrgjn8expnal7dMV7dZMl7M2btSB1NFtXLBcA>
    <xmx:chJgZ6NVLJYvPMegkVMs9mGivqIbaW3Ybj7OHW-zy10pr9FTa44fzTYH>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 06:43:40 -0500 (EST)
Message-ID: <b5009cc4-61a5-4f55-9fb1-ca6ff1163c08@ryhl.io>
Date: Mon, 16 Dec 2024 12:46:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
To: Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rust-for-linux@vger.kernel.org
References: <nGnC07PmUqofHiX7HfZAOCIK1-CPS7DF8kdGhDgJgPts5KYrCrimmovP-4YMVgI7WRmFnGwbdndTtxCfp278cg==@protonmail.internalid>
 <20241211-vma-v11-0-466640428fc3@google.com> <87cyhrdh2w.fsf@kernel.org>
Content-Language: en-US, da
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <87cyhrdh2w.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/24 12:04 PM, Andreas Hindborg wrote:
> Hi Alice,
> 
> Applied on top of v6.13-rc2 and tried to build:
> 
> error[E0277]: the trait bound `ARef<Task>: From<&CurrentTask>` is not satisfied
>      --> rust/doctests_kernel_generated.rs:6884:22
>       |
> 6884 |             creator: current!().into(),
>       |                      ^^^^^^^^^^ ---- required by a bound introduced by this call
>       |                      |
>       |                      the trait `From<&CurrentTask>` is not implemented for `ARef<Task>`, which is required by `&CurrentTask: Into<_>`
>       |                      this tail expression is of type `&CurrentTask`
>       |
>       = help: the trait `From<&Task>` is implemented for `ARef<Task>`
>       = help: for that trait implementation, expected `Task`, found `CurrentTask`
>       = note: required for `&CurrentTask` to implement `Into<ARef<Task>>`
> 
> error: aborting due to 1 previous error
Ah, thanks. Looks like a documentation test that needs to be adjusted.

Alice

