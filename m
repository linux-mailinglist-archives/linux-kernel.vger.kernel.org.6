Return-Path: <linux-kernel+bounces-218938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4242790C7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544FE1C21605
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BB1CE9F7;
	Tue, 18 Jun 2024 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huOg/vor"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABC1CE9E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702829; cv=none; b=o/4w9aFqkRT0Aimt7UegDFSIzd5F+z5HffQSSF7Jv79lkEQ6Q4ny96SRgr5mEJuYKdAOcqXjiZnVcSC9khP9ecR5f3H/RqkkLU3v+jbFf/c/u0Y2Zt6HRI7zlaeApu9P2l4Y5MqPlsJnJ3Fme3sfHh+AKnRNZXYzxSbT7Oi5CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702829; c=relaxed/simple;
	bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/GLvOXIp74w37qowM7+p2yv4hm6plthEvHwwvJU2QTigPu986HDOxZBj85tegJpGWMcPbPOgY4PTkJ+qs/Vs2lS9cIog+KHCQopyuGFAUhcV01aWGzgssKdeHajVAqsB4g2YfCuemPk/QF0rw8kBlYtwO8zK5IuhHgXyFQNRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=huOg/vor; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-795482e114cso441691085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718702826; x=1719307626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
        b=huOg/vorR3YTqG+1X95HfNzG5wPbQpgY4knV5mwPbe1kboc6s+AHfXSs1xlxg2W83E
         FpMEpHhkgNDyzT32O6VQ5gpZBD0aKxREqcdEAct/EZjYR5nE5UljBprPHp25Yi3tTrTW
         vnT/WVX3E85rA0vD9A6Tg/5DWr7bNFmOaNDEOWR9gTdi8yOb0VQrLJYS5auDv2XmRRBF
         mjxeMe9IJm6uDBNq++N8DyqTArzbcT96DzV9dYoHiU/ilp8jEauFnPd0WCr0S0k7LZBC
         3Nt5kgY2pdkk//VimcM3MAiMIYz91h+6kqk0838u8yrJnijEAvYq3gqbAigOH40iRwXu
         w8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718702826; x=1719307626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgjCqFVtKavNFxLDu8aE6OS/1nGbyLOwVqAAdquKtbU=;
        b=ZqHrontv2PJ6aMjmkB9eu/kIYvtHAbhn+KXBAfzLD5QqlD3fEoq70gZLIQGcHXBZyl
         YRFGBuyyK0AGwtm51yUyiHis0AlVzRpY8L9mZTl0zA4lMk2omIwGJvhAE5b5bkRjMuXJ
         PMh44e7GLmc7EMuZLB/w2NWty9Y5XMzF2H9T5WF9Og/QIJ4l2doI8bg6/mMy/z/47DSa
         bLt+hnHlKpDwxXPabRjn5DTTN27rObQVDqW77fnHtdzd0s5AFCq2UKv4rfEv5t7rtMVh
         j6G3uIXYZ3MQwArrntmy/Ot8kRB62g1zLUT7ZQyDwLuUtsWThYNnOyFYQXRISm+P6r9Q
         OXGw==
X-Forwarded-Encrypted: i=1; AJvYcCUGGkcZRQz8j+n2R/v72DkznolXzoB2GqhvjgIjL86oGGGV3VlPVXl7O+qdvS8cmHHGQGHnolD9V9IkDxQATn6jRjV175p0HEXDdmJH
X-Gm-Message-State: AOJu0YxHqY1zzfiZKY9FyMgLZGypVbROZKrH91MCdjtAP51dj4ENh4Vu
	L4ru5cG1rH6mho/C3buOG0M4YOS6rsO1BgZvj6mz2UPlmHuunmzLoap4OIY/kb9il7/2SWU16zO
	pMGVz7T3dHW9iAfy3Jc830UPmGCHRHkYaSIs5
X-Google-Smtp-Source: AGHT+IE/yIrzcpOv3eiTPoXN3cwGJ3TQnnFMvA5d279z/tiAN3Xspn0UhsEikZvmg+vlTu/xFiTY3m/3H4pxUpWqwP4=
X-Received: by 2002:a05:6214:1249:b0:6b2:cf8b:21db with SMTP id
 6a1803df08f44-6b2cf8b2252mr79472176d6.53.1718702825469; Tue, 18 Jun 2024
 02:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-27-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-27-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 11:26:29 +0200
Message-ID: <CAG_fn=VVGwxBUH=3HrVHhNs6AQFMqFgw7JDLqUFBTv13FOd5cQ@mail.gmail.com>
Subject: Re: [PATCH v4 26/35] s390/diag: Unpoison diag224() output buffer
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:40=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Diagnose 224 stores 4k bytes, which currently cannot be deduced from
> the inline assembly constraints. This leads to KMSAN false positives.
>
> Fix the constraints by using a 4k-sized struct instead of a raw
> pointer. While at it, prettify them too.
>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

