Return-Path: <linux-kernel+bounces-308087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C0D965708
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6451D28109E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F08814D70F;
	Fri, 30 Aug 2024 05:41:30 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F914A4C0
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996489; cv=none; b=br+0rPPNmYdNOhBwaLYroeB6INoIEesHT6Pm2iccWNiCEPvueBK8y+uQuPUChNpxbIWxs2aVKPlz6CBGvpJwnL4L1uyL9OUlaB+f86cFCK59x22bN8SfMoRJwJMhBkIqTYedFj9Bfn+Tm1ninecgpvmY6MJI+r2AFPxrQRYdke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996489; c=relaxed/simple;
	bh=O2jIMW6VHXuSTbfHICK/DBt0C6YBCQyY2Q+8ebyzrGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9G39bBFhV4je/ePfLe9Miimm5YW624xmXNfRB9EAK4dKSV8OAnokaof3ot0kOHNHNel0LBZ4wrzA/rZhUu6Lnb3JPg1Qno8ewTWuIsEny5i1+DpbA0+paw88Ne0Tj0Cvn9RwH5xhIveoAm41YdzKOEJvBu6oSbvSGkHPJx6DQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5df9343b5b8so911306eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724996487; x=1725601287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ke900fFc2GA2Wr6iqoqiAf9sCtX+rtXWkHRA2Dh3B14=;
        b=Fw4VQImqkcbjIvkDUIBBWhR4p4SqduvqGXUtuq+XSF8GropSjrBI8n5UQNUwuCCeyR
         +Y1sZMz26gTzkvwHk8AEeRr/IoYiR0avoALmf5Rwed3TtoQtMlAbj7wMhL5nuRpH/cr7
         M9vJxC7lQtObPQI+iSUV4lzemjdjNJMAEEl21EE+8FmpZIWWZSLufRGlJluxAGsBwRtU
         HbPRiZm5uM9XnTbAVRp1ufLf4f68BzR3Oks19kwseWVWMgwDhkFZH2rD37nLOL6AJKvU
         AVl3HrroURbyNXWFCvtKamLOobXN9hUqCb5kr5ZI3ZTqfujR0fSYgTdvOVKlRMYCSLeJ
         lbNQ==
X-Gm-Message-State: AOJu0YxLSwXPI4JYerGlsW2ukRRnPPicIumhfqNU8mqbnJIExnHRo/EM
	4IEEghIJRAtjvxhJrk0orFz8nUxl8TpS75EMdLIkhXkBx0Lnq2tmgkdtYRo99fwixQxhKRVzGsf
	71WJGjmU5To4WNBf6O7F5EH0zQ9c=
X-Google-Smtp-Source: AGHT+IHsMqOwyQ458wIbLbARslpP36ey8emF1MAxEfPPl5MujV8U3iNFWzIk9ysIeH84zOeasime6/sryNKYEU1qjWk=
X-Received: by 2002:a05:6871:e294:b0:261:1deb:f0ee with SMTP id
 586e51a60fabf-277900c60demr5463426fac.13.1724996487167; Thu, 29 Aug 2024
 22:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829074133.4547-1-anna-maria@linutronix.de>
In-Reply-To: <20240829074133.4547-1-anna-maria@linutronix.de>
From: Len Brown <lenb@kernel.org>
Date: Fri, 30 Aug 2024 01:41:16 -0400
Message-ID: <CAJvTdKkejPZL0vYngm1w=ao09mzCn7x3MYFWJkFhDh8ZUFkwzw@mail.gmail.com>
Subject: Re: [PATCH] timers: Remove historical extra jiffie for timeout in msleep()
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HZ=3D250 systems thank you!

Acked-by: Len Brown <len.brown@intel.com>

On Thu, Aug 29, 2024 at 3:41=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> msleep() as well as msleep_interruptible() add a jiffie to the
> timeout. This extra jiffie was introduced in former days to ensure timeou=
t
> will not happen earlier than specified. But the timer wheel already takes
> care during enqueue that timers will not expire earlier than specified.
>
> Remove this extra jiffie in msleep() and msleep_interruptible().
>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/time/timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 64b0d8a0aa0f..18aa759c3cae 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2730,7 +2730,7 @@ void __init init_timers(void)
>   */
>  void msleep(unsigned int msecs)
>  {
> -       unsigned long timeout =3D msecs_to_jiffies(msecs) + 1;
> +       unsigned long timeout =3D msecs_to_jiffies(msecs);
>
>         while (timeout)
>                 timeout =3D schedule_timeout_uninterruptible(timeout);
> @@ -2744,7 +2744,7 @@ EXPORT_SYMBOL(msleep);
>   */
>  unsigned long msleep_interruptible(unsigned int msecs)
>  {
> -       unsigned long timeout =3D msecs_to_jiffies(msecs) + 1;
> +       unsigned long timeout =3D msecs_to_jiffies(msecs);
>
>         while (timeout && !signal_pending(current))
>                 timeout =3D schedule_timeout_interruptible(timeout);
> --
> 2.39.2
>


--=20
Len Brown, Intel

