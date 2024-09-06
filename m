Return-Path: <linux-kernel+bounces-317983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC296E6B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2311C2325F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59293BE6C;
	Fri,  6 Sep 2024 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IutMm6zO"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1112F32
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725581842; cv=none; b=aqfKLP1YJm8nkxkGktwDj7YkcWWloS/knuv0S4VSD+Kgdx8dutUvdqQEQd1TBb+yQG8TN8po/qbuF7F5kwfZCU/PhhuBWgkCJ+Hxy4oAmzZgGww5UtqGsjpZViu9gjzrE9cp8svkQFe3VXOCAJMPtBREv5+F0bEghdEXkox7+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725581842; c=relaxed/simple;
	bh=NG9BmRA6hMBliXpavQRbROysFPGHOwtBx2R9wnjVQuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDNwDWq1PR6D8FQizAUjPA4READRy3Lo4QpTYw37dL/9+KlJJ5yaNHjoN4NnKXfIPCY4CkIFR5D2N3zlLYACN4fZEUZ57NVtCbKLNsOa88ybtQYGMIxcGmad9MasMFCKA43t87AE61HkIy/9zC2k4kB+0tlWXTc6xOvF4zuEO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IutMm6zO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8696e9bd24so198189166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725581839; x=1726186639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG9BmRA6hMBliXpavQRbROysFPGHOwtBx2R9wnjVQuw=;
        b=IutMm6zOuBiI0ZrpeSDQ4HTfpzL9L5E419NGZaIKxEpTTl9bOff1IA6T6zx0BseCbT
         ufumbeeYii90dBYE2OpmHg08Dsl+P59yfeP55OyB4h41c1JOtk8cYcCutlCm5ABDX3Yq
         /IQ9uSlu9k11/4xaUA2cri8iwuMG8+9dzl0wN1UhnaIRu1viXnK/b/MCMprj84FqTHEF
         Hy7DEBZgMmpfPATsK0W4OYotNzO5swdF/2Hhy3JzlbxRYz3KaDppW1/yPh+dRJh46eDp
         13c4qAOH2zNPj+c1wlnsYnAha+uMrtDfLMkH0k1Vr9mP/gtotjn1BG1DWmdSPsYTyvqJ
         jeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725581839; x=1726186639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG9BmRA6hMBliXpavQRbROysFPGHOwtBx2R9wnjVQuw=;
        b=CfjkeIyKZpz7HwlmgPjvYKTc0h+a4CxDbNoucR2DxqeDNiMhMgIBoXEiYWIWF5IMG/
         VjEi5e5J1dMZS8AORBqesdMp7UH4kIOITRiUCP22bg0whxNP8/ambT6u8CPlvBRyK+5h
         ZuA23rQdrMpdBvfSDSOPLi+1h58sN1xHOeV3wTV5zVxX9WYB+3GVU+WFWMJgmE/HncSD
         1IT9sbSpWYDDHZM0uc6LQYhnqmSePSrdQZKA2oJtEFmhTdGl67gCS3Bmsl0pVu0w13TQ
         Vfd3hY/O22YWTHA8qlNJgxxndZ34XCQ6yQsI7MarrZPxpIfAWujqnNqgNRMdfmSThI4g
         /l8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8s0ziQfsZ9pe48F083Cqh68+bxqm+sxb3KKSetQLHhUerxTbbOTLvLpSRi/V1X3qbcKJyAa0o+a2dmIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRcZpeEHG0FwhIxjA2BP6yVyCOZV1sPHak6e501CKcAp6/C8Wq
	D4A78g8FMS3eFaBDBm8uk8W6yeCfRtY8kfA9SAj2fY125vLE3lvwAnj/fSIg4aBGZ8G0wwMtY2m
	GFIeZTkXaORI3Yy/ZzanT10hU+6qeGsAhb5s=
X-Google-Smtp-Source: AGHT+IH6iGOhY96esUOgnqkha3Im5NDBFCI3MQ/51ohxLt/quz+M5fUyeZSZEDsXTKSS5BJ+8U+V3xQiVG0pxHwj5yY=
X-Received: by 2002:a17:907:1c1b:b0:a8a:78bb:1e2 with SMTP id
 a640c23a62f3a-a8a78bb0272mr274642366b.6.1725581838319; Thu, 05 Sep 2024
 17:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906000314.2368749-1-tjmercier@google.com>
In-Reply-To: <20240906000314.2368749-1-tjmercier@google.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 5 Sep 2024 17:17:06 -0700
Message-ID: <CANDhNCqudbuWM-WG7jiY_KQfgOZ84nAwWUfUHNzgniBiSZzeyA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Add __init to CMA and system heap
 module_init functions
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:03=E2=80=AFPM T.J. Mercier <tjmercier@google.com> =
wrote:
>
> Shrink the kernel .text a bit after successful initialization of the
> heaps.
>
> Signed-off-by: T.J. Mercier <tjmercier@google.com>

Acked-by: John Stultz <jstultz@google.com>

