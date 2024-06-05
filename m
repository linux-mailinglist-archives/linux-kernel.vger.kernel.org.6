Return-Path: <linux-kernel+bounces-202447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B088FCCB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CB9B294F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE11922CA;
	Wed,  5 Jun 2024 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VdRJzV9o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K6FpO8X9"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A11946DE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588807; cv=none; b=tVOb76Zbjp5d/5AkCvDrA0WkWr6mCu5zUoITQa7nH9kYjUvhKtghOiqdJa7K4mb0ZD6pNir/VthwCPLHz7lA/zk+ZzwTJLEiv57/XT9ocVU7lLq2QzjEyLgB3HRgNA7XVhtWrJAyBVSuPJv/e7sgXeaFZQ4svRWe9QqaiKanoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588807; c=relaxed/simple;
	bh=bJbJSqZB2rkbru4x0vbU/OX4P6AADquZWC2xY5GcwUA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=mPUJLoBzbD+0B5uXvrW3q7qEbzNlc1jds9GeoifStmA32DwlU0IQzJKGNmJQtBPxdcLyCceAjYx8KYsjtV3iJrQd/olBZB/FHbJ6zpDdZPTkRDUeH0DGncwLNnYzuADCCSHqsN9dn5aWJqHUohthzNWWGukP/PT+8GfSyjHhkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VdRJzV9o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K6FpO8X9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0E13011401BA;
	Wed,  5 Jun 2024 08:00:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 05 Jun 2024 08:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1717588805; x=1717675205; bh=R4On9M6zxb
	pKcjQrpt2xyYj0pGKyq2XbFfFWFOlZi1Q=; b=VdRJzV9oSCnzBvFWMQXlQ1yjsU
	czISruE/eH8htzQ1ytRUdZfAWTIhoCR7qVOIaLxrUtx5Ka0VxLwS8P/hBrzgGE+z
	5ZhpML9rzjzGZC37PLS9GBW1t6wxjYl0O2oNJ0YmdV+JkrK1vE+hPhqWelGaU8AG
	yEJGHvAIV6VyIHhmfH598+Do/CK7NNska0xW3GfNxrCi/zlWtUgV8RU2ClKD4SVb
	dt2U9mvs+AxSS/IqxgdMasHwWbYW0QoXUjIK+RolDEm/BP3Hv+Di/NeWlpJvP4zU
	JIggXoBvAV0ZZ8zux+UXdB7UhkApRY5TAeLRHq1bjlz9FSIUkbP2sT8Nuvgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717588805; x=1717675205; bh=R4On9M6zxbpKcjQrpt2xyYj0pGKy
	q2XbFfFWFOlZi1Q=; b=K6FpO8X9YYA3iE1TI4+r896fqY3aF8BM6fwQ4fWLIpTp
	rKEqhaWbi8gfysYkHLxOckl5OwqLlFaknFB6nUaKE+1gwE+WJk5IpW3bkl8HF06S
	ylpfjsH4eUCuyCeuqThGoLWYVXknWlMQ+Iy8/oAX8kVTY4U5IRsMyQ5xdWO53QwX
	1p1IShdvzMNrxqA5EJzYlFhJTU5c8ttL48C/0EKcbeSv1QuQIx1bm6GCPT6W4C6r
	6OFYVS56gXsCahJ7xV4JvNz3z+x7r7XuzVUAudaPe6TowrTtbE477oN5aSkHgsm/
	Qoqdqy0VPIEpCH9ARo2KLUQqfClbGFiz3kLKc15rug==
X-ME-Sender: <xms:RFNgZm4CrfoDm1tNoVdRujF_8Su1ZL3eCAROBfWwRDbVgCy4QLV9Vw>
    <xme:RFNgZv74NhW8rY-PWFM6yZHS7pnWQTy6esXkyW1SQQ4AKTzq6pCimUl5abGeTz4Ng
    SBDjCbKmkUxJJ3kAjY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeliedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:RFNgZleQpDEbUU-a8s17nQc__3xtPDeqbHUVJusS2ORDDBpSWfKBMA>
    <xmx:RFNgZjIL18OviV1lVJ1mpW5jDChXzKECU4uUH4ZicQuYjmkdl-zceg>
    <xmx:RFNgZqJ0-oC2XwCEDpuZ30JVJkXlzy4KJD1-mEeaE_Y6bxaYAE3i4Q>
    <xmx:RFNgZkzRq3HqW8oMK05vl-SM6oKm32Hn9CZFXwCm0weq5jfEDjrrDg>
    <xmx:RVNgZvG_0KjFnTzO3gapr07Bgc5O-RvToO2z9ry9nZM3bqGOezxiXgeD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B62D6B6008F; Wed,  5 Jun 2024 08:00:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93cf15d9-6709-4f64-880b-efb178b7bf01@app.fastmail.com>
In-Reply-To: 
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
References: <2024042950-refurbish-duckbill-77b4@gregkh>
 <20240520110630.2568767-1-vattunuru@marvell.com>
 <2024060412-amulet-unflawed-f37a@gregkh>
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
Date: Wed, 05 Jun 2024 11:57:01 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Jerin Jacob" <jerinj@marvell.com>,
 "Srujana Challa" <schalla@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Content-Type: text/plain

On Tue, Jun 4, 2024, at 18:21, Vamsi Krishna Attunuru wrote:
>> From: Greg KH <gregkh@linuxfoundation.org>

>> > +static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64
>> > +val) {
>> > +	writeq(val, dpi->reg_base + offset);
>> 
>> No read needed after a write to ensure the write made it to the hardware
>> properly?
>
> Yes, as it's an onboard PCIe device, writes will happen properly. I 
> will modify it as write followed by
> a write barrier to avoid any reordering.

I don't think a write barrier after the I/O is what you want here,
they don't just make I/O finish before the next instruction or unlock.

When you have like

	mutex_lock(&mbox->lock);
	msg.word[0] = readq(mbox->vf_pf_data_reg);
...
	writeq(DPI_MBOX_TYPE_RSP_ACK, mbox->pf_vf_data_reg);
	mutex_unlock(&mbox->lock);

there is no guarantee that the writeq() completes before the
mutex_unlock(), regardless of what barriers you put after it:
even if the device is synchronous, the CPU itself does not wait
for the store on device memory to complete.

If you actually need the writeq() to be serialized with
the lock, a dummy readq() is usually the safe option,
though for arm64 specific code, you can use ioremap_np()
in place of ioremap() to turn the readq() into a non-posted
store.

     Arnd

