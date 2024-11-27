Return-Path: <linux-kernel+bounces-424034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827D39DAFB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480EF282256
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B702040BB;
	Wed, 27 Nov 2024 23:04:54 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B062040AF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732748694; cv=none; b=Lkt8wbo8ohE/nRsnY1v2HdxTdJ/6lgrqQkJQlkwhtqyMlpo6zfu7Zhdj43+zKiMnijhAtyoRQLWgkzDWKC3i972NvisBh77aIvIr5uZOoZy6UqCSOK4MnSF71rCeMBy/xht0b93q8xvcgeJ3VgM2B+4gsuBCaZHwL8y+/0w1KRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732748694; c=relaxed/simple;
	bh=l6uXZOteB++oHt2C0giPiuh/eidCm/Kl31XxIBqYRng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4k4S2Z7dBeX6y0QNFbFPMvDKJ0W4tIkfFuNhRjN6ACpX5kzTz4ChZ/kVO9LVrCBNpqcwl7/pFWujlppIlLv5yrDenu1xVpZUEck1I2feuCmHp7MLeCgU9grH5JRCbImxqj2hYfUETNIS8wG8I5b2eIMAJab5sCrw2EEgrgMDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.49])
	by sina.com (10.185.250.22) with ESMTP
	id 6747A55F000044C7; Wed, 28 Nov 2024 07:04:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 704267602338
X-SMAIL-UIID: 48EDDCECC3BE4FA89682D6F43BAE2AB1-20241128-070404-1
From: Hillf Danton <hdanton@sina.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ruan Bonan <bonan.ruan@u.nus.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs@googlegroups.com,
	Aleksandr Nogikh <nogikh@google.com>,
	BPF <bpf@vger.kernel.org>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
Date: Thu, 28 Nov 2024 07:03:49 +0800
Message-Id: <20241127230349.1619-1-hdanton@sina.com>
In-Reply-To: <CAEf4BzYHeh_=iHOYL88pXXdHGZuAmQNM0jM+9iPUou+7+YLjjQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 26 Nov 2024 13:15:48 -0800 Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Mon, Nov 25, 2024 at 1:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Nov 25, 2024 at 05:24:05AM +0000, Ruan Bonan wrote:
> >
> > > From the discussion, it appears that the root cause might involve
> > > specific printk or BPF operations in the given context. To clarify and
> > > possibly avoid similar issues in the future, are there guidelines or
> > > best practices for writing BPF programs/hooks that interact with
> > > tracepoints, especially those related to scheduler events, to prevent
> > > such deadlocks?
> >
> > The general guideline and recommendation for all tracepoints is to be
> > wait-free. Typically all tracer code should be.
> >
> > Now, BPF (users) (ab)uses tracepoints to do all sorts and takes certain
> > liberties with them, but it is very much at the discretion of the BPF
> > user.
> 
> We do assume that tracepoints are just like kprobes and can run in
> NMI. And in this case BPF is just a vehicle to trigger a
> promised-to-be-wait-free strncpy_from_user_nofault(). That's as far as
> BPF involvement goes, we should stop discussing BPF in this context,
> it's misleading.
> 
Given known issue, syzbot should run without bpf enabled before it is fixed
to avoid more useless discussing and misleading.

