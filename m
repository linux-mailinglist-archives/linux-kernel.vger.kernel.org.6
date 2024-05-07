Return-Path: <linux-kernel+bounces-172128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D64A8BEDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26161B26A85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408514B94D;
	Tue,  7 May 2024 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVcDlbpJ"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41814B940
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715112459; cv=none; b=U5t+gIbuVu4XcS5KkPg7wdXWcGOTJQ0X2eBgdyWTcrf+4sacFqRO0fGdUSZEu5uKgQxa2TtUPDLwquz6KcModyvjcCWLvEcBhLGiG8ExETXdlwlNq4JbdpZc/Q40Nm7YnVjmBdSAHK716SZe4KMFLcZ+LVH92XvGJjodHc53ONU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715112459; c=relaxed/simple;
	bh=n/UC63lLAcCezzowRd6HUrb0809BTC3BrdNXURqieAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CII9KkkH2z9haFjJtkQnEimkGa9JmApIIg1S+v3ghqYlD3WtbhtrXSBG109chGqa4UW09MCrMhNbNZ0ZYFBBuWoh69DO7TAfTBNwU/9O5mX8hIbK1AYd7LpYnjfPzWZrdxw8zS9FWhKZpv83kO+YYnPJQE158piHajeVJk5fjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVcDlbpJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de8b683f76cso104268276.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715112457; x=1715717257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/UC63lLAcCezzowRd6HUrb0809BTC3BrdNXURqieAU=;
        b=SVcDlbpJRsrU1CgzIPyIMBcSRiNQlb/5CSHCxeWcn8JMiEXYDqEwLhcQNvb+ii6/sJ
         XtLcYclLlXJXaUXCPLg+AkOYmnBydERB7hEhtMEsyPvDOAonOizvQTvbYgfc3D5KTjDb
         14lySm6QzBJITBBz4TG7m8RxTzrtlYmlQv4HlC5WTWQbzCjTWt81iaUjokYU0qYFHijs
         mR8bWKCwDFDlLJZVGk6xgQdMI8QH4qVUDauUZFU9IbdWkA8828IlkyTKxg6OAlqALJdW
         iVx3ZdeZAvzgKZszgZqHW+WKb1E8w0fpn7uXGawrpZvvmJhFoDY0u0WtJU/g3eoUxGBz
         3SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715112457; x=1715717257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/UC63lLAcCezzowRd6HUrb0809BTC3BrdNXURqieAU=;
        b=bhQr4LlCl9nMAjsKzIOLVmQIhq1DbnPT4QJgJ0UrqPFx4v0yzCvxi7E84+8wl5vIUk
         cD/u7qUsVzrOvSB1sV7EK37drnGfGLeh4yeRDY56MV/IUS3U8dzoOvtKxKBefD1Wkwt9
         rQbP4EvhDMGMFFxLqcdpLLSPin7LGIgdEqPCiV7+8z9MDg887vQlzPVUMV4D3FarGm0v
         gJe8tm/oiaiN5IMoajGhvD8V7Rt0AadAj8KfPuqneOR1cw8ty3PjN8hqCzGgrzwsW4BC
         me63llwLtLOkk4Ptq+A7NTuCGMHOFXDeW8o3tUj9RUMWFydDd1EtvCipEpfpX+kbkyle
         IoXg==
X-Forwarded-Encrypted: i=1; AJvYcCU+2iBIfE9FRU2C3h2E4t1C7do758uqv+ZU3Gr8iKp2I1HWgWNNL4Jxmaqtg4rkMpryYzYZSmZN4kcjW3qmY2EHr1JRHCNHwa4JLFPL
X-Gm-Message-State: AOJu0YwD5ZU0onikkUpxbL++djHh4QYytiikHcE/nCfr4NOax4dpaXtv
	2OkFp2ThVdyezvkhC1uMX6LpSYast7QdpmLBG7QpYT2xSQ/B74+Oojja++GKTICe9FkGQZ04P9S
	KOPq2ie/9JWb/70KNkwRaEdgqkSjdkkpW1lp5
X-Google-Smtp-Source: AGHT+IEm/B5M9ij9+hhRe58Bv33yPC7ejrw1gilNago/rHkRrXGwhO7+GslzLf54b+pza6hk37izLWTtVb7zqaBYMVA=
X-Received: by 2002:a25:7481:0:b0:de5:64db:170d with SMTP id
 3f1490d57ef6-deba31e004emr2783330276.7.1715112456532; Tue, 07 May 2024
 13:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503183713.1557480-1-tjmercier@google.com>
 <20240506052955.GA4923@lst.de> <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de> <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de> <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de>
In-Reply-To: <20240507054314.GA31814@lst.de>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 7 May 2024 13:07:25 -0700
Message-ID: <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	isaacmanjarres@google.com, Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 10:43=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> > > You should not check, you simply must handle it by doing the proper
> > > DMA API based ownership management.
> >
> > That doesn't really work for uncached buffers.
>
> What uncached buffers?

For example these ones:
https://android.googlesource.com/kernel/common/+/refs/heads/android-mainlin=
e/drivers/dma-buf/heaps/system_heap.c#141

Vendors have their own drivers that also export uncached buffers in a
similar way.

