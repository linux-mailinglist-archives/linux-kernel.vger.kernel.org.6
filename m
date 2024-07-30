Return-Path: <linux-kernel+bounces-267952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749EC941D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D1B1F26D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356961A76BE;
	Tue, 30 Jul 2024 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTabwNNt"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE91A76A4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359914; cv=none; b=CKV7p2pYcQvbGPCimjjDPuSLvrVsJS+hKd+CLWTFQs5VPQWKlW//DUGonElUcX2KvxUhQD+fmTUI8zqWpqYTQonAj49Yk4K0+QEaWjEYUP+sSIwM4Dmk3RPQaAnkkLKzbktjAR9LHE0k+U1RNm0yruusPS9k3tOqa3eWgbRmG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359914; c=relaxed/simple;
	bh=NSwh2S4jFZUNLW279mrTn3SdwO4l4yQsEMBUgQrDYbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cw3e1Iq7ElzZdDYxqG39sbkd7HCin4VzIdy1j2W5QX5iEDpGCv7JFEF0V1DCQR/UxwsDLDxbTZoAUF74vLtPtj0M0XX0cBsHvt5ydujjLVPMAKaqxF59kD07jE/s0tzFbII2NAci6kWZZcV7jDxcHRQKE67UaXuAzkt6a5J6Ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTabwNNt; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a728f74c23dso650160666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722359911; x=1722964711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSwh2S4jFZUNLW279mrTn3SdwO4l4yQsEMBUgQrDYbk=;
        b=fTabwNNtYtA7HLvaqUBBdNxT4tS73r4+fqmiwTog+3WOJI2HxQkeVLkzHOruUMosaF
         4YsMiepGT2kx8waWoJKhvIwFRpH6bXFAZKAJWzzMc6mGOM9dhOrxzKHdWqRg/Tz4K8vW
         5aUs7u/5hmc+uHoLT1T0xD3Y/KwRevxMeBm+EMPCHjc4AtVbLpLHQiWdXFWKrYN3WgaK
         nhQ/GVnuI4z+2RzST+ROiYu8YVb3HdgynbMJqfd7NJs5GWpSQP3yBQirLxs5DCxv/Kok
         fcSL/MpciHjVEPRq2od7BPXWlEyRtIaadqTEXq86f29sMci16aHFqz/MqSNSC9+xmCGY
         hvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722359911; x=1722964711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSwh2S4jFZUNLW279mrTn3SdwO4l4yQsEMBUgQrDYbk=;
        b=TSqEoBLYq36f8Zx6EYc8RlTZr7sP7IVujxH3XezmiVUMnoOt7ajyP8kqXUktonP4L1
         B12QNCFEqDkglUe4K9RgGyzEbSjDKcdrqcFskR5QJr73peWsbC73a3FSel0t8CrO4SOl
         ofhmLvV+R/nP5vkP/3tWvaUH2xDcOCyJHvOIm9g0V2TuitWH1D5PI0c6/ElO6CJD65NP
         vRSffDuoVzedYTxDobdyF5BoS6FQom/EqIBylmRdfdHDMQlw+E4IoOpCMkANmmHufNp+
         +CTejxKz6zPsDwEJVgu7AlawmhAZohqi3Tq3l9/q/8Nevyg6byRcIakZAaCs4vQIgsfQ
         qGWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEjhGkL9wmV6FHoVrt3LHHaz0C66RXRrvY9htDdt1dhAVJ+gWCf4g9+/f3cOSRI0MRF8hYM92JEQTxTVnaaOnwLHHxShbFKic1vX49
X-Gm-Message-State: AOJu0YwTn1pVYCVi5fQMgkscl4Emao+HnifQ3AENCH8TFUBEjXhbIMCM
	K2s1ahq9nIUb3ODJSAY8vzcse7/7x45eWF/GCjIrTI2J4YtVGAx8+7kCMgOxy7oLKQgNUozg+K1
	xaB5vDHdseLAQcbcDnKJUC28NG7C75trteqFN
X-Google-Smtp-Source: AGHT+IH48rycmcn5SYzBW5ZC8UbZoUnMTbOHz0noIuwNpgbbja3UlcoUmoGDSVmhxt7iRguQJ6tBZo30R0axzOWbm+Y=
X-Received: by 2002:a17:906:c10f:b0:a77:d441:c6f1 with SMTP id
 a640c23a62f3a-a7d400af7f6mr804585366b.33.1722359910408; Tue, 30 Jul 2024
 10:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730150158.832783-1-pasha.tatashin@soleen.com> <20240730150158.832783-2-pasha.tatashin@soleen.com>
In-Reply-To: <20240730150158.832783-2-pasha.tatashin@soleen.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 30 Jul 2024 10:17:54 -0700
Message-ID: <CAJD7tkZ2f6g3P7qVP3fL0jFjZNHNgsW6BUb2-megpq_NQ3W7kg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] memcg: increase the valid index range for memcg stats
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, kent.overstreet@linux.dev, 
	peterz@infradead.org, nphamcs@gmail.com, cerasuolodomenico@gmail.com, 
	surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	shakeel.butt@linux.dev, vbabka@suse.cz, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:02=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> From: Shakeel Butt <shakeel.butt@linux.dev>
>
> At the moment the valid index for the indirection tables for memcg stats
> and events is < S8_MAX. These indirection tables are used in performance
> critical codepaths. With the latest addition to the vm_events, the
> NR_VM_EVENT_ITEMS has gone over S8_MAX. One way to resolve is to
> increase the entry size of the indirection table from int8_t to int16_t
> but this will increase the potential number of cachelines needed to
> access the indirection table.
>
> This patch took a different approach and make the valid index < U8_MAX.
> In this way the size of the indirection tables will remain same and we
> only need to invalid index check from less than 0 to equal to U8_MAX.
> In this approach we have also removed a subtraction from the performance
> critical codepaths.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

