Return-Path: <linux-kernel+bounces-358326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62FE997D33
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EAF285CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21911A0737;
	Thu, 10 Oct 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJbFZmbd"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2233CD2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728541729; cv=none; b=gxremnCgYenAKlMDQIuOSpxw+8t8FIJ0TOOwNhE2OX3dyEW/KVSzsKQXJONM6aQHz4kyGFQB/6Lca3m1eNUsefX1ZIDXKxdaV9Yb65noqpmSSZF55qYiO+VHAvIij1Kw0nxJpaPj7poURadqhLFInITj43/Dr+TrnCgm8dCRBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728541729; c=relaxed/simple;
	bh=Ud6a0AcXSkNN5SehkfF9Thgf/ouNbtxcshiTNmNn82o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nl/qG5OKFBh9b74WkZrwv/NqtHoHdstUixUDKC0ue/k8573qLhN14Fuvr//HB8yxYIM6qw54NUmRWIQuCVUfbgiBYSgASGg1mRbePm0fdp/78K0grL5EceqiVbP1lvsJ8uPD7rs6hTisdcBOTRfHVv7pYKBWC0GTkMdmuKSUeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJbFZmbd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9951fba3b4so91212166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728541726; x=1729146526; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQIRk9er/7JER8ZB4cm93/qw+JSPkCedJXj2bvL9sTE=;
        b=MJbFZmbdFovUEakN3pKtLuyxT+/CyuOYisnZL4fEWbzWfRij1hHc7OzqUNyZ9a2iSn
         naDkcEGujlhOviVogT5g70WbaPBpD4gcY8qLH9v/GaJUUOFHyP4bqFfthHHLNjIjQNri
         YIwoftWmNs38vNq/Wc/lmGB12J4xQygooXPCoJ9mDfAsMYp+kWUAadFC7KQfSoVI0tPz
         AO1VOcs1bWwHlIurTkg/WetHfgKMeDo2kPojv39OTGYje0/Zhn1A2OFqNRxJzpuNsOru
         fnr02LYxBSMyLccs04ZXPAWdppSkekKNa3FMLe4JQiob/EfP4vecIFhpCj8KF0ykb7Fn
         TXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728541726; x=1729146526;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vQIRk9er/7JER8ZB4cm93/qw+JSPkCedJXj2bvL9sTE=;
        b=qKd1wqcJy9vGfH74X1PtKoOCWhtq4syZDYo6BeB8llbJul+a9yi4v2918NJe3TNzBU
         8vv2CzFAQ/tZaWDZKQMuCTMSsnxVBE6nGm6hHDxUekOjZXZxENEgtlwwRvPn3KMycwrn
         xfBuxUVPjnwACv0Ryj2DJquO1HfkdtDNcrGlXK3A+7UQVZHKGLniAZmxx8eDLnu3pVOc
         RrGqQ396EgNETOkmWw7fdMfM2LVXA5DbpsG21dsLFYznW2hYIyPVRbuBFbXOWfWnXK1D
         rEatJzmHS3vWlGSSAWAxy9VcpTuzJyFp5uZu9Rs0FkbuF6rTP7H+9BY7MwaTFmKGoEXP
         Yj3A==
X-Gm-Message-State: AOJu0Yz5fX+TcDTCWlu85pbY3sME5KpGa5kV+rxHMMsR/3w3B0u/uxn2
	Pvlv54UxJ67e7H5R/bMVmu3fac5fVUaa0lpT0YC3Os0LuiEGp6QB
X-Google-Smtp-Source: AGHT+IFMuVT3IEB1d/RlM1JoMKQlmjt2MB8ypTxZGTx0a7hamvKO0j6NZYswS1fnDDP3LOo01bemkw==
X-Received: by 2002:a17:907:94d4:b0:a8d:250a:52b2 with SMTP id a640c23a62f3a-a998d114bbemr388572366b.6.1728541725498;
        Wed, 09 Oct 2024 23:28:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f21f5sm39299266b.202.2024.10.09.23.28.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2024 23:28:44 -0700 (PDT)
Date: Thu, 10 Oct 2024 06:28:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com, willy@infradead.org,
	richard.weiyang@gmail.com
Subject: Re: [PATCH] maple_tree: remove conditionals to detect wr_node_store
Message-ID: <20241010062844.vf4pyrd6isfddwo4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20241009152007.2096-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009152007.2096-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 09, 2024 at 11:20:07AM -0400, Sidhartha Kumar wrote:
>From: Sidhartha <sidhartha.kumar@oracle.com>
>
>In mas_wr_store_type(), we check if new_end < mt_slots[wr_mas->type]. If
>this check fails, we know that ,after this, new_end is >= mt_min_slots.
>Checking this again when we detect a wr_node_store later in the function
>is reduntant. Because this check is part of an OR statement, the statement
>will always evaluate to true, therefore we can just get rid of it.
>
>Suggested-by; Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>---
> lib/maple_tree.c | 9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)
>
>diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>index 4b423330d83c..f5a12d37b352 100644
>--- a/lib/maple_tree.c
>+++ b/lib/maple_tree.c
>@@ -4252,14 +4252,7 @@ static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
> 		return;
> 	}
> 
>-	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
>-		(mas->mas_flags & MA_STATE_BULK)) {
>-		mas->store_type = wr_node_store;
>-		return;
>-	}
>-
>-	mas->store_type = wr_invalid;
>-	MAS_WARN_ON(mas, 1);

If my understanding is correct, here is the only place we assign wr_invalid.

So maybe we can remove this definition?

>+	mas->store_type = wr_node_store;
> }
> 
> /**
>-- 
>2.43.0

-- 
Wei Yang
Help you, Help me

