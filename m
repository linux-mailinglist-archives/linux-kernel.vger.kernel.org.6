Return-Path: <linux-kernel+bounces-346086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA8198BF61
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41C01C238FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705541C6F7C;
	Tue,  1 Oct 2024 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V6piIGN/"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17D1C68B3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791842; cv=none; b=axSh7aKnSgJEzctBAT4vqkcQPGCVo1WPwc6DwW+mMD/OgRfPGq60zoAt1StFftWd7TYRtDGpol00xFCKdQVn3D+IfqUQPmqd9NzIxyVzXJnO7SJr5NWKpK5WAFu7SV8ykfHxcJUSZ3qxBH9bL2C89oC88kstk7p5rlVGEVs+P9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791842; c=relaxed/simple;
	bh=MGgDWhyaNQkWdgyF0kICbw3+2mXSgWZStzFS2lNYyDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qm0C7AyiWdZlSoIWVC3qkqMBaB3Gb5/0eMmSAPYA94YQZQ9tGXoLJaqcqyPVDFZaUb7UyuT9/KAq7GxGl29CXCrg2nBexFp1uhxQFLYGMsyvePjAmXu8BUKMnOHDRwb7wT0pai5CgbRwYVgyxhjUe3v0pISwCkNyRyfpqFN+HGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V6piIGN/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso1038559166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727791838; x=1728396638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWOTvS4zDZLKq99kfYknxKFIZwkZsNNwHt76ZWUC/Eo=;
        b=V6piIGN/Wg2nF7fQ2tOKuuXxPmJE9BrgwSuLQcwOjRqDfGjbClnVr/WLNdjZdCvXhm
         bl/l3sTJX9i9za28p0dwV1L+h0LY+mgNTjqSJFmxQaE10C6LxJucTj9FuodND8hB9D++
         Tin20DT4HUuSfCERVZxnPJjermPi4Pt0gQDoq1obZgjgwiEEmj7CnL4AFmo85zG2Wmy5
         eJ9MqgKywxr4lYTD7vsiGttPEOZjl5t7SC8EXyM3TBe4J8olDm8um4UZ72tGhGva19qM
         IFuznxrRHjd3a1cFKXC/rKj6KL/9cMxKTznTLmm/vPVq4AySiF0x2AFMc4QIDbaUgUMI
         fcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727791838; x=1728396638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWOTvS4zDZLKq99kfYknxKFIZwkZsNNwHt76ZWUC/Eo=;
        b=JS1Mb6ir77tMAM3UQMG1gXET9i9lhFBvzqGDs00JLJlRXYRRkTBzG/JE04FrBxXtn/
         DLkXWkSW4YaqNcmlqNV5isncH/mVFlsv/lJAU2ikInI7+LllLepoMVBb7pbnrMqn5HXI
         StjZmE1R/GegSkSZWbJzUbcwL7wmwA8kHKxMTAPZo89ZFcdXhFdNe6Jd5sGuxkKqWnsy
         MtIwbqOaPfzNf740qHqVyll05IT9pFuztmVg7jO7T2E9MK2f7J/0DwzG9/z8lngv12p4
         H1tN9ICrc85LaigjA+UNZz4mm34KGi1SuFQflY47fvAwYmdIuYWT7Z+wF86uochuA4rs
         oAmg==
X-Forwarded-Encrypted: i=1; AJvYcCW06RbtYW3bdioJV47vOVI6jXs1DNs04i4reFEfc5l/TjhY2pvL+xECQmtVEHMMlT/0elm/xeXpMY0Lx1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9ixaGSf5xv4vwBc6UgwGI7IXRZBkRo5banKGSmU3/BccLZQk
	+RKtLoLOkHG8EnYM28mCh3ZNR+F+i0sJk2ZgpLNPmNXQYkRm1+FhLl3sGNdzMrk=
X-Google-Smtp-Source: AGHT+IHWshI1U55+ayRerqUDAPmjmAslMtQ1AiG1jSGgoCbP2U5K95tRhQn9Xdn9ZEPvAcaia9AIcg==
X-Received: by 2002:a17:907:3f07:b0:a8d:3ee9:12fd with SMTP id a640c23a62f3a-a967bb7e8c6mr406768166b.0.1727791837949;
        Tue, 01 Oct 2024 07:10:37 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2947296sm711323166b.114.2024.10.01.07.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:10:37 -0700 (PDT)
