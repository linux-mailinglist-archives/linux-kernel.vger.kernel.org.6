Return-Path: <linux-kernel+bounces-410336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC489CDA16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD0B281482
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE70318BBB0;
	Fri, 15 Nov 2024 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcwnG8UG"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15218BBAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731657129; cv=none; b=UXfSe7U/0QNLfnG9ua0mB4c5+e0VepU3lmpY2j+viQWdYyBZE84i7lROAIxjIdMZGeVPRqQvyTnMTBy76NxHgwsA1kBTmjMcER2gpVB7h7z0l8Mfik4n+IdxT1L8DkEA1FY1ogOXPfRNYEDf0yroEjVA1XbGg1Tgwlp6tG3+HiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731657129; c=relaxed/simple;
	bh=RXll+GMHEp3MEQ0GRk55xOrBayavcQGxZPUerIbQyzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+JhVd3UuBfkRzT54hzF+OeE2FmRl977wU8+d59UzuvgbGj5/00/T0FMc1DQKyZc34oVDiJtI/ir9KBIHrkTROZrkcO4QW0xO6Er3ShPXnIfywGKOuWMzzHemy7V2hrzFt9ondqFvsb/Z7uXcjKrHS9xeVtTyEg/uS1xtonjTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcwnG8UG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa1e87afd31so187435366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657126; x=1732261926; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak51RbAOf5ag9k2fqB3j10uDW53SBC7LHip6uj8Et3I=;
        b=OcwnG8UGLnqIH+7rAAGc+0ZhajoYBzRIPVAsXu2zuOWFHG2zgcvnSOMEsU5Evpw1e+
         MUtrHWjVoKpQLmgCvImDuHv9VhfiCzz76/cM9XYSNrgeizkMOXM443Lnmw1WV5Z5Ev+o
         iQZUrNb+VciJ7xey0DL2WiYg47LBN/S4hHilFjXVNeJLEbaTONTiRg2GSYBBWLnqorTk
         zM7+x1Kyvv7DTmhXnldurJnl/sBBWtfPlX8rwku3iupyS0vLFNu2Ijej/LlF7Z3YLx5l
         XnHQyrUEOx3twfiUKeQhxgkz+TgRAbWlEW3VN1o50D7E7GtwI11JJdsDLlaFOP6Roj30
         lWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657126; x=1732261926;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ak51RbAOf5ag9k2fqB3j10uDW53SBC7LHip6uj8Et3I=;
        b=o+0/93uxVDzFRpxiXPyvY2QvOaUuu5gy9DgYUXD+zNFjXgkxyAnxLEToAR8w5W23DH
         3ZJHxPtD14QMgqg4L3GsAkAe0lHiXnjGc2y9pBsYU8bhrSzkG6WVv42n1sbZCd9hnGIf
         CbSWkIjlTZ6Eiity71vtL3dZbH2JbDknODvfaaxtp/FXRyRknpYloyIajPaXDTtyvhu/
         AENvCibnyXBkzku6Gc3Ox0r9lYM2r6vhNo4bhvA7WUnHBzTpWjcN5vLLeX+wi9KCUZT8
         cr4ZxIDZoupPa6IMOSoLpO3giWyubWUigqAy8tOPPx/C39MSp0OUiUReaNEfXJoJzY0m
         kxKg==
X-Gm-Message-State: AOJu0YwvVJ1N16nYSX8p1eRBuAK9y2yHboyaHIb0y9P8hwGKlgmwxM/7
	gBEr8fqU/vo9bRYfdTpNMJKOEGlqv8YpnVDKmMqOL0GBPiguG3IY
X-Google-Smtp-Source: AGHT+IGeUUCALONSY/DirIy3E7MjqDCgjI19kTQd0vXvuk/ibTsIesE3PfVGRjSRcDeb/U+GiWPb6g==
X-Received: by 2002:a17:906:6a20:b0:a9e:c267:78c5 with SMTP id a640c23a62f3a-aa483553e28mr129250866b.55.1731657125577;
        Thu, 14 Nov 2024 23:52:05 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df2649esm150606766b.39.2024.11.14.23.52.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2024 23:52:04 -0800 (PST)
