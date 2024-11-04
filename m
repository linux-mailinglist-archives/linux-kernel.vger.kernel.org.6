Return-Path: <linux-kernel+bounces-394875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2899BB532
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911F31C21954
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F0B1B81DC;
	Mon,  4 Nov 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="lGAyvPRP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+HAnSzw"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C75F1B6D12
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725092; cv=none; b=VxM1C4cTPo5fGVdD9sj4KvEJXDRo1MFCdgI6WkaXOL2gLXhMmDgCjs56zsQZBITHYEWLwjrO8ksubwBgtFup/SarE4rwyVFMdoPZy7YGGjr785NfCuvYRuC4gFvQ4VHL7MUIdX/wJ/eeplsDXawosY8C532oHweCzj4fkQmcUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725092; c=relaxed/simple;
	bh=C2xRbI9V5MYjIz5A1aAq/gGsd1LQ3A7YRt5msHdu3Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVA0btZyOlXbgxZGzsEipe358ik5lTqLMgGo8YVD8hbiPufsuqmvs9dsOmTuDSLf0mtJD0AL//eqz8m9W/pojPYg2q/M+xnwhg42TdyThHdHCLnZWi/YHMJAijEd0NqFvA89buLUSK3myhVqj/lprpPzuObpl8aaI0GfaCQS0Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=lGAyvPRP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+HAnSzw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1CC6B114005B;
	Mon,  4 Nov 2024 07:58:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 04 Nov 2024 07:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730725089; x=
	1730811489; bh=flUlqnY+cqQPccGICvx+n07RoS4HpYpLSSI0Fr9s0BE=; b=l
	GAyvPRP674npP7skf4FYdAOxDdPcWsfm2YxNdHnw0Ikn3KtpRaNcrp8OPDtoVT7C
	I7z5aw+4C/Rl3ahGATrG1EiDSGjGbcORsEStVH2zLMzn2XMnV52sQ5rwDwXdjGjJ
	pkXn/1BaNiP4Cii4wiAhPAGCw/odXKVCzfla4BVFH9rPV+S5f34jKt8jYKi+Wajx
	9awXYpB/YiYw0HGDlW3iquA01+TLyG8sFmkx8z71H9E+zRYctvYH2f01X16neh+v
	k9/hUeGUS5jq+eFxnR6shM5MO9ve3O4G2F0tu6jHXKcHisBCK2ewlQkVQ4otKJ7m
	YvE8hhnaT7i/6R4mP8XCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730725089; x=1730811489; bh=flUlqnY+cqQPccGICvx+n07RoS4HpYpLSSI
	0Fr9s0BE=; b=Z+HAnSzwE89uHYCqI5eAM/jN6Y2OVlW+h+p/sH/noLh0ODsrYfc
	gvk5f4rpyLCZcyobBIBa8cRNnbe+edv0KKXWeD7TB28I6fKtQ80VQz8VyCJpeqJV
	rUNUfgZ/1/P7Cu55Z7fXapXufb9b7DjWhkZJ45yPXx9kFVJFnihokzqnysT76KPN
	Ub5I63O6qoLIhINwfPqnfuNZdG36yOJ5ST9fJB0uJt5HHIA13xYmZlngpGjkgbuM
	0aV6SEb9zFpif57YeGBgwx0zk4H2jzEJ+MgtF3o8fFBRXjHbIY0AJC9Uqct8eDGM
	VPpt4iT9WvK4VB4Q17PpYDb1pHi4iRuCodg==
X-ME-Sender: <xms:4MQoZ-DCu7NA2Kd1HKPxhQ23zmm08TE4grzBDdQrQ2Tuyjx45-_sQA>
    <xme:4MQoZ4hVfWYReIa_rH0vKLf4qjLHBTbv0bZSHvD7dsSDvqTQJnbmA_TS26uB1jLiH
    i5ZgfxaP4aEU_PVSBA>
X-ME-Received: <xmr:4MQoZxnz9f4Lfp-UYLmBIApF4RIze3ieTjuSjpmh30ZTeWqgoCte3Cn7rmGK7OD21RSNxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpedfmfhirhhilhhlucetrdcuufhh
    uhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepveeifeekheelhfduffekueegtdeuhffgkeegteeihfeltdevgedvveeg
    fefhheehnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhi
    lhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehshiiisghothdolhhishhtkeeirggtiegtkeefgegs
    rgelvddtvgeljeejrgelsehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    epshihiihkrghllhgvrhdqsghughhssehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:4MQoZ8xjEJXBqjr8d83Qy25mY_2Mgba5sM1M7arLzfdJv9BUznNUcQ>
    <xmx:4MQoZzSK91UaIjO3rUg3Mo6wRtftK3SqUwfVoaboGumoxJudL9L6JA>
    <xmx:4MQoZ3YsZwF-qAYJKro6giLKgGgW6YgW1Hiltwf6zvLTtE8QD67B6g>
    <xmx:4MQoZ8SDRQ5aEiJCQecqGT-ahFVUMX0ji_orqn3mwhssiZJ7J-PHmw>
    <xmx:4cQoZxNHEiA8bG-POs_np-1EscNTmewByD3rzoC-JnEq8HorkBPioBNo>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 07:58:06 -0500 (EST)
Date: Mon, 4 Nov 2024 14:58:01 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: syzbot <syzbot+list86ac6c834ba920e977a9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly mm report (Nov 2024)
Message-ID: <nkwl63smriaeqf4vdappijzlhbs7t6c46eyxt3vh7a63h6rtn2@pwjdhhwi6cua>
References: <6728b185.050a0220.35b515.01bd.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6728b185.050a0220.35b515.01bd.GAE@google.com>

On Mon, Nov 04, 2024 at 03:35:33AM -0800, syzbot wrote:
> <3>  6624    Yes   possible deadlock in lock_mm_and_find_vma (2)
>                    https://syzkaller.appspot.com/bug?extid=b02bbe0ff80a09a08c1b

This one is fixed by 58a039e679fe ("mm: split critical region in
remap_file_pages() and invoke LSMs in between")

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

