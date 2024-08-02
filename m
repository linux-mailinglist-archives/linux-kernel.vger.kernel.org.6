Return-Path: <linux-kernel+bounces-273014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4679946361
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5671E1F230A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868681547C2;
	Fri,  2 Aug 2024 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaXUPavJ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442711ABED5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624730; cv=none; b=EKnWKCS15Cyzn/DG4688rkha1/3x0MSUENXqZMjZFhULIHOzgiCayyWfPYjkEsYMjJz2/KkRdzdDqHD5D+G28xNSW/9/6xOPbq7UV8KE3ZmhcTCQj25gGur5ZmGyW06lT1qfvtMHp98CrxR2ebuHOxhugcl3nmGPun3w/gvKamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624730; c=relaxed/simple;
	bh=iyzmY2mYDZhArD1mjD011Mp4zlsSOhx6cPviSULNEUI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXTmZTuSNm7ZSAr3poC0wdFXKlE6RbjV34FPKvaYtiXe0oVr9RDOWykC+H1CAHoGi+tKueg/C/qmM/lHlDH/1CSwDBicU6JieHibZOxvnlLzmq9WomDFrdhLE690mWOVEoMJ6kYvt8wMmhxgc3i05B+TDtSo3knwL68tmCVpMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaXUPavJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd65aaac27so25875015ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722624728; x=1723229528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t+v3NL+zeA+TfLqsAOg0jF4pN/5zB5SP0NcF9oposHA=;
        b=VaXUPavJ1prY1TDdbsd5Qy9dY62OJsiCaof0BSzinCMp84pjIJmQSgtZ97PmVH5vGK
         RJOiMzvYbZ8us5HmkYWnf2g5QNd2Y/DqPByKsCSCKaJf5qTskbg+Fye8qSbSdlclvkve
         3JIW/EnGBvutSG3NvXD9Y/vbo1EB2HCwPSn5lcoRzncIHPZiG0CnFcLeT0CxTg6p5tV+
         yE291WRglHQtWh7zL1p18nyIbFpa3R6PT4H9TMEDQWBqmJLTu96HTsY7wUBQeRPOucDJ
         Qv96N6Olk+OmseTPBbbB78xC/fW9Madgz1GLT3Eef/mv7xg87RDZjDlRB2U34n7EZ1bp
         NbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624728; x=1723229528;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+v3NL+zeA+TfLqsAOg0jF4pN/5zB5SP0NcF9oposHA=;
        b=We7SQGvdq71r1y+mii++OmHs44+LnZ7jhn1yu2YpXzpkFknxHK4CzzQftkjwzRyGG1
         Yg5d02ZGmnGkQAhxtPXOjF7mMcKfjlkaS4KLWKcSypcegmd0G3j1mUNsS3OTCnP8hrk1
         Xb4CX2uDyvhb8hTu65oMCVymv2PSjlZFyAZQ/UM9N414wiSI0cVCVZlD07n1cKNHXdN8
         PACCCU5PMrmeHq0MfZLoGSSI5qEveCOEc3hS3w2D9avRV9vqp5PmRNsa1wo2+xnQRHkY
         t0hc20CZfepJDixhVx7iPeCcgBzQotZ0yLDwZ6wpfGTIIyMB1t6F4/eQpbh3aM6RdCcO
         F2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZE28zTugD6bDaN3/3wwq6Z85S8X4drJzwKuIDNcAnJ4LFzII3AlzwcoleykQwoXIrh0Ma+R3TmnqNuKUBJTIutCtV37aZ7Z2ol4gt
X-Gm-Message-State: AOJu0YxuobxK6VtaCHta5N3gnsYsEu8fapmLaLgytzooU6c9H01XNYvt
	AcBKw5VBXj8FNtSeIykBNs8oOk4V9Vp7YjTsYSEqV7gfMlK17X84
X-Google-Smtp-Source: AGHT+IH0BB6n3fiWsO3K5b0edDmVXwKFkws5lBhHDWc9OULFCdJ7o2ipq4hucS8+J99vDCijG4X8Kw==
X-Received: by 2002:a17:903:41c8:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-1ff57bc504emr63979135ad.15.1722624728254;
        Fri, 02 Aug 2024 11:52:08 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59294e92sm20488915ad.240.2024.08.02.11.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:52:07 -0700 (PDT)
Message-ID: <66ad2ad7.170a0220.3a8e93.6a32@mx.google.com>
X-Google-Original-Message-ID: <Zq0q1D0ISadIq_oy@DESKTOP-DUKSS9G.>
Date: Fri, 2 Aug 2024 11:52:04 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 01/22] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-2-alexs@kernel.org>

On Mon, Jul 29, 2024 at 07:25:13PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>

I've been busy with other things, so I haven't been able to review this
until now. Thanks to both you and Hyeonggon for working on this memdesc :)

