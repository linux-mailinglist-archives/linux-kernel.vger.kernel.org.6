Return-Path: <linux-kernel+bounces-232349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8131491A739
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28DA1C2424F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265416DC31;
	Thu, 27 Jun 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KUmBRGdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Id5amWiO"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43725146D6D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493229; cv=none; b=YnGHkTnbnUiEwGVhoHu2S30LvMZYdlsxecoie9tFj17JkbQ4nP2YxfStRqFdPvQ6m9mY9WIYq56kAIyrVvPBwxcFBWJXZHl/cDj+kPO7LPIISDyTdLyd2Oz84O+l2Q+mr4hnOj42QiM9DbAL2/lMdK2JhusKnLrE9fFi3p/6bs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493229; c=relaxed/simple;
	bh=/3fHpBJwbtNxdKc1mqsLo15OIk2ImpsNLSbQ5JurI58=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ISgkyf5O9s5Ce1Q3OvcIfzmHgwWaUicLZwu+VujdRG9233SYQBzD3ZF81N8JhBEN5sSTH4yR++p23kCd0nyWbWTNhtRQ/9GvAOPvsTU6X/A0xTDurnl4p5LAZD9Gp00LaUOi/bJ23Q8PVcIin2RjDFsvnjoRQJh8gfE94tWJ4+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KUmBRGdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Id5amWiO; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 690011140297;
	Thu, 27 Jun 2024 09:00:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 27 Jun 2024 09:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719493225; x=1719579625; bh=SaPRVN9+Aj
	gKYt7eKG84QyPDe0b8SyRoJDobeWJkzD8=; b=KUmBRGdIUf5FWf7rQXCmh7UHb8
	iWaNMubHRVwhjcJ6jdNkq5OXjuKH9rHOsL1aS8A5sttLGDMIsmha3zr58XJY6XTU
	Oyel/FgZYQcddBNZ0/eJk4xbrhL0xiEROWbKANigGKyAzWAVhqpHA4SoETJxXrhM
	n2ea3NKDk2ChSj87houXAh9dQMwk6M0WLY6VwTr0q38ZD9NKd9Y4cxE01SeL+p6w
	fO5MicY21BFRxhMAvUhFWN8N3b0Ji5Tc8VCBau8hQ0Y78vMqZLLEL195NQ5f3j15
	mKpObT/xfDU+NVHR7j9lkQJjSojtbnDftSPXNSfVEyvhiWvvBg5iGtvUxByg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719493225; x=1719579625; bh=SaPRVN9+AjgKYt7eKG84QyPDe0b8
	SyRoJDobeWJkzD8=; b=Id5amWiO2NMu6jmK6d2q/dqQpdqYpWoqufPq03NVdbOU
	BDPRxQbgjmmP5zgJkfcjVRUMtkduBZvJHwzp4mgo7FO0s9OLetP2MrvbwOYhvu4T
	5P/t8G0r/v2513+x7WbHqpsAhVsAOT5B2V5Mp7+fiPy/XXr3SbYHTRlAR1LVH7Wm
	Kj0uLqROh+eNxBLg2NCeTGqtLTMc1Q0lnGFFtmOimxQP+iO5PbGOhR2w0wFlbdv8
	zHdPOdPCUdYwmAavm740u99rAr+xP5ucHMrm0D0XI3346j9JDnDk3pRtJa4LuUvi
	f1fcuI5J+63rAsBXBB1ZFGwv97dZnGceCv6k0LHr5w==
