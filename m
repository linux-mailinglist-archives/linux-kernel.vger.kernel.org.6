Return-Path: <linux-kernel+bounces-337900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A649850D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 04:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5799BB215AA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD824136672;
	Wed, 25 Sep 2024 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWoJojZh"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2422907
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229879; cv=none; b=k75TsD9e2oc+pzuL8UVbZsekIjXqy4thZMwXLMTZD5ueQZiM5aZCaAn5Zg7AL1wb8H5LGgP9oWlVRAz/1ugVBsXgkRlGgAnuiam9I+daV3qQEToyVvIzkoXuPZakcg2MGlZncF/nb0BuI+SSWKP7xLX7broRgHa5OOioEh7az3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229879; c=relaxed/simple;
	bh=06wk/Tlf+Bby/yFKfYGc3wTiVwIiam0YQcS4rttyljM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAiD19dEQe/FJJKWqosThNyiiSX8Js4SC7Mq1/1+PexZGJ8wJUhhRiKssNvfbBN8eia6R8OS8vdIhkhMSj0fXq09dGmFUomRwFPEu6ny72kLCutvJJUHYnRqHIRgs5rEUhJ7F8E7jgV002WTIGVJVDywtvefFrT02nbHQt+tTEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWoJojZh; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365928acd0so2788626e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727229875; x=1727834675; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBgutzjDfOgDhfPJb/VqZ+KjGDGotu18ULGDFcekRCk=;
        b=hWoJojZhLj25E/OiSx/QQ7XER2r/uwPh9NItUPz6RmtVubt7QzovSzElOfyDeE3Oo9
         HIBKQscNqLR2yn/+t8Wfw8LWuSZUZNxrpEfUAWRFVOzLOpUSDph8JG84EoIr9py4nsv0
         +TAVzVzPjj3G9aeqmfsIT2xWCZSLDey8x7TpsSe/+58mjEAHYwPMmWs2kUX0vYEdAQwt
         GlBfenTeO8Ed6nAFP7vx3OdI/EjL8v+4O4G2od6aTLALRGddsTUbK4RFNN9TemcUkdgb
         SEhK6hj7u8RYoKnz4/9/LMrqzJPuCIN9VYQFLbB369QeDpospzFTdzDqI/FFzaK2D+JD
         5GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727229875; x=1727834675;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBgutzjDfOgDhfPJb/VqZ+KjGDGotu18ULGDFcekRCk=;
        b=KJZP1pxlGstUKbVhyG315mhsI3oXsaP/JyFYvbUxF8sUHcFKtt37NP6caeSO9nbn8L
         P4dv6QjKN7emDKM9EQ2NlZrnpMP17xFmj2bHcu63osLakDRsqpJ5L4hIiq2o61cbuh/M
         jNO1rXxm0BZ1j4K02yadng0Pw1XsMKJL9I8wNF+JeSVeGyRGbiF6GSmK8RwMcbeq6HlR
         Xb0mLzl+2TIV/IaAW+4rn3q9rlEAflWgCyDmexrG2ib7fUulUNyKnYIidxggKbm9K1cW
         3/N3IUT2bcPG37WyAMb3pyUm23//zowIEGZoiDCeetLSeIoAl0J6qQFtCOkvclRUHj2j
         8oxQ==
X-Gm-Message-State: AOJu0Yyu/Qz09H7mS92It0LUgMyAM5bGqpV5h5rNhekDj3LWwmTiNHoV
	VhqMQZd9C4vapgiBMm7dFR8V8lkDalfrmIUF/poQcOq31cf2QjvkUD6vkeBA
X-Google-Smtp-Source: AGHT+IFCjPaZImuPumIH/zGWBtkHZ7XjcKsaZgbyp4TxJQSA7Fxxl4PuItGSboViP9fG+T4P1EmMaA==
X-Received: by 2002:a05:6512:12c7:b0:52c:818c:13b8 with SMTP id 2adb3069b0e04-5387048bb6dmr610863e87.4.1727229875207;
        Tue, 24 Sep 2024 19:04:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cace4sm154470966b.117.2024.09.24.19.04.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2024 19:04:33 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:04:31 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	liam.howlett@oracle.com, willy@infradead.org, surenb@google.com
Subject: Re: [PATCH v4 04/17] maple_tree: introduce mas_wr_store_type()
Message-ID: <20240925020431.joykmu4zzahoglcl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-5-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814161944.55347-5-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Aug 14, 2024 at 12:19:31PM -0400, Sidhartha Kumar wrote:

Sorry for a late reply, I just see this change.

>+
>+/*
>+ * mas_wr_store_type() - Set the store type for a given
>+ * store operation.
>+ * @wr_mas: The maple write state
>+ */
>+static inline void mas_wr_store_type(struct ma_wr_state *wr_mas)
>+{
>+	struct ma_state *mas = wr_mas->mas;
>+	unsigned char new_end;
>+
>+	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas))) {
>+		mas->store_type = wr_store_root;
>+		return;
>+	}
>+
>+	if (unlikely(!mas_wr_walk(wr_mas))) {
>+		mas->store_type = wr_spanning_store;
>+		return;
>+	}
>+
>+	/* At this point, we are at the leaf node that needs to be altered. */
>+	mas_wr_end_piv(wr_mas);
>+	if (!wr_mas->entry)
>+		mas_wr_extend_null(wr_mas);
>+
>+	new_end = mas_wr_new_end(wr_mas);
>+	if ((wr_mas->r_min == mas->index) && (wr_mas->r_max == mas->last)) {
>+		mas->store_type = wr_exact_fit;
>+		return;
>+	}
>+
>+	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
>+		mas->store_type = wr_new_root;
>+		return;
>+	}
>+
>+	/* Potential spanning rebalance collapsing a node */
>+	if (new_end < mt_min_slots[wr_mas->type]) {
>+		if (!mte_is_root(mas->node)) {
>+			mas->store_type = wr_rebalance;
>+			return;
>+		}
>+		mas->store_type = wr_node_store;
>+		return;
>+	}

After this check, we are sure new_end >= mt_min_slots[wr_mas->type].

>+
>+	if (new_end >= mt_slots[wr_mas->type]) {
>+		mas->store_type = wr_split_store;
>+		return;
>+	}
>+
>+	if (!mt_in_rcu(mas->tree) && (mas->offset == mas->end)) {
>+		mas->store_type = wr_append;
>+		return;
>+	}
>+
>+	if ((new_end == mas->end) && (!mt_in_rcu(mas->tree) ||
>+		(wr_mas->offset_end - mas->offset == 1))) {
>+		mas->store_type = wr_slot_store;
>+		return;
>+	}
>+
>+	if (mte_is_root(mas->node) || (new_end >= mt_min_slots[wr_mas->type]) ||
>+		(mas->mas_flags & MA_STATE_BULK)) {

The check (new_end >= mt_min_slots[wr_mas->type]) here seems always be true.

So the if here seems not necessary. Do I miss something?

>+		mas->store_type = wr_node_store;
>+		return;
>+	}
>+
>+	mas->store_type = wr_invalid;
>+	MAS_WARN_ON(mas, 1);
>+}
>+

-- 
Wei Yang
Help you, Help me

