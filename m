Return-Path: <linux-kernel+bounces-429854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBBF9E27B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4BC167681
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161761F8ADB;
	Tue,  3 Dec 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="68ogcBc1"
Received: from cmx-mtlrgo001.bell.net (mta-mtl-001.bell.net [209.71.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0671EE019;
	Tue,  3 Dec 2024 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.208.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243943; cv=none; b=k6XzE/AikgUrVu7iWU1u6kekLBM2jlxOE3VbPU0aABz+zGlmnoAxdiqNettQiWg7nfvLCn9hQTibaVL0ApFD8/Ju6keOosvcBQhgBKWB4pCI5JU7QWfbg87kr41kDlt1o9+b1Hp6MRhIneRXjWyPFp0MR06TEZfdJLlspMrW8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243943; c=relaxed/simple;
	bh=vxms5DIqNTipQhhG6Cp4FqAvutQweeMElDMclIuldlM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cqj8ZCb179Dh0eh0yQ0R95N84Y93/LYPfaAigMylvH3BqgX3uxgoTIveryW2dtwUPEx6rEuJn1jmEDZA1TlDYO93yrdnVeTV7qmtZ1l7rylqwslOaXgqdwelhhDzs/dsGwIzaqtWqr9q35B7/X65ypPskTUuvHVza716NyRzP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=68ogcBc1; arc=none smtp.client-ip=209.71.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1733243941; 
        bh=oZ7q7RSNOOH9YeKm6NnPg1ciR8arHxUfoukjYdNgT/o=;
        h=Message-ID:Date:MIME-Version:Subject:From:To:References:In-Reply-To:Content-Type;
        b=68ogcBc1KvGD9QIdTYkNtpS827pGiuJgL2pbWZUfITywUXr9kuwkl1a5ZthCNwxoCP3DZh2PmbqEhLL6RTp1Ba8vovQ9o8fCbZtpqcQW8iHQRGudsbuWMN8yA4zVUO3VePwXYCCkGubWwN/DS/wPIttQjxjN7GV4CGFGm4YBJInnXjF5OZGTq9QVeNWO4NZm5rmcumEhsEoHeABxz/PHHR/FmNN8CRwULuNr+8/9RBscYaxghiaUC5nOxjalPl9KfHhuIHKr/VKZs+VDg8DqdQWLqGkaWTcGeYDPflHtmdMejt8on0PuA1/rGGaHDCDk/Ee/Qp2nHJReUWrqgJI7pw==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 673CEB0602AB19D5
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrieefgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceugffnnfdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhhnhcuffgrvhhiugcutehnghhlihhnuceouggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpefhiedukeehlefghefhtdelffekvedvfefglefgtdelhffggefhueeitddutddugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedugedvrdduvdeirdduvdelrdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddvrdeglegnpdhinhgvthepudegvddruddviedruddvledriedpmhgrihhlfhhrohhmpegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdprhgtphhtthhopeguvghllhgvrhesghhmgidruggvpdhrtghpthhtohepuggvlhhlvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnmhgrghejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
	nhhugidqphgrrhhishgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhorhhopghmrghilhhinhhglhhishhtpghkvghrnhgvlhesmhgrthhorhhordhtkhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (142.126.129.6) by cmx-mtlrgo001.bell.net (authenticated as dave.anglin@bell.net)
        id 673CEB0602AB19D5; Tue, 3 Dec 2024 11:38:52 -0500
Message-ID: <7551c27f-58d5-4e4b-ac7f-8d09be634104@bell.net>
Date: Tue, 3 Dec 2024 11:38:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected] ext4 corruption on parisc since 6.12
From: John David Anglin <dave.anglin@bell.net>
To: matoro <matoro_mailinglist_kernel@matoro.tk>
Cc: Magnus Lindholm <linmag7@gmail.com>,
 Linux Parisc <linux-parisc@vger.kernel.org>, deller@kernel.org,
 Deller <deller@gmx.de>, Sam James <sam@gentoo.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk>
 <31c884b9-77c8-48dc-b84c-20e52cdc4d44@bell.net>
 <71fae3d3a9bd816ea268eb73c152b564@matoro.tk>
 <CA+=Fv5Qy0818xS3uW2bh2nVpy-3COUzbq5X0JPY6=YzbfYgNOA@mail.gmail.com>
 <03978220-0153-417c-8479-09239d19c9ba@bell.net>
 <9bdbf64bd63ab7eef2f5ead467f3c8c4@matoro.tk>
 <7e3682f8-ec11-40b0-898f-f3729d6f110b@bell.net>
Content-Language: en-US
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <7e3682f8-ec11-40b0-898f-f3729d6f110b@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-12-02 2:45 p.m., John David Anglin wrote:
> I also have in config:
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
Here is a comment from <https://www.kernel.org/doc/Documentation/timers/timekeeping.txt>:

On SMP systems, it is crucial for performance that sched_clock() can be called
independently on each CPU without any synchronization performance hits.
Some hardware (such as the x86 TSC) will cause the sched_clock() function to
drift between the CPUs on the system. The kernel can work around this by
enabling the CONFIG_HAVE_UNSTABLE_SCHED_CLOCK option. This is another aspect
that makes sched_clock() different from the ordinary clock source.

Dave

-- 
John David Anglin  dave.anglin@bell.net


