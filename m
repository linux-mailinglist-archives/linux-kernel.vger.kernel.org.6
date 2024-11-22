Return-Path: <linux-kernel+bounces-418514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40749D6269
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F5A28405D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AE815ADAB;
	Fri, 22 Nov 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwwAOdiv"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296013B5A9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293427; cv=none; b=cPupma7RgdFJgVrOYQVfYtfazat5Ygl0iSGt83/1qih6OjdpjKKT1cNulM5RAyUD7dTRbmC0aylGblreBg1MqTp6KvI1W+Z6jzxiMFdGrODmliz6h7XjVnXSxz1GUvGKo551ivdwIzwa50GykSvzKYzw0KwJoBcXqvX5heF+bEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293427; c=relaxed/simple;
	bh=FQn0/LRkgEdk0lbDArlpXcqhIAjBsyxrxbcIJCFBjDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2auMsfDLeyDDf/KwD5HZxlhPb8i6meUd6zGstLzlX0mzsDJm0ip2GUzDyhhcTvMl/qwDgZw+HfNtu+UNk8Ac5g5WUJFWX8ii7+5yQJfTseaCA8U9+ZQA/gVQoXt/8R0BmYfnn3hBdmIhonGqZs1l0es0gox4/lxLW9KOghy5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwwAOdiv; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460a8d1a9b7so265621cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732293425; x=1732898225; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQn0/LRkgEdk0lbDArlpXcqhIAjBsyxrxbcIJCFBjDY=;
        b=IwwAOdivoPkOcofEAj+hfKeVadAc9ZetzVD1yYYYpPh+26LYUGYQcT5LwcMpfNkz//
         6xyvJhE7XWVIchOacGbUac0JtZOQM5JSt86P6SErp0W+2OcnjUXq9/VJ9gERZ2O5zix2
         9EwNhjdsHJTaROfxGeBlYyuvp/ovF1zQCIIZowcLRO0MC4MoQiu1fRbI545Nzq9+JKMw
         AUKS6ZMuS2e5rtTU9dkfyFVSlSIOlvl41/CE4CtcuZq7W1KqOf9Qw8KtTTNQhW4innCc
         sPLYEmyqVzqiYN8dk5O46XL5QT5WTPKTXA1RfWCyE6BdGH5T5LzRw84t/RGg7cbArmXh
         Rb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293425; x=1732898225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQn0/LRkgEdk0lbDArlpXcqhIAjBsyxrxbcIJCFBjDY=;
        b=gkFg4P/DhNJLvVW3lyv7PmeE50JurSRQ2d95Iz+pZGmoV/HYCJqnUNdRvmwFqigWc8
         iVWvIMAZlJ0K2a43h5q0tIX9LkJdLHTnTcvVGa+jA54G12wMY5d1P4nacDIpYI8cUkv5
         b+ccjRIhuC2S5S5frZ/z4cqZS1g10B7uXs3jV7OuUmnNxh5SkKA++4s85T2TZ3LHkgQ1
         lIJxudY/k42WxmpcvTQhMofQONzms9I9Qh0dTql38fy1YG31+UnjLQvB0YOLMAvyh/YH
         PSqPc8n2QjkEIyIxNjyK4130xNbNUjFq2+dv+k00CW0hyjV1wTXVioMo7v+0BKUXoLI1
         2/6A==
X-Forwarded-Encrypted: i=1; AJvYcCVJhW/EDwkYFCbmL1Xs3xwsfBrcuFWVA5/TLM9/9QAhz3NUvdNb4IOx3m1uOeMGvXaZtx2lF+c35DBMof8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0pvFWGqxb6LXE2HCnsbfbPRHO9G9t+Q5InMXopZN38pJZjlcB
	sPij9Yn/R6E5JqOTzlXApLUtbMiZ2TiDEKAgb2qFBl0k4A10scrTPk7IzCvu2/ntZlFOVULGrN1
	pQ0V1X1y8jmOfHA+32yHrkw+grlrThCScq6lO
X-Gm-Gg: ASbGncvKTBsWLRGxlWQ8btNKkxuHM81+mqrM0COzAvoVX8GR3rjnjnpTJUu8FZHINTk
	Lb5GenIftJ5lEY8w9eWz+Vdim1JgcvD0W+yQNPEs27B0eUVjQ+fcVRnvv59eFQA==
X-Google-Smtp-Source: AGHT+IEb0dvXm8Lh4U1x+Ww0tpnjqHUUTD9I18tWGr+X9agjb/H25wNVx2Atj/FF5dXjdF4djDV8FJiSG3REib8UtM4=
X-Received: by 2002:ac8:5a91:0:b0:461:48f9:4852 with SMTP id
 d75a77b69052e-4653d5d6d42mr4144741cf.28.1732293424596; Fri, 22 Nov 2024
 08:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+i-1C3R=56CAMiDwuzrtxmQN+CN14hUeMfbv4k4WqyQfexZ1g@mail.gmail.com>
 <3676f073-028e-4855-aa87-107e0607be24@amazon.com>
In-Reply-To: <3676f073-028e-4855-aa87-107e0607be24@amazon.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 22 Nov 2024 17:36:53 +0100
Message-ID: <CA+i-1C2cyypfrTNauqEn_640k36Cvtf-qw4vJEDx0bQuJOO6gg@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
To: "Manwaring, Derek" <derekmn@amazon.com>
Cc: David.Kaplan@amd.com, bp@alien8.de, canellac@amazon.at, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, mlipp@amazon.at, 
	pawan.kumar.gupta@linux.intel.com, peterz@infradead.org, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 17:15, Manwaring, Derek <derekmn@amazon.com> wrote:
>
> On 2024-11-14 at 9:32+0000, Brendan Jackman wrote:
> > On Wed, 13 Nov 2024 at 17:19, Brendan Jackman <jackmanb@google.com> wrote:

> > A discussion off-list led me to realise that the specifics of this
> > comment are nonsensical, I had L1TF in mind but I don't think you can
> > exploit L1TF in a direct guest->guest attack (I'm probably still
> > missing some nuance there). We wouldn't need to flush L1D there unless
> > there's a new vuln.
>
> With Foreshadow-VMM/CVE-2018-3646 I thought you can do guest->guest?
> Since guest completely controls the physical address which ends up
> probing L1D (as if it were a host physical address).

You are almost certainly right!

> And agree with the flushes between different restricted address spaces
> (e.g. context switch between guests, right?).

Yeah basically, although with the RFCv2 I'm gonna be proposing this
"tainting" model where instead of having to flush, in context switch
we just set a flag to say "another MM* might have left data in a
sidechannel". Then if we have that flag set on an asi_enter we flush
at that point.

*We could break that down further too, e.g. whether the thing that
left data behind was a VM guest or a userspace task, if that ever
influences what caches/buffers we wanna burn.

