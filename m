Return-Path: <linux-kernel+bounces-379062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 763129AD924
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFBF1F22B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8681EB3D;
	Thu, 24 Oct 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJPF0EC/"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F5A29
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729732846; cv=none; b=b/x9r2GNWBrXvfJ69Ix4kHArMPr7dLO3GEsgMJ9iOAAgirhTi7tbeohbRcB6suw/r8rsCqjcOjl4hmcx3CmY84PaIND4lMrfgmvrbdxe/iwQaZV/DXhE/Mj+KmWkDzNIbVdniIVNCZoDm/IapfLjnzWdiJFPubBxJqkG63nFbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729732846; c=relaxed/simple;
	bh=v5iiawG+e96WWjqUUz00Elfp1d3XpOsUU+9Ii8/L8r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9ZP0Segd0t6SOcJzjQXVz6x41zWT85dE6gnwb5vS2oxXX3hVbPLO+SUwkVr0YqYfVrEbK5AwDFbm2w0bjIYwSM4z1jL71471+leeG9YrSZONT5qBbd7YNwduyt/j4EcgZtbczsscrkIvhAD9vPGTDbE2q4LCuxxAUJ4CtZLppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJPF0EC/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so191715f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729732842; x=1730337642; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW5s0ts3emXbAO6ktoSaK2rpBNc0+jdR3nk1YUAiJOA=;
        b=PJPF0EC/deG4mOvsYCOT/KDLbwrejegcB/+uRg/Hr8qbDaWOYF5KBbeYVbDsHMXz5w
         kSv0kLZp6z6qxm7Mkl8qYf6Q0/VhdMtB4T/zp+SgLBGANVjiSFRhHf/WZ+OWZa8h8prb
         lbuHNZDkP4vhuNiR5gH4Ot5NgCk+kvPQvNvKixJ6uOucAW9o/Mfm/igp1sUXG6mjrnzx
         vHPNBYLutWNjf1x0NPY55nd6ZnkMrMHAGSMGmdv2cNCbj8eVIE0oAw0HWlSAWZe5sGYF
         OPoQfos2/YnS5DcWxETw30+fB+RQTWlRXnw8FJB8mrfOXvHMbGhAu2HVgdc+d9HgmzW7
         v3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729732842; x=1730337642;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LW5s0ts3emXbAO6ktoSaK2rpBNc0+jdR3nk1YUAiJOA=;
        b=BvrL7agkej5HmQo/E3pDKzHVcA5tLe9nAiLsbJnnCFxDeexI/iOnUj5cK7JZctbFvT
         cb96YqF65wpymSUr2ONrgPJb93UAcaXgw6hAeWgnQcj0KybNrPx9jhHUTn46peX2aq13
         ntzOXJlMlcJ/2t2+mT28FK4K1jvBqlT5qF2/Kyu0A9OezkP7zFwQZT8Kl+3pom9S/fXF
         iI8RO/++r2IjIgFDwWZmoiuMEJpe54E6MxjzX5iOO4aLtouOj2e0j0thW4AY0s5cZThq
         fzrrsguelkqB3HSa15TyPx3CKOnKLUxWoAFMdJaaFkW3Nut/6J2HubiH5gGqPbkNjzz1
         ibvw==
X-Gm-Message-State: AOJu0Yx6R13Eg7zmnlUFSGRr0mkpfFEWvHQWFWCYqjMHkpe+jDxJOBC/
	scIpat/P9zZIEmMDlhMEnpBxJj+fCmKhN2rYH7G3vKej0xTg+kvX
X-Google-Smtp-Source: AGHT+IEo4g1u2FNmLLJkzwzUMo8Asoi2Ziinj7nHCIeWeufUFc+rLd3+DKvMOLce/onIHXTPndiI7Q==
X-Received: by 2002:adf:fd8d:0:b0:37d:4125:5cba with SMTP id ffacd0b85a97d-37efcf2e89cmr2606343f8f.32.1729732841949;
        Wed, 23 Oct 2024 18:20:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a6a491sm5083154a12.44.2024.10.23.18.20.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2024 18:20:40 -0700 (PDT)
Date: Thu, 24 Oct 2024 01:20:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com, willy@infradead.org, surenb@google.com
Subject: Re: [PATCH v4 16/17] maple_tree: remove unneeded mas_wr_walk() in
 mas_store_prealloc()
Message-ID: <20241024012038.zf3dpqsflnyi4wce@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-17-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814161944.55347-17-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 14, 2024 at 12:19:43PM -0400, Sidhartha Kumar wrote:
>Users of mas_store_prealloc() enter this function with nodes already
>preallocated. This means the store type must be already set. We can then
>remove the call to mas_wr_store_type() and initialize the write state to
>continue the partial walk that was done when determining the store type.
>

May I ask what is the partial walk here means?

It is the mas_wr_walk() in mas_wr_store_type() which is stopped because of it
is spanning write?

I may lost some background, so the assumption here is mas_wr_store_type() has
already been invoked and the store type has been decided, right?

>Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>---
> lib/maple_tree.c | 18 +++++++++++++-----
> 1 file changed, 13 insertions(+), 5 deletions(-)
>
>diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>index 8c1a1a483395..73ce63d9c3a0 100644
>--- a/lib/maple_tree.c
>+++ b/lib/maple_tree.c
>@@ -3979,9 +3979,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
> 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
> 	else
> 		wr_mas->end_piv = wr_mas->mas->max;
>-
>-	if (!wr_mas->entry)
>-		mas_wr_extend_null(wr_mas);
> }
> 
> static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>@@ -5532,8 +5529,19 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
> {
> 	MA_WR_STATE(wr_mas, mas, entry);
> 
>-	mas_wr_prealloc_setup(&wr_mas);
>-	mas_wr_store_type(&wr_mas);
>+	if (mas->store_type == wr_store_root) {
>+		mas_wr_prealloc_setup(&wr_mas);
>+		goto store;
>+	}
>+
>+	mas_wr_walk_descend(&wr_mas);

This one does not descend the tree, just locate the offset in a node and
adjust min/max. So not look like to continue the partial walk to me.

>+	if (mas->store_type != wr_spanning_store) {
>+		/* set wr_mas->content to current slot */
>+		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
>+		mas_wr_end_piv(&wr_mas);

If not a spanning write, the previous walk should reach a leaf node, right?

I am not sure why we don't need to check extend null here. Because we have
already done it?

>+	}
>+
>+store:
> 	trace_ma_write(__func__, mas, 0, entry);
> 	mas_wr_store_entry(&wr_mas);
> 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>-- 
>2.46.0
>

-- 
Wei Yang
Help you, Help me

