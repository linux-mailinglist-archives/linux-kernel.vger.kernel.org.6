Return-Path: <linux-kernel+bounces-444972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B862C9F0F62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51A8164C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4649C1E1A2D;
	Fri, 13 Dec 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7cm5HXO"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6F1AAC9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100804; cv=none; b=NN7n2Lav3IkstfEIj9caB8mKUDnFf96WNyRiWaSqAFVHtgIbbZx0GL8TNNVmjEyW13vtL7mllkI2UKZaxckEnmbU0KZ+8R3WNmjrDRKUmORN9AitP7ykVP3+9hijeU9jMphxmnSzguWVF0Pp8Q4jQOAVVdbx9yxoXrBXZD3Xs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100804; c=relaxed/simple;
	bh=wBqUYrDGzq8/Ph2W7HoSJKRld+XHMM3JOZ3PqC7C6+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpjzHyRgbpjDToJ/fHAYc/I4gg/b0poqYD8yXS1spttXjhH0ajrL4mvFd5Y0NP0N25xHbppV3vIwdwjMXNLnWNB/ZaRox3oIjcvP7hg8LUEup5o4sl/ewiXcdPph/7RqEvthNGuWXG8KHp1Zjtol2MxFwSUUUpLjcQPVJkQZJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7cm5HXO; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso168805ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734100802; x=1734705602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1o6cXCczlOJrW820tbI3ejXvq3a/VUwUy4HgwjZcug=;
        b=n7cm5HXOII7l0pifckG1G0KO5jIfknmR/vRJSZsnyjND9PnQuX7g6B+lJvUF+4zBxi
         eC6OW3yBky/+tXdDqRhB7ut+kCzqIHo5jXn+gBy5GctznrfFL+SPmiEQD6gk+Rd3EUIJ
         kMvRngSsg2/FfdyOKSo9eVYMmAFT0oDs1fb0kHD3jCBfQUHgjIldEHjYgzLYYSgIWY9R
         WJrockPS/4csYzk3gJFE7330vyEEnmJtod9RPNQJF88qmT8KpeJrg2/KdBX1kt3wdI1g
         T3z4UFxBlbK7ZqVwKiwo1ai+11VGD78rjIrT1mHios6KrDhVDThK0oYq7KTzYVQSYb1q
         Atzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100802; x=1734705602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1o6cXCczlOJrW820tbI3ejXvq3a/VUwUy4HgwjZcug=;
        b=gohCTWWf5WxuDmv3V6zqS0X3UMGfBahHZHRqNe1xqyM0WN4QypmH51EBUYuWhp/7nZ
         T6JvEWjUXQenlPx6ciCSt+MeA7pMREPSL4V11xzRf8c7a0BMPwK2TZZItZF2Usxo0SdH
         1t3MNHu2G9q4DamHoHCtWfWO3++KyVqRPaApAG/lwjtGvw1eJleMk9+Wg4M5zRj+tGdR
         dhwfhwYK2/x4CaQin6GzGebsSLRBI1sBEvonBaBKqqeZf3hbsnQUP7OoGytm8iJWyrcb
         7/lAPNgNklbQTZI1l1zvIVX2VzpWMS1u9IovHC3tx3YTB8kujp7Gz1s+HSLqAxkPC5B5
         YcPg==
X-Forwarded-Encrypted: i=1; AJvYcCWuQuHNL7Ri5s/9xkxnYRy8gIQhGOorLsGb3g9Q1elm+ce7Y1nHJS73AG1YxAQ/orB4LeHeHieZNzSp2Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu/iZQYHQXioVjJCvTjegviZa6bAAEkFZdasVx9UEVLRZQ5K/u
	jmsHcFY0S2IMui/MH0ERVqFPHcPy9LiR2OQAf6XNY1kP6fEvcGkAmxP+SzRnopHSWGgueb2P3YN
	4YXZ2xTz6lOlrMXr2zejnj7DpLhMV0FtovY/bxVHsUiYSvKPQGO+1
X-Gm-Gg: ASbGncs9zILJ/Q6fTF0PqRTC/2Oq6tAlD6KNUrXbrN8OH/z9vBhCpnJvnzyfZpDbsL3
	e7cc+UWX/NS4bfgjjeSFs1V0Smy4qDxsUrQWb
X-Google-Smtp-Source: AGHT+IG9Da28jDo3gMfdHEXumlT9aNakfaU2EFaMPQ/m5hhfUBa5umXHfjGD94SKFdUR9uWgqT27M8DdZa0v4Faq+Cc=
X-Received: by 2002:a92:912:0:b0:3a7:deca:1fe6 with SMTP id
 e9e14a558f8ab-3b0287e813cmr2140715ab.13.1734100802321; Fri, 13 Dec 2024
 06:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211013302.1347853-1-seanjc@google.com> <20241211013302.1347853-4-seanjc@google.com>
In-Reply-To: <20241211013302.1347853-4-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 13 Dec 2024 06:39:51 -0800
Message-ID: <CALMp9eQjGXrCpuwqYc5sddrTNWRO+gA-P0jONtzfb8W-E2STBw@mail.gmail.com>
Subject: Re: [PATCH 3/5] KVM: x86: Apply TSX_CTRL_CPUID_CLEAR if and only if
 the vCPU has RTM or HLE
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:33=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> When emulating CPUID, retrieve MSR_IA32_TSX_CTRL.TSX_CTRL_CPUID_CLEAR if
> and only if RTM and/or HLE feature bits need to be cleared.  Getting the
> MSR value is unnecessary if neither bit is set, and avoiding the lookup
> saves ~80 cycles for vCPUs without RTM or HLE.
>
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

I'm not sure why you cc'd me :), but...

Reviewed-by: Jim Mattson <jmattson@google.com>