X-ME-Sender: <xms:aGJ9Zi25TQuX60_VBE7ZI4q668YF8j1n1g7q4xgM7B1YYdnO9BAwTQ>
    <xme:aGJ9ZlFi6Kf1mO_nsrFmKhftPv_ARWvxu0Exr8KKCy29XOO4RaqcjkSLOOJFb9s3T
    HnGjgfTGIDi0MG7dAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdeggdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:aGJ9Zq76Uh6G7-1I_v2ml3O4i1ywzI-ybbwYIkJYjQlsl3ZnwG2veQ>
    <xmx:aGJ9Zj182Led8KhFNtMbskBJrcDcSmRwwfKXhQrzJY511MbT-IWHrA>
    <xmx:aGJ9ZlF4S3FNFHWCj29csO2BHcwTFAXrpyEqTViQlT47THKR7MyIBQ>
    <xmx:aGJ9Zs-czbSwgPjVkLhDw3jsFoNphnhWfx3F52xniYsupN-5qzSAaQ>
    <xmx:aWJ9ZtH_QhmLwrWyEW7v4Khlb1B7f_Ewk3Z22-FSv0vu9ygkUTXPitli>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 176F5B6008D; Thu, 27 Jun 2024 09:00:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3732da73-ecad-4415-bfa7-0f9ad6b2a58e@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYtiWKuQzwoBVaBA6zp304uCw5SsHKf3484CY-kuuOgnFA@mail.gmail.com>
References: 
 <CA+G9fYtiWKuQzwoBVaBA6zp304uCw5SsHKf3484CY-kuuOgnFA@mail.gmail.com>
Date: Thu, 27 Jun 2024 15:00:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-mm <linux-mm@kvack.org>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>
Cc: "Jocelyn Falempe" <jfalempe@redhat.com>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>
Subject: Re: powerpc: nvram_64.c:75:13: error: 'oops_to_nvram' used but never defined
 [-Werror]
Content-Type: text/plain

On Thu, Jun 27, 2024, at 14:49, Naresh Kamboju wrote:
> The powerpc builds failed on Linux next-20240626 tag due to following 
> ----
> arch/powerpc/kernel/nvram_64.c:79:17: error: initialization of 'void
> (*)(struct kmsg_dumper *, enum kmsg_dump_reason,  const char *)' from
> incompatible pointer type 'void (*)(struct kmsg_dumper *, enum
> kmsg_dump_reason)' [-Werror=incompatible-pointer-types]
>    79 |         .dump = oops_to_nvram
>       |                 ^~~~~~~~~~~~~
> arch/powerpc/kernel/nvram_64.c:79:17: note: (near initialization for
> 'nvram_kmsg_dumper.dump')
> arch/powerpc/kernel/nvram_64.c:645:13: error: conflicting types for
> 'oops_to_nvram'; have 'void(struct kmsg_dumper *, enum
> kmsg_dump_reason,  const char *)'
>   645 | static void oops_to_nvram(struct kmsg_dumper *dumper,
>       |             ^~~~~~~~~~~~~
> arch/powerpc/kernel/nvram_64.c:75:13: note: previous declaration of
> 'oops_to_nvram' with type 'void(struct kmsg_dumper *, enum
> kmsg_dump_reason)'
>    75 | static void oops_to_nvram(struct kmsg_dumper *dumper,
>       |             ^~~~~~~~~~~~~
> arch/powerpc/kernel/nvram_64.c:75:13: error: 'oops_to_nvram' used but
> never defined [-Werror]
> arch/powerpc/kernel/nvram_64.c:645:13: error: 'oops_to_nvram' defined
> but not used [-Werror=unused-function]
>   645 | static void oops_to_nvram(struct kmsg_dumper *dumper,
>       |             ^~~~~~~~~~~~~
> cc1: all warnings being treated as error

The problem is the forward declaration that was not changed
as part of commit 7e72bb7504d1 ("printk: add a short
description string to kmsg_dump()"). This should fix it:

diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index e385d3164648..a9da83c4243a 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -73,7 +73,8 @@ static const char *nvram_os_partitions[] = {
 };
 
 static void oops_to_nvram(struct kmsg_dumper *dumper,
-			  enum kmsg_dump_reason reason);
+			  enum kmsg_dump_reason reason,
+			  const char *desc);
 
 static struct kmsg_dumper nvram_kmsg_dumper = {
 	.dump = oops_to_nvram


      Arnd

