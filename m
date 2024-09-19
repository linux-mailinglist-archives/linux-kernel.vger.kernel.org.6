Return-Path: <linux-kernel+bounces-333557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE697CAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5AE1F233B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C819F462;
	Thu, 19 Sep 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="enNGW6vu"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8F19D06C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755003; cv=none; b=gh80uIhy1GmCFL9CUr88xB0M2Wvl+WpNmEnjGNcZB9btwKjZ3hI0gFt3fY7zAf4j6/YWRx2s4sM5Y+CFc1gLz6VoriUDnwdzDcS+ZcAsNTikTvN/N6ZnG9gJI1GjmdMsrOImqvO2jGOjMUyS89TYBn1EGIk1ZIFC0iQxkJRDUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755003; c=relaxed/simple;
	bh=gtv+TRjJu/mgasy35X+CMqfM7bhfkKr2QOvQYUlb5ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kb5cUNgHp08IOiM9ugnFspp3wXuao8OlTQ7oBnArpldv+Ty0ViKH41MIPsRju2Lk1ucbLhGHvmSBiPza0uapFMWfGAyV6R0Yw4Z1UeLqyAZYYlpWtm96kOeEPszSlH/CTBcRKVABZg456s8FsLNCAmlkEiqsvBw5Kqvwv2KpetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=enNGW6vu; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c358b725feso5992756d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726755000; x=1727359800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/XwMXPfmGjMXreSyn++r3+CsNg6EihddpKOod/8z7aY=;
        b=enNGW6vu7TYMkPzFZ3AycocosuQnxqPtwjon64vDcPXbPXjosIyZdCRavB0j6nlaAZ
         qtJqbrYW4CKmhB5qgosHyK98NBTtZdzXixuxDqKNcPM+UBLeNlas0WB/o7wth0FAhd50
         z7rw6ojkZlaW1vF3DNLQDNNWqqGmXMnQJIRLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755000; x=1727359800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XwMXPfmGjMXreSyn++r3+CsNg6EihddpKOod/8z7aY=;
        b=TBFT7uVXtDGN/aiJeSnDWwzQyjJKGPLElmGh/mTyEKjMLdNTXwyPpnWC93PE/Lzf8t
         17EQUH9/NLMyMplNPCiGE7xGjsbdff8SauhAGtowyxFsNSXqVm/2meyM/skhta9hYKWy
         U8rwi+OZVaSwK6sLea5A7XlYn/d43MwmeLzGAJCn2dDK7zDUG/pMb2GRCijqtZehQDSE
         +TlvF6Iy69IF2cMNt+FIRbMfMpsqXS1a+WRSfq3Y6mOlMjhzC7djC2eyDTXHrRWbv2fG
         J+S8yjBSH9C1OBkn9aMw8uVu1s7YSrBlHjlSmOoKPffPW1DXeJBNC8XtBbf0omc81r3s
         51cA==
X-Forwarded-Encrypted: i=1; AJvYcCUy5LnaatW6ABYlQW5jwXmaZrMh+QCQjtzm1SevFJtrr2i7cKBMSoX3mYzpo/sCNqv5YEW4oApQw5wA6eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDIslGwLIV9PAPquotu6VWaDK1I/9dB/GuEUD6KPToxuLgpnwP
	ScJaiGiCc4Vut+3v79yDost+6g60iVqnm6uP5bIyWPcZ7k2uviDbx27Rj88ZrXuv6QhkukusFuS
	zYBmKj1LjkFC2n7IBBOl4O45j0MDqDIEis/CZ
X-Google-Smtp-Source: AGHT+IGN47wvtUMqG6TmWurPc+pxLUOHND0JwFncLJ7mtd+cD5z92catn5fTSrBAbwTEd9ZWgQh0ydpyT6J2Ep40BZ4=
X-Received: by 2002:a05:6214:434a:b0:6c5:a3d9:1bc5 with SMTP id
 6a1803df08f44-6c5a3d91d54mr189822696d6.32.1726755000264; Thu, 19 Sep 2024
 07:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com> <20240918152136.3395170-21-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-21-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:48 +0200
Message-ID: <CAFLszThP0ABDm6fV6rBS9Uwc4h9w0k8oijA379cw5XzpbW=nAg@mail.gmail.com>
Subject: Re: [PATCH v4 20/35] arm: gic-v3-its: Implement of_xlate
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
	Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 17:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Translate IRQs by implementing of_xlate() as required by
> irq_get_by_index() to parse interrupt properties.
>
> TEST: Booted on qemu sbsa-ref that has a GICV3.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

