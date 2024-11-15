Return-Path: <linux-kernel+bounces-410860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FD49CE964
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD501F23DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323561CEEB8;
	Fri, 15 Nov 2024 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZ3BH0cd"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D41CDA1A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683208; cv=none; b=JG5oXYrFs3UYedfz3QqCaETiuVXQnDZAH5hLVVZN2c/w72gK/EtbQzRnwy2vhW3JJZeK91p9sL91ggWZ0n2hhqTCwroCzM5b7WV9vnF5gRzEArL9h2cRbczw00fkjTU+DrZxmAdGGB2PjU1mw2MDJSmpt5WxrfTzoK8lVlDaTtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683208; c=relaxed/simple;
	bh=L6rHc7bIH39FF/0gn7erG2N5q0A9lM5z0Mr12TL8uZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEcDrxSe4Y/4++IgtQeEIl4xq1/WDtypd2Ju7R8oxqHSmbnqJ91UZpAnHpWeY0QJgOIdqsZtS/LoIxkf8yLBt04CPb6CDXRcbRgoN3CWSOP9c5ESBFG3D2KmfzbSbkkspwm2856kjsqRWMsDQBgdL5PbTxXUAWUqEhYeK5zGVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZ3BH0cd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7240d93fffdso732128b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731683207; x=1732288007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L6rHc7bIH39FF/0gn7erG2N5q0A9lM5z0Mr12TL8uZA=;
        b=bZ3BH0cdpGqjLW/Zy1Su3xOAXFJG64gGA19W1qzxzuZimGCtfPiSnIQF/RA9wzk2sO
         xmC9DoW9tsNRxJHENh336HU1fVe6aYKch+Kfgy8vArCS8JLyohnGxDFfEuChqlJMO1uc
         ye6wzVcV5WPvpCdHWZVpbR4/+VY2MYU1ktck7ot1B4v8PvUh+19FMiNQmpZH3Kp+gpjg
         rWeQGduyfOZZCF5f715Q26J/hYLvC5LtymhxzJSRqiVFwcf80femPdv5afKPDxh1EGGn
         91JUfZHLrCu0i6rgPalNVsbnuqQYnQmNwlWtQvlUkxT8GEw4z697c/ublA3aZ74RD+M3
         a92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683207; x=1732288007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6rHc7bIH39FF/0gn7erG2N5q0A9lM5z0Mr12TL8uZA=;
        b=D6NEhN8l9/d/TZDUBLAKjvbByeq8emp95SQw+UHr2LovQG35UamBEvsNSuCVvhD9Bg
         JyXHhT9jx/vhxSNKFHwcJDCy4id8zL15QJnxNLu0Z5Ioxc33/acYhS3ChrxKZf0MhSzc
         Bmu+mc4FzgcgdA6WlRCJbx32ZrkkhWcaz17ChlvmOdtS+ZXbMng9bYbEYtFOFavCX03y
         ePrw5TuvTeSEp66ARU9JgGtqB09W8Kt0Olrub7pDtgyNuBtKTJYgTTL/6qLEE+9C+aE9
         UZH6raOWiKy47fM3yIkURf1YgUJFjwjWQg028kMaZ64uDmKXOdWhkzz/OmrT53MOKrl2
         bYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK0VOLVmB6rJBuxgKkgsphdMXGUZkX2jiWN1QmesJcvnF7qMuD3MlT0jjzBqyajVSUsGIOSJtfZFLVwEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4SqHBKfFXCXS4DaBppFTP30j2sh/lG+rXboj8B2aYsxiQ88f
	gWFyjOpstoQBB8GWnwCj3w/3hEC9HrziYDWDePbd3WzqBomSIx2/L2JI4T9IN6VbcOojAz1v5lx
	rlen2dWA0JGHM0LyZ+RuO+z78pc8XOKzlwKG8YqkqmXyXMNOc9g==
X-Google-Smtp-Source: AGHT+IEUgPtK0zm9JlHmILKAZrzqF/XanePDYjHMFgQeF9qQLS2OeBR9J+dbTbFzei2pMXsVmlaqR4ic11xSOoquQpQ=
X-Received: by 2002:a17:90b:3b46:b0:2e2:ca4d:9164 with SMTP id
 98e67ed59e1d1-2ea154f71e0mr4241757a91.12.1731683206476; Fri, 15 Nov 2024
 07:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108113455.2924361-1-elver@google.com> <CANpmjNPuXxa3=SDZ_0uQ+ez2Tis96C2B-nE4NJSvCs4LBjjQgA@mail.gmail.com>
 <20241115082737.5f23e491@gandalf.local.home>
In-Reply-To: <20241115082737.5f23e491@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Fri, 15 Nov 2024 16:06:09 +0100
Message-ID: <CANpmjNM_94fmQ025diHd9_vKtRxtDbSYaOpfBbshNQYEPQmHZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 14:27, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 15 Nov 2024 13:00:00 +0100
> Marco Elver <elver@google.com> wrote:
>
> > Steven, unless there are any further objections, would you be able to
> > take this through the tracing tree?
> >
> > Many thanks!
>
> This isn't my file. Trace events usually belong to the subsystems that
> use them. As this adds an event to kernel/sys.c which doesn't really have
> an owner, then I would ask Andrew Morton to take it.

Got it.

Andrew, can you pick this up?

Thanks,
-- Marco

