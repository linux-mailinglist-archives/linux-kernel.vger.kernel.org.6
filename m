Return-Path: <linux-kernel+bounces-412437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353289D0902
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48F228200B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C82413D297;
	Mon, 18 Nov 2024 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIOc+WeI"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7939F2AE8A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731908690; cv=none; b=YRgHdOJnyBWLvbsbiFoiKQSGhxSGSaURor1/dDHnY1vabOIA2JlwWGuB/Tm3r9TGi92ZERLGPrjLY/78Ozi8m1S+vUVI8VKTooiCcYx1HG2WIvSdCCQfG4hoqvmq79nBqfaGninR+L9KO8lKtIUlUEZkyrUaMnb5nG/IIzPsq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731908690; c=relaxed/simple;
	bh=Cle66ud9RuKiHyqHZeVzoW0FTIOBM8fCWO9HubdidHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxEk+Fi2XoCZnIKDemwq6KLn+jo9Pj/NTD57G2+0dd5oumD9TsORP6lhuisPKDGnO7wMyM+fOKKb0XvqRRW4trokw6FrR2LsvfH6CrpvomvuVIfGvdeYiocQ6ft3fc2urGh3dIL+9LxX+mvaUDRZmwmvb7EDl79hyvMs52Vqqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIOc+WeI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cf7aa91733so1143398a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731908687; x=1732513487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cle66ud9RuKiHyqHZeVzoW0FTIOBM8fCWO9HubdidHQ=;
        b=mIOc+WeISmzYzqCt1WwBOYI6TcfhOA/XVyTNtiomt4FzQbCB7fgrEzamtNKlWTPON2
         UVT7QOLlPW3DQVIMlQmU+VZiEZWdlTj/U6A4XUrGLlz63B4HDa6TTU2eay+PBAuJ0RML
         0gnNNWKLJSIwKUUPCjguRHGg+y82MAAyg3yJ4HVbZLc14uPmiRCy2iWzf3feqP5pfJY+
         HFCeIiUZ2sHK8QaM2OfXjujucqjEP6Na/ftJ7mOk7X3ETFtnm5E1s0W/V8EX/MKlH2s7
         Bpu876doACRTa1JvlMWU8dnmNCHngtwEkLhX+vDuUllD+UArYg4OXTfOSM+U7mxv+tWD
         Ev5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731908687; x=1732513487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cle66ud9RuKiHyqHZeVzoW0FTIOBM8fCWO9HubdidHQ=;
        b=kL8dYgdZbLxMFHvSzWfhe/rU7k8GkCpz1E4ptZlHLZLXzX/mxDASoCuJ0j1QQ/pX3l
         bU5rIFTfUGwV0/G3oxtSfrRkK+rM5gNjWhvDoyAO97vUKVdcPMdUXMyzmjVVSMx7d7be
         dZP4Fc/3mHTwZnZ1dgta4HZLUIYS4Xp7oGXrZSFrouMN1raSg2J3Kv53i6c7Ugjba9zi
         ojlxgVraP+GyRJOF+V0HS+YJOyyKPMwgHlMFCBM1ER/wVi/xMSQSeWj9gWs44/BkxdGA
         xwcQtEHwuCY3RVEJWY+BbBbRkXrbjcpz0Z8H3jLFaoCea9VVEeo3p4kgyFIND6foiMFo
         ZIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs+i4PwAEGgEy9vzjFe1Z3et4Cz7GLvbqaxqxJmgNLTJniTSqGYL2ZyuCUZb2k+YK62qjAqhcWCoX+NXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41P5UIF9NVHcEaOE/34nLCmPCgYTLRFHpMH20PP0RwDtBLVtN
	3nWglXjDV4EM0x1xMPmYCszD9f/8KRid/YsXuWyK2zs5kcsGLOYhS1cZ9BiEwv+iZsVlJX27WZd
	hAsuCWNPVNe+L9rto1AXzR9tuajM=
X-Google-Smtp-Source: AGHT+IGYqvKwUmDN4eBSOsXrYLATi4g52HtoPqcolxoH8ROkOdSTdDf0mxN+uTWEU3U3GWoJcrDADgn3AahKQfyi8Xc=
X-Received: by 2002:a05:6402:397:b0:5cf:cf91:61a5 with SMTP id
 4fb4d7f45d1cf-5cfcf916376mr529257a12.12.1731908686522; Sun, 17 Nov 2024
 21:44:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113102146.2384-1-ahuang12@lenovo.com> <1c8e478d-866a-440e-a11f-80fd210cc5ca@amd.com>
 <3727258a-7caf-4f05-b8a9-20ab82ee4ea0@suse.cz>
In-Reply-To: <3727258a-7caf-4f05-b8a9-20ab82ee4ea0@suse.cz>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Mon, 18 Nov 2024 13:44:35 +0800
Message-ID: <CAHKZfL0fEkgsi6xNO6EjKJsESUX0zx+Lxj34qbwfpTiJOG+6qw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched/numa: Fix memory leak due to the overwritten vma->numab_state
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Raghavendra K T <raghavendra.kt@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>, 
	Jiwei Sun <sunjw10@lenovo.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 7:02=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/15/24 11:45, Raghavendra K T wrote:
> > + Vlastimil
> >
> > Looks like he was unintentionally missed in CC. He has added Reviewed-b=
y
> > to V1
>
> Thanks, seems I did it for v1 when v2 was already sent, and without also =
cc
> linux-mm I didn't notice it was.
>

Sorry about that, I fat-fingered it.

And, thanks for Raghu's and Vlastimil's reviewed-by.

-- Adrian

