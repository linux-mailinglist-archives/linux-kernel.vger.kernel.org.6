Return-Path: <linux-kernel+bounces-367749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A39A0637
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D961C24361
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64ED206067;
	Wed, 16 Oct 2024 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07JWmaFY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hbC/esjY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07JWmaFY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hbC/esjY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460D206056
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729072612; cv=none; b=LyMRK4a84c9/nWfqtFNVTB7+H0Q5yYp2XpDnVmhwx2U0gW/kWe5FCzsaVGHqqaPb8KssUKM2xOlpgUMWIUlNbH9GXqHINAJkSbzxWD8ote6kPpDNnpRvKOEu9h000SZSYQIYlKfcumfChFiXaW8HtLd6jbcLaR5EOtOJu9Md8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729072612; c=relaxed/simple;
	bh=GnXuKwAVq0DHYxhr0k+biRvbF0FlOGXYumdi1AkGPG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tjsGsYH+hOB38Oxy99ltJsFo/ZE5V5swQQDOhTdXpWAgow8rYIIKIlVFQN3bZcod2L7kvw6yrGUIUsUP5FdlV+zwclLcL7wKmMJOq2aFDzKiCj39SLoe0dlAmTMVuu8kfgBAaE/uDWBNry/4aHyD2RX1YOKyJJNUCQx+FD8evsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07JWmaFY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hbC/esjY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07JWmaFY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hbC/esjY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5672521E83;
	Wed, 16 Oct 2024 09:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729072608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1ixCIJA6yvkoiMh2ALclG0Qf+6NiOjZ2lVzTuA+JJOE=;
	b=07JWmaFYCfMNvzPMikhWhuTqVhkyzl9tcHjryA77iJ47oP8h79oitIQrBF/4XUpgPx4WxK
	ZoIwmV9eEl9e3CnRP22+ATno1Y/tNgKMyRih7AbVCODOsgdTVDhINWr/bnSys0DiHaiPka
	181QVgLHnKf+rMl3nwIls6Gj8bzLTFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729072608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1ixCIJA6yvkoiMh2ALclG0Qf+6NiOjZ2lVzTuA+JJOE=;
	b=hbC/esjYlUs0T4XFZGYnsJb8Cm4F8vmdlCKeQX90p/qFl8h416IihmiFZRMHyl/ts++uQL
	VeVhd8bbHM2NVOAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=07JWmaFY;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="hbC/esjY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729072608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1ixCIJA6yvkoiMh2ALclG0Qf+6NiOjZ2lVzTuA+JJOE=;
	b=07JWmaFYCfMNvzPMikhWhuTqVhkyzl9tcHjryA77iJ47oP8h79oitIQrBF/4XUpgPx4WxK
	ZoIwmV9eEl9e3CnRP22+ATno1Y/tNgKMyRih7AbVCODOsgdTVDhINWr/bnSys0DiHaiPka
	181QVgLHnKf+rMl3nwIls6Gj8bzLTFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729072608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1ixCIJA6yvkoiMh2ALclG0Qf+6NiOjZ2lVzTuA+JJOE=;
	b=hbC/esjYlUs0T4XFZGYnsJb8Cm4F8vmdlCKeQX90p/qFl8h416IihmiFZRMHyl/ts++uQL
	VeVhd8bbHM2NVOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 380BE1376C;
	Wed, 16 Oct 2024 09:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Kf9GDeCND2f/QgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 16 Oct 2024 09:56:48 +0000
Message-ID: <105a267b-e166-4928-baac-69c6d1a8f62f@suse.cz>
Date: Wed, 16 Oct 2024 11:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH lib] lib: alloc_tag_module_unload must wait for pending
 kfree_rcu calls
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Florian Westphal
 <fw@strlen.de>, linux-kernel@vger.kernel.org,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Ben Greear <greearb@candelatech.com>
