Return-Path: <linux-kernel+bounces-385810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A84B59B3C06
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9FDB21547
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FEC1E0080;
	Mon, 28 Oct 2024 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLcNMVAy"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231421865E3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148041; cv=none; b=pRXBjyxb/U3C7hz/tJw3dhSMoo71kel9aIH682C+kWXTvl1fVEbDoTiwWl0tVvn1LNbOFq9zgJhsyolUa9kI46Qi2gR0IxrC/3rsvE0OJrtZICYnhkE8X6Oyr1NFSqk1+hilBJd3WGS2+tumoUEPPBJyXPSWCkrgGBJPqgFjZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148041; c=relaxed/simple;
	bh=9dz6xZ6hfPJdTpur8atS5MT/XDt9GvHX8LySPoDh2rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0zwZo6Fqo5h6XL1HbvXO1JJw0fzcUOBMZLi6H77W/CPJZ0r8OCSBFdeKl/wGpUAWdqSD1AVFGsmc+vXnqbIu98/fCSQPz3kiiPYNDikI2J/BBGV5FBVLOqTa1IqRpL0xr382T1Y8vQdP/vGNmWqVH5DFRu1iuxiYiocxRkbD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLcNMVAy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ca4877690so7635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730148039; x=1730752839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9dz6xZ6hfPJdTpur8atS5MT/XDt9GvHX8LySPoDh2rk=;
        b=FLcNMVAyAqQKGnTi1BRcKhCvvUHlB7BK4CjLqHQX95jI/7FvY0RxiIwyV1dfRn6ler
         S74l2VXo8jLVbw5l1WY5zVui7lwZbIBuGPTc4AiYixPKd2IopZMKe/MYQxUKT1q5fSyn
         yAQc/YRZw8haeehYxGtcYTN9G7cKermgcAfjQ9CmNongY2F5zkesn5DlcZIL0nI/ZaU1
         PZRz1YLNEjJK3fFLrsbVBdM+w3UAxrw6qD6fLrQH+X0MeeI58VAuRDGQMucBsw6ZwL06
         NsipFZI+Q5YD5l8lO5/K7qDHzWYF4WsyqsFAsyyTBY/rHBeWrqDtw1DxgI+/DN/U7pGM
         Z0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148039; x=1730752839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dz6xZ6hfPJdTpur8atS5MT/XDt9GvHX8LySPoDh2rk=;
        b=WdAnt7MGytcqjdHAfDw8DiZi8UkIO2rxQPWPCMdY20tio1nncICgs0r6SVV3yret0i
         uziXC+SUSKQIdizwsmfXpgHMxhZzg6+rh+kEQzZRw5HhWvmtxkmxWB9cibMxp26eHqP1
         njiaxo4C+KIHPllM9lRMClITVt3iCluJhuSp5bgC3jJky6pTuF/Aty65bmyXPpoUCsV0
         Z+YpJ3CHiRgkJ7LyNRdQ/NGmWmWU5mCGCFJqtZ5wxsjWudogKtosB+DlYVQ5gkJS+H+3
         XXmFGsLvOWhh9rJaTk4+oerDvunQEn0ActiYYa9LkIo09hvc3dlFDWI6xVU70fjVQ/+H
         AeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj4PjaXHCzv+ohGSHqQwrXy1JFgYiXkefeRn1Kqnr0Y2AIG6mSGtF1O+QazwsoK1iJRW+HslPXqWDW6QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6J9Cpmd912ImuxGIJs0PIBtciCiBSgpzP5Da47YxkZv3+AQw0
	yMZ76KgW0cq89w+kBseyD5lUV5cfE56Ouo4jq62/VUpYWqZW+yBSUNYdNdhvLxmJpsKEj1I5VHJ
	n/rg0+SpRuMjqYoRIVCqAMhj0EsenALhKZeVA
X-Google-Smtp-Source: AGHT+IGB1o9kvUvh/QFl8xL0rGLeL+ikmejkDsOlqWvJb4vUOzxHKYG5r6pGtIKwZsTh9QyBvhOiphYmOeU78cjIOKk=
X-Received: by 2002:a17:902:f682:b0:20c:5fbe:4e66 with SMTP id
 d9443c01a7336-210eb03e797mr82515ad.27.1730148039166; Mon, 28 Oct 2024
 13:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028190927.648953-1-mathieu.desnoyers@efficios.com>
 <20241028190927.648953-5-mathieu.desnoyers@efficios.com> <e18e953b-9030-487c-bb8a-125521568e9e@efficios.com>
 <CAEf4BzZgSPXyvtBZuB+W3fp=C8QYSHsd0TduxWE3Le+9e80-UA@mail.gmail.com> <588eb8e1-5035-499f-b19b-8b40a9877433@efficios.com>
In-Reply-To: <588eb8e1-5035-499f-b19b-8b40a9877433@efficios.com>
From: Jordan Rife <jrife@google.com>
Date: Mon, 28 Oct 2024 13:40:26 -0700
Message-ID: <CADKFtnT59wzKxob03OOOfvVh67MQkpWvzvfmzv3D-_bGeM=rJA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 4/4] tracing: Add might_fault() check in
 __DO_TRACE() for syscall
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

> I'm still awaiting for Jordan (or someone else) to come back with
testing results before I feel confident dropping the RFC tag.

I can test this later today. Considering there needs to be a fix on
the BPF side to fully resolve the use-after-free issue reported by
syzbot, I may combine your v4 patch with the bandaid fix which chains
call_rcu->call_rcu_tasks_trace I made earlier while running the
reproducer locally. This should give some confidence that your patch
addresses issues on the tracepoint side until we can combine it with
Andrii's fix for BPF that consumes tracepoint_is_faultable(). I'm open
to other suggestions as well if you would like me to test something
else.

-Jordan

