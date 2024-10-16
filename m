Return-Path: <linux-kernel+bounces-368289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A469A0DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629011C23376
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9F720E01E;
	Wed, 16 Oct 2024 15:12:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC530208203
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091542; cv=none; b=q5hmcWKVn7Be2WXR2NuDJiEOUcREdjEFcI9Rc9huIZjdTp8Ty0e9gkUy64ibZZUAxQVRMnaFAOAPk0JdvZxLVdR4ICdGVDbjsOfmxUx9tLyTZa7Y5EssNVlwwsqW2pPcupqjbrqMAO29N31HYzopHGr7YVZjbvNjK/ElXyGkerU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091542; c=relaxed/simple;
	bh=HjN+YkwG7eNPrAyPkYFNYF8jodJll+ks7A7aWCoXkEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipyfLBHX85ffT03AO7+IbLltQUli6dhqWCkgx8WZAzcnO2duQuNfthgm6fCEm0n5rzooGWkQnGy1mC87j2baOvHT63RrSwoRNBoNCxFfpLil7eZhVw3jxRXrnJcBbX4MeDf8p9ta8wu7R+zqiCOVHvQIXJ4lbTRSKijLeosEyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB932497;
	Wed, 16 Oct 2024 08:12:49 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 456253F528;
	Wed, 16 Oct 2024 08:12:17 -0700 (PDT)
Message-ID: <11fc5066-81ad-49ca-9037-1d711b9413fe@arm.com>
Date: Wed, 16 Oct 2024 16:12:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 30/57] drivers/base: Remove PAGE_SIZE compile-time
 constant assumption
Content-Language: en-GB
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-30-ryan.roberts@arm.com>
 <43395dc5-51e1-417b-8a0a-7b8482a24411@arm.com>
 <2024101626-reattach-spiny-98dd@gregkh>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2024101626-reattach-spiny-98dd@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 16:04, Greg Kroah-Hartman wrote:
> On Wed, Oct 16, 2024 at 03:45:48PM +0100, Ryan Roberts wrote:
>> + Greg Kroah-Hartman
>>
>> This was a rather tricky series to get the recipients correct for and my script
>> did not realize that "supporter" was a pseudonym for "maintainer" so you were
>> missed off the original post. Appologies!
> 
> "supporter" is actually a much stronger "signal" than "maintainer"
> according to the MAINTAINERS file:
> 		Supported:   Someone is actually paid to look after this.
> 		Maintained:  Someone actually looks after it.

Yes, consider me educated now. For some reason my brain always thought
"supporter" was someone who was active in the subsystem but without an official
affiliation.

> 
>> More context in cover letter:
>> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
> Ick, good luck!
> 
> greg k-h


