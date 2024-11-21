Return-Path: <linux-kernel+bounces-417045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC729D4E39
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E291F2316E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F0F1D9A6D;
	Thu, 21 Nov 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROXAOxvk"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554F1D932F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197743; cv=none; b=oak2VPmLplqX+CNmiGo3/Txyp8CrxWLGrORTdXOntU0vsQ3jZEiqH+m7BNWEzjANLg3kIJ3XCkBVxP3fYbuSdhODNdrp9UH0uqhpzGOcx0NelaaQ9T0eRK707WkUaqiP6z48/V5UuqjO0Gm0FVkKD3xkOaZBqGYJGqICWJFODec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197743; c=relaxed/simple;
	bh=5Oh/o/XpH8bZVGM+tUQ6gST6nT2DOSuTqrYyQ8HuFRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roDMmv8Eax+dVGJ62wLHpsixS8qHRubVpqqarNQ2/qkEW6HzBRKKA8228FS5boFb2Gm0082xNq15NWNjHShqdUtSdikcOgxxbPU+uWDYQNgW6nlHyirArFN280eJlhsNyb5iksGq/CA82RBHWlIvirf86l6/Xb1Vjon7Ggpl1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ROXAOxvk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so688089f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 06:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732197739; x=1732802539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAE+A77cEW+RSvRAmSY+g8z45cph7MbMcujqpsZd4q4=;
        b=ROXAOxvkFT7Ajg2S9YS9Aa2yxi5pL/q17/Q1QDXT4urcjz5u0UtrDg4gTxWrDXha66
         TnG+zW85YMKOtdeKLMurHP2/c57ieofm1VWzyc+hIME5RfLUCRLnFRQ8HPGRT19RZI8B
         i9UvRo6WBg6fKtQZP52NHivoDK3C615Hd3JWYPEudBd4q2+jN4BBzXnHw8WOZNDTF1M3
         PMGzeLFsnvOHOuAY3jSDn5WTNDm9JzCIo02tL3yf8N+Gj9rzdUfQ2CGUo9LgEKgkZ6j/
         8/LNbQ4J+3eX5Zi+5m89/3TZaEwdR0jlvXf2SA79APk5KupMiT63p2vZ/FcrKhH0ztHE
         WZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197739; x=1732802539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAE+A77cEW+RSvRAmSY+g8z45cph7MbMcujqpsZd4q4=;
        b=KsBQ/kyQSOV3TseJahfB4fsdbuRjJ+1iUsKQR0yVi9PQDas2UEWcbgLA01aocU5EM1
         xKa7ezdHoAzhS8bo5lEFlTkF2qS/0fhY9MjPmLpbSFIjjJxTPLycOJliLXDdNxSB9xfF
         79ocq+mid0wCbqnW+u5eP+Bgxtc3bQbF1BGx6vwRRlzaa+guemliURDp+qEJXY4BEKvA
         XXraRz1bx4e7dFJ/dKmWkPcunMFUSd1Kt6nYvnvQJxP+jjqSgin+JRddFT+tfVblYRGB
         2KQAD1W81ZxoEuCRLkNrP0PEyBxbanA+2Vah4rtqrHC5wrAEE3lyauttPh1E3Bk/eblL
         yJQw==
X-Forwarded-Encrypted: i=1; AJvYcCU8xyEfDmagMT5aoiqF7alQf9ZmgrIsBDY4qDYb9rc6onzPVZhs81/T3D19gXq8l8G/59JcC4+VYsUD/Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8stoyhbSZXjfUpzbQfQ/FQUGfLKdNoZFEyjuGW3LgQ/dNemC
	Za5/lFmzeS9/0ViXer9v36QOvy4E8JcjrGhbjWVJxXRGs/PNCGqCPhv4zBQ3Hf8=
X-Gm-Gg: ASbGncurPVe3BBm5kTUNXoGqyWGhhJhFRpHkyzEjlHwtV+2YxK43X+bsqLDP+bsi1T3
	48pfZR3DlEGCfJ0YQGumOYrHT6e7TMecBtTrarox2UiAfSXfK/7DBctfz46FuXmy8argnoBtEqe
	Oq5sf/L3m3EKmlOB1T35slVkmcP3u64HOT1KnLtT9G3VR8WHBt8eP6Wrn4XO+ThYIhpoTMf3mz0
	/GdHJE1mxbZor50w8MmQSXl/oGrdr28pT9DquA8cn1aNuPcI5EQqjo=
X-Google-Smtp-Source: AGHT+IGXHHsC3lb110ltSt3NkQeKjUO+qIDnI9Se0KIThUXBQ1o/5uVK01vMM3fGteaPzmjmgPzfgQ==
X-Received: by 2002:a5d:64cb:0:b0:382:4c57:c415 with SMTP id ffacd0b85a97d-38254b20bc9mr5002355f8f.56.1732197737685;
        Thu, 21 Nov 2024 06:02:17 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493f36fsm5104693f8f.97.2024.11.21.06.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:02:16 -0800 (PST)
Date: Thu, 21 Nov 2024 17:02:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com,
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Satha Rao <skoteshwar@marvell.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
Message-ID: <2d7c846c-31fa-4f63-984e-d46670c1dfed@stanley.mountain>
References: <20241121134002.990285-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121134002.990285-1-sthotton@marvell.com>

On Thu, Nov 21, 2024 at 07:09:43PM +0530, Shijith Thotton wrote:
> Updated the driver to utilize all the MSI-X interrupt vectors supported
> by each OCTEON endpoint VF, instead of relying on a single vector.
> Enabling more interrupts allows packets from multiple rings to be
> distributed across multiple cores, improving parallelism and
> performance.
> 
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
> v1:
> - https://lore.kernel.org/virtualization/20241120070508.789508-1-sthotton@marvell.com
> 
> Changes in v2:
> - Handle reset getting called twice.
> - Use devm_kcalloc to allocate irq array.
> - IRQ is never zero. Adjusted code accordingly.
> 

Thanks.  That takes care of all the issues that I saw so I'm okay with this now,
but I'm not a domain expert.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


