Return-Path: <linux-kernel+bounces-412274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A69199D06BC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 23:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C658B21D16
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 22:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206A1DDC1C;
	Sun, 17 Nov 2024 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e0ftgWb8"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5E1DC19E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731884308; cv=none; b=B03UB6RMruJwBOYTZwywR7nTcymChaqExpD/q9horU3nbFgbddw906PnQi4VHp/EQSuGmHnaB/LonZE5PHSkSFWu727rteHEYQnawFqjKs6ldGpgjzyjoQPKNRVJcIHU3MlrOJBZiKIYOGhX5o2RfBTPyNJIDF/LFIUmjw9B96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731884308; c=relaxed/simple;
	bh=EiVbVsi+3KRPH1RlO/UqhhebmUP6+aP3L6Bqgv1bwW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZNJztT+kldPnl49YHghmkAOUFuSDOvffrFl14/wPKCNhavq9xJznT2XD7uwLqGXBIRF4mKEs2IOMDXZExohAQs6aNdq1DcDjcPnvXT6i3A3W3XRsoaMnviTi4HU8JtqmhjFIE7dvhsQXwjNE1BHetQ6tasKguFVEjSPSqjnSnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e0ftgWb8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99fa009adcso121906966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731884304; x=1732489104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzkeKdhEDg8y8yiwaJERZ7qd5zIqnzWCTyWLEoroQ78=;
        b=e0ftgWb8OpScRpbbqFmdQezESQMuFxtU1GB45iYLL/b0zj5XXt6Ot+i3/uhZqHyZ97
         dPBbxVaGJxy1BM+9IUEFLAOfrY460LY6rdoO/MqawW+PwcfdP98xJB+L7RYdEGExuqVD
         AEXZRHUO1P5+UFmFR/U79E4zhDM6gCTqT3OQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731884304; x=1732489104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzkeKdhEDg8y8yiwaJERZ7qd5zIqnzWCTyWLEoroQ78=;
        b=d/GlHa4K5McCIUmST7X0fnasEf4E+eUwmrnYz0ffVYJ/PnMxhsa+6ihIcqaKZWo8VH
         0xjrcSe1S/wTICWAxq51AekowR5KabDGUar3LJWpeql1uCgtn4AGDIwCjGssu3fVOOs9
         kMvWZZ4bSCKWQOECNKT6bmGM2DdtK3wN8pyk2/7ym+WC0egBNKYM6nYDnJ1/Ekmw1IJ4
         VFyViKN/wXLD0Xte0BZW2OhlwQl9u4L+ku4SIKaaajJPoGmk/eVYLCLWPD7A2MFh12XD
         P4hT7AeIf+Hrk/cUI5/zCJxq0tuqUWfHywIJPV75dzfZuWCrAy9CiGpmg5I25yc+96GB
         oc9g==
X-Forwarded-Encrypted: i=1; AJvYcCVhZe+BoFYi+9knRAtjMGKt1JeBjBJNgDDUuSZL4jx8ru54UwT5LzroFKCji+4HisI4qH/nX/ij4c9YdXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyliDt6wFKq28nELhi37d8QppHSfX6Flg38d0kbIuSp3e45Su3V
	NzGvXxqZG2VE3KLHs6wGJCx4boRRlnDt1g7Z8jS3Zm9Euee3d0M1btMSll67yIb2gCoQVW8UWRm
	nq9s0Kg==
X-Google-Smtp-Source: AGHT+IFYxdFXJ8f+OslVIMyFLG/DYcC2Sou/v8bwmzUb+vVR1SU3ln13L4fpaXDQirpklNgvxoYfJg==
X-Received: by 2002:a05:6402:2688:b0:5cf:bc9a:9a9f with SMTP id 4fb4d7f45d1cf-5cfbc9aaa8bmr5210574a12.24.1731884304523;
        Sun, 17 Nov 2024 14:58:24 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c1de36sm3878514a12.84.2024.11.17.14.58.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 14:58:22 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314f38d274so22199665e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:58:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWs/sIZOfGEtQvn1Ug9aEUHlXSQAUEISpimGo1BFNa6/sdA2VHX6xDRgrNdWBZrVZjbB63gr+0ouT2liTM=@vger.kernel.org
X-Received: by 2002:a05:6000:1849:b0:382:440e:4e86 with SMTP id
 ffacd0b85a97d-382440e513bmr2379360f8f.33.1731884301218; Sun, 17 Nov 2024
 14:58:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
 <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
 <c2eabf2786c2498eae5772e5af3c456f@AcuMS.aculab.com> <CAHk-=whaUtqsgLGk3a+1+SJ2+KGK+GK-WbSK0dX2JpVN3bs0hQ@mail.gmail.com>
 <fab10eb9e70041c0a034f4945a978e00@AcuMS.aculab.com> <CAHk-=wgfpLdt7SFFGcByTfHdkvv7AEa3MDu_s_W1kfOxQs49pw@mail.gmail.com>
 <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com>
In-Reply-To: <2b5282038b1f46bc9a658fb2b6d78350@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 14:58:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
Message-ID: <CAHk-=wiV+yL5qhm5FbeKz3FV6Zdi4oRv7rr3b_=16tfmwUMWFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 14:38, David Laight <David.Laight@aculab.com> wrote:
>
> I wonder if it reads better (and without extra comments) if the (long)
> cast is removed and the 'callers' are required to generate 'long' args.

I think that's much less obvious, actually. You'd have to explain why
it has those odd long constants now.

Also, technically it's not even really about "long", but "intptr_t",
which doesn't have a simple constant representation.

We're using "long" in this context because we don't want to have even
more dependencies in compiler.h - but I do think that means that the
cast is at least conceptually the proper way to do things: it's how
you'd do it in some user-mode header if you do this (as opposed to our
kernel model where we generate all these things from scratch anyway).

The "0*!(x)" is admittedly kind of ugly, and might be prettier as
"0&&(x)". Same number of characters, but technically one op less and
not mixing booleans and integer ops.

But honestly, nobody is ever going to look at the internals anyway
once it's all in there and works.

              Linus

