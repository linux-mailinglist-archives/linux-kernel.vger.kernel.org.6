Return-Path: <linux-kernel+bounces-253246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E71931E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA30EB21967
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347234A24;
	Tue, 16 Jul 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b="keu4idQ9"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475033CA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094278; cv=none; b=SRNiDcHj1TJfJltFj/ND3tKGYcarZx++xpqlyHzyIJX/cILxvHebqxMrj0TTbb6Ibmu5ni7zoFtPekXEePxY30qEpuDsbFuBQVGLITiboFGQCDlH2m/IR1SyIVepiEOduOt8PXqz3yIzZmK3pHbF2p06nyTjBS5caPeCJgpJ/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094278; c=relaxed/simple;
	bh=7zZ9tQnbqTU68C02onBT3UHWbkDPBTNCRLUcaCpM+a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1zuvYq3vLCY1Xk7hBJZYhvh6gQWixhTvr5C5uRLYQqA5Pa4KbPC7Ds3a6gJ5Vaq6FO+UYmNXpFsSDs4RJdnhs4Tp+wr+0m/aZphJXIYcxmmjYhE83WY3Bskv5Tyh4ut7MSJfnYyFBdCzwaRvfZ8YqUZEONC3Uvve1biJeXUsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com; spf=pass smtp.mailfrom=schmorgal.com; dkim=pass (1024-bit key) header.d=schmorgal.com header.i=@schmorgal.com header.b=keu4idQ9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=schmorgal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schmorgal.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-788485dd42cso53961a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 18:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google; t=1721094275; x=1721699075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Qt/SPI9w4Ydlf5F3lgn/F+VMPpJrd+IRMvd2pRUL/U=;
        b=keu4idQ9T+Z07QkZ4+5re0u8GQsxy7WRpX9TM2fEQM/vYP/1svTTnhrEkHY+Q1XBtr
         XJ2A+lzT2deZCaHNXdJ6eMtD9kfakuqGL0fIbUh5yj2WE0WIDVv+7nqWtDVRNPrbxOxA
         RnOiWW44M/HKxM+DiAQkSqbIZ/UTKt13SEVzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721094275; x=1721699075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qt/SPI9w4Ydlf5F3lgn/F+VMPpJrd+IRMvd2pRUL/U=;
        b=VLLH9fBtanXfvZXLdGAejtxtSYizwzE3oiu+oALOgJc+7Bv0GPMT2ly6S9eRXIy7r7
         LuvbROoUMN5ZwL+DWePXu7IRBBKF+DwD2OLxGvWHOwm0WRf74mGzvhSxdjnxJaloFd5z
         6lhYjGWPyXAi2am5jCxonS6zrxwX8v5ti/or7NUESlM/03np9H1lKjdMw5CdZ6AUhgpI
         KHo91yrSp+ZIikCrWGQDZRS/CF6W001BKPb6+uM/QbcjPvHkBRc+xXxsE0gFm7MvvKOe
         3omEtscJNN9MMVAfYLSw+iMAokTfBH+A+EgqD4klNoxtC/3WTwSyOFFR9lj5aFJPstvZ
         l1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX30N+3ww5lfN+iHfU2gqey6jCbnmOrpUG3MiGwZhaPzKVPzAi9cwJz/sfwf3G9vdrjHwwjhczRUuICszVIJwLy6y5AYfrOtyD9FV2U
X-Gm-Message-State: AOJu0YzpQRLBvCTYxI6jpaYIUoZjVAiRtQxu5QPpEzTDWZJC/BYAVxcT
	k85G6Tf8O4wZHTFcyrK70yvNg/2Psa53LsjmA/rSHUyZEGpRJVj9ctvT1ncvpbnO+/CMHATuAMc
	T7YmzgQ==
X-Google-Smtp-Source: AGHT+IHW+WnJXZahgXnwYzOQ47BHvXthzkNIwiv+2EdlxveKcdFOl0yH2UivBrARch0QR2rf9MWqpw==
X-Received: by 2002:a05:6a00:6584:b0:70b:705f:8b12 with SMTP id d2e1a72fcca58-70ba48e76efmr1093813b3a.4.1721094274807;
        Mon, 15 Jul 2024 18:44:34 -0700 (PDT)
Received: from [192.168.1.33] ([50.120.71.169])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c8f2sm5073301b3a.41.2024.07.15.18.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 18:44:34 -0700 (PDT)
Message-ID: <1e7be166-30bf-46ee-b5d3-93def3465b07@schmorgal.com>
Date: Mon, 15 Jul 2024 18:44:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] drm/vmwgfx shows green Xv instead of actual video
 (bisected I think)
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 regressions@lists.linux.dev
References: <bd9cb3c7-90e8-435d-bc28-0e38fee58977@schmorgal.com>
 <CAO6MGtjxnm3Hc=T8jv-upP46XBzAc0ZNmLVF3=KNN8buGBwg1w@mail.gmail.com>
Content-Language: en-US
From: Doug Brown <doug@schmorgal.com>
In-Reply-To: <CAO6MGtjxnm3Hc=T8jv-upP46XBzAc0ZNmLVF3=KNN8buGBwg1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ian,

On 7/15/2024 12:32 PM, Ian Forbes wrote:
> Hi Doug,
> 
> Can you try this patch with 6.10.
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
> index c45b4724e414..e20f64b67b26 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
> @@ -92,7 +92,7 @@ static int vmw_overlay_send_put(struct vmw_private *dev_priv,
>  {
>         struct vmw_escape_video_flush *flush;
>         size_t fifo_size;
> -       bool have_so = (dev_priv->active_display_unit == vmw_du_screen_object);
> +       bool have_so = (dev_priv->active_display_unit != vmw_du_legacy);
>         int i, num_items;
>         SVGAGuestPtr ptr;

I can confirm that this patch fixes the problem for me. Nice! I did have
to manually apply it -- looks like email converted the tabs into spaces.

I don't know if I'm supposed to put tags here for you to include in the
final patch or not, but I'll do it just in case:

Tested-by: Doug Brown <doug@schmorgal.com>

Thanks!
Doug

