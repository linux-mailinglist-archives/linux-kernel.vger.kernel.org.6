Return-Path: <linux-kernel+bounces-230934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6842E9183F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B439BB23284
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B421850A6;
	Wed, 26 Jun 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="JNyAP8IJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+gPqfNZ"
Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AA45C07
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411951; cv=none; b=PyKCILCERVwsWI2XqXoov5L+99QlFCClwe7dR7YrTQj32OYgxYU7hVie44ri950zqYG44e/02pVe1FdlO+9x2m20oAaRlYFFbZmQTQ0CxjgXOgqCVayzS89/Z2FDoC8soZxrL9o+V768/3KffZ5jzjgC2rXdYmz6XxeIdp8AeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411951; c=relaxed/simple;
	bh=oSOXDQj45nSmvfW7XngrB/BJE/MrOtHFWIJ3F1tBBPI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=As2SsELl3pPTTv27pQfO7gMUyNGqozyMReiIaAS6yPQB+FFbUmMO5nog2e6Id/4nq2gs6B2mUJ0SpDQpT8vVRasleHQJEe7dXY0CvC2hMQFnUxy9P1EtdmfMuCUrlgkiQ1Z2JWAdSQJ4FD7A8dFfnlWWhaNXAMgX5HSUsLthwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=JNyAP8IJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+gPqfNZ; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 35FFB18000AC;
	Wed, 26 Jun 2024 10:25:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 26 Jun 2024 10:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1719411947; x=1719498347; bh=oSkUtGm1/7
	apiNd36dGqMrJF/4sWZLpzUDaGM8MrITM=; b=JNyAP8IJXZ0FO/oGWwcE3OTqmX
	yZPnpiRnYvupJBZS6Wtl216dp5wwsBB6J9SOcMcW7IiB3SeoiTCOx7mAyZIgr2x9
	BR0SKBMYW+qXNKyMkkEa8eDMZ2axvuuS2JPbag/+sTv+sPFSTOz4dxTfS9pSUlva
	H3lAvtbffz8ov1sqehFJ7uMKWM+JxkYlTRrHlujUu+vR310YTLJCNAafzI3OJSVr
	tjrnPFsKK926b4xqGpUuULOYJm5vbH9CTglGq5tF2VN869u+z7FLpDQVVg8q7nXC
	8nsO71aUmf/WexGuPgGHj8qsfQKJa3jHMa/AaUek9A/+pCam95H8MoHg7hYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719411947; x=1719498347; bh=oSkUtGm1/7apiNd36dGqMrJF/4sW
	ZLpzUDaGM8MrITM=; b=H+gPqfNZPlU53o+ER9abzC32ux7ZvqXcdyVGWUEjmC55
	BjQ2KqlwYuQY69Ngx7UdwUSnB8KEideGXj9e/obcCaWY9KKfli6/lFBftb/poNfT
	VjsxthaAsyUf+HGgbDtNVzJrK7vmSFBGQQNoHRn2qX+AOpc6Zo2gPXX/ddLC/HfY
	pDfw6p26fTKPKqF7ehXc6ByLp4l5a0F0LYrDtyKthWslrKnSxyYDQf0evqzHEeKQ
	GiQRinZcesSwa1+poGXkWqeqGrgvf71wXfVQXDjsoxs/CDY3hB5fCXIjp+z6B5s5
	MqrQi+2LofW6Y7/NUT0sCdLIwqy33LYqbMb7hkdBcg==
