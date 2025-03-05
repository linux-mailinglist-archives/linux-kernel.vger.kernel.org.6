Return-Path: <linux-kernel+bounces-547474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189CA509EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F383A3776
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42AF1D63C3;
	Wed,  5 Mar 2025 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rIVNU23p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5sixJxiH"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99C18E362
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199163; cv=none; b=G2wCeY/BAzIqxEZPzH/C8g/BxU9OBhZkoQGmCO/pPLZV6ipgA8KcP6o7gwt08WlVxePkpaEg5CHUJfM2Go6dkQF03wsIiSNQfi5wTQ6jqN9xL7FGyScVz1he0cWvPYir7EdYnKbSAcQNG27XwLOHPEBZ0jOTyZBxii9QDuqzMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199163; c=relaxed/simple;
	bh=xnYuyaNVXncB7uxGLWFUWsmhJrqIEKW7rR/7ZC5CiaY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xr6P8FpACoIGutBW8nNSwkSPI6ndChTImSMgqxlFs/Z5Nrj4TRITL8JQX13ayJ7qvwlFqn3L9WKd5cX4Wqlpi2JRRw/r/naFKsya7QJqjkIXa9IeXkZxUfwtz7F0RAdXSX2FGQcJq1EPbc/i4OnDDX5N1ILsm3PPuY4bn7kcLvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rIVNU23p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5sixJxiH; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id BAC141140199;
	Wed,  5 Mar 2025 13:25:59 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Wed, 05 Mar 2025 13:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741199159;
	 x=1741285559; bh=q1dco+A1ZQ134eZ1BhjcbdIuYCO4f0Xtrgj8AjId3H0=; b=
	rIVNU23pV2mRSjKjsxplZRcfLak3xJn+HgNi52nfZKD0hkxLhz81qR0zds8sc6O/
	80DK6rfwnPw7bC7b3aV2ocpN6OzavwlWunwR6YOCtp0hsqy1R2HSTXYAu/nWpEXQ
	NDq265NtpP7uiPYENnhaIDXKCEta55HZ8gslnbn3CEHyauWTB2mXLuHBUUKkDK2K
	soSmV89GGqb3AZBT+b3wrH+iKWIgKEpECg0AK7RwC2kDuFCBvOwn9oNZuJA+/LKQ
	rB6rdcbZY8U1LPhssEsvxMn/2xWzAgKmrtWIu2S7fIM8vIeRadKOUYU/arrmoh4z
	1f3I/dGjmR0zCgiLvSyk0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741199159; x=
	1741285559; bh=q1dco+A1ZQ134eZ1BhjcbdIuYCO4f0Xtrgj8AjId3H0=; b=5
	sixJxiH2hJ5LQPpsk8DGqxPZdxBE9mzc6oZqYom7PI7wCZLSewmTfa8PaeOLmQuR
	/82LWLLL3vieFsafOb91od1lcZoUA2ZHR115GK5Amq3mgTwaTpX9vSa0SMI63dCF
	TOIQ+fsa6mMOVGdmat8qRnU40W6S5oUaCFPqIFDDi1+y2kaneUwlQR2x9Vd7ql1q
	B5NTvB++t70PxcKCy94I3QSM317iykHrEClT5OOkT1KxlfD4YktCbAcWHHrg+ffK
	y2tNdFg53cNGgywiizyninT0UVaZoVzF3xUamjWO0/TuZWA0Lw1CLIpXoZMl/O94
	8RRo6r9QH5XB3Gj0DIbtg==
X-ME-Sender: <xms:NpfIZ-Tri66tAvsbdpm_YNNGIz4J1VtV1pDvTBUlQi0D3Y8NblYQtQ>
    <xme:NpfIZzxkqH2rINK-WVt5Z4MmKwm6ScI3KVXG_iHqGOa3g70DbXsiMveKTUsuEKY8s
    MEAibFxzXfqKg4hRgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjvghffhiguhestghhrhhomh
    hiuhhmrdhorhhgpdhrtghpthhtohepphgvughrohdrfhgrlhgtrghtohesghhmrghilhdr
    tghomhdprhgtphhtthhopehjrghnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    ifrghnghhkvghfvghnghdrfigrnhhgsehhuhgrfigvihdrtghomhdprhgtphhtthhopegr
    rhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtg
    hkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:NpfIZ73tcDHoIEY_-wddHpy5Keiy1ldYak8XcrXOIv2ZNj4RYWe4-Q>
    <xmx:NpfIZ6BzzNevljukY8D5wkwUePl2V9o8SQA6EiWraPLUfDtetgzOtg>
    <xmx:NpfIZ3i_siWkkXIhR74W-OUKiJIGvtpPAfVkBZBKE4SNvu2dZ-AbNA>
    <xmx:NpfIZ2ryp7jRm2vr0ON0ORTVA9SfbUXgdOuGYWAf002FWQtCkz9jgw>
    <xmx:N5fIZ6pzJwlLg8a1Wc55ZqQ1XvqTeHDOJUQ5nd0k9IPPLGPgvU_60SLt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 970AD2220072; Wed,  5 Mar 2025 13:25:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Mar 2025 19:25:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Jann Horn" <jannh@google.com>,
 "Pedro Falcato" <pedro.falcato@gmail.com>,
 "David Hildenbrand" <david@redhat.com>,
 "Kefeng Wang" <wangkefeng.wang@huawei.com>, "Jeff Xu" <jeffxu@chromium.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <eda53542-14f2-44fe-aa18-8cd3dfe1ed75@app.fastmail.com>
In-Reply-To: <bc7c9b8a-83e7-49f8-bf0a-2f2bb950b99d@lucifer.local>
References: <20250305172800.3465120-1-arnd@kernel.org>
 <bc7c9b8a-83e7-49f8-bf0a-2f2bb950b99d@lucifer.local>
Subject: Re: [PATCH] mm/mremap: fix uninitialized return code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 5, 2025, at 18:29, Lorenzo Stoakes wrote:
> On Wed, Mar 05, 2025 at 06:27:56PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The 'err' variable is set in a conditinal branch and is not
>> set otherwise:
>>
>> mm/mremap.c:1017:7: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>>  1017 |                 if (vma->vm_start != old_addr)
>>
>> Set it to zero before the initial value is set.
>>
>> Fixes: 3129f7896afb ("mm/mremap: initial refactor of move_vma()")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for this, however this has already been fixed via Andrew doing a
> fix-patch which should land in mm-unstable,-next soon (possibly tmr?).
>
> This is entirely my bad btw, for some reason my compiler locally didn't
> catch this even with CONFIG_WERROR on which _really_ surprises me...

Unfortunately gcc never shows warnings about conditionally uninitialized
variables. There is a -Wmaybe-uninitialized, but that has so many
false positives that it is completely useless and it is turned
off globally.

      Arnd

