Return-Path: <linux-kernel+bounces-426491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F339DF3D5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAED4163007
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098D1AB6C0;
	Sat, 30 Nov 2024 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EMfFjDXc"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BE16C6A1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733010184; cv=none; b=aXxLkFDKsajhNfGbG+yP22oOegEXPkGguwuBHV4oOiaCRRsAww30isWVUYPY8e4xlc1zmsaOOed93TndKg2JNWoXO1a0w4DutdTWWm/sQIblIsvObPOTzGgugPaCjrEeUzNXV9OXvRlOTEir8k9TJEeBezgOscPSjMrpyiArOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733010184; c=relaxed/simple;
	bh=dmyM2X6GDFcDEtkf0EAY6/OynnRgtllGwUKFUh9dCJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CudAMFPBxMF2A/TSSDOHRbUd043BBffBEe228bnhsbPQVPTTxtg4eVvHpXs2ga69PLHrieTn3RSWpCk8raCE9UndfJ0rJ6gPnPYFxf8C91DiurYUw3Po0A1ObmhnVLjnDIe3SOcY3xb/8+9biwtpJhtSh57zzrRN1mOEvBcltT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EMfFjDXc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5500f7a75so479585666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733010180; x=1733614980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dxlhX570UpX/l+v7xOWsI34LvjuvMoCbewUEouqkiZI=;
        b=EMfFjDXcAsRV/LAArEbdvoZBmfH3W79ZiOhgcb7WFmoVPa8Y5D4bc1Az0iE/PktZij
         BJ4sS9RCncJrcHAO6XR4+OTY0d4T+snTIVPSAftQ2yFk+9ZvOcunLv/hXvgkZljoGzfN
         hURgyEk+Km+WEKkFfz11obxqWKm9XLPKJrj+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733010180; x=1733614980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxlhX570UpX/l+v7xOWsI34LvjuvMoCbewUEouqkiZI=;
        b=l5lIhPMyJ29jz3CAcZcX89Z4X/3w9fsI+xOSTgFx7VnKXHmzKc6A+Z2IVGDPv0B2RH
         aoGTh5fmfRBeHF3lgJJpVEiRaIE5TXiUs/9/ZQNVxp4a62lS6FYUXfpYl9Kr7ZupOB9E
         lqpjkSE1McSVkKpF/Dv+oAXuY80G7WfazvTPCULVyKOWXiJqxJgm25SuMgHJkhXVQyPg
         7FOQlFOPtjLnrffSsXR7w5Rht9wpLJnvreLASj+Xa+LQtuZIlnbLwfWtadG5AA7i3iOX
         CSJHsN1BALgP9LBIpEPDkZ3b8B7Zx67aervIdxBUIjG5rasSd0FrBMZPd5bnlxrntsGC
         fZMg==
X-Gm-Message-State: AOJu0Yz7Mp8pBzQhAL2smmhZUYReSPFLrzPvEFoRH3wf2ddkEBIwRk6c
	aKKcl9wf4YOJ1zi8jA+aLk3GAwiOoPiTeJor7KhVoU4boSEsLNTF27Ii4HTFEbZcjr31U474VD5
	usYOlBA==
X-Gm-Gg: ASbGncv0LDxYZ6pGzyX8xWRSoqq9pRWjgtbMP6Jd3oj4+1713YY3TiF/733ga0xEu/v
	nU8mGo7Y7ly6q/BV9nixrIJBGA5qeW+aRw8H4VyGKEOcWAbnjJBJDiYNSU9OeYYrTV8NEeVyN8j
	dWzC7FOYA8mXSwixALdXatzo5RMJerAdJ+CfDmp0uC57YNLEug8323slilGyyDy6btFtO8YCqQ8
	XNgVbY5Qy/KGkia0LP+J94ZXG3+BSiw7kC8xr6/vuDi+LsqC+igLNRYCXgjPdpqVhKR7ZQLxsu7
	JYS9N0au5f+CoTPUOXr0U+1w
X-Google-Smtp-Source: AGHT+IGzD8QnPGSDulZoImiGfgYfL99ijzVxb0YmgTgUoReB016RjL94TuLoNbR/Cith8/L+r9prhA==
X-Received: by 2002:a17:907:cc01:b0:a9a:a891:b43e with SMTP id a640c23a62f3a-aa581081adfmr1307564066b.50.1733010180522;
        Sat, 30 Nov 2024 15:43:00 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59994064fsm327627166b.174.2024.11.30.15.42.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 15:43:00 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa5500f7a75so479583466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:42:59 -0800 (PST)
X-Received: by 2002:a17:907:780d:b0:a9e:43d9:401a with SMTP id
 a640c23a62f3a-aa580f2a8d9mr1569428666b.14.1733010179098; Sat, 30 Nov 2024
 15:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129231841.139239-1-pbonzini@redhat.com> <CAHk-=wjP5pBmMLpGtb=G7wUed5+CXSSAa0vfc-ZKgLHPvDpUqg@mail.gmail.com>
 <c43676a2-8db6-4ff1-b519-3fd3aa290e4b@redhat.com>
In-Reply-To: <c43676a2-8db6-4ff1-b519-3fd3aa290e4b@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2024 15:42:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiJnBGxUd4Bwnxgtzp1sDXO-+eN9mZfUi_3Cki3Y+hXDw@mail.gmail.com>
Message-ID: <CAHk-=wiJnBGxUd4Bwnxgtzp1sDXO-+eN9mZfUi_3Cki3Y+hXDw@mail.gmail.com>
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 6.13
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 15:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 12/1/24 00:11, Linus Torvalds wrote:
> > On Fri, 29 Nov 2024 at 15:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> This was acked on the mailing list by the RISC-V maintainer, see
> >>    https://patchew.org/linux/20240726084931.28924-1-yongxuan.wang@sifive.com/
> >
> > Please don't use random links. Maybe patchew will stay around. Maybe
> > it won't. This is the first I ever see of it.
>
> I'm not surprised. :)  I'm going to launch into a full comparison of
> lore/patchwork/patchew---but the reason why I used patchew this time, is
> that I wanted to make sure that the one that was acked and included was
> the most recent submission for this series

Well, I can see the Ack from Palmer there on

   https://lore.kernel.org/all/20240726084931.28924-1-yongxuan.wang@sifive.com/

in the thread overview - or press "expand" there (either flat or
nested) if you want to see the whole discussion rather than just the
overview..

So it's not like the Ack wasn't visible there right on lore too...

              Linus

