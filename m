Return-Path: <linux-kernel+bounces-282375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4457D94E2FC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5731F21C1B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C931F1547CB;
	Sun, 11 Aug 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AbKLilA"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28079C4
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723408231; cv=none; b=VzwleChKilDwV/w+/0jlOSBigP5wCuAa/xJslkubRHpcs2NncxMEx/FQECWl9Txzyz4+DnDnru9yVK+f74hJVL5xI/pSfDSUOyiBiV00TSiznjscIgtYaf7YlVXeaneocRaOtqGpjU60GGYDLacEKA1dn6Kbo9XGg/BtIBtY4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723408231; c=relaxed/simple;
	bh=CyETbTQpNxeIbVE/caPQ+TWr0ZLAPXE/w5iOZv5rERU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OTxa6jcQ/PdM4kL7Oopiz4gNOtCMTejcSx+eogpGBfj+D5jj3wCkC2j66g6qBVNBoolpJLUw1Ingkhmi7E5Ybyqd9DIQzVXkzQPf5OFXc8tzLeaaZrFGIO5IYOBZKCXW4KSsm108DB2/OvGJQExK4jMAJuLkIovZ2kXp+7EUfhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1AbKLilA; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39b6493b7dfso220685ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723408229; x=1724013029; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5LHinhJkPM7mgzzCEWfaYX6R0BuSflcxoeZfjEH9AQ=;
        b=1AbKLilA8JqoJxb5mjsM8fhshbGjbRWrJ+wkAf2ptqGSHBY6RKXb9FH1geqolDme92
         GP8rIO0Irvhrvj/f4u6iXLnT8IccXl3PClPvQwfpw9C62yhj4276mmApCsdDT7wz44jN
         P33E/Zxn8tp/PAEU2wIoGySJ4O+KqBjqu2qHGkVRgdG7jF7oH2TSUhyUt77V+wwQNwEh
         RXLP2ZbmzCao0VC44kO3vcI2Sf0XeoT3EkT7ue8fPFoBJVH3/UqkdDZ5VFfM16zpY0DT
         Q/Q+tG0cqDUt6AQM3RFHfUYr/tlaJoXt4/Uq06HVdzlvwkAlXr2vhLkMEGfYiLo64Mbq
         K0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723408229; x=1724013029;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5LHinhJkPM7mgzzCEWfaYX6R0BuSflcxoeZfjEH9AQ=;
        b=q9huW0BpQg6DXFjd1L7QUUQOLylMOW4zxh56RnkHx1w3q6bEPeY9xk9jbNwsGCk68a
         UAPOyteUy+hmoQlksqyFjow8tNqkeKOYZtQsmmnBp59mDlyWiRBE70hqpeGiEmlS7rov
         6UzZUigY+8xTWJE7iKWxV7O16dbXUADQMme0l9Yx3+EHqG7N9WmRDx10bDd3cYFO97EQ
         rtARoa4QNWc9WJCAvmXpF6wE6selOe29SSKcxSMD8i22BeY6hXKTrkML5kZD39FuJd7R
         0tJodq2FRWwqUXU1yQ99F86qeRhY/xOc3PyTcsguDKn5GtabrGifN38Snym6bDPSnM4n
         MmWA==
X-Forwarded-Encrypted: i=1; AJvYcCWUH73QVD4jT23uwQnw6WaSmtKaFMj4aRAHmCwZ+YrKAQ74UUHcnvln6vUDZ/8fjsBAmb2kXKIk76LwqEOrnt7llpIA4wgpjBeE4OlS
X-Gm-Message-State: AOJu0YzMIa7QyIQgFlXEC+cMQfJtNSd6jyl8Xu9XxoQ11aDx9hoYmNg4
	ZmY9/zWVf4JzsLrhjmYLHDgJ9neJyb3PxHiTVn1kFrUaHuqvKrHCW2t6+XlvYA==
X-Google-Smtp-Source: AGHT+IFXIUx75qgMWLqs135JhpCsuvZbm9wkrWd9JKjCSRxOax9133ZPYsZN263oH9Ox29T93Eb/FA==
X-Received: by 2002:a05:6e02:1448:b0:396:2b04:f489 with SMTP id e9e14a558f8ab-39c3146b4e4mr2784305ab.15.1723408228737;
        Sun, 11 Aug 2024 13:30:28 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba3f374sm25712555ad.259.2024.08.11.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:30:28 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:30:27 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] slab: Warn on duplicate cache names when DEBUG_VM=y
In-Reply-To: <20240807090746.2146479-1-pedro.falcato@gmail.com>
Message-ID: <cdfc5a08-c0ee-30a3-d6c5-22d4cfddc3a4@google.com>
References: <20240807090746.2146479-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 7 Aug 2024, Pedro Falcato wrote:

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 40b582a014b..1abe6a577d5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -88,6 +88,19 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
>  EXPORT_SYMBOL(kmem_cache_size);
>  
>  #ifdef CONFIG_DEBUG_VM
> +
> +static bool kmem_cache_is_duplicate_name(const char *name)
> +{
> +	struct kmem_cache *s;
> +
> +	list_for_each_entry(s, &slab_caches, list) {
> +		if (!strcmp(s->name, name))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int kmem_cache_sanity_check(const char *name, unsigned int size)
>  {
>  	if (!name || in_interrupt() || size > KMALLOC_MAX_SIZE) {
> @@ -95,6 +108,11 @@ static int kmem_cache_sanity_check(const char *name, unsigned int size)
>  		return -EINVAL;
>  	}
>  
> +	if (kmem_cache_is_duplicate_name(name)) {
> +		/* Duplicate names will confuse slabtop, et al */
> +		pr_warn("%s: name %s already exists as a cache\n", __func__, name);


Shouldn't this be a full WARN_ON() instead of pr_warn()?  I assume we'll 
be interested in who is adding the cache when the name already exists.

