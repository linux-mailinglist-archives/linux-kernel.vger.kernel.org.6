Return-Path: <linux-kernel+bounces-542204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323B7A4C6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384F6188749C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7CA21B9F4;
	Mon,  3 Mar 2025 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hlPtcxra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGHfFUf/"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A821C189;
	Mon,  3 Mar 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018714; cv=none; b=FjYL/zCmzUQ9J3lNqUKVksrQF+TLrimlKerK5brUylmcnPU9TsWLEJFVj8k8IqrEBedAngyarB3vHIAkv+BVQi24YrOLcw8c4G6rt8122GZIDjroeFsxdOE67xvx+l2rWzNU3+za3w1MW+e/qqTSVppyzPFtEFrymnSbiyPL0M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018714; c=relaxed/simple;
	bh=Shcgiv0ZUtINUIZW4HJZ/TRBrWAVRSUZV3UdJRymLBw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eyw9wbL1C7NQvjGcAG6ub+g91cTTSMmplR/r//G6EZ1ZgLCqOU8vuGq2QS+R5xz4MRbFlDq9kdxnU9nwknUgetzI+LvObfAEbxbAb2YIM4wZ85j3yioxHlQ+zBtH8nekTDAOhbWB1X2un+FbpB2PKhTLyrG8PNCyrr6/zFNaans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hlPtcxra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGHfFUf/; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 023F813826E2;
	Mon,  3 Mar 2025 11:18:31 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 11:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741018710;
	 x=1741105110; bh=a9n+QWQK7JixvqX2jl9NOcrAvoreNZlOocQmDIAQklg=; b=
	hlPtcxraYJBuAHEJAc1xFuNxN3Gf/QgO8k7yycrX9lobYCnCUL06nU1a6TfEtLf1
	BqZWE2neYgZWJD0d3dq+3G1vIuVgqUh0dWM4U/Ub1AYHB4bj+Rtu/YeIkkQyngXf
	P7CcT07n/NDxgTCIln9e6RIdLQ2uj0No+s1hnQCZq7oxZ6F4eARbBJ4J9QfbJ6tu
	CiOoRYIF0SQNJi1Fs1lbuhtHz+BtXRqkx/1XYAvc1VnldgdLLXdEObFPaoMlfwib
	Tf/uK8ms9mRO6UxM6fQlPPQ1RIUPwL2kqH0XDAcGl3zZ87Kvd5TASJRWBPbuB2eZ
	hOy4gjHTSSxOoa7fTbqIUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741018710; x=
	1741105110; bh=a9n+QWQK7JixvqX2jl9NOcrAvoreNZlOocQmDIAQklg=; b=b
	GHfFUf/4mecdzLQu6P0cImPT/KzjDgCt1BodsMO4nfmy/kMiP4Bk8se9XrXK+s4z
	Mcl68hG/gXuM/dghDYPrSvQrfHnf55LTMvDH6Zs49Pplx0k7/BdXbJ2uTW9iOwnx
	4yy9nWQ/HW1RkNn8RI8rQmDY/t/h31b2A+Ol3wPEsCd5O1m5kNl/OSOI/yAyNQoi
	sAHTaozjoXjVAywWGQag21pqHIRTlXaBvgtao1x2w6PJxm6nPaxbXeuTmGU69jzK
	S9MXWh2JMbo3h+oEWJSPmdOTexI97h+49Isz8a3B55BzWbF4lGAlpY7SEYJLf4kw
	LB9LUUwepMdIN3H0g3euQ==
X-ME-Sender: <xms:VtbFZ153eAy9AkJjjsAzFWphXA2NGSA2VDMmO3ji8anpRzGln0CGRA>
    <xme:VtbFZy5jJ2F7dkrbOxoAeIMoFGLkUS0J62xZs62D8EPeRjvsKhAESkhv7fi7VGVYS
    4VbF5kHIA1mEl9RX4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhshhgrhidrghhuphhtrgesrg
    hmugdrtghomhdprhgtphhtthhopehgrghuthhhrghmrdhshhgvnhhohiesrghmugdrtgho
    mhdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpd
    hrtghpthhtohepnhgrvhgvvghnkhhrihhshhhnrgdrtghhrghtrhgrughhihesrghmugdr
    tghomhdprhgtphhtthhopehshhihrghmqdhsuhhnuggrrhdrshdqkhesrghmugdrtghomh
    dprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdp
    rhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgvthdprhgtphhtthhopehlih
    hnuhigqdhhfihmohhnsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VtbFZ8fmqAq5--EVuEM-g4YApfa-roxd8oY7OUlnc4T-sgEhVD9vkw>
    <xmx:VtbFZ-J4mN-uZMBgfRfUhj8HIOj6IjuTro0vMn4K-Q6JgUE7gPoYZg>
    <xmx:VtbFZ5JIItkfYu5q7tx0ATprNoPizMWRFra6XK3KunZ64xiGmLZnFA>
    <xmx:VtbFZ3yuSkSgul29DfkTM7yS9-GwogaaD_DSYjWHeIat3zR1VZM-yg>
    <xmx:VtbFZw8Pi3CZqTi1oUyYPhl_pNDRAY5MmsjL8ZpyTGcu-qxxjDjuJ111>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9921B2220073; Mon,  3 Mar 2025 11:18:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Mar 2025 17:18:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Akshay Gupta" <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, "Mario Limonciello" <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com
