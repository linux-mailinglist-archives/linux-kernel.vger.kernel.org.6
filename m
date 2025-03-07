Return-Path: <linux-kernel+bounces-550714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEB4A56336
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C81D1894F2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC71E1E03;
	Fri,  7 Mar 2025 09:05:56 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F2E1DE3AB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338355; cv=none; b=AM9xITBIuXd0BIyJ0XwaFWvo/rAsysRFLQrQlKTaiosHP90+cCQzcYumHSEQrEb2LOdVSE6XwrVaa6EMmKVyFQwxf8+Di2dFgZ2XMeawrx6McgYVvaJmgrrylHhqOxeH2rGPviJIzGGO2j3NkPELWVYLZhWNzQv+B8+7nhpn/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338355; c=relaxed/simple;
	bh=Usinp3Vv71ftseygVXDVdGXGchSBm7AbtOVar0HozIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYUPOLLqpCLbCcg7KieZUY7kcW7okBrvgwNZSo+PnnSYGEAuXtrBxK2BpoXoOlytdYZbHC1AijMcYGT3XPqRdziDc66Ex4/n3DNZV3wMsYk3pPyrMX6lMsWs1cfg4ZRZPQIfYEm3WKQNgXQxF8mrzRhR2XX6vhUFI4B3QDD3iLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523eb86b31aso82499e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741338351; x=1741943151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkUXMSJvOwmGZQyXBBi/6A7NZy9K7YXmgUeePpOLV9c=;
        b=HX+rdCfgp/+RyTYjGQodNI8i1r4NOApjkg8FHcjNtBVQQjpttbvXtbxcHqGEiGL+gx
         Dhwg00DkY2aj8UtuTkwWsstJyx6viV4gZRDflOmXp6w6wWlpom3rCqw4ULg2OzUQcbF3
         ef6ff7RnlL2I6U9iLOIeMbQMzlhm4BX7M21QG1RZzvaiNkTyeDqxUYwbhKfvSLGcr43J
         DAWBKB4iz3+BFbXqfkMEOQJUQ+QW7s94d1LkINb0rVrgYLGquImGmWeoxfOggeG4eVBh
         YYFMtwEmaGPZpzbD9NHk9HCdEfeZxzpAo3NCYijpPDsfUqnM7si+492/bhMvyBi2dw5b
         CpnA==
X-Gm-Message-State: AOJu0Yx0payiKA90E0OotmmnQzeFNbywUZc66DdeCftQ6lk4vvtL6lth
	i1eWd0ZCbyQZaUCno/I9ukWItjakKrJeMZg6yz8Evi38DmPUHtsAsmT73Pkl594=
X-Gm-Gg: ASbGncuEM4+rslaT5ijf3OAN28dYRgwKw1au4KZgADBZIdWCn+h/A5Ais4V1hWdZF07
	pqs45ivCKidUn8s5o8xq8UuMYMY7m/Y8lIEJE7GksFGHfo2DyeYl2aTaddqh2JDlvcFpdYYPjOV
	Vq0JftCkI117peCUEP+61MJes36nGC3irYti3M+dthAh2bVu3zhHoZstp73fsIV0uqEH9EzPy5T
	74XY9GrX1MwipJjZivnpwGZnIiZ6B7/vEtFMYxCW9La9NLC0N3xt9xrrToSwjIPqlU+x5ecilQm
	az+8a8T2+B/j8PCMdnu7Pjz7Yj6RvgWCorFn+SPDsdx3MF8SAobBL5N5smToR5PC8717HHfYJFy
	8qidB/hSDFuU=
X-Google-Smtp-Source: AGHT+IFTzjieOGmOAJAeUyi1MOGfx/a2acVZVKlaYYUkXy1EJhqRAqAh9T/gLTYw34u5HZNnEXrqBA==
X-Received: by 2002:a05:6122:54b:b0:50b:e9a5:cd7b with SMTP id 71dfb90a1353d-523e4173295mr2201023e0c.9.1741338350906;
        Fri, 07 Mar 2025 01:05:50 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8ac1ebbsm464837e0c.12.2025.03.07.01.05.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 01:05:50 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so20801e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:05:50 -0800 (PST)
X-Received: by 2002:a05:6102:8094:b0:4c1:b3a5:9f4 with SMTP id
 ada2fe7eead31-4c30a5f9769mr1440444137.10.1741338350072; Fri, 07 Mar 2025
 01:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com> <20250224173010.219024-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250224173010.219024-5-andriy.shevchenko@linux.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 10:05:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXEx3tpwOYK3eCRgFyQ=05PLC93Upyasj3Bt29mmhAHrA@mail.gmail.com>
X-Gm-Features: AQ5f1JoZAXu1-O4NjZByIXofYCWwOh8izZUV1gstKAoZoYIIKqX2UIVsH19CzCI
Message-ID: <CAMuHMdXEx3tpwOYK3eCRgFyQ=05PLC93Upyasj3Bt29mmhAHrA@mail.gmail.com>
Subject: Re: [PATCH v1 4/7] auxdisplay: hd44780: Make use of hd44780_common_free()
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

