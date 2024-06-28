Return-Path: <linux-kernel+bounces-233492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A991B837
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429891C21A57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54F13F437;
	Fri, 28 Jun 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htCjFchI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A913DDC9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559363; cv=none; b=p90g/1x5VXw28VYjYrdgDcQ5m2z/lKwrAsSW+2iCfyuQ+T9p3yIN7vjzALKo6oK/V4aMTlI6gwsCIhz3ahh1UTiPgK2icWZDAdo+S/Epk8ZmVkSAFa+T7Ywas1YksbZDbfHm895DhGAUclv/gzYv+xaPw+aQB+R2L9kEY2PRExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559363; c=relaxed/simple;
	bh=7Tf/vh/e+w/9J9xee3TIyV/7qBN7BrlX5VjWSwNArMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tovi0PjFBsAKR9l8ScEtV4GhSOqqcJRzWPC3vP5Lao3i88M5SZe7kzvV9xWcmlcjYwKN6J05cBd6jxYjt6a+4Ak0YXwG9UEZWzZIzwfzAvZ2k6TwkOlpH8WB38KhkdMnhWC3bpUqnrGrW77N84S4rJo2b7ju5DXRSI/vwAQPAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=htCjFchI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so3397011fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719559359; x=1720164159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4pD304JwMKa83pcEpFZevIuB7X5ddSXjfbIN66nvoM=;
        b=htCjFchIMzI3ogvZMaRM9NRSAfh088a9WbirHWTM3jLoNpAjPhPdwhMzI+FLRDY+TQ
         BGSuEyaI7ovqgPPSW4JGUm90EA6r0VOOzkUKOCPqdwChF9EUGPlTyuodGSEfHw5m93Js
         TKh6amJn8cydYmwkyGShUAsR9paqRvgzCj3+hbFRtHqZGJ+lsfPOTlfByiyHd7o+feDH
         Y8Q2TcAg3AXq5BuGhUmN6CpOGEyL8+ng3wcaY4kkepTVO/TP3XFMk5Eoj7107Bv+UzFI
         3UY46HQ9aqDwcEjze9gUthKAf5vTDNS5UkPGFEsrMXzD90RIWyuuVQ5fBSJ0miz/dKdf
         vhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719559359; x=1720164159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4pD304JwMKa83pcEpFZevIuB7X5ddSXjfbIN66nvoM=;
        b=jOT7Kj3QO+ZWpB4L3SZYk9XOxmf964aHLD1+ummANntdLZHqwEOj9p6sl2yLB1JHKb
         UG2VAVtMVBkC6pSaQ3B2k2ji40P76G4mScKfEHhaXyB1/JZHaLewcfGtQfnN8H2ycYbF
         8Zk42Wj36eL1iplez+4fCtlJgzj2rq2KypPdLm7pz3wmpUlSSX5v94jqPj4/g/zm8gkG
         /Q8RYgQCWT8Vt8LKIQ1smBJmoCca52K1Ltym/DjQvqI/+58JgsMreWUs4gECM8UIN8hH
         TA7G+Nj443nQY0DPc+PkRQ1EiW9CGJ+ztQxMdTS2bqOm6ADXrK6uv63Y3CIGBVJKjoih
         cwsw==
X-Gm-Message-State: AOJu0YzI8SWYnALK3lDfwCp56iI98gDFv7sUJngfn0jipewYs0B+3+Y3
	aLQh7r+iXxIw/l1CFOxrLcybb4OEVxqhKw2NQoVliGd9Lr9GIaZXdnlErTHfDLM=
X-Google-Smtp-Source: AGHT+IE4XozIpNLrCIvjHr5Z0ToDUvimNW3x7D5/7u0wxrN3EaX/yFN+S5mO6lhru7jzTa1nW+PrZQ==
X-Received: by 2002:a2e:8048:0:b0:2ee:4f58:7738 with SMTP id 38308e7fff4ca-2ee4f5878f3mr15444911fa.17.1719559359206;
        Fri, 28 Jun 2024 00:22:39 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4256b097bcbsm21904385e9.35.2024.06.28.00.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:22:38 -0700 (PDT)
