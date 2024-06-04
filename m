Return-Path: <linux-kernel+bounces-201548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA448FBFDC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47C0B25561
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6C14E2F4;
	Tue,  4 Jun 2024 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lk3kajkG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09E14D43E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717543824; cv=none; b=R2u17GhAy9x0JFlASERTBcyF3jOMrK8+rgAf3xHYKZo+JUKuhldrvC6P0BAUAkRyJGu0BMOXnz+bl2ctAujG91Nxk7rcr8eDd0QZis+uuI9LD+nyV0za0McrcjoDlgbUztlTAFN3Z+MHMapX+i2POEPhMgw/eIxh/CMTFD3+u/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717543824; c=relaxed/simple;
	bh=VjJmX34+aTYJ+9HTQ5vgX8U5z0y5Ts+H20MVJUkGYKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bRCpGgcekLmDPjblCcwR2haYmR+EMxVghFZ8lAHllB9sV0QZw6sHuAqiB6kW+umJtV544H7ciUESgSRs+38XipQf43L8amH4/YixmOC/5kjP+yYTYW9qaQFGBHZgtOq0ft3auEDQjAXHvC34oh1HAWWDWJ/GBkPlyWzgifWv/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lk3kajkG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627e6fe0303so105699537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717543822; x=1718148622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfypw/c+5RO0tQuEOThBLk/AkkGlXduiTmVxQ/7nnIE=;
        b=Lk3kajkGkq1zw9xtCwUl23BM+hsOIduU1mq7Gx46PfXj7807AVrc7pn2mUAP6PVqS7
         HR9ke88QLMjLGm8KoE7v5CxDZnlZzNn5a+7BldiFBgIuSPb+VJRaAbeLrOsqmDS0UgOr
         y+J/U9NfIMXE4H20FlppvOPEUlBmAgF3FNyFhKWKy+twE9Z6SkovGq1D1VO9+m9c44ux
         9hWQJLdcv0FWAdVmes4cpe50hYrSkdSeMoQFCJqqa76asb/2K+rd5kBb8lEa1YrJvsfV
         rfT0bIJ7KN+A2AQpsOwqFB/SDVXEpvGgW8gL2s7vd3BllJCRFPyA1Ft7MKUmeoUgPQzi
         khGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717543822; x=1718148622;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xfypw/c+5RO0tQuEOThBLk/AkkGlXduiTmVxQ/7nnIE=;
        b=eYKImIxtjGOe+3IJ2/l6s8Wzz3am4irTNXMoZlT14zQYjjhNu3IuIyVSz5f9pdYfgz
         lUDVBZ85B84orFIGU6ocselo3xSqE7GszT9WWaaYvTa+fXGicK5fgZYg8SQYpD9umr0k
         Ar48QoPrtTo4SkdslXl0QcicMNfehXQFiVMVG1CsueXSFXiR5FohhTPkojAwAc2BhVrV
         TkeNpmTq47Hv8inZGPrBv4PgbiPiTZmtYEA7BLf5i24AnJAZKX61zcFzgTlofT+RU2lM
         J88ES8vgntHs2QNRTmqmiihzY5Tej9GokJt4Q0IF7BWxLPr9Xkq2T4gosYgeEfxwYnDF
         sk/w==
X-Forwarded-Encrypted: i=1; AJvYcCVhcxiGUYq3nwvayuBUMPng2QZDr57X2KpDYiLNE5P5fj/ZDesK4roBU6W5AYycY3ztaXpLq1dgy702LP2IAxo0OZkMLX3xkJeFqOAN
X-Gm-Message-State: AOJu0YyWUT08sgNnfOka4w5+OB9IrgovelUEAMQ38ZJsiBBkY2tEyT5x
	PaVU3ZONOt8ngZ5Ru+ir54e3lK5iHTQLyoh1SpUlQelUddu7XrAdx+RITVa0QXOejxCEsHJubFR
	6fw==
X-Google-Smtp-Source: AGHT+IGYHhwobD17I6BcNx47OLoZruHxw9mWITV1BFNUGFWtzbkWqhjasbu6vT69tB03IJERpEy9c90wwX4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6486:b0:622:c964:a590 with SMTP id
 00721157ae682-62cbb4ba98emr1679267b3.1.1717543822427; Tue, 04 Jun 2024
 16:30:22 -0700 (PDT)
Date: Tue,  4 Jun 2024 16:29:25 -0700
In-Reply-To: <20240424105616.29596-1-clopez@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231116133628.5976-1-clopez@suse.de> <20240424105616.29596-1-clopez@suse.de>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <171754327022.2778929.14475719898493728460.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: X86: improve documentation for KVM_CAP_X86_BUS_LOCK_EXIT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, "=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 12:56:18 +0200, Carlos L=C3=B3pez wrote:
> Improve the description for the KVM_CAP_X86_BUS_LOCK_EXIT capability,
> fixing a few typos, grammarm and clarifying the purpose of the ioctl.
>=20
>=20

Applied to kvm-x86 generic, thanks!

[1/1] KVM: X86: improve documentation for KVM_CAP_X86_BUS_LOCK_EXIT
      https://github.com/kvm-x86/linux/commit/d3f673c86c5b

--
https://github.com/kvm-x86/linux/tree/next

