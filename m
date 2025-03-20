Return-Path: <linux-kernel+bounces-570125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D87A6AC86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2D94873C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB322652E;
	Thu, 20 Mar 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byNzrn0C"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2ED2628C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493274; cv=none; b=jkvhqUTzDLK45n5xmNhFMpugE7+a2SkbMnnjlxl9bSJByiJD5OAHrTE75pztiHjDAeVA00c/+Nmwz7FBUK006yTgjjyuuSXem3B0JWq6P8o/bmFmCv/Lwz7vackPflmXivNlLTR1bzN3U4OxcrHWqTJ/Q2gVBSrqRjjqwhQ5Tlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493274; c=relaxed/simple;
	bh=ycFdkzxtakEGnyZBK6i8pj/Lu02w+pmZ7EzHe02D5xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QsYRWE753CXUcIK80e47qVaHY0dNkym/3xrEm4aS+JAmiaLcG23JmQWBbETEx1rH3RH2PH38f914tKElJ+KzrW2QTgzP2v/qQl3F+62mse+LnfHsl++jQcgZbOjqISZRXaIyx74QI1AEjqO3tkj0Y13uxYLQaRuwP5immqtrESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byNzrn0C; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso3347775a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742493272; x=1743098072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycFdkzxtakEGnyZBK6i8pj/Lu02w+pmZ7EzHe02D5xc=;
        b=byNzrn0C0Y0qyQo0EnNH+e6auz+bGIHY/LvyABC+B9lv7PpUs2ZnYF5bURd1HLGVPL
         D2koSM2W53Qhptd4w4/yQdTjajqjIVEj8JThsuX+sa8Slu8C19n2nMDdAd8oRX+sNbHN
         sf2Hw7Th6WrNjSQZZUfdklGknc8G01yb4SirDj41lKBRIZz9Cn4UK13JsBqPvIoHj8L2
         wFX6lV6FTT/fwk2VNC+nupkBsgoMCsbgeJcTFHdJGmEJDKFHnXt3rW7EmmYPxlAXigqj
         IHCwNR8E5m6f3rJXNj/9KUCNrlTDObmUlj4BSbGvO9s3OJwDlXc7DpxcSXAiaDfIla9c
         u7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742493272; x=1743098072;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ycFdkzxtakEGnyZBK6i8pj/Lu02w+pmZ7EzHe02D5xc=;
        b=lvEdnXVViG21SIxjdO9g0k0ll3V2ZVn0nJ/H8T7bhHLzVgaoB3C8vyDbIGIPBc3HWf
         nt6MMI0+s5wogYIF27LfeQGKRqbhSkc2ls7LAv5AY8SxhuQDvCIdTKNZ6uCW3+VMSAgJ
         52sBnJ4hyDXYlwXiCQkvGYM9EenEeGn1+yaxBu3N544alj1GXQQ9X7EC6ebHP6hCcVjQ
         zCnRB4EPlhnpd1ouneAGHN06iVVFdFIkenBmcVXI/Bz+leiF7QP0KuL62Ah3sArvXEIM
         svNFcteIewc367yvuMSjYCB4Ys9Hx6L8mz3gZAScXeANXj7fwO8nAi/fdtZ+heMQPepq
         PWAw==
X-Forwarded-Encrypted: i=1; AJvYcCVNXGxvQ4c29IcFYh4Tai8ZdTRjV7i8CyFaVVBXZ4Vri5EE950cSLaYxPf6sDbr4nFAqL7xQBkqFpxIDvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4wj7xz54tIsdXnw9tAeWvgt5P5x+PNns4C/GF8j/mewN+P4B
	KOQcZWhF/IpA4ccC+rdLF+0Hla2SPsgTas6vHJVeOgzKEgvWp5klWSJ3LcZu1wfYdh/vect+M34
	++A==
X-Google-Smtp-Source: AGHT+IGDSdE1ytyBoBFw7qVwuVm3wbv2xNCX9zlmSDFB9e6T2jpMlLpSaA4AhKeFzgmz0ROgTRp2/3598EM=
X-Received: from pjbpd14.prod.google.com ([2002:a17:90b:1dce:b0:2fa:e9b:33b7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3844:b0:2ff:53d6:2b82
 with SMTP id 98e67ed59e1d1-301d43a2db5mr6626003a91.11.1742493271988; Thu, 20
 Mar 2025 10:54:31 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:54:30 -0700
In-Reply-To: <CALMp9eRLfpM4Oev_UeaL-Jc25izkgEqaPqeC41MayPRf6m0AZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250320142022.766201-1-seanjc@google.com> <20250320142022.766201-4-seanjc@google.com>
 <CALMp9eRLfpM4Oev_UeaL-Jc25izkgEqaPqeC41MayPRf6m0AZw@mail.gmail.com>
Message-ID: <Z9xWVkDx6hnpFw5Z@google.com>
Subject: Re: [PATCH v2 3/3] KVM: x86: Add a module param to control and
 enumerate device posted IRQs
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025, Jim Mattson wrote:
> On Thu, Mar 20, 2025 at 7:31=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Add a module param to allow disabling device posted interrupts without
> > having to sacrifice all of APICv/AVIC, and to also effectively enumerat=
e
> > to userspace whether or not KVM may be utilizing device posted IRQs.
> > Disabling device posted interrupts is very desirable for testing, and c=
an
> > even be desirable for production environments, e.g. if the host kernel
> > wants to interpose on device interrupts.
>=20
> Are you referring to CONFIG_X86_POSTED_MSI, or something else that
> doesn't exist yet?

Yeah, that, and/or out-of-tree hackery to do similar coalescing (or ratelim=
iting).

