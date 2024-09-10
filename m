Return-Path: <linux-kernel+bounces-323858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BFC974452
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F071C24BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9D61A76D3;
	Tue, 10 Sep 2024 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="ENSMjzN1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9vRvNoi"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BA193431
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001527; cv=none; b=BdN9eFIUwk0PqCJdUmIxdRo0cTJxG7lvoNKy5HIjkogzHKriUR8S5GGY13kcyo+Kv0WwQvpniKgaPGrShCZqQ8w3UaFE8IN52AWHJG7tqiU6GUB/Qn/g4OJ+r4ICKlB1k8PPs3GFIE1vzacNdCaKa/UY6/CnOjYSHTw8m7i4zZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001527; c=relaxed/simple;
	bh=WeL6w5nyqLtRRzFm5LVx/NHV8YfFZluKJyFp8t9NJ40=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AswRnVQg4PSqSfj1/Lx1NrehJMyLkkfxqWwfZcAtTwNJKmtT8BnYthNsI5eXE0aLEOY0RLB3fOfAMislg2RalLkmeNQxPxcBwceTEooqYx//S1DmQf1H/LCah3NNGhDNnZpTfXpZcfLx4POoxeJpLAnNwZ5k055o8+2Is7kM4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=ENSMjzN1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9vRvNoi; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 858FB114012D;
	Tue, 10 Sep 2024 16:52:03 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Tue, 10 Sep 2024 16:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726001523;
	 x=1726087923; bh=GXC0yulCrynQrY5/3EoWZXN2eEiW8kN3wl0FVcVuFxk=; b=
	ENSMjzN1H3C2E7LkjrJ4FO+OiSYzYKdzVdM7d4zjr7aCsGmgBh1IisWNBFGbdu5g
	dsGAxYNXOnbsiNlXxmfNdZG3GS5/Ia15wme3nYdeFit0aQ4uMplA0syxnWJJZdFH
	0W9GzmTF2cw4uoIl58EfzFTXLTNqtdzSvsjKxZ12hMOQix6qVjqvYKupb8wnEsVK
	x9m9RPX5mFqTut2+qO44Uy2LyS0ihioMAfxQC1wQf//VWxlnKaSbVehpXBYpskMA
	iYBMJqs+3yMuZ6xdkxMVjULYmuZclZQXj3j4NiwC0YXC7PC3yhfF0rIetHHefzPL
	THaDu58vB0TpIxvH/+ee2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726001523; x=
	1726087923; bh=GXC0yulCrynQrY5/3EoWZXN2eEiW8kN3wl0FVcVuFxk=; b=Y
	9vRvNoiGGtX3B6MZE/tIVNFPRe7j+wQwWyvIz1jFeXk5UaJ3+2IlXfDBAfo+PnWo
	VDKUrevLx3fPov5HfQiWhvgLJBBJK/46rfK/JS1K7BmD07IHNA2J0vNskDRYf6Us
	0BImkw87K56M+h9mwHmWKlUFBpH9hiZpvtFb5gVo0ucFwY5IIW7qLj9pK6eD8zIc
	yfz+Z9rLctvZE/SdAll6egGrJMMAAGhxWXeQ/eOZiuicwcuU0yIowJkDYnZVkqNe
	2zryq566mBHorlualrt5Krv+bb2lfewC3GT9WTep+NvlWnSGfpK9J+CvFyhXNBL0
	mlN/y3LPey1fQ2q6lsIJw==
X-ME-Sender: <xms:crHgZvtHPlAxZCVhdvN5h5_npGzd4l_DmguXqPGKnrxQP01qvYpECg>
    <xme:crHgZgdEimwSU0tqAW_8FIcZB53S4bIaO_Bj_vmujXzfKzcWZ_Z0gHQirjrk1gvfL
    9-0QALKCNmGmztZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhinhcuhggrlhht
    vghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtffrrghtthgvrh
    hnpeefjeeitdekueejkeekgfduffduiefftdfhkeevuddtudfhudefhefgfeeifeelvden
    ucffohhmrghinhepfihikhhiphgvughirgdrohhrghdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghr
    shesvhgvrhgsuhhmrdhorhhgpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehhshhirghnghhkrghosehlihhnuhigrdgrlhhisggrsggrrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqvghrohhfsheslhhishhtshdrohiilhgrsghsrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:crHgZiyZ0S-deCU5qyGaequ85oldZaAxmJuYkuUgZQQVSpU0Mt4elg>
    <xmx:crHgZuMrT01nDD6v9b28yisSgfgqNHE0wTFWswXAAlA1T7l9JTkmaw>
    <xmx:crHgZv9lq5ejeaivPQuyIyGitt9WL_T_mayqH2I9792v-EbbheIpmQ>
    <xmx:crHgZuUjmDvfokWAEgtxOCnXPejVuXTS_pS4yTcNSiWlo3yEEDriLA>
    <xmx:c7HgZhKUF93rh_Kvr14wwFfYrmGhGwVZ_tq7bE8A0Nx6Jvn5U7MmBmtF>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9DBEA29C0072; Tue, 10 Sep 2024 16:52:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 16:51:41 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <ba83ef6e-d4cc-4ade-9dd0-e3fdfa8fde70@app.fastmail.com>
In-Reply-To: <e137404e-16cd-4d81-9047-2973afb4690b@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
 <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
 <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
 <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
 <e137404e-16cd-4d81-9047-2973afb4690b@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Sep 9, 2024, at 10:18 PM, Gao Xiang wrote:

> I know you ask for an explicit check on symlink i_size, but
> I've explained the current kernel behavior:
>    - For symlink i_size < PAGE_SIZE (always >= 4096 on Linux),
>      it behaves normally for EROFS Linux implementation;
>
>    - For symlink i_size >= PAGE_SIZE, EROFS Linux
>      implementation will mark '\0' at PAGE_SIZE - 1 in
>      page_get_link() -> nd_terminate_link() so the behavior is also
>      deterministic and not harmful to the system stability and security;

Got it, OK.

> In other words, currently i_size >= PAGE_SIZE is an undefined behavior
> but Linux just truncates the link path.

I think where we had a miscommunication is that when I see "undefined behavior" I thought you were using the formal term: https://en.wikipedia.org/wiki/Undefined_behavior

The term for what you're talking about in my experience is usually "unspecified behavior" or "implementation defined behavior" which (assuming a reasonable implementor) would include silent truncation or an explicit error, but *not* walking off the end of a buffer and writing to arbitrary other kernel memory etc.

(Hmm really given the widespread use of nd_terminate_link I guess this is kind of more of a "Linux convention" than just an EROFS one, with XFS as a notable exception?)

> For this case, to be clear I'm totally fine with the limitation,
> but I need to decide whether I should make "EROFS_SYMLINK_MAXLEN"
> as 4095 or "EROFS_SYMLINK_MAXLEN" as 4096 but also accepts
> `link[4095] == '\0'`.

Mmmm...I think PATH_MAX is conventionally taken to include the NUL; yeah see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/namei.c?id=b40c8e7a033ff2cafd33adbe50e2a516f88fa223#n123

