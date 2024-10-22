Return-Path: <linux-kernel+bounces-376597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A786D9AB3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5902D1F238CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B819B5B4;
	Tue, 22 Oct 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7YqV452"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D61A3049
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613686; cv=none; b=lbDk5zwYAANWCB6stSVAVtpCjcyhbxCTOHO+Lrfoi/j4abAwO0jOilWVTyQbjYlbCvWAqHSRpTbmRrjU+ntWctlvbwdcD8vjHVGfQ8esCb438G946Srfz74DX6hdWajIweqNiDvkBsAgjWsmqC2GPsinJ09U3WLG4gsfC9D5XPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613686; c=relaxed/simple;
	bh=uQyLKf/KjMGIsuCylbyZv2NLqsDYwh8/jixtnFeFZ+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEtuhSRu14hV3/8o30fJ2fi2sbYWe2J52qaM7UN5a1xsm1S593MhScqLKBQWBna5hQxdpV+jegM6CGbhllwD5HOivr+P5+Mg5X9fmrF4V4121x0lWnNmmaFHmxybeHCFY/af1tpDB0EYZynKQu0+0p8lltBmFb0a+aGZISWGCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7YqV452; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c8ac50b79so234855ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729613684; x=1730218484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uQyLKf/KjMGIsuCylbyZv2NLqsDYwh8/jixtnFeFZ+0=;
        b=I7YqV452NoPx1tk48NK1iezUpnwGQuuQPryJ/EUgtJcf84f4m2voI7Wieiu5pEbSxj
         PlgWvWl0tsw1jA7V/2RJsCqwDfnzwMhj7kYZleuCRgS1ncFb6kkd3DNjtnBI8aH+BfcP
         T4lijDP/12uc3RJ/+uTXQzyOjgXHI0/xUoA1+5OlevdTOBSSe5gZkwQ5o6OMERk5vWer
         Nik1IXCqubLRI4KmV0Dypgt0IdcG4k5PNQUQiC1BpLY+kIIaxEDNGjH+YFZ1JtC62dIk
         LoIeP+EaFVKuF1mpC+oWrswuw/EJbnHJ+jkxQdo6Dl5VtCZIoe3kdVBgClZQ1UQu1VT0
         Oj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613684; x=1730218484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQyLKf/KjMGIsuCylbyZv2NLqsDYwh8/jixtnFeFZ+0=;
        b=AFnvxoCLozFH24y8Q3pnjci+WounC0qex9SuFuuzeI5bCjJEipm5cwBGqLqmjgXDMG
         2TD0OIEPl4UcfIZYD71x9xgbo/nYInnF1AezIvdqs8Tqx0CXDTe9GoQKIyGzcUnIahVF
         XOAbDKjAX6xUnh2zlpK/wZpF5laB7P+pIH0+wFabXh6fsIVpBddYm7gprol+On8TeXt0
         6j8YBVLEmqH9WV92cRvelcIgPna3fQEa4porpXIPPWoEteRwPcNFylPqfrg0ecSRmM8M
         Gn5+8c9Rs46sdJHrYtYy4N0nADgNbxz4DG/h7kyl9ZRtjTGMuZFYbhyB7ud870DRgE4S
         uFsg==
X-Forwarded-Encrypted: i=1; AJvYcCVqy3fUGVQwSNMfnqM8+HxUWSvIEuscpqQpos8oraA7Fqr8Z+IEiZOuNaU4grBU+iTf9g0qUnGGL8u7rqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLrnVRmsIvwyW7NwFki8h84QKV7ClsCHhvD6sUssaFu3QqDQL
	gojPPCogO9F0FxsM02mQYuxHbcL+WJOTup3lpjzLEzWInWeCYobWuS/tbxWoNl9CgegfAaNJ33W
	C4qtOHl6M94uJj/aX/yWeIVMXcYg/4broSQg5
X-Google-Smtp-Source: AGHT+IEk2C5VN5OQSxU2RTl/uiQOLCjAufw/n0qpTfSTknlIOJDwl1tjcDLh9OBuWTOSWITRPJuHGqKMAHTJwO/i8Xg=
X-Received: by 2002:a17:902:d486:b0:20c:e262:2570 with SMTP id
 d9443c01a7336-20e97fb41fcmr3516165ad.8.1729613684229; Tue, 22 Oct 2024
 09:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241022151804.284424-1-mathieu.desnoyers@efficios.com>
From: Jordan Rife <jrife@google.com>
Date: Tue, 22 Oct 2024 09:14:32 -0700
Message-ID: <CADKFtnSGoSXm-r0cykucj4RyO5U7-HHBPx7LFkC6QDHtyPbMfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

I assume this patch isn't meant to fix the related issues with freeing
BPF programs/links with call_rcu?

On the BPF side I think there needs to be some smarter handling of
when to use call_rcu or call_rcu_tasks_trace to free links/programs
based on whether or not the program type can be executed in this
context. Right now call_rcu_tasks_trace is used if the program is
sleepable, but that isn't necessarily the case here. Off the top of my
head this would be BPF_PROG_TYPE_RAW_TRACEPOINT and
BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, but may extend to
BPF_PROG_TYPE_TRACEPOINT? I'll let some of the BPF folks chime in
here, as I'm not entirely sure.

-Jordan

