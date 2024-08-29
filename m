Return-Path: <linux-kernel+bounces-307056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B46964766
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7970B1C22F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D181AE846;
	Thu, 29 Aug 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hnIRSAWi"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19B1AD9E0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940008; cv=none; b=SUbeiCImoRmsIV6nJWIpkLMDJ1kVoEdAomxF7PqBmCRqYSyQCchKLgzG6nGzNf4fh1JVjQb90Pa9MnixMJq/ON09bxIN8kTOE+NgwrxvXX85xMU/9t3Dej3j2SsmmVPDGWNGRkKAphuP+E+8SB7Wb8T/1SnaOC0DLiob56VITUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940008; c=relaxed/simple;
	bh=HEfiEFPZVTpEqpV4tcSnQGziSY7uZgU5bMcKYdf0NKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r13yX0t5ocsd3TiYBHFrNVNuyYNK3jT7+9f40Otsgv4OmZWnt/wLocSfUTxmf3+hGjBoqB8lU/OhbY1ztkXzZ/6WgjlUtwACDRB/rJK8yzuI+mRvRI9Ux36Delw18BHkh3G6zydBmJewZgZWg7GLmxxh/ifCtsV+EY52JvjlhXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hnIRSAWi; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724939999;
	bh=HEfiEFPZVTpEqpV4tcSnQGziSY7uZgU5bMcKYdf0NKM=;
	h=From:To:Cc:Subject:Date:From;
	b=hnIRSAWiRjM11t5lXHr7DoTBoiOwxUivQfvbkPteap7xhdlEDKLETt7/M0wB70/pa
	 /xP00dK02OVETXaDbQcBSeHvN4IzI425bAjZqzKuuu4Vy+33DzFpjZm+yOI5+VyFsT
	 0UqmlKsxZKPrXUDIz6fdLGLo1E/TAWgUMk8omSoFTor6jCdr4KP4npZpg5pPwB810E
	 0oN13J9Jg5oGeysFv71039lG54HRSpJuU0DeLpttHWsGUp1zu9BdgKGc3CqWUaj04y
	 n45H1nOn6FmwaHAdGnOIPnE1DsLF3VGKh0kTfNJRr299QF6gVNNh4xhstJ/LqqaGxc
	 S/0DDznBXXHoA==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Wvjb30Qwxz1J5x;
	Thu, 29 Aug 2024 09:59:59 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2 0/6] lib: Extend bitmap find binary operations
Date: Thu, 29 Aug 2024 09:59:20 -0400
Message-Id: <20240829135926.926603-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend bitmap find.h and cpumask.h with additional binary operations
such as "nor".

Also extend the testing and benchmark coverage of those bitmap find with
binary operations.

This is useful for NUMA-aware rseq concurrency IDs which depend on this
series.


Mathieu Desnoyers (6):
  lib: Clarify comment on top of find_next_andnot_bit
  lib: Implement find_{first,next,nth}_nor_bit, for_each_nor_bit,
    find_first_andnot_bit
  lib: test bitmap sets binary operation iterators
  lib: Fix test_find_first_and_bit and test_find_next_and_bit benchmark
  lib: benchmark bitmap sets binary operation find
  cpumask: Implement cpumask_{first,next}_{nor,andnot}

 include/linux/cpumask.h  |  60 +++++++++++++++++++
 include/linux/find.h     | 124 +++++++++++++++++++++++++++++++++++++--
 lib/find_bit.c           |  36 ++++++++++++
 lib/find_bit_benchmark.c | 103 ++++++++++++++++++++++++++++++--
 lib/test_bitmap.c        |  81 +++++++++++++++++++++++++
 5 files changed, 396 insertions(+), 8 deletions(-)

-- 
2.39.2

