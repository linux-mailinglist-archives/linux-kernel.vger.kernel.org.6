Return-Path: <linux-kernel+bounces-215245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C1C90903E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF11C233FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBEE17C211;
	Fri, 14 Jun 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V4Cv8gkK"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47F16F0D1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382514; cv=none; b=ENJeA/tZTbWLDuw6TrArrx3UZfysmHXDpjd9NsHevTsK4Hx3PhKJj24Aj7+xBpba/IiyDnkQNK9ZiG9Zh0FvOgP/bBNQ87lCJF4JBi29bhM9REBk4sLswspYyJVzG1erzNuH1LW+W8gWDqYnrSHkYcdl6PDWQNLQThmZRST9BYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382514; c=relaxed/simple;
	bh=8esRhZr5t++HylGupLX6lyRpqHu8zZM1p1WN0/F8Ko0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sz6KOazhKMcujNpfC68x8A00dxTWYS+eOK+EyTeppuQIOfjKqL0DP5dBVN2kM7NAo9QOACNnw77yg9/dOTfmglsz9nkKiZuDJiJkORPhCrv1fAPMvkQKKfkIr4NVX8D9WINt6Sh/ITS/gRO0uQbnFQeLHk95PebQdHal+svuGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V4Cv8gkK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a63359aaaa6so359113366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718382509; x=1718987309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjciShuEmN4FOttkz3Fru1iIAynJFsivm4utVaX4RDQ=;
        b=V4Cv8gkK56l5oxvYJmamzusDkfTD9NKIE2ExJ8mmzsfLMSKroCdM81ez60zXOX6Z/l
         W9RUQvJgzWgpspSnrBbvuLelHj4iZDi/boFiV4q4y+UFpNx/TjoWqjWt00xN1CPzmFBU
         lEuOT2v2ZDDBb10QVDf5o1BupcO0ZVKsLZeLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382509; x=1718987309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjciShuEmN4FOttkz3Fru1iIAynJFsivm4utVaX4RDQ=;
        b=Ex3vQur8wYNZynMMmMjys8PYHqG96r3IJ8hbWX93OOlMpKGy5k8iKWZWkaSWu2A1in
         OQxX+D0vvL5SjWFRld7MVOwDGziHyL/Kb2boQHJ79nkG1znGSA9ZotS3t801/JHoX5P1
         258T8bv84vFbp4rPvH9JERtuMJ50UMSrNAveAvCjI1u3nsf2MhwHvgsd0Ed9WzeDFotF
         2kIwB65aJtD/enPShbkpNvM/JKmksmkn3EumhLYplm41qAREXaVnuSHw34wKDpIWF7AB
         lIrtSJlnqsGmHFIyFeHK66TvMuUThbjdXGDGq76OFLHKoyBZ4fRX01SXR04GzZEcD641
         ReDw==
X-Forwarded-Encrypted: i=1; AJvYcCW17u3GB8vdrPwXyLOQe1WYDbp4D0vwFfzq/1yunsTEpz5ZIOjZmwD6cf2lU7yL3A5mc5HmDluALfpk43O+EI3BfQqchF1ebX+J2B9D
X-Gm-Message-State: AOJu0YzWoQ6vS44Bs4RxZLeU4Yo7GIPQiLj2ln5o+R0IV6XByTJYK7aW
	S6wXwFMifDl7ZooIZCqhsSDZpKv3dXArIv+eMc/hTuzMYyuIEy1NH3MQEjpdJ3YGWAV01YjEaq2
	S9e4pkw==
X-Google-Smtp-Source: AGHT+IEKthR36x2Snann5nXIajzwgBNQnDjkwy8ej0RDcip52cS6ivp9tRoTkM69PFhIPBga+jmEvg==
X-Received: by 2002:a17:906:40d7:b0:a6f:585d:626d with SMTP id a640c23a62f3a-a6f60dc896amr185376766b.48.1718382509442;
        Fri, 14 Jun 2024 09:28:29 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f41737sm198865866b.160.2024.06.14.09.28.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:28:28 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so1033894a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:28:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5dcLrV7gW7eCTAgtEtcKHvcVhEyQBuEezjr9v6fAcgPON3wb8bfL+eIrs7QZxhyX5ES1TKEFxklgmMO/ZvwwvfJF/aD3DCAaIQYnw
X-Received: by 2002:a50:c357:0:b0:57c:7594:4436 with SMTP id
 4fb4d7f45d1cf-57cbd6642ebmr2048528a12.12.1718382507928; Fri, 14 Jun 2024
 09:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zmr9oBecxdufMTeP@kernel.org> <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
 <CAHk-=wgOMcScTviziAbL9Z2RDduaEFdZbHsESxqUS2eFfUmUVg@mail.gmail.com> <Zmv8sMMGS8uosLQD@kernel.org>
In-Reply-To: <Zmv8sMMGS8uosLQD@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Jun 2024 09:28:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOwJD6sp6mdFg+6Ab8shcB0+qD8=m6MFBA-ExxBnYG5A@mail.gmail.com>
Message-ID: <CAHk-=wiOwJD6sp6mdFg+6Ab8shcB0+qD8=m6MFBA-ExxBnYG5A@mail.gmail.com>
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Jun 2024 at 01:20, Mike Rapoport <rppt@kernel.org> wrote:
>
> A single constant is likely to backfire because I remember seeing checks
> like 'if (nid < 0)' so redefining NUMA_NO_NODE will require auditing all
> those.

Yeah, fair enough.

> But a helper function works great.

Thanks, that patch looks like a nice improvement to me.

                Linus

