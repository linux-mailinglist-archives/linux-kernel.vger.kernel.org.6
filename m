Return-Path: <linux-kernel+bounces-178036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA0E8C47B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80606B2295F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BBD770F4;
	Mon, 13 May 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2/HHKJh"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D239FD8
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629249; cv=none; b=UazzRmTvUmjeHlbzD6TLBDgBjCiDYlnVp8GMHIht5fW2PveQ36htgNir0kuOrO2bQDR83qGk63QENZVXWOHjlL7f7qDKDCQr8hgHYARuXLoydoP/3CFoXhSzLEPtr7AywYZlY4LJzU0W9/H98tzya8/YPeRm5DvigwDyTGVylVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629249; c=relaxed/simple;
	bh=//NGOHTIP6HghHGerT7/lK4Uz6RPwCBltXnXUwVGkvM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PcuwHcSwnDhrR2gKqdQuJhxz41H+KP2tx/wwEMWgbqALz6RJBWkqNLnxFo+A+dfv1gsvM8iN2W8CStkzqy/cR2Jwo8nN0jUN7pXvBvLFNICATIi7s6h9SCubX6jvba+dIUNN2RGHDfCjMELUdBe6M2w7voBz5k84eNBgFWeuT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2/HHKJh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0c36bbso95296617b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715629247; x=1716234047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVao59+8SWn5R7wq1a2EyacHCsnmokQY3DXiYJQLN0I=;
        b=X2/HHKJh35SGbbfoCeEwrVgbdwXvMBSLfp0FDriUHjM33U+VBxcfE6aMi2QLaBCYk6
         vqD6MIixzDIe9vqYGlrY4bNC8eDBcRtYr/pQwOq3pgW+pUsd8tBXqLRwhdfn7AF+uW8x
         k7Qm75uQHgLcwCI/RiIy0MhufQUyUaY6NtlaflBU7Z8wmKOKSUUr795y5z9IuejnyS4o
         vZsx9HDhwxl3z+lWVrJOlD3AHpBhup07by/z2/KwAF1aFaaYxbxt8NqcDvUivJuDrT/0
         NmVPvAIuH4/RLJvhXkpR3fGMjHqnBjGilIFGo+2Iv+abbAyQHnGljcHON9N3TjdWzz38
         GwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629247; x=1716234047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVao59+8SWn5R7wq1a2EyacHCsnmokQY3DXiYJQLN0I=;
        b=UQzbNB+RLYq/sCy6oBbDVWGIt+w0eTtgOxtqr3KRRDbLXUiiWNAmfNAT6o6OpR9E+w
         Qvx5nXRW3yl75X/hh+pXJ1ZxZb5R6sK9FlRBYzTC9C2Vu8ccnNkLiYMQpdShFTH7dpzp
         Q+ZPkYfDvZEEqzLylLTAQzZW1iX6M97TqkMX9ECRgFRQtPemupo/7L2uic4CjSvNALBT
         PuGCCGSYr176A98xYOFDH9CvqtMrgI3TItJHuVi3nYHHdCadR4W7a5XmtIwGxOGAXoDL
         J1D0h3t18T7U0loCjoAn1OV56BgBQygJVcE2ejtVu1N8kDuXhFDf0Coyini4MLHHwFAq
         v1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU47qZwr867SeDi/aOjZu6SiATGXQECRajwq2D73PJp9v6Kkg2Qsux3HFjk1mt+a76VyVFjeohCsLS1SjV29iYedLexoOD/5IjvS+JS
X-Gm-Message-State: AOJu0YwtN1xnGktbMJnUPI578T5+vGuHAb2NcRVD0GNbdb+UnE06rgIg
	xKPTLm2O+fBSRu/vDLzUSh+guKHKbW17SX2tvcetN0eXel7ObRuMspjOv212bByo2nHCrCXNi9S
	HTQ==
X-Google-Smtp-Source: AGHT+IHQJ6MAKEsQp7Jyujf1L79g5X9IUEtHDXgP8rtrY9IbuHK5YWHJ/ubuIU33ww2PXq/pEwLP75RZH3k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:120f:b0:dcb:e982:4e40 with SMTP id
 3f1490d57ef6-dee4f38b7cbmr3058891276.12.1715629247216; Mon, 13 May 2024
 12:40:47 -0700 (PDT)
Date: Mon, 13 May 2024 12:40:45 -0700
In-Reply-To: <20240511020557.1198200-1-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240511020557.1198200-1-leobras@redhat.com>
Message-ID: <ZkJsvTH3Nye-TGVa@google.com>
Subject: Re: [RFC PATCH 1/1] kvm: Note an RCU quiescent state on guest exit
From: Sean Christopherson <seanjc@google.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 10, 2024, Leonardo Bras wrote:
> As of today, KVM notes a quiescent state only in guest entry, which is good
> as it avoids the guest being interrupted for current RCU operations.
> 
> While the guest vcpu runs, it can be interrupted by a timer IRQ that will
> check for any RCU operations waiting for this CPU. In case there are any of
> such, it invokes rcu_core() in order to sched-out the current thread and
> note a quiescent state.
> 
> This occasional schedule work will introduce tens of microsseconds of
> latency, which is really bad for vcpus running latency-sensitive
> applications, such as real-time workloads.
> 
> So, note a quiescent state in guest exit, so the interrupted guests is able
> to deal with any pending RCU operations before being required to invoke
> rcu_core(), and thus avoid the overhead of related scheduler work.

Are there any downsides to this?  E.g. extra latency or anything?  KVM will note
a context switch on the next VM-Enter, so even if there is extra latency or
something, KVM will eventually take the hit in the common case no matter what.
But I know some setups are sensitive to handling select VM-Exits as soon as possible.

I ask mainly because it seems like a no brainer to me to have both VM-Entry and
VM-Exit note the context switch, which begs the question of why KVM isn't already
doing that.  I assume it was just oversight when commit 126a6a542446 ("kvm,rcu,nohz:
use RCU extended quiescent state when running KVM guest") handled the VM-Entry
case?

