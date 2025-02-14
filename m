Return-Path: <linux-kernel+bounces-514851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF653A35C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9534F16EBBA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D263263C8D;
	Fri, 14 Feb 2025 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WX9oLO9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UdjLwZQ6"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D5263C88
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532178; cv=none; b=rcdNDCLeWqqPUl24MFfVYnNP960NyqTEIB8smoNb7fWE2CKl53ykItytJ1QXMYzCCRpaUNWZ4Xb/MRRIhZPdn2EoqDNoxANUNMKfd1T9+GGT5q3s37TtEmTHiZYmWf/xVScwEz+VERYrq7BeHflDkdiJ0RGcSkf7lG7NUXy0+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532178; c=relaxed/simple;
	bh=OsjCXXBxfPDSc8sdW5re9j2JZVVhVPF2q8SKbktNvH4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IGjiIxAPMXn6XOaiXyJZQt3EXA1L4+bI60+5PK89wU6VPOTuoiB5HEcpZe5bLK5fCRixU7d0VVXl4gqTBBrzHK3DRBy8BihWqyMV+aLXlpUxI/413TRtnhfKGHQZ63XmFKzRlxYYYvN/kYSJs6C6vMUU+nKkW4eWS+sRkb+c7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WX9oLO9B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UdjLwZQ6; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3903D11400CA;
	Fri, 14 Feb 2025 06:22:54 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Fri, 14 Feb 2025 06:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739532174;
	 x=1739618574; bh=m8U691ACWe3t+/nGQjZe7Q9pb8ejSpFRnvHei6aA9lY=; b=
	WX9oLO9BItsoCWpFjU5ka7WeQxKfRNU2NsbyiJkJ/t27zIxl3Xf6TCdawtxzMfs7
	bDBgkoOdTFyLtPcujFwMMbnyrzSW5bj9qlHBv00tgidSEICTv4xq1zDzbayH4OHg
	EPC3lN4BwEKTdVTdB0/Ptw863YfTwWC2erWR0v6dJ2hABKFvYgYY9CwyWWXDsdAc
	v3nYsqf1157tnx/PGrUBWoVO2ENTh4FxasyM5FJcx45vWLhzAmp6fQOLFpPpT3Rt
	M3jn+QN/MfxyCboAfvCvPK2Cv/1rb6zbvOz+P2PvcVexIY5mKjyNgnOuO+QeX7Hn
	46hr1lgF36iUl6+Aj6y49w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739532174; x=
	1739618574; bh=m8U691ACWe3t+/nGQjZe7Q9pb8ejSpFRnvHei6aA9lY=; b=U
	djLwZQ6ShCtiJAawB7AzPGa+JAra/rOVmVF1ug0j4JK9MGZOIPlT0DCtKW3JbrX+
	8loYUWkhMMmOOANozBadKwINAoWcdilpZ/26ispBuNh47V70n4RmPeydgMyq1VG5
	gftaZwp73s/ZoVXRal0dH8/hSwvnqVJ6wSpA4l0ITf2pBQACRyhWlaQbGBnXAN3z
	J1wOQ3bRjtXKh05j9FMr/mEbU7WDP2w7yIG52QdGAEYimuUvFg9yGCyprrYpVofv
	/V0KokcxY1Nn2XMxvXjVY3TOiHSyJXbATgAmieiMLpfC9CNuDy4JrO/RzpQu0+K6
	6JeopPh1/3LN3k3yOyAgA==
