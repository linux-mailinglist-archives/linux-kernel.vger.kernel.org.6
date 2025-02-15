Return-Path: <linux-kernel+bounces-516054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862BA36C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4F91896471
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7323198842;
	Sat, 15 Feb 2025 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjcjwVa7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F14192D6B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739605101; cv=none; b=MKiJKBhrYr9DtsOgGqRKBxRnJfIrKFWk6FdUzOepTkgp7hcqM0SDMwQHvuZ1dqB4t7LREx/ziXnRw2up0dIltPoUFz2EeQpWkys1Z9FCIg8udeWPlVoknN0RVDeMwz6JXWbiasQKqoWkc6KU80C18w2HByG5QKVI5QRL5SsEgUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739605101; c=relaxed/simple;
	bh=6GfARyOXcv4E4UaVmRZmt/WSScP231zpHTJkdPoZiQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dsaf6h1a47kpZ9C24fYU4pssGencaiBan/s+jOvu5nnYqmYbvupOKUU+ykVO3M0YCY0WzwbAeEzxdzTxuxn5sK7yXqTlIXYD8CYL6PJ01+JiavZUgVDKjy3Mu8GdWPlzuu/K7Aw0EkYyGL8xYSVCBrefKytJ2e5Z1fP2IwY3BQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjcjwVa7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739605098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9SPJu0ZBIiiVkYEwkjayrxT/oy/c7Iuvd5fIj5BIhro=;
	b=YjcjwVa7Cc7uPOC91sh0bkG491USeBpPATjuAgOVg0Ko73hXyLyrmKkGbvU2fssENVhiPd
	wos//RhXRg9f0gtiZUmIOaYDbKbKAKP6vtU8tigWxwt4zW6Kh+Qq4gptOHMPKxFbMCwlLk
	F72oWMqY2lmf0fabBJFJAuGCAM7nBAU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-YifOuPliNcGGzOHeNBG8zg-1; Sat, 15 Feb 2025 02:38:16 -0500
X-MC-Unique: YifOuPliNcGGzOHeNBG8zg-1
X-Mimecast-MFC-AGG-ID: YifOuPliNcGGzOHeNBG8zg_1739605095
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5ded802b571so1880027a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739605094; x=1740209894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SPJu0ZBIiiVkYEwkjayrxT/oy/c7Iuvd5fIj5BIhro=;
        b=mZU6BO6iDXrwJHI4npfqFKg0I+4JAUvPuLgPECjsrrlqfUETq/NKgY6ODIe7pJdey1
         LyLica3bxO6ogKd/b2FJC4Ke6dGKP2KQv49wv27jN2MSvus3nbwDg0pwnIbRuIuOegyd
         on9DaXh88WBfMqW1fqe5FhN8PPtXABrthsGYEkvQIYLQOtwrMfZOECDvUCWVDq4Uyg1T
         FOjkpDybpjJNjqs83e9WLcVzKFHPgIXPrSpqlUMsImmvcRVpWCzMxS28ygA9hZ7m2ZVt
         ZEhmkY9kmgGJSTiTswOPVirHyZROgDM8yrduksddcH4WzFSGG/v4xNrWZxBU6OrTYm9l
         wHlg==
X-Gm-Message-State: AOJu0YwzWvZgtGkoUceAQ+HxvOua+1eTFx3yJv5dMm0UnqqZHb2MRLog
	MVNAa0gwxG7Ipo/Z0+aRL+EkNovxHf5NuP5rf9JT++oLSIdtVjFgfMAxfhHZRe2wyHA+5IBxo9q
	kNZu/JGClzMdZh5RdKwRtc9W4XyZGrqysFe7Tqu8isrp1PVFxZoPJNrWglLYUOV4VpZwM8In9Ff
	3GruXkyWbaOQD5A485KWfJOJWSg8LEoxtZcRIBpFPlNWjx
X-Gm-Gg: ASbGncvLtKfdM7azrgfgfrocD4g7ykfDPRlViK3NTVFepwhz78QlmpXzewOOsQcXuaX
	yJrYTrTTfPBRSQU2dZ+VRxEA86JMspxhL9BaGdFwB4clW6/LXUBwH5chPHFoQ1ZT2MemnqIt9gR
	Iv+Kg5yCiB6j9gZ6hpTVPC/bDWiv3LKZJJtyqFVfQ6sFygGv1CBu9FTRwWHtLn8rKajwfvzmKxW
	VCXilQic9x69vZ1ROSB6+dY8Nw5dAJ5PepAY2wAQVL6UiHh1H/YNd1gUynE+Z9ffrK2e3Xrfgpl
	AqI=
X-Received: by 2002:a05:6402:1ece:b0:5de:aa54:dc30 with SMTP id 4fb4d7f45d1cf-5e0360441bbmr1752479a12.5.1739605094607;
        Fri, 14 Feb 2025 23:38:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFHAhvVe5Py0hdiB94bUaSN07AMDxg4HYAot7e2ntkAqpIGaEmu0Phl9/Q2zVhnBH9f47G6g==
X-Received: by 2002:a05:6402:1ece:b0:5de:aa54:dc30 with SMTP id 4fb4d7f45d1cf-5e0360441bbmr1752458a12.5.1739605094200;
        Fri, 14 Feb 2025 23:38:14 -0800 (PST)
Received: from kherbst.lan ([188.192.20.101])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ded69e7c33sm3195322a12.61.2025.02.14.23.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 23:38:13 -0800 (PST)
From: Karol Herbst <kherbst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 0/1] Me stepping down as a nouveau kernel maintainer
Date: Sat, 15 Feb 2025 08:37:52 +0100
Message-ID: <20250215073753.1217002-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I was writing this up on Wednesday night, chatted with a few folks about
it. A lot of things have happened. I often thought about at least
contributing some patches again once I find the time, but...

Anyway, you'll find a full and proper statement in the patch itself. And I
wish everybody the best of luck and all the strength needed.

Karol Herbst (1):
  MAINTAINERS: Remove myself

 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

-- 
2.48.1


