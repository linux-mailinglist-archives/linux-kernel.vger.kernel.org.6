Return-Path: <linux-kernel+bounces-571963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E849A6C4BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B27F1B6118D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F422230BF9;
	Fri, 21 Mar 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fs2DLMpA"
Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2F0230BEB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590677; cv=none; b=PVnMShU9ecDC0qkXNyrXJ8ho+kmNMw53MduSpXkxGFpPLdnB2YBwq/8uv8he51PWBgXmZ1elIC0VJpaKlRGRnBZ7Zlutwvgj5vZ6CQN9SdgsgNJ3plGOA7b7Gjl2Osl+R5hUwzd/JZq9S+0Q/NI3i95yLJXL2l/mhRQJsA4H/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590677; c=relaxed/simple;
	bh=eEEzuF7d6T7hcnHB9cj+EdOT28oFZoy+E/XEnhCmXvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqs3JNH3luoYtIKxhyREqggqYdHE+uR8n4C49hY1u9W2uH4hr1huzs22ZgV3vTHyhKBZxYp98sg/4OJ8STKYPy057Z6kzo3YmzivItQWlLqEdh+6Gv2QknvriZZk7Dd4xKw5VrgUkBeU9AYgrCUdgxEX44Av02t04e+odbBLPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fs2DLMpA; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e63a7403c4cso260345276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742590674; x=1743195474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=;
        b=fs2DLMpAlCBeGkfDLf29zrqSY93QK0uJZGQthQ1yhS1S1ikG0UYC01SLePDQcyXgAm
         M6DLqm2kGtks4ulCQHNb0YoF7vgHzW7mYr1KD4As1S4f5T81uRlh+/YqCRfPoA/dGa4o
         Ty4pXD0QhGpFHGouIAiDSKGQLUoa2vp7ack9i1x67LhSlWSSKgIDZrpvLyJ42757Oqn0
         /Q8EG39r/0lL7elEqvkPGd733uA5Bvg9abTQSwhbZiwy43G0EnxtvVg0m8vmvk5iGC45
         Jc3ixMIjulZPzoTjtsE7V7hCOLvjL0Db2pTa0kiCKT1Oe2gB4EHsMwmnrvBvZSIgIfnm
         mVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590674; x=1743195474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+z1St+MaEHLpVnvOhQgv+7CsD+vx1VwfbKyavT0lPs=;
        b=khrYv14MXLrqhpjqzxPGmxdBSZpzM+cT1ZOaWmvIooRKaJqOK6a6XkbUYgVOWM7W9u
         Y467i3HcHrYiDfKyme/ZAZq8teUTfzN2cH53iHp/RTvgpPesrD5vPAMf5VNUkvppyyKh
         JogDevMTDwvLgGxzt3qw7k56UhQtzhCriCY73t44SKxRtnP0KrTBdUz/7hRYdOOzUheD
         0ceymvSMIiJM8Lfph/QIBqMYRh8Di9iPaMMhbde+R3pY6qJ3MzfOiqAJr9rApq6sv2IF
         z6yMDf3Qk+FGHQ0FMiiu1LkluA2/fhATURVH6h3Tz24q25Y01bXIaOzndgOBO+gb+u/k
         y/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkt7o4GcjrHo9nG3QxvTSVQBbBy00jOsxXPooR93zy9SGJJY0klVTlRgsRveew4QFUCwMjbP2wFN7kLqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb55xaVmBRlVZpv7IwQopZ4nRZmGSrCe6B33sxJb8Wk+fMD/w3
	uWuTEnRsmdVzDecMh7IS7rlsytRz/tJrEP6Z1d8L45uTEubb3s6C4HiNk4eszxV7uwHRR95vkW0
	3QgWe9CGyyOCXydG2fR7YysT65k5DokDJ
X-Gm-Gg: ASbGncuSRa9M1137h9A62pu6V1GuvM8RGTHZlIjRmPLgI4fZjpd2qQb/Qjp/z8SgU5d
	oBnvm6KSOXEcKSqbpPVR2DdsUtHJxFFuN26e3UMUxsAHm9UEjso7372m8q3bY/C6pelzBit3YWW
	Lwnj4Mx/0KG7uWIvtJ4AYAMY9RHQP7VKGXrBNflJ31Jd5fdo3uTveuEfYhlqcLgasx0bKX1hMdt
	BQvb/ExG+/txC4yOH/GpV+5+SeoVdtorQLF0OiMh6wIkLcMrjiNdPvtJ9Hmi1i5pcStbcHAGmM/
	CCG56WnjSK0xZ+yuQOlz/t54BKcPjQNS4TZOL3Z4XXNOb/hH
X-Google-Smtp-Source: AGHT+IHMsqT+tAJGNYKBkEfX1KXe23paMLiNTT5TUzRzsaj2BpFKB8j3BMLeHqAIARAiOCl6or/l0Rhj+2TL
X-Received: by 2002:a05:6902:480d:b0:e60:9821:3c with SMTP id 3f1490d57ef6-e66a4feab02mr2622892276.9.1742590674081;
        Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e66a44272b0sm53193276.21.2025.03.21.13.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2562C3400FE;
	Fri, 21 Mar 2025 14:57:53 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1831CE41952; Fri, 21 Mar 2025 14:57:23 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/3] nvme_map_user_request() cleanup
Date: Fri, 21 Mar 2025 14:57:19 -0600
Message-ID: <20250321205722.3947901-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit removes a WARN_ON_ONCE() checking userspace values.
The last 2 move code out of nvme_map_user_request() that belongs better
in its callers.

There will likely be conflicts with the parameter cleanup series Keith
posted last month:
https://lore.kernel.org/all/20250224182128.2042061-1-kbusch@meta.com/T/#u

Caleb Sander Mateos (3):
  nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
  nvme/ioctl: don't call blk_mq_free_request() in
    nvme_map_user_request()
  nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()

 drivers/nvme/host/ioctl.c | 63 +++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

-- 
2.45.2


