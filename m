Return-Path: <linux-kernel+bounces-555270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9C0A5ADD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1403AF10A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8451221730;
	Mon, 10 Mar 2025 23:34:25 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25531EF38C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 23:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649665; cv=none; b=qh0kyXi5A1bk97uRPectfpRQdVJIeJqeMMKIzMzx8tfbSIgAYanIJ11PohMpXwl1tha6PcRlrCkh0hQmJInthlhzkEgqKoVm+39xw2rZw8xpiwTllKf+EjggeDcxnsl8224U5CqLzxxYnxMVW2ved0vYHt2oBAx9IhTw6Pm17PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649665; c=relaxed/simple;
	bh=HPI6pp6v/rLFcnduzP/OxPEuynRrIMy6vqk5Nbwe2i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzafniKTG6SU4vYtQYul4/fgvtySAOnaj1OTfJfhGnqxuEMeSpiJJbqIZ098rz5LOBhStox+xgXLHDQ3nY9xph3uLwNKxpEy2ZA6tyCTrRGwBeL3QFx0d90WOjiuurXNY/AavVgpVX/vpQ1vkgwXw3ZmrrRD5aLiPJ6L7MyIP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.113])
	by sina.com (10.185.250.24) with ESMTP
	id 67CF76E7000034BF; Mon, 11 Mar 2025 07:34:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 74749010748300
X-SMAIL-UIID: 113EEC134AE8467D8B99103C86904F81-20250311-073407-1
From: Hillf Danton <hdanton@sina.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Date: Tue, 11 Mar 2025 07:33:49 +0800
Message-ID: <20250310233350.3301-1-hdanton@sina.com>
In-Reply-To: <20250310124341.GB26382@redhat.com>
References: <20250304102934.2999-1-hdanton@sina.com> <20250304233501.3019-1-hdanton@sina.com> <20250305045617.3038-1-hdanton@sina.com> <20250305224648.3058-1-hdanton@sina.com> <20250307060827.3083-1-hdanton@sina.com> <20250307104654.3100-1-hdanton@sina.com> <20250307112920.GB5963@redhat.com> <20250307235645.3117-1-hdanton@sina.com> <20250310104910.3232-1-hdanton@sina.com> <20250310113726.3266-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 10 Mar 2025 13:43:42 +0100 Oleg Nesterov
> On 03/10, Hillf Danton wrote:
> > On Mon, 10 Mar 2025 12:09:15 +0100 Oleg Nesterov
> > > On 03/10, Hillf Danton wrote:
> > > > On Sun, 9 Mar 2025 18:02:55 +0100 Oleg Nesterov
> > > > >
> > > > > So (again, in this particular case) we could apply the patch below
> > > > > on top of Linus's tree.
> > > > >
> > > > > So, with or without these changes, the writer should be woken up at
> > > > > step-03 in your scenario.
> > > > >
> > > > Fine, before checking my scenario once more, feel free to pinpoint the
> > > > line number where writer is woken up, with the change below applied.
> > >
> > >     381          if (wake_writer)
> > > ==> 382                  wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
> > >     383          if (wake_next_reader)
> > >     384                  wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
> > >     385          kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> > >     386          if (ret > 0)
> > >     387                  file_accessed(filp);
> > >     388          return ret;
> > >
> > > line 382, no?
> > >
> > Yes, but how is the wait loop at line-370 broken?
> >
> >  360                 }
> >  361                 mutex_unlock(&pipe->mutex);
> >  362
> >  363                 BUG_ON(wake_writer);
> >  364                 /*
> >  365                  * But because we didn't read anything, at this point we can
> >  366                  * just return directly with -ERESTARTSYS if we're interrupted,
> >  367                  * since we've done any required wakeups and there's no need
> >  368                  * to mark anything accessed. And we've dropped the lock.
> >  369                  */
> >  370                 if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
> >  371                         return -ERESTARTSYS;
> 
> Hmm. I don't understand you, again.
> 
> OK, once some writer writes at least one byte (this will make the
> pipe_empty() condition false) and wakes this reader up.
> 
> If you meant something else, say, if you referred to you previous
> scenario, please clarify your question.
> 
The step-03 in my scenario [1] shows a reader sleeps at line-370 after
making the pipe empty, so after your change that cuts the chance for
waking up writer, who will wake up the sleeping reader? Nobody.

Feel free to check my scenario again.

step-03
	task-118766 new reader
	makes pipe empty
	sleeps

[1] https://lore.kernel.org/lkml/20250307060827.3083-1-hdanton@sina.com/

