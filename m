Return-Path: <linux-kernel+bounces-233226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5391B486
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC8A283238
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAF710A0A;
	Fri, 28 Jun 2024 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="egwdW+db"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C8CDDBD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536898; cv=none; b=g7lt7HGUmAG90b1RGipGCVtdOhrnYSLi9lgTfxnhKbm2HyUcgnOBKDUwHslx4nvwuzkgR/Ncp1NKcrP07WpeI/bc8y7dPFWJAq4gbEa7rzRNfjh6ufcku7EH09JPbEEI8CE+2jgC6fMz58yIa4ThaCcwnRz3zj6/HGmOjNpR3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536898; c=relaxed/simple;
	bh=VLCVuH+TgQTouKRhnEi8003sNMdanj8ij8JQnMaL3OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQAHzpndt7Q9n0Fc+2CoUetYab0BfjP2jBciv2GppHuS9zMyRHMSAuaB3IFgtZjWAqsqW5SQgqy1lPY6D5c5tJfGeaGXmEz5AKw6GrGZmgwlUkaqFUcX/KrxIbj+qug5/ERGs9KX9neW3E/Lqbd4mdA8EqdtoY69DiDKxoRtmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=egwdW+db; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f6a837e9a3so239335ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719536896; x=1720141696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a2utnmsw1xb4DBsUqmmJwnVko+nFbfKDW1nfGRRIJcA=;
        b=egwdW+dbE8OjWIYbr+1bUPnJ4Sc5ojXoRx95GrIMOQO12SXoN2sjHgBcTV6tqkhkfD
         5spZTZZL//3q+MqdHwNOY3EqXSUyqVLyjSS/M17Kd45Bxl4v9NJy5+cqut0ENOHt5+jv
         9Fr37WNlilQRhhr2lqtf4YzkIoI6+sJJtvUjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536896; x=1720141696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2utnmsw1xb4DBsUqmmJwnVko+nFbfKDW1nfGRRIJcA=;
        b=LGvYGrAYQbUUm+1kAD5pjsnF2ApipVY/rkJr/3ICapGZY34Ce6A+XxYK4nePnieiP+
         YfdDs8K4NC0ssyr8fnZQeV6Z0AMssoNtF8YdZ9N7Wd7G3b5iRgVVum9T4cGrNnknDRet
         vGlALFt5uSn58S27eX/HtyBRobRR7zyqS8TI9vCBc5HjcVY7tIvQOodmwhwHAd+6wTku
         fUJGcIwH5X+RtNCDHJYdGfhHLV67b+WWL2/vC/34PPpgumBhZkV3+fHHt8OCIGi6bPj9
         enTVPcHjLnd8UZKvHYAMB/tPkHWL/hBMvSjCBCQBZyysrWVjLeT/F9Zw3ircvmBRbYlg
         sEww==
X-Forwarded-Encrypted: i=1; AJvYcCUoLVPC3LahUlI1E1c/6+aTnZu105jiZA4zIjFKsEje3uwjDiNe7r8P9RRpobfiRQEmwlRlItVG/1UVin7QrRv2JMBQcdI/tCHThnm+
X-Gm-Message-State: AOJu0YyCLu+UYPKycJ1c2kYeU0cAbt0V/AftHz3GDBnvXoRxtziI0FQv
	mV3badrGW/RXx96iFft3YOCLMOh7M2uDZofyBByKusFqKbHMzYt6ZyNcp07+8w==
X-Google-Smtp-Source: AGHT+IGwkepPg18peE3iKJtzQXjCutZ85rLoUEu++EzilFhy0HLWBnKs2pOQG8bChfgfC3yiuZlNpw==
X-Received: by 2002:a17:903:230e:b0:1f9:f018:6973 with SMTP id d9443c01a7336-1fa240822c2mr154709215ad.51.1719536896549;
        Thu, 27 Jun 2024 18:08:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:c19a:b9a8:4bd1:72c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159ac64sm3802795ad.295.2024.06.27.18.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:08:16 -0700 (PDT)
Date: Fri, 28 Jun 2024 10:08:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: minchan@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
Message-ID: <20240628010812.GD15925@google.com>
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
 <20240628005523.GC15925@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628005523.GC15925@google.com>

On (24/06/28 09:55), Sergey Senozhatsky wrote:
> We can land this patch, if you insist/prefer, but it's some sort of
> a NOOP, essentially (in a sense that it has no visible effects).

Forgot to mention, sorry.  If we land this then I'll ask for a different
commit message.  "Fix" sounds alarming.  It would be better to say something
like "keep that stat counter accurate, but RATIO_O is never used anywhere".

