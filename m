Return-Path: <linux-kernel+bounces-322233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B75B972616
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBC8AB22BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35522901;
	Tue, 10 Sep 2024 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="Kfijd79+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gFREr/gL"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9301859
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927204; cv=none; b=mm+bIKDCYSQcsj9jYbnBgrKKnjtwPKovHCBszRIcQ+X5uWTViByM6mnoHhTaTB2NWAk0PnfeCGjHuI4v6vAunWgFOQhwB347QjSs61IG8FJYUTGwk5gTERY26w1GktW4frWPmkDzRo/JWQsEw22YtjPr78TAy1cZVTUIz2yuCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927204; c=relaxed/simple;
	bh=ujbpl4RceXXSiOyrm3n+wCVwZKmNpe535fyfhfNxGmE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eSf9sBSRvpUVcw7ZKE13feiVBwkKb5vliCo6MAVPOsgp8hbSh6xlDYwOSX4fBw5SoOZ8xvBFYbwvMQsz3grjGHOk0GMCs/LpcL5tXZVzHPZ4EDbJXgjzq3QKJoyRfmewPrAYJgnqjPOAV/yMoYbfjrEQ9Z2eJIo/jhZXlkrLZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=Kfijd79+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gFREr/gL; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9320C13801BA;
	Mon,  9 Sep 2024 20:13:20 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-02.internal (MEProxy); Mon, 09 Sep 2024 20:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725927200;
	 x=1726013600; bh=fKI4i4kY3uZ7tC9wpbWIKNOVsMDg+90C6y/ABOelzM0=; b=
	Kfijd79+HircDC18Co2EGumxNw9SH1q8waXY5i7mXe76Y9zuhqzgDHpOLMc2mMs9
	njEHv6piBimxZp0XE6Wh+KxDIHMkvFpBlsEjl08eK72YjVijCsak5TMDi64PQbRc
	HWEXb3TViEyKvW8VGHI8gWArk6Nt4glrCDGfU2Y6yresa2dE12g3zaXTDpFw0nwl
	VhT/7nFBDW4HmIxI2wNW/ZXD9nqlqtkiHlvEf7Fc2M51s12qhg1HO4FwWobGO0eN
	sp+LXUkno27npHutBO+dHcDRt7bU4V0wuTyG+3aE/zDg5XhbURCWjcg00Ngy4VcG
	tFuzdj9q9zZcrhJgRWswyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725927200; x=
	1726013600; bh=fKI4i4kY3uZ7tC9wpbWIKNOVsMDg+90C6y/ABOelzM0=; b=g
	FREr/gLpVDe/OeQOgUY6CXg+wx52oY1v8USEDCam+0F+p9AzB7jeGj7PnjKmZDKr
	VWPh39q+wDi31GKtX09RJfl46/317q42BWa6jNba3WM3AmDNthXcsiuVYy1qXhwB
	ooPUqeZbNNNMgzFiZzbYnQNlW4zQoFfjxmoJZ7qaScnsAOYupSzT6RH9A4H9DztS
	rW3tLeMtoYWv9/yKXe3afNYZrzIfwJMnpE++yCa8Jjc1eOx2R7RdsAtZiKHXODLK
	pTpoyeniMBR17u1vpf8f8NIa6aDWgcYAu3nQVfEcSe0hOgKeS+6QSoho2T3jj3+z
	EFFm1/vltS+xI4jY5oQuw==
X-ME-Sender: <xms:H4_fZgFHqSZmkZWgsaCUSMksNM1wKoWBQEFEnoyoa3gP_HYbc4aHvA>
    <xme:H4_fZpU9wCYo87Erc8MG1DoCjsi23rbVmWW7VFur8YAYEw-b6yvgB88FTlcc8J5_-
    sty22eBpoRyVBL5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevohhlihhnucghrghlthgv
    rhhsfdcuoeifrghlthgvrhhssehvvghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnh
    epleffgeegffffleeugeehgfejleelleejieffffetheelvdekiefgjedvudevtddtnecu
    ffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhshhirghnghhkrg
    hosehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhhinhhugidqvghr
    ohhfsheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H4_fZqJu6ilAYQyf4EhMfhcri2fTYQjts7yyTiyk_aRlvA4oQH9oFQ>
    <xmx:H4_fZiETcjbPJhrIy5VkzL2UVlPr7ZNzSdWbb-cANx_2Dm_uZPaH3Q>
    <xmx:H4_fZmWPcSj-OnsFBco2DzBOUponvlAfRxwVzpVqml4T08VnCaxeAA>
    <xmx:H4_fZlNoMYfqhB8ZmCD2BcmgPRwPc7joInnid2_1Zrun6B6BBaC8WQ>
    <xmx:II_fZjhEF_C1ui2QikD5RXZ2oAMqLxcWJtBfwXkBKR8-t11E_-cy7ViQ>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BACCA29C006F; Mon,  9 Sep 2024 20:13:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 20:12:59 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Gao Xiang" <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
In-Reply-To: <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
 <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
 <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Sep 9, 2024, at 11:40 AM, Gao Xiang wrote:
> 
> Just my personal opinion, my understanding of rubustness
> is stability and security.
>
> But whether to check or not check this, it doesn't crash
> the kernel or deadlock or livelock, so IMHO, it's already
> rubustness.

OK, if you're telling me this is already checked elsewhere then I think we can call this end of thread.

> Actually, I think EROFS for i_size > PAGE_SIZE, it's an
> undefined or reserved behavior for now (just like CPU
> reserved bits or don't care bits), just Linux
> implementation treats it with PAGE_SIZE-1 trailing '\0',
> but using erofs dump tool you could still dump large
> symlinks.
>
> Since PATH_MAX is a system-defined constant too, currently
> Linux PATH_MAX is 4096, but how about other OSes? I've
> seen some `PATH_MAX 8192` reference but I'm not sure which
> OS uses this setting.

Famously GNU Hurd tried to avoid having a PATH_MAX at all:
https://www.gnu.org/software/hurd/community/gsoc/project_ideas/maxpath.html

But I am pretty confident in saying that Linux isn't going to try to or really be able to meaningfully change its PATH_MAX in the forseeable future.

Now we're firmly off into the weeds but since it's kind of an interesting debate: Honestly: who would *want* to ever interact with such long file paths? And I think a much better evolutionary direction is already in flight - operate in terms of directory fds with openat() etc. While it'd be logistically complicated one could imagine a variant of a Unix filesystem which hard required using openat() to access sub-domains where the paths in that sub-domain are limited to the existing PATH_MAX. I guess that kind of already exists in subvolumes/snapshots, and we're effectively enabling this with composefs too.

> But I think it's a filesystem on-disk limitation, but if
> i_size exceeds that, we return -EOPNOTSUPP or -EFSCORRUPTED?
> For this symlink case, I tend to return -EFSCORRUPTED but
> for other similar but complex cases, it could be hard to
> decide.

-EFSCORRUPTED is what XFS does at least (in xfs_inactive_symlink()).

