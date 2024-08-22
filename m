Return-Path: <linux-kernel+bounces-297663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7325E95BC1D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2752D282898
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F731CDA28;
	Thu, 22 Aug 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="S8XvGpDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HxN18+/V"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926E1EB5B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344817; cv=none; b=QBov/jK8pHBoU/8yh2HV969185xHtiiJQ1UgwHVrWEIaT0DMYS34WPAC28ihyc4M+8UGxaUdS39MTLyQo32yrzlDE6AJ2/0GNnJhx9XxCN6wTekDsntxY3ilZG04kMShAQgWEVT/xZhLKuL+1yEApaH4HGpWGJ/9LiMBXamcnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344817; c=relaxed/simple;
	bh=wrNHX+EWRqSzAquh/0Exd8F2vxeOfiW0IC2CXHdBMnk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Bsn+Z3RmZLhO6IK/u8XltAt4WsrmpmcfSkWKCgMlxGwdjvIdB+YBQkr78bVkwiiZQkun1GxkOGNNx7i2Ua2251VU6RMeGvHTTnCaegLFj4Lz+rvYQ1QNUk5xrwWgQ6ny19lTMys7kQlWTfwtPIYG2oYckman0ewGHxE/F44+N1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=S8XvGpDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HxN18+/V; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 60FFE138FF82;
	Thu, 22 Aug 2024 12:40:13 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 12:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724344813;
	 x=1724431213; bh=K0aO7XBUAYMKnLu+orlrwHfPQqL15G9R+xTGJS+4qp8=; b=
	S8XvGpDZzmF0EbSAXV8hows3TRXl6bLj3Mk5bIIRy77bvvZLWB4GodGOiQ+uL+wj
	6sMQWuUeKXUCPEVtVtMT0Bgv+zZg6moOTtHEecxTf2rbwv8l+S6S2DJ/MK4et/s8
	8VKfMpnccJSHC71PxSI5zjvDKB2HGUIsNTHndERfVrcelty2BIjy6/U4GKKrzfvF
	BVqd9m6mc42s7FTI/00jjwxv3Kq6L8gnuRQpTbhidKAJ3rYX+E/KC3488YU2O4vo
	HtRRfz1X6rEz2Mdj+ssWn4HkIqowmzCUL5S/sh0luh5fuMT3EYn2iMitHY9nFbgM
	DICa2U9+pjbQtaCfdJblXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724344813; x=
	1724431213; bh=K0aO7XBUAYMKnLu+orlrwHfPQqL15G9R+xTGJS+4qp8=; b=H
	xN18+/VWGYGivLweAb1Z3utYi1uki2dOcCTwGWJmuam/I8+Nb6hsfbm1V2zcxITb
	1bf9yP/VuMbtaQJ/Ke427D6r4oOTMFrO29egyf3OsC/7Mb0pepIR0W4iB5hdHfnD
	dx6yPv4lveAguLRLzhq4KaxgHS0DBbq54pLYcTR4NPQiK/ZK3ydCq9A/UlBtfx9S
	1Ug6f3qlSpvwuySVRgBn48CcJ0UKBSxDhYx/g9mu3nk8zPmzBt/6Q2srGzPw/tsH
	hJfm3wpS4Apkx8Rhnd5G243ko7c4Q/dHP0Asr1Ubm7TZWOK4PZU+0Y3GUoJdTByE
	YqkwMWkKHkTnWvTv7ZGQw==
