Return-Path: <linux-kernel+bounces-522925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6320A3D026
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 04:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FCE83B7853
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE3F1C6FF0;
	Thu, 20 Feb 2025 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoCDVuJ8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C635958
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740023359; cv=none; b=M0dVRDa94siCDQJmKugzlNHLFdj8BxitEC3WHxH3DBWsE0uxlPBkueYFKGWIp9rgAIdLiywQHMT31wWn1QMuVV+rZTBMke4g5puwfA987lbD4qGCpFBapIVe9uo9/9fWJuCGbhsjglRU8DOqGpqQBDGGUX1JlOGaGUnjZouDRo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740023359; c=relaxed/simple;
	bh=7N0poqT7/JftmsP8RiRVDaLcKxjYY1vXGtOKhhz48cI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P6GSg79R3HrpCkmJYxQktA4rtDAifX6G5fkZPAbyQF9AVQTmf7AGgkCXpwV4OJyuVUdofEvKhRVa1U1+NxpaJ1izBwsFZRYYKT6n/R1oCHhUOhlC17picrIYLW1nH1SjdunEppHrnDB1fswyBCzZwHI2qYLfO0rd1+BQyaMtevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoCDVuJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740023355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BDgyzKrvPLq7tuKTWHweaqfM9waU5Bn+U2iuknInSNk=;
	b=UoCDVuJ8BqdgV+1OldkVOhIKgHFvJZG+f4sW/daNtyNLY547QL1ctJ257b6V2S2QVrMnpQ
	C7YlOq2HbJxwkLgherXKl66Hp6innwsM/a4KjP//4zia9aqMOGXeZJDu/KlGUcgxZRgROu
	vsSyyhGHbCeTdlRm9dFqYgcbhv9rgTU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-scFPDQFNObWNqUtCkNOdzA-1; Wed, 19 Feb 2025 22:49:12 -0500
X-MC-Unique: scFPDQFNObWNqUtCkNOdzA-1
X-Mimecast-MFC-AGG-ID: scFPDQFNObWNqUtCkNOdzA_1740023351
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e669366564so14887406d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740023351; x=1740628151;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDgyzKrvPLq7tuKTWHweaqfM9waU5Bn+U2iuknInSNk=;
        b=xMuOzxgulAcnHJOEc8xr9OGu+L+p+7trFgqeVDaqtj7bTBhZ1vP/bWsNzV+du2lB/l
         Ae9AhEOa9Af0XjzHH8c/QJFUKhCA1way+R52Lqk4dgztPuRyTPyA51eVV/REQCeE085S
         9tcQ8F0Db9cSdph+0AUhlK5f+TFfWUGkoDTTgri7F7319zCTX0MBcUWfjAdvQNuRmV2h
         9T3DPFAeE8T6G41xWeaQRrhHDC03VosAxlkZ40rTpO8pfEoumlOU5+4S+9IQszNEdYlH
         +yy3mijGsfuHngM6wODjADWJ/py4Kz6aAKEkPtEp7+lrsRKyfXxR2p+enmdSXHDkWhN0
         9Fsg==
X-Forwarded-Encrypted: i=1; AJvYcCVgveH8VlidvGnLB39XpXwylKTYU82TyjDMv7371V/IbzOEYFPSCc6Uqqny9fpnS94BHMz3ORyPOw5Kcvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywah3Li18JJwEVXY8VOAY2W3Qbt0/5yjQhaqj1CtuGV2as2mbs0
	LVa9al28JC45g64LQxU9P+ox6RvuUx8zSeWm6163PjxiOOWOV6eOgqf4vsGL3HY6SyHHgiwXlxA
	lwYA4i9kyxKJLNY8/nvVWUg4nqfAydpYj0H5C5lvd7/EPXMWh4Sxxwl8H9kw1Zw==
X-Gm-Gg: ASbGncuSJRjMGK1izD23yx11cuT6zhipBqdcu+Bmy+AgMVRLiAr7SKOiAc9h+2SrDF4
	0Lh18w4fcwQmo5vw/fhiaVwGUEsoVEINi5Dsuhul+yHYaAgdTcZiShDz3ImNrUwc/QegGSWIHJ2
	hVSwcId3/VcvBYGybkv/oiyjhL7V1hkcX/TEN3P6NB9MlPMEinEyNIgGQ9DyWF/g77zhjue2e0+
	voeDGArRI/DQrDgb6hLqnTAqF7gCllE01nNFtGC37L2RmVbrYvmIkhQ+mPgBLzLDP9cPs5BmDwv
	hpWtOQrWhM1TDlTAZZRJzpLZTr4uoGVTiW1Q1xnsNGNhGcZ0
X-Received: by 2002:ad4:5ae5:0:b0:6e6:57ea:7b41 with SMTP id 6a1803df08f44-6e66cc80b70mr327163956d6.8.1740023351552;
        Wed, 19 Feb 2025 19:49:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEymwcmkOKap/mm5lCe08N7rQy1rQaoCX5yrQbnjFTYs3ED3qni28IAVrtErl7O9NIy5ACdHg==
X-Received: by 2002:ad4:5ae5:0:b0:6e6:57ea:7b41 with SMTP id 6a1803df08f44-6e66cc80b70mr327163776d6.8.1740023351310;
        Wed, 19 Feb 2025 19:49:11 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7791cdsm81784096d6.9.2025.02.19.19.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 19:49:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <524bd2b9-5322-4012-b1d0-b76edb84ec4f@redhat.com>
Date: Wed, 19 Feb 2025 22:49:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hung_task: Show the blocker task if the task is hung
 on mutex
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Waiman Long <llong@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Tomasz Figa <tfiga@chromium.org>,
 linux-kernel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <173997003868.2137198.9462617208992136056.stgit@mhiramat.tok.corp.google.com>
 <173997004932.2137198.7959507113210521328.stgit@mhiramat.tok.corp.google.com>
 <20250219112308.5d905680@gandalf.local.home>
 <0fa9dd8e-2d83-487e-bfb1-1f5d20cd9fe6@redhat.com>
 <20250219152435.35077ac3@gandalf.local.home>
 <20250220080908.fc1494f0f7c611b48fbe0f8b@kernel.org>
 <20250220-112040-neomutt-senozhatsky@chromium.org>
Content-Language: en-US
In-Reply-To: <20250220-112040-neomutt-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/19/25 9:45 PM, Sergey Senozhatsky wrote:
> On (25/02/20 08:09), Masami Hiramatsu wrote:
>> So something like this?
>>
>> unsigned int	block_flags;
>> union {
>> 	struct mutex	*mutex;
>> 	struct rwsem	+rwsem;
>> 	struct rtmutex	*rtmutex;
>> } blocked_on;
>>
>> enum {
>> 	BLOCKED_ON_MUTEX;
>> 	BLOCKED_ON_RWSEM;
>> 	BLOCKED_ON_RTMUTEX;
>> 	BLOCKED_ON_IO;
>> } block_reason;
> I totally like this and always wanted to have something simlar,
> something for all "sleepable" synchronization primitives, lightweight
> enough (memory and CPU usage wise) to run on consumer devices.  I was
> thinking of a rhashtable where each entry represents "sleepable"
> primitive with a "owner" pointer and a list of "blocked on" tasks.
> But I'm sure you'll have a better idea.
>
> If I may add a couple of "wishes", can we also add:
> - completions (so that things like wait_for_completion and
>    synchronize srcu get covered)
> - wait on bit (so that things like lock_buffer and so on get covered)

Bit lock doesn't have a owner field to track the owning task.

Cheers,
Longman

>