X-ME-Sender: <xms:6iR8Zi3cDU_PmEJfOjSTC8EV56DFKcDAnGPe9yvGEKuqCLLGOpoF-A>
    <xme:6iR8ZlFJKWTLA8hA4Y5YX3Us7x-z-ab56zQqb4qdamhNxyazakElDNa19co-lmBc8
    4j3eOGjzcsXcecijfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6iR8Zq5Vf4mbIbZYcuMH_cvhwTAxH4VJLL4jKfSs-11Sp5VaqdjxlQ>
    <xmx:6iR8Zj07fRdWESlFqSGPJdtW_PtMbOQw3S_MkE5daifip9j8u9-txA>
    <xmx:6iR8ZlHLCkL2_VawczFLvr73wWy1yC_ixQ4CBOTkOm-2B5cg5OQVWQ>
    <xmx:6iR8Zs_z1f6yNflmfzZ_9uP-L0vr-PqRAV8dQFOzAIt22jQzQ_7JHg>
    <xmx:6yR8Zq6mDn6E2JExQpY8g0V-jQHMf2volYODna8PvFr39DnU0KgI4XMC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 79E53B6008F; Wed, 26 Jun 2024 10:25:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-538-g1508afaa2-fm-20240616.001-g1508afaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dcf9574a-0f1b-4131-befd-39f47d4f9002@app.fastmail.com>
In-Reply-To: <ZnwTwnSsnZ8Td9GZ@xhacker>
References: <20240625040500.1788-1-jszhang@kernel.org>
 <20240625040500.1788-3-jszhang@kernel.org> <mvmikxvonjh.fsf@suse.de>
 <ZnwTwnSsnZ8Td9GZ@xhacker>
Date: Wed, 26 Jun 2024 16:25:26 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jisheng Zhang" <jszhang@kernel.org>, "Andreas Schwab" <schwab@suse.de>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] riscv: uaccess: use input constraints for ptr of __put_user
Content-Type: text/plain

On Wed, Jun 26, 2024, at 15:12, Jisheng Zhang wrote:
> On Wed, Jun 26, 2024 at 03:12:50PM +0200, Andreas Schwab wrote:
>> On Jun 25 2024, Jisheng Zhang wrote:
>> 
>> > I believe the output constraints "=m" is not necessary, because
>> > the instruction itself is "write", we don't need the compiler
>> > to "write" for us.
>> 
>> No, this is backwards.  Being an output operand means that the *asm* is
>> writing to it, and the compiler can read the value from there afterwards
>> (and the previous value is dead before the asm).
>
> Hi Andreas,
>
> I compared tens of __put_user() caller's generated code between orig
> version and patched version, they are the same. Sure maybe this is
> not enough. 
>
> But your explanation can be applied to x86 and arm64 __put_user()
> implementations, asm is also writing, then why there's no output
> constraints there?(see the other two emails)? Could you please help
> me to understand the tricky points?

I think part of the reason for the specific way the x86
user access is written is to work around bugs in old
compiler versions, as well as to take advantage of the
complex addressing modes in x86 assembler, see this bit
that dates back to the earliest version of the x86_64
codebase and is still left in place:

/* FIXME: this hack is definitely wrong -AK */
struct __large_struct { unsigned long buf[100]; };
#define __m(x) (*(struct __large_struct __user *)(x))

Using the memory input constraint means that x86 can use
a load from a pointer plus offset, but riscv doesn't
actually do this. The __large_struct I think was needed
either to prevent the compiler from reading the data
outside of the assembly, or to tell the compiler about
the fact that there is an actual memory access if
__put_user() was pointed at kernel memory.

If you just copy from the arm64 version that uses an
"r"(address) constraint instead of the "m"(*address)
version, it should be fine for any user space access.

The output constraint is technically still be needed
if we have code like this one where we actually write to
something in kernel space:

int f(void)
{
     int a = 1;
     int b = 2;
     __put_kernel_nofault(&a, &b, int, error);
     return a;
error:
     return -EFAULT;
}

In this case, __put_kernel_nofault() writes the value
of b into a, but the compiler can safely assume that
a is not changed by the assembly because there is no
memory output, and would likely just return a constant '1'. 

For put_user(), this cannot happen because the compiler
doesn't know anything about the contents of the __user
pointer. For __put_kernel_nofault(), we rely on the
callers never using it on pointers they access, which
is probably a reasonable assumption, but not entirely
correct.

     Arnd

