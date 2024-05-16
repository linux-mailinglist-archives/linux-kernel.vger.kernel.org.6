Return-Path: <linux-kernel+bounces-181349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53328C7AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7015A28478A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916415099A;
	Thu, 16 May 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYgeVVfL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE97150986
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879351; cv=none; b=maSaR5khQrdusTM0zbSTF2J7gZRbbXaBRvTIflv03QLI+JB8hcPs9KVs4bhbhpuWwmWRQAjTE5TPqV3mn1Vqz7LoZ1jRILORLv4op3dXhTAz8Wsigf6bWDe2PsdsdJLGOKIEFTs18lqDEPsutKfpKPea5Vhzu5jeY/OVtLHvDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879351; c=relaxed/simple;
	bh=ggqDzvuVW1SHkSUQXE4l9nUzsTTuNXRFUH7lMDjVhHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uxdmn6kFUZcAnmeMCMcok6P9Pdb0ARNA2uopYF2a+aQQT8XSEQym+dkBqqM/BvIGELdROpKRIvExVJO3H/h1WJxfJxOdQ8JUbKvf/4Az907EEexymow+W4rgHxFJGu641GUIt3OOfDV3MdBIOSgrdmQVHNVmQkf9IJicuQHgT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYgeVVfL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715879348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ggqDzvuVW1SHkSUQXE4l9nUzsTTuNXRFUH7lMDjVhHs=;
	b=eYgeVVfLK73mmJbQHupLSOfJPl8LacWYhghJL4t2EtTKo4B3kxNhpJ9rCpbuAd9BJKdRib
	0WUF9FZq3fqhCQKdPjScqOWLHBQiNHaEkckA1Jfc5gYs7PfzOnktmANZ47Fk9ps/Jl1QmV
	OF4psDRZVO5YZPAf5+5RVavcYbE6w3c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-lfXInM7nNVCUnQa6ZARqVw-1; Thu, 16 May 2024 13:09:07 -0400
X-MC-Unique: lfXInM7nNVCUnQa6ZARqVw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43de409b742so96314541cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879346; x=1716484146;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggqDzvuVW1SHkSUQXE4l9nUzsTTuNXRFUH7lMDjVhHs=;
        b=qwO6B6TLLITi3eQSD8rni4cCnmc4Gv1KCEHzuEh2AzGEw7ZcLEHzKr2Tj2xk41yeRz
         JsNxRnZ87VrBfcCRCByZizDPoNffZ0HXs3ldIdjpSz4mA1TUqTQrGpbZcHZccX/z1G6M
         hB7UFIiRXh99widoQ0LqdqheyLDFwtsNsCniVpksrQ4o9Hs4FlWI9Sb60yyPBoOjqrZk
         jjsopTjr9A/P+SzZY+OtdAkkBOOdoB21zWaoJzfZTxMUmcSJuOKMhKupe+5tfwq4hlF+
         WEYCcZkTmnUwlu5h/lp01nqXvsugvno20RXrNE+l/c9Fcctl9EtK7eGi7rOQBp1RNomA
         /V+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqqwbmpMDd1x6bC6WrRHC8B5NY6lACUZlpXxtQHLBGFzhLbW2bqqM7OdlO47Qt0oYyoq1IR8LU3oakQxMN+DQgAz7ufysYmr0fu6fl
X-Gm-Message-State: AOJu0YyPFZOkQ+JSQ54wcVV6OxXBDhWM+oRyr9XFZtSsYetEdf2EOMPz
	qfu6rTuVf3hijoeXKVfZgoSZ58f03Jg1GpVa+rCpNKVb1BRqGVHY1Quv0sIevn6KC/mkRLsa61B
	HKkMFVGlka08PW0YMAG4/g7DwSoRC/Z3iHeTHbpsfsa23bbPzoB48EA1xGgamMA==
X-Received: by 2002:ac8:5f14:0:b0:43a:f80e:152d with SMTP id d75a77b69052e-43e39de4d06mr35882321cf.3.1715879346447;
        Thu, 16 May 2024 10:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/hHZD2KBy4CA1qH/yOuRUaMV0t3df96/5rdOec225fHrAbhTa1WL7Klbo7MwTrZCrT4Qynw==
X-Received: by 2002:ac8:5f14:0:b0:43a:f80e:152d with SMTP id d75a77b69052e-43e39de4d06mr35882071cf.3.1715879346054;
        Thu, 16 May 2024 10:09:06 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56ddd77sm98217861cf.92.2024.05.16.10.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:09:05 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Joel Fernandes
 <joel@joelfernandes.org>, Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
 Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 4/6] rcu: Remove full memory barrier on boot time eqs
 sanity check
In-Reply-To: <20240515125332.9306-5-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
 <20240515125332.9306-5-frederic@kernel.org>
Date: Thu, 16 May 2024 19:09:02 +0200
Message-ID: <xhsmh8r09hefl.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/05/24 14:53, Frederic Weisbecker wrote:
> When the boot CPU initializes the per-CPU data on behalf of all possible
> CPUs, a sanity check is performed on each of them to make sure none is
> initialized in an extended quiescent state.
>
> This check involves a full memory barrier which is useless at this early
> boot stage.
>
> Do a plain access instead.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


