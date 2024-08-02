Return-Path: <linux-kernel+bounces-272506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C460945D48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9BE1C21A06
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EAF1DF689;
	Fri,  2 Aug 2024 11:34:07 +0000 (UTC)
Received: from hkg.router.rivoreo (45.78.32.129.16clouds.com [45.78.32.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A76D14D458;
	Fri,  2 Aug 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.78.32.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598446; cv=none; b=hqoLq8018jBrwe6ZKk4cwKI/bYf5R3dhs0ougs24IoE6F/BnaOnuXdhUZg6pLxqfzYuS5aV+MnX3sx6v8rBnhf8mDZKpuYMeKxt6978nuYMYkAoPbxympLJabYuJxkJ0Sw72Difu3wDqghWlqzX7pj8RWRCjlfj81h+Ua7maumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598446; c=relaxed/simple;
	bh=CSN/nzOenTuEchA+JBM1pilFuDhdl8T4uNTbeBLKTuE=;
	h=Message-ID:In-Reply-To:References:Date:Subject:From:To:Cc:
	 MIME-Version:Content-Type; b=muqnT1mgDnCRyukycFE+OLEJy4s3/7No4zEF9VxHc50Ulf9NYEihEw9qvzL712lpvMKwp6+iC2lfBeCpVuVHFv2/VlLu/r/2jKCjzDpYeWtnzhCiTNwh9jLaCTjinZKZs20TDi6VBtoarAbNmO7+R0xB8NeoJd/SwMWhSxcYwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one; spf=pass smtp.mailfrom=rivoreo.one; arc=none smtp.client-ip=45.78.32.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivoreo.one
Received: from tianjin2.rivoreo.one (unknown [10.100.1.128])
	by hkg.router.rivoreo (Postfix) with ESMTPS id 6C83511CEEF;
	Fri,  2 Aug 2024 11:33:58 +0000 (UTC)
Received: from [10.1.105.1] (localhost [127.0.0.1])
	by tianjin2.rivoreo.one (Postfix) with ESMTP id 0B4A56BE31;
	Fri,  2 Aug 2024 19:32:29 +0800 (CST)
Received: from 10.1.107.31
        (SquirrelMail authenticated user whr)
        by _ with HTTP;
        Fri, 2 Aug 2024 11:32:29 -0000
Message-ID: <649fab0060369a98b9a898e82f518f18.squirrel@_>
In-Reply-To: <CAL_Jsq+Wcag2Lzu_kLRb5ia=3hNUOs1Ny93Y541eOY-NZOA5qw@mail.gmail.com>
References: <2046da39e53a8bbca5166e04dfe56bd5.squirrel@_>
    <CAL_JsqKpTKv-fthwD9bFHiVESJyNP6uMg7Px7Rh+-k583oz76g@mail.gmail.com>
    <1c7955e8b5f0cdb3c60381a9a7dbbf42.squirrel@_>
    <CAL_Jsq+Wcag2Lzu_kLRb5ia=3hNUOs1Ny93Y541eOY-NZOA5qw@mail.gmail.com>
Date: Fri, 2 Aug 2024 11:32:29 -0000
Subject: Re: [PATCH v2] of/irq: Make sure to update out_irq->np to the new
 parent in of_irq_parse_raw
From: "WHR" <whr@rivoreo.one>
To: "Rob Herring" <robh@kernel.org>
Cc: "Saravana Kannan" <saravanak@google.com>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.23 [Rivoreo]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal

> On Wed, Jul 31, 2024 at 10:22 PM WHR <whr@rivoreo.one> wrote:
>>
>> > On Mon, Jul 29, 2024 at 11:54 PM WHR <whr@rivoreo.one> wrote:
>> >>
>> >> Commit 935df1bd40d43c4ee91838c42a20e9af751885cc has removed an
>> >> assignment statement for 'out_irq->np' right after label 'skiplevel',
>> >> causing the new parent acquired from function of_irq_find_parent didn't
>> >> being stored to 'out_irq->np' as it supposed to. Under some conditions
>> >> this can resuit in multiple corruptions and leakages to device nodes.
>> >
>> > Under what conditions? Please provide a specific platform and DT.
>>
>> I have a previous email sent to you before I came up with the fix. The
>> kernel
>> log for debugging and the device tree blob are attached again.
> 
> Thanks. The patch needs to stand on its own with this detail, not
> require that I've read (and remember) some other email among the
> 1000s.
> 
> "multiple corruptions and leakages to device nodes" is meaningless. Be
> exact, it's device_node refcounts we're talking about. The issue is
> out_irq->np is not updated from 'usbdrd' node to the real interrupt
> parent, the 'plic' node. In the next iteration of the loop, we find
> 'interrupt-controller' in the plic node and return, but out_irq is not
> pointing to the plic. Then of_irq_get() fails to get the irq host and
> does a put on out_irq->np which is usbdrd, not plic node.
> 
> So please update the commit msg and provide your name, not initials.

Since the fix for this regression is really trivial, I think you'll be able to
commit it by yourself instead.


>> > Honestly, I think the DT is wrong if you get to this point. We'd have
>> > to have the initial interrupt parent with #interrupt-cells, but not an
>> > interrupt-controller nor interrupt-map property to get here. Maybe
>> > that happens in some ancient platform, but if so, I want to know which
>> > one and what exactly we need to handle.
>>
>> So you suggest the #interrupt-cells is erroneous in that node, and should
>> be
>> removed?
> 
> Yes. dtc warns about this. dtschema would too if there was a schema
> (there is, but not since you use a downstream binding).
> 
> The clint node has the same issue.
> 
>> This is a device vendor-provided DT, so any issue in it will have to be
>> fixed
>> locally.
> 
> Complain to your vendor...

Thanks for help diagnosing the issues.


