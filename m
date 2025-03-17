Return-Path: <linux-kernel+bounces-563991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A497CA64BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429C23ABB90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010A236A9C;
	Mon, 17 Mar 2025 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Cyx6zrlf"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9EF22CBE3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209335; cv=none; b=krgkUjbtziKlk2sSnVs04fpeMV5YJ8tl8kxYxaZ6GBitgcTivpsfZ6vR8kg2EIMczl1CpZudF+ATdFqzCUxgHizzIm6mo2yfDWZBPfpy21SHDBwf5+IgID0J61R4Fp75U5ILYrQ2I/Aca072t7X87q0t1IQcNWgI4sXlA8L7vf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209335; c=relaxed/simple;
	bh=iJUFjccbbRg29+1fyhoN/w56nFuxVARJPVYorhMQi0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkMBMysqJTlWtLqHFYyYH06O5djyl/oUd5V2lcVbtfUL7rnKUdjSCeNr5FKOwqNqipYN012Sayi6N2YJh0eaC0NgmURhYhH8kkYa0RfbwbDbFhUtmRhda9YNxVIHxRDNryxg1YdG1dn0iAL/bB+sBZB5GV22hBftKxxooLkS1iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Cyx6zrlf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2235189adaeso69464965ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742209333; x=1742814133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6shPC5jW0ozEdZOQNelxL8rFZZyYTLtn1efKxSBsUY=;
        b=Cyx6zrlfqRG8iKDvViTcIB0xIFfU6OoGgjv6Gz2WaVaWdWxFjANnzqccgZzMsrBj3n
         lnnZiMaRRo6dkaiYTKMveET1bClomoc0MQwPa3NFP+M5H+X2i3dtF9Un7748bqeIUp6S
         cnMkP03pLtjgjnd/8Q4smqImF6bR5QZhJC+r1jGVCAHAeN3q6rXPud4BMA2WbiaF0UMk
         RYpd6eacDsyCs/2DpX5QLML7mZP4stBDqFkE3VHyiZmoNgQedQLlVTTzIb2QDiFhMAEt
         kBd0lASFC375qmD2q6czx+/jWk8hQLMGjw4KOM/dbH2Mkiqw1YlrfAabewla2ypFKU3O
         5Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742209333; x=1742814133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6shPC5jW0ozEdZOQNelxL8rFZZyYTLtn1efKxSBsUY=;
        b=Kfz8/taRQcW82Lo8rBSf9LbbYTECWAS24PE8ispuPxGwcJVMovRLozlSllycx2MZ4/
         HziThDJDX8a+NIwQ3MYAwbmT0nro2mxuQYpTxIrMYPhhoLhyOyep761EgRpBpsuMKfP+
         PXDHoAqcv1tuu+Nfex5cb8mkRSZ4p2XWTFKFDSk8E4is4eqewpr5RltoV756QzSJMNcD
         NaSUtZPuO2KPnbRg70BeOygKxfYQpS//izKqXNOAp7hAHTFocNheyTCf0jnJc7owM4Y2
         7pgk/7pfxpUacZIPIQv8jePK3ib9jBcT/6+uEZvdT5qpEeVSGEylMHCZmNEu/+670TqB
         oSqg==
X-Forwarded-Encrypted: i=1; AJvYcCU9SMSjVPQirO8Sry4U7m3NRmRz7CIFSA658zKuDTGE+3ryL+Yr9OAAlkqcQ7Kaabjhr7Z+DOKPPp/P1u0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0sl07HTzVj/KUlqXCWXuChX9sosKgpapdvrDFvUr65liu4oA
	vwp2cOkixGIhX1m5EGQOgNc0FP2J0R6gHYX3D7//owMRpl+AtMTAi1Or8ynSXQ==
X-Gm-Gg: ASbGncu0pfVUGvoo0+n72aJM4whRHeuw8i5xqVa0WahY8uurjQgwKznq6+4aGQZfA+C
	mtnv/nlQh4GKCquvIBa8sZYMGsaN5KU/x705VKsdp32peC71n1j/RRNqPtib6LAO0NgxpxKkl8s
	+Kh3/Tsm4/P9e78ITwdyiSwEbckoljImCH9N08T97rS7O7YiqX0tdhU40VxbRxj/8h/1nEwlRZb
	YuZd1HLR8NyTZsxWiSnI1zca7NkbotCTSZQIlTvf4Y0qveN52EHUMUsYB7/UIJL1P1WNDlBa5Qr
	DfVZPHvUcPRwTPuAdQW+otDWRwka0/xrnFWII0Gf5XLi
X-Google-Smtp-Source: AGHT+IGxzVcL7qiDYvc/9vY0cJbYEW/mrL9IZOj4QcVfhMqAgcSS8/w2bN8JKt8VjC0RxmLhssUQgw==
X-Received: by 2002:a17:902:d48b:b0:215:b1e3:c051 with SMTP id d9443c01a7336-225e16b0fa3mr117402315ad.11.1742209332685;
        Mon, 17 Mar 2025 04:02:12 -0700 (PDT)
Received: from bytedance ([115.190.40.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a381bsm72220495ad.53.2025.03.17.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:02:12 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:02:05 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [RFC PATCH 1/7] sched/fair: Add related data structure for task
 based throttle
Message-ID: <20250317110205.GA4071488@bytedance>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcxLJOnNSZgYVYYh_Ug-sVpCOmsf3VATELrKrs_6jovQw@mail.gmail.com>
 <xhsmh7c4ooss8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh7c4ooss8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Mon, Mar 17, 2025 at 11:28:23AM +0100, Valentin Schneider wrote:
> Hi, just an FYI, I didn't receive the cover letter (PATCH 0/7) and it can't
> be found on lore either:
> 
>   https://lore.kernel.org/lkml/20250313072030.1032893-1-ziqianlu@bytedance.com/
> 
> Not sure what went wrong there, but could you consider resending that?
> Thanks.

Sorry for the trouble. The original cover letter mail's message id is
changed to CANCG0Gfn-BENDNqJmWC2BCxXLA8pQWrAwNibx22Dv_yUzyNV5g@mail.gmail.com
for some reason, probably because I used the wrong smtp server when
sending the series.

Seeing your mail, I just realized I can re-send the cover letter with
the correct message id and get this issue fixed.

I have re-sent the cover letter and saw it on lore now:
https://lore.kernel.org/lkml/20250313072030.1032893-1-ziqianlu@bytedance.com/

Sorry again for the trouble.

Best regards,
Aaron

