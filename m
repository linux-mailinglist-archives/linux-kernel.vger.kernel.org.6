Return-Path: <linux-kernel+bounces-242396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66429928784
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C1AB257FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B81494CB;
	Fri,  5 Jul 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwH/bVZA"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786DD1494AC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177744; cv=none; b=JpDRNmc87pokAXWigheoOHFrLgG/Kj0usR6hLnU1Lbfi20clxtm+7EiuPskrQRiS5wbh6Yhn1iLAGX1Ztw5xfnqYdeo3NmhFOMvhJ2O82K0kWuahE+F/SE7Dv9S3q75doLNFgef9zLakIirvbhZ4ImVLiYPFP5cuzZKVUJ+NJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177744; c=relaxed/simple;
	bh=fDulRA5wY27E8BaQYB2UM7S3YsQRO7WeRgkJ8bJUNC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3Qb9xPbP/X+0LQAOI1asshlupqd8k8Gv/8AEeTgE7kdRRHotk7sXKqQBzC5GojNN/8v66+klZh09YSsrbUYLmIOWvCvLD2FcSw9TmJDJe1qqL4QQVzuqByJD7btEIMM+eUOQ1MlJ/bE0O3lBK/3eW++jdtc3U3QzHDbW8Uj/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwH/bVZA; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5c219c54800so722686eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720177742; x=1720782542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WzC+hRRvf2EydJkKilHZ95nPy417tV+PTrQEse7qlk=;
        b=mwH/bVZA0u3DKar1M2H32KFVMnFdQDEaq1b8yXXW64uf6ONMt5aAfYhN149AhXE7FR
         t6yW95ZtvPt+fbeWR8yAIR5nESSExFrkN2OXml309zRk3MJeUy16wXRfmeCqMiNq5mjz
         cXmvkjXpvwflH0jsphf5zrsS4yzRa4XiVEUf1oGCIOx1X7+VU7MDpOQM9A1kawRv35OV
         Cbq1Jm9uO1mwsi3Np9TW2SJmHuBRdIVg7AZxvv4WRsZ3qbA8kIfhhpfzsdO3byzM5TY9
         gsESYaidv/sxWv/YFgcAyZsxKAEaelyQsccChPeh9UgWY9hbrJdg23V7pRhTdzuFSTKb
         yZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720177742; x=1720782542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WzC+hRRvf2EydJkKilHZ95nPy417tV+PTrQEse7qlk=;
        b=loi9pSWcV4XI4BLOZMfHdNA6DOoVbM5sAfSejRmuWMwtKZzEJvVnVx0F2YL66vjwRv
         POZ8wldKlFsTmsHDXKhZ//AfXyP3FUDyFe8f1E9fQiJ3ro64e11xifxH/E5bU3fXM07y
         z3ZFgN6A8UDRs+xHsytOJ/lenF1oM+dDEEbK+hW12k09XWFCip3SPH/i66X17rzRr19u
         R38m86+Q+6yv1IfSbd/zzGTXcc51avHPdWuG0gqV+YM7Aj/JxvD3F/Ec+F+UtJfYepew
         rMlHWjloZFNhYMYkhGDJ7OX3WRHVK4y375iFJpvfD7wlkOC7RTJQBWMbF3vvY0cejHex
         fpHw==
X-Forwarded-Encrypted: i=1; AJvYcCU0k7QbgavUc/L4Xv01pCY/oi6YOdfjg1ignUWtW1gZu/Nsn2xO3mbKfkEeW5OdBvsWtriE+4ePtLEILebm8oqYjO73Zxugz7NB/5Wa
X-Gm-Message-State: AOJu0Yw/hwqdyT2CR4nmMEW8drbC4VwQKk9o1aV3VJUS0rifVfXiLKeX
	F0hjqvBnY7l3JlM1D3z2vJQHLmVZWnmG/+rh5cvHAlk8xC5xDAEq
X-Google-Smtp-Source: AGHT+IHzeICS1oNqqYW7D/8f6xEgQJzXIS/jUrkrbvOuSduc2b9TuE9ZL7Q4J8OXY322Cju933uguQ==
X-Received: by 2002:a05:6870:171e:b0:24c:ae57:b4b9 with SMTP id 586e51a60fabf-25e2bb3d366mr4061569fac.14.1720177742409;
        Fri, 05 Jul 2024 04:09:02 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([43.129.202.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b0238331csm2714112b3a.170.2024.07.05.04.08.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Jul 2024 04:09:01 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: david@redhat.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	dj456119@gmail.com,
	ioworker0@gmail.com,
	libang.li@antgroup.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mingzhe.yang@ly.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com
Subject: Re: [PATCH v3 2/2] mm: add docs for per-order mTHP split counters
Date: Fri,  5 Jul 2024 19:08:16 +0800
Message-ID: <20240705110816.75871-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <40ba1239-bbe2-470b-8574-c7e098b40bc7@redhat.com>
References: <40ba1239-bbe2-470b-8574-c7e098b40bc7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David and Ryan,

Thanks for taking time to review!

Updated the doc. How about the following?

split
	is incremented every time a huge page is successfully split into
	smaller orders. This can happen for a variety of reasons but a
	common reason is that a huge page is old and is being reclaimed.

split_failed
	is incremented if kernel fails to split huge
	page. This can happen if the page was pinned by somebody.

split_deferred
	is incremented when a huge page is put onto split queue.
	This happens when a huge page is partially unmapped and splitting
	it would free up some memory. Pages on split queue are going to
	be split under memory pressure, if splitting is possible.

Thanks,
Lance

