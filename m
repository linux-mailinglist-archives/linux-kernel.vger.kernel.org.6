Return-Path: <linux-kernel+bounces-573765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B8A6DBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C620816896F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A625E444;
	Mon, 24 Mar 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GxonC7VQ"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE312505C3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823839; cv=none; b=jNUuDespWVVkewiNlYVF6QItrBntShbKSutqgcG4qq7jXmM7BBfRwhT3v5RCTEn/nQwDYK4yfXh8MRV+Ts1lZuJInJdHCnVh8TeTQcK9rFbR2wrduzEajrc/P1atJTFsgxwhP7vAetKiwMr+uBZzyMHxa9+GBjVC+KeZvK8ZfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823839; c=relaxed/simple;
	bh=1xNZlSVbNDoJPRjUb5MwLSBNNaLvxA65XB62/kSkR9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJtt87pf1g+PwzxkwfEKHv3xhFUCfd5voqwIDyeLGFEPcrMOqAShvspOfmjNSFty6MMTXq8dNnbWHFfDuZh+2U3yhNXKR1FkxK5YJXq0uVoRhxmvsI3SuVZrQJfPR9BSmefOr4cjxAFUt7EnScQLi4l/4CD/vrB1UtWPydPagvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GxonC7VQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c08fc20194so929323885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742823835; x=1743428635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vGW53LfyIVcfMlHvMt/kyxY4rw5TXGHD2Z6PF0btLwM=;
        b=GxonC7VQfqVjdahd80EeR03ZNTV04FhyqxcCafMDwOzh6rrvWQW88W6r2ujLEIlLdq
         yXZD9yHtta/bJ6OmQ11bypQMwf3jb2kToQCYSPoPCDerjwL88LnIN2AYiQ9ltbDVtRrq
         tn+Uu7QSFSCpTzpfl37mQLAv04wbNTLCr+WLcBx4yjwdRddkh0W5DXqWgIIVxrkLA4g8
         np35uJfQSOSEBvq2JNcE0Yi6FseBA1uOxOwXEpGACFZd3oOqtg+WdacOIAlM8amSip5w
         Q5/Llxw4J4J2EmyddATdkiwNJEcaeM7hs8WYZvR7QpRDLaO9LVAYF7Yw/MpwLtijElos
         Tqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823835; x=1743428635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGW53LfyIVcfMlHvMt/kyxY4rw5TXGHD2Z6PF0btLwM=;
        b=hCzZQr27wp6Jh9Ccqr3drJeuASphDnuni3ClGY4f6/BnqT0ozmY4a0ZxwD/N/F9/df
         +6+6Wxkcn1qJM2uOmaGXbVccvzT5yuVv4wgHoqkoxAOO3ffu6vQEOvENWzKBVkrxvFKJ
         0GGqQTHdK/0nsyqxzg9e+jvw0Oz6kW7l6ya++johmlLzSgRrNKfrZj0RxkYj3iXE2Org
         Rrn17WMCk/24Fqu1O1D7Lo/D7bSQ1CUAqYIV+BSj8Lht/KdhL8KkzpzwBOQeyR0lTjUa
         OCKBqK5OAHR1geM0UNFaI33UTyhSwRxhAjlXc4B9IUORQumqApeBGoTfG3aZeNf2lbZc
         b5Xw==
X-Gm-Message-State: AOJu0Yy4jyIAeXBg/PCQtwH6HMcyVfUfpMhnJY7a+7R2A/JYrGPiY/y7
	sv190Yb2FMaCWy8YncT9it4OWLYswigR/G3YVGdQTmFmBYo/JblSdo3CE3bAQlQ=
X-Gm-Gg: ASbGnct8yxLuZoRPdQVnasG11hWKQYySoX5CXqajWDosq3y8U3fCtVM4J+GKbg3X3S9
	04QolpJAhYLH/PoP5OUM7DJKvKY+Y5NDZIVSUCL7fM7O92r8f03tKq3O1C0CrS88I1AAOstFap+
	cilD3zkzXMxldiUTEaxdhOYFMrsIoSYOsjHTrrtKsoVLKLxeusjzNbCH7eNRbgu1IfkYFzfEul3
	umJ8DNyNkellcR9HwflRr4Anuiz3VbtIYwsLPa/VhKeR/BMUBCnRTOvkA7SBFy/46l6WNsiYZta
	bCZwyVDWRDG+LC8SkHIfAjW3Fg6dSlb56nTmrEw4vop2Z1qdRMsVmw==
X-Google-Smtp-Source: AGHT+IH8FMzSfvRHQLrikh/cxN2juHwustpDdgjWn8aSD//4Ho2J2tvUAcurpDqW2WXUj0eQ9aDqjA==
X-Received: by 2002:a05:620a:f05:b0:7c5:9fd3:a90b with SMTP id af79cd13be357-7c5ba235ba9mr1867116885a.47.1742823835257;
        Mon, 24 Mar 2025 06:43:55 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5cf74e3cdsm163064985a.18.2025.03.24.06.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:43:54 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:43:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Bharata B Rao <bharata@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	AneeshKumar.KizhakeVeetil@arm.com, Hasan.Maruf@amd.com,
	Jonathan.Cameron@huawei.com, Michael.Day@amd.com,
	akpm@linux-foundation.org, dave.hansen@intel.com, david@redhat.com,
	feng.tang@intel.com, hannes@cmpxchg.org, honggyu.kim@sk.com,
	hughd@google.com, jhubbard@nvidia.com, k.shutemov@gmail.com,
	kbusch@meta.com, kmanaouil.dev@gmail.com, leesuyeon0506@gmail.com,
	leillc@google.com, liam.howlett@oracle.com,
	mgorman@techsingularity.net, mingo@redhat.com, nadav.amit@gmail.com,
	nphamcs@gmail.com, peterz@infradead.org, raghavendra.kt@amd.com,
	riel@surriel.com, rientjes@google.com, rppt@kernel.org,
	shivankg@amd.com, shy828301@gmail.com, sj@kernel.org,
	vbabka@suse.cz, weixugc@google.com, willy@infradead.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	yuanchu@google.com, hyeonggon.yoo@sk.com
Subject: Re: [RFC PATCH 2/4] mm: kpromoted: Hot page info collection and
 promotion daemon
Message-ID: <Z-Fhl6rLJH2wweGC@gourry-fedora-PF4VCD3F>
References: <20250306054532.221138-1-bharata@amd.com>
 <20250306054532.221138-3-bharata@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306054532.221138-3-bharata@amd.com>

On Thu, Mar 06, 2025 at 11:15:30AM +0530, Bharata B Rao wrote:
> kpromoted is a kernel daemon that accumulates hot page info
> from different sources and tries to promote pages from slow
> tiers to top tiers. One instance of this thread runs on each
> node that has CPUs.
>

Hot take: This sounds more like ktieringd not kpromoted

Is it reasonable to split the tracking a promotion logic into separate
interfaces?  This would let us manage, for example, rate-limiting in the
movement interface cleanly without having to care about the tiering
system(s) associated with it.

    my_tiering_magic():
        ... identify hot things ...
        promote(batch_folios, optional_data);
            -> kick daemon thread to wake up and do the promotion
	... continue async things ...

Optional data could be anything from target nodes or accessor info, but
not hotness information.

Then users at least get a clean interface for things like rate-limiting,
and everyone proposing their own take on tiering can consume it.  This
may also be useful for existing users (TPP, reclaim?, etc).

~Gregory

