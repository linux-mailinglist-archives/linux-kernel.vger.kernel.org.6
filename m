Return-Path: <linux-kernel+bounces-539625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE9A4A6A7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460FA7A9093
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B019D1DF752;
	Fri, 28 Feb 2025 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okRC2DRb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9571DF737
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786059; cv=none; b=ocoZvAPKW1HcjNfzTUVdgi2Kziwn43GL15xvieitPcdf+IUptleOp/rQZmmMZAu8UUXZj+ZGURjaNn0zoPyZ0cxXccSWY5Um1thQQHubOVSyg42/jgYLccxBPdU+ZRqWC/Jl5QZdWWaCRZQqKD00T56833l7Whx/2aeHJ5Vl5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786059; c=relaxed/simple;
	bh=X4fmUz6M9WHs8xbXMrIP+NMrZCQ+OGR4N2wlvwZQDa8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GRA47jzvTeCpAH7EiFEnEsts0GINwMpX1lU47vKpeaKEL+M01m2nplOC2xbZQZq1ezG+zXTNquOSp0wXJjCF5MzK3rZk/wnasxdLAw/mMf7mewHjErBQQtNebu1nFnI8Qcq20La8kJmAZSfDIVbuGrsX6smz/55U7wyZm9MS5hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okRC2DRb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2feb8d29740so3277986a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740786057; x=1741390857; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y6kdIhbmecG2s6oijg3hrb/HZDz6lI2TUduP2e++VE=;
        b=okRC2DRbgKcWRYvPF7gqxNA3TCSIH26D1yX+2+QgGX9SQUME4zhs6JjKJALsgEXcdk
         HIbCfhmuKupkBekiX5raGgNAhKzmEsIuwCC/PCZ2am/b/yQhDNM5nmKa6cV3Pu5COU2S
         pc3l6LVsFIlLOUh8tC49gkgpkltw0cwveVvbKi7YggMu2x30Y4+gZuJhRypBVkb+lb54
         MLIyPQUZv8q6UmrslpLQou0n5Qbg5McK0Zb6I2wnpi/VT7w2q/QIHZQF1/OLqOnI6s0R
         P9sxkyftuD4GMn8FvJ+XidAlfJ7xlAVuDnF73DJvSsR+D/g2sDvJ2xlrNty8uMRrQK+2
         fpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740786057; x=1741390857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y6kdIhbmecG2s6oijg3hrb/HZDz6lI2TUduP2e++VE=;
        b=w/lcOQmmPZFdPohvmxOEUGJauTWxd2garjhqkV88Ra9Aa976VZ3NFTFht2CtdWJksH
         geXo645PtmgrWqtdYZAlhLlAXPvjkDOXspCOU8lsAPRRGOIWDH7+bxYkxxOv8Ws05lgy
         YzgvMsouB3/ru1uAHzspa0mYa5Nwjv3TE3l8OUO7BJPHLmpkF6jsH1GVxCpBT8TDSbhu
         K0qYhoAKyjkZEgn/nHX+/mosBZscDfBFfTy65WwGCaRjZzdqhTLsjInDIxZRYcVph7G9
         EPeFzX22Ey/sfI/b5BSS1O1PXXzskZBS232ILZLeoBb6azLm31J0NYaxetC7UTUF725t
         Bxtg==
X-Gm-Message-State: AOJu0YzGyvGXr7qAgr5gdStmuDfC5OBGACvsa9OgR7dPG/Q01NrlTTsU
	OQexMXwKGytgc3AJLda9iblnbgDaXgkkxRcX/pwyI4MpkBP1OYMIQlfq6U3IuxTfbGnHY7lPU3f
	kSg==
X-Google-Smtp-Source: AGHT+IGi1fgzqXBy5vxKuvEo/ZHYsPpv8I4K571iURnu3dRsdMXh/qVkN7umYar1m8IF6nKWFJwTiW+l/DA=
X-Received: from pjbsj5.prod.google.com ([2002:a17:90b:2d85:b0:2f9:c349:2f84])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2883:b0:2ee:d63f:d8f
 with SMTP id 98e67ed59e1d1-2febab5ba5fmr8017786a91.13.1740786057156; Fri, 28
 Feb 2025 15:40:57 -0800 (PST)
Date: Fri, 28 Feb 2025 15:40:28 -0800
In-Reply-To: <20250226074131.312565-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226074131.312565-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174076296192.3737724.4386230620749350319.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/tdp_mmu: Remove tdp_mmu_for_each_pte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"

On Wed, 26 Feb 2025 09:41:31 +0200, Nikolay Borisov wrote:
> That macro acts as a different name for for_each_tdp_pte, apart from
> adding cognitive load it doesn't bring any value. Let's remove it.

Applied to kvm-x86 mmu, thanks!

[1/1] KVM: x86/tdp_mmu: Remove tdp_mmu_for_each_pte()
      https://github.com/kvm-x86/linux/commit/0dab791f05ce

--
https://github.com/kvm-x86/linux/tree/next

