Return-Path: <linux-kernel+bounces-516763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AFAA3770E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C916D838
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177CE19D8B2;
	Sun, 16 Feb 2025 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlSUs8s3"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58017E4
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739732745; cv=none; b=k9XE0BQeL3KUf3+xznPE7AwZBGTUf2ParlWPlo97YvhlD44LRmzXb0ZicTHCw9761pj0aHBsX4kIZrFFovaEndfy4EbzT52UvSNCtJKTxq4BcCROXZUkF8wUvVUosGVENypUsLSfJt1UvCdD7N37kFr2aFJmDUl3NT36WeSi3XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739732745; c=relaxed/simple;
	bh=7zmPtr2cjnAs83oA1Bzmg5GPvsYWebFzV7YioVzF6d8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOu14Bk2n6y1ykca1hVxjzI45OgrJCwg6QzJaFgPCL0ZWI3DEFWnYgoIoEVqk9ycWjmIRngjt7nTIwGKKYLi1v0XphVifpau6xeJ6PEDrqAhwQsDnklclj3qnP/7yLYzbYHyeu/XfE2sv+lDPMsdAxIxO24VRd0Xjn6/8QTqblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlSUs8s3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43984e9cc90so966345e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 11:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739732742; x=1740337542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed8erAR/uNXchmY1jO2FgXilqROALpe46JaTvHN8cz8=;
        b=XlSUs8s3oT/A0d7Z3VoDEldr926HBiYM8UIBD/4jpRn4os2nu+GhheDA3MqITEm4GH
         3fHhh1Gvo8ZGhFhqMFWi1yM8govbK31fgwHnEz7ODyFUHU29jsezcCwO1fltk6FRAzGz
         WYzb2VkthOn5nOxKnAGFQd0k0v91eIpuM+0K2/Zej977H0/RK7XC82W9JqpzSehbunat
         BWlhbVvLudGGRwuZwGUzsm+eYrKdlisHRVRjsftnj3lGEWgDrRyDH8oCn4QhIt8hcF8r
         ySqxHgWh04h5tSTmWu7edS+Fjqd8JGXcGASaMnKYiT4LdI+FhYm5BiXwOs3NI1tIjQsz
         4BCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739732742; x=1740337542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed8erAR/uNXchmY1jO2FgXilqROALpe46JaTvHN8cz8=;
        b=gUfKR21RsMzk1wAQ1ip+AZJ32sXcKn8+u/tiQjS1Y8IJN9FXI1zOpfXKV4POQK5CdG
         teNaV8jOnk+8cVk1FD5nlYDBdiuH0asB+cfwrykEy763QwRCQUci3eNdgJ+3i3fPjrq4
         Wjan3vRW64BXfaUJ7rTKqngvmsrvoYWDGdXH37LvhftpMCwoGO3im8imoAcnARDDxcN/
         i9C3Lqp/gH7Zq17wJW2phOzpb3xLXaRpB1pDq9KYd949CmdUIvPcroO+BMv0oApn/eM+
         WncMRFSMw/jivA+qxchwZndCwnKTo2cEqeMQfSe3TJBt3NxmZy1/l/shv6uKVPaRLy1E
         2mPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+yET2dvIaP2MyQzQSsrq/nip24I1pvlraFC2UZe1PASN9YW+QKLOttmamLkviU6/gJnEIWXIboClrmeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYLuhBneJMP8lZ7EwRiuhTXiFns68TF2lKvnHJmL6CS3kTfWUB
	tVbtcYs+iKTLJmrJvEnWhdhuju5YDpVrFX/b7Zy5mYPYZP2WxRrz
X-Gm-Gg: ASbGncu0ST1RCKnQxHTqsmFGPO6lS1EE0wjxGid9jyEW1lVt5Jbz0i49VOUAGWfEIvc
	auBUlIvytAdUSMcoLzT22eHg14gFHQ/8c4L3sjkZfz+HCwLsaaXGN3iKzt3w2uwbvU/9bMCTz1/
	ipw9IRmcuUW9x+bqVQb6jEl2P5weWjpTSQ5e3CDEoMesn1DY9LhMBh9d+BlN573oDFvRjIDlJDp
	8An2i2jS3f41YSShv4+U4L8emUp+qFi/yroP8oIL/ybCDrCDNkvTgGkfQp40j9apRYj4a69ggaI
	k4jLfoy1osvFEZxt7Zk7Cvvca5gV7jeW+twUdFMo3EF06vKac03s8g==
X-Google-Smtp-Source: AGHT+IG68bIe0oyzJsT8gJiQWYK9Zph0ubJIckuXGJVGRXamSNK8i1sJBrQim6lwlgR1Xez1306MAQ==
X-Received: by 2002:a5d:59a2:0:b0:38f:3224:65e5 with SMTP id ffacd0b85a97d-38f339dee44mr6003708f8f.12.1739732741936;
        Sun, 16 Feb 2025 11:05:41 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f771dsm10130003f8f.81.2025.02.16.11.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 11:05:41 -0800 (PST)
Date: Sun, 16 Feb 2025 19:05:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, John Stultz <jstultz@google.com>, Saravana
 Kannan <saravanak@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig.hz: Change default HZ to 1000
Message-ID: <20250216190540.254512a5@pumpkin>
In-Reply-To: <20250210001915.123424-1-qyousef@layalina.io>
References: <20250210001915.123424-1-qyousef@layalina.io>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 00:19:15 +0000
Qais Yousef <qyousef@layalina.io> wrote:

> The frequency at which TICK happens is very important from scheduler
> perspective. There's a responsiveness trade-of that for interactive
> systems the current default is set too low.

The problem I see is that most people use a kernel from one of the distributions.
So you need to persuade them to change their default.
Change the default 'default' won't necessarily have any effect.

OTOH if you decouple the timer interrupt rate from HZ (or jiffies)
then it becomes possible to boot time (or even run-time) change
the timer interrupt rate.

So it makes much more sense to fix 'jiffies' as a 1ms counter and then
configure the timer interrupt to be a number of ms/jiffies.

This would be similar all the simplifications that came about by making
the high precision timestamps (etc) ns regardless of the actual
resolution on any specific hardware.

	David

