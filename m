Return-Path: <linux-kernel+bounces-248438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C292DD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D23928783B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F56F15958D;
	Wed, 10 Jul 2024 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxVFDFfZ"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45D15EFAF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655355; cv=none; b=t/qPlketQJZDyifsteVjJhbimBfR044cajb5wSK06tcxvzuaDUfi2t9Y6z5joXsW/+McTAiy+ATRs0oMb9ZgmS1Em7bHks8c31l30yO39V67RPk1Y+43hLmT0U3gzkwRpoPNhmjpvOqqDP50cP4/5uiwQwEsIwILb5NN8NJfKm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655355; c=relaxed/simple;
	bh=WpUWnTWcQ9yZbCFEuArGMs4Fxk919PYBB/xOGitk7xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll6rFYWqtLgkOkA7HSKR8WH5EanONWQ/R29YdTTt/OtRZt9fyGhys5gT2FZ6e+wIZwz0h/JiJFHWIZs1Pxqe3rebHbKrWs7rV6ayMOUUKsNbVE3bC5I0yKUE2coIGuluSXySgTfDQWZ6KeKmZVELmkX7mlHZse09CdnMLDPXhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxVFDFfZ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447df43324fso64781cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720655353; x=1721260153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WpUWnTWcQ9yZbCFEuArGMs4Fxk919PYBB/xOGitk7xM=;
        b=TxVFDFfZrvROa1IKZ3G5x2ZkEvq9G8gQk4z8oeAb/KpPpPvQOH/gIU0KLHUwUU6GFn
         zHjX3/emlwa1Wq8KkRnLm/gAk7ZSpGZd+0D0hWyGHNdvypxPkVvYAwNkIG7hDC0jmwns
         6BwPHSONhiwDP92nugSYgG/1eVSF9OzY4SWiAe45CXyIaey6oVcoW7jc7pvnOLXgCnNK
         AR5QwzdR+o+LAOiRAiEgiegcIRa2yNMefFsu/Zjn+6Ok0C22D+4MxmqggJiAH2ljTTCy
         rHuCbdu4xAxVsXkUPgUR1XYB3+y2/ecAqd96rNfabcyRGfdJAU47FpwBR8yJMOjCJI9u
         H6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720655353; x=1721260153;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WpUWnTWcQ9yZbCFEuArGMs4Fxk919PYBB/xOGitk7xM=;
        b=umgsK7DndA9YqgSPfX4GsPXueoDEZEnlhMQAuZwwRd+1UKLdyMhpBAgbIqxNNO3O1I
         +h/Bdqou6XwJYenDk6fpoC9A95NTAtxHfd+ozoz92vWO/MgX+mBCcvYpK0tN4FLHZsg0
         WTGm7iF6W06aL9cLTrfyw62VU0sX/ha65bnyoqoVKThM0C0J+UdRCU2bOuDN4XRTFWDJ
         DxsNbHntiNw977ipOsA6YctePgo/jV4F4uW5wKMdy7YKn9O9NbzRu3YzLS7AXsT/XfId
         AvKeAfRH1ip24NbrOORyCyKlSNyN2D8HUk5w1NK4RGANXM+oRSkNw/zPu751Cx/9GLG3
         JYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbeD35hGwNxr2YkGhCwQOTtmzrJ+TwK7j34P8FpaWx8Bm8sEM20LdXbHd6E0h+n7eOXQr++gL7DtJjE+Uvl2HP58IcvCPAeOq82/nG
X-Gm-Message-State: AOJu0Yzv8OLwRn8KP3C3ZQK/+VaxtA1o9MQ+FHGgY1+iLlTBdRZX/YsN
	AzE0sEt+zAu7ptVeM87zK43uIRHj9cRLiCLsQrqMnUsK7NT3uTd0wY8JjeaIgH4jz2SRJD1BZmZ
	RLho6JToava0SCXXyb2fsleAzp49U1esGiVLn
X-Google-Smtp-Source: AGHT+IEuslvTU7O114maCMu6s7q1QatazKYK4Au3LHFSN1TQt2fd6q24xfMVdE/dWH6oyRO5MWqPuiKjKkMbsPD4dqw=
X-Received: by 2002:ac8:7386:0:b0:447:ec33:f488 with SMTP id
 d75a77b69052e-44d0aa4788bmr1329661cf.4.1720655352838; Wed, 10 Jul 2024
 16:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 10 Jul 2024 16:48:36 -0700
Message-ID: <CADrL8HUHRMwUPhr7jLLBgD9YLFAnVHc=N-C=8er-x6GUtV97pQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/18] KVM: Post-copy live migration for guest_memfd
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ah, I put the wrong email for Peter! I'm so sorry!

