Return-Path: <linux-kernel+bounces-394475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89819BAFAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0E1F22228
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 09:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C71AD3F6;
	Mon,  4 Nov 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnIhb1zK"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CC189F43
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712725; cv=none; b=PZTMq/F48untbOWRZK9RxjRwqY4xKEp8f/lBhXTlS1GyUMEo025oxuODohq5IgJRRoafolgEB+hOrIxhQUSM1/SdxxsZg47TkGcHkMGd/85MFtuqQDDQSS1lQ+xZSN+9Hcyqw2VcUOJDrZmM/e2WgY4ErFwrXTO7Kv7WGPkHpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712725; c=relaxed/simple;
	bh=Zd4qV11Jk9xXewqHJBWt6C2AQwLiXmL4QYVrO7l6gWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRyxZvnwzM2y4puPzRoAjOvDAOp1hpagLnq/9WYO305VL0t/xH56wsOtuOBqlgB5eQMMVrd40mnC10Tzpd834YRvepCXxX5e110o3E41llaRJuF2bnr8mylyzW0tKmZ8trhvh7NYKYpBFWjW/q1PwA03yARD+/FRyX/wFfUCOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnIhb1zK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d518f9abcso2723259f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730712722; x=1731317522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd4qV11Jk9xXewqHJBWt6C2AQwLiXmL4QYVrO7l6gWs=;
        b=TnIhb1zKp6bdaFo3DqOwqBgLkM55xA2r12xXVbzNnGu/8k8R5EQjODfyy6Q5w9CL4N
         DNwRxJQ+88HxxyfynmzHJKFsxcspTrIvVDLOHkg/MKXrw+qIDWbYOfDLZoaFmA4yjcSV
         b36AzaZJHfOoP78NcFP8D35OJFNyDBmrqSsuL0/q5yjw9DcvXncRyUbCqy2c7CYh7fcA
         xOjGmWk0SBrntEkq2ggWDLpE/UhUchBJ0WLIP0hg5mjQ4DYnPPR0dtYB0XJux6PjOpwG
         REhoSjaDsUH+WQAezJaociwVtlbNGes9ilXa+mqdR2KFUW55dfaFcCpyryfGwiqbHDMf
         8MEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730712722; x=1731317522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd4qV11Jk9xXewqHJBWt6C2AQwLiXmL4QYVrO7l6gWs=;
        b=m43hyREuR3WQ+nIvE2AIyHcevZSE1Buz7OGy8pDg0d22v6nwvLVRSVZNM2s6pZ4GoZ
         cjTLGugfmnJGXDnBJJ81YSBHLQ+1+9dE8d4qR529XpKMereQvOGGxnDtUwvTFTxDQ0wJ
         u/tSQ+zzqywcqNQ5EyXh3OXPTcJc+dPgv7uROH0rI8nIGXZtPwZ9ClA6/iBPPX6N2bpO
         pskfsT5mhffKAavWHmC9w6eCTL3FrTM9im2yK9PoCOfWoOe4PKRF/7XydtYb43+GPKDy
         0dyUApFkLAHT3hNvpflEJsVFqbRmJsCxGzJDuKr2NPNTCW552Q4qvryDk1blyuG718wb
         89Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWM0Hfsd1WJhQzeMJSiClg7unv9jQ2c9q0YeQiFkM0a/x1k6mAH7cF+RVwzJNkKJ3RsoMwyJVsdvSAs0IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyGqu6YhjheeCCG9/dxOKNhtd5BRuNguCFEnopxJRJIeAosGng
	0i53ZoIB8XVmIs3SkQbbaSN+I0zgLebA2ksJKfXrU36NjtuFSuu81iwXhNJAnrwwead7laSsjkx
	o+8mHUshI2rE9/EWRFw9hFeUbMf03UwRTa5SW
X-Google-Smtp-Source: AGHT+IGgxxwstMlD8rP6BtbqQAqXim42VUhtM2Svr5NTrUM6RIhgQvhkHKl6VRlqR1gRR7oPbOCGY14lUUmtslJl1S4=
X-Received: by 2002:a5d:614f:0:b0:37d:398f:44f9 with SMTP id
 ffacd0b85a97d-3806115ae92mr21368232f8f.32.1730712721670; Mon, 04 Nov 2024
 01:32:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104090711.3000818-1-abdiel.janulgue@gmail.com> <20241104090711.3000818-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20241104090711.3000818-3-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 4 Nov 2024 10:31:49 +0100
Message-ID: <CAH5fLgisLyW-d9rsHJ8Vp8HpWh7PZxtkXooVQyMTxs445Ah4GQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com, 
	a.hindborg@kernel.org, linux-kernel@vger.kernel.org, dakr@redhat.com, 
	airlied@redhat.com, miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com, 
	Andreas Hindborg <a.hindborg@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 10:07=E2=80=AFAM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
> +/// Abstraction of dma_alloc_coherent
> +///
> +/// # Invariants
> +///
> +/// For the lifetime of an instance of CoherentAllocation, the cpu addre=
ss is a valid pointer
> +/// to an allocated region of consistent memory and we hold a reference =
to the device.
> +pub struct CoherentAllocation<T: Add> {

Requiring `T: Add` is very unusual. Why?

I don't even see any additions anywhere.

Alice

