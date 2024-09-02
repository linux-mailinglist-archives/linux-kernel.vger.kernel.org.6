Return-Path: <linux-kernel+bounces-311892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF293968F12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD021C20A19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34C1865FB;
	Mon,  2 Sep 2024 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SENdJMwb"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FD1865F1
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310999; cv=none; b=SG3iBVTie/WoUAEJf/beyq0OJriR9Vk7BlWdc+TcAX8SdTGlPY+5z1BpIbXa9t6qfi66pbciXi0qO4cL4BGuBZYdUMZD204NydCx6IOpTX9R62mmAGhx64sWSkPmaXtQSZU3/6Fo1LSF9wNNne3IuipFhE6yNeu4BifMDckgz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310999; c=relaxed/simple;
	bh=CMQa/33WZzfL31kcG3CjB/U+R/8uJ/2tlmE8nlhm9PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJJI+YhHwGj3OsycrvXl+5anBPGJyBXzuaQ/YEr8GPxJYy7KvnoeTsS6jdIwIjgRfMqUeC1B+3VLLzzk5brbV5zdRPoFsmb2P+wm0fQfd/8dwHhwjjX1Ho8WXfWEpkMGGmu5Zjfi7x7TmFYnfDeyHL1tXpisZdCZuSnWiGPpTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SENdJMwb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f4f24263acso69262791fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725310995; x=1725915795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=po+MmfD4nq5cLkClRRslOxFglpMwsYkFajj19L5Hzi0=;
        b=SENdJMwb4OebbRrnn4zA8+bwlG+5tf/9bg2dky9ChRqToXHyEavEIuW7TIBFLnlFrJ
         qepi05YcwDfcFfC0d/1sZ+zkRByPivxVWyOozJVTlhBHBmryETmO+dyYgrkI6tzPE5Xz
         GMUcBvvb3hoV3T/cPqHBd8ZX8Bc9bvLHjDBjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310995; x=1725915795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po+MmfD4nq5cLkClRRslOxFglpMwsYkFajj19L5Hzi0=;
        b=m7giZP0cXY9KFmno04FLUIV2RjvZEx5jYRpYqtMV71JvQ+P1vRfuzHUY8t7qYgZMLT
         raXZWAREibKvAoOEMKVKHZ2CIrk8zXHXYgx5lKRu+dtlh6Ks+AhPIujUbG+i7H45bZ4y
         DzsNWWmgigD8icQFj7A1OJu3a6y2LgI4JUZVz9tWnkT0ZMEkYeTqzLQeHNILzP7RhmiF
         JiWizm9p0wT8OuEdDLiZif408Nh9K5Q7VTpV6uvmqEzyEzTgR9sR58NSFteuUNeVIPRU
         NmWKxA69dj8sb4MUpbuoQ2o7XVByTvBdd5bb62KPyWdJoquz47+jmvDuGs4f+s45x40Y
         GW7w==
X-Forwarded-Encrypted: i=1; AJvYcCWP6/a22W0NlMlnR+IwJMgzdj0qfxcbqCYk5A8WewHhGdYtBTRMjY6dPrseeL7WKn9SQvt2goheytLkF4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCx30pEaUdWUKy3Zf6+KB5nc/OYsZEgX501qD/MA66YWa4D8io
	/eGdOf5FY0Zou19NZEKP7O7Q6SioZpb5F8AoLDOavWc5CrYFoyTDwGPMN04fVq3xJBADI84Zs/Y
	gKZHHmQ==
X-Google-Smtp-Source: AGHT+IE2p+q5wX+QmsHkEcHsu09HB2in4Ap5cydjrE7Y4zzJ365np1Rw1ON+ud0OlB8dmkSNiDiw+A==
X-Received: by 2002:a05:651c:b0f:b0:2f3:e9fb:6d5a with SMTP id 38308e7fff4ca-2f6105d755amr141203901fa.13.1725310994440;
        Mon, 02 Sep 2024 14:03:14 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d72c3sm606466966b.147.2024.09.02.14.03.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 14:03:13 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a86b64ebd8aso281368366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 14:03:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlIo6dBl0KDUq1Fm0MzmTfDduSHmjind6z8rQt77RDYgw+Nn346Hj4niMxgEEzItRFbewI+j+qjo0ZXFI=@vger.kernel.org
X-Received: by 2002:a05:6402:34d6:b0:5c2:5d34:a45a with SMTP id
 4fb4d7f45d1cf-5c25d34a63fmr2793579a12.2.1725310993097; Mon, 02 Sep 2024
 14:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <yt9dy149vprr.fsf@linux.ibm.com> <20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
In-Reply-To: <20240902134953.e834bc2e57d36b1d3b1397e4@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 14:02:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
Message-ID: <CAHk-=wjD0XLhkzou89J-TK=L6B88pFoNYxN1uTWRQB3U5Czywg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-s390@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 13:49, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> uprobe_clear_state() is a pretty simple low-level thing.  Side-effects
> seem unlikely?

I think uprobe_clear_state() should be removed from fork.c entirely,
made 'static', and then we'd have

        area->xol_mapping.close = uprobe_clear_state;

in __create_xol_area() instead (ok, the arguments change, instead of
looking up "mm->uprobes_state.xol_area", it would get it as the vma
argument)

That's how it should always have been, except we didn't have a close() function.

Hmm?

            Linus