X-ME-Sender: <xms:7WnHZtUg45KXimj1v2LAFGCw5HLuFAegGovpIJG_8tmzghgOhEpOAg>
    <xme:7WnHZtl0htyxAakzL6JcgnRKUIEl1BCp0kLFfkFEwNJ-0wSsFQlpgC3ZI-XkVJrhA
    lsHWvIbtTEm4wl8WmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohhhihgrghgrrhestghhrhhomh
    hiuhhmrdhorhhgpdhrtghpthhtoheprghlvgigrghnuggvrhdruhhshihskhhinhesihhn
    thgvlhdrtghomhdprhgtphhtthhopehtohhmrghsrdifihhnkhhlvghrsehinhhtvghlrd
    gtohhmpdhrtghpthhtohepvhhithgrlhihrdhluhgsrghrthesihhnthgvlhdrtghomhdp
    rhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7WnHZpYOp49Uw6g2rTOp--a8PXMVWqhbKhXobD0uvFBWEFKHyKVYXw>
    <xmx:7WnHZgVmZwz_kTxboYSsB27_SjbUmEqeT9PQy8sD3ZQQ24Hfv8iMCg>
    <xmx:7WnHZnmyjsx8PcKyjSLX-3VDhuJG2rJXQAenU-61FV0LbTUQ3Rg7ag>
    <xmx:7WnHZtdPjUO5_6lFQV1eDPC43hfn3LAbzLVDpdvwurNqUnHuahXXUQ>
    <xmx:7WnHZisIXsX-DHt7bsO98EeFiumRz1Q1Lm3rO0ZanTDY5CyTeAxYw6ND>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 140FC222006F; Thu, 22 Aug 2024 12:40:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Aug 2024 16:39:51 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tomas Winkler" <tomas.winkler@intel.com>,
 "Rohit Agarwal" <rohiagar@chromium.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Lubart, Vitaly" <vitaly.lubart@intel.com>,
 "Alexander Usyskin" <alexander.usyskin@intel.com>
Message-Id: <4a66eea2-c23b-4c34-a5c6-508bf2a6fc47@app.fastmail.com>
In-Reply-To: 
 <PH7PR11MB76050864E8DC9F7389314BF2E58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240813084542.2921300-1-rohiagar@chromium.org>
 <75f758e5-a26f-4f41-8009-288ca2a4d182@app.fastmail.com>
 <4d6f3331-5a9c-46f2-8e27-3484ba6f6eab@chromium.org>
 <25e56199-7af1-4235-8973-cbc351325b8c@app.fastmail.com>
 <PH7PR11MB76050864E8DC9F7389314BF2E58F2@PH7PR11MB7605.namprd11.prod.outlook.com>
Subject: Re: [RFC] Order 4 allocation failures in the MEI client driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 22, 2024, at 13:27, Winkler, Tomas wrote:
>> On Wed, Aug 21, 2024, at 05:20, Rohit Agarwal wrote:
>> > On 19/08/24 6:45 PM, Arnd Bergmann wrote:
>> >> On Tue, Aug 13, 2024, at 10:45, Rohit Agarwal wrote:
>> >>
>> >> What is the call chain you see in the kernel messages? Is it always
>> >> the same?
>> > Yes the call stack is same everytime. This is the call stack
>> >
>> > <4>[ 2019.101352] dump_stack_lvl+0x69/0xa0 <4>[ 2019.101359]
>> > warn_alloc+0x10d/0x180 <4>[ 2019.101363]
>> > __alloc_pages_slowpath+0xe3d/0xe80
>> > <4>[ 2019.101366] __alloc_pages+0x22f/0x2b0 <4>[ 2019.101369]
>> > __kmalloc_large_node+0x9d/0x120 <4>[ 2019.101373] ?
>> > mei_cl_alloc_cb+0x34/0xa0 <4>[ 2019.101377] ?
>> > mei_cl_alloc_cb+0x74/0xa0 <4>[ 2019.101379] __kmalloc+0x86/0x130 <4>[
>> > 2019.101382] mei_cl_alloc_cb+0x74/0xa0 <4>[ 2019.101385]
>> > mei_cl_enqueue_ctrl_wr_cb+0x38/0x90
>> 
>> Ok, so this might be a result of mei_cl_enqueue_ctrl_wr_cb() doing
>> 
>>         /* for RX always allocate at least client's mtu */
>>         if (length)
>>                 length = max_t(size_t, length, mei_cl_mtu(cl));
>> 
>> which was added in 3030dc056459 ("mei: add wrapper for queuing control
>> commands."). All the callers seem to be passing a short "length" of just a few
>> bytes, but this would always extend it to
>> cl->me_cl->props.max_msg_length in mei_cl_mtu().
>> 
>> Not sure where that part is set.
>
> It's allocating maximum header for receiving buffer so it can 
> accommodate any response. 
> Looks like this part can be optimized with pre allocated buffer pool.

I understand that it's always trying to allocate the maximum, the
question is whether there is ever a need to set the maximum to more
than a page. Pre-allocating a buffer at probe time would also
address the issue, but if it's possible to just make that buffer
smaller, it wouldn't be needed.

Is the 64KB buffer size part of the Chrome specific interface as
well, or is that part of the upstream kernel implementation?

       Arnd

