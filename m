Return-Path: <linux-kernel+bounces-576277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB8A70D44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58643BFCB3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879C269D1B;
	Tue, 25 Mar 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WdazGhhl"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071D1EFF98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943139; cv=none; b=POnJF3SbVOAQ5AD3b6NiH36maN6CIJIqo8WUHIvkL4+e9WrootDXhsQjwEqwivO9YHvlvwWEKeNBf20z3A5UQvsnXSlDgD1XN2m70vBC1UU+mGSzt59vOQt1ke15WOEsMfJ+AoXuG1O5/CBIPSGdBIn+/+RY1iSsGTfH53EYP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943139; c=relaxed/simple;
	bh=ZTbkWv6CnlDbqJY3BfLE4M7+Ch+I7zT0wzeQIR2kUd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPsIfKYCVXY0a4WFhNei+wbP4SMY2xfKi4Sp1vw95NDO+88G1etfEN0oCyWIc8Szrh0q2R1YeZ2uDcqY6xy31ZU1FN5e5rQXJ6EXQWNUlSnWGWUUeSedZWRrG4BFxuVFtvLffawjRA/ooph77t/W1IPPbUkaQvX+07/pJpr/324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WdazGhhl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2c663a3daso416146266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742943134; x=1743547934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e4JDrtoGXDDLDIXwqSlEibUrhSsFbkL9xiBiOdDzBwo=;
        b=WdazGhhlXj7CZwF3pWw1zJn9MfCVwRtH1teUD4boj/XNNGaaiOEbCYwcLndLfeZD/h
         a/kIROZprtLOKPnYAPhur1wzXwSWW81h7TeSfJ9unRvt/N1pEYiQtFnspPEAoCvdZuQg
         M1ldqaHZAu4Adh3JYCQS+anrAGvslehEu1mVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742943134; x=1743547934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4JDrtoGXDDLDIXwqSlEibUrhSsFbkL9xiBiOdDzBwo=;
        b=LEB3ZkMWVzbmOY5IWZKc4+LbRFhBebi6sY2+JQbgMRah7xmj36VlV29Eaav5XmVbkQ
         YlbKXyiwfX5d8bcjZSrJk6yKqn6IXcLZ38EIPKop/NHUjLu81+EibMKRnBvIgZ2VtI3c
         LipD2zma3/7jl2jYRc/O0UOcd3L5pLsC8vNQ94o1uaiF7Rvm5Q3wzvwqmmQVaX/hpWiq
         AVXawPPlhB8t2nfXjoX+Utlm11EyI/ojzz6CQJm2KFyXijZOiyF8LljdpdgvpO9Kv8DY
         1tSPT+6nwOafFJxJ6tyzenIQ/RQzGORq6RK2i0A3YdBde6phj2p2a75ZDG87VEqQanJA
         E26Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqu4ESzMwlYWNAGsAjAHkYe9P8SOYznSAu43jm5C2ZLy3hD+yzfSeTgEH1NJ7+3c5tZyFgJ10HoX5e8Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuPH8uwrxTlGwmxISR3Pa4FlKqiIo0XkVP4OK0HcmFin2kM/z
	H5PR6noemqKKYMKanBqtSSZf5Va4sMo8TCoeGMDmymez+Xr4fpxK2PcpizV0zTIy98rDz0wx6Pv
	vk4PbmA==
X-Gm-Gg: ASbGncsFIfHhAs7C9Y/4DdihEBDDf9EAAyuVGQN2DMX6/jO0vi27/PMsFnDgZ3r2Syv
	fBgrVw3bzcIkPbcqkbJksX9P7a34jAaP3+Thfh0+w202LdWhT1OtNOM9IC6YBdrotrh9hm7/yPg
	vkvKEGk7rfzL+rZWGUur3efNbQzpYR1SOFCJ9wHplrlUcp+ihyxmXeuwVLjqZxytnCOtvNhXRbB
	j2yhBvuHkLKYsJFNT5OZooBdRBHiEr8PEn5sseZRih3w8U4EtuVq0yPPcbH6QoUnBfZ4QTlSzWK
	hmysiVeWM6IiKQM5gPZO+xLNxGNI2vSTkfy8tt28d5hnwbLtHlkR/HwNy7Eltn2NV3d6IgQJ/rx
	crbf2MZlJlZ8KOmaTAGE=
X-Google-Smtp-Source: AGHT+IHXdvKHiraHHwnPZf7B0AMbW09We1o6CRj+JpXtRRVIfzq43ZGXOKUQxK4hwt5elS3WU5yZ0w==
X-Received: by 2002:a17:907:7d8f:b0:ac2:a4ec:46c2 with SMTP id a640c23a62f3a-ac3f25342b4mr1831847466b.49.1742943134470;
        Tue, 25 Mar 2025 15:52:14 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef93e17asm930106966b.78.2025.03.25.15.52.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 15:52:12 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac339f53df9so139953366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:52:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWI6JgkrWR+XWlhHiFo1M9JzGvet3wVuofALB37ItJq3kDjcEhe3ox0LjewrX0F4wYQQR+4bf5VOo2QOsw=@vger.kernel.org
X-Received: by 2002:a17:907:7215:b0:ac3:97f4:9c08 with SMTP id
 a640c23a62f3a-ac3f224dc29mr1773944466b.31.1742943131705; Tue, 25 Mar 2025
 15:52:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320190514.1961144-1-mjguzik@gmail.com> <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
 <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
 <CAHk-=wjo__Bj3JNw_7E8HhTDUF65LVOApvN0D2cofgotJoqpmg@mail.gmail.com>
 <CAHk-=wjxi0poUzCd666Kx5wCjgOwN5v=-zG8xSAL7Wj_ax8Zvw@mail.gmail.com>
 <20250321204723.1e21cb23@pumpkin> <CAJmZWFHTG8cR77zrUpKF81tphcTQ1fyDO6vqnY57ptcs2yM=-A@mail.gmail.com>
In-Reply-To: <CAJmZWFHTG8cR77zrUpKF81tphcTQ1fyDO6vqnY57ptcs2yM=-A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 15:51:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisCz3HHBKjgHKfnCjNf=fLyr40fWH=D7jYe+EpHnWJeg@mail.gmail.com>
X-Gm-Features: AQ5f1Joa_8sHjM6LPpyMv0TuOd7sCIgFX8S25jah0G-9L4UHRV75Vg6PuVlHofM
Message-ID: <CAHk-=wisCz3HHBKjgHKfnCjNf=fLyr40fWH=D7jYe+EpHnWJeg@mail.gmail.com>
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
To: Herton Krzesinski <hkrzesin@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, x86@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com, 
	atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 15:42, Herton Krzesinski <hkrzesin@redhat.com> wrote:
>
> I have been trying to also measure the impact of changes like above, however,
> it seems I don't get improvement or it's limited due impact of
> profiling,

In my experience, profiling overhead - assuming you have half-way
modern hardware that has support for it - is simply not an issue.

So I think that if we don't have performance numbers on some hardware
where it can be shown to matter, let's just leave things be.

            Linus

