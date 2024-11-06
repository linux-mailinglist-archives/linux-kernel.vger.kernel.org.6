Return-Path: <linux-kernel+bounces-398975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0819BF8CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B8CB228BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 22:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE82207A39;
	Wed,  6 Nov 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NP7AwOnm"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B10D20495F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930403; cv=none; b=hzPikl52Y/pJa1BNFCS799Xdxt7BTt1ibYfNRLqRprvaMxfCIcqUR9YGs/NtBqaeaTjcvN3gvfMbnlWkQEpHI5Z8VKTzZSlpG4ef11uz4QTXzPcoXf6TQVWISL3MJm9Tr4xHasfsePCES/+I49upz3PTV5ekM3zWgbn1m0eh0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930403; c=relaxed/simple;
	bh=Dxb4/6/36affsib/O+PJ+ffEY/uk+DTB5RSnQyNRnpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcR8n4EUfM0nQqqRegS/VFrKybboQCIl/e30+WCn1nVbmDnjCIdBx1U99Lw+QW7lxx4XjKshIob5JPjHZtfMlOLyp8kcJ7hWP2NZwLkFJs2KsNj0BN9OtdP5YZpPBx+Jjt/S951uYbbd+ZH9e3mgiSBZ4ybA/nL6vgXzy8HkPl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NP7AwOnm; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so237489a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 14:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730930401; x=1731535201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Es3p6p94eraJRLtbFRw7m7Hdwqby+HzOFvb3PHSaFg=;
        b=NP7AwOnmZ9GLFrp/oVTVJAx6dEL1Ww3CGaavp1cqZzng2YShGTHATskq3EQZLKSgG7
         YWm9sPDlGGHnefMGhBhyaRxvmNU+fu0xB43m3cvRy6CZAvJp/Q1ahmBbF70bClqlXuDA
         zXS/vqfEzVzpxLcUj0An4kkTBU3Iq1bEGm7pVmIAZheyvSXEGbUZsVH6CjEQqaFKHViS
         BbmtA0b7qv3a17KG5pfQ0xXnKPUsnau4oALOKtHZQCeoQFtVarV/EYjZFXlyUpd0Weg2
         FurVhal2qrbq8Wy6G3g0+5snbYYzItqKLB1fxqNS6Beiv34DADIVvsJpVEQZ2Ts3xCQC
         oIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730930401; x=1731535201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Es3p6p94eraJRLtbFRw7m7Hdwqby+HzOFvb3PHSaFg=;
        b=YBE9eRZuV0NlN8X7OuEPaRv4V/0DsgAhrVzyXoH00m3fCDN6PKcM2S6besBvWByKog
         Cn4TvUtWf+LTWdXXAhdZjsX5ZYfgf6ebGFL3FYGjPikWNUBe9Bar/qVpYzG8N0MmElbk
         c5bOjD9f1IApBRuhQqjbDxBMIiJPR3HXnO2bnmi7mmdTPNWKm9PyTIrFRHZoxVacDxT+
         s4jf/hOOVK4ybohywGRZJ8zZybZmi9oZK53GHYUGUJJciiE39vLHmOPcBGWCPgppa8xT
         iUg+IRfLhyG5sN00g9Co8Vnkzv4yuzg0OBda+MMr2qGAyevRKRC0aU9Tg8HwE3OBUAwh
         lMGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTJZx+uUlnJllIcMe5U7YjCL4HrE6/4N3dNv8/NymWmA3kcD41cF3clgDaGRVVDn99CXlkbPulAGqZW/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCFIodmbE9HmmjDrIzOZkSaopHHGVqBZilbTYc3JoT56DfXlDX
	nq2CUweN6W6p/BVlhmKo82sG0Z7DfVcdBYO6N+wEqA0pEZb64DFZaKqzOydlHjepiT1O4B9XKbH
	dzw9ROG4sbwBcM8vKSbPiFBEr7iw3UbktQxre
X-Google-Smtp-Source: AGHT+IEZLGNIimSbo/bhWn6P2ldR43LdNR4/3zsRJ00TNvlOTTJ7yt5Vn9HuykGDPw5SX87MzIKTxpvA5b2yEhWcddE=
X-Received: by 2002:a17:90a:b305:b0:2e2:b937:eeae with SMTP id
 98e67ed59e1d1-2e92ce2ca0emr32021282a91.5.1730930401453; Wed, 06 Nov 2024
 14:00:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133610.1937089-1-elver@google.com> <20241105113111.76c46806@gandalf.local.home>
 <CANpmjNMuTdLDMmSeJkHmGjr59OtMEsf4+Emkr8hWD++XjQpSpg@mail.gmail.com>
 <20241105120247.596a0dc9@gandalf.local.home> <CANpmjNNTcrk7KtsQAdGVPmcOkiy446VmD-Y=YqxoUx+twTiOwA@mail.gmail.com>
 <CANpmjNP+CFijZ-nhwSR_sdxNDTjfRfyQ5c5wLE=fqN=nhL8FEA@mail.gmail.com>
 <20241106101823.4a5d556d@gandalf.local.home> <20241106102856.00ad694e@gandalf.local.home>
 <ZyuxmsK0jfKa7NKK@elver.google.com> <20241106162342.3c44a8e9@gandalf.local.home>
In-Reply-To: <20241106162342.3c44a8e9@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Wed, 6 Nov 2024 22:59:25 +0100
Message-ID: <CANpmjNMMvZPWJG0rOe=azUqbLbo8aGNVZBre=01zUyST40pYxw@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 22:23, Steven Rostedt <rostedt@goodmis.org> wrote:
...
> > That's pretty much it. I've attached my kernel config just in case I
> > missed something.
>
> OK, it's because you are using trace_pipe (which by the way should not be
> used for anything serious). The read of trace_pipe flushes the buffer
> before the task is scheduled out and the comm saved, so it prints the
> "<...>". If you instead do the cat of trace_pipe *after* running the
> command, you'll see the comm.
>
> So this is just because you are using the obsolete trace_pipe.

I see, thanks for clarifying.  I always felt for quick testing it
serves its purpose - anything equally simple you recommend for testing
but doesn't suffer from this problem?

Thanks,
-- Marco

