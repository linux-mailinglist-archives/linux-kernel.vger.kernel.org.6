Return-Path: <linux-kernel+bounces-399719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C339C0363
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE91128862B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E9D1F12F5;
	Thu,  7 Nov 2024 11:07:46 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520191373
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977666; cv=none; b=BAcbgR8XPh1+CqmWVPwv1nsNr9ZXcvz/Q5gb+Xoms4ix6A8gcF4/VVmRNPx4Kr6BLcBRYN0bUjJ7FJYsrIaflOSwuOGSRARGyKNUTyUyCzSZY0t9WyWnLy01UrdP/QkX/CiZKVtAPyA/xqanrEi7mfopIRJHsINIwA6SIJUPz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977666; c=relaxed/simple;
	bh=JHt1Cd8CpOyb/zmK13q/K55ly11u/rSJOmQ4ZUMljrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QQjIBxSlq33UQZ2YAPLI/iVc7P2sa7nU+3T8dwJOMC3qYDs4guzZlcL5UzkALQBFDNhVDorsEmiMQaQXdYVBwgtSB58VeUfnH9jbQLQn73pjqnKRmExc9bgO3D6qRDpAXVWgj29l/zmSbpdOhokwX2tl5CwS+jhSKjGZH9GkVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.160])
	by sina.com (10.185.250.24) with ESMTP
	id 672C9F6E0000104F; Thu, 7 Nov 2024 19:07:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 71537510748368
X-SMAIL-UIID: DDC5A6679C8944CF9449AFCEBDEE1A87-20241107-190730-1
From: Hillf Danton <hdanton@sina.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Date: Thu,  7 Nov 2024 19:07:17 +0800
Message-Id: <20241107110717.3441-1-hdanton@sina.com>
In-Reply-To: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  1 Nov 2024 18:50:33 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Locking around VMAs is complicated and confusing. While we have a number of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documenting
> how locks are expected to be interacted with when it comes to interacting
> with mm_struct and vm_area_struct objects.
> 
> This is especially pertinent as regards efforts to find sensible
> abstractions for these fundamental objects within the kernel rust
> abstraction whose compiler strictly requires some means of expressing these
> rules (and through this expression can help self-document these
> requirements as well as enforce them which is an exciting concept).
> 
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and relies
> upon us handling these correctly).
> 
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardown.
>
What is missed is the clear guide to the correct locking order.
Is the order below correct for instance?

	lock  vma
	lock  vma->vm_mm

