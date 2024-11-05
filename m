Return-Path: <linux-kernel+bounces-395964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B929BC573
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 07:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62511F211FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100831D88DB;
	Tue,  5 Nov 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZweH6fom"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FE2A1A4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730788417; cv=none; b=DBKLbIZJ1zAF0Y4z9lfeD2KbjqXRul1IMeif7D36jqyg1wQA6IS+Af2eMB+zo1qZYT4ap6bVxU7MkDRLlLEHVRQfpkrUrgbmdam2IzPVWM1hbZyGlxBpDQbB65N71Bg0WTMUC+b57A5qPhMwU4cYfS1NR3j/Hk+0YawBpFA2ijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730788417; c=relaxed/simple;
	bh=t3bvFmNuQGNs9UGiiISlH2teCewegtta8jaIxh8ONf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1ChtVEWPxQYOJA1ZPBjV83wv1BclsG6V+dPOvSPDpkqH4wEgOartgOYXagnTg2N/GYe+GZ0kdHAcgqPRaLQyyfaptz7zytrr3fpq+xFivtHBZY5qMZYj4nw4cYUHpDMv1eTOOPfFkZaoMzNmLLRGZ3cpY6eV8hOTh7VwsWCiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZweH6fom; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso653965466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 22:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730788414; x=1731393214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3bvFmNuQGNs9UGiiISlH2teCewegtta8jaIxh8ONf0=;
        b=ZweH6fomU23lZ2durwOq0G7Cg69+b9rRpuQyLD6fZ/rYb3S5SIDgVcjPvmRC0sa5Lk
         Mo1jLsc45AbV8hmjEvXZ6qC1WedS5CvgwU9JIAQEe4v8F/UCwjqf+oE6CMIIXFMrKNlq
         sH7Msm2/KxDrZgUxQ8Qi3wgu0F2ko3w0l1PyWQ0pwMRYj2rI81u6tinHPWHniDstj0Rh
         vv2xNfyHwVYGCbO7W0vT5tEjmY0nUUzEDVkO7ycFrKXN2DBjSUAu51eXSdwQ5vmsBUEN
         Bz90ZZIXFxKy/9URJjaYgM9wens6z3cbbqlcs0jaRKscjSg1R1ayCTUj9bRlAn4f7kX6
         yXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730788414; x=1731393214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3bvFmNuQGNs9UGiiISlH2teCewegtta8jaIxh8ONf0=;
        b=wDE8cfCo2aWTDEU0lK2xrDua9ZDgTjJKoBI1/Zgo/na9l9a7OXrKfMqEs3ZlSo6HXe
         Rf6laaFtt/Czo30YHuHLrGEQpPM18ifF9McW1wlH+OFqSQ+6d+9vXEUxv60m0r0X2Bit
         VNKVZfSLxCzE/rfjQBm0pYqQAh4oxQ2r4d5j0McCUShKr5HaX4wQKxq6ybMF9D15N4KR
         V2c+LC4b3d4nj5VOtS2o0ZZTjfKA1hq7C+UamhTfQjysjY5aZFGj+PowE9uJvc/GQqwJ
         95Ljup082y1xfu6ALFw6iOFA95gGJZoyOByvLa26svDtEk3rTKqBacEu9bEF9EIS/Xyk
         IiAw==
X-Forwarded-Encrypted: i=1; AJvYcCW71CRhx1vMrOJNn/i/S19sCceYmfcjHDpPrZmUAg5vv40BmR8m9FaLzKQYIKyBGAtcm+TyfdaYeFy/eoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQg2wjNSOrOH8G6yAVwWiBJrvIjuQ8yrYWOyMtnm56+gUpnTXz
	QcYHunMPXXKPHIa6bInHKY3cIYM3ie+GXg4/+jw0UlIbUmsjvEMb1IoBOEVFMTM=
X-Google-Smtp-Source: AGHT+IF9V9Q8NkCfVRclh7Q3mDq8C0xfRD+iZKCJWd9iql6JL8dFIMsWd/abfpHvPCmisIhYNnTz1g==
X-Received: by 2002:a17:906:dc94:b0:a9a:12c9:41d1 with SMTP id a640c23a62f3a-a9e5092b1c4mr1812239566b.28.1730788413729;
        Mon, 04 Nov 2024 22:33:33 -0800 (PST)
Received: from localhost ([77.241.232.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f9b3csm83341766b.172.2024.11.04.22.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 22:33:33 -0800 (PST)
Date: Tue, 5 Nov 2024 09:33:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH v3 00/12] staging: gpib: Patch set for gpib staging
 drivers
Message-ID: <d0c4c59f-dbaa-403f-ae39-4ee0476ed9e7@suswa.mountain>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>

Thank you!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