> The 1st patch introduces new memory decriptor zpdesc and rename
> zspage.first_page to zspage.first_zpdesc, no functional change.
> 
> We removed PG_owner_priv_1 since it was moved to zspage after
> commit a41ec880aa7b ("zsmalloc: move huge compressed obj from
> page to zspage").
> 
> And keep the memcg_data member, since as Yosry pointed out:
> "When the pages are freed, put_page() -> folio_put() -> __folio_put() will call
> mem_cgroup_uncharge(). The latter will call folio_memcg() (which reads
> folio->memcg_data) to figure out if uncharging needs to be done.
> 
> There are also other similar code paths that will check
> folio->memcg_data. It is currently expected to be present for all
> folios. So until we have custom code paths per-folio type for
> allocation/freeing/etc, we need to keep folio->memcg_data present and
> properly initialized."
> 
> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---
>  mm/zpdesc.h   | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/zsmalloc.c | 21 ++++++++--------
>  2 files changed, 76 insertions(+), 11 deletions(-)
>  create mode 100644 mm/zpdesc.h
> 
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> new file mode 100644
> index 000000000000..2dbef231f616
> --- /dev/null
> +++ b/mm/zpdesc.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* zpdesc.h: zswap.zpool memory descriptor
> + *
> + * Written by Alex Shi <alexs@kernel.org>
> + *	      Hyeonggon Yoo <42.hyeyoo@gmail.com>
> + */
> +#ifndef __MM_ZPDESC_H__
> +#define __MM_ZPDESC_H__
> +
> +/*
> + * struct zpdesc -	Memory descriptor for zpool memory, now is for zsmalloc
> + * @flags:		Page flags, PG_private: identifies the first component page
> + * @lru:		Indirectly used by page migration
> + * @mops:		Used by page migration
> + * @next:		Next zpdesc in a zspage in zsmalloc zpool
> + * @handle:		For huge zspage in zsmalloc zpool
> + * @zspage:		Pointer to zspage in zsmalloc
> + * @memcg_data:		Memory Control Group data.
> + *

I think its a good idea to include comments for the padding (namely what
aliases with it in struct page) here as well. It doesn't hurt, and will
make them easier to remove in the future.

> + * This struct overlays struct page for now. Do not modify without a good
> + * understanding of the issues.
> + */
> +struct zpdesc {
> +	unsigned long flags;
> +	struct list_head lru;
> +	struct movable_operations *mops;
> +	union {
> +		/* Next zpdescs in a zspage in zsmalloc zpool */
> +		struct zpdesc *next;
> +		/* For huge zspage in zsmalloc zpool */
> +		unsigned long handle;
> +	};
> +	struct zspage *zspage;

I like using pointers here, although I think the comments should be more
precise about what the purpose of the pointer is. Maybe something like
"Points to the zspage this zpdesc is a part of" or something.

> +	unsigned long _zp_pad_1;
> +#ifdef CONFIG_MEMCG
> +	unsigned long memcg_data;
> +#endif
> +};

You should definitely fold your additions to the struct from patch 17
into this patch. It makes it easier to review, and better for anyone
looking at the commit log in the future.

> +#define ZPDESC_MATCH(pg, zp) \
> +	static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
> +
> +ZPDESC_MATCH(flags, flags);
> +ZPDESC_MATCH(lru, lru);
> +ZPDESC_MATCH(mapping, mops);
> +ZPDESC_MATCH(index, next);
> +ZPDESC_MATCH(index, handle);
> +ZPDESC_MATCH(private, zspage);
> +#ifdef CONFIG_MEMCG
> +ZPDESC_MATCH(memcg_data, memcg_data);
> +#endif
> +#undef ZPDESC_MATCH
> +static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
> +
> +#define zpdesc_page(zp)			(_Generic((zp),			\
> +	const struct zpdesc *:		(const struct page *)(zp),	\
> +	struct zpdesc *:		(struct page *)(zp)))
> +
> +#define zpdesc_folio(zp)		(_Generic((zp),			\
> +	const struct zpdesc *:		(const struct folio *)(zp),	\
> +	struct zpdesc *:		(struct folio *)(zp)))
> +
> +#define page_zpdesc(p)			(_Generic((p),			\
> +	const struct page *:		(const struct zpdesc *)(p),	\
> +	struct page *:			(struct zpdesc *)(p)))
> +
> +#endif

I'm don't think we need both page and folio cast functions for zpdescs.
Sticking to pages will probably suffice (and be easiest) since all APIs
zsmalloc cares about are already defined. 

We can stick to 1 "middle-man" descriptor for zpdescs since zsmalloc
uses those pages as space to track zspages and nothing more. We'll likely
end up completely removing it from zsmalloc once we can allocate
memdescs on their own: It seems most (if not all) of the "indirect" members
of zpdesc are used as indicators to the rest of core-mm telling them not to
mess with that memory.

