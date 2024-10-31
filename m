Return-Path: <linux-kernel+bounces-391203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD79B83C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ECC281F96
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E3D1CEAC6;
	Thu, 31 Oct 2024 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoEJ7xvs"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938E1CCEF0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404502; cv=none; b=H6FM6On/0qf4uQNKlhPXgznPZ79e3643QvGRueC5UR+8exx5dj/s/VuCgxTnNwntyixon9n1FmslrLnIuF+PACGeuVhhDM+pquodrnpjzcGtJWtspGdCKUfpALKHarXOL0aMCd+EyEHjIqgCX5GlQj4Esh9ulg2oCRWUWqtoVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404502; c=relaxed/simple;
	bh=c1HM76fjlY7CwkDyriwMdyZX1W8t26uKQzpAfEx2zh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b5ylVBLabTTLRX/QTBgmvyqZWSRl/mn2SwNqwPJYLH5pQADw6FCzNBB21Mb6VZ2uMQ+5+79PVpbuGr5Y5HX5/gfnvadabKQd+dh28SspOW9Sbh9ry/qv45MLzpGoPGYguw/QNfuA3w7LLcz4jQWBT6h08dzDu9eU++DGluZygFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoEJ7xvs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30ceaa5feeso2275840276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404499; x=1731009299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=myYdWc4AXlxP7rCEkTdvNwOYER3RXhdDy5/e9p3ENIM=;
        b=ZoEJ7xvsCcKYIxIzahCpEcXMDlIEFUSqL9GVP+J790S1o2U2BjEhgwI/4yZZp5kDIw
         zurkzXNfiAMTzwQVoqkMhKke4a1fZaR4RWrA9PqOGynceFjfRtLaZFyd0n3k1quT7vOI
         fedQLDybGEl3PV26DGECr7Wb51UuA1SwLg7yVX1bJ1gtC/Vmsxg9HikG7SJcmO/e5QwT
         voE20EOwdYOgBcDQUnLJyrApeNdxD6pbAQKSsp0dmcfyoDzhresrTIICm3zr69AIJkuX
         B1Pws0NKIKwlV1Tf2RxBRDM4bOMlxHqAcfsWOB8rmV8SZykdaV2YA2amQqVe2MAGPUAp
         c/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404499; x=1731009299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myYdWc4AXlxP7rCEkTdvNwOYER3RXhdDy5/e9p3ENIM=;
        b=ADlBt2S5sa+simLT07Axr42WWEnSaNPW/2YN+lZ4TpqmT4qOb4x3Hwv+IkZnA5nt/T
         iuHn9zDSDz6HabomoK22X7mkqIvsLoBIiTWKccQVXP0on/SMzVnel322x+sgNNAs51t+
         r1Zbg6lH7DTvRiq7qi4gx8/8CEaOG6xcXd15bX+eGDLr7TL8rmoG07YOgVX9jFZ51sUe
         yBvgdlCAVyqC6lzJkTn0VA8YMcGTNxmwDFgROBeWUdta7QLuRLuNFxNPHGnVL6DQkFRz
         Z7GrVcGQUXmmqkGbgwqPEPPYF7NeHqTHKlPQuutfuvmG1EJsbGGldpomZD/FERMx2VWt
         f3FA==
X-Forwarded-Encrypted: i=1; AJvYcCWz3F7WqNh5LT6t3LVL9fRuCsrS1cvosqsgR/H5VZbJrJ3+FO99keiwwUji+4pgnu/ruCQYiI4VLfskXAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ynwp64MFKvyIvEakIi/FtEdTZ3tg5B9mnZdM7dbyQpndYMF5
	UaEm76WwGjsJFsdB1/nGMJlgHbKKyKJMlhKqcR5YtennIEKYEo2FGiNW3mfL8xKp7BPP4efyO6r
	SuA==
X-Google-Smtp-Source: AGHT+IHzkm6rBRUPrDiVnyIYRt3aOkdmQNiBS+4yPaHYrPKXPiEsgOBP9Fa60YXyk+XJLjYWxYbkA0ptEZM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:3602:0:b0:e22:3aea:6eb5 with SMTP id
 3f1490d57ef6-e3302686c15mr1931276.7.1730404499563; Thu, 31 Oct 2024 12:54:59
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:41 -0700
In-Reply-To: <20240802200420.330769-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802200420.330769-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039507056.1509043.12101873900724716741.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Document an erratum in KVM_SET_VCPU_EVENTS on
 Intel CPUs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 02 Aug 2024 13:04:20 -0700, Sean Christopherson wrote:
> Document a flaw in KVM's ABI which lets userspace attempt to inject a
> "bad" hardware exception event, and thus induce VM-Fail on Intel CPUs.
> Fixing the flaw is a fool's errand, as AMD doesn't sanity check the
> validity of the error code, Intel CPUs that support CET relax the check
> for Protected Mode, userspace can change the mode after queueing an
> exception, KVM ignores the error code when emulating Real Mode exceptions,
> and so on and so forth.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Document an erratum in KVM_SET_VCPU_EVENTS on Intel CPUs
      https://github.com/kvm-x86/linux/commit/eebc1cfae6c9

--
https://github.com/kvm-x86/linux/tree/next

