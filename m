Return-Path: <linux-kernel+bounces-532749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B09A451CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA81B17CA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2E1547C3;
	Wed, 26 Feb 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZY+f46QH"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACEC1494C9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531600; cv=none; b=Bv5u7cQT2298S+I29Vm/9lZlNx6WetVZFVf084I7GXqyBux4qejxVh0PqMkWFASP/5lhxW/6Sdjv+ePRtTaRMs/iTNQW1iNpGH7n9kWWBRy2XcFq+4UrFjsj4WQKJ/fkRJGYui88tR2NVBn6r2i1uwjsm+gLB8N4nJqZT9QEZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531600; c=relaxed/simple;
	bh=UZuoXvVoYlHLe2ZJ31ykIrX5on5fG3MR/NQwxEXkUhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uGR7lPG6wiw7PqZUnO7Z2ga1HxQICGynZE7BMnR9PSWxPclW9pPPmGOFy+zFrFbceDd5TGBOzksQC4gljpusBGPDi0WiU4doFYB5uTPBee5uNTgSY9ptF57qXvZZCdmv+CH18ARBSqAhjggjOdVz3m0FBRamSy2k0gbbyfRrW8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZY+f46QH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-221063a808dso121690475ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740531598; x=1741136398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/yRfs+ROvmr6zgK0XZwah8gAq+1Fneqtf50nUYSsfQ=;
        b=ZY+f46QHFnmxWoJHh+i+SHK/+ce/wTI1ZA7Bpelya1OHnS56lZE7kRodK7GsU69iri
         VYRQi573BmknGC9r6tycudbfw6wABFsHswAb+MKIKopIKGAEzOZsZERHl2648Iqs7MLP
         B0vj9RO8/ztulQwPR6FmfVnW8GDxI6reszsIpVZ++FmhvYHgQtp3R6MyxzW+285zjSxY
         aBvtA8+xsCqHNbMrF4noPda2SgN8aufePecHihm6Fc85Tb9ZdWIT4nYGn2RaPoVHsdlh
         k6JrrIXuLUiX3/YDNQhMfMJjK4Qd/hHJ76SlXbV4HJp0AjU855ipV/4erbYHhvEGZOO9
         XNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740531598; x=1741136398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/yRfs+ROvmr6zgK0XZwah8gAq+1Fneqtf50nUYSsfQ=;
        b=mC1frth4M57m5TWYWYM03G3LUpDa7lD8krShhkJLGJI5dP42YzyrfbpMU6zFjnXS/c
         FOL3fm0cSNwApnsubjIuaFsW51tVIboXmaNgcv1EYAYgtZiBExCRbtnTQETvZ82vpnq+
         tPxM3JHabmTcOnmYJQzvu3KEWHxJ74Rx3xFt1uuPUK3CW71uDWHRyK6Xq+MTRsDvGPvd
         IYPqj9gfBqP7fKXx7utOr5oeFUxMLXLr7ehZhbZXJJB7toBtELkceVNEH8y/qrrjDNy3
         cpS9S5HS6wbNIHYlwbaPGMgwZ+nWes7Gg5DwmRXxMT2aQtAlXweM2uBF98GsFnkKs1xw
         46Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW8jWu6DR0J3JsIE/0f9A0GgBoTv9HZYDmp2wN61dRt+bjggNHN7rWrtpDzafmz7XLs/ZBnyI7vCVyitoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4IQmqvlVusvq3Vkw3FT7/EVJuKOcT1ujfQCczDofiRz5HMywR
	HkMWIGh6D3ks3581VPS/Nxiy3JLrUkP2z2XX0GlNbDi+n0t0CDAasu+/FIsPWqmzVEg/x7op1A6
	/8A==
X-Google-Smtp-Source: AGHT+IH496irJstB/O9V4P9MxhU3mjS9uTgOnuszad1Q+wwrdjAdB/BhMFsGxC844mwcdWTH/dPBcGAvxYg=
X-Received: from pjbsw14.prod.google.com ([2002:a17:90b:2c8e:b0:2fc:11a0:c546])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cd:b0:220:c911:3f60
 with SMTP id d9443c01a7336-221a00260e0mr311608095ad.47.1740531598367; Tue, 25
 Feb 2025 16:59:58 -0800 (PST)
Date: Tue, 25 Feb 2025 16:59:52 -0800
In-Reply-To: <5fb9fa5e-5769-3ad8-32d8-e4a045f041a1@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250128015345.7929-1-szy0127@sjtu.edu.cn> <20250128015345.7929-2-szy0127@sjtu.edu.cn>
 <5fb9fa5e-5769-3ad8-32d8-e4a045f041a1@amd.com>
Message-ID: <Z75niMjZTQQ28HKP@google.com>
Subject: Re: [PATCH v7 1/3] KVM: x86: Add a wbinvd helper
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Zheyun Shen <szy0127@sjtu.edu.cn>, pbonzini@redhat.com, tglx@linutronix.de, 
	kevinloughlin@google.com, mingo@redhat.com, bp@alien8.de, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 06, 2025, Tom Lendacky wrote:
> On 1/27/25 19:53, Zheyun Shen wrote:
> > At the moment open-coded calls to on_each_cpu_mask() are used when
> > emulating wbinvd. A subsequent patch needs the same behavior and the
> > helper prevents callers from preparing some idential parameters.
> > 
> > Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>
> 
> Not sure if this wouldn't be better living in the same files that
> wbinvd_on_all_cpus() lives, so I'll leave it up to the maintainers.

It definitely belongs in arch/x86/lib/cache-smp.c.

