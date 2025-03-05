Return-Path: <linux-kernel+bounces-547900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE44A50F06
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682A5188F740
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE322066F4;
	Wed,  5 Mar 2025 22:47:14 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617DD206F17
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214834; cv=none; b=ogRLDs7xGyStfS4B0fxs0tf7Fqqdddkg79d2HhFrBw6VRVUgdJ1og7YethqVistSI6xc6cR3wVSysx7ULQ4iRxvdNHEjRVMP2p5E+Ory4CyIPmJJBcJcVgITratvbxfI1E4L3KcWgJcH2U3PIf3Sg77Z1+614gLZ9ETNQg4xyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214834; c=relaxed/simple;
	bh=Giysu/tjLy7TiFQnaV1VHgDDO4OdNnanXoD5UIaaXJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrdSDAeSfMetjk69eTafs6i6DbjSd5oD7QkC94mF5O+uGMXMjDD+8rfGhmnB/LGR5FrhleWObbtXfDl/jeKqwLjE4Ahq7hOBjgu4+/tg68r6ZXh9dLwumsMiyhE6FziO8Ak38JORk9qh+8Pnvy2c6GjQp33rMsZqGx49wat7dtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.13])
	by sina.com (10.185.250.23) with ESMTP
	id 67C8D4620000619E; Wed, 6 Mar 2025 06:47:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6462088913194
X-SMAIL-UIID: 8718048AE1954DBFBAC9D1D84D431635-20250306-064700-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Thu,  6 Mar 2025 06:46:45 +0800
Message-ID: <20250305224648.3058-1-hdanton@sina.com>
In-Reply-To: <20250305114433.GA28112@redhat.com>
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt> <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com> <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com> <20250304050644.2983-1-hdanton@sina.com> <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com> <20250305045617.3038-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 5 Mar 2025 12:44:34 +0100 Oleg Nesterov <oleg@redhat.com>
> On 03/05, Hillf Danton wrote:
> > See the loop in  ___wait_event(),
> >
> > 	for (;;) {
> > 		prepare_to_wait_event();
> >
> > 		// flip
> > 		if (condition)
> > 			break;
> >
> > 		schedule();
> > 	}
> >
> > After wakeup, waiter will sleep again if condition flips false on the waker
> > side before waiter checks condition, even if condition is atomic, no?
> 
> Yes, but in this case pipe_full() == true is correct, this writer can
> safely sleep.
> 
No, because no reader is woken up before sleep to make pipe not full.

