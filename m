Return-Path: <linux-kernel+bounces-573962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C7A6DEED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E21E3AB834
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728A6261561;
	Mon, 24 Mar 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Zg+A9gOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0sKUAiC"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE02E3392;
	Mon, 24 Mar 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830837; cv=none; b=g4jAhEp8eba6r2PmrQG92FMtYr+QEVMCXXqWPyrBjuXmD5QK7Z+PU6DwOzHlyO+Uu9hjjTklMTYf5l1kOq66JlqP9vmr4Vakim2rHLYyYbvOUXvosrQKO41VpamgqX2wpDwdfW2EcnGLDfHLdxV0XZXRQumXqpUIZzF0BKThy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830837; c=relaxed/simple;
	bh=l4I6098IvP7v5LzbanRLrtAxL/0MyIYzt2nxEeuqjww=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nYu3zBtEAal3EXnNzuvf4NgwrUGiJmrlujXo00WA1PuqFVUBkVB63hdt5kcCbnyf4Fa1ioZW3Tyxlh7egBqiF6/eEFU8/dflYsvX0zU0gpAwCPlF2dB0RFuFPWBYMcV7oZSK6DfpOX84S8A6IVFVwPhBUJmU6Tn47kHiWzNR4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Zg+A9gOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0sKUAiC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 80A031383F4E;
	Mon, 24 Mar 2025 11:40:34 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 11:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742830834;
	 x=1742917234; bh=a6mL6ZV55LpLoF+o5FMn2VcT5nSELH0L7ai1+VLjQvY=; b=
	Zg+A9gOIxGeDQJ348LFVyaIf7A85kObEfXFEidZpNLmXLr8fWGVJLDCkRACIk+ao
	Z9kK68wRepkSmJfizPFRrTAkNNe9qGez/Qz0yhHzXeTtzofpW5+8GfRSpqJRiKHQ
	DEhBrmI4u9uL4oi05C5hlHdf8g2g1cGEAuSVfAuDBptjz4Gu5Gt6OaZUntZD0uVI
	CEM+hhYLZEEB1U9gPPjKrRVppIwoAJi6DIrlBBFwtAVj839DByVloWcE8U7Gaywy
	Jx8Syzuq/G5u3HwDFbea8EW4fvCgwhDCQe92R7ToEAkPIjOPiO5faI0yEG+xwUT9
	ve3tq1ywozmvfs1PtVbDMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742830834; x=
	1742917234; bh=a6mL6ZV55LpLoF+o5FMn2VcT5nSELH0L7ai1+VLjQvY=; b=Y
	0sKUAiCU6LFA/I1wSWTUCI0QHuhWMhikvz5KFlImSa0MjAOeMXX++L9qqr8Hb65A
	sxX/zvEJq+BXRrqOSKXs8sWJ+d07pp+cQwgIsWJFefRnzanqf4ky8A43ifU2echE
	2SWttls0GYdTpPFGkURhVk5nKEgbJ8NThu5VjSpWNt5Ss5sMbS1SxCv/RRIQMLjC
	u8oW89v6qEkJJ8g7578cs6JgQbj7S1Lx30fWA81q7WaHdL6Ky+sqSMsWOf5lG9N2
	JAULvVfUd/tFkl5pPhl9PzzLv5kHDqbwchdWu1KV5ssgK1xhdmbesg5dNkdUtJbr
	waYBBeCYFw9y70uBF0gAQ==
