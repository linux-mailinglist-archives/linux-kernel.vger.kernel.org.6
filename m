Return-Path: <linux-kernel+bounces-551317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC49A56AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30B81897880
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B91221B91D;
	Fri,  7 Mar 2025 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPqY0/JW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3F16EB4C;
	Fri,  7 Mar 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359515; cv=none; b=K+e/48ZU+0nTyh1fJkSoXeDv4Wb+Jo8JmDmeOr2rnd/145J56HoQFw6gqSC5CFfanHwxaG/09DPFJmPPk2Mm3T1+JrA270nMrWjStDogGz7w0JbfhmnXKWLFpWYk/J7T9V4uAnoudyBzvKQZY8+LcbqS7cCU0fPWGtscMRpANjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359515; c=relaxed/simple;
	bh=oZzk1/5Rt1IYOn6jkgTu1i2ssgOPUr5M3qitmmRVOy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwnRddNVV5zarDzVkcmkUaf884Q+n0nACZk0t9RoWPFbB3d0c1lnuj3P1c6+njzUonE2AyZJJYvM/lCq8K6tw0BU2XR5CPoY6KwBwhzQDrFSjU0gWULzX6A4BAL36o1CBpfjcEUY6BdqOTlxr+c08PybdZks6y3biCvAmIxLuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPqY0/JW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2239f8646f6so36954015ad.2;
        Fri, 07 Mar 2025 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741359512; x=1741964312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BeGVrO9UYpogd2hMfjsiDz/RbqZAS98AB3fSsRgyDlE=;
        b=CPqY0/JW+Km7g3SXC8rhEBJGnNs+1R3zPo4oy1kTR9OhD/4Gr7ZM5tHB9yYuL0110Q
         ul3l5sNx/yHVTA9FM3Ggz5yFrhzv9wHtB45aAkUrjEZXHeXnDPhNKNZLeXjbXIr9odDP
         HlW0Llhb+DsW6G1G2i2ptLMZOApH8l6+w9WPq8Ev4ai+6BV5lWqZiM0oBb+GhmbnrRcO
         ETKjLOfvAW5eItAgODSYwhbG/HLseHwZYTxIhILdLMuJ8dNbnuWaJ1r5vrz14yY+fjY6
         /pj49DLOkalL8Z9SA8DVxSSwosLdtNdplA08JZLiMhzCcBWKoAlc/WgzCsx4/6+CITMc
         uG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741359512; x=1741964312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeGVrO9UYpogd2hMfjsiDz/RbqZAS98AB3fSsRgyDlE=;
        b=Aysm80/4TQdHEPGQNxW7wXCPewuLAMWsd+IHbYXe7OXRiHBu3KW+WvgQBjghyfbyho
         qZCNsWVY/BobD/21TjwXLwe9Bi9vwqHo0nPFufkNE1gj5ILRxe9pHEXAc9ffqaMaDVmC
         ojWuNYRk5z3VdNU066oIDvXo9HPEBx9wkKKylo9a7ClWw6vZOp3PZGw0hSQ5QSvr0orB
         QjBifs+HuQnj5IfZHKkdZg6YvL2cfyS5SdZ1iaNOS8nhNprs0mMSWDk8HxP3niMjLOSp
         HU/hqLTDJJA1tia3iw8q7U2qh1X+xAKPf6pYJ+lwm6pKLYAg2YLbCzFqyZG8qZjHlB4X
         RHvA==
X-Forwarded-Encrypted: i=1; AJvYcCVTzorGKMZYE2ItxhNWIoTLfjWuB0U1+sXehTY57qqI6rD4MOeDds50qxwm23I7WHSxscMuoSeJ8VkpWA==@vger.kernel.org, AJvYcCXlmgOO5Biu0hQT1V3uWqW1t/V4vlEjRN/wvNWBoJLwQjELVt/gAky6zCk6mPuW3rRMXVfaGlGsJd6n9OQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzVF4CltwPJSjrETa0KQX69sZJ7aU4YnhP4BJv/o9tirGhXsukW
	4ip8oo/gKFt39oW/vYzxoPtrRNnbfnZix0FojJfUmg13TtS6CPAjEVTi3w==
X-Gm-Gg: ASbGncvFrzuVm64Z0yh3iRUd/Pidwf+oBH2lXjXgoojkITCIBS8cBiKDGnlPr+YSW0y
	DKcwwvceSxTbum3SjiAWiyPnSvW6AYhN16yFVF+Tx4Co3Sl0NL6zJuQcMkBk6uLYjp9p/367+8b
	8jzk0/j5IHKQivlBYVJaqjsrGgr3KTsgNtFfadz1Ou3YKCOOYVj9uGVrUm7y4d5z5H/9CrFNe8M
	5ph2n8Hbwtkm6zZTEQaW7QhN+WQ1MqDlT1kfDfHMVe6ccngMeGY5pMVPPAbWIvdCr5Bm9PnNd31
	htn0KYi0jO8rYyth8q3veKjNPJ9CrhNkgE3kdNdfAbPcbRawQSM5SHaVUg==
X-Google-Smtp-Source: AGHT+IEkVEXPKWVGYwsEilWmrMR6r4ItlGhcbgF9+MHpE/uL2jCYzQD8yzq9kkCTEiv1CZ65LJozcw==
X-Received: by 2002:a05:6a00:c8f:b0:736:32d2:aa93 with SMTP id d2e1a72fcca58-736aaae8207mr5170578b3a.20.1741359512336;
        Fri, 07 Mar 2025 06:58:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b1eb2138sm1190852b3a.126.2025.03.07.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:58:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 7 Mar 2025 06:58:30 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: maudspierings@gocontroll.com
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor) return error instead of
 clipping on OOB
Message-ID: <da9ba2fe-f182-43b7-a28d-b34021a2d3be@roeck-us.net>
References: <20250307-ntc_oob-v2-1-bba2d32b1a8e@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-ntc_oob-v2-1-bba2d32b1a8e@gocontroll.com>

On Fri, Mar 07, 2025 at 09:10:43AM +0100, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> When the ntc is reading Out Of Bounds instead of clipping to the nearest
> limit (min/max) return -ENODATA. This prevents malfunctioning sensors
> from sending a device into a shutdown loop due to a critical trip.
> 
> This implementation will only work for ntc type thermistors if a ptc
> type is to be implemented the min/max ohm calculation must be adjusted
> to take that into account.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

Applied.

Thanks,
Guenter

