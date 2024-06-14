Return-Path: <linux-kernel+bounces-214349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B9D908328
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25EF1C21ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655851474B7;
	Fri, 14 Jun 2024 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frsyOYeN"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBD12D760
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341507; cv=none; b=eEeawMfLoUNxrMWo7PGs4VxXaOpt36zXtzGIeTERmShFp9lnKFRQMM2WPu3K7VsafWVyGedzhoUJ5Om/094boDBKz6VCfDH99KrlJcfmbOuZl65h7+9f+NCsX5Hooc44tHCv/UoUx6R67AVytBVs4k0apW9BUbGW8cMa1tGhxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341507; c=relaxed/simple;
	bh=IukhxcX3qDkzoO5Zy8Nrlq5s8wAmwy+/c7BkQCbdyC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4et2EM2DsElqwfHQ4Afi5F8d6H8xvFY+LabR7jyEln9wJ6sjW+wG6RiavDGk6pCiXjGvww4wK6t18sbMaHJsYFflq1k3Rz9pKxubSwDsnU1grsww2RrUaT2LA1rPQri5TiS2T6eHmDMcTHH89FCxMHL+/jyEFijpBB/86YpQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=frsyOYeN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4217d808034so17494135e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718341504; x=1718946304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWNNIgMpJqUN8OKFztHzayuDCT95LOD3ZJqMZeNQQ+c=;
        b=frsyOYeNNhtC5G+KKj+t9vsEKuI8OGC4BgQ2i8q/RDNlss/jTB0geMP/Ys5pIqNQ9n
         UzInjbAFKZvUv34qm9GzzhtP8Hz1+gvQ0BuvcIIbdllC61rXfPC7ll9f8W0YdliJGNgn
         8LhdKVuWOxLPBmtHt+sMD/3QodxEm+uGZwytO+L6iXrG9Bl9995dz5w3bljh0qdAA7Ly
         0fS0SY/h+mBWIOYzWA8aj4J0vn38BExFPn2lFmganm80tYH/1U/c5hTKOWAVXG0yUThM
         6kAtYcdyKrlfHRpWLf0fOs4jkLpteubLMfBTntLE+3W+dAHGcIPYsDoQ5IBxoCVi1Cuu
         RDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718341504; x=1718946304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWNNIgMpJqUN8OKFztHzayuDCT95LOD3ZJqMZeNQQ+c=;
        b=E0NjC92zuPYopmfgA7MFCYgMdbUrQDLcWVDFK6qy+aAhFb1xIgu2UDSPlOnDITx/iY
         4/RecFBuI6INY8iMRPND6lH1zTiRhLNHwoDTpRCFlgPePEi8UDH/FrTiBm1aQNAgaRuv
         dJQLMAGmxyaeWT0tyYmwXRTQ7qzbEm6mmvwjUL6LvgEgd+O2Et3jMJ+WSP++rwrl/10l
         LYgt3hjzh3J32P1zQSDORMN37/aiID6vIo7Zxcuv8m3Jp7y4mYekfsU22jbEu5/ys33K
         KSi9PPm/UIWdUjd8v7Ao3VcuHvqV3OMzLnz8dUsAEh/nWJxjMupNZ5U0lZfKURWFKSIB
         JNyw==
X-Forwarded-Encrypted: i=1; AJvYcCVF+v7vbEaroNnm6GsLcJR4SN3dCxYc3+g2U+QFteomWI5MMFX0dRLcFjXPL1GLRb+kcNBxx0AvQskGJBpfV+GWuQoSfDSWA2JgmMx7
X-Gm-Message-State: AOJu0YyoNodyXNsbsRi0fLgUUBF3zODM6cqiBe518QwuzPLxJnkD3Pfz
	zqfv4n/ZwtgeXkCdm0N+3XqpyADbH7WO6rA1oGW01/qhJ3mOko8A6ClQWZeOALw=
X-Google-Smtp-Source: AGHT+IHAc0Yh7ji0lwnDCu2Lv4w/FZ4Yx74voqdotxBtp/d5ml1qvOCQlfNZBB82HLxJCmKCwVO2Zg==
X-Received: by 2002:a05:600c:4ca9:b0:422:52c3:7fe0 with SMTP id 5b1f17b1804b1-4230482c1e9mr16109225e9.22.1718341504275;
        Thu, 13 Jun 2024 22:05:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de5d5sm83206355e9.33.2024.06.13.22.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 22:05:03 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:05:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Handle zero length
 read/write
Message-ID: <590a7d8c-6bfb-45f1-bc26-d99837cff2a2@moroto.mountain>
References: <20240613212542.403-1-ben@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613212542.403-1-ben@jubnut.com>

On Thu, Jun 13, 2024 at 10:25:42PM +0100, Ben Walsh wrote:
> cros_ec_lpc_mec_read_bytes and cros_ec_lpc_mec_write_bytes call
> cros_ec_lpc_mec_in_range, which checks if addresses are in the MEC
> address range, and returns -EINVAL if the range given is not sensible.
> 
> However cros_ec_lpc_mec_in_range was also returning -EINVAL for a zero
> length range.
> 
> A zero length range should not be an error condition.
> cros_ec_lpc_mec_in_range now returns 1 in this case.
> cros_ec_lpc_io_bytes_mec checks for zero length, and returns
> immediately without beginning a transfer.
> 
> Signed-off-by: Ben Walsh <ben@jubnut.com>

Ideally this would have a Fixes tag that points to my commit.

regards,
dan carpenter


