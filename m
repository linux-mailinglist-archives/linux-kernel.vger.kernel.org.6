Return-Path: <linux-kernel+bounces-383832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6689B20A9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FED1C208ED
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBB17F394;
	Sun, 27 Oct 2024 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WGNQlg/S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9+AQM1qQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WGNQlg/S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9+AQM1qQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024591DFE8
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730063155; cv=none; b=Q18X1T6scnRISHct48rTy8GdU4Ee4433M5AiO/tc0zBWr7K9hqz4uyoCPLc6mQaZBljaWmN/CEI6YTwWzLimjr+ENjexVfkLCAbVD8ZjpEtA2lgjlUUNdAcyhscCQzmIcAADpozXjNAyE0WEpVDGAbr22g0Bi9gfc7X9KlQ19xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730063155; c=relaxed/simple;
	bh=Fnp/Cdc4ToetrB2E8b9bG+qdgwjx/g3QMuwv1KR6nUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qA204QzQVgHwnPaiqFbQSVE47tGV0/12gcR/YLPDNvx/VOoclqx5ozgDh6lJKoeiauJTI13jGJcuj5wG2miOYYVOjDKQ6/Fk8aFXQYkxJqbxK8SgckGrpFGr10XvL8ZmMZNUBTNK2HBo+Qc/1tSjSrK+0CwYkMgKbdROwBKr63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WGNQlg/S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9+AQM1qQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WGNQlg/S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9+AQM1qQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D43421A4E;
	Sun, 27 Oct 2024 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730063151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JJewF0+M7DZ1KsQ9HNlZe4k9AkbzHxEr9f0YzDD14+U=;
	b=WGNQlg/SWzv5QibzDlND5uKg23OAxa3jMyuCIxUhEtFCDSWyi5QtAtJdxji/F6mWNC05Hx
	ccLpg0paFybRySAuRzKTaq0dpInUlrRFlNySIgQo2Z8h6hzspwCCG83H9zOYBLcBhIo192
	u1aq5Wzwov+DtVC1LF72Svq23PjO6yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730063151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JJewF0+M7DZ1KsQ9HNlZe4k9AkbzHxEr9f0YzDD14+U=;
	b=9+AQM1qQnkWHvZ8syEMfdVXqgyB+Vcm/s7V35BB0iZp6dzn6YFYyAlgCXOgdzWNb2pRq/P
	5ZS07stqQjYi40BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730063151; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JJewF0+M7DZ1KsQ9HNlZe4k9AkbzHxEr9f0YzDD14+U=;
	b=WGNQlg/SWzv5QibzDlND5uKg23OAxa3jMyuCIxUhEtFCDSWyi5QtAtJdxji/F6mWNC05Hx
	ccLpg0paFybRySAuRzKTaq0dpInUlrRFlNySIgQo2Z8h6hzspwCCG83H9zOYBLcBhIo192
	u1aq5Wzwov+DtVC1LF72Svq23PjO6yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730063151;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JJewF0+M7DZ1KsQ9HNlZe4k9AkbzHxEr9f0YzDD14+U=;
	b=9+AQM1qQnkWHvZ8syEMfdVXqgyB+Vcm/s7V35BB0iZp6dzn6YFYyAlgCXOgdzWNb2pRq/P
	5ZS07stqQjYi40BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E56AD137D4;
	Sun, 27 Oct 2024 21:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7OZcNy6rHmdfdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sun, 27 Oct 2024 21:05:50 +0000
Message-ID: <6ac7a38f-30df-4403-8723-a43829bcdba5@suse.cz>
Date: Sun, 27 Oct 2024 22:05:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free
 highatomic
Content-Language: en-US
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Matt Fleming <mfleming@cloudflare.com>, David Rientjes
 <rientjes@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Link Lin <linkl@google.com>
References: <20241026033625.2237102-1-yuzhao@google.com>
 <37a28ef7-e477-40b0-a8e4-3d74b747e323@suse.cz>
 <CAOUHufaS-dGAPGs1Y1=imW_nusaTDeysN3qfJc9-76DBVEHScQ@mail.gmail.com>
 <8459b884-5877-41bd-a882-546e046b9dad@suse.cz>
 <CAOUHufbHVXNZpW1mVhuF+4p8PbPq44w4chQX7Q6QYVDCjSqa1Q@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAOUHufbHVXNZpW1mVhuF+4p8PbPq44w4chQX7Q6QYVDCjSqa1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/27/24 21:51, Yu Zhao wrote:
> On Sun, Oct 27, 2024 at 2:36 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 10/27/24 21:17, Yu Zhao wrote:
>> > On Sun, Oct 27, 2024 at 1:53 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>> >>
>>
>> For example:
>>
>> - a page is on pcplist in MIGRATE_MOVABLE list
>> - we reserve its pageblock as highatomic, which does nothing to the page on
>> the pcplist
>> - page above is flushed from pcplist to zone freelist, but it remembers it
>> was MIGRATE_MOVABLE, merges with another buddy/buddies from the
>> now-highatomic list, the resulting order-X page ends up on the movable
>> freelist despite being in highatomic pageblock. The counter of free
>> highatomic is now wrong wrt the freelist reality
> 
> This is the part I don't follow: how is it wrong w.r.t. the freelist
> reality? The new nr_free_highatomic should reflect how many pages are
> exactly on free_list[MIGRATE_HIGHATOMIC], because it's updated
> accordingly.

You'd have to try implementing your change in the kernel without that
migratetype hygiene series, and see how it would either not work, or you'd
end up implementing the series as part of that.

> (My current understanding is that, in this case, the reservation
> itself is messed up, i.e., under-reserved.)
> 
>> The series has addressed various scenarios like that, where page can end up
>> on the wrong freelist.


