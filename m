Return-Path: <linux-kernel+bounces-370646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33C89A300D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C46AB23782
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBBD1D7985;
	Thu, 17 Oct 2024 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="jNzDigo5"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679201D63DC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201796; cv=none; b=C/+uT88krJH5FHJSuHXgip1VgOmUpPwK7hlz5n9d1GvwnCWLh1pTtr2HwGyZcLqWXGrcnP72guljWyU3eUo9jLMlUarRpi7mC2f5CX5Y8+uzCEXREUPPU8tx6HBG17qmjKeEMabmRP3PDkLZ+jFaAkOCc3g1oAxE97Mmilr74PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201796; c=relaxed/simple;
	bh=v8/HTNItQv0TG3Sq4pBWyyUhzG9Q9PL4uVQLQoslvow=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=C7iJeUZMG1vXs5rNBjKxZdMXL2oqTTp30dAeSmc1q8PfAhxgt4own5AaNcZ7JkFZxDVHIUayLrezgYV6m0PJEqyAi7TtTqLQy1LasyJx+cuVOQolyFfY/XLW6xdRPRegKC5gSnr5jieQWVqVeFs4ttk8UrAWVpfcZ5RbPuSjpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=jNzDigo5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1039130a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729201790; x=1729806590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu/dxnXAMTzuUeZdFobyXdEI/zCxHQSZLPRWhAzrc2c=;
        b=jNzDigo5RnJypPmAVL4yZhn2gJsp3RXxoi2lXkQUfZGYcQhIqIRUWhn8nyYDuAfWij
         lBOI9Z88xP5FatA0G3OI4+tJvJnkgQWMFoY/BrqP8+ajzdzkiY8Z/7P+a83ZW0kgSCaN
         pvhJWEjd+Sll2/WyMqdVrLUE617uSPiBXTlzpA5We8rpOFyppNwz/oaJG/UdAwC9hR0v
         cLd9uC9h0CdQiJo8cCXlPN7+rqSZwrmcz/5G9DJn0B6XdKzvg6vievWwT1LHxD9k54m1
         A5IxMTmU8+wdDZgvd65XzdeoR69dv+lW0CBVAuGePikYdcDPiSIDP3F3Rz+X98KygW+i
         YclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201790; x=1729806590;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu/dxnXAMTzuUeZdFobyXdEI/zCxHQSZLPRWhAzrc2c=;
        b=Mmjg5dja1HDN7W5Paek3iAL0jlhn19n7+h62ua23l4gmIYG0qEs2lOWo6qqax9Voe4
         FKGPDm3wvt897oS3+fFNH8itr+Ysokaz0Lsfnw9QlN7PTyNP0eiL+aIKSq2S7KCb2YYw
         LgylzpWErUB4aYrUxfuOfgq4NQa7bMbcU0PPVEr0V1/vNrN0CO4qfhu4Z495uigVeeln
         wVTn6Wsi2FiCAHqPUMnSs95KpCQfb7XnOAbwyEExbWSJdDQUTsH8s1ARZhf3b0Sqi8SU
         sXBdcM8Jo9y/+sYO0zwh6TP57UrBXzYt6cvaWu1V0F26j8KBKeeHGpmtrLt3N1CCkhSQ
         Dn/g==
X-Forwarded-Encrypted: i=1; AJvYcCWTsani1uDnPjDlatDLt0g7QeTmAzpsAXMZEjhHliw9L+7A7PRnkqTeKMeedztDPpMC/rPuB9eDkGxHAd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVE8qs5Sq4Bd6jI4T7njeEtAoBf8f/qWkiNzdG6CpD3E2W3Ii
	z6qSSyb0TWyefI0U09MzxuiUSfdJKal+arTkem0eYUpXQdR6ScILPhVkABc9RFk=
X-Google-Smtp-Source: AGHT+IGmY3bCaEMXb29cCY6tmaZsUZCoNqD8MeKKY+vFnpDezuSI2SqDrji03CqXJjFB8/1kPsAZ+w==
X-Received: by 2002:a05:6a21:114d:b0:1d9:2c23:66ff with SMTP id adf61e73a8af0-1d92c4ba7aemr371347637.5.1729201789678;
        Thu, 17 Oct 2024 14:49:49 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc28baa6sm80732a12.73.2024.10.17.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:49:49 -0700 (PDT)
Date: Thu, 17 Oct 2024 14:49:49 -0700 (PDT)
X-Google-Original-Date: Thu, 17 Oct 2024 14:49:46 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: add PREEMPT_LAZY support
In-Reply-To: <20241009130530.2Sv2p0Eo@linutronix.de>
CC: peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
  linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
  vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
  mgorman@suse.de, vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
  mhiramat@kernel.org, mathieu.desnoyers@efficios.com, jszhang@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: bigeasy@linutronix.de
Message-ID: <mhng-02463d30-c55e-41a9-beae-ac4cdff9fc9f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 09 Oct 2024 06:05:30 PDT (-0700), bigeasy@linutronix.de wrote:
> On 2024-10-09 15:03:07 [+0200], Peter Zijlstra wrote:
>> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> > index 9c10fb180f438..8b5a5ddea4293 100644
>> > --- a/arch/riscv/include/asm/thread_info.h
>> > +++ b/arch/riscv/include/asm/thread_info.h
>> > @@ -107,6 +107,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>> >   * - pending work-to-be-done flags are in lowest half-word
>> >   * - other flags in upper half-word(s)
>> >   */
>> > +#define TIF_NEED_RESCHED_LAZY	0       /* Lazy rescheduling needed */
>> >  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>> >  #define TIF_SIGPENDING		2	/* signal pending */
>> >  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
>>
>> So for x86 I shuffled the flags around to have the two NEED_RESCHED ones
>> side-by-side. Not strictly required ofcourse, but...
>
> I can shuffle them. I don't think the riscv camp will complain (saying
> this for them to actual complain if so).

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

