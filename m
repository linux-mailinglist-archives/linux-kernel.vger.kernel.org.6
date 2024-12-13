Return-Path: <linux-kernel+bounces-444467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7989F0754
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8333188BCCB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468E51AF0C4;
	Fri, 13 Dec 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="asYqJMPw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqFsNdku";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="asYqJMPw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqFsNdku"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4318E377
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081044; cv=none; b=V4uRMDjBSLqM5yNee9Hl9oVSdV27E5QNDScd62sKpoz2xJF3LSDNZAivLEFHR+R4sBI05OHiVEtl6cHcZPTRX3iwSzrbb4Zru5sKTZduUR7EppZngsXA9WVcTKYxho4PZ11W6w/jOT8Jq2924JMIwq7iC1tH6bG6ITgcFKhyjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081044; c=relaxed/simple;
	bh=/TpiBDIS0qFQs+ZwsVhLQhV5G2FTGDev/hiWKRIwQSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj4jTyzqB7EEDZVqqKQt4jFIL6wdaHiFLa8VfoZ+NCCRdS2IKQ15OufHJENEz7UsN8tPXqE8/TN+42CLhq6VreXH86NPfPD5Uo8v9Hgagmv6NrS2jAYKpYyAuQgZFv5zK6JZJGHKIp3Rba+dCrPNRSAEEKNAP3ZEv3viBbEwOXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=asYqJMPw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqFsNdku; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=asYqJMPw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqFsNdku; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 874C41F392;
	Fri, 13 Dec 2024 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734081040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a0N+E23N1RjpsczoKbwt1F7AIsadbPz0wOZWoGx8zCM=;
	b=asYqJMPwjcJlUpn3wnJ7L1yRYHY5Rm6m67p/xBfIWhdlDq90Np13zLWIHQ4RtkFsC6qt9M
	gUDTocJ2uQ5nEvoGhoANwPnSbIgKjbQMPtknvGRwhS0gjwdH7vknlc1mLZ6dCoB79QzeJ0
	i0fu+sOFrYKlDPPBomQiTHksQWplEAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734081040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a0N+E23N1RjpsczoKbwt1F7AIsadbPz0wOZWoGx8zCM=;
	b=DqFsNdkubG0uLUjkSYoMdhId89UzPKzRKWrRMXf07fsvezvLBWezNnIU7RFIo+7+U+tUSX
	RuxHx6L08vUONfBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734081040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a0N+E23N1RjpsczoKbwt1F7AIsadbPz0wOZWoGx8zCM=;
	b=asYqJMPwjcJlUpn3wnJ7L1yRYHY5Rm6m67p/xBfIWhdlDq90Np13zLWIHQ4RtkFsC6qt9M
	gUDTocJ2uQ5nEvoGhoANwPnSbIgKjbQMPtknvGRwhS0gjwdH7vknlc1mLZ6dCoB79QzeJ0
	i0fu+sOFrYKlDPPBomQiTHksQWplEAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734081040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a0N+E23N1RjpsczoKbwt1F7AIsadbPz0wOZWoGx8zCM=;
	b=DqFsNdkubG0uLUjkSYoMdhId89UzPKzRKWrRMXf07fsvezvLBWezNnIU7RFIo+7+U+tUSX
	RuxHx6L08vUONfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 705BF13927;
	Fri, 13 Dec 2024 09:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EmQYGxD6W2dbLgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 13 Dec 2024 09:10:40 +0000
Message-ID: <b538fe66-21f5-47ac-8469-5eb2bed3362b@suse.cz>
Date: Fri, 13 Dec 2024 10:10:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
 <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
 <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local>
 <CAOUHufYCF0i_aJZPceMXfcTZUcZsCY9fBuMr=25q1bROWx5nsg@mail.gmail.com>
 <e3a61eb1-2224-4700-8df2-28a93e2aa1a6@suse.cz>
 <CAOUHufYSQFNS16YBe1W=ZpxzT0r5yKLj-56az+fpioGf2BqWsA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAOUHufYSQFNS16YBe1W=ZpxzT0r5yKLj-56az+fpioGf2BqWsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainers.pl:url,oracle.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 12/13/24 10:00, Yu Zhao wrote:
> On Fri, Dec 13, 2024 at 1:25 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 12/13/24 06:50, Yu Zhao wrote:
>> > On Wed, Dec 11, 2024 at 11:57 AM Lorenzo Stoakes
>> > <lorenzo.stoakes@oracle.com> wrote:
>> >>
>> >> > I'd like to be added as a reviewer on mm/mseal.c.  Is there any way to
>> >> > indicate this from this file ?
>>
>> I don't think the format and tooling supports adding a reviewer for a single
>> file out of a subsystem. mm/mseal.c would have to be an own subsystem, or
>> Jeff would be indicated as a reviewer for whole memory mapping.
>>
>> >> This is something we can consider in the future, sure.
>> >
>> > What'd be the downsides of having an additional reviewer?
>>
>> General answer to general question: being R: means 1. getting email for
>> patches touching the files (if people use tooling properly, sigh). This can
>> be also achieved on the receiver wised by e.g. the lei tool.
>> 2. being perceived as an authority for people sending patches, some of them
>> not being familiar with the subsystem and the people working on it.
> 
> I think you are saying 1 & 2 above (the meaning of being R) can lead
> to the following?
> 
>> This is
>> why it could be counter productive to be given out to just anyone who asks.
> 
> I understand the words, but I still don't see the logical connection.

I said "General answer to general question". You don't see a problem with
giving R: to anyone who asks, given they're now perceived as an authority by
people not very familiar with a subsystem, sending a patch and getting the
info from MAINTAINERS?

> Also, Jeff is not "anyone", and I'm not sure why he can't be
> "perceived as an authority" on mseal.

I didn't want to say anything about Jeff specifically as I haven't
interacted with him myself much. I know he did mseal but explained how
adding him R: here would not make him reviewer only for mseal.

> Anyway, I would encourage more technical contributions rather than
> "administrative" barriers.

Maybe a technical contribution to get_maintainers.pl to make it possible for
R: for a specific file? :)

