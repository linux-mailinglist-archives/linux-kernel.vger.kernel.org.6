Return-Path: <linux-kernel+bounces-290859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE769559A8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 22:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E3E1F21B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 20:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A59B156257;
	Sat, 17 Aug 2024 20:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rXx+Uugj"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC47148855
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927608; cv=none; b=es4sq0z79mauSPzcDTSkjRFsuf6zGj5DsKHLHqAn4M8mkLgpOd4KCS+RGKli0006e6Ud89G3eNGBbFEyLyyCZXOXGJF8N6Jsz13zyuYlCh0KLTNnA/OZ5ZAVoU7+uY2XIxpKicY5CKHPYhNQvkHYViyZ+IqUZwjWqBjIBKHd098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927608; c=relaxed/simple;
	bh=AeeefSMD2axFi3uxpS6dlU/mwVVYWnZLxZJKYSAHUtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpLCxdVDTqaApUcpxgXVWPVk58RCgoc0WC/HGyStuyX3D1UkyJkyeaCU8g9G4wvNFKYwhFKe+xc3vFtmToFZKpp3GRO4xWNc9JnlFLqvp0jHoE70qzXHSbh29NJ8U1Yn/QnjwVj98rbHBDCT07VE5OYSAGdZE5hGPDcIEyynWGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rXx+Uugj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d1876e748so151080b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723927603; x=1724532403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5b5pvD+KT+ltnlJ4r6cDUTunICfG06Bpf203gIq+Ps4=;
        b=rXx+UugjczVXnixaOQZxey+UWO06Eav1Xf4OPrZ+RshXNvYe8DpyqI5+zQuTdHBzzq
         aYR5wj1RZ0QqJUif1eoT55hZtvBN60q8ctpQFRUTIzOPoesobA8DH9keORY5SCZkfaiU
         OwhCyNbN+igkHdQVV4IPWgPlSDDSXNk+098YFPDZ+rieuLrEsHMv6znQ6HbIC0gO6Li5
         MW8fCgxTvfF+AxDp6/8pa0RDpuESG/U6/CoPvgGkZzHHAr8vqntyiE+8adEO7Gqk1IwG
         xUMm094EEKv8NroZbtk6qoadWuYcZVc9QJHYdw1WHb7qnP3Q5SIkGx+LPAdKl0OOowNf
         YoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723927603; x=1724532403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b5pvD+KT+ltnlJ4r6cDUTunICfG06Bpf203gIq+Ps4=;
        b=vjeDkGQ83Dm0fGw+wq6Iz3S7lUkF2qQI4XGHOpNITyoR9FKPvWjVoZHdY/LHfzPXGm
         wDvWwaKPWcV18swWybWo4cD9MmTbkdoNRnt77l/L7klSL8I7CWfdtnnGS5fSOhc7FpT7
         oh4GxjwqJhJ2CsVPDueyZskAH0s2tO10fWmR+76+dXUpfzx0ikRWfSH+AduMRL730hQo
         2mAkr5ftSNJ4tpK80kJMswKonnMgZVO8ET2MzUjF0m6+0LySiLcQK11My+vEzVkUeDV2
         LOf1xbVqAC2bLtdnutyUQL293G10CTWkQgdvxo+EsJVcSBv3Zqmacz4HvntQcEIs4oXl
         SWxw==
X-Gm-Message-State: AOJu0Ywo+o6IbizJHXu02GlNinQaTxKH4mkkbcO9KE2Ilt8rZwfrQ5Xp
	zmfxmZKaVFiBgvmceqsC/71PVPvmSyG/pBJvW8e6fpJSn/OS5Uhlk8Zwb15QjKG9rRUOSwRllAH
	e
X-Google-Smtp-Source: AGHT+IFq/d3K2lEN54A+wGwgEXUDmPJVF7VEQg7R10CHDEEYQGvjQlgJa+mqEQQO9/Sb0dxINTYWXg==
X-Received: by 2002:a05:6a00:9185:b0:710:5d11:ec2e with SMTP id d2e1a72fcca58-713c4bb1e70mr5155442b3a.0.1723927603496;
        Sat, 17 Aug 2024 13:46:43 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07e41sm4411039b3a.65.2024.08.17.13.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 13:46:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de
Subject: [PATCHSET v5 0/4] Split iowait into two states
Date: Sat, 17 Aug 2024 14:45:09 -0600
Message-ID: <20240817204639.132794-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v5 of the patchset where the current in_iowait state is split
into two parts:

1) The "task is sleeping waiting on IO", and would like cpufreq goodness
   in terms of sleep and wakeup latencies.
2) The above, and also accounted as such in the iowait stats.

The current ->in_iowait covers both, this series splits it into two types
of state so that each can be controlled seperately.

Patches 1..3 are prep patches, changing the type of
task_struct->nr_iowait and adding helpers to manipulate the iowait counts.

Patch 4 does the actual splitting.

Comments welcome! Peter, CC'ing you since I did on the previous posting,
feel free to ignore.

Since v4:
- Nothing, rebase on top of current master with sched/core pulled in

-- 
Jens Axboe


