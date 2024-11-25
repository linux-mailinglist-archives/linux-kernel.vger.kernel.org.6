Return-Path: <linux-kernel+bounces-420856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C99D83B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3902E1686A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A8D192B84;
	Mon, 25 Nov 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhI5mueL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39454765
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531554; cv=none; b=alr7+VO9eHQZ3B9gcKjDV+2LES7L4XuGtJhXGuWXNHBLtdpufxtYrdfeH/pzUgVhIumlqSUyE/i6/RmFJokl3TEsdgx77XwK9dxOD004X4jEZsZ7NUNsKpQpgHHaBZZfN542tytOT1Gm5NPD3JD2aBB50xtd+z4sS1vHgjVK8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531554; c=relaxed/simple;
	bh=H8jHzL6ei/EwpDcgwLpkQaZt1HF6WA/zA21C1UeDIrw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nGHxJgZVLTJFxzxnx9ocJyhVCOTQGdS1q+0W7qe45MmH9c1xmEfZckSrOCqkTBALBdbnEK9H/gzdletpDCunKrOb++uizRqgEay/ciRfrPhekjPV8Nz8y9A1bCzBhrm4ztea621hkX/bWWHE2RKy92qGrQbMxNzhIPY2PO5LwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhI5mueL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AC8C4CECF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732531554;
	bh=H8jHzL6ei/EwpDcgwLpkQaZt1HF6WA/zA21C1UeDIrw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XhI5mueLphW6ef0yguyAWCJqNEzy+DHC719shUyyleLxq2eLOVurIMK8+VRJg1yze
	 9gRDQRS7zEavLBH0t0QK+6euiYuFZZnpRf3oJldPI/gchwPvJbqGq/nazEdN9u+g1b
	 0Y8jHCOtF48NiTqceAMoN4vmM3QIPBg4vFJ6SwId56S6L6N2I5rWh19hBZwF/ceyzU
	 YgO1QNw6WKCjy97Szv0HLZr/FdBECp/MjW2aI+83yk66YEZ0dfpKTO+Mv8xcQfrWtb
	 vOmX+w7I3C6LsVBjQxppV91Kr6D6LTwtfsWiRRkT3+G18wghD0jPpphhE0uGa5wUxx
	 HJKoorEmviNkQ==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5BF4D1200076;
	Mon, 25 Nov 2024 05:45:53 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 05:45:53 -0500
X-ME-Sender: <xms:YVVEZ7CHpFNXYSOcsG7fX98L3WYaI8R8JyAKPAPD-py5VjxRprw2yA>
    <xme:YVVEZxgCLG0fDcetyNw7MYWY_9HGJmFPILzyNaZNWnMVvNopPLq8gdXfYiy6ogBH9
    -3qwtZu-sZYCF9XlMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedt
    udeikeeggeefkefhudfhlefhveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidquddvkeehudejtddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdroh
    hrghesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhm
    pdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:YVVEZ2nMHrtwzfhxHwDvebsx1Oro10v7We4QGWyIhduwTFaNNGJT0Q>
    <xmx:YVVEZ9zKchtTDvsdYuhQXVCLCQjQAQG7z4bsFwPZRF3_3FZZpUruzg>
    <xmx:YVVEZwTMNdkpUNRY_CFlGSXMUujImEWzvbvRvDO9JEyyw-7z7CbOsA>
    <xmx:YVVEZwYSyt274-1HwJfj0jAPd-TI3hZOzDetQDz65ioBbM_0EmQcvQ>
    <xmx:YVVEZxSiYD_EjdL2-SQeTKyTCXeVT5Tqd-OU_DmJkiQxR27o5f_iQ6Au>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 338B02220071; Mon, 25 Nov 2024 05:45:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 25 Nov 2024 11:45:32 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: "Jiri Slaby" <jirislaby@kernel.org>
Message-Id: <ce88e017-9c2a-4963-a64c-9893e12cf6ea@app.fastmail.com>
In-Reply-To: <20241125103305.1614986-1-andriy.shevchenko@linux.intel.com>
References: <20241125103305.1614986-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_port: Assign UPIO_UNKNOWN instead of its
 direct value
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Nov 25, 2024, at 11:33, Andy Shevchenko wrote:
> serial8250_init_port() assings 0xFF for the unset or unknown port
> IO type, use predefined constant for that instead.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I already thought about sending the same thing, but was going
to wait until we have found a solution to the
!CONFIG_HAS_IOPORT warning.

      Arnd

