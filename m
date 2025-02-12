Return-Path: <linux-kernel+bounces-511134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA9BA32662
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB49C168F11
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB420CCF5;
	Wed, 12 Feb 2025 12:57:52 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAC2271824;
	Wed, 12 Feb 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365071; cv=none; b=uZFDGlHOA5e9t8HUWf4NU6PrQUQ5gT1ti2cgMqaITjNFzLIAcTKYRBjBG//KAqU8YE+uX2oOBMAmKQrC2/vy3XqC/xF4EmUvloVbmZ0i1Ys1dCj6jI4Nu/EuPbe899f45oO0WsJMswcLfr+n9FlJf2nmsv6r8nnDrnl9QPnUyNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365071; c=relaxed/simple;
	bh=1fQJ9/QoaiCE3XRCo0rze42eHMuZ87wHTMYWXy0JzSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEJryDGqUyp0UTiULYNLLpGSxmcwxuZ/eEbN0cFg+ay7VO2j3Wr5sSLSnpJev1rihWW9tsD/Ybo70TuhELyDYUFpQq4tfnxCrTEGghduUXJMk0Qse31Oz4j3snC0JLcO9Hl8njH45WeoPF6lhRkxFUOBcb1Jo5dO/9L1++M9ZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1256650766b.3;
        Wed, 12 Feb 2025 04:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739365067; x=1739969867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+omTqBzUILm+6CyB0Br0bTGYlVV+kHRwXXStam8eq0=;
        b=FidvBiEo5R2x9KaabmY/XnkLcnSV8/sESRkB33QTHuMKNvozdIGrahxDbmKbs1ER1r
         opi3zt6CelV2EiylSQsbXYY0/wyrDLefJ38JFBGe48+Y9GaHLuXjmxlEtgIo29Fvhv3T
         458AE+TA7Fi7RhGJ7U9VXVYw1TXBdYZU98OuBwNDlvCsIyMHCAmRltFBOzGq87NTarqC
         cFOLK00+Et9HGLSFowSrBi5TJQT7dhEMv6oAlAyqYmFrH20MonMlP5Gvb/gw4Zymol2n
         4KTEZ2jZqFFcvfTlEVHahQD8OQEWAZh4ezJZuIF1wAfIjCXPFW2dAa//P7FYnVMPpyW0
         NA0g==
X-Forwarded-Encrypted: i=1; AJvYcCVUAFo/3YKRCli/px2AvsA2s9JiQBaPg4HDMq8Y9va0KZjH3zs9ctadXIUAHqvd+NxLlT9LTL5TYD0u68k8@vger.kernel.org, AJvYcCXP0o20to/rUW0AZvHN9oKfLqUdIE4F8QBtsDdSZvtFKGSiLFygtaA3zZhO4lICKi1dY9O6klrH5kLvog==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzekzaZff2I0zkvL1Xr2TEg9TQQ1XihW6ekapI6g5sFOktX9yo
	zMUior+58MIHwEYB7QPNLSjVj9W0YELV7FYMTTm9CPkXcRQ/PPjq7A6rxIjAJOY=
X-Gm-Gg: ASbGncsiHJOppVbRZzxZEI2EIhN8dTAKzUov6MA0ppKSS3UtpfaAA58hwjUhruWhnQc
	Eez53XQAM0uxTL0tc1Xl16lcj3AIaE0snVioyj4eJuvUbwveRYa7V48IeLRNH2EimzoKznwar6E
	MZ+3/cgeaqoEGhqo36bxVsTWbtzjHMXgRGKH/VSw8LCehTh0rvyMybpdsUr0SBFdAlhbr+qoUTL
	HJootsUyksS9JpHVY5rHS5vJRYX+UQsGoSR9aqg2jW5vOyF5ML31n7VHj6ccEhZbk52xCzsigkx
	rkad6rHNlJtV95dhFtof8jrFIrm79wOfB93wMddFMXK+mqKzsA7OFQ==
X-Google-Smtp-Source: AGHT+IGOq9ERUslcLV2yMahTl/DW/mD3ioaQPVufgDYepNMLUztCai413N2H0Ft4q8c8y+OxwSQcNA==
X-Received: by 2002:a17:907:6e8c:b0:ab7:d59c:41d0 with SMTP id a640c23a62f3a-ab7f3381283mr263332366b.20.1739365066844;
        Wed, 12 Feb 2025 04:57:46 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7ced6fe0dsm487000166b.179.2025.02.12.04.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 04:57:44 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de4f4b0e31so8755516a12.0;
        Wed, 12 Feb 2025 04:57:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUha9wqxpDdqoRtSt1h/RsL8rue6fblttCjQV4LpyPj85ihvAA/SrbB1s+4zJ1byEqNdl0i22USGNgAvi1B@vger.kernel.org, AJvYcCXlvvqtP5oTAaqM4DKbd+Ww/Ztyby+0VfgXNg4JSlsqSzdfs15n5SkEYaNXW+42ixFAdo+YMwvxMiJ7lQ==@vger.kernel.org
X-Received: by 2002:a05:6402:34d2:b0:5d3:cff5:634f with SMTP id
 4fb4d7f45d1cf-5deadde6002mr2835112a12.24.1739365063427; Wed, 12 Feb 2025
 04:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212111449.3675-2-thorsten.blum@linux.dev>
In-Reply-To: <20250212111449.3675-2-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Feb 2025 13:57:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSaRCQMePxnfP7EdMUf4PU9ZCC09NsyHUSjhhXC=eT2A@mail.gmail.com>
X-Gm-Features: AWEUYZnrp1PaU2E7y_Z-ScKjyKKRUdtJyijVggRYIiNip4_87QuBmsShUjRCjAY
Message-ID: <CAMuHMdXSaRCQMePxnfP7EdMUf4PU9ZCC09NsyHUSjhhXC=eT2A@mail.gmail.com>
Subject: Re: [PATCH] alpha: Use str_yes_no() helper in pci_dac_dma_supported()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Guo Weikang <guoweikang.kernel@gmail.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 12:15, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> Remove hard-coded strings by using the str_yes_no() helper function.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Can't test it, though, my UDB died +20y ago...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