Message-Id: <c3c1fee9-d119-456e-827b-04ba6cdd8d7d@app.fastmail.com>
In-Reply-To: <20250303105902.215009-7-akshay.gupta@amd.com>
References: <20250303105902.215009-1-akshay.gupta@amd.com>
 <20250303105902.215009-7-akshay.gupta@amd.com>
Subject: Re: [PATCH v5 06/11] misc: amd-sbi: Add support for AMD_SBI IOCTL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 3, 2025, at 11:58, Akshay Gupta wrote:

> +static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned 
> long arg)
> +{
> +	int __user *arguser = (int  __user *)arg;
> +	struct apml_message msg = { 0 };
> +	bool read = false;
> +	int ret;
> +
> +	struct sbrmi_data *data = container_of(fp->private_data, struct 
> sbrmi_data,
> +					       sbrmi_misc_dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	/* Copy the structure from user */
> +	if (copy_struct_from_user(&msg, sizeof(msg), arguser,
> +				  sizeof(struct apml_message)))
> +		return -EFAULT;

This is not how ioctl commands work: you need to check the
'cmd' argument, which includes the length of the data.

copy_struct_from_user() makes no sense here since the length
is fixed (for a given command).

> +	switch (msg.cmd) {
> +	case 0 ... 0x999:
> +		/* Mailbox protocol */
> +		ret = rmi_mailbox_xfer(data, &msg);
> +		break;

This looks like you are blindly passing through any command
from userspace, which is generally not the preferred way.

Usually this should be a known set of high-level commands
accepted by the driver.

> +static const struct file_operations sbrmi_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl	= sbrmi_ioctl,
> +	.compat_ioctl	= sbrmi_ioctl,

Change this to

.compat_ioctl = compat_ptr_ioctl,


> +	data->sbrmi_misc_dev.name	= devm_kasprintf(dev,
> +							 GFP_KERNEL,
> +							 "sbrmi-%x",
> +							 data->dev_static_addr);
> +	data->sbrmi_misc_dev.minor	= MISC_DYNAMIC_MINOR;
> +	data->sbrmi_misc_dev.fops	= &sbrmi_fops;
> +	data->sbrmi_misc_dev.parent	= dev;
> +	data->sbrmi_misc_dev.nodename	= devm_kasprintf(dev,
> +							 GFP_KERNEL,
> +							 "sbrmi-%x",
> +							 data->dev_static_addr);
> +	data->sbrmi_misc_dev.mode	= 0600;
> +
> +	return misc_register(&data->sbrmi_misc_dev);

What is 'dev_static_addr'? Usually you want a miscdevice to 
have a constant name and a static structure definition, not
dynamic allocation.

Are there multiple devices of this type in a given system?

> +struct apml_message {
> +	/* message ids:
> +	 * Mailbox Messages:	0x0 ... 0x999
> +	 */
> +	__u32 cmd;
> +
> +	/*
> +	 * 8 bit data for reg read,
> +	 * 32 bit data in case of mailbox,
> +	 */
> +	union {
> +		__u32 mb_out[2];
> +		__u8 reg_out[8];
> +	} data_out;
> +
> +	/*
> +	 * [0]...[3] mailbox 32bit input
> +	 * [7] read/write functionality
> +	 */
> +	union {
> +		__u32 mb_in[2];
> +		__u8 reg_in[8];
> +	} data_in;
> +} __attribute__((packed));

You normally want to have the in-kernel data aligned. Even
if userspace has it at a misaligned offset, it will still
work without the __packed.

     Arnd

