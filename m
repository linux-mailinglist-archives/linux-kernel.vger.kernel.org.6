Return-Path: <linux-kernel+bounces-570007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F4FA6AAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96AC486636
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99060223705;
	Thu, 20 Mar 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/9DH1va"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E961EC006
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486551; cv=none; b=Qe+kURk9xoY/sX/qYqWuifYCTVK3cK/7WZDhHQkMGRUBL03XowQzqqY/ekltahP9/6uP4UaSZBO/jM/sFa+5fgSMuP/YWZp+c/2iwJnIsAePRSH2GNOh4Jb0xhpI0DzL66uFC4WaAWAlEmyLnIsy2O8HFC2mozjSrWYi38qNPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486551; c=relaxed/simple;
	bh=u1Hi8rfaHFW2dGSL/G7Kp5UBXH3MGXgX/6flLUzp0k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+bmmQnMyCDDQ3TfqD1eq8SKyVxJgMeXfBMQtCQTxedYKMYAEshiHcFWwvZljzzbRte8O0+tn3N0LRRy5AedpPby6klWs0hQ7qTf8ito+1iryVdoKBdAKhrH2+p7wGTCJSYfSSUvJiZpx304wah63viRm0yWd8msVNcwL4ooAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/9DH1va; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso12659a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742486547; x=1743091347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1Hi8rfaHFW2dGSL/G7Kp5UBXH3MGXgX/6flLUzp0k4=;
        b=a/9DH1vaEB84rEDQTvOZoYhrzdj2TqXaP03WGqcy1Au2OVQclw0jC+fcWfAWBUDcJI
         ebCuHULRaTFcTYjSlbDXDVR/EduXYHaDgPBHl2WjXFtczVW40m+ANlEe/B6X5JN42qQd
         s9fHqhaGQN4dXBJ8aPAg8ylPvSP106dbIRk+Cbm7+QVhbNaDxtOswLhPd2S7CDmS/55/
         EKMmOYXXvFQp/8FY6dHJkmltkJAIcpBjjsXGjRqB8SKwPFBvxS42c+r9u02rByafrCoH
         8z6PvzkBZ3EWiZao2sapNCPFjdZg0JygNFP4YlNDwB37Vdo6Hpf8/vp6OeowktkScAVx
         afYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486547; x=1743091347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1Hi8rfaHFW2dGSL/G7Kp5UBXH3MGXgX/6flLUzp0k4=;
        b=iBARV8wCoYldw16wtUJSIeyTdUNgs3Tg4L7Q3QFZNBEyX6Iql6mfS9MOgQTp1jlH2F
         kFX700XGEAREeTyl/PCyNLzoUaMtX/R3zlGW40kcS/84sm68vsvSMabKYCk57XemixCe
         BdOBijERCWiEeEDlu7HkrrrK07kw5dtwoWLvcbeaxuFdXJaS29axjI2crBo3tVw48Rvz
         pugJJtkWSfxBMpqQKxJfl1Jnm9FPo444gRW4GWkIS0C+EhjB/d43N6M9yShO42ekGTW0
         VaSdERHYN077ZxUetzbvtJPcBXyC9oUUNcU7eRh0owQeLeibhgMEzICps5NkZpp4K9oY
         9iUA==
X-Forwarded-Encrypted: i=1; AJvYcCVGxOmxPH7MIJk+kS9JG0VAzVWQXSt5YMClFgR9g0O0/jL7RuIXPc9rGPf4pGo7AIlleVJfI0H9MAPcUII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4KxqCb8Ddf6pdZsQydZdzTgolGzUONDxvbnR4HBnTr+9ZDei
	UEPn2Dqq81CMx0YulkWEnWSjsFGBSF65ebJyVAPF9ic47o1Xz6fYUgyKsI5Qo6oH5oTQc2PN58x
	SQQkfDtSqvASCsk0a7KxZPHNjvzzwH6o110vT
X-Gm-Gg: ASbGnct7Ap8GOL3vBnO1peorWWboQyNkrnl4CxCF9vhyFjpxN4Txhhzgs/vMpLW6uIu
	pt97hAP/PUDMeP+Iv6/RnDtH76bEYpjrL8RlYwiXWOMd0MdRSGfEHLFtnyqFBjjC83LIC8ppltG
	B71VCN8o/9vfDXrw97II1QJMGyH64KpZMbd/XB
X-Google-Smtp-Source: AGHT+IGJz11VRz1sfjmWPFz8mNeMCvcfaDXFykddyPCtCU+pWu+/Q9NdBfYxM1g/ugC9fyw0rYLc85ohe36zFlrr8FY=
X-Received: by 2002:a05:6402:1495:b0:5e5:b44c:ec8f with SMTP id
 4fb4d7f45d1cf-5ebb56790d3mr99841a12.3.1742486547119; Thu, 20 Mar 2025
 09:02:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320142022.766201-1-seanjc@google.com> <20250320142022.766201-4-seanjc@google.com>
In-Reply-To: <20250320142022.766201-4-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 20 Mar 2025 09:02:14 -0700
X-Gm-Features: AQ5f1Jr1nc8mqsq0Nwxb3YT8iNSy7LQyzMmmepYP-6qWP026Rw6NHiUdinwtGD8
Message-ID: <CALMp9eRLfpM4Oev_UeaL-Jc25izkgEqaPqeC41MayPRf6m0AZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] KVM: x86: Add a module param to control and
 enumerate device posted IRQs
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 7:31=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add a module param to allow disabling device posted interrupts without
> having to sacrifice all of APICv/AVIC, and to also effectively enumerate
> to userspace whether or not KVM may be utilizing device posted IRQs.
> Disabling device posted interrupts is very desirable for testing, and can
> even be desirable for production environments, e.g. if the host kernel
> wants to interpose on device interrupts.

Are you referring to CONFIG_X86_POSTED_MSI, or something else that
doesn't exist yet?

