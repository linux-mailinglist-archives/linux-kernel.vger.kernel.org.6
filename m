Return-Path: <linux-kernel+bounces-200529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4659F8FB14C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED32228241C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22027145B03;
	Tue,  4 Jun 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PUNm465m"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC01459E5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501469; cv=none; b=DBxTIVjzE4vEAfHqELdvcGaI4UjVvLAAct2Zg8X7zTAnMI1ZkwFclWhFLDT3S9MFa9+ayjT7Hc55xEcGRg1s1M+1LwF447JhOksmFFarnWVREENNykUXqigtG+hIoPDAOadiGgX8xYmqWk27YXVu2Frd924yBZfZRvDaiulQhl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501469; c=relaxed/simple;
	bh=3BXu54JL29te3bk0JIakNdnue3MoNyfA1fQ0KpkafnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6qo8qgZPKAiuu261rneoOMuP3XuMgfCm/BcLfaF4Fnv4r0RkKArQAjGiIg1vXsLfxClM0lP06G5pzuxSlI3jCHvni3+Hqq/rdyBPQ7qfn1NGwcPRhutgTMd5E0Na/iEoSNxfjA295xeTPzN71xF22RDg2IJAgsdK0ak3LMEM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PUNm465m; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so967844a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717501466; x=1718106266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BXu54JL29te3bk0JIakNdnue3MoNyfA1fQ0KpkafnY=;
        b=PUNm465mt0L+oMsosDaaJ7pHYyJCaIEQFFn6bbrPcdwVwl0DvmsVU0FjLUKb2SCUK3
         OpV+aZDTG1E7CUmKBDpFk6rW42+hWu/k9bZtOPElGsoyHDd3+EOlNqCDxc4Oxcoqab1C
         EsuE7Sw4lJyTu6SmglSltu4RvZnByV4qp91pt9eM6w3YMsHisr4gaErBQ8FIe+L/MJGK
         0L9Txovpgdh4UwXc6ULR+L4TTEjTcr2Rr5QgO4FNI0yCXXcHIvWHgJr4NQnAQIDkcCjl
         ydBgOuIpXaMuTksEyS+I7hYz7CYJ6S2NwQm2vAtWNScKJ+FqhBNrheBnCaAG2QSncbSj
         Eu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717501466; x=1718106266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BXu54JL29te3bk0JIakNdnue3MoNyfA1fQ0KpkafnY=;
        b=EDkPWnzGLRt1WjxvkQyz81tS9dvErW60sdz9w7iiGnuLpFQbyISwRRTcnzHrwbg9Ai
         lqEr9COwiCGYLgBoQwgw+bXweWRO9xws9b2PBiu7kYUBJg1bYfpGYL8iU8H2ljNXARSu
         JS6VxNX4celb/lUG6OLSa2UcHm+ofGkOMjm8yStHKzLuw/C8SGJlTxHSMeIqhhLAC83r
         x+HziKeM76scqZRypdTvxee4OGrLSHMy8KfXd6Zp4MHu0q5nJ4m1f8flug3kz72l4MsW
         aPnjz3Sm3K+9dMmw68r/ejb9fX10BQ0M70FKa4V2AKDYAYbiNPf7Smw626+rM7qu6qcR
         f92A==
X-Forwarded-Encrypted: i=1; AJvYcCVkZI31oMi7YuYrdi/z9tqWIHKKKHKn7G1De+rmLMEel/t9FSthFm3i568RougvY5Co9GPk3YkCNsmEFZzKKMIqtLn0/srMy/+1uJly
X-Gm-Message-State: AOJu0Yxsi4W3bn09BYxk1IYoOP4xxrrJ5jyubwiXnEkM3/+WFQO/HSuY
	vMeUVPKiKMI056VpGcAfXZXFPHolFGXdNI+AETKzDGNcXjFMIPLOS6sB4qMMGqQ0XutJAirX68D
	wyiui2mxuge2mlQlQxptYEU/6zilHB4fTwZv5/w==
