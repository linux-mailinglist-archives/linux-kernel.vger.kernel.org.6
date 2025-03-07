Return-Path: <linux-kernel+bounces-550715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773EBA56337
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5580170111
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2BF1E1DF7;
	Fri,  7 Mar 2025 09:06:13 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233821E1DE4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338373; cv=none; b=lM/AtO11sjhkzeJzLLxKVVEjYl4CUE6PiJ1AuacY2PVgfxClzQMx9W5x257k6wSQCVtjuzEffBmZIf69GpvCcmbNYR7J+ny5fOmRaKoBDUyDxcxvLkd5p5QsTY2eJvCJ5ridSVgGUYRkgMsZcD1q+fpIlX7iYaXR5zl7wdTxSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338373; c=relaxed/simple;
	bh=Usinp3Vv71ftseygVXDVdGXGchSBm7AbtOVar0HozIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXEVsJNNSlaJqfcIWQIK3UPjHw679ufqZxf9at8gwt1ULHyNLlnK5B4Y/bPX7ik1jo5Ij3S+ECE6BhKAqEGkLHYhf0Ic+wMtahCdAKGkEYdQHXXprGHPlbacjozJIZLmLwIirgVdymnsdnHjqjvEiaMMaSHh2gqQmeoBWZKwtCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523edc385caso32781e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338369; x=1741943169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkUXMSJvOwmGZQyXBBi/6A7NZy9K7YXmgUeePpOLV9c=;
        b=VJHt1FaZeyZ10uZlU8ZJP5H/SSL6cf6Me9z2o8P+gcnUYtPnHNK9h8HeJqTkwPtVwB
         HmEO0Wydg63iCuYDrvOFdWl3kOaR3WOiRxiLlTGnggrS4MFOatYf4Aj7/0xryhPxi6Vk
         CPgaJMVPPTwgpIDxCBAcCfjyfOxDYeqyVObcLRji7M3gv/QWQyavtjBtLnmyPf3kUbQp
         eZUeSdtJUCZkrSoavo+/uoWFK7q9e5FS6R0ShcX/VJ0VfL6AjDZUPKVK1daYWcFJS0RW
         mP+uBGNflGrUV5CDby6aUPcHtzea+G8sDE3/uRmlod+H0xAPjvjHve5S6wMUyMPJTV74
         eLRQ==
X-Gm-Message-State: AOJu0YxPrgFBiFQ2mKe5dnwcTaP+qS57pJtr5drXYC1fghd9rKc9U4D8
	PY9fIe661xsNumyHlM4wCnoK42m1IxKYIyS+K7vEACzlMTpMTtEbV11m5fMV0Fk=
X-Gm-Gg: ASbGncthxprpV5ANoUPrEFzi+3LPJ6e7oyLDea+kFDFrKSAzZW9Ps+jyNYavmsqjuD9
	cVfxJWawa2TvFqbQMa+oAQb/Fnv/R+0lzz98KehTjl+GkaGSneQo/ahbbnWAM8LXKXMbe1LWqb1
	XsiX0+43J1LYlCR3Oo+f4WGDa66DAopKZOeIOJP0UAqP2ItzKWSyzV1JeJeJyWfoMKmj8HJ5h/2
	HQpm213A/lMBIvnQwCy+wFiCNFUfkwgBS0ilYNwR4j7IULLhYoMUYAa3Hw/Kx5x/lg/1i/kHxge
	a1MDL5Qdmy6jebbOxjDWmFNDXw5lkjdcV+a6qd53C7CeqOG9A2FPGefiQbs/qYZe9eUjaqxCf4o
	vCYp22Z2QGxk=
X-Google-Smtp-Source: AGHT+IEEz0G+eV+1WS2stPkdZQiVLb3H9JDudoIktWev5mZ5LbfqP3yBwnBlMxchkWYjv+f59o7JNw==
X-Received: by 2002:a05:6122:2011:b0:520:3987:ce0b with SMTP id 71dfb90a1353d-523e3ff3203mr2263090e0c.2.1741338369313;
        Fri, 07 Mar 2025 01:06:09 -0800 (PST)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8a85398sm458530e0c.2.2025.03.07.01.06.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:06:09 -0800 (PST)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51f22008544so640186e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:06:08 -0800 (PST)
X-Received: by 2002:a05:6102:374d:b0:4bb:c4ff:5cb9 with SMTP id
 ada2fe7eead31-4c30a600073mr1320520137.15.1741338368516; Fri, 07 Mar 2025
 01:06:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com> <20250224173010.219024-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250224173010.219024-6-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 10:05:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=hfoKZkCtByCb13XaO4vKkk5LBx83ei=ac2CUKWJPjg@mail.gmail.com>
X-Gm-Features: AQ5f1JqoUsuDVXq0KTv6t47xqnC_4oRX8WNeehLTaNafGwNOdmYJoV-tJv6Umag
Message-ID: <CAMuHMdW=hfoKZkCtByCb13XaO4vKkk5LBx83ei=ac2CUKWJPjg@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] auxdisplay: panel: Make use of hd44780_common_free()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Willy Tarreau <willy@haproxy.com>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Use the symmetrical API to free the common resources.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Perhaps fold this into [PATCH v1 3/7]?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

