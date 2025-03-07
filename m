Return-Path: <linux-kernel+bounces-550709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CFDA5632E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5BD3AB496
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A01DF990;
	Fri,  7 Mar 2025 09:04:16 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5271AA1F6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338256; cv=none; b=Eyff8Cki772cTVkgiSgq0gBkqyG+94FUHgqsQrFZNd3C9vFYAA4AXqxCW+K2jYuFydRXhC6G8EgW3kRPbfPKteVMT2XtToTBZ3PH1fRzgoGM+I9JSIhSeAbscdiul3LOHYfCsraZ2W0GmudEbEJSoS4FlLP/SpkZXsw3RwgCMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338256; c=relaxed/simple;
	bh=3aibKpK0ztQ/3cbZKPo24Un4lA2z5U2Yw2wmRqYCVLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAjz1p7/6cKomJzlw0x89Ohrq97g4//AEeghSdsGswQSUd86Ty6w1y0Yg2t0z4Bxv8S2jMUyUfYPwplbdCsceZi8tH3HjagmXeuuBYvcJlusZsdVMBdY2uLU/7z/j7BVRo2y9KSh5kdpyg7mI1ez5j1sLXQcMjh1JagAe/vwMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-523ed8ac2a3so36557e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338252; x=1741943052;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/u9/hy9OczPsgk9L+uEQ6bNzK6rRFnsMPn6AMJ3WKjs=;
        b=C2QMjR3lOC57WJzfOJvvwLIxWl/0oICAt7qguGNjw4sW926lM4fl72I8n5P8eQOmkk
         F9O7Nh7m42OU4lI9JXCHWKvA6F8bfUsQaZf/PkEf2zfXAyKaO1GMWqlySBKn4JfWwna3
         5EIi/4HW7mWRi6Y4K3MgGpp0HPm2RBPZfZUy0NZcZF8mO3W/dqwk1UUaR2P4aI55tA4l
         j0c2OIwXuBplUvvoK7hznTPMlWZvkMjVLQmLnwmQi3ZEewMSSQTEa6v3z28R/CSWx71C
         RLWJLM5CBZZCqnCetTiHxvM/H+78w4F64P4Mli3GED5NBUuKIzKGHmkGOQUSP+fUsPgw
         qsKg==
X-Gm-Message-State: AOJu0YyYgzZVJIkYinBkxNaxnSAAiRE2Y02LtojMFhgN4wL5vMGIinFs
	AsRiu7Dg/BMfIgVEBJl0CRFQ5xH7YXEPbMquIIWkg6MnG37xZzMiroFd64/7VX4=
X-Gm-Gg: ASbGncuHPB6YUyYRU8NP7K0cmhgO568m/bwTlVF4mc3sWOVcK9avFIJqzVh/C1E3fei
	/8ZVAA20HOmBLY75gGdCv3daAJhfrYl7pfiA2IPMoiLu134Tu99LzARMFRtBxz/zkUd+S4mJuN1
	aQ98kXxc9dAiFK0QBqNMQj0M9TFj7tfQW/tfLModLPae/fRd52ylhdWn4o8kn/RKvT+sAo3B+qK
	13hFB0hus9RJ72HqLm+mT24UU5BMlkwJauXD4aeCyIhTHjhW8l725sQzf1wEdep/fDrw3B8jtE4
	bhA0Kz/BC/H+lhMGd44ordHEfO1j87E71ck4HXr6pp2zvnh3qiP1k/rHXJXknpZXbQ568TH6/ok
	U3glHevQ=
X-Google-Smtp-Source: AGHT+IEXjXIwANHyAGegSS9yRBo+GqGmg0zYE2Pk690r9ubColaYTxNLKWMf1Cj2bA4pG0nE9Sq0Tw==
X-Received: by 2002:a05:6122:2011:b0:520:42d3:91aa with SMTP id 71dfb90a1353d-523e3ff118fmr2321531e0c.2.1741338252334;
        Fri, 07 Mar 2025 01:04:12 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8a85320sm465429e0c.8.2025.03.07.01.04.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:04:12 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d3907524cso572874241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:04:11 -0800 (PST)
X-Received: by 2002:a05:6102:2d09:b0:4bb:d062:430 with SMTP id
 ada2fe7eead31-4c30a3459d9mr1658476137.0.1741338251769; Fri, 07 Mar 2025
 01:04:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com> <20250224173010.219024-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250224173010.219024-3-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 10:03:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXO-DMkQdOOJibxyAQJpUDVk3ye770Br_LonT3OJxJvXg@mail.gmail.com>
X-Gm-Features: AQ5f1JomEdquPDNEX65bsuLzznn6oBmAS2ZWOgE8-WrqKw0YHbFspfkdmrhxioI
Message-ID: <CAMuHMdXO-DMkQdOOJibxyAQJpUDVk3ye770Br_LonT3OJxJvXg@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] auxdisplay: lcd2s: Allocate memory for custom data
 in charlcd_alloc()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Willy Tarreau <willy@haproxy.com>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Allocate memory for custom data in charlcd_alloc() instead of doing that
> explicitly in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

