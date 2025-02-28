Return-Path: <linux-kernel+bounces-539008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8DA49FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE41E1890227
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1864127002E;
	Fri, 28 Feb 2025 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fjm9BZTj"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77F1EF38C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762397; cv=none; b=Y34JI7IJw5CDyvliCel2WCUEH5A+GEXubI75M2Fz4Om5GshDq5T8zmTniQo9RsC+XMPZjpOs519g0TSBh7+doB0HBi6Gty0aS+XYOf9bFZSxyD/Kq+KzGYnqI1LSkqHI0hhj/tC68C5BARdA5Wy+UFyD5tadu0mQr2BqfqrihIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762397; c=relaxed/simple;
	bh=ZNlUa3CeezWnmzy7Kq8Of/zcrmreAtTixe78APIx1Wk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SFMcuzPr1ZPnqet6DvhgGezjsRo/9vgfF7nBuT/K6ZPv8xCMZyk2mLSq/HmtY9JLU9+MMN1lKDelWHJhF7H9HSaEaW6mQQpwoJsqftgPqWyXjUkR6fYtfB1jjUcgVgX7t3y2LwIkxNlwu5crPlukz9sBlULbGw8z5n9H2BVEbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fjm9BZTj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22367f4e9b9so22555195ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740762395; x=1741367195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWP6D9WOs+e2iJqyvW8XyE8+noGjj4tp3X4+/PvTMxU=;
        b=Fjm9BZTjoKL4MWjNfTKCpPATlu1Y1ri/xaIHV4MwJdVDy3a4/cUcGi+RC6DLFeQLVT
         tPfCDbvgX01C5eRsrooK1IIUIi3z/Y7jUH6eBTGgQvoCI6mEqvotGd1XCxaRTe6iZ+LN
         hyopbZ/afXP/uClLyqJbZwflNiKD2mPjTM8ZP6FzWT5ZGT3LzGjeHqo/Zpmye+IpmmvM
         Jwdcuswg9GjYK/+d7Lwf0bLQdajQanM29W6vqxrJCA8+V+UmaN3WATs8FJ7oj4SB75Vz
         P3c60XqHOFmT4bVEgQ0vLPeOWRI+dn6PeAZ6c5n66r/wP59HlLN6u9RjSjIUhjQmUJJZ
         9cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762395; x=1741367195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWP6D9WOs+e2iJqyvW8XyE8+noGjj4tp3X4+/PvTMxU=;
        b=D2wfBnRRSgw3zFS6wpoGkw6ovg8sm7gZvfRVoRwJTYqo07coW52iiQxfSD2xBFuyzm
         bnk8Vz56ObequkedgJRstCizdY4qcEondQou2r3CguhDOCs4Rr8wtVOaVY3BVcku6sip
         k31PsskBv9GcCygUmqM6ZW/ShKc+9qj2m8biZWGpDayi1xsmxqt59SRBir3QuzK85b/n
         Q5w6O9OQ8JcgyTU5Hy5LqRNImQO5LKKIKkNqYKlHMd0svVVlcKi6+6SbeyWNszB7y+xx
         tbN+7nGm3pwWqgOqhfdcsSlnOH4c5IetVkQe2eqMfoDPdu2Wthwi0xmX08OA3Zu1R8ts
         xyNg==
X-Forwarded-Encrypted: i=1; AJvYcCWuzCR0pPBXUImOUYqM9HlQUYUJqGhRU7l4UiOctLZWiY25iIeB+hIgMHTHbJaXKYGgN33a8JTPWSXJZCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwGU1gTAhQTjP3sc3Mzu2hfwVD4XlaQ5IC0HEYP0QlZs1qoMP
	ExglP5kiUTWc9daGUuW1aMd5ea7WFtrY/fFkpjA2oL6KxpbkARu6prL7oOZR6nzkWhE/hanXa5F
	s/Q==
X-Google-Smtp-Source: AGHT+IEYtxFcEUEnDqSTHAQVrblyfI2oNMubjRZ5e9W9yNRmL4/qhO+F7kELzTtOhO+SWy8SdhbFQmfwcOA=
X-Received: from plfz10.prod.google.com ([2002:a17:902:d54a:b0:223:551e:911c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:17cf:b0:215:89a0:416f
 with SMTP id d9443c01a7336-22368fc97c4mr58635635ad.30.1740762395319; Fri, 28
 Feb 2025 09:06:35 -0800 (PST)
Date: Fri, 28 Feb 2025 09:06:24 -0800
In-Reply-To: <20250215010609.1199982-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215010609.1199982-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174050797060.2702095.3801136360929410599.b4-ty@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Fix and a cleanup for async #PFs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 14 Feb 2025 17:06:07 -0800, Sean Christopherson wrote:
> Fix an issue with async #PF and protected guests (which really shouldn't be
> using PV asyng #PFs), and clean up naming related to SEND_ALWAYS.
> 
> Sean Christopherson (2):
>   KVM: x86: Don't inject PV async #PF if SEND_ALWAYS=0 and guest state
>     is protected
>   KVM: x86: Rename and invert async #PF's send_user_only flag to
>     send_always
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/2] KVM: x86: Don't inject PV async #PF if SEND_ALWAYS=0 and guest state is protected
      https://github.com/kvm-x86/linux/commit/b9595d1ddef8
[2/2] KVM: x86: Rename and invert async #PF's send_user_only flag to send_always
      https://github.com/kvm-x86/linux/commit/4fa0efb43a78

--
https://github.com/kvm-x86/linux/tree/next

