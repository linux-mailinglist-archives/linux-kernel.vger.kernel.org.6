Return-Path: <linux-kernel+bounces-332842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E797BF97
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C93B21EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8E11C9DDA;
	Wed, 18 Sep 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbQrMZet"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EABD1AD3F8
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680040; cv=none; b=WN3bPNOLPhvN9nqjKtETig4obvpYltv4JRsBjbu9HAy1J2gydv2n5gePaDeL66/xzND2ZvGSZaoq60V5SQf6A+MnGgZNQMtx0XA0Fh3bA5MTczP4JEq3nctKDBcO3aFNkvtzOd7Uf3pHtXL4zlQhtChsMk0mej13X/zOxavUpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680040; c=relaxed/simple;
	bh=fp0kfU9JJXj3JXg6Kmhe3J26EnAG57gHBH6CHIYIU6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JaAyxSsd/We022NU3Vb6knE8FrKTN6Mv5KkdeRb/CI0bAi9IgSE92SnQquVhobfrqpQ0AROAl5y7M5oNYIooQTMCjvSVqXnqm+0G5bSPkCau1aSf4quY0mtGYKXWXHK3838VeTCR2vbTRRCyiVeXk1owpPEUeeXLe+9giiopYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbQrMZet; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71798a15ce5so867885b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726680038; x=1727284838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCjQaYHdb+9akkF4GNDfGIZ6sEnEG+5xP5QyLjg07+g=;
        b=mbQrMZetXec83bcLsN1iZ3GuyUkRoHbjC6/h8/Z5xIgH/rgzdit3h848vs77dK8WdV
         pxJtQK5hxPflU3UgwmN8yku2IPSgvNCUumFMZGiyjGRbkMamhD5gR5/bwBvYMhbQPvbD
         CvlcznfL6m7M7Nsv3bfhwGEEse2oRIMYy1Uxhtrw+U5xtFdGzQ1m94nCdK/v2lnqoJP/
         QCn40iDTeI6kElT1jHPFdKEL3C6J47V3Gs5mCT3hZGQU48ki6+D9W6KS/nlDd9M1UtP1
         Utc6WjfiepacL7bSdhQCetNh5nrhTHVyyWF2/rXu1OBqKju/dvVI59G58fDIQMVXtZth
         G6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726680038; x=1727284838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCjQaYHdb+9akkF4GNDfGIZ6sEnEG+5xP5QyLjg07+g=;
        b=sJrBa5UQ2GLGMW+FRGaRe1kJuriti83CX7Qg9eEcczArHkfAuUinnJnQIHDhrYyjDI
         /H5gO+mEvnUv8In9iQ7xAI/TAh9zhhVJ59gWLiycZtRBXFbIxrF/YXIyGq0NhG5+QYF3
         xHGq5oXOqYa0X8NlN1YwGfeV3XPWsutWgrf7CZpn3GZO+nyAtfQBa7JNEOlh9q3W+nAy
         EmNpcatGzv1qPXFDx8ZIB9K3IiIQP8onaZevAuCtuADaBGsyjDE/7WE0dyk9+L9R75sf
         1eAEJpqDLctwa36LHIZgkAk13NSlC/DmESKL2WC/S4DqjFgBkTxJbybh7aRcvym0cQQi
         gc9w==
X-Forwarded-Encrypted: i=1; AJvYcCUO/63AmtNkcSfH7IlfaNhxb9PXSSrRhyEuInTLVIGdYgPyVNpzQSL9u0TKNPHNP0z8gZ/WleQsUF+gHiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXWmVtoc0KPP95xoUTDeonFZjjt9jXRsLGOZAI6A2MepxeUjO
	mDcjStOl1hwgbFBJlDceVnsLBds6Of3x+D42S+tknVI9H9yyCfm8
X-Google-Smtp-Source: AGHT+IFZVBIM7leYgR1FuSjCuamUv2TO9TcnN1QImS+vNJUsnHx5FI5MEArsnr4YCOk+f+LXTrVIbQ==
X-Received: by 2002:a05:6a00:6513:b0:717:92d8:ca5c with SMTP id d2e1a72fcca58-7198e24346emr477163b3a.3.1726680037871;
        Wed, 18 Sep 2024 10:20:37 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7aeafsm7186476b3a.99.2024.09.18.10.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 10:20:37 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH 0/2] ocfs2: Fix deadlock in extent_map and handle zero
Date: Wed, 18 Sep 2024 17:20:24 +0000
Message-ID: <20240918172026.2532-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses two distinct issues within the OCFS2 file
system:
1. A potential deadlock occuring in ocfs2_read_virt_blocks due to
contention on the lock.
2. Handle block conversion with value 0 in ocfs2_add_clusters_in_btree

Mohammed Anees (2):
  ocfs2: Fix deadlock in ocfs2_read_virt_blocks
  osfs2: Fix kernel BUG in ocfs2_write_cluster

 fs/ocfs2/alloc.c      |  7 +++++++
 fs/ocfs2/extent_map.c | 16 +++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.46.0


