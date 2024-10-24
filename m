Return-Path: <linux-kernel+bounces-380442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554349AEEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A7F1C21C94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A551FF608;
	Thu, 24 Oct 2024 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdi2L2Ny"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE91FF042
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792260; cv=none; b=DwT+c1e1OJST2EfzMlM03SkrhJGh8Q6MbLKfY3KRrRfwtbPwzIufgTKOomm7EVfUcuP31v8nvlMbzYKu7tVuQO1+GH8+B4C5OotT60FRi3hWtLXHHjL7KLg4TMycRMRI1sUGFjaYJ+WAWhhQ/SI3t7igcuADGbPCKpQDJPvw60M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792260; c=relaxed/simple;
	bh=/tM5oJkYSDIxAbnk01u6JH0cD+6nKWl90fud8hBuiyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsXz9xlt3g+0co9sYK/KjP4xMqCRRAa02A4/K/4Ye/oB4GAJO08njBZckJUajrF1S0YIOCV46Uz/uE5odDmcawvrzHoTdwj+B7a/kB2reBowTTgGDTegwTT0QDAd8Gp7gpiJf+oN9l1pepULogoU2FpHcLAHcE7OBa5I67c4K/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdi2L2Ny; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca4877690so13125ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729792257; x=1730397057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RkjXg6PY0r08PgmUd9ZxlQNovB2X2eRq3KqUjeeCP+w=;
        b=hdi2L2NyGn5VEdMPdEz29hRAGJp43vPB1UljorWEblmDAs1e5BMxvhUwLce9akr/1e
         m77pIxlyIurMYXQLzvno7F6SVzoFonwumJGtvGs0C/EFDE7spy66Q5KDkHIEQcjhZkxX
         KaMQ8Oo4n/GQkfHoK370rKFBmf9p2TqsyRen/VJ/y0K+htpK2XI7i8iyqCHYKo5BveqW
         bpKpTJFuMczsf+MV9VyYb/mkLWhUjRM9FVGirWaFQYjmpd1GKDiN5+uvSLr2Clg+IIYa
         TGLOzirzpsUbhytMWqBGxG82VAblWQvjnzO31u60mXPPLsBYidVY/vVM2BMy7IcaVEdg
         bwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792257; x=1730397057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkjXg6PY0r08PgmUd9ZxlQNovB2X2eRq3KqUjeeCP+w=;
        b=XAvGeVkQCbyj+mAmArqSxEaKtFX+r2EpLBSGbRDLM+maekCpnBpQdGaDtQLrki5kup
         5co3dMXe3K0wkwiQWRpVbe2qoXDNCA50+BdhCJvm7cGtsNhPtu2cqMg5cT7wlnNzG5Uu
         MphuF/m+jwpt+sVpfeUdVCGL780+slmm6eVAYpvrIP15FIv4e/wOwdQ2mNH/oWNEx/Cy
         HuNCvSxepPfPZP0sXT5nUOfvWFZ4IDvwRsStKC1LHwcvnhCT5f5493RpYq9pnL3J9lzX
         yYrN3hqBYVuo5abIyXBWRl/SCZZvNHK/wHmIKmddzBPDwRsQGsQfkMCfg/TeKvaM3jBf
         SAIw==
X-Forwarded-Encrypted: i=1; AJvYcCU1rbzqZ2x822T0LB3l1sJSSd8+e6PL2RSFPUYIk+qJi465N58kDBRPZIIRmGbu6tA1UY9lv/pHZi5UOE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BKR3xBRjI2EI0O0IybrKnnRDfn64osyd4TnSjrzrUXv4e3Sa
	bSa4kVnFTRZlvPdtCuXlaskioJW+FRom3+6tKbhIpQDCFkcvjbBD1f5+tdTphJh82YrYTxofaeM
	992oz7g/WzJCOQIg5mf/zc5Sw3MYf4+VI1/rn
X-Google-Smtp-Source: AGHT+IGmMF6Oi1vLba4m0kqHuNX8J81qghfcDxfqm6mH4PqLXBdjonza61cFVolDXqPL3rLs7uZVHPnQpEkVmW5BoD4=
X-Received: by 2002:a17:902:d488:b0:1ff:3b0f:d61d with SMTP id
 d9443c01a7336-20fc2219cd7mr74225ad.24.1729792257213; Thu, 24 Oct 2024
 10:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com> <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
 <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com> <20241023220552.74ca0c3e@rorschach.local.home>
 <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
From: Jordan Rife <jrife@google.com>
Date: Thu, 24 Oct 2024 10:50:45 -0700
Message-ID: <CADKFtnSBkSHuR8XLhwsB1NZ5pPeUXNAPCzoCiEqJ5X5=NqqWEg@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Namhyung Kim <namhyung@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"

> You guys said you have a reproducer, right? Can you please share
> details (I know it's somewhere on another thread, but let's put all
> this in this thread).

For reference, the original syzbot report is here along with links to artifacts.
Link: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/

syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153ef887980000
disk image: https://storage.googleapis.com/syzbot-assets/cf2ad43c81cc/disk-15e7d45e.raw.xz

The steps I performed to reproduce locally are roughly as follows:

1. Copy the syz repro script to a file, repro.syz.txt
2. Download the disk image, disk.img
3. Build syzkaller (https://github.com/google/syzkaller)
4. Start up QEMU using disk.img: qemu-system-x86_64 -m 2G -smp
2,sockets=2,cores=1 -drive file=./disk.raw,format=raw -net
nic,model=e1000 -net user,host=10.0.2.10,hostfwd:tcp::10022-:22
-enable-kvm -nographic
5. SCP syzkaller/bin/linux_amd64/syz-execprog and
syzkaller/bin/linux_amd64/syz-executor to root@127.0.0.1:/root/
6. SCP repro.syz.txt to root@127.0.0.1:/root/
7. Run './syz-execprog -repeat=0 -procs=5 ./repro.syz.txt' over SSH on
root@127.0.0.1

This typically crashes things within 20 seconds or so on my machine.

-Jordan

