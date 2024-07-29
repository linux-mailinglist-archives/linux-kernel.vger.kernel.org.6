Return-Path: <linux-kernel+bounces-265891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3F93F755
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33008B224A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB8152160;
	Mon, 29 Jul 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeAXlS3S"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729314EC55
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262229; cv=none; b=otQXa/8wxthVVdeyBCswC0OQpX6WeaffL3/8uNcaiLHOj6iLSJ0q2jZUVnQrYjPWNaNzV/2nZ/UvMX90yzrkw/t+GW5oHj70L9iMOyE8UwQ1xMIHrmSHNS2xdc84PQBpqBw3AZs+dOtMBGDGOmXp+nnRV2uVu27fh7/TlIuDn0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262229; c=relaxed/simple;
	bh=JqlyuK7PaNSfH127cTky8BP0zH1Xl6nVQf52DBOjqrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5vdKwqlDx3mzknkLXXFh4WdeiZ/sZcWvMEtP2f+WCngXW5XsQef2LEQkuj7WqNfd1uHK+PXYbrHqqw1UcimcP3k9racNqioq3T0ZqvZdq6l+exdXp9aCvaLrr21PtNC3o4aOQjZ3zmHM7hKcU6k/rzSjffO7JpLktsVvmo7FIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CeAXlS3S; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25e3bc751daso2568439fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722262227; x=1722867027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNp+cQPSoj/8O6JaY8fRlRrTVGCksavAKQMIAp/dl6c=;
        b=CeAXlS3SOsEBikhp/EKrHUbjFYmz2TyvgfrslStH7bufhcWhcVpRenf3o884rNubIc
         hBq/jUTzxaput2eaYIhyGVYZcY0pgPerPcvGbsUWrPPWSXUJxxvFzHySSTkGStjZB9gr
         LOcKYC/4h5y/GAp63yxaSxUIl1RQNfqaGdUB8gZZ4zpsh6bWwmKHVuC7aDGkCMnjToXB
         F8JsaPMs9Hi57JnkZgeTSh3eLawhM2quFumQ33aqpKd8cqvYmuKFp/R0jYBpLFz0IGOh
         HgA56yMJncvY4jUDeoAiBfoM3kcDE8yMjc59C0PYcbpBCWD2TMGXIC9ag3UkgmYX4L6Y
         Hf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262227; x=1722867027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNp+cQPSoj/8O6JaY8fRlRrTVGCksavAKQMIAp/dl6c=;
        b=f64elD4/n1XWtDOpFHOP1MPvJz3zHtqI+CmGoxpXt/p+c7HynqxYx7GmTngdNUlsST
         oPvYvg4IALwz5/LzBvJ4R12cB51QjHxdNOLY4A6hAUTs5k1Ev8ph3odFPFNIavH4okAi
         wVFLQhCHNeQZmy4Rve4BF7h8KKzAwdwv/QutSqi2sIWrGz6NhADsNw5likzIQUc6cNlD
         gxfplZiUvrvH12wLIjt1guj0DExa4o1nM/7ZJEy9K60ZyOKnCA7mBg0ZGKHlgSKtm/Vr
         6gPzmzbBOzimWasNJhieKirm1cvQAHJOHZaiIHGA4BYy+Kbie2lCFQaz5rfnuhWUho5l
         3GZA==
X-Forwarded-Encrypted: i=1; AJvYcCUGbeRTHsF48RpE05I1KX7Y3MaTzBIsJj+zHpVf+giOjBDMfIvztqc2e6H3ZNQRwgR2rsv+sJb+RzZQ6KTfAisRMx2l/MShhszDjlDh
X-Gm-Message-State: AOJu0YyA1y3NwDIRgA1eTkUyr27xWS/JzE57UjgOLxaL7OZvaZjcDahM
	iCdu0C3jlV63THqajOO9anbIx8q/0cItNW6/sXzP/kfXfXc/E17NT1ZmuxFsN2c=
X-Google-Smtp-Source: AGHT+IE3F+o5CY91JWS1hd0lkqMsJMWrwAKpE0XMh1kK950xmMKvPHuWAQCxIuhFBKMTtCuJb/sdLA==
X-Received: by 2002:a05:6871:3312:b0:260:e678:b653 with SMTP id 586e51a60fabf-267d4ef4399mr9073460fac.42.1722262227161;
        Mon, 29 Jul 2024 07:10:27 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930722531sm2096942a34.38.2024.07.29.07.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:10:26 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:10:24 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
	airlied@gmail.com, daniel@ffwll.ch, Jingwen.Chen2@amd.com,
	suhui@nfschina.com, bokun.zhang@amd.com, chongli2@amd.com,
	Luqmaan.Irshad@amd.com, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com, shaoyang@uniontech.com,
	hongao@uniontech.com, wenlunpeng <wenlunpeng@uniontech.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Properly tune the size of struct
Message-ID: <93d10611-9fbb-4242-87b8-5860b2606042@suswa.mountain>
References: <D51E93EE77EF1231+20240729140000.890760-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D51E93EE77EF1231+20240729140000.890760-1-wangyuli@uniontech.com>

On Mon, Jul 29, 2024 at 10:00:00PM +0800, WangYuli wrote:
> The struct assertion is failed because sparse cannot parse
> `#pragma pack(push, 1)` and `#pragma pack(pop)` correctly.
> GCC's output is still 1-byte-aligned. No harm to memory layout.
> 
> The error can be filtered out by sparse-diff, but sometimes
> multiple lines queezed into one, making the sparse-diff thinks
> its a new error. I'm trying to aviod this by fixing errors.
> 
> Link: https://lore.kernel.org/all/20230620045919.492128-1-suhui@nfschina.com/
> Fixes: 1721bc1b2afa ("drm/amdgpu: Update VF2PF interface")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: wenlunpeng <wenlunpeng@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---

Thanks for doing this, but these Signed-off-by tags aren't correct.
Signed-off-by is like signing a legal document.  It came out of the SCO
lawsuits.  SCO was a scam where SCO claimed that Linux stole their
source code and tried to get Linux users to pay licensing fees.  (No one
stole anything and SCO didn't even own the copyrights to Unix, those
belonged to IBM).

You could maybe use the Reported-by: or Suggested-by: tags for Su Hui.
But the rest of us could just be Cc:

Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: wenlunpeng <wenlunpeng@uniontech.com>
Reported-by: Su Hui <suhui@nfschina.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>


regards,
dan carpenter


