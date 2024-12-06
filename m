Return-Path: <linux-kernel+bounces-434533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EC89E67F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCD018853AC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A60225D6;
	Fri,  6 Dec 2024 07:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkwOtMcv"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F541D63C4
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470211; cv=none; b=I0PpdKHSblgDqe/eXVY2S14ueeiajsQvoxmKAQBgSBPoIkvDaVtg+faoo9fjmHHWl30uuGoZgDnVwKfIGsWpXyK7FQFQkzdKV0K1BX4Q6OF+yMUvAqbWpCuo3vwVop2QYMk7IA5zAA7LuIujpbkSSWvMaVadDqSrULq2BZR5tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470211; c=relaxed/simple;
	bh=sgzM5IoI7p3S3EB4CvffyxidkciOZwqKaaQjcxJhl18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=keFcrjJNVw57CL5zT9M86hs99jGuZwHBaJAVNyIkH3Tk+zDnFMcaCzGwTfRTaTNB78kBr/upr3LkE6SimDl8ZFStOUI4wk5Ur/2lodf8eX6BwZKrWkvRJ5kDZoaDAkOD16sOE3yYWjhaVqhaGq2TDix5X81rzDrEQjvRujaIjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkwOtMcv; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea8de14848so1355452a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 23:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733470209; x=1734075009; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wEwq24c5z2zaEdnRWFeQ2NmKzmhnGWd1lmeDNbRELm8=;
        b=GkwOtMcvUQP9hXwkXXwD6eaqWpu1z2lzEH8htGeKMMZ9sqeu28uzGY/Cec0VUDONVm
         6k8lC41QBFJYWrq3XSXNLLAUqdoA32ZP1yIlj+4+QqS1yBxjcpyG5EyeRwGsj7jQum16
         /MpyqElRxCuTgmGjTlA5SQqC2ogWR9oz/ovnPbXoyDt2KNjKvYQriQMGFOx11nvdHqtx
         UAQ9QmEbayH9suup4BHjgknppv5gQYh4qwpyFyhH/KOweMgOnOMnLGxVbfLO/Ea+jmXs
         3hBdIHh3tCxEqZj48TTDGR2Qmz3ve8WS9gP9ZQWv5yRbG7BdIlY9YIJEKbnqMxUj6OJZ
         NWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733470209; x=1734075009;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEwq24c5z2zaEdnRWFeQ2NmKzmhnGWd1lmeDNbRELm8=;
        b=E6U0y3/43GNFt9YtwQvt0tHcpJ0ycyJ2G2EtgGGDazVx/aBej2bqIsaDayViiDAqs+
         K8fMWNqcge7ndEb1kq2mKBxFezvP0T5KZSjy6F2C9BcoPhaTDjflU+XINKz8AkidzJAP
         zchJTYE/4ipPp3EjOGNlPV+omu//yz02S9O3LtaCGFNa2ddjGJFTOU8oE8Gc1589rwdB
         zaH1XdU9lBpyeKE4XQTYgFhKGQeTc1c12JoTIL36UhE6Z1sToTTLWoqKkW3qIPOi7mTH
         WXtiY0qfNtIj7cdPYj0/j7E8UqFn5hAVi+K9NdkGud2ZGUNW/BaFiCoy5c4MZ2HCpkL2
         StMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO0NwvytE4Q+Vw/GNW0KaI2W9U/upkrA7lwvMh6RvFJn6oChxuMTN9davqXNzeJsRiNE2PyU3QZPrbfB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2rgT7mo9d5522qxqwI89vjRpw5nXmInDu+VPTsImTKdAtExP
	91/8+xSbcseoDL/10aFRcsp0ooav5TZWNsVN45xCtkDmvmWsM7ga
X-Gm-Gg: ASbGncteqLdqDVAcsIFRVdG296oPKvkSTjTaCQpUiUQIOjSr6f2a3x3FJjUVQmKd5EA
	mjkMd/+1zqD8SCfdZBEdkoNnc4EIroUaS3IG6/FyxDaBB4Ladk7G0/b1ajMu3uXMoAgiplca3mz
	koMFbuv34c41P6syYh8nU2or8TFKYXYMCjREbi5QWjBu3Lj3BQDlOdQsdzsVNg/lqUX08QVPu2i
	cgX/9w1TsIrANRhbc6R4AiYfd0Bs7wxdpMApCGTbgAdy3sFHt8cO0G0j90=
X-Google-Smtp-Source: AGHT+IH+njD1GiGGJ2Q6P5lfX4e5GYPFZl7ibqMyTBSEmw+vZH087F6xk1eyQXRyIDerdLBmszLCWg==
X-Received: by 2002:a05:6a21:6f01:b0:1e0:d934:6189 with SMTP id adf61e73a8af0-1e1871234bdmr4369991637.31.1733470209288;
        Thu, 05 Dec 2024 23:30:09 -0800 (PST)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5f27sm2358899b3a.11.2024.12.05.23.30.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2024 23:30:08 -0800 (PST)
From: MengEn Sun <mengensun88@gmail.com>
X-Google-Original-From: MengEn Sun <mengensun@tencent.com>
To: visitorckw@gmail.com
Cc: akpm@linux-foundation.org,
	avagin@google.com,
	joel.granados@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@weissschuh.net,
	mengensun88@gmail.com,
	mengensun@tencent.com
Subject: Re: ucounts: Move kfree() out of critical zone protected by ucounts_lock
Date: Fri,  6 Dec 2024 15:30:07 +0800
Message-Id: <1733470207-23473-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <Z1KR55ggLyTzPys/@visitorckw-System-Product-Name>
References: <Z1KR55ggLyTzPys/@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Kuan Wei

On Fri, 6 Dec 2024 13:55:51 +0800 visitorckw@gmail.com wrote:
> Hi MengEn,
> 
> On Fri, Dec 06, 2024 at 12:13:47PM +0800, mengensun88@gmail.com wrote:
> > From: MengEn Sun <mengensun@tencent.com>
> > 
> > Although kfree is a non-sleep function, it is possible to enter a
> > long chain of calls probabilistically, so it looks better to move
> > kfree from alloc_ucounts() out of the critical zone of ucounts_lock.
> > 
> > Reviewed-by: YueHong Wu <yuehongwu@tencent.com>
> > Signed-off-by: MengEn Sun <mengensun@tencent.com>
> > ---
> >  kernel/ucount.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> It's a common convention to prefix your subject line with [PATCH] to
> let others know it's a patch. Additionally, when resending a patch
> without changes, consider adding RESEND to the subject line, e.g.,
> [PATCH RESEND] ucounts: Move kfree() out of critical zone protected by
> ucounts_lock.

Thank you very much for your reply. I will make some changes here.

> 
> See: https://www.kernel.org/doc/html/v6.12/process/submitting-patches.html#include-patch-in-the-subject

I will study this document carefully.

> 
> Regards,
> Kuan-Wei

Regards,
Meng En

