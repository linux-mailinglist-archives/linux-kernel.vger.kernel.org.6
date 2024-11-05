Return-Path: <linux-kernel+bounces-396178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173559BC8FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBBE2845EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691BA1CCB2D;
	Tue,  5 Nov 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t8xCL8Zk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oOc32KEc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BSqxfb4c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eXvIbqU2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE752C1A2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798526; cv=none; b=uKPa5VEbvtxtrTGCrUNSUZwx1to/NZHTlsUneBeqtElIXZMdRTt3QtgMRQbef0f74ypFKDbdUmiB/JeLhE3UAMD2snKUOh7uwpfEhEM3vnGo8yXF7o32Ta+KV+3FpR7PuqAEBdVYhAHPOuEhMNhC99pOYQlnJRmFD0Ckfw69Qpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798526; c=relaxed/simple;
	bh=sSDJENRA4mt72DgKYUeLa3zTPVIVhLV7NBw9+D5geEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKyS5J444MaBmQ60dwpuuA39FxQzxfRpxyYvb7AXESYuJR4bm5kFugTASthpZ973NMir6kiueixCDO0ec2bjSLbC/AM4ILnGQBL6hEn678d24TFOcmm6+ua4U+KQcw8EByXhRye/vIkQwmC/oIB5QL3oNVhGONmcRX1GdbmwG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t8xCL8Zk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oOc32KEc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BSqxfb4c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eXvIbqU2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7A5921CA3;
	Tue,  5 Nov 2024 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730798523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QAW1SRKrrCcnuofRfZ9A0rSpe7NKVNAfqixSVPJfDfY=;
	b=t8xCL8Zk4LrxtjviQN9fVxtTcEn4EzvFGi2/ED+NsC0+UmO8iNNKuvKCPXixsaRdxvxbN4
	V9Q7h2hHpjAV5HVwW/2ycs9gXGmHROnscUWk2VCBVCCMwvyU2NwbHRoRQg609dknIa6QXP
	5bTh2X5hKvoZa7Gq74DY5XEwGOowsmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730798523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QAW1SRKrrCcnuofRfZ9A0rSpe7NKVNAfqixSVPJfDfY=;
	b=oOc32KEc2zxvFszSdt4D8O0pAAdLm8S6SxuZuErPVGOxhR2WYtolbxfAO6sOT/91okRKPe
	M2Hw6ta6ZXlNT3Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730798522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QAW1SRKrrCcnuofRfZ9A0rSpe7NKVNAfqixSVPJfDfY=;
	b=BSqxfb4ckzLsSfi+UJspEQx/7CC9xlpYdRdN2KtUsgzmd6ZIxstS9fO3BEJ6zftG+t3Dl8
	h1ihaS+QxAx0vJl6oHVQ8Z+wAujjNoXTlc9TZxtdIAjuj7lbHsQskGWRRVw6iXKGhJsMr6
	j6MPJEnOSkhtSYFCRNNCFNY3EtDyH2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730798522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QAW1SRKrrCcnuofRfZ9A0rSpe7NKVNAfqixSVPJfDfY=;
	b=eXvIbqU2vdhevOTJQtDvn/pAS7OaFVRDB9sU4yJlpG/z1rOpAVq19ApAr5ux3ICETApBAF
	rjR/6cdHPoNn/YBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6FA21394A;
	Tue,  5 Nov 2024 09:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t9sjNLrjKWeEOwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 05 Nov 2024 09:22:02 +0000
Message-ID: <721aaee9-2680-495a-807c-d188f8329fbb@suse.cz>
Date: Tue, 5 Nov 2024 10:22:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tools/mm: Fix slabinfo crash when MAX_SLABS is
 exceeded
Content-Language: en-US
To: Marc Dionne <marc.c.dionne@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>
References: <20241031105534.565533-1-marc.c.dionne@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241031105534.565533-1-marc.c.dionne@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,kvack.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 10/31/24 11:55, Marc Dionne wrote:
> From: Marc Dionne <marc.dionne@auristor.com>
> 
> The number of slabs can easily exceed the hard coded MAX_SLABS in the
> slabinfo tool, causing it to overwrite memory and crash.
> 
> Increase the value of MAX_SLABS, and check if that has been exceeded for
> each new slab, instead of at the end when it's already too late.  Also
> move the check for MAX_ALIASES into the loop body.
> 
> Signed-off-by: Marc Dionne <marc.dionne@auristor.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  tools/mm/slabinfo.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/mm/slabinfo.c b/tools/mm/slabinfo.c
> index cfaeaea71042..1a9b807a48c3 100644
> --- a/tools/mm/slabinfo.c
> +++ b/tools/mm/slabinfo.c
> @@ -21,7 +21,7 @@
>  #include <regex.h>
>  #include <errno.h>
>  
> -#define MAX_SLABS 500
> +#define MAX_SLABS 2000
>  #define MAX_ALIASES 500
>  #define MAX_NODES 1024
>  
> @@ -1228,6 +1228,8 @@ static void read_slab_dir(void)
>  				continue;
>  		switch (de->d_type) {
>  		   case DT_LNK:
> +			if (alias - aliasinfo == MAX_ALIASES)
> +				fatal("Too many aliases\n");
>  			alias->name = strdup(de->d_name);
>  			count = readlink(de->d_name, buffer, sizeof(buffer)-1);
>  
> @@ -1242,6 +1244,8 @@ static void read_slab_dir(void)
>  			alias++;
>  			break;
>  		   case DT_DIR:
> +			if (slab - slabinfo == MAX_SLABS)
> +				fatal("Too many slabs\n");
>  			if (chdir(de->d_name))
>  				fatal("Unable to access slab %s\n", slab->name);
>  			slab->name = strdup(de->d_name);
> @@ -1310,10 +1314,6 @@ static void read_slab_dir(void)
>  	slabs = slab - slabinfo;
>  	actual_slabs = slabs;
>  	aliases = alias - aliasinfo;
> -	if (slabs > MAX_SLABS)
> -		fatal("Too many slabs\n");
> -	if (aliases > MAX_ALIASES)
> -		fatal("Too many aliases\n");
>  }
>  
>  static void output_slabs(void)


