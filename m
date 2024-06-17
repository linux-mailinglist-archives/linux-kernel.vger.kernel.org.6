Return-Path: <linux-kernel+bounces-217469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA590B029
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5771C22BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4D1D47D0;
	Mon, 17 Jun 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jP7sUEdM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Frztf95e"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD81D3639
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630657; cv=none; b=kH69V7cOvoSqzx1chojlvFH/vM+njhRriVLVabUVovnA6Akh8BYT/7tj9D7+IQKmEpFuZRoFDuH1kgCD7LzFTM83n8h9dNkUmTPTLIIq95KvMLip9xEHmRw/1lNCELbOzhR9bNvXIVREwxfL4DNnHrrpD+IARWyJHzmfcpOqN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630657; c=relaxed/simple;
	bh=Y8TUhCIZhvH0mPpll/+gqifT091gwUxLq/RLLYO7rbM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=J82CMAeCxA1LYaHsdN3DvU5LL55PI9j+FOqpaqlvvJIgaAs77RI/cMuEpacpXh+eSXZUKi7Z44mCjEHsDNjraAfme3wRPuAKMHoLSCXoZRRsMCA60DrBsu5Edix0oFJhH1R2WDJVRV2nKiT1RJJwScORFYsbeZLejAd6ZttOgU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jP7sUEdM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Frztf95e; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D394713802A6;
	Mon, 17 Jun 2024 09:24:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 17 Jun 2024 09:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718630653; x=1718717053; bh=RG0OOoOhRs
	DRXzn/o81MA/WQyCDR8o4YEPnE9nJjDms=; b=jP7sUEdMOQdalssTMMW5Sjxdad
	HQgG147nSiZjEMlPqZbYOB6kvTZoj6zE9onTWYa+h7KW0z236TG0JbeTZGtJjw/0
	2mAoBmNBQ7jAn0WwJmzfaDc8Y7bJahEbT9SPDXCkHHht8o+mnn/CcDS/Exv5pkdu
	3gu+xfiI84wsUyvt9QSXXI68FDHKi0P9Rm0OU24NCUIeSJf8oYtwITUuXJ8CfLEL
	Z537/5496p/zLLDXRRnRy6TVnmSrtFCzq/ZJl9DHHKg8YB6BxTIVX1EX8EqKWVlb
	c4Hlnt+tZAFAYtdgp5NQTdW1OWS4dCvz8pNycCOleIK0Q0nZxiQpEtE5SI4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718630653; x=1718717053; bh=RG0OOoOhRsDRXzn/o81MA/WQyCDR
	8o4YEPnE9nJjDms=; b=Frztf95eICG6TIscoqw1+WkLTmIcnHx2+lcit6hsXgXk
	DbbhqwImm1xF7axJ9gejfWuLh1Jiuq4J2xZfEIrbQlc0ttKRUgndoB+jT4w+vV69
	TdvbsuDmLCG5hGIRgaGatt/BN+g1hpQdQv2nnf92ycHhw+23E7tCeXEY7HNvcZ48
	Qqdf4dfoLSufsIK+e3kDb61gJdiJzQkLqKe0IA+05qwgMI0HSdktyC35IsWFoY58
	a0jwvWhSPGOwziGwrxYJLjfUi2boMcCZs8AHqoXGzSrFkEmXf+E/JMdxIyRSbhlM
	nbZLc96RnWcINd1+JbgNK6qRyBQ48TYnxSZRU/pjDQ==
X-ME-Sender: <xms:_ThwZprPkOGM_pCHV4_ZZBDr4vCTC3ZUSgBIapWwIV8s1tDmzhX7lg>
    <xme:_ThwZrrcGlvBAMP1-KR0mW7DR5drNOQ5vLntz-QGH1p4sz_wFY07aZzlzoGg0oJQt
    bPhH6fjU4UILkdX2JY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_ThwZmNvl6ukNcA0_diTqypDIbqfwRATBdoHbFxYoQzPBGKdA7si3Q>
    <xmx:_ThwZk7LtOtkOxnJtHwIZV8Obrv4b01KxOQFSediyvdrgjhiTKanMA>
    <xmx:_ThwZo5ozhatE88RsuDo7DOXB5WgY8WQYaOYiL2KYq9A3hl3sc3ceQ>
    <xmx:_ThwZsi0oC-ilm3L60bDLM5l-MLGx09QmESgA6BzmXlMegEwNv1jQA>
    <xmx:_ThwZj0xJ8B9j7LI12tfIKHOYF3bLbiBTqzXwLXTof22AraviiTcC6PQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 65367B6008F; Mon, 17 Jun 2024 09:24:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f39c75d-11f3-45ef-b0b5-d11c9f1720ac@app.fastmail.com>
In-Reply-To: 
 <MW4PR18MB5244E888BB8195D94A6E2EC2A6CD2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024042950-refurbish-duckbill-77b4@gregkh>
 <20240520110630.2568767-1-vattunuru@marvell.com>
 <2024060412-amulet-unflawed-f37a@gregkh>
 <SJ0PR18MB52462AA2A9F15103D5198CC5A6F82@SJ0PR18MB5246.namprd18.prod.outlook.com>
 <MW4PR18MB524422223AC92181942C75E2A6FA2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <4a4b1675-3244-4032-ae64-82ca8872288f@app.fastmail.com>
 <MW4PR18MB5244E888BB8195D94A6E2EC2A6CD2@MW4PR18MB5244.namprd18.prod.outlook.com>
Date: Mon, 17 Jun 2024 15:23:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vamsi Attunuru" <vattunuru@marvell.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Jerin Jacob" <jerinj@marvell.com>,
 "Srujana Challa" <schalla@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v7 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Content-Type: text/plain

On Mon, Jun 17, 2024, at 14:55, Vamsi Krishna Attunuru wrote:
>> On Thu, Jun 6, 2024, at 18:42, Vamsi Krishna Attunuru wrote:
>> >> -----Original Message-----
>> >> > -----Original Message-----
>> 
>> >> > The ifdef is cute, but not correct, sorry.  Please use bit shifts
>> >> > to handle this properly without any #ifdef needed at all.
>> >> >
>> >> Ack, will fix it next version. Thanks for the suggestion.
>> >>
>> >
>> > Hi Greg, the ARM64 cores on the Octeon CN10K hardware platform always
>> > run in LE mode and this CN10K DPI PF driver is only supported on
>> > Octeon CN10K platforms as the DPI PF device is an onboard PCIe device.
>> > Can I remove the BE format and only define the LE format for the
>> > dpi_mbox_message structure?, other HW device drivers of Octeon CN10K
>> > platform also only support LE format.
>> 
>> Isn't this a regular Neoverse-N2 core? That means the hardware does
>> support big-endian in principle, though it's usually only used in VM guests,
>> not on bare bare metal and the driver is fairly safe.
>> 
>> In general, I would always suggest writing portable code, as you never know
>> who is going to copy from your driver into something else. Writing this
>> portably is not that hard or less readable than using bit fields.
>> 
>  Yes Arnd, understood your point. I am thing le64_get_bits() would 
> solve the problem here. Can you please confirm.?, I will avoid bit 
> fields and use mask scheme to extract the fields.

I think FIELD_GET() is more appropriate here. Note that readq()
already swaps the data from little-endian into CPU native word
order, so you have a 64-bit number with the bits in a particular
place starting from the low bit, so you don't have to worry about
how the fields inside that word line up with byte boundaries.

You can also just use an open-coded bit shift and mask value.

     Arnd

