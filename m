Return-Path: <linux-kernel+bounces-201547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09D98FBFD8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE241C22992
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85314E2CA;
	Tue,  4 Jun 2024 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKZvqdBr"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D814D281
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717543810; cv=none; b=FBcGVwHTFWv28v/l3VS8ls1sXKelFNkiOwvRq+Aq89GatpUXxkIhiCy9Uo3V9LceQABxvUy6NDlfmp/zEiwL3odFr2oEMPlliVjf5obkm7y8Kk2bJxoLmMy31ntro2BjYCq5w01N2USIu7JmW19Bw9Kv0V2qPxpBSRTqZwVW0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717543810; c=relaxed/simple;
	bh=69HXCGyB8IQaAuH9mcrsD6ho5FH5OexAKt+TkNR8mjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f5kFARt5dKcVd3JoFLo7CHrQnH5Kg9ed617Pu7/kb1HXnH8CyHsYbRaTAnin0aLo4eCoRO4vTdO68jn0vIZWAeB+zV7lSaajDl1BxbMmBXxom7gVQjo/1n/4rP1YJ8nDSnfo7K3QKG3oWUuEWHYSZVXSJmLKcZGOrbkXEjpGZrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKZvqdBr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a080977a5so106849747b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717543808; x=1718148608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbDVtO6uI5A9w7zVSGkxwTcTlqN/E5pMvXfmkLsiah8=;
        b=lKZvqdBr2tPp0dlrH3kbfbnmKMRLd/PKgksLCQSXqholER5cp3TccvqKIITlFRC4kT
         XT0RqnwCr2faGwXqpaKBWGqjtnwYYUXvLVCUm5XKDSHULn33tUz9h92AMU8vI8JU9rr9
         A60gRsyK6oVZDdBI2GsAx8dbqZp3HoxrdN2z/oWu8I3wvwjQvIxNBzUEewC5z2QAEq9t
         cnG5j6Nd6+x0lKz5A98b+nJx6LjuMbJXeRB1T7lfCxujR6Q80oGqOEJKGFcbj4wl8yeV
         DAegd8uXOumyxVpD4CYuovFWomByd36m6NjwnTRQ8/PUMAD+0vx8vylWgRKJ26w5hdBM
         aZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717543808; x=1718148608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbDVtO6uI5A9w7zVSGkxwTcTlqN/E5pMvXfmkLsiah8=;
        b=eW5XTcesdmeQGi1CJd6mdHHvCQNL3XjmBgdeXnmMEcjLd83985BH3MN/bBTjMc9crP
         tbJxBzlWRDbAksui6KGGcAg8zjluEMuela6i8M+HD5YzBr2bJDAQ9aWAB6xvniru8pQN
         HZq70xYwJhSO5ob9VUyFvtEnLwn4z9jcLVzOyMxYtu6Z0A2pl5hOdmcTQz7hNlA5i3fY
         rQZHBw5hGOJJZY2pkCaDURvIqN5AAOt68OwbeimsOC0koCz6OIRI30EITFKM1Ad/F7if
         VqMjPWT2uCldviDgN/bsLdnM0qWy+iEciOaBku4QZA4R7q3xdkUiONQ3wr5k3czeJzqX
         c0Sg==
X-Gm-Message-State: AOJu0YzRcbgFI5sVog++D/gYMAVrO2Z1H6WTO3NINUwvvry65u0lSBK9
	7dmyoS69Kh7BhIYD3V/qu5BZROHsIP1qJpCZPx992VQ7hriZSS+RJSp/yrVZ3Bjkbu3z4hqXHnR
	pZQ==
X-Google-Smtp-Source: AGHT+IH6h1btNIzSAg26Qi+fIhqNOAz7WTApq9B/RWDUDQ1ZENIHHizq/YlqKdlT7+QU3U2CwwhlbbZ3HfA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c07:b0:df4:7605:26d7 with SMTP id
 3f1490d57ef6-dfacacf729dmr277860276.9.1717543808128; Tue, 04 Jun 2024
 16:30:08 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:23 -0700
In-Reply-To: <20240515150804.9354-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515150804.9354-1-bp@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754273903.2777740.4190926733266969217.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Unexport kvm_debugfs_dir
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, KVM <kvm@vger.kernel.org>, 
	Borislav Petkov <bp@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
Content-Type: text/plain; charset="utf-8"

On Wed, 15 May 2024 17:08:04 +0200, Borislav Petkov wrote:
> After
> 
>   faf01aef0570 ("KVM: PPC: Merge powerpc's debugfs entry content into generic entry")
> 
> kvm_debugfs_dir is not used anywhere else outside of kvm_main.c
> 
> Unexport it and make it static.
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: Unexport kvm_debugfs_dir
      https://github.com/kvm-x86/linux/commit/96a02b9fa951

--
https://github.com/kvm-x86/linux/tree/next

