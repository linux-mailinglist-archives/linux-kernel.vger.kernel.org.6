Return-Path: <linux-kernel+bounces-382548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EF89B0FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264691F239BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DFB20D51C;
	Fri, 25 Oct 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmF5MjPr"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFBC1F7566
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887483; cv=none; b=RIGs4LdMxfUmS5xp5v9RNilrzYEcViJE+n11hR3Bpk7umGzWIl2TICd9lYsVdVScQ4NptsyNwU8lgZZZFgNUvICTEEVAu/TpBncF3bt1uE1gXtiIJNEHx+YABeODUxD6WY8No20R57iFC7x/phet/u1reAnjlqyonaBqx215W6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887483; c=relaxed/simple;
	bh=ZX41vGUQ46c6s8VMbnNN1Ce+/mHK2M187SNW47zXQLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4mKjqIYTrRCWpir9KhnsFpCmWggkV9WizRLM1JgbdTJ3fa6NwDLxb6MGciwPTSgMotGiJGJfY5nLqSG3kxsurBEfCujt/1FfakF6cDFkq8CzAj+PL/TqDxISgXdwlkTlMaDgLDqL10+/C81PHvhHAtNuCMYJt63nLuYN8ZLWPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmF5MjPr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so11485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729887479; x=1730492279; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX41vGUQ46c6s8VMbnNN1Ce+/mHK2M187SNW47zXQLY=;
        b=RmF5MjPr0heepwWo0tiWq/zMy4mVmGrgRLn3zWsd963InPgP/FI5T+q1z0Uaj+89ea
         Ym1L45IBiKY2e3pDC1Ryrx2izUsBCj9pHjNLFg+d0uHLQsR+hQMvV5NP+waZThnuT3Cp
         eS/f1KrJGTHcocElVbc0O5iJJO3aipvsSpkGHmQJe9aJz1LqqT7vZpCSMlW6StxioJ7/
         vE17Kjoknke+r3gGXZSg2wfR4po0C/KER9COhYMBcr8Ii4RdSuSbtWXJOsF8o4j4koh0
         MeAFSELKbKMzc9wunYtrYoDQ06KyisKkXookMC/MKDsamHxBAR2QVXTqZNzumwJV4dnO
         zHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887479; x=1730492279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX41vGUQ46c6s8VMbnNN1Ce+/mHK2M187SNW47zXQLY=;
        b=KyuuSJ0p+brNdp6HwHyPcPMOHmw4wesb5sRhzs3sQ77yIK6VCOVw0BEFU9hAJHF18N
         0DevkZjsZtBwlntaEvJMIACi5GFASqTBIU1qqZkaeKzQy295TGm8ZBxQ3i8FG7v+jR0g
         VYngesHW6mZj82ZtmHl9amGm6WbzFtzxI+OxR/tgv6zIO/1t1KqSNV2vSEReCozQxAgg
         8tUYCYk3OEP1D0L+dAluqW6qT6ZGQI35rZP3EEeyu898kv6CGFJMwFX1pdSYC+Q8cCDT
         n/esSRtq7+On3VZSaIYtXO2yuG+fKidWdhdtNBp2NYD6zCmqD4XxmwUYc2hJapHMN+zd
         97xg==
X-Forwarded-Encrypted: i=1; AJvYcCWAsWZOKC+ZSbHsGaUHJXDGaIkoxepeXsYVMgHOCh4r8jr7TXDxO1tUoTiW/We/lafMvcDHNJvOqGaqZFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdyR0uCwCSB2MZkLqcAb2bIfL+CuvF/lDfwCTAV1wWe7Yjdt5
	KYsdseXyWiICSiHK2KDkg62v+M9kXSUtEG6rR8yqXIj8yvcU0VxMHZwK1vWXkpQxa3RSN8guXmz
	vBwoXd4sewcwKxliNE4MwTs0r8Fhf+/961Zfh
X-Google-Smtp-Source: AGHT+IEnqPQIQgwOCRRh7O130t7gbS5cZDLzm7QuIfbNAGvRQUgHHeRxwg7a7fgz8a+q5UlTLGaStqa2Imj0eFkV9Wc=
X-Received: by 2002:a05:600c:1d97:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-4319bdd0fb5mr20585e9.1.1729887479277; Fri, 25 Oct 2024 13:17:59
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829220427.2764399-1-joshdon@google.com> <CABk29Nv=Gj9H0dfvdV0E9us+jBnysoPXYoO-Rkn46rwGtg7=hA@mail.gmail.com>
In-Reply-To: <CABk29Nv=Gj9H0dfvdV0E9us+jBnysoPXYoO-Rkn46rwGtg7=hA@mail.gmail.com>
From: Josh Don <joshdon@google.com>
Date: Fri, 25 Oct 2024 13:17:48 -0700
Message-ID: <CABk29Nuqfux0MMinx2Ug6U6_EF72ukahYnuvsSb=Hfnd=g6-xA@mail.gmail.com>
Subject: Re: [PATCH] sched: fix warning in sched_setaffinity
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"

> Gentle ping to bump this in case it got lost.

Nudge :)

> I've also collected the following:
>
> Acked-by: Waiman Long <longman@redhat.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Also adding

Acked-and-tested-by: Vincent Guittot <vincent.guittot@linaro.org>

Best,
Josh

