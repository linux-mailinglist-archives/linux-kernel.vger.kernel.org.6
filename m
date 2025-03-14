Return-Path: <linux-kernel+bounces-561754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4C4A615BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3A1173850
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D47B20127B;
	Fri, 14 Mar 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOxLsiA8"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB1F1339A4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968426; cv=none; b=CbztS9/vgd5ZKxczv+O1qUB86tKParuKayBMF8SM+P9KxdG8QSPEdhKdYfBe6nisYIO49+LoBIO1wMoIyalamxgctsk64c69fFbc5L5dIlwloRTBVsBVlQiZ43pztEUuG2UhG5VBNWhd4pW6SnAdHhPBFEam5G5FipQiL4e6c0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968426; c=relaxed/simple;
	bh=z63DALYOCzMi0c+blpaeIPy8Qba0mK7YLbdqHgCZ1KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRR+r1mWBv6ZbSFUHdfg+Wx5wMyCVmR45DM5B2o366kwN4/jMENEJQJqBDNRT36I15stvI8mdzOVHFkHO+4osjxJ4Skv+X/423FTeEx+oYH8mdBrGW6DAQKSzm67LJ85KBkOY8h79pcbneM0H1VxqTr+5iuquWX7wE+giIymIOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NOxLsiA8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so4290725a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741968423; x=1742573223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z63DALYOCzMi0c+blpaeIPy8Qba0mK7YLbdqHgCZ1KA=;
        b=NOxLsiA8WYwvSD/clAPfZc3dVyVZFput2+f4XtyEcOr/Xrx8xXdiwhwWw/TEqrrFDl
         jaNxTGYNbNyib8gBGdg2TCLrGmON8FBMhpCO7ALIzdO0VtH19UDdGSpTTnxYkH2VsMI6
         d+/yOHLlp/BR6dkaADgkP3lwONq9p0lNKi/yolwTaI59wVeEGS3R0yOg87yqx2rvYfyT
         kpdoak6v25yDga7dT9Xuk/TfFxd3qzTCHZf+AIfjDNKljb8U5ECB8JcMx3AO0l0srLMh
         kkoxGsyuX5cLe1DQ+IrxevAWPX79LVIyA4hw8gqNDevzVbjGIDKShSAZMLkVmlDqd8wg
         M7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741968423; x=1742573223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z63DALYOCzMi0c+blpaeIPy8Qba0mK7YLbdqHgCZ1KA=;
        b=Y/HhYUC0G0Kn6JpnK0YinD9RZ5r5k17L0DBwrJFEJCxIainWkvSW0cY9w9CHbssxFF
         DbuJ1pr2MbmIyn6X1Z8v6lucPQnPZkbmE6qCrza8AWK92DPHp47W/+sGjTNL+a9nbEF9
         yMEZ1JozqhOegvMbDiexZjKCX9hkPw8kceVGajQluRlz5T3U4p7NY+nTdJFwZIusrqnb
         9tUiDngILP2v0DojRpImN6Ee/zt2Hyscbu7WsWBq/JPr5j92/WvJWX2Eqsv+YcWDRfTp
         qBJSwXYA0ZEtEB7caF+Fgm03qviF/HzMASeUOj/kPcDdIqfdo1CjBrLIZeCGjHcJikwQ
         uq8w==
X-Forwarded-Encrypted: i=1; AJvYcCVbuvZ5FZxm2bwJynX1lFbOWsOC1DfUOpfh5GF3LLh32GOP5CmNNWefk5t+B1W8Pg4uW3rBw5Ti5n9psAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2WGjhgUY/iOHE9OeXCn+xboTyTJeuuKPIjqr/UR6N4W7lMRFa
	Hyla21fVkxZhBP2bpWbIQX1R+jGIamAm2ShDLV2HvjuLxP127Jr8Phm1sBvuRLGsuv/SxrQfcDc
	1HAzoJaz3ckEBvGm7U5wAJqjrsq34Por+nV6ZPA==
