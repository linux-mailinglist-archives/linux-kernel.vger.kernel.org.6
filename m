Return-Path: <linux-kernel+bounces-170501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF508BD823
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD161F23AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886215CD79;
	Mon,  6 May 2024 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmKRFFNm"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF7D132C1C;
	Mon,  6 May 2024 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037585; cv=none; b=lgtjY7vL41JJQ8lHy4tT8G7b7DU05F0fW5OHsy39Dt14e1NpwapYDFKfVx7JC6wkOVmOjnqFgFOxZSmgXZuRcUzhhbMuencZymzf/z95+jFtqBCTbeyG2E1wKbA+2dSvBVmNCCWAklo6YfgwsURbJBUTsQ2bbpKUrfxd88oRcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037585; c=relaxed/simple;
	bh=+KUERwP2DeWJuc3fypqR4Pa8eCVMsHu/1B74WMo7HzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcRyWEHPZyNN82OBMBZC/K6+iOQVbrg1oqmFD/UHqEDB8JlHCyHUvA7FMFJpZ12tfYe7F2A//ZiSqaJOT5mep0VuJuXRyj8GatnI/ZFEm3NUXOCd6W0ONWQ+deMRH2sjLjW2/rpQYTTCRs4oa7pEFqhUehhqm853efYhDBkWsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmKRFFNm; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso2462593b3a.0;
        Mon, 06 May 2024 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715037583; x=1715642383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyAH5z5yaF28VIBrVB4OxDbsUZbImZAN5jQsZ0+0a0U=;
        b=SmKRFFNmcadqSXK6Bi2neOWzNaMHh+BRk9MwNeDp9BAGBdjlpsBgtj+2rSCJiPmNlA
         +2CP4TMjVhn6jVNG5Mry/PMczU22VJMw5gas1UVtB4y4KlwskBtGe8sk3gNOLR1cEAEe
         PiZdFJAis9N8ETGqWJhCoBpoFd69UDE6S4ZXVaaCo3OpTSkdPNZk2NCZUg/4X4CTKmy2
         yt6Lg1I6CpfHxh4vAmxQ+yFvo+FnJd04VgsZzVqtN0yPSk+p4FV3zVdxT39NZo4+Ms+D
         A/ZwsFoi8+il9taNAXboMtRKWcR2enL6wljwwj1BSaUbAKdRU+RwR5rQ7qoNYCXMLSOo
         VgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037583; x=1715642383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyAH5z5yaF28VIBrVB4OxDbsUZbImZAN5jQsZ0+0a0U=;
        b=mNlrsJ9iDOS0Oa6EWDOSadkCTVr6C+7s6rE7/1zCLOlaWa8ojB8Y2zU+zUEtsO9XtS
         db5h//hqlq0YhykzZ/k56TgcLXKj6H5F7ZgApjby61jWP1wozVJmV1gDeKpT5Qk/mFld
         RVH++25eRIyaDDCk5bNANkPBfR+nvEN7YCVGlV0fNSlELWy5C7ei62Ml65l7cYuXHbVE
         g0CM6YviWATuikK3ZbbSwAtiqL43yg6eOBEtqk86DhmHpi/vvPf7yJ24pGvI600VhwhM
         8PSV6Hiwt8LurGjJqOqVgtxn38+D7T+tb7ANYY+6hk9fJHrS3xBDxLUeHKDT1EwGV91v
         RSzg==
X-Forwarded-Encrypted: i=1; AJvYcCUsjGVHZT7Kojj9PlEnVEOv9IiYWv/ByIFvhx5ZeFbeaExADlmpNudY6ruIALeWjSjsvgzqd40wOXv16JSBBO09SMQ1nGfdMi43FNahi5/804ZG3qihCblozCEDUyU+xTC1I2Jb3ZLyCAM=
X-Gm-Message-State: AOJu0YwEvr+g3HW9HeYGWAwtMNP2idPfUpL7WdoU/tQP0soaxfYRC6t/
	XwkuGtYfF04z7/JqJyzHaQkr+z5txJ2/69NTFELDZIReAkcExR0G
X-Google-Smtp-Source: AGHT+IEN5WLp54jyzkBuWBWjRwWMtftIputaJPFffdW/tGyXAL9bI079/j+zDAwhco0OUFIvd8XlNw==
X-Received: by 2002:a05:6a00:2287:b0:6f3:ee4f:e28a with SMTP id f7-20020a056a00228700b006f3ee4fe28amr12947375pfe.32.1715037582820;
        Mon, 06 May 2024 16:19:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a00218400b006f3e3d928fesm8261307pfi.220.2024.05.06.16.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 16:19:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 6 May 2024 16:19:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Lechner <dlechner@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (adc128d818) simplify final return in probe
Message-ID: <f1af1b58-025f-4963-9358-808b6f5d8b01@roeck-us.net>
References: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-0-356cdd152067@baylibre.com>
 <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-2-356cdd152067@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506-regulator-devm_regulator_get_enable_read_voltage-fixes-v1-2-356cdd152067@baylibre.com>

On Mon, May 06, 2024 at 10:59:16AM -0500, David Lechner wrote:
> The final return in adc128d818_probe() can be simplified by using
> PTR_ERR_OR_ZERO rather than an if statement.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

.. assuming the patch will be applied as part of the previous series.
Otherwise I'll apply it after that series is upstream.

Thanks,
Guenter

