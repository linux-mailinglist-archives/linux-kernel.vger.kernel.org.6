Return-Path: <linux-kernel+bounces-549505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA2AA55353
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839743B1E34
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9737F25CC69;
	Thu,  6 Mar 2025 17:44:51 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D3225BACB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283091; cv=none; b=RC7rQqUP0+SDjz5l77Aak47VrD1122j8+rRheJZaghVcp9xQaS/RZsHasWe7rJHKwPoJ6hY7b8O9LTk9YxRz+qa+aAkUML+i5DetsDjRqpjGkqzKLYBUwNCJu+7oNiEiWApRm5t6X+0ExSGgxrBkXsFt3ZROL1n5xx934OQBcqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283091; c=relaxed/simple;
	bh=QJmXhhJ268S5pczIrEFQ2Jqo3REkMiMrSCn11pdmkFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c166sgXkEnZUvif4aZaYeL0FgAw+bzprYm+ceMNQQFoGoGb3kRqiHgHSW2uTpjJm+sQxiaXUVz681thLzdUCvs+J8BIiopufJI1j6UidokZz2B2/Q2PinQIJq1DyxGFyP4gi//Gt7J6qF7YL0dOBSFKaVehiTjVgniHhDTSKSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86b6be2c480so349206241.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741283087; x=1741887887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6UG0BoDjq+wII57XehpuikrAnqg7CYhLzQIRn+82n4=;
        b=DrNFy8NtFRAitf05GjZkSDH3FiNqm+n3hI7PmLWanoLmLY3IpP27z9TYOJRO9yY+hg
         QPnxQN0eRkV2Kz2U7obz6aiTOPdLjcdUCynjEepVKg657C8ty0tk/rl9wNGNXva+I7F2
         bm/HX2WWwk6pADacvHHWchqFlCqAxXDTpFS3R5aYivqwHi6WJBcs5aNFgTyVaD5mfgl0
         u3p/vW8Xa9NOlFuQojX3aC8T54mpKoV2EWhu/XeJR8XwDGbx9yI1xR1SFYtGNhk+vZjW
         Y/Zgg5NjNDCnPU35iK8S3fTmhWmM0JTCuQEUtx0KG74b2OkyyYvdezRGyNX5cij6CYAz
         mH8A==
X-Forwarded-Encrypted: i=1; AJvYcCXv87djEpNgod32meAgKl5E54vtKrD+zU+fDNPAxt+DE5oPP3ZgPLvkI9N+cmHdb2tdvhK1SAWzIeoz46c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZVziBp784mYtXKprh63FTPbQz+zoxOdHq8oj8Q+8YVSVtus2
	PYb4Z2F5eLCk6SA0YOH8vm6qhTMzObBL5MEblPnbEfeMmRHQfwCfSFVItY2LhZo=
X-Gm-Gg: ASbGnctm2LTXVGlqlTV6iZU7vg/K1Li8mcUPEAzFodE7RGyk0AJ7pFg0s/dWNfstMYm
	1BoGbohTa7dUvBhbiIDet83WAc3jHCoQffuzGCovBeP4sRLvvU/IdAtmRP9LeU1eDcXOmvgdG+R
	x19HLshQo9g5h4CznAgN8NxTLS/TuulCP3ITd2bLuxFW7KcMy9zogBZTPaR+/b3k1hIUgs1/2g7
	HR9sfQKFCn3SWWJoXK34RYdiUKiKvwg+ovn+XxCPxGMcD+j3y+0lZDJSTn4Irmygf7XEUqeESlE
	N8sCGY1Ui7I8yjL5/lT5qDc12DgLxd4vukomsx42P8o1NwIDYr9AG9qV3e5w98jmh/jhGKy8a7v
	pV5Dn/jw=
X-Google-Smtp-Source: AGHT+IEDjz+bPuTHsOtvfnd4XdAAKgI7/82HWFFF5sFw1OL/4nw3NYQcmS5PWC1D1M7GPhLqBgkQLA==
X-Received: by 2002:a05:6102:15a4:b0:4c1:b339:e4f with SMTP id ada2fe7eead31-4c2e2744b1emr6174890137.4.1741283087201;
        Thu, 06 Mar 2025 09:44:47 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33be0875sm289047241.10.2025.03.06.09.44.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 09:44:46 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86c29c0acdfso410387241.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:44:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXz2to1A1osseYkUZ08t17yq83p7ZxHy7MUlQVrl2Ya3ZoTLK1+UQXXqMzjleCwK52uwqPxE0ZZcXV4kj0=@vger.kernel.org
X-Received: by 2002:a05:6102:38c7:b0:4c1:a448:ac7d with SMTP id
 ada2fe7eead31-4c2e27b3179mr5846045137.10.1741283086657; Thu, 06 Mar 2025
 09:44:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302230532.245884-2-thorsten.blum@linux.dev>
In-Reply-To: <20250302230532.245884-2-thorsten.blum@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Mar 2025 18:44:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com>
X-Gm-Features: AQ5f1Jq7R80tfvK5LT7usBpSLmMBfHezUmZK5I3xKCRPWw4P2MZ3-jt2tl-G-PQ
Message-ID: <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com>
Subject: Re: [PATCH] m68k: mm: Remove size argument when calling strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 00:07, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> The size parameter of strscpy() is optional and specifying the size of
> the destination buffer is unnecessary. Remove it to simplify the code.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.15.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

