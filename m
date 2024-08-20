Return-Path: <linux-kernel+bounces-294553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A787B958F28
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650C5284AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 20:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB71C0DD2;
	Tue, 20 Aug 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FzZsSiNi"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00B14B94B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724185376; cv=none; b=dQF1MpsMYscYuDEtWvzXcjbXsMz3WReHBYe0lTf+67xuf6Vy9hx7v05WFxYjRhe2cLFAhsjjX7o4j9pND9P0fQxvqbuwJ3d5broMF8LFa21yIdbLCNptupON1myADMqRNfgOhvubVUOmjiY/ekLYLMmSCvuJ0untzlKhyPVolvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724185376; c=relaxed/simple;
	bh=E+kXUwICZYj2HydsIt5fBb+0o9o/27hUbjZYZRkzVD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqDez3NkgW1gGngeAyi7sbQEaL6UwvRBVo8lbYI1F4FbR0LbKyE96PZR9r+5n6TGDmYOkeC549Yg2Aw3tFa7a/Ars7REJzMJ2NSV0e377QICKJB8ggtqxl/tYCOOmxWlrIUYFbzMBBKzfKj0HKLnFgGvfszsPUauBO49/4k4IeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=FzZsSiNi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c3e1081804so3928823a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1724185372; x=1724790172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF1xGAzBc+XfrnIu1OYyumZPOyMqmVIc0vNTJwylp/c=;
        b=FzZsSiNiiHRJb6SBmzZcPb/FCH5SuK9YvBKiirHPKah8fL+0eXbpZKe4gB3f/h1L2j
         GWo2VfvBb+2qmTY1No3ActH5q//Z+b//6YxOJc/bFZld+hvIT3/E4USX5tkCugBQ4x+z
         Ju1uHaXHvdiWYhv5yVArgCow0GbuwRp9bQ5EEytL5Tb2oj0OHwl7uobw9NSrvysF5glJ
         Gf2x1jdhxjxQLpaSDZfIeH0Bj2YXaazMtU/zDr/jwevjm0nkWd9riFZtaUPJrMT3/9nJ
         7Xzah2A8FoLqYPI0fZE7BCfhEC1veY03C9CTeJAgtCQbjsG7SukLC60U/jtPQayuY5de
         /nqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724185372; x=1724790172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF1xGAzBc+XfrnIu1OYyumZPOyMqmVIc0vNTJwylp/c=;
        b=NhssVJ5QA6s99ES0ULDxGSsBJHEOljnSHNXNfLZNgGVu5FanXBep9tBatq+k+90dxv
         7+MVK0dYaJeHSCYLao0Dwb4kq63/vTsdojr67hgJVQoIxSuO39u4YZyBtkjqprVeC7Zz
         GU9e+yPiJE9eCMegwdiNXtTEWQALVwIvNlRu5JOkRbahzsnLjHPLcTUUlprblCnlZ+4g
         fJcU+RPUEn3xEkJrEJamxltRglucGT9wtU67LhEAw9IyKZzHhCswXNehGvjP++ydXmIQ
         hlq6EszSFHRA9TFYF9JqR9GJ+Agjw/FIUtYixSpTnJnw9LQphXxFi9EUYU7NLR6e6zOG
         GA4A==
X-Forwarded-Encrypted: i=1; AJvYcCXTFjEPYk54WfQu2R4IlStGQ2HrV6v5tfqZXm3abZN0O1tjCRCNB8FG9D4Xo6LlYAuEV5YHx/RWaBqlPBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47SB73DjS9++M3KC3YS814qpIU6xl9YM6SagvQJfb93Osj6KZ
	pcSL17ZECX45jjF1sioiInxySZp89u08M9g98gfjiWjr3Hv/Pzm41XlYLwnPSik=
X-Google-Smtp-Source: AGHT+IFKLaWCI6pTbg4pWG94rAcL0fmef+3g+t3F0g+/j22778SV3QfJxKbW/f6NTPaLJkCpG2fINw==
X-Received: by 2002:a17:90a:e147:b0:2c9:7a8d:43f7 with SMTP id 98e67ed59e1d1-2d5e9a43943mr115861a91.23.1724185372511;
        Tue, 20 Aug 2024 13:22:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5c2e163a8sm1371608a91.1.2024.08.20.13.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 13:22:52 -0700 (PDT)
Date: Tue, 20 Aug 2024 13:22:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Budimir Markovic <markovicbudimir@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sheng Lan <lansheng@huawei.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netem: fix return value if duplicate enqueue fails
Message-ID: <20240820132250.28bd507b@hermes.local>
In-Reply-To: <20240820154213.GA1962@kernel.org>
References: <20240819175753.5151-1-stephen@networkplumber.org>
	<20240820154213.GA1962@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 16:42:13 +0100
Simon Horman <horms@kernel.org> wrote:

> On Mon, Aug 19, 2024 at 10:56:45AM -0700, Stephen Hemminger wrote:
> > There is a bug in netem_enqueue() introduced by
> > commit 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
> > that can lead to a use-after-free.
> > 
> > This commit made netem_enqueue() always return NET_XMIT_SUCCESS
> > when a packet is duplicated, which can cause the parent qdisc's q.qlen to be
> > mistakenly incremented. When this happens qlen_notify() may be skipped on the
> > parent during destruction, leaving a dangling pointer for some classful qdiscs
> > like DRR.
> > 
> > There are two ways for the bug happen:
> > 
> > - If the duplicated packet is dropped by rootq->enqueue() and then the original
> >   packet is also dropped.
> > - If rootq->enqueue() sends the duplicated packet to a different qdisc and the
> >   original packet is dropped.
> > 
> > In both cases NET_XMIT_SUCCESS is returned even though no packets are enqueued
> > at the netem qdisc.
> > 
> > The fix is to defer the enqueue of the duplicate packet until after the
> > original packet has been guaranteed to return NET_XMIT_SUCCESS.
> > 
> > Fixes: 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
> > Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
> > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> 
> Thanks Stephen,
> 
> The code changes all make sense to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Reported by doesn't really do enough credit here. The commit log is from
the original bug report which had more detail. Fixing it was the easy part.

