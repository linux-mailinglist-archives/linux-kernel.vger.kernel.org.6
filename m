Return-Path: <linux-kernel+bounces-352893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B549925C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315F0B237DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BD3185B7B;
	Mon,  7 Oct 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0Ylmttr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583916BE14
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728285176; cv=none; b=NZqcQLIU9d4bmM1xytIbKN2a1+mvzM+PfNGPZzyMdifyh7PJ//qTdkouKReuliP3t3fIWRKjHh7HwXzd802Kj9bDfRzjOT3h7tZbhB82KmgZKnk/huUnn4FGAgT/8P5BldsRb3AG7no8wteIikyp6fgPh47O5X9+2B72cz1xP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728285176; c=relaxed/simple;
	bh=EdpuchUqnY+j8ggVbTp5O+dRlywTJpHecf1+zLfiBPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCCuES4EnuVkmcwy47WoMpFDpXZHnXZHCCx7mIXoaf2nGtH424TaKf1Zi1Ul4ztKsVLCgaFNtdqD14m5/8BOW9okfwkMq/I7oFllZlbWvdJWVYl6n1iGhBlvcy+dr9GhFIRgxDc/tQXFlNcXrUKIqkfa7JMQhircY1zNpDBPPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0Ylmttr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728285173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4X6L+Pljqxo0bn7m3zwsJ4JqJiLb+y9qwDXNwJCKk28=;
	b=N0YlmttrLAR4hgrzF80D1N89guqVk5FofmI5nQtPKWMjRy0BQxFTnPTfmXL7UVMbqHfB7u
	DxZMU6UERIwbqmaVgzKyMbbvZ07A/m9cUuab5ExVJWedPkGj5LaSe9hgVTSsCntMh6dIPt
	3ksIChUx9nPOTge7qrPOmJzrBbLkrUM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-MmR2_9Y0PXKHXZSoqqWH8Q-1; Mon, 07 Oct 2024 03:12:52 -0400
X-MC-Unique: MmR2_9Y0PXKHXZSoqqWH8Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb479fab2so22028515e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728285171; x=1728889971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X6L+Pljqxo0bn7m3zwsJ4JqJiLb+y9qwDXNwJCKk28=;
        b=b+KNDKKA46zAOMBDcsVsJKNo6mYvKXKU+t4hxluveZfU8YoQ+gYEuhqOSi2rmNhlWP
         /q8ls7L815s7IPx3Txq6vuyymiskcL2l7mw7VOZiRtQ8indoGeR/2lL+duazyI1KcyTc
         cnWsNtD4wDuOpumNe8oQEZW+p0tfPvEw2tghriKPqCon/xgb9HJvl27EmmyQbbjA2JeP
         IIdcGdNvTQVmBX0w3HyqzRyGORNZY6cR3/VFeNP5BoAQa4XQbqj6gVkvY8BzU6WQRUb6
         oq5kCLAgBZwOnEBcZqifhB6ohaG9dRYURJQcyMiZL2BR9kIhURLjn70Q/4TzRT8myyhB
         PmJA==
X-Gm-Message-State: AOJu0Yyx419ubl22oO18448wDaUpYYFUrzGaYjsWb5Zb7VfEK2fj290o
	U8PD9ovynYgkT9yeAmiUqqesu8k7NwM65xcVp6k36I1Zp3HKYMuqH7CIXqmMuuM/ZEoVTHbSU4Z
	KwaC6uIQ58OJ7u0Fa/zl3jWafyi7SJqlAbnAyGXqPMJ6JCOXf2f6o/vjzXSlRiUoHLceUWQ==
X-Received: by 2002:a5d:5b85:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-37d04a7b2f1mr7981314f8f.28.1728285171119;
        Mon, 07 Oct 2024 00:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkwwGUiO7eIfF8ndcWqyQ/Z1SV4ikrsYmnpU3sdjvoR/qb88g72qzcTyNfOthoCxSu97G8Vw==
X-Received: by 2002:a5d:5b85:0:b0:374:c33d:377d with SMTP id ffacd0b85a97d-37d04a7b2f1mr7981303f8f.28.1728285170701;
        Mon, 07 Oct 2024 00:12:50 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-206.as13285.net. [80.47.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f24fsm5037507f8f.1.2024.10.07.00.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:12:50 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:12:47 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/deadline: Use hrtick_enabled_dl() before
 start_hrtick_dl()
Message-ID: <ZwOJ781mpF137oT2@jlelli-thinkpadt14gen4.remote.csb>
References: <20241004123729.460668-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004123729.460668-1-pauld@redhat.com>

Hi Phil,

On 04/10/24 08:37, Phil Auld wrote:
> The deadline server code moved one of the start_hrtick_dl() calls
> but dropped the dl specific hrtick_enabled check. This causes hrticks
> to get armed even when sched_feat(HRTICK_DL) is false. Fix it.
> 
> Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Indeed. Good catch!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


