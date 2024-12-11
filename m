Return-Path: <linux-kernel+bounces-442023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3039ED6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63160282C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC57207A25;
	Wed, 11 Dec 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jg0B22eu"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3C20A5F9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947311; cv=none; b=d1BNSJY8cgyiwwZ7Y2VeG55a4QQeHR/7q03LJ12WYtVWMCU30EZEr7Cq2AFiKplZaA0wsvwy1NArew8mA4Xlyef4+VwsdGtdIOLhNihVWZ4dd6naGegt3OffOikYZg9IqVktieZC5KqaoQjPgR0sSNWaTSbwl9b0O4WyF3XK6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947311; c=relaxed/simple;
	bh=jvNr/mm/KISVeWk0aeIVt8GN7pPxb3OnVWvrYZ/AUP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyveCLdklAMbuhNww2v+aVajcdbuMI9MOcxxopL1pzHWTpRaCf8P9lzAKEKQnt8+71G4hQuRgZqO0KIcBtf/FNVxsXwl5PBsHo0/T9ra6U7E9W5ULfuEwfDCtG9L1PWl5dxwHU4pEmchm7FVWnql16q/lvsntCf3FI8zst8mSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jg0B22eu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so8428245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733947308; x=1734552108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy0r5zhlEBX198RCSafsNFSDYJdvGKEyDvKJy8g2liM=;
        b=jg0B22eumMYUyqOgM/L33WsAEh1yCzGlyoXvB8ii+CcN8jNeZy17LQjq1ChEB9UtpQ
         iDUDTmlZW83nIfTEyWEegc/FkjW4uxZC4K8BfPB0kyymdIGHFq6YHpyiwT4adUEL//ue
         egFRKu4UIYMpI1e0r9EdaKwQ9HsBZz7OumDyEpiETh5SXUJnMAK+2TpRmtUy+gtPJMcK
         E4C7RI3C9c+4PwLeO0ttxfS2tWIFETsSDQ/I++FsrFkSRAjCQz3Tzu9Eo0dD7QE6IvQK
         4p965UAJ9T6DubtazY28+1uoEcJTSby8vEBm4Oq6ULYd8WvSEUyCbHT2VsMlJoz1zl8U
         bs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947308; x=1734552108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy0r5zhlEBX198RCSafsNFSDYJdvGKEyDvKJy8g2liM=;
        b=CLDRnh4h0bffLy8XywBQiJDniMdjbQfnVR1V/a2KD8qHciyGHbljZ0NmTIOTb31ZB2
         ySp8pPHVjHaJp/OuihWgFQgEtxLY6jDaIqGiZMztPjZC2uReDRlJbxtilQN4YrhhJf6h
         Il1apxus0zDa18SD1dOxeIrHvXw1jlbboJWgK5KH5p97OFLJdqYyjL0UQDvdk6Wl5ggi
         N4sVbuPAswWZpnJPhEKCFhxxoydu3MTtuHF5WmTdKI2wZYobrzwSJFCtREZrjMXb5lm1
         fsnWKLLi+9Q0VB5P8G7dC4DfIgJGI0RrTJCow1RTPm0vCsDxi4peUK5YTYdBUa5uavOt
         cnow==
X-Forwarded-Encrypted: i=1; AJvYcCWe2dIzAC8eQsTVwEy3XEvtxOPvtWVl13Snz6PcLAHlXQH0yUo0wI7GWE8hQ+uT7XptYNxEk5q4viIonVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIf8rYjVKspB0pHAf9tfsACliGZfEsDGXdX5teueFV+a16hB+
	hvEuciwwlhRgmLVkyHCiKZU3vgVNbx3p1uXo6i9WP+w34LRng0nECfmbT3CDuvo=
X-Gm-Gg: ASbGnctxOtRsXEqvTYE4+SSRgERzfrIigZAQHI9KisqqjWC1L1kaNpwpacvRn9Mf2Y9
	GpWnzK572vffsLDaTVVqr+Ywcrbk3JsE1zDmhQrc8TLmnlYu0sa15FoWx4Y5nlNBDDFyHCaj7XT
	EyDYF0tpuoug2YVJusLI/+sJfYhaco1gYsQAiOrMAAgzkZsZU1Ah7MT9+gYn7xe65upnVZr/qCm
	clRLJuFIqMNgl3L693n0OrioS46hTnzYzKvbolElsdVuf1WEJ472qFW5H8=
X-Google-Smtp-Source: AGHT+IEOphev5W0KGJg+nO81TIAt1Rqh9pfXsnfrArp+4ViyI3T7Wf3ChJSDYoItEG2a8bgxut2RoQ==
X-Received: by 2002:a05:6000:186b:b0:386:4a24:1916 with SMTP id ffacd0b85a97d-387877c2690mr705067f8f.55.1733947307320;
        Wed, 11 Dec 2024 12:01:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bf19dsm1966698f8f.53.2024.12.11.12.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:01:46 -0800 (PST)
Date: Wed, 11 Dec 2024 23:01:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: eisantosh95@gmail.com
Cc: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rohit Chavan <roheetchavan@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Wrapped macro in parentheses to ensure
 the correct evaluation order
Message-ID: <292b38bb-6dc7-4ea0-889c-deefadc1b3f6@stanley.mountain>
References: <20241211192209.22493-1-eisantosh95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211192209.22493-1-eisantosh95@gmail.com>

On Thu, Dec 12, 2024 at 12:52:04AM +0530, eisantosh95@gmail.com wrote:
> From: Santosh Mahto <eisantosh95@gmail.com>
> 
> ERROR found by checkpatch.pl script
> 
> Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>
> ---

Checkpatch isn't always right.  Adding parentheses breaks the build.

regards,
dan carpenter