X-ME-Sender: <xms:jSevZ9wWSEalcILpi6zuxb5AR7jP04Es-44OzJDMAA2amXSpJkQS3w>
    <xme:jSevZ9R_AdQDxaEQrMCyuL_AoebJCLir6VVk7dkiIn-XdC0T3G02PyMTEYYgXSuVP
    jfYmabYwJl8AvWL95o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiifhhighhurhgrsegtohguvgifvg
    grvhgvrhhsrdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphht
    thhopehphhhilhhiphdrlhhisehinhhtvghlrdgtohhmpdhrtghpthhtohepohgvqdhksg
    huihhlugdqrghllheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jSevZ3U9TEQisKj2XMLJWwzUCoCFM3Rzlef_feZ-NE0CvjTFTMocFw>
    <xmx:jSevZ_i0bPbUkxLm27Q8EKgPzBTRlY25u0VgtPr6kFflHB7At45BJw>
    <xmx:jSevZ_Chw7fL5vqspY-EohXVhSOpPK2_eKwL5iYC9aVzMomEfZAclg>
    <xmx:jSevZ4Iv8OubEi5AIYMvJnWkinIi-DC8RqaLNvTzcrw5ZcNlsM8FQw>
    <xmx:jievZ69CIeaLTARA2VOWhf3ZHut1nnthAY9870HNbQtS4FKjdw_PgGyc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B198A2220072; Fri, 14 Feb 2025 06:22:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 12:22:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philip Li" <philip.li@intel.com>,
 "Elizabeth Figura" <zfigura@codeweavers.com>
Cc: "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <9791da8a-fb5f-46d0-a86f-66738293d155@app.fastmail.com>
In-Reply-To: <Z68CX3HMEUW00WYi@rli9-mobl>
References: <202502072019.LYoCR9bF-lkp@intel.com>
 <2421077.NG923GbCHz@camazotz> <Z68CX3HMEUW00WYi@rli9-mobl>
Subject: Re: include/linux/thread_info.h:259:25: error: call to '__bad_copy_to'
 declared with attribute error: copy destination size is too small
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Feb 14, 2025, at 09:44, Philip Li wrote:
> On Mon, Feb 10, 2025 at 02:39:46PM -0600, Elizabeth Figura wrote:
>> On Friday, 7 February 2025 06:11:47 CST kernel test robot wrote:
>> >    In file included from include/linux/spinlock.h:60,
>> >                     from include/linux/wait.h:9,
>> >                     from include/linux/wait_bit.h:8,
>> >                     from include/linux/fs.h:6,
>> >                     from drivers/misc/ntsync.c:11:
>> >    In function 'check_copy_size',
>> >        inlined from 'copy_from_user' at include/linux/uaccess.h:207:7,
>> >        inlined from 'setup_wait' at drivers/misc/ntsync.c:888:6:
>> > >> include/linux/thread_info.h:259:25: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
>> >      259 |                         __bad_copy_to();
>> >          |                         ^~~~~~~~~~~~~~~
>> 
>> This was caught before and mentioned in [1]. The suggestion there of changing "args->count" to "count" doesn't help.
>> 
>> Somehow gcc 12 thinks that the array_size(count, sizeof(*fds)) parameter is constant, although it's finnicky and depends on exactly where __builtin_constant_p() is evaluated.
>> 
>> The bug goes away with gcc 13. Is this worth trying to work around? I don't have any ideas for how to do so.
>
> Thanks for the info, at bot side, we will ignore this error to
> avoid further reporting on old gcc.

gcc-12 isn't really "old", we support gcc-5 through gcc-14 at the moment.

Maybe the change below would address it? (Not sure I handled the
"+1" right here, but something like that should make it obvious
to the compiler what the check is).

      Arnd

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 055395cde42b..ae13aae9194b 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -873,6 +873,7 @@ static int setup_wait(struct ntsync_device *dev,
 {
 	int fds[NTSYNC_MAX_WAIT_COUNT + 1];
 	const __u32 count = args->count;
+	size_t size = count * sizeof(fds[0]);
 	struct ntsync_q *q;
 	__u32 total_count;
 	__u32 i, j;
@@ -880,15 +881,14 @@ static int setup_wait(struct ntsync_device *dev,
 	if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
 		return -EINVAL;
 
-	if (args->count > NTSYNC_MAX_WAIT_COUNT)
+	if (size >= sizeof(fds))
 		return -EINVAL;
 
 	total_count = count;
 	if (args->alert)
 		total_count++;
 
-	if (copy_from_user(fds, u64_to_user_ptr(args->objs),
-			   array_size(count, sizeof(*fds))))
+	if (copy_from_user(fds, u64_to_user_ptr(args->objs), size))
 		return -EFAULT;
 	if (args->alert)
 		fds[count] = args->alert;

