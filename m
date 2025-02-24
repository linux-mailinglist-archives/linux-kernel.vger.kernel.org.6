Return-Path: <linux-kernel+bounces-529675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E8A429C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3B01892865
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A361B264A82;
	Mon, 24 Feb 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTKIQkxY"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6DE2641F6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418157; cv=none; b=kLZo6ILfmLNn9KyhRZL72o2G4lG/b4qddecpPx/6P+hKv0q5reg13psQWUQwMGA+2lZtc/vSant2Y9Cbw5b/iKXbgWyvoiYHCo4FAp5UuQ/ibcop1xEuUWGagm6SR638sWY3loyuk+H/2zNmqFsI7zdhbYGQbSadhC04nmman6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418157; c=relaxed/simple;
	bh=xx1QeYum9F0g4R1uQ44LWKRmPki5YkeJN99+/cp6RXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r79mrAYbhbh7UlddeieuOuDlC3qC8AA1hK2mrTNCi1huXoeKQdTQs0eauiGuyix6JM5wWacEchfDesaUUYnHTndv/N1Gz2Qsh85RmtuC2sZVrLdLarmgOrNw68x50TjSh0o9ZGruJG+PAkvpAYlhh1G/zR6QdshJlN3+eiOXpf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTKIQkxY; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e08001cff4so14449a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740418154; x=1741022954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx1QeYum9F0g4R1uQ44LWKRmPki5YkeJN99+/cp6RXo=;
        b=LTKIQkxYv3j/YmeuLJ+fmpEFgx3BZPQNTW8VGvac+6zuUmS1OwUa7VU0NJbI9XuREE
         RKEWJavITT9A4stZ3bstUDCwAPe6wln1Wa9GLil6nxQk9E6msk0gXAKXYA/L34B738W2
         8K6MWVNoud3khBH2/faXqeZJa6Ys+XrLRX28r+WvBy0l3BLKzvEmZ06m9qFfHsa3+lJS
         Z22xe2ZXCt7xmolLjawqh4zRkdQzxjcwVmQm7pHXCt56z53Tk1Z7+ZmIsHFtD7+MA2MG
         XWR3dacp5FSrJNCof3bmX6obzkDq7LKOD5qw5IqgbC4H7C2xKZs/+U+AciXmUmGr7AMS
         0NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740418154; x=1741022954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xx1QeYum9F0g4R1uQ44LWKRmPki5YkeJN99+/cp6RXo=;
        b=TqkgvICHgIswBv0FBFZN9Q4oYASpIr8adqcCNMFnu5c1MNGu2Sekyt7K783qMKG9WG
         121vx4JtKeNJJ4dASLTWovr20qjZv3X1b1kkv6It3bfQAqi0/18A/vXDeC5FDysG6RLY
         8f28MQ4xXU2MDA9QFCpmo7k9Yuy979sByRX9BQa8t871loBrt0E7nLd1uM5pEgdXW4D2
         nJh9JfjPPmnZ6v3mmqoAufJUyQe5tO7pCK70BhqRmjZikFeFnTv2a6WrsQ6kokA4SMCp
         jILgGvU0gP+A10XSoZyvMWWbMgOU89aTjlChiQ6g8w/QeGhZDn6jep/UZYY6uXl/Q3lk
         B9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCX7dQKqWoebqz//2RZUcjH0rAUSAy03to0xxvWdz+ephL/lt5uAqgg/tY/nw35fYVoVZjk28C/Z2w4GMIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrRcu0a9wCgI5Zty2HihKSgQr2EFeOaQ4U1b8EAFZvcMCyeRx8
	xGfvgAlEkg4Z2ltLTNL0n1KFg3KDuqz874HTVXUUhVbtetz965JYILe4YIsDZTdotGPlQMrsEiM
	qVJYOkA24rp9bJpAIxoc4zdskm5hx7jLK2iymDBMHMAnw4nyFKA==
X-Gm-Gg: ASbGncs7ngYjAEgLv779i8X103HbLU/wz6DDfP4+zg6Vf7YrxjDI60K0j4HT5JRGoPo
	6gp2IVb5KRNEpIPKteVMyz3xq8pTCerl7mKZ8Mk4uC8FlsI4BNijraW7qWOVmEFaNmWr2+t6lnz
	2BtBAPdT8=
X-Google-Smtp-Source: AGHT+IF33Bz0K5wTdY9n2hwU2nzRuWmxmxvKbeT5PUpV0suDtFxp2gRSePT6D7x7AVWBorWFCnCBILpKjJQOBzBvGy0=
X-Received: by 2002:a05:6402:2062:b0:5e0:ed25:d28 with SMTP id
 4fb4d7f45d1cf-5e400125716mr2002a12.1.1740418153635; Mon, 24 Feb 2025 09:29:13
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224165442.2338294-1-seanjc@google.com> <20250224165442.2338294-3-seanjc@google.com>
In-Reply-To: <20250224165442.2338294-3-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 24 Feb 2025 09:29:00 -0800
X-Gm-Features: AWEUYZkxSRz7bozwI6B1PTS5d-j--Hld6kcW4FN3FHQP5MxWfJFlCRft8xOA5s8
Message-ID: <CALMp9eRrZ3vMbiJRLU3wrpGaVbBOuYh8QkxazZKxXvDrnxVkUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: Assert that STI blocking isn't set
 after event injection
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 8:56=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add an L1 (guest) assert to the nested exceptions test to verify that KVM
> doesn't put VMRUN in an STI shadow (AMD CPUs bleed the shadow into the
> guest's int_state if a #VMEXIT occurs before VMRUN fully completes).
>
> Add a similar assert to the VMX side as well, because why not.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Jim Mattson <jmattson@google.com>