Date: Fri, 15 Nov 2024 07:52:03 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com
Subject: Re: [PATCH 3/5] maple_tree: use vacant nodes to reduce worst case
 allocations
Message-ID: <20241115075203.ojspk255cw3sr3s3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <20241114170524.64391-4-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114170524.64391-4-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Nov 14, 2024 at 12:05:22PM -0500, Sidhartha Kumar wrote:
>In order to determine the store type for a maple tree operation, a walk
>of the tree is done through mas_wr_walk(). This function descends the
>tree until a spanning write is detected or we reach a leaf node. While
>descending, keep track of the height at which we encounter a node with
>available space. This is done by checking if mas->end is less than the
>number of slots a given node type can fit.
>
>Now that the height of the vacant node is tracked, we can use the
>difference between the height of the tree and the height of the vacant
>node to know how many levels we will have to propagate creating new
>nodes. Update mas_prealloc_calc() to consider the vacant height and
>reduce the number of worst allocations.
>
>Rebalancing stores are not supported and fall back to using the full
>height of the tree for allocations.
>
>Update preallocation testing assertions to take into account vacant
>height.
>
>Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
>---
> include/linux/maple_tree.h       |  2 +
> lib/maple_tree.c                 | 13 +++--
> tools/testing/radix-tree/maple.c | 97 +++++++++++++++++++++++++++++---
> 3 files changed, 100 insertions(+), 12 deletions(-)
>
>diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
>index cbbcd18d4186..7d777aa2d9ed 100644
>--- a/include/linux/maple_tree.h
>+++ b/include/linux/maple_tree.h
>@@ -463,6 +463,7 @@ struct ma_wr_state {
> 	void __rcu **slots;		/* mas->node->slots pointer */
> 	void *entry;			/* The entry to write */
> 	void *content;			/* The existing entry that is being overwritten */
>+	unsigned char vacant_height;	/* Depth of lowest node with free space */
                             ^^^           ^^^

Would this be a little misleading?

> };
> 
> #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
>@@ -498,6 +499,7 @@ struct ma_wr_state {
> 		.mas = ma_state,					\
> 		.content = NULL,					\
> 		.entry = wr_entry,					\
>+		.vacant_height = 0					\
> 	}
> 
> #define MA_TOPIARY(name, tree)						\
>diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>index 21289e350382..f14d70c171c2 100644
>--- a/lib/maple_tree.c
>+++ b/lib/maple_tree.c
>@@ -3545,6 +3545,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
> 		if (ma_is_leaf(wr_mas->type))
> 			return true;
> 
>+		if (mas->end < mt_slots[wr_mas->type] - 1)
>+			wr_mas->vacant_height = mas->depth + 1;

For some cases in rebalance, we may split data into three parts, which means
we need 2 extra vacant slot.

Maybe this check is not accurate?

>+
> 		mas_wr_walk_traverse(wr_mas);
> 	}
> 
>@@ -4159,7 +4162,9 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
> static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
> {
> 	struct ma_state *mas = wr_mas->mas;
>-	int ret = mas_mt_height(mas) * 3 + 1;
>+	unsigned char height = mas_mt_height(mas);
>+	int ret = height * 3 + 1;
>+	unsigned char delta = height - wr_mas->vacant_height;
> 
> 	switch (mas->store_type) {
> 	case wr_invalid:
>@@ -4177,13 +4182,13 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
> 			ret = 0;
> 		break;
> 	case wr_spanning_store:
>-		ret =  mas_mt_height(mas) * 3 + 1;
>+		ret = delta * 3 + 1;

Hmm... I am afraid we need to put this patch after next one.

Without the change in next patch, we still need to go up the tree till root to
rebalance.

> 		break;
> 	case wr_split_store:
>-		ret =  mas_mt_height(mas) * 2 + 1;
>+		ret = delta * 2 + 1;
> 		break;
> 	case wr_rebalance:
>-		ret =  mas_mt_height(mas) * 2 - 1;
>+		ret = height * 2 + 1;

Looks current calculation is not correct?
If so, do we need to have a fix to be backported?


-- 
Wei Yang
Help you, Help me

