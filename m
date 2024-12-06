Return-Path: <linux-kernel+bounces-434453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233619E6707
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77C1282FE2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0711AC459;
	Fri,  6 Dec 2024 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdJR3ErM"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F23EA9A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464558; cv=none; b=tfbavhmmctyIuioQFjUaUJ5InJ2R7XzkChKGG9k+nbhmKtjaVwif06DHx2FGRZBhehiwjK4nIHqvrV1qwhtJeQRrkvQY/ryqG3ENbYo1bc0+5bXSJ0xM9xKOp/q+zCT1f5d34bpKGlVNbnaWsn25N3BDxMmiaO35+tUt53kMeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464558; c=relaxed/simple;
	bh=pgWWL65jVI36kwBab0GUISAPpJvKRY+wGENUGi+QANc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjMtbLPAWGBESgnzM0BsXlhhJlEMtLPaazTmlawxDGXAkuGQRfINHb8YT2VjWDkIptnYILAZrFK2V064tc9cxymBIJ24Wa0J/C/+kNWiB2TKxgbtECqQiGd3936S6ebK8Ja/F0RYmEbI/bVyGant+kWuz6lK6hdmu528Etj/thc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdJR3ErM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7252fba4de1so1979148b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 21:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733464556; x=1734069356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TpHGbX1MJgd/Oxrh9TT6XakNqJYvIqo0w4BrgRFHBz0=;
        b=QdJR3ErMkgqBwmWyaftN7404AMv+BzStwAV+NgFtmcfx947hwd93B2tx+/3RqdRRnO
         MK6Bq7FyqoLVJFQnIQoHnw0Bdm/+mzt5f0YCrDmK8Vn+RATOAu9EatGsQTz8uYj9YGtr
         ZUbVL+km1RVh2Gh/qMl2HZV2xYZtljofWkR7vzyJ2Qh1TKVFfoSP4qSwGoVu6vsjObp9
         1e6ZkYAxbDi8hsK8R35EAtPRfgKl0SRclsFNTzHohkOI2hxW/oVMtEGTTe4UrevDfr//
         o5PO/Qz2cb233xLaKTZ87hyYEYSSv6IcsznxtjrjudzeazxC8iNpUahxW9g2D/pvC1Dz
         ty0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733464556; x=1734069356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpHGbX1MJgd/Oxrh9TT6XakNqJYvIqo0w4BrgRFHBz0=;
        b=tCdnn7PRJq8KZ6A+jBD14EU5iauExsp4HVzEJ97eM94Y19OZnMisvCq992HUZLg374
         e1nE80omK1VQWau30pKyNRpwFInY9bnfY9ExIiHj9TbWJMKpfwG00LBJplKDSXozAfDr
         0QIpYMTxDZE3tJgvo7Iva3zUpvdOhtgmZRj7CqDV1Vr72V6VIfAjeHfkqYMcDHcxutLq
         ybyPqNHAZi9diiBI4F4gu5j2uyeK9MrCE9CdQyGiVWF1OjHRjQVgvTYQQqCifERx6+Df
         A2+gELV3g/1aX47jbHk2WqHqK9yNNIb1kbTW7hubTQkvSpc0LJRuAWMIsXmOSP3P0tdb
         KXdg==
X-Forwarded-Encrypted: i=1; AJvYcCVe3LMiiuo+f47JvvA56V88YlrN73sRvkUQn54UII6VmzymqnhsbVZqOzEWqdQHpfUEsnwKGEX6Xj1EapA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXtp+Ycp+UfzdpHko3KK4lfpN3U0Ch20q31+SjqfGtBa5e/f1q
	0pSArwA2KKtItlvXXTEnUh61/4pMRb4sa6cm6Wvr9NrqnjMQfBpL
X-Gm-Gg: ASbGncuWfsbITIvNGU2joGH+iDy014gQVcCNZv/+eRKL9TjiEKzyTZN5fEnrG/BGbbd
	Eea0XD8ix7ZsBMgoaQzibYiJ/bv+RxPiA3F6aPhQSk5vs4dB4qI9WjnsCsVWe39S+f1AbnR/DIp
	nkzUoJ6lFDf2Z4YiAsWZv94UBIagBb6+4lj82rhHPc8KjPpmHm360y7mFSzx6+Q5YKq6THdGaZt
	5oTNw0Z63tV/qaUkzHI4fCywHTVa/XoJLMSIFbzIogPd1VvxGxWZqf++4amkMK0N2NDvsBCJE9j
	xg==
X-Google-Smtp-Source: AGHT+IEAmy8/5t22n4fzBYZdQcCM1J+gosoeb7VaG0GizQTDv8JgRqOSjMhaQ88bVLq10HgzzJcPTQ==
X-Received: by 2002:a05:6a00:2196:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-725b8156675mr3486281b3a.13.1733464555852;
        Thu, 05 Dec 2024 21:55:55 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29ca9d1sm2263979b3a.23.2024.12.05.21.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 21:55:55 -0800 (PST)
Date: Fri, 6 Dec 2024 13:55:51 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: mengensun88@gmail.com
Cc: akpm@linux-foundation.org, linux@weissschuh.net,
	joel.granados@kernel.org, avagin@google.com,
	linux-kernel@vger.kernel.org, MengEn Sun <mengensun@tencent.com>
Subject: Re: ucounts: Move kfree() out of critical zone protected by
 ucounts_lock
Message-ID: <Z1KR55ggLyTzPys/@visitorckw-System-Product-Name>
References: <1733458427-11794-1-git-send-email-mengensun@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733458427-11794-1-git-send-email-mengensun@tencent.com>

Hi MengEn,

On Fri, Dec 06, 2024 at 12:13:47PM +0800, mengensun88@gmail.com wrote:
> From: MengEn Sun <mengensun@tencent.com>
> 
> Although kfree is a non-sleep function, it is possible to enter a
> long chain of calls probabilistically, so it looks better to move
> kfree from alloc_ucounts() out of the critical zone of ucounts_lock.
> 
> Reviewed-by: YueHong Wu <yuehongwu@tencent.com>
> Signed-off-by: MengEn Sun <mengensun@tencent.com>
> ---
>  kernel/ucount.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
It's a common convention to prefix your subject line with [PATCH] to
let others know it's a patch. Additionally, when resending a patch
without changes, consider adding RESEND to the subject line, e.g.,
[PATCH RESEND] ucounts: Move kfree() out of critical zone protected by
ucounts_lock.

See: https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html#include-patch-in-the-subject

Regards,
Kuan-Wei