X-Gm-Gg: ASbGncsceNvpB2/4maEJVI23l6hoPFbFFCxObVHO3rsgtENVeHW1wT3dzqehJAZtQFM
	+VMvLFfXQjpWFxdU0QuOeu1zctg26W+d5Uw3qc45Jw79xN9dUdlU2RZhzOJ1/1ZEz8rYuWUmlPP
	WSrEpILMAa5Wx5c0o8RCQEckrtPX1VVYnMLAs5LOANyABaCNz6AptCBg==
X-Google-Smtp-Source: AGHT+IHLdqnYcCUssk4mGHllu1vrHw10x253Sr35ZhJPBupgwWPdgt1bcLg5qwNrD6OZ5+cI3/Kzolh2Qx+be9IY3J0=
X-Received: by 2002:a50:99d1:0:b0:5e6:de5:312f with SMTP id
 4fb4d7f45d1cf-5e8a0c14582mr2787338a12.23.1741968423092; Fri, 14 Mar 2025
 09:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
 <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com>
 <8ddd7bb2-3a18-48b5-85c6-23263134308a@arm.com> <CAKfTPtD9DwWquFN6G8BXAii7HH5zJeEXiUjE8ma-eHdEqeHzdw@mail.gmail.com>
 <51d24e59-247d-4b66-9ddb-4b9f0f53497b@arm.com> <20250313092107.GA30527@amazon.com>
In-Reply-To: <20250313092107.GA30527@amazon.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 14 Mar 2025 17:06:50 +0100
X-Gm-Features: AQ5f1JqZaCUljxHdsutGonTlDmCIy9f_sWSPwqJvttIGqgONCup9-GqPNgpWHrk
Message-ID: <CAKfTPtBixgju0YX=TLbOWO4s9uHNBMSmnV=xcVBJVfU1wqrM4Q@mail.gmail.com>
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, wuchi.zero@gmail.com, 
	abuehaze@amazon.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 10:21, Hagar Hemdan <hagarhem@amazon.com> wrote:
>
> On Wed, Mar 12, 2025 at 03:41:40PM +0100, Dietmar Eggemann wrote:
> > On 11/03/2025 17:35, Vincent Guittot wrote:
> > > On Mon, 10 Mar 2025 at 16:29, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >>
> > >> On 10/03/2025 14:59, Vincent Guittot wrote:
> > >>> On Thu, 6 Mar 2025 at 17:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >>>>
> > >>>> Hagar reported a 30% drop in UnixBench spawn test with commit
> > >>>> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
> > >>>> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
> > >>>> (aarch64) (single level MC sched domain) [1].
> > >>>>
> > >>>> There is an early bail from sched_move_task() if p->sched_task_group is
> > >>>> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
> > >>>> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
> > >>>> (Ubuntu '22.04.5 LTS').
> > >>>
> > >>> Isn't this same use case that has been used by commit eff6c8ce8d4d to
> > >>> show the benefit of adding the test if ((group ==
> > >>> tsk->sched_task_group) ?
> > >>> Adding Wuchi who added the condition
> > >>
> > >> IMHO, UnixBench spawn reports a performance number according to how many
> > >> tasks could be spawned whereas, IIUC, commit eff6c8ce8d4d was reporting
> > >> the time spend in sched_move_task().
> > >
> > > But does not your patch revert the benefits shown in the figures of
> > > commit eff6c8ce8d4d ? It skipped sched_move task in do_exit autogroup
> > > and you adds it back
> >
> > Yeah, we do need the PELT update in sched_change_group()
> > (task_change_group_fair()) in the do_exit() path to get the 30% score
> > back in 'UnixBench spawn'. Even that means we need more time due to this
> > in sched_move_task().
> >
> > I retested this and it turns out that 'group == tsk->sched_task_group'
> > is only true when sched_move_task() is called from exit.
> >
> > So to get the score back for 'UnixBench spawn' we should rather revert
> > commit eff6c8ce8d4d.
> >
> > The analysis in my patch still holds though.
> >
> > If you guys agree I can send the revert with my analysis in the
> > patch-header.
> Agree. The follow up commit fa614b4feb5a ("sched: Simplify sched_move_task()")
> needs to be reverted as well.

Why do you think it should be reverted as well ?

