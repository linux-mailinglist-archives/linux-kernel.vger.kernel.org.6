Return-Path: <linux-kernel+bounces-389344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D4D9B6B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35A32826BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE411C460B;
	Wed, 30 Oct 2024 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NACy1icU"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245CF1B373A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311530; cv=none; b=i3A30c5AS0wvU4G0MoSMn05Iu2oy1vU7hrhx2MG9QI4Kb+G8tbNFsUohlTxmS5op/WXTFyDgV6rTNB1AhTIzyshiWIG0iWGGPshoKoMWK29aIpl/XeGnV0xJ53wRc7XgAUuC14HKTd3B6qPsu4nGGdCjYGVioeoLcytyFSvjqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311530; c=relaxed/simple;
	bh=RLqliAfR+UGshmcm/rvWnn4gb3e2hajQ9VrTmy21AS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T0uIxFoZUG0bcIqYmzU6q+eTcokpHjOgGsJvspXF7OdGtOnbyF3FcS8RHyDHxTLhtRMfAa+y18mNvSCY18FBCF85vF7BF0NISuafGYiJiBgDNH2Jl0D/detlnZNhO2CYw3dA+X1Sme3xggsmRyYlYY4ueaCNH1fID3tmAVuLZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NACy1icU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7c6a9c1a9b8so143831a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730311527; x=1730916327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsN+88z0+xTmi+w6uVBgNq1mMIkrfieQkUFjvlPFQfM=;
        b=NACy1icU6lwQ5Px4YEglKqcgTqpKim5vk8/mi3v1v0ZIbw/xLgRCboJcVLapMdi/X+
         TCvjcP7A20e7RWv0o7N9jmgc+JwIBB0Dh9gsXHfaVyLKz9ZHNjUZw0YnojHYqELpWfkk
         O578huqkJ5ghrztKvYsejqs5nXOjUV6IRvU6kKRNmX6iuAoKMeRFGTbGAA+UH6OflPb6
         Q8UWJaEloojSU58PBS9w/MLsLdVT4HGsa9PxmPJib54iKiEI+Qv7CNT7+wk8vfEE4cU+
         INSo7yhbsO2J8nxw6ck04jsU2JvuMW4V6CDUd24DwY1RBTUnp+k1IauhjhgkMdfBIS4k
         VenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730311527; x=1730916327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsN+88z0+xTmi+w6uVBgNq1mMIkrfieQkUFjvlPFQfM=;
        b=k83tXG3e1sP7WA0I3lo1Z0ymcrKWaY5l0EIwJoIvbeNy5+BnslCbynyS0e3YziTzZZ
         PTWOcLL20vMvCmKvJZk/eumXSEuIVA/y0YquDQ61lwb3b4woup8eEzR5zCIUgEOU2cOw
         U/prmtc6OFzIR6zLQsBY79oUEc88n6KkNnIbCs4/OLuCuxAGUlhjw1t26TUkXbsv5WhT
         XZRMmhEGJ/56ANCCnlTlHIDKT7FE/ZAhnXseXf6hNjJ2DN6Ik+1APHC6HhRdACyuYYed
         BCRs2PcjJkRIq5HEgnCzMbJYcMPUrJQe2VTbMlKQVwDYaS/pASXy+biwO8a+XlGj+I5/
         PPhw==
X-Forwarded-Encrypted: i=1; AJvYcCVb/XPJxINPDkIoGEoSaRY+MGJCaH64fnrwMEjlRsFprhU1vfX/4FVbJFdc2OWJFxK/1SDb2ts/6aYXMLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdI6o5fjdRU/EJyDR0EUS+51ja+zAGrBkpF641yvoMcHzywwN
	Eb+QW4o3XUE4Nx71/zcws/mB8Re8Vfd3ppDsmioWaKw+/pPhhXkKhi9Mr/RG1PE1iL5y1aLKvKL
	ZTg==
X-Google-Smtp-Source: AGHT+IEwpH94Knt5f0q0GCjhlJUDzsXFyX5obRCiBSHz/PN0wGXtDjYFudu4QwfLsjDgh1CzOxVnlDfj02A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:385c:0:b0:7ea:999a:7930 with SMTP id
 41be03b00d2f7-7edd7b6c7e8mr24481a12.1.1730311527208; Wed, 30 Oct 2024
 11:05:27 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:05:26 -0700
In-Reply-To: <c8e184b7acf1e073c0d6cf489031bc7d2b6304b0.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1729864615.git.namcao@linutronix.de> <c8e184b7acf1e073c0d6cf489031bc7d2b6304b0.1729864615.git.namcao@linutronix.de>
Message-ID: <ZyJ1ZrdxDhGTQ-JT@google.com>
Subject: Re: [PATCH 04/21] KVM: x86/xen: Initialize hrtimer in kvm_xen_init_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 28, 2024, Nam Cao wrote:
> The hrtimer is initialized in the KVM_XEN_VCPU_SET_ATTR ioctl. That caused
> problem in the past, because the hrtimer can be initialized multiple times,
> which was fixed by commit af735db31285 ("KVM: x86/xen: Initialize Xen timer
> only once"). This commit avoids initializing the timer multiple times by
> checking the field 'function' of struct hrtimer to determine if it has
> already been initialized.
> 
> Instead of "abusing" the 'function' field, move the hrtimer initialization
> into kvm_xen_init_vcpu() so that it will only be initialized once.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

With or without the helper dropped, which can easily go on top at our leisure:

Acked-by: Sean Christopherson <seanjc@google.com>

