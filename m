Return-Path: <linux-kernel+bounces-254976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B02B933A10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC6D1C2235C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A79E3EA76;
	Wed, 17 Jul 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILc395s5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MEQTAbmh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kA3U3Ha7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VGxLpaQM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3F03BBFB
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209039; cv=none; b=d5dkWMDEG/BN51m0zCFKoHeuPj6RMC92cHifWxvwCX9gMNqEO4w3AbmA1hhmU6aysP64tN8P9aRBdihM07xiNMdJMx/MYVH00KBuwyuPQ3hImTfQzZtZgIbMYBuP5z1yTnF/EYOM0aD2o0wChkUip84Gk14UPYBA6go9cwXhkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209039; c=relaxed/simple;
	bh=mPMZl6Sm1aQPuoY2PFl/T4vB/wW4BrT3LDGJkA0lsg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGcXTCpIz4W2ed5vzaBtKNmjwsYy7B4EXV+S9CLaYX7cGx4mEc3UFJ7OTMcrLsUnCs4VqyYIFFrAAkygbtxDincunuTT0NitishUBC72RjgFjaRlHTjOg4azIQWOOgfEfnnqvRTGQDJm2ofoKA7GO9+avL3Y/uMSu9I1LDJNuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILc395s5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MEQTAbmh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kA3U3Ha7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VGxLpaQM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC3FF21ADD;
	Wed, 17 Jul 2024 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721209036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JgWj8ViNYYuyMRUyya/t2CjUKg6wXDGQd1uHrbOCFbU=;
	b=ILc395s56vCVP7jPzCf8CXlDIUNR+Lfs2N07qI9qpr4+z8JVH6Mn/BmYJMGUlbwz+ZLhOJ
	NvbX+hUOdpBAJs89EoxQsqWSeGHKf9I9oBtpwWsAljJc9wui1zm/M3rtQ8yYmbei5Z+/o0
	UucWTcloaNrC+Nggs/8RVwLDTKmqKiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721209036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JgWj8ViNYYuyMRUyya/t2CjUKg6wXDGQd1uHrbOCFbU=;
	b=MEQTAbmhkyGlkbjs+ixEPXkP2Jpibk6Wm2No/c3zMBsh5bwG7GHxhNkBeOfW+yb0D9dzLc
	s9RqTwfmLiM1yXAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721209035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JgWj8ViNYYuyMRUyya/t2CjUKg6wXDGQd1uHrbOCFbU=;
	b=kA3U3Ha7f7cxkFffLpzBZVgRkY/3vpXCurF6w0v0qQgE3Lmc12praOqtyUkh+p1OUt210J
	tuis+iI/Lzk9etpoFvU545OIwQTdoWi/1RIRrtlyrJ2h1z7LNI+QGSpaxAj6/jj2Qnxj3g
	f+MJ5S9it3Hl/yBP2je2Bywryf8RrM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721209035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JgWj8ViNYYuyMRUyya/t2CjUKg6wXDGQd1uHrbOCFbU=;
	b=VGxLpaQMoggkqRYziOwCdb+V3xVT56c972rz92jGg6xFuUtH/RDN2MD99JtYaajztrjDa0
	NKU7kRhEVQKfEZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0964136E5;
	Wed, 17 Jul 2024 09:37:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RjadLsuQl2ZqKQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Jul 2024 09:37:15 +0000
Message-ID: <5fe190eb-ae8a-4e24-989e-3b967b57aea9@suse.cz>
Date: Wed, 17 Jul 2024 11:37:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
Content-Language: en-US
To: Bharata B Rao <bharata@amd.com>, Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, willy@infradead.org,
 kinseyho@google.com, Mel Gorman <mgorman@suse.de>,
 Petr Tesarik <ptesarik@suse.cz>
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
 <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
 <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 7/9/24 6:30 AM, Bharata B Rao wrote:
> On 08-Jul-24 9:47 PM, Yu Zhao wrote:
>> On Mon, Jul 8, 2024 at 8:34 AM Bharata B Rao <bharata@amd.com> wrote:
>>>
>>> Hi Yu Zhao,
>>>
>>> Thanks for your patches. See below...
>>>
>>> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
>>>> Hi Bharata,
>>>>
>>>> On Wed, Jul 3, 2024 at 9:11 AM Bharata B Rao <bharata@amd.com> wrote:
>>>>>
>>> <snip>
>>>>>
>>>>> Some experiments tried
>>>>> ======================
>>>>> 1) When MGLRU was enabled many soft lockups were observed, no hard
>>>>> lockups were seen for 48 hours run. Below is once such soft lockup.
>>>>
>>>> This is not really an MGLRU issue -- can you please try one of the
>>>> attached patches? It (truncate.patch) should help with or without
>>>> MGLRU.
>>>
>>> With truncate.patch and default LRU scheme, a few hard lockups are seen.
>> 
>> Thanks.
>> 
>> In your original report, you said:
>> 
>>    Most of the times the two contended locks are lruvec and
>>    inode->i_lock spinlocks.
>>    ...
>>    Often times, the perf output at the time of the problem shows
>>    heavy contention on lruvec spin lock. Similar contention is
>>    also observed with inode i_lock (in clear_shadow_entry path)
>> 
>> Based on this new report, does it mean the i_lock is not as contended,
>> for the same path (truncation) you tested? If so, I'll post
>> truncate.patch and add reported-by and tested-by you, unless you have
>> objections.
> 
> truncate.patch has been tested on two systems with default LRU scheme 
> and the lockup due to inode->i_lock hasn't been seen yet after 24 hours run.
> 
>> 
>> The two paths below were contended on the LRU lock, but they already
>> batch their operations. So I don't know what else we can do surgically
>> to improve them.
> 
> What has been seen with this workload is that the lruvec spinlock is 
> held for a long time from shrink_[active/inactive]_list path. In this 
> path, there is a case in isolate_lru_folios() where scanning of LRU 
> lists can become unbounded. To isolate a page from ZONE_DMA, sometimes 
> scanning/skipping of more than 150 million folios were seen. There is 

It seems weird to me to see anything that would require ZONE_DMA allocation
on a modern system. Do you know where it comes from?

> already a comment in there which explains why nr_skipped shouldn't be 
> counted, but is there any possibility of re-looking at this condition?
> 
> Regards,
> Bharata.
> 


