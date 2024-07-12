Return-Path: <linux-kernel+bounces-251238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC76930286
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688291C21102
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85BE132811;
	Fri, 12 Jul 2024 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Okj4PtaD"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7038DD9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828626; cv=none; b=PloSmajnVTJK9yhYdnoNVa2dX0Xg+iYbdKX8qiG9S3y7JcNYy/cw9gA/Ku8UCxlQf+6SlLnSh6XWzaTX8M/7nRBIM+bvAyg+1eTwSTe4FfMhuvgvRqnd1BdNpuVb43QP8niGYGcFAhZgeXFOn/0XyAFAWMumqKgJP2AGautYlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828626; c=relaxed/simple;
	bh=v5MFUcY2KTqANwH586uLxyoUInEK6dGefZwvJWBcGP8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eiDVwOJodG3mH7pjkBZomA6cG15Am8zwjtHzDwBIRav3Or0lsZNSr404PVhdmCZT3KarsBYxT+Stz+QEdvUmDm6ADYq61X8YoO+GtGCoiQAML3bsdLBLKCb9file2Xiz50X4wGi8uajhrt6C+kHfm/dGD0v7L8+KH8XA/HrEJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Okj4PtaD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso1859504a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720828624; x=1721433424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze3wACVXpWLgwdUW1sUj3dn7jbqIRwBSX0Q8OyWjcao=;
        b=Okj4PtaDidIX0lqRxSfffJ8TOvJOL0ZOp6pO2kXH+3UyXqxOjhHInqaSlIAqUlc6Ny
         ZH+3h9Q5hdceOYUEBB0sM4pt0Grhdbx4KeOGZOORu9vVdc3I49Th8ienoWtcQy+VxkZB
         Lv0WNcj/n9i8JUJCXs4pElXcI8YSB2bd53hqqYBFUkY6kQYM65mbXBFm4siuxwf3FRjw
         Y8b0ShaXZHV4ZsImSusUnAxvVPKZrdi037BajjxgOyYnnyk6sKEfcjD1VS7vhSoPEWo2
         VoRFLllQTF5GMwl3/VTWSFWYZKZuFbYq4Wk80eXOMVx97j67yAyZOXoLtCDtWW+xQBBx
         r7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828624; x=1721433424;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ze3wACVXpWLgwdUW1sUj3dn7jbqIRwBSX0Q8OyWjcao=;
        b=RLuSFRJXYdZFk/c/XG/OgEHHlg/F4UpmpRUr1rOuRIMYIN3om0KZ/J48tPrdsX8XE0
         F8ZJyZjCLmp6xq2XgXIrxKjQWxwMJv7VuCIBJHlTQAWfPAiAvEzjkegTsuAXufDuG0uK
         2uBVqzAiudQloTixs+q3a93ogsJTtlSr/H8eeKbBgllTlpoE8T8puoQU2IBKQPvOE38P
         F0TVYyklAZ8vwLrK08rPR+yBBJlPz7Sl4/Yis2cCrAHZUUDhWnL8KXIIfJ07Gx8l6GKo
         OWc+zLplwf/MoFIqk3jZJ8yv+ZLJAypcFaYR32WO3jyv7KKsLSwx48e9a2QFJN7tKACv
         r1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8IgrjKdxwmEm+nvaJHCiWPGyj8cyui2rYbxIrtlWQLHLab81QfjR6i6VFc42rCDtxYj9/cBjjPRgQoSZ9Uyog9mcp3kcJoF2mDI6n
X-Gm-Message-State: AOJu0YwWG6YIXogWgS17uu2JMZ4odb8PKf3vOO74WrGo9tgyfnVbIedG
	p719lOqlKOAmHqRTXOr/89XRGp1QdluMGV5fm2qgPLfBM6c9tb2AU+wpHI0B4ISRgiX8fPaz0tC
	0bA==
X-Google-Smtp-Source: AGHT+IGuOjZyfAICM5hPYltKwK8MUxEufx6QRd2bStK4KRbVp9LndHSZuW7wfQXLiJscub/n62KMNN+4NeU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:5215:b0:2c8:632:7efe with SMTP id
 98e67ed59e1d1-2cac53aceddmr45484a91.4.1720828624214; Fri, 12 Jul 2024
 16:57:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jul 2024 16:56:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240712235701.1458888-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 pull requests for 6.11
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

There's a trivial conflict between "misc" and "vmx" in kvm-x86-ops.h, they
both delete ops that happen to be _right_ next to each other.  Otherwise, should
apply cleanly.