X-Google-Smtp-Source: AGHT+IF5j0HlHcUwqZev1qhJa4XLMrGdrhzyscNN/jd+ZNq5k0ymbm8yvqEpsVyAB4LEq75CK9UuVo8NGyvZXeKaCp4=
X-Received: by 2002:a17:907:7ea1:b0:a68:e9dc:b07 with SMTP id
 a640c23a62f3a-a68e9dc0feemr501609066b.60.1717501465846; Tue, 04 Jun 2024
 04:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131155929.169961-1-alexghiti@rivosinc.com>
 <20240131155929.169961-4-alexghiti@rivosinc.com> <CAEEQ3wnT-K18R1KQjJbeSdnFnRFQZt=wCuAHeDrf7EohwZ7n=w@mail.gmail.com>
 <CAHVXubiKAY_L04ZwYSp-MpPPT5sPzxm4wB6HVFPzsMcB-3zq9w@mail.gmail.com>
 <CAEEQ3wkkNyrjVCDxprNP5Z=NzO=EYeKeWf3CDvVNJHY1uovmMQ@mail.gmail.com>
 <CAHVXubi+s2Q0y_xLbHpQJpz+yXvKWJ8e96wwAHP6A9C7U-He7g@mail.gmail.com>
 <CAHVXubg4vtfjSJ-w8-7suzZ9L5ZmTo8udUMaYjJ5veKBmikNjA@mail.gmail.com> <20240604-dazzling-envy-1dcf111eb2c5@spud>
In-Reply-To: <20240604-dazzling-envy-1dcf111eb2c5@spud>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 4 Jun 2024 13:44:15 +0200
Message-ID: <CAHVXubhy1yEKOx91gc9S++yKOoQa+sJ5EDSiMFwR6qepwzRMew@mail.gmail.com>
Subject: Re: [External] [PATCH RFC/RFT v2 3/4] riscv: Stop emitting preventive
 sfence.vma for new vmalloc mappings
To: Conor Dooley <conor@kernel.org>
Cc: yunhui cui <cuiyunhui@bytedance.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Ved Shanbhogue <ved@rivosinc.com>, 
	Matt Evans <mev@rivosinc.com>, Dylan Jhong <dylan@andestech.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 10:52=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Jun 04, 2024 at 09:17:26AM +0200, Alexandre Ghiti wrote:
> > On Tue, Jun 4, 2024 at 9:15=E2=80=AFAM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > > On Tue, Jun 4, 2024 at 8:21=E2=80=AFAM yunhui cui <cuiyunhui@bytedanc=
e.com> wrote:
> > > >
> > > > As for the current status of the patch, there are two points that c=
an
> > > > be optimized:
> > > > 1. Some chip hardware implementations may not cache TLB invalid
> > > > entries, so it doesn't matter whether svvptc is available or not. C=
an
> > > > we consider adding a CONFIG_RISCV_SVVPTC to control it?
> >
> > That would produce a non-portable kernel. But I'm not opposed to that
> > at all, let me check how we handle other extensions. Maybe @Conor
> > Dooley has some feedback here?
>
> To be honest, not really sure what to give feedback on. Could you
> elaborate on exactly what the option is going to do? Given the
> portability concern, I guess you were proposing that the option would
> remove the preventative fences, rather than your current patch that
> removes them via an alternative?

No no, I won't do that, we need a generic kernel for distros so that's
not even a question. What Yunhui was asking about (to me) is: can we
introduce a Kconfig option to always remove the preventive fences,
bypassing the use of alternatives altogether?

To me, it won't make a difference in terms of performance. But if we
already offer such a possibility for other extensions, well I'll do
it. Otherwise, the question is: should we start doing that?

> I don't think we have any extension
> related options that work like that at the moment, and making that an
> option will just mean that distros that look to cater for multiple
> platforms won't be able to turn it on.
>
> Thanks,
> Conor.

