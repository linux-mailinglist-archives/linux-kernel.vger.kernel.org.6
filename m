Return-Path: <linux-kernel+bounces-201555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBF38FBFF7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D3E1F25DAA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B68614D6F6;
	Tue,  4 Jun 2024 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BD/4ppr3"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D314D28E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544284; cv=none; b=ZCyFRcEsP6PDzlU3GWxJn0eB8MWrPZLJi7aH3GPgNMLGUr0aeiI5i6J3WPLHtaHcBBv/DkZw0uhzkgw13Akjw8Aw/0j2U74kipQ6WnHZ1qbizg7Cx5D5w1U1DuRxZ2tWK4JlHJtetl3o0m5es+LgkvatWdXFh1NMfKqVU1FtRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544284; c=relaxed/simple;
	bh=uCtcs6noFPE6r6gdZtSWPlGrjWvqC6KqdckCJe7HWX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mv+ox5aG9/f11tO9Fy5XgYIgxiMwtaRB/8DuV9CNn9NeM02uCZQaFPpnWmJdsDpp+AMk+m8tSbJMrys+JB1Ygnl16gJgvBOxDc8I/h+0xVfwLZUCccDI2u5CSstoQAaI3U7ee9BTz5RcPdrSqBS3WO6Tp24ENs1Saz8IfUK1rdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BD/4ppr3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c554776d0fso322742a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717544282; x=1718149082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rk/FtP1IyVv3vBWrTDjMqBLA7Gf0KiY9agQ/oo54g7U=;
        b=BD/4ppr3C6nPPgGgTQB/aEqlJaRdAfr18tZW9g3nuyYPYlBHL0W0rIwzFXGCM0YD2c
         a9ClTmqUDMQXFht8GM6VqCbmqFYA6lp7DROy0breCzD5gJixNcDzP5YEMDMNflYSJLn8
         IM7nBLfOccTTwvVFxqfyDizBy4l2vfUtkUTgk3ABctotDbzMaP6M1YdEYqd5Qx7dKjd0
         jfRQgs56yAgaF/SFTn1HjgL37AkhNWHw6ph3nKZ0R9UN9MJ72yYM3La9xzuFgvzOozsp
         waDHm/+LMIW/YR0nOgwKIKBgsdG2LOZmbUnYH/nRxj5JupJoKREPAeZB3reX3rb9iBRi
         pdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717544282; x=1718149082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rk/FtP1IyVv3vBWrTDjMqBLA7Gf0KiY9agQ/oo54g7U=;
        b=U1sk7nI+ogUIE8zSezhBsHpG1p/IxXr7BnC0jBgnsVgjYmfELyewJtemOgTkIKuOqe
         Q92p2RB3V++fDKPG9hyTSxGoBTDgvLd8E78uBWyB7jNac8IYjHXvXVZfABAKyyGL4vmU
         5lQ2yesHw0Kl2E8RQond7xIqmcOB/Jbi3xmR0pYhwgmroOeoWdHSk6waNXqfeyHZYKj3
         yfpPjCagQ7SF1KheGFJ69vlxG6YIXlPckaOxd3PSe11vil8oZjWl4gT4tLpBBgq6siZn
         gVGUMyxRRXmCUJCy5zqii5hYveuVo1irOsZGcHLh9+ML/qfIXpOQj6+7vGyciNnR/8Bg
         Ujdw==
X-Forwarded-Encrypted: i=1; AJvYcCWnsK/aCKq/rWwJJuakOw6G+wT08UAVvZ6C1+GI1QCeB8QnuVLfpWa6ApjsS3L7OMFUwABdGeaWqeXFYlu8FAfe1Jv3DbFbt0CRYx6d
X-Gm-Message-State: AOJu0YxgXlblZWheiSpUk8vGXeu/hlyxipayU9HSs/be6y8OWPm67Hqh
	0WoQvxsTXpqOG1j/vYSuSMMS+TLAiwyMntUClLa7eGnxdEs2Q8gmw1gjTw+8LtKvqfYjK5Rh+mP
	WNA==
X-Google-Smtp-Source: AGHT+IHZIE1aSJKNameo12IiZOPatLKvd0dlaPUQsUUAhUvJrz645sSwhtTznVjkzZVO3C3zlnmmqxLLb2s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6b07:b0:2c2:4117:2401 with SMTP id
 98e67ed59e1d1-2c27cc5925cmr42158a91.2.1717544282231; Tue, 04 Jun 2024
 16:38:02 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:31 -0700
In-Reply-To: <20240423191649.2885257-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423191649.2885257-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754322115.2778750.1004415588461260295.b4-ty@google.com>
Subject: Re: [PATCH] Revert "KVM: async_pf: avoid recursive flushing of work items"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xu Yilun <yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 23 Apr 2024 12:16:49 -0700, Sean Christopherson wrote:
> Now that KVM does NOT gift async #PF workers a "struct kvm" reference,
> don't bother skipping "done" workers when flushing/canceling queued
> workers, as the deadlock that was being fudged around can no longer occur.
> When workers, i.e. async_pf_execute(), were gifted a referenced, it was
> possible for a worker to put the last reference and trigger VM destruction,
> i.e. trigger flushing of a workqueue from a worker in said workqueue.
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] Revert "KVM: async_pf: avoid recursive flushing of work items"
      https://github.com/kvm-x86/linux/commit/778c350eb580

--
https://github.com/kvm-x86/linux/tree/next