X-ME-Sender: <xms:8nzhZ-83mmEHo7gbo6l0XlEdj9lHcYBSv6mZ2y1uu5HCacFiX3txjg>
    <xme:8nzhZ-umNDdkNJ2siNCVLjwbt1qzzKJFmuUpKh6eTKcD-YIwQfVv3iPWVWZZ_belW
    WrzoiBaQIaulxdGeTo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhshhgrhidrghhuphhtrg
    esrghmugdrtghomhdprhgtphhtthhopegrnhgrnhgurdhumhgrrhhjihesrghmugdrtgho
    mhdprhgtphhtthhopehgrghuthhhrghmrdhshhgvnhhohiesrghmugdrtghomhdprhgtph
    htthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthht
    ohepnhgrvhgvvghnkhhrihhshhhnrgdrtghhrghtrhgrughhihesrghmugdrtghomhdprh
    gtphhtthhopehshhihrghmqdhsuhhnuggrrhdrshdqkhesrghmugdrtghomhdprhgtphht
    thhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopehlihhnuhigsehrohgvtghkqdhushdrnhgvthdprhgtphhtthhopehlihhnuhigqdhh
    fihmohhnsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8nzhZ0CMZnF96zX-GUeoPHNqmtfLd6WrRy_pXwexG_O_2vCfSzwHag>
    <xmx:8nzhZ2ejjnpYx9hX1XYuBzB287MoEb6YpJhCr2oPFYW_r84-MHjpuA>
    <xmx:8nzhZzPhwYYnu7WKn1q8dKVwULefEJCW_Ejy3UW9zMcV_V9CBwtsXA>
    <xmx:8nzhZwlRy-Z69iJkIENcXCo6uM0UKAKYvCLmZ-uTJ0tO0kTMG12JIg>
    <xmx:8nzhZ-prPwP8WUJrThhpHzVWnnODBBuukQlo1U5cJOkv7RBxLXLZA-ZU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 43DB62220072; Mon, 24 Mar 2025 11:40:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9168aded715bd4fc
Date: Mon, 24 Mar 2025 16:40:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Akshay Gupta" <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, "Mario Limonciello" <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com, anand.umarji@amd.com
Message-Id: <c9138dd3-6a09-47a2-a8fe-716c8894042e@app.fastmail.com>
In-Reply-To: <20250324145815.1026314-7-akshay.gupta@amd.com>
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
 <20250324145815.1026314-7-akshay.gupta@amd.com>
Subject: Re: [PATCH v6 06/11] misc: amd-sbi: Add support for AMD_SBI IOCTL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 24, 2025, at 15:58, Akshay Gupta wrote:
> ---
> Changes since v5:
> - Address review comment
>  - Address Arnd comments
>  - Add check for cmd in ioctl

I think you missed one of my comments.

> +static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned 
> long arg)
> +{
> +	struct apml_message msg = { 0 };
> +	struct sbrmi_data *data;
> +	bool read = false;
> +	int ret;
> +
> +	if (cmd != SBRMI_IOCTL_CMD)
> +		return -ENOTTY;
> +
> +	if (_IOC_SIZE(cmd) != sizeof(msg))
> +		return -EINVAL;

You are checking the 'cmd' argument to the function now, which
is good. There is no need to also check _IOC_SIZE, since
that is implied by the definition.
rue;

> +
> +	switch (msg.cmd) {
> +	case 0 ... 0x999:
> +		/* Mailbox protocol */
> +		ret = rmi_mailbox_xfer(data, &msg);
> +		break;

What is however missing here is a specific check for the
individual commands: I don't think it's a good idea to
treat all 2458 mailbox commands the same way and just
pass them through unfiltered here, and I would also not
pass the specific 'cmd' as part of a multiplexer structure.

Instead, I think there should be a separate ioctl command
for each thing you can do with the mailbox. From the existing
driver it appears that these are the commands currently
supported:

enum sbrmi_msg_id {
        SBRMI_READ_PKG_PWR_CONSUMPTION = 0x1,
        SBRMI_WRITE_PKG_PWR_LIMIT,
        SBRMI_READ_PKG_PWR_LIMIT,
        SBRMI_READ_PKG_MAX_PWR_LIMIT,
};

which is just the first four out of the 2458, and clearly small
enough to justify one ioctl command each. I don't know what
the command specific arguments would look like, so it's
possible you may also want to define a separate structure
for each one.

       Arnd

