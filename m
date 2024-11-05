Return-Path: <linux-kernel+bounces-396993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9AE9BD552
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56C0283F5D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166D31F1301;
	Tue,  5 Nov 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfFb3sEy"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FC1E906F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832611; cv=none; b=SE55YNCEtTWZNo4f7ZED1/sEWo0f/WPoU7L8UhIPeDHNI2oG5Z3K8r3nOePJfiwk8XeUqAnjZ6VOS1kXsTBbc1rI20x84zT/yoK1RkJ+1uIAWCdRwXt/dvcGzftRJOEPDKKDIWtvL0efg1tysdOZ4cuawge3mpOHAzXLHUkW82E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832611; c=relaxed/simple;
	bh=GuA3beCpCOsF/1gnaqKFYykwNqNyqB6S+p7rPkGGEko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sE6l08nVjS2oo1NcqaqjmCGt0Rrl3Ue1ghoepXLLCiK5ZfrtXutQUYcSF6oXshVGM8Y2P9+fY4yoxeojbZYnIdeCK7LaRTz5BEF7x2lCExKu/i+2a9rQakvTlJawBsJvje/Iv/ihXTmi3HoPc3qdlwexLDHepFbfMYidll2fxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfFb3sEy; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-855eeff6448so1605773241.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 10:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730832609; x=1731437409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuA3beCpCOsF/1gnaqKFYykwNqNyqB6S+p7rPkGGEko=;
        b=XfFb3sEy6bh09we+iyqQlLwnD76lkk5u0bxekUKVqfDHOvHL95+cVRcdc4I8OhOaDg
         6ifdfcshF6jJN2VKL/BP8rWmf14vuT26H3/lMQ7zkeGHdocDkEEod4GBF8fJhT3CALD5
         3ort2diLNibyMSa6VKKTAM07XBCTuCjaOuBspJhUfrcC0+LbSz7UviKPPUOgGNAVwXJZ
         JsHulYPqHMp0+OyTazmcAoufmQ7up7i14pgeTZPdae1qEZxhZOWhLXfwaal3MwbeS0Sv
         Os6DO4088NZ1tr4X4QTN7mYtoI1JzNPWzoJXBz5iqhAVR620wgpzzFY7r/8kx2Eyp0UV
         ilvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832609; x=1731437409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuA3beCpCOsF/1gnaqKFYykwNqNyqB6S+p7rPkGGEko=;
        b=JQR5OxMqNLZ2QmHVx0aDVatSp8Jxbc9BBMZZSNweAFq5MeKwTmIVgbmYQKl9lO2rQC
         8u7dViL9pZFZH57qCwRKW84pGUJZaIF0ZxqOLCvoqmQXRTNrPie7O9hcJw2Y098h1fUF
         yfxj8CZ8uAiF1252mV/37uPOv5ERjrJgPzMRnYSWVOh6Mu38Hk2i065TJxoRRHZChne5
         k0KtxlQOMhQgeEvGgpKPjfXWHLQRglDr6sHh59xSk+01ffrVAxOY68zBc3DnxLZ938xz
         KM74cvzX47Hkj65xieTg04tBiuj51pq7IiBHndYLaYjlTkO0pXm6g5Mnd88Iz/5jX4Yg
         qdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7QQBUp3Cx7uXh5ti38j7hWurzCKlHDVnJIJZXkHROMCTvF8znvH7osQ+ImqAz+zUYy4XmOqFzA/8BsoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZj7IEuGma7+3rePhznMyXdMYiYyb+hQdvDZTa0SpZQdgFr8LJ
	RZfmZ5iJrloUKIerCgK99Hy3LrjsWQXdtFrEtPCsUkqoXXQ2SlIsLnqb4WdjEbUWiGZfgtl01hA
	WA8b7hq0ixq3yClhUbNf5Pq8F73jx8azQ1hxy
X-Google-Smtp-Source: AGHT+IHkItXBC1B3UDEQgFBqAWgFVBkvDNSRLXCtLKqvyF8jaciAAlFayhRVV0lLZr7LoiK4iN896AfTAH7qS9CPm0k=
X-Received: by 2002:a05:6102:3e92:b0:4a4:8287:6c34 with SMTP id
 ada2fe7eead31-4a962e4a464mr16705037137.17.1730832608818; Tue, 05 Nov 2024
 10:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105184333.2305744-1-jthoughton@google.com> <20241105184333.2305744-7-jthoughton@google.com>
In-Reply-To: <20241105184333.2305744-7-jthoughton@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 5 Nov 2024 11:49:32 -0700
Message-ID: <CAOUHufYA9wSQqOtoEx4yp1t60s+iOoM7Bq9yT+pfY82y0dQWvA@mail.gmail.com>
Subject: Re: [PATCH v8 06/11] KVM: x86/mmu: Only check gfn age in shadow MMU
 if indirect_shadow_pages > 0
To: James Houghton <jthoughton@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:43=E2=80=AFAM James Houghton <jthoughton@google.c=
om> wrote:
>
> Optimize both kvm_age_gfn and kvm_test_age_gfn's interaction with the
> shadow MMU by, rather than checking if our memslot has rmaps, check if
> there are any indirect_shadow_pages at all.
>
> Signed-off-by: James Houghton <jthoughton@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>

