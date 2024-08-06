Return-Path: <linux-kernel+bounces-276709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12AD94974F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247C21C2145A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9EE78C8B;
	Tue,  6 Aug 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O1H5dHE2"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAC4376E6
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722967866; cv=none; b=CVxwn8J68pbF0W4Mq8D1XRkZn4zyUsqvG+PASA5n1d1OrwbgPocS5oV+cyGXGX5wVItbXQ4o9EmA0jxaLZtQFxSFkkvAM8MsuVaEGtaA5mZDUfE8jykfU2fD2zyFGJJx8GZWiPDLz2CA5XGyXhtRs74koxJEwibQhpiy1pWZ7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722967866; c=relaxed/simple;
	bh=H5SrFdrgWUh0CfU2ztfRl3qbrBobD8/W94oZg7JsQEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4S57vERqdJI0Y0cGSXy/XMOpSeggBu9FFcd63A5a3zmJ0fqyFeqZ5US8rXTfX4EJW19Q7b424WFuRiPd+RLU739ZhNbijP5zpFC9AebOKbDIZ+vSEyPuplTMZ4SXv3rVtEtPnH3/0Zb3DpXiUaof3WgP/iIBkJdJEVwo2VKx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O1H5dHE2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aac70e30dso102217866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722967859; x=1723572659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gQV22+e27DSUSOzd/K4ZClyu1XBGYY55bOvIhuKRW5Q=;
        b=O1H5dHE2MDNlTGmr+hE2zuMu5YAlvu6tzjLwbRCRISTVXemRbCSxugFrlT6NUWe1ws
         qe3OYemU3aboniCCKK9MuuGzsg6MW2oDPMU5hL+1Qv0MOvycMggJ78Vq+XyHr+Gk+a6O
         lTKm/cf14u36qxGGcqe7OrpMWDXAavO1rkGFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722967859; x=1723572659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQV22+e27DSUSOzd/K4ZClyu1XBGYY55bOvIhuKRW5Q=;
        b=Ks/I/RCM7rNxyz6EJjhISSsX0Uv3TKjor8HCpIc650v53p8Koa2X5+B8MK7v+7NBsn
         XEeGT6128s6Cf4209zm9m/TrVOvcNr15zaBtTlwPZ3Bysz2Fy5q42jc2WQ6afMCy+8Br
         z/9k9kN5FVnpd/VcBL5/VbPy4mt3xT1f4OtSBdeImRCbg2LX+ozcL7gW4s2AmP9jgc7W
         AyF6WBtxHPvEkwBB+xS6V9OjGDive+YYBgnS4JoTa1JKMtarSBP+CJtfnTIIej7c1Oue
         RLkWKW+EpenNORleUHak62+i373/tviW831uv74F8WGIKnssgRwUfm8zzV+BKwLQbzxd
         Hmpw==
X-Forwarded-Encrypted: i=1; AJvYcCVq7snkq0cGQmRuEEBLTy68A9uAfyoQzQnZUZWiOYpqWD366eO1JAHeuxG0Ge2Bmvd5dvvdovhayC5WG7up1P8km0JSEnp/dszUnInP
X-Gm-Message-State: AOJu0Yx66eh5FEKrNHMdDSO/xjk/dzW3V9pnLOD5S/y9RncaM9ApobYI
	rWuPtwqJTCpfqYhu31gKCm01yb1KXfv5F8+Yn3qyxStFbq4dXTO2Wo1Lm43EAk5tkyGeIkI7mhP
	NtlHjbw==
X-Google-Smtp-Source: AGHT+IEgMQqU8yB4+ihGWYktBnmXmOHi/mfbAviYIuDns4HCwIufNhUdSPWng2Em3mKomwqY7TqBbg==
X-Received: by 2002:a17:907:36c4:b0:a7a:b73f:7584 with SMTP id a640c23a62f3a-a7dc5074f0bmr1347366666b.34.1722967859341;
        Tue, 06 Aug 2024 11:10:59 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8ddfsm567839966b.210.2024.08.06.11.10.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 11:10:58 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so892911a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 11:10:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKDCaGmlyUkwxBT8d1FFoHEqvie0qo7fzbnbNuOzv+7JwlGS7dZqFvUWdI+7a9DikQLhIiDR4Vz+plVUxbIVXB1zvnL0rZUYBQ4ss0
X-Received: by 2002:a17:906:db0e:b0:a7a:b1a8:6a2e with SMTP id
 a640c23a62f3a-a7dc50477eemr1164705966b.28.1722967858025; Tue, 06 Aug 2024
 11:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <f63c6789-b01a-4d76-b7c9-74c04867bc13@roeck-us.net>
 <CAHk-=wjmumbT73xLkSAnnxDwaFE__Ny=QCp6B_LE2aG1SUqiTg@mail.gmail.com> <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
In-Reply-To: <CAHk-=wiss_E41A1uH0-1MXF-GjxzW_Rbz+Xbs+fbr-vyQFpo4g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 11:10:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioZm+XqrwtijS7wKMcFCi=jhGLs5ausJbNutwFdx-Q_Q@mail.gmail.com>
Message-ID: <CAHk-=wioZm+XqrwtijS7wKMcFCi=jhGLs5ausJbNutwFdx-Q_Q@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Guenter Roeck <linux@roeck-us.net>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 10:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> where s390 has this very odd "flogr" instruction ("find last one G
> register"?) for the non-constant case.

Close. "Find Leftmost One" with GR apparently just being "General Register".

                 Linus

