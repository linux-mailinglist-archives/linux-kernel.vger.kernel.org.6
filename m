Return-Path: <linux-kernel+bounces-404422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721439C438E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3693B284B18
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF411A726D;
	Mon, 11 Nov 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfgPUtoU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23171A08DF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346053; cv=none; b=EgUOGHvlh/ilK6JHmJoaxdL30HXI001QK5JoKoko5F7RTiH7NS909rOiHbQ0L7dbFB+Ra/AvIwCNCq+nXWHItf/eP6tgEEcMmt91UC43r+3Wui/NhoabgknJrhF0egsx2PHGAX+1djF0EoNp3NznzTJ5adr3YPoEV76EoZK6EuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346053; c=relaxed/simple;
	bh=WYFgUndS+KzKZFVk4xzsNFADcQ4DyMgY2lgh6bjlHJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M0EVQ/gogGKKE5rdUNZcjrCBmGPNpt76TiGMjeCgDazrln1ZAOBKAV4RpUjcRPyKVTj//TZChK7lePnQuh1nRJ7FVTxSGoMt4dm9TnK6lOd1Q1HV8MAIvTTsj93dIFLGfsGrJcnJHS4rX7SE2f4+mkak3wZ2+D3ICpVRJ16vgec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yfgPUtoU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30daaf5928so8850669276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731346051; x=1731950851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmKizeQaKfhibWJZ/2erOOyrrRJ4rvJRJ+g7NHKLI9A=;
        b=yfgPUtoU6jud26MmV8uJ2jp72DVX3Ekf4xExpXF2NHA0RwozSP8KOZxESwPL4EsqEH
         64NX7tpaAwX3MtnnCtXrWo6tAIfITVjMZTMRPk++eu7Er2XNumHGAo39uZk9TMwccy2N
         0O2S/WzDGXw0HLuKYPJ0gm50fF7VmdFOwonLfwFzOaEwO9k9VBx6fTGruymeYMVD2gEg
         0ozY5n0NCihp4JJin8YWUkinbFLRY7zkANbnUuC21LRNgNIxh4Jc1BEozLvGQEItvn/k
         TK7+e0VNS9i+ahl8KV58sPxCyyEhOKGqMMs6BTge5Rs0NjkYorx4vk8XZxSWq4TnDibX
         aJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731346051; x=1731950851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmKizeQaKfhibWJZ/2erOOyrrRJ4rvJRJ+g7NHKLI9A=;
        b=Ercb+5Dj/OVvcIWW/AvC9Wb+Qn0NWRvz/P254pJNZ52K/8QSoUz03waUweVo1BoMft
         Xrg5oKfVn0gWnABIcfIN5LOHfcosoAJFkfgZzLeykBZa5EDm7WDOKW2+vCjFh60SwKlu
         rpZdEXPhn6Iu8NsUV4AXSVXSG7wOHNxYB/VwzIAj7c9w6VCsD7Pwnj2AhckTjLUhQ2Tr
         kWI9ocorw44MnZ1G80bCrwL3CL9zFzCeZ+S6FOGH3oJxOjUBy3k+78eTerLzEZLfkwKP
         5+3ReRZ1f4yzpX7WPoNM73GOqw2jnaUj97AUUPiOkNb/a3QNroeGw4AkljnnuTUWaywM
         2J6w==
X-Forwarded-Encrypted: i=1; AJvYcCUnZBo4Qs4hYEORaanEemhxr6LtYrP47Ql/UVbU2V2wdsSTxPftdYDfvbUApqqjUiJJV5291BViR+Uk1yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp2zg2CMtYHMRLC84n6+szk6i6Q19jMz+IhCbH2NSRVM8pm9sm
	EjZQuJcb7ZnKzxz4i16vlLe32NboLJmoLLszYt+W8A2Yc+5k81KM3pRZhP+OH55yXzvlN38/N0S
	J9g==
X-Google-Smtp-Source: AGHT+IHAAU2e5YnmnPTi1KW3zzMNtGPxVYMB2bEkL/o+Wnl4gRUGSDioaDbR1aybQBx/36KLZnDxqf/1xek=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a5b:809:0:b0:e2e:3401:ea0f with SMTP id
 3f1490d57ef6-e337f8f63a3mr25772276.7.1731346050773; Mon, 11 Nov 2024 09:27:30
 -0800 (PST)
Date: Mon, 11 Nov 2024 09:27:29 -0800
In-Reply-To: <20241111115935.796797988@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111115935.796797988@infradead.org>
Message-ID: <ZzI-gcYieawJeCyV@google.com>
Subject: Re: [PATCH v2 00/12] x86/kvm/emulate: Avoid RET for FASTOPs
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: pbonzini@redhat.com, jpoimboe@redhat.com, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	jthoughton@google.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 11, 2024, Peter Zijlstra wrote:
> Hi!
> 
> At long last, a respin of these patches.
> 
> The FASTOPs are special because they rely on RET to preserve CFLAGS, which is a
> problem with all the mitigation stuff. Also see things like: ba5ca5e5e6a1
> ("x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()").
> 
> Rework FASTOPs to no longer use RET and side-step the problem of trying to make
> the various return thunks preserve CFLAGS for just this one case.
> 
> There are two separate instances, test_cc() and fastop(). The first is
> basically a SETCC wrapper, which seems like a very complicated (and somewhat
> expensive) way to read FLAGS. Instead use the code we already have to emulate
> JCC to fully emulate the instruction.
> 
> That then leaves fastop(), which when marked noinline is guaranteed to exist
> only once. As such, CALL+RET isn't needed, because we'll always be RETurning to
> the same location, as such replace with JMP+JMP.
> 
> My plan is to take the objtool patches through tip/objtool/core, the nospec
> patches through tip/x86/core and either stick the fastop patches in that latter
> tree if the KVM folks agree, or they can merge the aforementioned two branches
> and then stick the patches on top, whatever works for people.

Unless Paolo objects, I think it makes sense to take the fastop patches through
tip/x86/core.

