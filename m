Return-Path: <linux-kernel+bounces-377066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B7B9AB971
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2471F23333
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF761BD4F9;
	Tue, 22 Oct 2024 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NtbcO6wz"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686F1CCEE0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635910; cv=none; b=WsTKiYBJh8TmHWl4nYWxefuPJzbs0q92ACULN+/IwUE9ofHoWRh9IPgOIw2lPgFfJd48FluBtf8mPZVxCabjTRgQbZRfD5gi6jMBApZQh8flH3x0T4jXjJ+dFO2uZeG3+fFZxBOx1ZYGG4wa2N/CIEi5TDM5tiu/j2lzis6u5SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635910; c=relaxed/simple;
	bh=iOiJ34DqRyuaW2f1KEzrFUgvNVZUdPnsNfSrAJPsx5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gai9Bvri6SXaQfUhlE6SwT1pqYIjiKz8qZfzwKixsdTlOLDpl3ul44RvDB5izyCHJF13ouhHlXiqirRZAlkxNJy5fSPJolP9e+zyrFEouBBAt6TeiO1nsXoRc6HRnA4dWpMLLkqSW74bqcJ4pSu0yJJ93Ha1rqjdpA7wVToZTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NtbcO6wz; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3b2499c65so21215345ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729635907; x=1730240707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCS+af++TIhD/0ZORFL2loLAkC1Uw2+3hJp4y+XdylY=;
        b=NtbcO6wzeSQG51gAWMNoakfIB70sm0ayvCTGkDToChZC6ocPDbxNF+ss8jnLHfUXpL
         vOCpEbzuFfNbtg6kBWl5f3HmuDSCXMrydewQCD50/v/dFCf7k4g9iF4JXb0YVebhXCRV
         5e4zT5DP/5D8hpZb3XhWwecFdEYB4JBCmsJxUcy7mI/fKAJl8Xt2e5MmCyJs4T5iHUpb
         0FPNgkuDMJUbhn1zo/2P4Zm4TBPK0u6W4ICgjRPKMkCSQ8DRIG8mXMSZvyUoGEcHSJYD
         Ijqs3DtNn18k6ayMPp31hawApr7Y3jt8JUbSTqKszCoDxruB+yGELZNbd8oJ0BM8dLAm
         zreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635907; x=1730240707;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCS+af++TIhD/0ZORFL2loLAkC1Uw2+3hJp4y+XdylY=;
        b=hsA5eKQx7Wkv0vVgDxTwepSScmsSN31HrgOB0OGpeCrhH3aye0XsJacN1DZ3hs/73x
         1Z5OBoGTMkyZ0XuMGEu4IzA9sip3A38pGqlUsbWo7BWnpRuldja+OGjkypZJ2PWpIY1t
         1PeT6Ny7ncRx4m3iU62GQLVh+HRv/YJ/APmQkHE5pPQN10vUNx0axzsNZmVVbyRwOdWU
         +eOTCCb8ebwmPdAXTz8aaODFm3Fr04PGQdvfDCbVbyQ7TX1/sPTGuhJmelF6eKRM/Rso
         FJGt3I4dYZ2FM6s4EQu005qgFSRKyjEObIAkruFuGmrOlwIcbiwjjnmEqFfItWfk7vt/
         b1sg==
X-Forwarded-Encrypted: i=1; AJvYcCXfL80ScZcNX0R23qfXogn2sr8a7diyO1KaG/eAuoOFvQQz7tYwZH/cE5ONV2AJVekyosAEJ1xWrgvX6LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndF+iuoohUs6DpK6ZgjGM8xNueBkBkXk1xT+kBFLqav75pco4
	TJv6qTSS/9uvAS0QYcbr51FY8RM3/xhaul62F9Fw1F4x1jhIcW8qB0S+wiVWJm4=
X-Google-Smtp-Source: AGHT+IECbvU9xyqGdGLSnp+emlrEw2DQYwrGr6DhTTYByG6dOze7v/lx58pfZoZ+MZmljeoaYjemDw==
X-Received: by 2002:a05:6e02:1c0f:b0:3a3:b256:f325 with SMTP id e9e14a558f8ab-3a4d59e03c6mr7425865ab.20.1729635907638;
        Tue, 22 Oct 2024 15:25:07 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a65f952sm1767297173.176.2024.10.22.15.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:25:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Muchun Song <muchun.song@linux.dev>
Cc: josef@toxicpanda.com, oleg@redhat.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, muchun.song@linux.dev
In-Reply-To: <20241021085251.73353-1-songmuchun@bytedance.com>
References: <20241021085251.73353-1-songmuchun@bytedance.com>
Subject: Re: [PATCH] block: remove redundant explicit memory barrier from
 rq_qos waiter and waker
Message-Id: <172963590674.1032314.6365851966628094463.b4-ty@kernel.dk>
Date: Tue, 22 Oct 2024 16:25:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 21 Oct 2024 16:52:51 +0800, Muchun Song wrote:
> The memory barriers in list_del_init_careful() and list_empty_careful()
> in pairs already handle the proper ordering between data.got_token
> and data.wq.entry. So remove the redundant explicit barriers. And also
> change a "break" statement to "return" to avoid redundant calling of
> finish_wait().
> 
> 
> [...]

Applied, thanks!

[1/1] block: remove redundant explicit memory barrier from rq_qos waiter and waker
      commit: 904ebd2527c507752f5ddb358f887d2e0dab96a0

Best regards,
-- 
Jens Axboe