Message-ID: <835d5847-1aa0-4852-89c7-6a6996b3eb65@linaro.org>
Date: Fri, 28 Jun 2024 09:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External Mail]Re: Race condition when replacing the broadcast
 timer
To: =?UTF-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?546L6Z+s?= <lingyue@xiaomi.com>, =?UTF-8?B?54aK5Lqu?=
 <xiongliang@xiaomi.com>,
 "isaacmanjarres@google.com" <isaacmanjarres@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
References: <042520850d394f0bb0004a226db63d0d@xiaomi.com>
 <87o77m1v9r.ffs@tglx> <b07f9746a58d46919b1600b22f5dff05@xiaomi.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <b07f9746a58d46919b1600b22f5dff05@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/06/2024 03:59, 朱恺乾 wrote:
> Thanks for the fast reply.
> May I know when there'll be a formal patch on the mainline?

Do you confirm the patch fixes the issue ?


> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, June 27, 2024 7:27 PM
> To: 朱恺乾 <zhukaiqian@xiaomi.com>; Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-kernel@vger.kernel.org; 王韬 <lingyue@xiaomi.com>; 熊亮 <xiongliang@xiaomi.com>; isaacmanjarres@google.com; Frederic Weisbecker <frederic@kernel.org>; Anna-Maria Behnsen <anna-maria@linutronix.de>
> Subject: [External Mail]Re: Race condition when replacing the broadcast timer
> 
> [外部邮件] 此邮件来源于小米公司外部，请谨慎处理。若对邮件安全性存疑，请将邮件转发给misec@xiaomi.com进行反馈
> 
> On Wed, Jun 26 2024 at 02:17, 朱恺乾 wrote:
>> We find a possible race condition when replacing the broadcast timer.
>> Here is how the race happend,
> 
>> 1. In thread 0, ___tick_broadcast_oneshot_control, timer 0 as a
>> broadcast timer is updating the next_event.
> 
>> 2. In thread 1, tick_install_broadcast_device, timer 0 is going to be
>> replaced by a new timer 1.
> 
>> 3. If thread 0 gets the broadcast timer first, it would have the old
>> timer returned (timer 0). When thread 1 shuts the old timer down and
>> marks it as detached, Thread 0 still have the chance to re-enable the
>> old timer with a noop handler if it executes slower than thread 1.
> 
>> 4. As the old timer is binded to a CPU, when plug out that CPU, kernel
>> fails at clockevents.c:653
> 
> Clearly tick_install_broadcast_device() lacks serialization.
> 
> The untested patch below should cure that.
> 
> Thanks,
> 
>          tglx
> ---
>   kernel/time/clockevents.c    |   31 +++++++++++++++++++------------
>   kernel/time/tick-broadcast.c |   36 ++++++++++++++++++++++--------------
>   kernel/time/tick-internal.h  |    2 ++
>   3 files changed, 43 insertions(+), 26 deletions(-)
> 
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -557,23 +557,14 @@ void clockevents_handle_noop(struct cloc  {  }
> 
> -/**
> - * clockevents_exchange_device - release and request clock devices
> - * @old:       device to release (can be NULL)
> - * @new:       device to request (can be NULL)
> - *
> - * Called from various tick functions with clockevents_lock held and
> - * interrupts disabled.
> - */
> -void clockevents_exchange_device(struct clock_event_device *old,
> -                                struct clock_event_device *new)
> +void __clockevents_exchange_device(struct clock_event_device *old,
> +                                  struct clock_event_device *new)
>   {
>          /*
>           * Caller releases a clock event device. We queue it into the
>           * released list and do a notify add later.
>           */
>          if (old) {
> -               module_put(old->owner);
>                  clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
>                  list_move(&old->list, &clockevents_released);
>          }
> @@ -585,6 +576,22 @@ void clockevents_exchange_device(struct
>   }
> 
>   /**
> + * clockevents_exchange_device - release and request clock devices
> + * @old:       device to release (can be NULL)
> + * @new:       device to request (can be NULL)
> + *
> + * Called from various tick functions with clockevents_lock held and
> + * interrupts disabled.
> + */
> +void clockevents_exchange_device(struct clock_event_device *old,
> +                                struct clock_event_device *new) {
> +       if (old)
> +               module_put(old->owner);
> +       __clockevents_exchange_device(old, new); }
> +
> +/**
>    * clockevents_suspend - suspend clock devices
>    */
>   void clockevents_suspend(void)
> @@ -650,7 +657,7 @@ void tick_cleanup_dead_cpu(int cpu)
>                  if (cpumask_test_cpu(cpu, dev->cpumask) &&
>                      cpumask_weight(dev->cpumask) == 1 &&
>                      !tick_is_broadcast_device(dev)) {
> -                       BUG_ON(!clockevent_state_detached(dev));
> +                       WARN_ON(!clockevent_state_detached(dev));
>                          list_del(&dev->list);
>                  }
>          }
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -162,23 +162,31 @@ static bool tick_set_oneshot_wakeup_devi
>    */
>   void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)  {
> -       struct clock_event_device *cur = tick_broadcast_device.evtdev;
> +       struct clock_event_device *cur;
> 
> -       if (tick_set_oneshot_wakeup_device(dev, cpu))
> -               return;
> +       scoped_guard(raw_spinlock_irqsave, &tick_broadcast_lock) {
> 
> -       if (!tick_check_broadcast_device(cur, dev))
> -               return;
> +               if (tick_set_oneshot_wakeup_device(dev, cpu))
> +                       return;
> 
> -       if (!try_module_get(dev->owner))
> -               return;
> +               cur = tick_broadcast_device.evtdev;
> +               if (!tick_check_broadcast_device(cur, dev))
> +                       return;
> 
> -       clockevents_exchange_device(cur, dev);
> +               if (!try_module_get(dev->owner))
> +                       return;
> +
> +               __clockevents_exchange_device(cur, dev);
> +               if (cur)
> +                       cur->event_handler = clockevents_handle_noop;
> +               WRITE_ONCE(tick_broadcast_device.evtdev, dev);
> +               if (!cpumask_empty(tick_broadcast_mask))
> +                       tick_broadcast_start_periodic(dev);
> +       }
> +
> +       /* Module release must be outside of the lock */
>          if (cur)
> -               cur->event_handler = clockevents_handle_noop;
> -       tick_broadcast_device.evtdev = dev;
> -       if (!cpumask_empty(tick_broadcast_mask))
> -               tick_broadcast_start_periodic(dev);
> +               module_put(old->owner);
> 
>          if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
>                  return;
> @@ -1185,7 +1193,7 @@ int tick_broadcast_oneshot_active(void)
>    */
>   bool tick_broadcast_oneshot_available(void)
>   {
> -       struct clock_event_device *bc = tick_broadcast_device.evtdev;
> +       struct clock_event_device *bc =
> + READ_ONCE(tick_broadcast_device.evtdev);
> 
>          return bc ? bc->features & CLOCK_EVT_FEAT_ONESHOT : false;  } @@ -1193,7 +1201,7 @@ bool tick_broadcast_oneshot_available(vo
>   #else
>   int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)  {
> -       struct clock_event_device *bc = tick_broadcast_device.evtdev;
> +       struct clock_event_device *bc =
> + READ_ONCE(tick_broadcast_device.evtdev);
> 
>          if (!bc || (bc->features & CLOCK_EVT_FEAT_HRTIMER))
>                  return -EBUSY;
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -53,6 +53,8 @@ static inline void clockevent_set_state(  }
> 
>   extern void clockevents_shutdown(struct clock_event_device *dev);
> +extern void __clockevents_exchange_device(struct clock_event_device *old,
> +                                         struct clock_event_device
> +*new);
>   extern void clockevents_exchange_device(struct clock_event_device *old,
>                                          struct clock_event_device *new);  extern void clockevents_switch_state(struct clock_event_device *dev,
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


