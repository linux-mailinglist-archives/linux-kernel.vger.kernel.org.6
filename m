Return-Path: <linux-kernel+bounces-395154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783649BB954
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE968B22618
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2C1BFE03;
	Mon,  4 Nov 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHk87tLB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B5470816
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735219; cv=none; b=KTwJIA8jZXF3spAXrNnkyWVBjFA2pTH6qdO36Ic84dS1fiDKpTANJQ8+eNTA3pXvomXpI8pqZ/FOs6w3AzuKn5wogPWB3SizTEieHqyKvk8iS40T+jbcHzhH1BfvkqzLK1ZhO3aZCt8SuvJPDoFkLM1md6FwCUYrEautcbm0HwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735219; c=relaxed/simple;
	bh=cyh425pNXcQivIiwavEtYI0ranrZT4OUgdphHkKG6DI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7VlS/DXDVussalTh1qMAs16WacY0qfEGhOlpJBxwJNklCnZbDkYy4S+rt5lEf4qSc4dqhhHNmbAqsqDCEG/05gaTPWjNv8d5iqUOxAxrgbXcTYZZ4EFoIr24lVXbAB+J+Ss2r2CWoA+IExid7kFmhtQo6Qo/9grsajsU5k/5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHk87tLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730735217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh425pNXcQivIiwavEtYI0ranrZT4OUgdphHkKG6DI=;
	b=bHk87tLBlbGLVm5hREpAbXHWG/FaDTpaA92ZNmiauoc1zN+9z/BfujwYOifIHVUzSSSDcA
	PlQ/rnH1yHl3H+DQANqHYAZHZ01M0R6zJ7T7nbF8/rrdAmnAysb3vk1T+q/t5p3pCXKA3s
	wR4RTa9hZQ7ZIc5aI4upufoG3ud6c3A=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-SkDbE4A9Oj2uwY-qwIoaow-1; Mon, 04 Nov 2024 10:46:55 -0500
X-MC-Unique: SkDbE4A9Oj2uwY-qwIoaow-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-71819a87993so3946295a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730735215; x=1731340015;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyh425pNXcQivIiwavEtYI0ranrZT4OUgdphHkKG6DI=;
        b=TQjSvTrjVu9ak2DdJLDh3K4YEOkBFbxlon/+qUf2gGzHZXFUHReALydTwjVmn1MuI6
         bQdZdCbjEu878tXZVGWP0H9KJxgaaeJAHYJctD/t/TBe6nfaNWj+Uf4kVuxRFLRhmBDf
         jiC8TKcJX2vA7++F+ysjkKB/ntb0mdHvMSlSQhc6IDbUiPOlhWD683KETffsJYCNR9IW
         4Iee2NpXJy0fIko4Fif+ZbeUXGtOLMY0Dl00GUe1Mnxlt/OjJk4QNaZcL5Lu/HX7C7GF
         YIrjzf3SZ/488f8SJjq55bFvO5afs3g4oVHh+1I4YszoJOP4ekfu05JKPovQOT0gtc7w
         mCxg==
X-Gm-Message-State: AOJu0Yy+fizCqVFGIY7Zv3/Bn7+OaecJqht9Mq7HSTYhfml/WxxGm7sC
	rWwS9Vuau+bQvUNZ2xqOBKTiuXB0bYw8+iXQSOpBuv/o4ovTXrmM1I73RK6XiYG7C/nuLnF9mmV
	VCQgpqV7YMXwOTEA0ObPMSWUQronZIas/Xco1ZC5e6ESXCSH6j/0+UeKYtWe6ng==
X-Received: by 2002:a05:6830:6709:b0:718:1302:b2a3 with SMTP id 46e09a7af769-7189b55ae98mr14724629a34.31.1730735214903;
        Mon, 04 Nov 2024 07:46:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcEeo/DI8hPzn4CSpfberrWrU9s96A8UhritWhfiA1EvpMRtLkpYPxZCs0Ec7KP5EoLMlVpw==
X-Received: by 2002:a05:6830:6709:b0:718:1302:b2a3 with SMTP id 46e09a7af769-7189b55ae98mr14724608a34.31.1730735214628;
        Mon, 04 Nov 2024 07:46:54 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccefa6sm1996109a34.66.2024.11.04.07.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:46:53 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Andrew Kreimer <algonell@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Andrew
 Kreimer <algonell@gmail.com>
Subject: Re: [PATCH] sched/topology: Fix a typo
In-Reply-To: <20241102131943.10103-1-algonell@gmail.com>
References: <20241102131943.10103-1-algonell@gmail.com>
Date: Mon, 04 Nov 2024 16:46:48 +0100
Message-ID: <xhsmh34k757dj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/11/24 15:19, Andrew Kreimer wrote:
> Fix a typo: borken -> broken.
>
> Via codespell.
>

Quick, hide behind this bush before Peter sees you!
https://lore.kernel.org/lkml/?q=f%3A%22peter+zijlstra%22+borken

This happens to be valid internet-speak and isn't really a typo, see
https://www.urbandictionary.com/define.php?term=borken


