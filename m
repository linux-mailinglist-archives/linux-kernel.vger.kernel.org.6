Return-Path: <linux-kernel+bounces-179393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73988C5FA7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788AF1F22BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961238DCD;
	Wed, 15 May 2024 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IMNZHljO"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D922207A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746498; cv=none; b=VmSGaxrPRpdO/hScYvl6Bp5yG/z7443YF+74G/Rz0dx4mRXrdEjsU3hxeRVQoVJjONVhG19oMpscnTcVZ5eO+CaoCsI+w6gXxiRWXquxsnY+/xjy6bUNBTDIZJkz4OWT3b+W3QMV9srQLesY1rLEldwLIqF3zJ26iCKnagxLAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746498; c=relaxed/simple;
	bh=XhCwhjcGydXDxiHtSK4BdYzcSeAyPu3k1yt7vJg0K8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAOuxDUr0OSw+YLTJQ5wVqmfygwP1Yoxnd2Vw0snZxA6Qhk+R8ll9HNu1q5yi/cSgBonjUj5RsnU6JYtq1CDxrFNcTx6NDtNBakQz42NqMUMdE4lKo1URawy5WEzd2krDeTXvs/saL4golvDLCnDzrKCtc15eUXH3jXkuxemBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IMNZHljO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572669fd9f9so1218412a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715746494; x=1716351294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r4cKs65r0Vn5NjWdK37SwLqUt+S38IkvifOxEI5Gn60=;
        b=IMNZHljOQnPCIgeLH81xvKh2GckkbVFrJhwzoPYESiOip4cGd3J6aB9qX5SAa+PupY
         PHfF+hUlR4rb6gFjcgS8lbnt0DyQLv/4vgNE6vmFK0vWUy2BPu808d7dQGeXhzEy8GCm
         0sw/o9bicTAu3BkdNbfBM1GfUhBfhgdYD3Eck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715746494; x=1716351294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4cKs65r0Vn5NjWdK37SwLqUt+S38IkvifOxEI5Gn60=;
        b=kNRwtrT2QX1wbXypIW1njUaGeOwCA6cSk53cqer+aoVDiJ3nwbSP1qZzcQ6a4TrKu8
         /E8Pjpex1wZ39FreewEkJm4Gny9k5/rcLVlDxvz/BdiZPmj1eMEZgSwGjlW18aPG86Uy
         OtHn1iQRigRZL/SMjZ3yfKPZMP6dqSERXpEfC77gEI92OiayfnYE2KHE4L/lr1olGnoJ
         2lMyBii0JDprvGaXU4DCrSjwR+/BcbPiG5WRuw2vtZ5xjzHuosQo73UG3OdnckcqBkdl
         CGPeIYJ5r/vqOgY6mTRuoxY78IeVcfPJpsftaHpga8igpwHPfRNGEgrHnKTau64IZbMy
         Xp3A==
X-Forwarded-Encrypted: i=1; AJvYcCXWdjZxvRjiEPkDfRy7WdCt3W6MGaqcq2er+XgQ3uLlola7PXw+PXR//+NGrugxbcU6daHtPV0m02z8GA8IgLucqgYcpgHYgTzOuxSt
X-Gm-Message-State: AOJu0YwUdh/ezd4h+QGILvNQMZ2DRW8sjwo+Rjl6qNyQ9AtPjiZESME4
	hMK0f0KmPLnAkiiZjDdr9oZSFEinldvvqDHJx3zFH0PlD3zvZXEBCnMPR8PeUgiLX0NmX+L7M+U
	fvpGskQ==
X-Google-Smtp-Source: AGHT+IFk4trkVKr1NeMtZpl2o2Lt9myuC5/0mLzTFw6BZBfY/ZpgUzieeyCp8tEPLD9pgxTQcdRhxA==
X-Received: by 2002:a50:d74e:0:b0:56e:2b31:b111 with SMTP id 4fb4d7f45d1cf-5734d5be7camr8388113a12.7.1715746494513;
        Tue, 14 May 2024 21:14:54 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfc2fsm8343645a12.39.2024.05.14.21.14.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 21:14:54 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a0e4b773so123478066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:14:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXs1QqmabbdBC5NPgR8zIR1OE27+YgSaDTfmye2NSCCvQi5kgw53/a7c3fYvVIXo6lJh5AmOPlObi7I7RJZIgoO80XtkP7ETb9zMBh
X-Received: by 2002:a17:906:dac3:b0:a59:b6a8:4d74 with SMTP id
 a640c23a62f3a-a5a2d3bebeemr1157374666b.0.1715746493951; Tue, 14 May 2024
 21:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
 <92453.1715730450@cvs.openbsd.org> <20240515025811.GA1232@1wt.eu> <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
In-Reply-To: <CAHk-=wiW4V5HRQ5Jm_MnSMVTeivS_4kdm1dnc08d03UKzmyp+A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 21:14:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_GHCwCiC-ZR=idjNEb0xZq20=fQnQxnjGkiq-ba5DLg@mail.gmail.com>
Message-ID: <CAHk-=wh_GHCwCiC-ZR=idjNEb0xZq20=fQnQxnjGkiq-ba5DLg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Willy Tarreau <w@1wt.eu>
Cc: Theo de Raadt <deraadt@openbsd.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, jeffxu@chromium.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 20:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Guys, if you let untrusted code execute random system calls, the whole
> "look, now unmap() acts oddly" IS THE LEAST OF YOUR ISSUES.

Side note: it doesn't even help to make things "atomic". munmap() acts
oddly whether it fals completely or whether it fails partially, and if
the user doesn't check the result, neither case is great.

If you want to have some "hardened mseal()", you make any attempt to
change a mseal'ed memory area be a fatal error. The whole "atomic or
not" is a complete red herring.

I'd certainly be ok with that. If the point of mseal is "you can't
change this mapping", then anybody who tries to change it is obviously
untrustworthy, and killing the whole thing sounds perfectly sane to
me.

Maybe that's a first valid use-case for the flags argument.

            Linus

