Return-Path: <linux-kernel+bounces-255647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4277393432B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52871F221CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4331849CF;
	Wed, 17 Jul 2024 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gL4Q/VUN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7pv+nM1h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gL4Q/VUN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7pv+nM1h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0EA33997
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247564; cv=none; b=aNyOS8vAkEZB3gUpFBnPVpxzqhWmbWzApQa8HxzaJk9Q2WlkFEUYgQUAQxVcWWtpKDgZuL6E9/78l/jVQ1qW9y1TyAE5KD8UaKSMc7sEb52kW3Il5IoqOSIQ2LSv+jQMeu6r9icwt+gkE5ccgD43J8iFsNGTj3OFKXoQo37Y0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247564; c=relaxed/simple;
	bh=QWURONe6NwYDxG9hfkydVxDmCEP7LUeAds4LsE0lTM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcHKb1SfDqSYZBOqSZcQ0ur+zquY0SxIMMpX1Mhhr5Pohi0IRMD2N2tqWW1YUCvVNkUK8bPPmGKjfPACIZPqYqgJLR2jo+/UmeLr1fiYVxyG7P7fEsVWRMf8oBTH2kpZOxaZtoF/VTLaFjrytNxT6sX5NH5YSWdkbDBcCmXEKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gL4Q/VUN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7pv+nM1h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gL4Q/VUN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7pv+nM1h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A3FE21C15;
	Wed, 17 Jul 2024 20:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721247560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uG/TL70DOuV6k27FNkLApQMyQ9L09UTancsGn8vY74s=;
	b=gL4Q/VUNYNh1EBuTiLZ0+AAirTIo3rHrGjhvRKLWmWzr7vGoReijn1GQ90BF9SATybVnKI
	IsuD87kCl8kkw3GRVwz3QNjcvAL+BkE3sDKtoX+PYnDPSIecX4zwjZb7GLRakNuc7lLNft
	Rbh3GBstHspwp1FD/AAmaXJV+Es91Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721247560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uG/TL70DOuV6k27FNkLApQMyQ9L09UTancsGn8vY74s=;
	b=7pv+nM1hqpu1fKKFN6C0dfivqP+CxQwVwJLFWjVML3Y54UN3jeZA8EMZa6/RDo1DpJvKAS
	iuOr+zX5YG2MVGDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="gL4Q/VUN";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7pv+nM1h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721247560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uG/TL70DOuV6k27FNkLApQMyQ9L09UTancsGn8vY74s=;
	b=gL4Q/VUNYNh1EBuTiLZ0+AAirTIo3rHrGjhvRKLWmWzr7vGoReijn1GQ90BF9SATybVnKI
	IsuD87kCl8kkw3GRVwz3QNjcvAL+BkE3sDKtoX+PYnDPSIecX4zwjZb7GLRakNuc7lLNft
	Rbh3GBstHspwp1FD/AAmaXJV+Es91Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721247560;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uG/TL70DOuV6k27FNkLApQMyQ9L09UTancsGn8vY74s=;
	b=7pv+nM1hqpu1fKKFN6C0dfivqP+CxQwVwJLFWjVML3Y54UN3jeZA8EMZa6/RDo1DpJvKAS
	iuOr+zX5YG2MVGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 120CF1368F;
	Wed, 17 Jul 2024 20:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3xb8A0gnmGa9ZwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Jul 2024 20:19:20 +0000
Message-ID: <10865b0a-175e-4b90-9042-7b63b1ea19f8@suse.cz>
Date: Wed, 17 Jul 2024 22:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] alloc_tag: outline and export free_reserved_page()
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, hch@infradead.org,
 pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel test robot <lkp@intel.com>
References: <20240717181239.2510054-1-surenb@google.com>
 <20240717181239.2510054-2-surenb@google.com>
 <16286915-1350-4e6b-a0f6-deec02b7fa92@suse.cz>
 <CAJuCfpG2uNicytRYhfqAKrfkxJoNLUUK_o066D=yKggsoc3wKQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJuCfpG2uNicytRYhfqAKrfkxJoNLUUK_o066D=yKggsoc3wKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A3FE21C15
X-Spam-Flag: NO
X-Spam-Score: -0.50
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.50 / 50.00];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,intel.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

On 7/17/24 10:04 PM, Suren Baghdasaryan wrote:
> On Wed, Jul 17, 2024 at 12:36 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 7/17/24 8:12 PM, Suren Baghdasaryan wrote:
>> > Outline and export free_reserved_page() because modules use it and it
>> > in turn uses page_ext_{get|put} which should not be exported. The same
>> > result could be obtained by outlining {get|put}_page_tag_ref() but that
>> > would have higher performance impact as these functions are used in
>> > more performance critical paths.
>> >
>> > Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
>> > Reported-by: kernel test robot <lkp@intel.com>
>> > Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
>> > Suggested-by: Christoph Hellwig <hch@infradead.org>
>> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> Are these two patches now stable@ material as 6.10 build is broken on ppc64
>> with alloc taging enabled?
> 
> I tested them with that specific configuration mentioned in the bug
> report and with several usual ones I use.
> Yeah, I guess from now on all such fixes should have
> 
> Cc: stable@vger.kernel.org # v6.10

Right. BTW I have just realized that the way you did Patch 2/2 and outlined
the whole free_reserved_page() (which is fair, it's an init-time function),
mem_alloc_profiling_enabled() didn't stay inlined so Patch 1/2 is in fact
not necessary anymore?




