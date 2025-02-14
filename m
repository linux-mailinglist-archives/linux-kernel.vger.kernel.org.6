Return-Path: <linux-kernel+bounces-515784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9032A36904
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7514216C428
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C6B1FCD16;
	Fri, 14 Feb 2025 23:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AvS1Vi5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C71FC7CD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575289; cv=none; b=kg8ch15nWZL/lB7d9MkCp3y6D5xyg00fjgMbiGCgPW5j0HAgj9L6SqzI7gmjGwAwnEogjAbkyMQRasxLVlqOaJNXvch2BX6oH/wCo/a7SV8as/0zFND89DcrIHKSaFhoCq1dYmnTlc2XUbN0pJ80xjT+bQOVjcAF1WE9EHju3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575289; c=relaxed/simple;
	bh=Sn49x4GVqGn4nDq2MMDv+oDV7GGxMn241Y5xqPcIKbg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ObL/b0h1mo9GC2HGTCWff62bly3O4k2ixj415XYo6p/Vw4jvIr+yYSJRTmK+GkplWV1cNuEs/Wc/FFQK7zI3XM0gYsRjRb3+54/VUaVbgUOiE/Lja1mbr9iOO4AfDTfkKz6/GAjQ2hUYrgvHTybOx+VBZ65y3hVrozc3j50bHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AvS1Vi5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1739C4CED1;
	Fri, 14 Feb 2025 23:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739575288;
	bh=Sn49x4GVqGn4nDq2MMDv+oDV7GGxMn241Y5xqPcIKbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvS1Vi5L986Qd8t9fyyJXInX+Iy3wFqW1PnE1/eUUUuvXn7z33WlNdHl25NG37/wj
	 IACJm1Vnh6WCdRIDh60d02XxDoTlkDG1hSXzVIPiePpceOBtznFO8NmB7XCrT5gT8z
	 MBC3NWC4Em3Hg5g2ZrgwbZUKAU1BTpPYsA524VIc=
Date: Fri, 14 Feb 2025 15:21:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Liam.Howlett@Oracle.com, brauner@kernel.org, lorenzo.stoakes@oracle.com,
 willy@infradead.org, davidlohr.bueso@hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc: fix to protect IPCS lookups using RCU instead of
 semaphore
Message-Id: <20250214152128.61a1054b90d1a53eff9cf16b@linux-foundation.org>
In-Reply-To: <20250214180157.10288-1-aha310510@gmail.com>
References: <20250214180157.10288-1-aha310510@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Feb 2025 03:01:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:

> In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
> only calling idr_for_each(), which can be protected by the RCU read-critical
> section.
> 
> And if idr_for_each() is not protected by the RCU read-critical section,
> then when radix_tree_node_free() is called to free the struct radix_tree_node
> through call_rcu(), the node will be freed immediately, and when reading the
> next node in radix_tree_for_each_slot(), the memory that has already been
> freed may be read. 

A use-after-free?

Is there any report of this occurring, or was this change a result of
code inspection?  If the former, please share details (Link:,
Reported-by:, Closes:, etc).

> Therefore, I think it is appropriate to use RCU instead of semaphore to
> protect it.


