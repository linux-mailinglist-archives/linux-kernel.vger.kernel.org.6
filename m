Return-Path: <linux-kernel+bounces-390724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4689B7DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F080F1F226DC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EF91A2554;
	Thu, 31 Oct 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1528TI2e"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2A6A019
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387385; cv=none; b=syjdmLEU38ekVMtQAwU0NxQcqWrba1VjaY0QBtth4eBOdheKr9tamEkYxIWtiOYy3WUjQRBTMEOYk5Myl0+BFMEbDYDyWKt6aaLoVSMf2Q40zRjz2rsbyj6gmBX7f2QP2ukfJAFLUjXiGxz0QF0dUZs0I2OvCK5A3uUSWnc1O6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387385; c=relaxed/simple;
	bh=ZXFHWFKHL4fETMV8i377mhV5u+xSvQW2if9PiOkGyys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ouxQS1i2oBLtHh849b5JbKUKm+1hiagKuJxMMqzxyzv+rFgU94UtoSXDeQqru3SItdaCE5lTslCVGWzuTWKyVOZXcwQoelXHMOguV1jiCB6cX1bDlB6+26Xd89b0+bw69/qo7BrzITXUYrT6drGDh8At7eStbvoG4EqQB2YEpLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1528TI2e; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea8c2b257bso1243518a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730387383; x=1730992183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+Zs/48FaVXp/eqwzCE2pJ2xCzbPsm8EaasLiVupl5Q=;
        b=1528TI2eoTtvG4M1gzziguAU+ZgS2/ZKfD5D+xDGlE+KVXLuGCze6Y8GskTBwOIoPs
         L2eUOKSUqf0+Bl1x46tdTstp/rvE2RJnhNiFCieqAi6pcw5zuUQ0/tQQls9//pD+/gGs
         /lkpe/nvmvqCh6dHBHJxgnMEVQetYSDtCJepXwof5suCpwYh9O98mBTcjhTk0hpnLGYO
         ei3gFuag1jtbynJRqTESvSB2u96SgHLy/DC5LI+tUKldd1KI+QPpaSK0p01eD10JYV9b
         BK8T+mBNjYGwn2gk+oe6MdMPfk8oOkORQDYRn4lz8BBfB+0NjxxszyWVDfKwOxRxJwG1
         arZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730387383; x=1730992183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+Zs/48FaVXp/eqwzCE2pJ2xCzbPsm8EaasLiVupl5Q=;
        b=kuyO+O1awJ69X0MYBk2khKWqJQYYWKKl28AL8pP6YLkBfk0BpzayLrRetlMjSF4HdR
         cor8XHrp1Flmgz5MzD84VlevBOi3v+AEJpt1UhWBmaw2yPDGHxT3U0gaFAHFJEfVF6wt
         NJNNt66Q2X/6pF46ViQkKabxfzcsdxuijJ2iHt0bM7tuy0AgCGmYwSKWB0W2HsBIOtDz
         +YKxxk9ko+shZwc65R9rYUYYmdBXN94eNqiW7oxE/LhYlgE3zuE4k1TnU60uIS3xj8Cw
         AjQ3oA6e8MFA4fOq5c0hh0/b2h+zXzVCFIDahIKLfiOvU178ZQpHOyrI7DR0ZNz7tp0X
         Yjtw==
X-Gm-Message-State: AOJu0YzP8K3ZtWzkHieS6Y+HzUV4JTP+F8FJGdLrPT10p3MqPXk7UfuW
	b9BoauE+L+wgjdEPT9THg7v3BNEGLMnr0TULeJW85zmMFL5xNs/4kyKT5OWsrCNPtrf/IyrhUKi
	/YQ==
X-Google-Smtp-Source: AGHT+IF/JOczwYI7vGS8c8FFUvQ0c/vYG1oRhZCez199HGcXQyWe2bFWEMmM4uHSlUiNA3nzTJH8vgPqY4s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d64c:b0:2e2:d879:7cfd with SMTP id
 98e67ed59e1d1-2e93c119cf9mr18714a91.2.1730387382024; Thu, 31 Oct 2024
 08:09:42 -0700 (PDT)
Date: Thu, 31 Oct 2024 08:09:40 -0700
In-Reply-To: <682cefa6-9a74-4b8b-97e2-38a1c58c6e72@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241008171156.11972-1-suravee.suthikulpanit@amd.com> <682cefa6-9a74-4b8b-97e2-38a1c58c6e72@amd.com>
Message-ID: <ZyOdtFzfARpJ8_fj@google.com>
Subject: Re: [PATCH] KVM: SVM: Increase X2AVIC limit to 4096 vcpus
From: Sean Christopherson <seanjc@google.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	rkrcmar@redhat.com, jon.grimm@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 31, 2024, Suravee Suthikulpanit wrote:
> Hi All,
> 
> Any concerns for this patch?

Don't know, I haven't looked closely.  I am not planning on looking at this for
3+ weeks, as I want to sort out the KVM_CAP_MAX_VCPUS mess first[*], along with
a multitude of other bugs/flaws in the AVIC and posted interrupt code.  I have
crude patches, but they need changelogs and more testing; I don't expect to post
them for at least 2 weeks.

[*] https://lore.kernel.org/all/20230815213533.548732-1-seanjc@google.com

