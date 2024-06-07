Return-Path: <linux-kernel+bounces-206550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B10C900B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ECC1C21D7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EC1991CC;
	Fri,  7 Jun 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j4o2G5EA"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5333C0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781636; cv=none; b=T46db1V10B99ybZIzw7utTWb3Ulkr/N/5l6wbUQgpCArzCYZvJBMf4gjRTcqFhJLBfT6mP8128QhT2zFafshRfQQj51Y2sAmZwDNMnn6X2wcsfwRQtQVs4VE7twg04Cx/Z3LXRPjC2j83SZymcfRKXerjcjBeIaBNvNycjvIPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781636; c=relaxed/simple;
	bh=fvlMr8NeemR0mya1UxHN05eadBJSCH9MiFHjNa9gUZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSBxMxWDMvD8/oIlvqUzIuaoGWwPseMmlw/4wrZyE4p+EW7DFz5IPXmkrnTD7n85QR0W+XdvgphoHvfpOv+cQChOTNZKaEAXQ06QoGSaBHTWtC7hgZdFqILGJ/aOV8EYK5DCZLtFwLmE556q61o6yDVnhLR2/IdeCdZ4GCYQ1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j4o2G5EA; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4eb1d56fcadso841375e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717781633; x=1718386433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dybcnIiLVi5/bVqftpS2lnH30sLAWeA2EDG07SaudOE=;
        b=j4o2G5EA5BRzjzovCWSP/xGzfKsgx8xc4euKcl/hkHIMZPbs+8ZX0PB+NSKHYtQFhi
         W1n2IAChwPml/GWR+I0wftlMAB/ZrLoL8x3v6EwxrNoLHtF49qCLoyI6G+KGYQnKXbvw
         xZ69pIhGmu47LFLNmWZxxarswuBxxNRVZYvQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717781634; x=1718386434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dybcnIiLVi5/bVqftpS2lnH30sLAWeA2EDG07SaudOE=;
        b=BwOTTvnUeYaoZyQ3+Jna5haHN4jomTr+khZKxKvVinxhXM8rjiUQF1X7GCESKgVWmH
         acxzKqtn0hao4P9VPbXFD3cmHW84g6llF/Gk5Cc+VDYj70Zj0fHZ2Y6Q6APbtt4YyJj3
         +9i3ggag9STJ8qoqihiarq6XYo/FNhoDJGbAlFmEwY1CYgkv7kGebWpfmQZfYVV/m9Jf
         dHZTQNMB3wVFWBG3OAues1WQJ04C70tnIJI7magXVX1kMh7FPdlkbCQroEYDgNKwyiUM
         mmDitKpvUUPkOkqVchKLMPsrSbpAxKgzV2oFnTSDa5b1lwnqBDO5Z2JjH7RmdkhmOfJ6
         WsmQ==
X-Gm-Message-State: AOJu0YwxkQFyfQ8i1TGnR6IsO1/qzYBGH9icNjdIOdjgsUJfQ8TTn59i
	+TJJH2ciQBBa94rKOgVjq2gu29aBLRASvOZfm91GELzDCuq/7M1VeSJPPVnxGCVI+6trnM21E57
	b3GXQgiKS4CsuivpM49s39zGyxurxnglfrgUJ
X-Google-Smtp-Source: AGHT+IFXvpc6qNSMXpgwDcPE9pPWUm6/R43F2u116dAsDRczp5uVABR22bdJUvEkX30wyp4qaveyKrbcSrZB1NVmaN4=
X-Received: by 2002:a1f:4f05:0:b0:4d4:b89:bd2a with SMTP id
 71dfb90a1353d-4eb5621bd52mr3231900e0c.3.1717781633654; Fri, 07 Jun 2024
 10:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607104610.1.I6c23f4fdb786f7200f6f1255af57b4e9621bcc66@changeid>
 <ZmM7FovMyez71TcC@slm.duckdns.org>
In-Reply-To: <ZmM7FovMyez71TcC@slm.duckdns.org>
From: Tim Van Patten <timvp@chromium.org>
Date: Fri, 7 Jun 2024 11:33:43 -0600
Message-ID: <CAMaBtwHrprN1Ev8kJPggggVcVZCxsxMQJ=NBQ2AC_Tr1jqHoCw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Prevent delayed work UAF kernel panic
To: Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, druth@chromium.org, 
	Tim Van Patten <timvp@google.com>, Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 7, 2024 at 10:53=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
 > To prevent kernel panics, check if the pwq and pwq->pool pointers are
> > valid before derefencing them, and discard the work if they're not.
>
> Nothing guarantees that they'd stay NULL after wq destruction, right?

It doesn't appear it's possible to re-use a wq once it's been
destroyed, so I don't
think they can be re-initialized once they're NULL (nor the __WQ_DESTROYING
flag cleared). I could certainly be wrong here though.

> > Discarding all work once __WQ_DESTROYING has been set (including from
> > the same workqueue) causes breakage, so we must check the pointers
> > directly.
>
> There's only so much protection we can offer for buggy code and I'd much
> prefer an approach where the overhead is in the destruction path rather t=
han
> the queueing path.

That's a good point about avoiding the overhead I hadn't given enough
consideration.

A fix in the destruction path would presumably require draining the work in
drain_workqueue()  or discarding it in destroy_workqueue(). My naive
interpretation of
things would be to discard it, so the work isn't executed
preemptively, but I don't know
what the expectations are for delayed work regarding which is better:
do it early or don't
do it at all. As you've pointed out, since this is buggy code to begin
with, I don't think
there's any contract that needs to be adhered to super-closely, which
is why I'm leaning
towards the discard path.

Regardless, it doesn't appear we have a list of those delayed work
items available today.
Adding one should be possible, but that would include removing the work in
delayed_work_timer_fn() in the normal path, which would also add
overhead (and likely
more than the pointer checks, due to searching the list, etc.).

I think a better approach here would be to update
delayed_work_timer_fn() to check
__WQ_DESTROYING and discard all attempts to queue to a destroyed wq. I have=
n't
given this as much testing (I just kicked off a round of testing), but
it should help
reduce the overhead impact.

I'm far from an expert here, so any input is appreciated. Any thoughts
on this approach
instead?

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
--- a/kernel/workqueue.c (revision 4bd3ef41540b950cf63179be1967aac6d0937766=
)
+++ b/kernel/workqueue.c (date 1717780157589)
@@ -1925,6 +1925,17 @@
 {
  struct delayed_work *dwork =3D from_timer(dwork, t, timer);

+ /*
+ * Prevent a kernel panic by discarding work queued to a destroyed wq.
+ * This must be checked while the rcu_read_lock() is
+ * held, so destroy_workqueue() cannot nullify wq->cpu_pwq while it's
+ * being accessed here.
+ */
+ if (WARN_ON_ONCE(dwork->wq->flags & __WQ_DESTROYING)) {
+ pr_warn("workqueue %s: discarding work for destroyed wq\n", dwork->wq->na=
me);
+ return;
+ }
+
  /* should have been called from irqsafe timer with irq already off */
  __queue_work(dwork->cpu, dwork->wq, &dwork->work);
 }

