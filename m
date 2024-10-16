Return-Path: <linux-kernel+bounces-367460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF29A02A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21D81F26B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AA61B3F3D;
	Wed, 16 Oct 2024 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NI7eGuDg"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E4BA45
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064030; cv=none; b=rZHXavBi/eTtKD6iJlghjOxCZduy9gNavmIJkglqr2PkEVTvEX4hfj268v8O1N+5gbp0QWCkVSN8kLmA0QBL/aNr9t0YBXEKbUzgK0wEpQqXB017cQXyPRWqfXDoAnkUMY1Lu0taqbvdkkYMdXsCu3FCrKHTIsWfoHAN9HC8+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064030; c=relaxed/simple;
	bh=feYTSeVka7QJWWBhSEjcTj4+tcS2XGrp6PYYQaXDwEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2zu1opA2gf1bAkeD6DvFy5nn6vF5bbzldJGHjoQULzNdtBbCTvZ9D2K2n3ynU3JRqgf05iF1G8oobW0HJMbSGvcK9aIjuHezlm9e6+fd0ZA6nHsBzJV8ms1lGQ0GR3Ta4AFyF7kd+t4gO02N3YmnrijsPwhRUO/KBMWN9T5urE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NI7eGuDg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c8b557f91so51782955ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729064028; x=1729668828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thSSg5ShR5xJz6ZGwKGRw0pVZLjhIQAJQj0YRSu6SgM=;
        b=NI7eGuDgIpgpxl/NitGvuj2Pcym/7vmB/cEO3dmUE0Z6xcodFY9UfkL2g7nzTdEsJy
         xH7cYb25EGN2XXqDvaG2MtTj/02O7v46TZ4qXCcp4f9Iv4iaq7yjUtiM9+kUSN8RJsQG
         EKpFPzCdPcG3dcGf++ibpxQWj8+X0JxtXApAxrZpTfN4sZwVETEP+YS73jjriGJshmUX
         n4woQp1Ikx2/fgS/6RnRNmd6VEZDCUYKK9yPkhJO167eOZPWY59zkcLIRu8TA5n4k5v3
         zz8e7Dvlq7Z7B7er2Vj1gV7iD6qnEcAYgG+ZzRxzl9EZ2vtV8NqOlDt2Sdt1omY9zm5L
         G0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064028; x=1729668828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thSSg5ShR5xJz6ZGwKGRw0pVZLjhIQAJQj0YRSu6SgM=;
        b=qG6Z8/klD80gb+bnVBmEEgO0akhnPzJA+qcXsjXoAtcZl7Av26uLJD20z82XjYAG1z
         4PM9/3OGatJQwpJp4alkEv07u/uPh+CFinDbPiP7KiqLm0rAU/e2z1epsSOJ1LOeB3WB
         tTx3we9o3B5knsHwDy5BR2VIs8V7B2IhlXlZK/VmHUex6W3+gpe738ZQab/Nm6cHAFn+
         /cuxtjhOkMLkpbt0cm9l5X8A87nhJNdO2ON9/++4840PAfoLyt3lWJHyzkSt9CNq6xgk
         mtF1Eq7g5HySj0NpueKA+a3AH0Wh5J93R0YeNPvIAPwx6NPJASzE3iAcgVRBO7gljXVA
         EADg==
X-Forwarded-Encrypted: i=1; AJvYcCXc7cUSb3J/CzyMOXLVB52pA1GMmGjHF1VAxvlJ7CAUAgK3i6h5YtCVZTu4IAv6/3OKCFAF2jDSKIDPbzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFsMuesNp0eGPSBj5GfCCeeXVwYbqH1LCRhW/CQH1wtWse+rT4
	wtxSeh0zoE/rBA+4J4rMc83/rkLI14mH2Kq2cuJVf2fOJVLxRAPPOEVVUOd4pJY=
X-Google-Smtp-Source: AGHT+IFVld/ABfC+a47ultviWqV/D/tDl2m5qap0Aw12fa9OnUPwgfuOk2l77mPB3egySl0roAs9gg==
X-Received: by 2002:a17:903:189:b0:20c:fb47:5c05 with SMTP id d9443c01a7336-20d27f26c4emr47690995ad.46.1729064028119;
        Wed, 16 Oct 2024 00:33:48 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804c698sm23342265ad.187.2024.10.16.00.33.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Oct 2024 00:33:47 -0700 (PDT)
From: lizhe.67@bytedance.com
To: hch@infradead.org
Cc: akpm@linux-foundation.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Date: Wed, 16 Oct 2024 15:33:40 +0800
Message-ID: <20241016073340.42565-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Zw9Hk_9OO-Aqsshc@infradead.org>
References: <Zw9Hk_9OO-Aqsshc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 21:56:51 -0700, hch@infradead.org wrote:

>On Wed, Oct 16, 2024 at 12:35:59PM +0800, lizhe.67@bytedance.com wrote:
>> From: Li Zhe <lizhe.67@bytedance.com>
>>
>> Introduce a new rwsem interface upgrade_read(). We can call it
>
>It's obviously a try_upgrade_read, right?

Yes, try_upgrade_read is a better name, I will fix it in v2. Thanks!

>
>> +extern int upgrade_read(struct rw_semaphore *sem);
>
>No need for the extern.  Also please make any new advanced funtionality

Sorry I don't understand why extern is not needed. If we remove it,
we will encounter the following compilation error:

mm/khugepaged.c:1145:6: error: implicit declaration of function 'upgrade_read'; did you mean 'i_gid_read'? [-Werror=implicit-function-declaration]
  if (upgrade_read(&mm->mmap_lock)) {
      ^~~~~~~~~~~~

>like this an EXPORT_SYMBO_GPL.  That is if you actually had a modular
>user, the current one is built-in.  (although we could use this in
>XFS if it lands).

I see all advanced functionality in kernel/locking/rwsem.c is tagged with
EXPORT_SYMBOL (which is used in my patch), and I'm not sure if I need to
change it to EXPORT_SYMBO_GPL.
Hope to see this interface used by XFS.