References: <20241007205236.11847-1-fw@strlen.de>
 <20241007181541.4bbe9b8580f6475023256515@linux-foundation.org>
 <CAJuCfpGZg8Pydy4rGUefOBgwJZ5C6_s3p913oFQJSVV+S9MQoA@mail.gmail.com>
 <ZwTb8tMVVqrpZIv2@pc636>
 <CAJuCfpFKXYEaNJce2bUDR0EJNNk8KV_cUZfRALfmp=ejCW042A@mail.gmail.com>
 <ZwUunnGM9UFJ9bdt@pc638.lan>
 <CAJuCfpEtZK-w_=WuSPcQAJRyoazNkw-jxGoRyU0Ggg+Ljz2dZA@mail.gmail.com>
 <ZwZApQ5eB-Bx8Bpe@pc636>
 <CAJuCfpHR33mZEqtstEVz=x0tgG9ZDbH4Tf0nEmVUnn5GygR+NA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJuCfpHR33mZEqtstEVz=x0tgG9ZDbH4Tf0nEmVUnn5GygR+NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5672521E83
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/15/24 18:22, Suren Baghdasaryan wrote:
> On Wed, Oct 9, 2024 at 1:36 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>>
>> On Tue, Oct 08, 2024 at 11:34:10AM -0700, Suren Baghdasaryan wrote:
>> > On Tue, Oct 8, 2024 at 6:07 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>> > >
>> > > On Tue, Oct 08, 2024 at 04:16:39AM -0700, Suren Baghdasaryan wrote:
>> > > > On Tue, Oct 8, 2024 at 12:15 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>> > > > >
>> > > > > On Mon, Oct 07, 2024 at 06:49:32PM -0700, Suren Baghdasaryan wrote:
>> > > > > > On Mon, Oct 7, 2024 at 6:15 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>> > > > > > >
>> > > > > > > On Mon,  7 Oct 2024 22:52:24 +0200 Florian Westphal <fw@strlen.de> wrote:
>> > > > > > >
>> > > > > > > > Ben Greear reports following splat:
>> > > > > > > >  ------------[ cut here ]------------
>> > > > > > > >  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn has 256 allocated at module unload
>> > > > > > > >  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x22b/0x3f0
>> > > > > > > >  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos fat
>> > > > > > > > ...
>> > > > > > > >  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
>> > > > > > > >  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
>> > > > > > > >   codetag_unload_module+0x19b/0x2a0
>> > > > > > > >   ? codetag_load_module+0x80/0x80
>> > > > > > > >
>> > > > > > > > nf_nat module exit calls kfree_rcu on those addresses, but the free
>> > > > > > > > operation is likely still pending by the time alloc_tag checks for leaks.
>> > > > > > > >
>> > > > > > > > Wait for outstanding kfree_rcu operations to complete before checking
>> > > > > > > > resolves this warning.
>> > > > > > > >
>> > > > > > > > Reproducer:
>> > > > > > > > unshare -n iptables-nft -t nat -A PREROUTING -p tcp
>> > > > > > > > grep nf_nat /proc/allocinfo # will list 4 allocations
>> > > > > > > > rmmod nft_chain_nat
>> > > > > > > > rmmod nf_nat                # will WARN.
>> > > > > > > >
>> > > > > > > > ...
>> > > > > > > >
>> > > > > > > > --- a/lib/codetag.c
>> > > > > > > > +++ b/lib/codetag.c
>> > > > > > > > @@ -228,6 +228,8 @@ bool codetag_unload_module(struct module *mod)
>> > > > > > > >       if (!mod)
>> > > > > > > >               return true;
>> > > > > > > >
>> > > > > > > > +     kvfree_rcu_barrier();
>> > > > > > > > +
>> > > > > > > >       mutex_lock(&codetag_lock);
>> > > > > > > >       list_for_each_entry(cttype, &codetag_types, link) {
>> > > > > > > >               struct codetag_module *found = NULL;
>> > > > > > >
>> > > > > > > It's always hard to determine why a thing like this is present, so a
>> > > > > > > comment is helpful:
>> > > > > > >
>> > > > > > > --- a/lib/codetag.c~lib-alloc_tag_module_unload-must-wait-for-pending-kfree_rcu-calls-fix
>> > > > > > > +++ a/lib/codetag.c
>> > > > > > > @@ -228,6 +228,7 @@ bool codetag_unload_module(struct module
>> > > > > > >         if (!mod)
>> > > > > > >                 return true;
>> > > > > > >
>> > > > > > > +       /* await any module's kfree_rcu() operations to complete */
>> > > > > > >         kvfree_rcu_barrier();
>> > > > > > >
>> > > > > > >         mutex_lock(&codetag_lock);
>> > > > > > > _
>> > > > > > >
>> > > > > > > But I do wonder whether this is in the correct place.
>> > > > > > >
>> > > > > > > Waiting for a module's ->exit() function's kfree_rcu()s to complete
>> > > > > > > should properly be done by the core module handling code?
>> > > > > >
>> > > > > > I don't think core module code cares about kfree_rcu()s being complete
>> > > > > > before the module is unloaded.
>> > > > > > Allocation tagging OTOH cares because it is about to destroy tags
>> > > > > > which will be accessed when kfree() actually happens, therefore a
>> > > > > > strict ordering is important.
>> > > > > >
>> > > > > > >
>> > > > > > > free_module() does a full-on synchronize_rcu() prior to freeing the
>> > > > > > > module memory itself and I think codetag_unload_module() could be
>> > > > > > > called after that?
>> > > > > >
>> > > > > > I think we could move codetag_unload_module() after synchronize_rcu()
>> > > > > > inside free_module() but according to the reply in
>> > > > > > https://lore.kernel.org/all/20241007112904.GA27104@breakpoint.cc/
>> > > > > > synchronize_rcu() does not help. I'm not quite sure why...
>> > > > > >
>> > > > > It is because, synchronize_rcu() is used for a bit different things,
>> > > > > i.e. it is about a GP completion. Offloading objects can span several
>> > > > > GPs.
>> > > >
>> > > > Ah, thanks! Now that I looked into the patch that recently added
>> > > > kvfree_rcu_barrier() I understand that a bit better.
>> > > >
>> > > > >
>> > > > > > Note that once I'm done upstreaming
>> > > > > > https://lore.kernel.org/all/20240902044128.664075-3-surenb@google.com/,
>> > > > > > this change will not be needed and I'm planning to remove this call,
>> > > > > > however this change is useful for backporting. It should be sent to
>> > > > > > stable@vger.kernel.org # v6.10+
>> > > > > >
>> > > > > The kvfree_rcu_barrier() has been added into v6.12:
>> > > > >
>> > > > > <snip>
>> > > > > urezki@pc638:~/data/raid0/coding/linux.git$ git tag --contains 2b55d6a42d14c8675e38d6d9adca3014fdf01951
>> > > > > next-20240912
>> > > > > next-20240919
>> > > > > next-20240920
>> > > > > next-20241002
>> > > > > v6.12-rc1
>> > > > > urezki@pc638:~/data/raid0/coding/linux.git$
>> > > > > <snip>
>> > > > >
>> > > > > For 6.10+, it implies that the mentioned commit should be backported also.
>> > > >
>> > > > I see. I guess for pre-6.12 we would use rcu_barrier() instead of
>> > > > kvfree_rcu_barrier()?
>> > > >
>> > > For kernels < 6.12, unfortunately not :) If you have a possibility to
>> > > switch to reclaim over call_rcu() API, then you can go with rcu_barrier()
>> > > which waits for all callbacks to be completed.
>> >
>> > We do not control the call-site inside the module, so this would not
>> > be possible.
>> >
>> > >
>> > > Or backport kvfree_rcu_barrier(). It __should__ be easy since there
>> > > were not many changes into kvfree_rcu() between 6.10 and 6.12-rcX.
>> >
>> > That sounds better. I'll take a stab at it. Thanks!
> 
> I prepared backports for stable 6.10.y and 6.11.y branches which

6.10 is already EOL thus won't be necessary.

> contain this patch along with the prerequisite "rcu/kvfree: Add
> kvfree_rcu_barrier() API" patch. I think that's the only prerequisite
> required. However, since this patch is not yet in Linus' tree, I'll
> wait for it to get there before sending backports to stable (per Greg
> KH's recommendation). Please let me know if you think it's more
> critical and should be posted earlier.
> Thanks,
> Suren.
> 
>> >
>> You are welcome!
>>
>> --
>> Uladzislau Rezki
>>


