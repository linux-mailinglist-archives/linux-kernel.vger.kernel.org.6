Return-Path: <linux-kernel+bounces-296237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613595A809
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B943B1C215FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F6C17C21B;
	Wed, 21 Aug 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl+CFjyk"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C601494AD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724281553; cv=none; b=DryEKdwXMrNyRuAuiRmcxH0oVev2OmmitT6oAoYnk7lO5Eou9S9WymTkjkQrsyZtOFAeKwJYxiQsV2jnwcIip+Qd949RTZWS0XiSnxC0r0o6pldIjRIC4+zU2uT4A8KFPdI95rb5iRRHjnjqbeLYNY5qCQLo9Qx7RrFZVJnDdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724281553; c=relaxed/simple;
	bh=d1EID/CFGj4Y6H4KJF9CTdUyw1WgxLbONILf2RQs0WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nVHzyVYRntgnEzBHO7v2tV6o5NkDaToXZj2eoX+hO3rFwINSoHsT8L6wd1IX04GQMw/rqs85/xq+OVuMhITvaWFRZ7FI4kIKgPzegXUJiegO2SxPHdpbJ04ru5oGmyUaG74VXYZH2kra3axjETtCsGzji63B/Kab3F+ZY3cnQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl+CFjyk; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-714287e4083so179648b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724281551; x=1724886351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVdbyf7S2v4iGMD6CkQHTFlqzN06wCtHKLzUTSC5OVM=;
        b=Jl+CFjykNVvifSApugNc/YNJ8dh9UZhIwqkFpDlw4ghMX9vwU3l04pjKPCFSRa+/74
         qPCO2cP5w3BV5gcOjViFY5okfamSbgQrPq6B5Q2mAUCtkHETC+sMmq7MV1zURqJfjEK9
         tlJFkQ7q+GDHyACyIas0AL2o9tu7H5+xwud9iVVODVqN4gv0YesbJum2dvuEON2E1Y1x
         Yju+F8uPXAyEbGGEkLOSQyGp2fDEwwWtR3IwehdmEsl0ojwrM7WV9xr+EFkqUjiIsQ9h
         oHzjSL3u6Eg9lUsJ7Ud0mG4+4oEI+jTDq4McCkm85bmOlCyi+M+gvFJcKrVa8ceAxKvh
         w2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724281551; x=1724886351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVdbyf7S2v4iGMD6CkQHTFlqzN06wCtHKLzUTSC5OVM=;
        b=h0uMP1ufvFGVoz6zYZALoHXrf59eHjVQUkLRaUXiaRdBjZ1aRZd2PbuiqgnCZsynjM
         zwtuL7sNtX6H/fSHxez+sWxv8dGjKf2oZ0RYPJK7AQYwkSDyLMlwFzv33V0KALnQB7Q0
         5iM4FyEaIrV/NVdWCb7EouweQd+k5uV+CcY0cTZJkFvIHWXLBi0RAnjEfLEzxZJKhV5q
         zljEuDp+/kj54+7Aqd7MX0CcnUWnE/ML0qxv1/4YjVfExRBaJUWOFUwZatnSo9g8sa1i
         ZRcVPzk8dACbqoYnEVIYH03N6HDpZFstz04fNOViP8V5W1AELD2VuwfjnU/ZdVH30L8V
         NMkQ==
X-Gm-Message-State: AOJu0YwkI452i4Eg8R/b27VL9t/BA52+FyL0dpENNBi6DVwLg3EIU0NF
	1F1zudhcprtFYodKd0sDu8QxHSpaCIPsbrpPubHrXrUPeldFDHqh
X-Google-Smtp-Source: AGHT+IE+rP6DqOYjwYHuEdXSxIWjS7x1jQRRhBt/VRC6lpu7Nmylgo3R52hVYvU3z6rNt+PsywD0cQ==
X-Received: by 2002:a05:6a21:1693:b0:1c4:944c:41e2 with SMTP id adf61e73a8af0-1caeb342e86mr67389637.51.1724281550890;
        Wed, 21 Aug 2024 16:05:50 -0700 (PDT)
Received: from localhost (192.243.127.228.16clouds.com. [192.243.127.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac99502sm151433a12.14.2024.08.21.16.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:05:50 -0700 (PDT)
From: Woody Zhang <woodyzhang666@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Woody Zhang <woodyzhang666@gmail.com>
Subject: [PATCH 0/5] Minor memory size optimization in debugobjects
Date: Thu, 22 Aug 2024 07:05:34 +0800
Message-ID: <20240821230539.168107-1-woodyzhang666@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of now, debugobjects framework uses hlist_head and separate spinlock
as a hash table bucket. We have hlist_bl_head APIs which embeds a
bit_spinlock in head pointer and thus no separate spinlock is required.

This patchset first wraps irq variant API for bit_spinlock as well as
hlist_bl_lock and several other APIs and macros. Lastly, It replaces
hlist APIs with hlist_bl counterparts.

Woody Zhang (5):
  bit_spinlock: add irq variant for bit spinlock API
  list_bl: add irq variant for hlist_bl lock API
  list_bl: remove lock check in hlist_bl_set_first
  list_bl: add hlist_bl_move_list and two macros
  debugobjects: use list_bl to save memory for hash slot spinlocks

 include/linux/bit_spinlock.h |  37 +++++
 include/linux/debugobjects.h |   4 +-
 include/linux/list_bl.h      |  40 ++++-
 lib/debugobjects.c           | 288 +++++++++++++++++------------------
 4 files changed, 217 insertions(+), 152 deletions(-)

-- 
2.45.2


