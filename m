Return-Path: <linux-kernel+bounces-319608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FFA96FF2E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 04:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C6B1F23B69
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6AC8FF;
	Sat,  7 Sep 2024 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQOr5P94"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91E12B73
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675795; cv=none; b=Qc5TUm8D/LUDWVAz51gI/xPDwJ5sCRWQWM4+z8wDvMLeIjpFVNRWOpd1lK6R8uVWMk5e5rSkSLnZp/tYMpOcXxrDimxv1FkEX6L4SsizNBJlp0+B/B+TFPycNP7J8tqiulWPLLxjf9XUNL0R+RAlUTqJXrbNZ2VxOXFaGt7YRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675795; c=relaxed/simple;
	bh=+U+19gB8+ElHdhKmy3WeqXgDdEAkbeEUhd31bSK99nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RVJdF2r8SUiVQ7yLFFnZ+ghPo4ntOatXck31AOlzz1f/UEMQJI2t/dbHkXAzP49za9MsUWBVmBDLVOs1JeOz7v92+gSJOoYNBBjdAlP8RMGtKi8wDxpuUxwHSdPVokeNljXK4ikm1SbGZZtuV1Etxu7papIwcAQgrrUh11LMU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQOr5P94; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-718d985b6bbso1123655b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 19:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725675793; x=1726280593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g67c+srPP6Ajv0zIm0Z8lW5PETm8l99jkLlfhTbUl4I=;
        b=jQOr5P94lMezVDVGxr/kDMyxnWPep1DXYbTQIAjNFUBjf9V9ejUPzcaYNUmn/9GJUd
         VMKlBMAwdo+P9tW4sfg19Oqxn9omInpwCF8B7OG3pn/2qIFYdbTKeyu+iKIPZxqUOLqV
         jlDg5XSiYXoepiRfuMHyajJll1lu0SfCLtNdiqnPvb2myPe+BIYwu0euIjM+mPL99uk/
         pSOCrEdWfFJ0KU0Ba34H7ELrFu8Kxkqd1i1PCZu4G+5p4AJdq2SApdiK74z560mMo/ge
         xqThjIQq8JUrkEdJY0cW0k3TB1IfO2qdYzjkjyJJRD7rSfyiYTnHRCP6Sy7CXNvIoh5U
         kVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725675793; x=1726280593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g67c+srPP6Ajv0zIm0Z8lW5PETm8l99jkLlfhTbUl4I=;
        b=JixJwpOhTXTiB4DMWUDYB6lMW0bjPNHgbZ4IJTtMXzSHjuF64c7TFg97XOPbLnsi/h
         XFVW2/i5Qk5kkLf/RW7f68lr2grE57RNAx7wzF4StJA1mA+1KYyqWAPXbJnp0SdwfIyG
         Z8DFLEfRXiatiRyw3msZkIij1OYjQ7uGlXhc2ROUhVhL3B8tBg9lzIgp6XIxtagL9Plm
         7i6BhHEX6gTxQyuO6wURv9xrMmK0AGnvtUmuhhuthzN6yd1kbs36iLw6yXJzUz2nWtzr
         3DB6DOWSJhZw9dQ6tBlDagco9fQL/oZivna9NiF0zxiA+qFTklMyRfvgxxPB+fjN/b9z
         OS5A==
X-Forwarded-Encrypted: i=1; AJvYcCXHP7RlWN2XKsljkFYUcvpqBG2/Z4Z8gJnn2fugjcH6YsrLPPXacsJPBaITD3t0EpPm06hjratwIB1QLAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/q+ZVUlSSUz9Q9nyh3/jSx+GtBaZULieud0IdAQWkS6pQ60S
	iAqZGydCd7Pihk2LVkSQyRC+I1MFhvUCH5Zd8+OD4NBK2EH6n8s/
X-Google-Smtp-Source: AGHT+IFuctpMFUQUZqeaDO/YXOq2BVBiEvroHNIa5dUWXo/PtD7Zs5VUvsq6mSp4tFkJIxYkyMClcg==
X-Received: by 2002:a05:6a00:9492:b0:717:9483:5887 with SMTP id d2e1a72fcca58-718d5e18c86mr4590178b3a.8.1725675793254;
        Fri, 06 Sep 2024 19:23:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e596890dsm159241b3a.137.2024.09.06.19.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 19:23:12 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: shr@devkernel.io
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	hughd@google.com,
	linux-kernel@vger.kernel.org,
	xu.xin.sc@gmail.com,
	xu.xin16@zte.com.cn
Subject: Re: [PATCH 0/3] mm/ksm: Support controlling KSM with PID
Date: Sat,  7 Sep 2024 02:23:09 +0000
Message-Id: <20240907022309.1931368-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904054132.F2DF72220083@mailuser.phl.internal>
References: <20240904054132.F2DF72220083@mailuser.phl.internal>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> xu xin <xu.xin.sc@gmail.com> writes:
> 
> > Hi,
> >
> > In the field of embedded Linux for cost considerations, resources including
> > cpu and memory, are often not very sufficient, so the global deployment of
> > KSM can be a mitigation strategy, which is feasible for closed system
> > (scenarios without Internet connection). However, KSM has a side effect of
> > increasing write time replication latency, which is somewhat unacceptable
> > for latency sensitive applications. Therefore, it can be combined with the
> > QoS of the business tasks to dynamically close some part of those already
> > started processes in real time if the QoS degrade. Although it is also
> > beneficial for server/cloud OS, the requirement of embedded system is more
> > urgent and strong compared to cloud or server operating systems with
> > sufficient memory.
> 
> In general I'd expect a different approach for embedded Linux. Evaluate
> which processes benefit from KSM and only enable it for these processes.
> On embedded platforms CPU is generally a scarce resource.

Generally speaking, the ksmd at the default scanning frequency consumes
very little CPU and has a low scheduling priority (the value of nice is 5).
And the global deployment of KSM is quite common on some embedded operating
systems, such as Android 13 and its lower versions.

In addition, the feature of controlling KSM by pid has the following usecases
that I can think up:

1) On the OS with a global deployment of KSM, we can dynamically disable the
   KSM-merging of some latency-sensitive processes by PID, to prevent the
   increased COW delay from KSM. Latency-sensitive applications are common
   in a variety of industrial control scenarios or wireless communication
   scenarios (like 5G).

2) Under the new prctl implementing of KSM, the running user processes don't
   have to be restarted if they want to enable KSM, which will be very nice
   and user-friendly to some critical applications that can not be allowed
   to be restart.

> 
> In addition there is already the KSM advisor which checks if VMA's are
> have benefited from KSM sharing or not. If they haven't benefited then
> they are skipped the next time. Have you evaluated this?

Do you mean smart scan? Yes, that feature you mentioned is very good and
improve the efficiency of scanning.

> 
> Simply turning on and off KSM for certain processes seems to be a bit
> questionable. How do you evaluate that you have waited long enough? To
> see the benefits for KSM you need to have at least two full scans. Are
> you taking that into account.

Yes,usually we wait at least two full scan. For some processes, turning
on KSM for certain processes is indeed useful becasue we can see the
saved memory benefit.

> 
> I don't see a strong use case for implementing a second technique to
> achieve something similar.

In a word, the old prctl of KSM is limited and the new implementation of
KSM prctl support the two usecases above, which is very nice and
user-friendly to some critical applications that can not be allowed to be
restart.

