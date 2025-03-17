Return-Path: <linux-kernel+bounces-563878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7BA649FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E20F188C2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD4233720;
	Mon, 17 Mar 2025 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfpOd3Uv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1812221CC7B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207311; cv=none; b=GPECnAnMTCxR6QqWVST6HMmV2IzxVJt21kWwN/BWyIpX1byTbYYz/q5BBLmNfTmxa4vdXeFveX2+ehCPfPizIqU3R2YMxE9aXjL+s5zai+pE79/Gzns51krawNINSu/Kic2YIz59uNUxTqsbqO/y9TO78u7Fge79bWD1gLGZbIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207311; c=relaxed/simple;
	bh=UHHo92O52nWRNsisehdFxVI8rIastL0jHugBpGz18lk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lEm517jFPFWJjX5hE7S2ALFSE4G/kps2fjQJVdyOzXlYRtRGV+USoSBeYDzDx2gGVLSIqv9xBOEXxaOoIGIvrjzyk+9tcXC6I35pI5oH2shaoupp59tLZynpf0Oa6Du9efFEY7LbetFIbt0jk37ZKWSo6ePEEbeamJtgAkyySak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfpOd3Uv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742207307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3ZpCYyD2or8iE1ALBW4gTcZc3gKrNq4HxsVD0AGmAU=;
	b=EfpOd3UvUtAW6oBkiT/d4yVqk7u8QS7cBa4vS7rPVe6OvUlsN2bPvM42bTyhx78SO2JSQF
	MEfSEjg1lyxwKtxJ9PWhrFrHKC4GmroObFWmOc0gbVCOQSOleytk0K3F6BFZ6cbaBlM9Mz
	lSgo89DIzD2l3gtNnXx+T+HCrMqupaY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-e4jxckrlM8SWC6JhHT8eNg-1; Mon, 17 Mar 2025 06:28:26 -0400
X-MC-Unique: e4jxckrlM8SWC6JhHT8eNg-1
X-Mimecast-MFC-AGG-ID: e4jxckrlM8SWC6JhHT8eNg_1742207305
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so11881105e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207305; x=1742812105;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3ZpCYyD2or8iE1ALBW4gTcZc3gKrNq4HxsVD0AGmAU=;
        b=m6Q3nQXeEdjTNiCnEOae545MbD4KqleuvqW8YVBfIZLlyS9QKZErx2NuSm4UNjqTt0
         gWDo4+wiuZ8F2NxzDpXI570BbgxKcCvTlqXUDcoMNyUzPZ6YYX4T08N5TTZzk9NXI8LP
         HdCepWEVSTLHZFSai1X4DwyJ/5xV5mVtxf3vLXXKGkaCAkr+NSSxumbJH5doRB5US1VJ
         svk9sJJFcRNQ7TlkCsFigb6leUIjo+QD2QfRa3RGfO241aHrg6FqM2bcEovtygjE96Yw
         r6Nc2/yWbFXOkoyt+CS8crP/eLCZUsFNMfuQhkO8mpQkubdoWoadvQG/DqlGRaSf6Mn7
         EltA==
X-Gm-Message-State: AOJu0YyLzqssRneYlF0y+K0d7obSFY5DGOgMQFenHmdZxxQNZPMw5c7r
	n35VFSj1TtKTM5+jK+9wh0+TWzhsNr/1658b16reRMspIUvL7ELGiDtldvoksAszykTPuqaWBd9
	1hHhUgzzD+1+0nN8SozWu23m0GJUgPa7EV6TQ6GO3NQrpujU0uFNMXf1uXQCmKg==
X-Gm-Gg: ASbGncvQaZhCSO9xReI2ztGtF5ck4s744HTHkmsUeRWRFtjXKEiTtEkRzRcGS2Bc+Rm
	QXKQwFhz1ALmXbTi9jhPeN5ki0gDvtlq+n0Sz0Jcq0z5pjTfx+JkdurALo8xjguF57AXcH7hXx6
	6NkRLTphgEywkMwGNzUYgMDh1AFLQQE24iaQxAyqgTD9XyDbdJTftVW23CrP9lPOUutaGsqBHnN
	W/1oxFjt3i3AxPdSfu5l2Gf/pM9R2NNWEW2vRQ5PcZbYHw5qrMc5k1RoLnxTCTzhwnALKEf2WzV
	1k/esnWsqid4wGTfKMKOGiV5zWqB/fzyZY0X/wr9vNFLUHwjmWTilHftLt5Xd0sq0ZvtBFpG4Ql
	FeI4RtHkGjz/mb5HOOmHkg3q5LJETxv6l
X-Received: by 2002:a05:600c:1d05:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43d1ed0f578mr110241545e9.28.1742207304698;
        Mon, 17 Mar 2025 03:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLd82s7hmq4XzPKPiYFmG7ancuCXYwwSBwnPVIpiuyKnYj0ig9fIVTt/U5+lWFU0IRQ+PUlw==
X-Received: by 2002:a05:600c:1d05:b0:43c:efed:732c with SMTP id 5b1f17b1804b1-43d1ed0f578mr110241385e9.28.1742207304369;
        Mon, 17 Mar 2025 03:28:24 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (106.15.202.62.static.wline.lns.sme.cust.swisscom.ch. [62.202.15.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe065b0sm100080515e9.14.2025.03.17.03.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:28:23 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>, Ben Segall <bsegall@google.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Josh Don <joshdon@google.com>, Ingo Molnar
 <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chengming Zhou
 <chengming.zhou@linux.dev>, Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH 1/7] sched/fair: Add related data structure for task
 based throttle
In-Reply-To: <CANCG0GcxLJOnNSZgYVYYh_Ug-sVpCOmsf3VATELrKrs_6jovQw@mail.gmail.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcxLJOnNSZgYVYYh_Ug-sVpCOmsf3VATELrKrs_6jovQw@mail.gmail.com>
Date: Mon, 17 Mar 2025 11:28:23 +0100
Message-ID: <xhsmh7c4ooss8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi, just an FYI, I didn't receive the cover letter (PATCH 0/7) and it can't
be found on lore either:

  https://lore.kernel.org/lkml/20250313072030.1032893-1-ziqianlu@bytedance.com/

Not sure what went wrong there, but could you consider resending that?
Thanks.


