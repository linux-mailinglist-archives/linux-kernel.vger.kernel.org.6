Return-Path: <linux-kernel+bounces-268066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE1942000
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD0F1C2306C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC571AA3F6;
	Tue, 30 Jul 2024 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwLrIsx9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D71AA3C6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365455; cv=none; b=J4M5i3mIP3Qnfsa3oqxblEUzj8wTiQBzAmsayH0aIYwbNX6AXYQ3bk6HaysXpaaIjbqjMlHgraJ8W8rblZzMTlPosw8z2MVT3kFVvoUAurgZvJe9DMXkLUFVQQ399t98m+tGF2BaAjORLM98UIUuW1rvwcWX4Zq1hyO/cr46EDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365455; c=relaxed/simple;
	bh=dD1n7w5Jem9acpsAsrBHR1ipmgsus4rY6j0u7D4ffmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXkmtInTXgunPkwzzMouQanZ6dpVT01/ueJE9/k6z15jVm0sb6pm+a0EMD553ixcaCQMOgxbXa+FgefN5eYbQ/YmyXen4IU4bkGpkB0qmNy7rnsBFpmbYpNvY722ijbgFQMya1gHe8v7FT4U+ZWcmWqEbKDo2ovuFCpuMWWhSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwLrIsx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9B5C32782;
	Tue, 30 Jul 2024 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365455;
	bh=dD1n7w5Jem9acpsAsrBHR1ipmgsus4rY6j0u7D4ffmI=;
	h=From:To:Cc:Subject:Date:From;
	b=AwLrIsx9SwwYwR5wQy0TwV1cPPxn3T+/JHIncw+Qj666TR80dAZ5NlRyOWwPauHht
	 7S8lk92hMK7DVp22X5q8hqMzYE0LPz+SkVUzrhX33iU3uKrqgbJHuQHhYDlWoLg5v7
	 utuXJqQ/0MdnPPvWt/fYfbAxZaKPhY1xv+FDxWv50wibQSNk0iwg0jxZqSpOjKG7X2
	 VSStg8r2gOpAfM5CTb3NS9OLodI4n8LxlRqPkwMq0f/OqCOptwTFV+kCPPZCTXRUEN
	 9DeSMx6H+rAKbYcA40GRGLN/QIfoKY3CG+Z0u77njo5qAB7dX9AUcqoTUTZILGs19q
	 dXxdlcWmnc4Uw==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	vbabka@suse.cz
Cc: mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/4] (k)vrealloc (__GFP_ZERO) fixes
Date: Tue, 30 Jul 2024 20:49:40 +0200
Message-ID: <20240730185049.6244-1-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixups for [1], as discussed.

[1] https://lore.kernel.org/linux-mm/20240722163111.4766-1-dakr@kernel.org/

Danilo Krummrich (4):
  mm: kvrealloc: disable KASAN when switching to vmalloc
  mm: vrealloc: consider spare memory for __GFP_ZERO
  mm: vrealloc: properly document __GFP_ZERO behavior
  mm: kvrealloc: properly document __GFP_ZERO behavior

 mm/util.c    | 16 ++++++++++++----
 mm/vmalloc.c | 24 ++++++++++++++++--------
 2 files changed, 28 insertions(+), 12 deletions(-)


base-commit: 4152c2f7b8af8c270686a4aabda302ec22b0e099
-- 
2.45.2


