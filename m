Return-Path: <linux-kernel+bounces-202787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA008FD113
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4746AB22F17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6151F5F5;
	Wed,  5 Jun 2024 14:47:12 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4900319D8A7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717598831; cv=none; b=YDJ42EGXdHT3Yjj1KREm47sAt+4/URSO1ApZT9e90/qB9M6YJxRszsLXrZKZgVJ2Ceg6U1ej+McSrsbexPQ4JXD/kE8JH6AU2zZN0DVxaLndC6W4+U6yJ5eBbGlDzoABbHc3dlqhWaLITkfntHByZsiA6mhqhAEv7nOz+5QDxAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717598831; c=relaxed/simple;
	bh=26Mmd5wjZFDXiPuulTYjpvu+4ei/osZxeFNfc9g6u/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gnk+7qEgbPV6Hca0vfi2FW/s+Yhg5hshla9lAiW4GUqyIipMG65ZYSJgtBq092i0/z1TbkTu8120/UuJHNd5JnS4oHf4SNNbHpz6ISgecTj+XBLHi+X8UhuPvea6MDK3i+Fm08YpnmDkuMoo88x/Cf0VRtvuxCfzc39OaLkXXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 198843 invoked by uid 1000); 5 Jun 2024 10:47:03 -0400
Date: Wed, 5 Jun 2024 10:47:03 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: New locking test for the paulmckrcu/litmus github archive
Message-ID: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Paul:

Below is a new litmus test for the manual/locked directory in your 
github archive.  It is based on a suggestion from Andrea Parri, and it 
demonstrates a bug in the current LKMM lock.cat file.  Patches to fix 
that file will be sent shortly.

Alan

---

C islocked+lock+islocked+unlock+islocked.litmus

(*
 * Result: Always
 *
 * This tests the memory model's implementation of spin_is_locked().
 *)

{}

P0(spinlock_t *x)
{
        int r0;
	int r1;
	int r2;

	r0 = spin_is_locked(x);
	spin_lock(x);
	r1 = spin_is_locked(x);
	spin_unlock(x);
	r2 = spin_is_locked(x);
}

exists (0:r0=0 /\ 0:r1=1 /\ 0:r2=0)