Message-ID: <a71e018b-1dc6-4427-8f10-399d8a9a5243@suse.com>
Date: Tue, 1 Oct 2024 16:10:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/20] gendwarfksyms: Add a cache for processed DIEs
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>,
 Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>,
 Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-28-samitolvanen@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240923181846.549877-28-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/24 20:18, Sami Tolvanen wrote:
> Basic types in DWARF repeat frequently and traversing the DIEs using
> libdw is relatively slow. Add a simple hashtable based cache for the
> processed DIEs.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/gendwarfksyms/Makefile        |   1 +
>  scripts/gendwarfksyms/die.c           | 143 ++++++++++++++++++++++++++
>  scripts/gendwarfksyms/dwarf.c         | 136 +++++++++++++++++-------
>  scripts/gendwarfksyms/gendwarfksyms.c |   6 ++
>  scripts/gendwarfksyms/gendwarfksyms.h |  62 ++++++++++-
>  5 files changed, 307 insertions(+), 41 deletions(-)
>  create mode 100644 scripts/gendwarfksyms/die.c
> 
> diff --git a/scripts/gendwarfksyms/Makefile b/scripts/gendwarfksyms/Makefile
> index 9f8fec4fd39b..c0d4ce50fc27 100644
> --- a/scripts/gendwarfksyms/Makefile
> +++ b/scripts/gendwarfksyms/Makefile
> @@ -2,6 +2,7 @@
>  hostprogs-always-y += gendwarfksyms
>  
>  gendwarfksyms-objs += gendwarfksyms.o
> +gendwarfksyms-objs += die.o
>  gendwarfksyms-objs += dwarf.o
>  gendwarfksyms-objs += symbols.o
>  
> diff --git a/scripts/gendwarfksyms/die.c b/scripts/gendwarfksyms/die.c
> new file mode 100644
> index 000000000000..28d89fce89fc
> --- /dev/null
> +++ b/scripts/gendwarfksyms/die.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Google LLC
> + */
> +
> +#include <string.h>
> +#include "gendwarfksyms.h"
> +
> +#define DIE_HASH_BITS 20
> +
> +/* {die->addr, state} -> struct die * */
> +static HASHTABLE_DEFINE(die_map, 1 << DIE_HASH_BITS);
> +
> +static unsigned int map_hits;
> +static unsigned int map_misses;
> +
> +static inline unsigned int die_hash(uintptr_t addr, enum die_state state)
> +{
> +	return hash_32(addr_hash(addr) ^ (unsigned int)state);
> +}
> +
> +static void init_die(struct die *cd)
> +{
> +	cd->state = DIE_INCOMPLETE;
> +	cd->fqn = NULL;
> +	cd->tag = -1;
> +	cd->addr = 0;
> +	INIT_LIST_HEAD(&cd->fragments);
> +}
> +
> +static struct die *create_die(Dwarf_Die *die, enum die_state state)
> +{
> +	struct die *cd;
> +
> +	cd = xmalloc(sizeof(struct die));
> +	init_die(cd);
> +	cd->addr = (uintptr_t)die->addr;
> +
> +	hash_add(die_map, &cd->hash, die_hash(cd->addr, state));
> +	return cd;
> +}
> +
> +int __die_map_get(uintptr_t addr, enum die_state state, struct die **res)
> +{
> +	struct die *cd;
> +
> +	hash_for_each_possible(die_map, cd, hash, die_hash(addr, state)) {
> +		if (cd->addr == addr && cd->state == state) {
> +			*res = cd;
> +			return 0;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +struct die *die_map_get(Dwarf_Die *die, enum die_state state)
> +{
> +	struct die *cd;
> +
> +	if (__die_map_get((uintptr_t)die->addr, state, &cd) == 0) {
> +		map_hits++;
> +		return cd;
> +	}
> +
> +	map_misses++;
> +	return create_die(die, state);
> +}
> +
> +static void reset_die(struct die *cd)
> +{
> +	struct die_fragment *tmp;
> +	struct die_fragment *df;
> +
> +	list_for_each_entry_safe(df, tmp, &cd->fragments, list) {
> +		if (df->type == FRAGMENT_STRING)
> +			free(df->data.str);
> +		free(df);
> +	}
> +
> +	if (cd->fqn && *cd->fqn)
> +		free(cd->fqn);
> +	init_die(cd);
> +}
> +
> +void die_map_free(void)
> +{
> +	struct hlist_node *tmp;
> +	unsigned int stats[DIE_LAST + 1];
> +	struct die *cd;
> +	int i;
> +
> +	memset(stats, 0, sizeof(stats));
> +
> +	hash_for_each_safe(die_map, cd, tmp, hash) {
> +		stats[cd->state]++;
> +		reset_die(cd);
> +		free(cd);
> +	}
> +	hash_init(die_map);
> +
> +	if (map_hits + map_misses > 0)
> +		debug("hits %u, misses %u (hit rate %.02f%%)", map_hits,
> +		      map_misses,
> +		      (100.0f * map_hits) / (map_hits + map_misses));
> +
> +	for (i = 0; i <= DIE_LAST; i++)
> +		debug("%s: %u entries", die_state_name(i), stats[i]);
> +}
> +
> +static struct die_fragment *append_item(struct die *cd)
> +{
> +	struct die_fragment *df;
> +
> +	df = xmalloc(sizeof(struct die_fragment));
> +	df->type = FRAGMENT_EMPTY;
> +	list_add_tail(&df->list, &cd->fragments);
> +	return df;
> +}
> +
> +void die_map_add_string(struct die *cd, const char *str)
> +{
> +	struct die_fragment *df;
> +
> +	if (!cd)
> +		return;
> +
> +	df = append_item(cd);
> +	df->data.str = xstrdup(str);
> +	df->type = FRAGMENT_STRING;
> +}
> +
> +void die_map_add_die(struct die *cd, struct die *child)
> +{
> +	struct die_fragment *df;
> +
> +	if (!cd)
> +		return;
> +
> +	df = append_item(cd);
> +	df->data.addr = child->addr;
> +	df->type = FRAGMENT_DIE;
> +}
> diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
> index 3e9e8500f448..f0c881bef026 100644
> --- a/scripts/gendwarfksyms/dwarf.c
> +++ b/scripts/gendwarfksyms/dwarf.c
> @@ -71,17 +71,19 @@ static bool match_export_symbol(struct state *state, Dwarf_Die *die)
>  /*
>   * Type string processing
>   */
> -static void process(const char *s)
> +static void process(struct die *cache, const char *s)
>  {
>  	s = s ?: "<null>";
>  
>  	if (dump_dies)
>  		fputs(s, stderr);
> +
> +	die_map_add_string(cache, s);
>  }
>  
>  #define MAX_FMT_BUFFER_SIZE 128
>  
> -static void process_fmt(const char *fmt, ...)
> +static void process_fmt(struct die *cache, const char *fmt, ...)
>  {
>  	char buf[MAX_FMT_BUFFER_SIZE];
>  	va_list args;
> @@ -91,7 +93,7 @@ static void process_fmt(const char *fmt, ...)
>  	if (checkp(vsnprintf(buf, sizeof(buf), fmt, args)) >= sizeof(buf))
>  		error("vsnprintf overflow: increase MAX_FMT_BUFFER_SIZE");
>  
> -	process(buf);
> +	process(cache, buf);
>  	va_end(args);
>  }
>  
> @@ -162,18 +164,28 @@ static char *get_fqn(Dwarf_Die *die)
>  	return fqn;
>  }
>  
> -static void process_fqn(Dwarf_Die *die)
> +static void update_fqn(struct die *cache, Dwarf_Die *die)
> +{
> +	if (!cache->fqn)
> +		cache->fqn = get_fqn(die) ?: "";
> +}

When is update_fqn() called with cache->fqn being already non-NULL?

In general, I find handling of cache->fqn slightly confusing, mostly
because the member has three states: NULL initially,
a statically-allocated empty string if the DIE doesn't have a name and
a dynamically-allocated non-zero-length string otherwise.

I wonder if it would be possible to reduce it to two states: NULL
initially and when the DIE doesn't have a name, or a regular string.

> +
> +static void process_fqn(struct die *cache, Dwarf_Die *die)
>  {
> -	process(" ");
> -	process(get_fqn(die) ?: "");
> +	update_fqn(cache, die);
> +	if (*cache->fqn)
> +		process(cache, " ");
> +	process(cache, cache->fqn);
>  }
>  
> -#define DEFINE_PROCESS_UDATA_ATTRIBUTE(attribute)                           \
> -	static void process_##attribute##_attr(Dwarf_Die *die)              \
> -	{                                                                   \
> -		Dwarf_Word value;                                           \
> -		if (get_udata_attr(die, DW_AT_##attribute, &value))         \
> -			process_fmt(" " #attribute "(%" PRIu64 ")", value); \
> +#define DEFINE_PROCESS_UDATA_ATTRIBUTE(attribute)                          \
> +	static void process_##attribute##_attr(struct die *cache,          \
> +					       Dwarf_Die *die)             \
> +	{                                                                  \
> +		Dwarf_Word value;                                          \
> +		if (get_udata_attr(die, DW_AT_##attribute, &value))        \
> +			process_fmt(cache, " " #attribute "(%" PRIu64 ")", \
> +				    value);                                \
>  	}
>  
>  DEFINE_PROCESS_UDATA_ATTRIBUTE(alignment)
> @@ -185,8 +197,9 @@ bool match_all(Dwarf_Die *die)
>  	return true;
>  }
>  
> -int process_die_container(struct state *state, Dwarf_Die *die,
> -			  die_callback_t func, die_match_callback_t match)
> +int process_die_container(struct state *state, struct die *cache,
> +			  Dwarf_Die *die, die_callback_t func,
> +			  die_match_callback_t match)
>  {
>  	Dwarf_Die current;
>  	int res;
> @@ -195,7 +208,7 @@ int process_die_container(struct state *state, Dwarf_Die *die,
>  	while (!res) {
>  		if (match(&current)) {
>  			/* <0 = error, 0 = continue, >0 = stop */
> -			res = checkp(func(state, &current));
> +			res = checkp(func(state, cache, &current));
>  			if (res)
>  				return res;
>  		}
> @@ -206,39 +219,78 @@ int process_die_container(struct state *state, Dwarf_Die *die,
>  	return 0;
>  }
>  
> -static int process_type(struct state *state, Dwarf_Die *die);
> +static int process_type(struct state *state, struct die *parent,
> +			Dwarf_Die *die);
>  
> -static void process_type_attr(struct state *state, Dwarf_Die *die)
> +static void process_type_attr(struct state *state, struct die *cache,
> +			      Dwarf_Die *die)
>  {
>  	Dwarf_Die type;
>  
>  	if (get_ref_die_attr(die, DW_AT_type, &type)) {
> -		check(process_type(state, &type));
> +		check(process_type(state, cache, &type));
>  		return;
>  	}
>  
>  	/* Compilers can omit DW_AT_type -- print out 'void' to clarify */
> -	process("base_type void");
> +	process(cache, "base_type void");
> +}
> +
> +static void process_base_type(struct state *state, struct die *cache,
> +			      Dwarf_Die *die)
> +{
> +	process(cache, "base_type");
> +	process_fqn(cache, die);
> +	process_byte_size_attr(cache, die);
> +	process_encoding_attr(cache, die);
> +	process_alignment_attr(cache, die);
>  }
>  
> -static void process_base_type(struct state *state, Dwarf_Die *die)
> +static void process_cached(struct state *state, struct die *cache,
> +			   Dwarf_Die *die)
>  {
> -	process("base_type");
> -	process_fqn(die);
> -	process_byte_size_attr(die);
> -	process_encoding_attr(die);
> -	process_alignment_attr(die);
> +	struct die_fragment *df;
> +	Dwarf_Die child;
> +
> +	list_for_each_entry(df, &cache->fragments, list) {
> +		switch (df->type) {
> +		case FRAGMENT_STRING:
> +			process(NULL, df->data.str);
> +			break;
> +		case FRAGMENT_DIE:
> +			if (!dwarf_die_addr_die(dwarf_cu_getdwarf(die->cu),
> +						(void *)df->data.addr, &child))
> +				error("dwarf_die_addr_die failed");
> +			check(process_type(state, NULL, &child));
> +			break;
> +		default:
> +			error("empty die_fragment");
> +		}
> +	}
>  }
>  
> -#define PROCESS_TYPE(type)                         \
> -	case DW_TAG_##type##_type:                 \
> -		process_##type##_type(state, die); \
> +#define PROCESS_TYPE(type)                                \
> +	case DW_TAG_##type##_type:                        \
> +		process_##type##_type(state, cache, die); \
>  		break;
>  
> -static int process_type(struct state *state, Dwarf_Die *die)
> +static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
>  {
> +	struct die *cache;
>  	int tag = dwarf_tag(die);
>  
> +	/*
> +	 * If we have the DIE already cached, use it instead of walking
> +	 * through DWARF.
> +	 */
> +	cache = die_map_get(die, DIE_COMPLETE);
> +
> +	if (cache->state == DIE_COMPLETE) {
> +		process_cached(state, cache, die);
> +		die_map_add_die(parent, cache);
> +		return 0;
> +	}
> +
>  	switch (tag) {
>  	PROCESS_TYPE(base)
>  	default:
> @@ -246,6 +298,11 @@ static int process_type(struct state *state, Dwarf_Die *die)
>  		break;
>  	}
>  
> +	/* Update cache state and append to the parent (if any) */
> +	cache->tag = tag;
> +	cache->state = DIE_COMPLETE;
> +	die_map_add_die(parent, cache);
> +
>  	return 0;
>  }
>  
> @@ -256,14 +313,15 @@ static void process_symbol(struct state *state, Dwarf_Die *die,
>  			   die_callback_t process_func)
>  {
>  	debug("%s", state->sym->name);
> -	check(process_func(state, die));
> +	check(process_func(state, NULL, die));
>  	if (dump_dies)
>  		fputs("\n", stderr);
>  }
>  
> -static int __process_subprogram(struct state *state, Dwarf_Die *die)
> +static int __process_subprogram(struct state *state, struct die *cache,
> +				Dwarf_Die *die)
>  {
> -	process("subprogram");
> +	process(cache, "subprogram");
>  	return 0;
>  }
>  
> @@ -272,10 +330,11 @@ static void process_subprogram(struct state *state, Dwarf_Die *die)
>  	process_symbol(state, die, __process_subprogram);
>  }
>  
> -static int __process_variable(struct state *state, Dwarf_Die *die)
> +static int __process_variable(struct state *state, struct die *cache,
> +			      Dwarf_Die *die)
>  {
> -	process("variable ");
> -	process_type_attr(state, die);
> +	process(cache, "variable ");
> +	process_type_attr(state, cache, die);
>  	return 0;
>  }
>  
> @@ -284,7 +343,8 @@ static void process_variable(struct state *state, Dwarf_Die *die)
>  	process_symbol(state, die, __process_variable);
>  }
>  
> -static int process_exported_symbols(struct state *unused, Dwarf_Die *die)
> +static int process_exported_symbols(struct state *unused, struct die *cache,
> +				    Dwarf_Die *die)
>  {
>  	int tag = dwarf_tag(die);
>  
> @@ -294,7 +354,7 @@ static int process_exported_symbols(struct state *unused, Dwarf_Die *die)
>  	case DW_TAG_class_type:
>  	case DW_TAG_structure_type:
>  		return check(process_die_container(
> -			NULL, die, process_exported_symbols, match_all));
> +			NULL, cache, die, process_exported_symbols, match_all));
>  
>  	/* Possible exported symbols */
>  	case DW_TAG_subprogram:
> @@ -318,6 +378,6 @@ static int process_exported_symbols(struct state *unused, Dwarf_Die *die)
>  
>  void process_cu(Dwarf_Die *cudie)
>  {
> -	check(process_die_container(NULL, cudie, process_exported_symbols,
> +	check(process_die_container(NULL, NULL, cudie, process_exported_symbols,
>  				    match_all));
>  }
> diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
> index 5032ec487626..66806b0936e4 100644
> --- a/scripts/gendwarfksyms/gendwarfksyms.c
> +++ b/scripts/gendwarfksyms/gendwarfksyms.c
> @@ -43,6 +43,10 @@ static int process_module(Dwfl_Module *mod, void **userdata, const char *name,
>  	debug("%s", name);
>  	dbg = dwfl_module_getdwarf(mod, &dwbias);
>  
> +	/*
> +	 * Look for exported symbols in each CU, follow the DIE tree, and add
> +	 * the entries to die_map.
> +	 */
>  	do {
>  		res = dwarf_get_units(dbg, cu, &cu, NULL, NULL, &cudie, NULL);
>  		if (res < 0)
> @@ -53,6 +57,8 @@ static int process_module(Dwfl_Module *mod, void **userdata, const char *name,
>  		process_cu(&cudie);
>  	} while (cu);
>  
> +	die_map_free();
> +
>  	return DWARF_CB_OK;
>  }
>  
> diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
> index a058647e2361..7df270429c21 100644
> --- a/scripts/gendwarfksyms/gendwarfksyms.h
> +++ b/scripts/gendwarfksyms/gendwarfksyms.h
> @@ -89,6 +89,60 @@ void symbol_read_exports(FILE *file);
>  void symbol_read_symtab(int fd);
>  struct symbol *symbol_get(const char *name);
>  
> +/*
> + * die.c
> + */
> +
> +enum die_state {
> +	DIE_INCOMPLETE,
> +	DIE_COMPLETE,
> +	DIE_LAST = DIE_COMPLETE
> +};
> +
> +enum die_fragment_type {
> +	FRAGMENT_EMPTY,
> +	FRAGMENT_STRING,
> +	FRAGMENT_DIE
> +};
> +
> +struct die_fragment {
> +	enum die_fragment_type type;
> +	union {
> +		char *str;
> +		uintptr_t addr;
> +	} data;
> +	struct list_head list;
> +};
> +
> +#define CASE_CONST_TO_STR(name) \
> +	case name:              \
> +		return #name;
> +
> +static inline const char *die_state_name(enum die_state state)
> +{
> +	switch (state) {
> +	default:
> +	CASE_CONST_TO_STR(DIE_INCOMPLETE)
> +	CASE_CONST_TO_STR(DIE_COMPLETE)
> +	}

Nit: I suggest to move the default case out of the switch statement:

	switch (state) {
	CASE_CONST_TO_STR(DIE_INCOMPLETE)
	CASE_CONST_TO_STR(DIE_COMPLETE)
	}
	error("unexpected die_state: %d", state);

This way, if someone adds a new value in die_state and forgets to handle
it in die_state_name(), they get a compiler warning.. or a runtime error
later.

> +}
> +
> +struct die {
> +	enum die_state state;
> +	char *fqn;
> +	int tag;
> +	uintptr_t addr;
> +	struct list_head fragments;
> +	struct hlist_node hash;
> +};
> +
> +int __die_map_get(uintptr_t addr, enum die_state state, struct die **res);
> +struct die *die_map_get(Dwarf_Die *die, enum die_state state);
> +void die_map_add_string(struct die *pd, const char *str);
> +void die_map_add_linebreak(struct die *pd, int linebreak);
> +void die_map_add_die(struct die *pd, struct die *child);
> +void die_map_free(void);
> +
>  /*
>   * dwarf.c
>   */
> @@ -98,12 +152,14 @@ struct state {
>  	Dwarf_Die die;
>  };
>  
> -typedef int (*die_callback_t)(struct state *state, Dwarf_Die *die);
> +typedef int (*die_callback_t)(struct state *state, struct die *cache,
> +			      Dwarf_Die *die);
>  typedef bool (*die_match_callback_t)(Dwarf_Die *die);
>  bool match_all(Dwarf_Die *die);
>  
> -int process_die_container(struct state *state, Dwarf_Die *die,
> -			  die_callback_t func, die_match_callback_t match);
> +int process_die_container(struct state *state, struct die *cache,
> +			  Dwarf_Die *die, die_callback_t func,
> +			  die_match_callback_t match);
>  
>  void process_cu(Dwarf_Die *cudie);
>  

-- 
Thanks,
Petr

