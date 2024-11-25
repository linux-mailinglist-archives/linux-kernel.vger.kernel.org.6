Return-Path: <linux-kernel+bounces-420410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C469D7A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 03:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B53280E71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 02:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD97F507;
	Mon, 25 Nov 2024 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kd3d5/Fo"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352597485
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732502976; cv=none; b=LbPo8mRY8wab+jIt66DfRHhZYVLWr5bPq2WelpUrvk/BmT28LIw1Dz3dTIAiAjs7hwoOa5hCGI9mojimbgA/sY2jqG2jnnpPhK7fDNrX4fcaEwCyjFMzgIkjrX3+0z07xfg/qYiAnHxMWSQvg0xNHZniDREgklhwn01cJixS3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732502976; c=relaxed/simple;
	bh=bwYRKpTNXZ0AgTOqs1gS//e1QnOtjbZbYKsvZm7kMzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP0kH1lbAaaVwTnQewEJB5zUnMFIWmn+9qb3HLMQeG1DfwGPrE3rP3hCBzG1KH58v0kMx6d6ondZSM57wpE5yWQ4ZDNz3Slrd24vnOyuhHTbtV4Z4U5FZAtrhNow0JZ1ZNdVJtN2DqUya3Sz2uNcI2dh1rbowtBJm4MwLEpkcYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kd3d5/Fo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7251331e756so92530b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 18:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732502974; x=1733107774; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bwYRKpTNXZ0AgTOqs1gS//e1QnOtjbZbYKsvZm7kMzk=;
        b=kd3d5/Fo2OZX9Ymg50fN5DYcFVn3RgmucW7OOvhqNeWUawGyR89oIaDJ55g57iXmNx
         YUH3hKowTW+iLVhr8o8zNJuVGmhC90F9woUQFoaDD3lXbDBVcuy6KNGzY2Wnrpjd2MF/
         T4lCHATJZgLxhvgCRXXkklbKVCxyBvtxNK7Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732502974; x=1733107774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwYRKpTNXZ0AgTOqs1gS//e1QnOtjbZbYKsvZm7kMzk=;
        b=f1CNvqO5w0rcnZnBDaME0t71vKV9IzhNDE+1o7D+Qj55gCWxTnW3ZAMqJMNHVVyYwv
         P5JcDsl0K12fybUx1zYIAg/xd2a2NNJcPWFF4meAT6UeQVp/b8bLe1Wi9bBNloA+PKbS
         FZftGTacVfTu3UhdHoDt5LrxvKImeDAtUd0x8UkagixQ1GfWtHvMlgpfYbNfkg/H1uWR
         iHuGkWOcMx3MDju/Nsmu09LWmN1xuog21QKQilBieR7ZJYGsLe33i5arVgJZZbbFIz/f
         mqwK5SxMmuc7nMNTv+gbbkfidGMTIX2gDmM819NN7ObOQn0RS4lwfP9j/YTgtk6JVJX4
         zW1w==
X-Forwarded-Encrypted: i=1; AJvYcCXROot68srWTIww/gUuljvkR4yZNr46q9iurda/FQKMIl+46F/5unCG2ZYMWphF2R3Z5AZhPiIFMWVqaGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyV6zZ831qFbE0AvZPj1yUJWPyCmihW99ELh8J/227Lub76XRc
	OAgrYaZRk47aOhCrX4qIV6pS5Ah3afh1Kqcz4a+VYo7cQ/DylMTMcbi5GEJlXw==
X-Gm-Gg: ASbGncsJ9pgE88UCCpFFbmWbCf9OFYzDfZk85XdKFatva35ljbrsTDA/tXkwtjarsbM
	XMoagQkGJNTkyu5QYYtmvhBtcHwInal27tW8RokBU6ufXjmM5nqlnD4Voq41FIUzzdLAzJ/BVwc
	fFwCXsHeuiS+VynxSVTQdJostSUb3N2oz6FrHx1V0OnpMIi73ghP2yJpC/yWHRf2ol3W0aoce1w
	l60US8/ZULBlPYl7p95T125IYSFl4PZEdvxq8RlcLdEaRa5/vWOtA==
X-Google-Smtp-Source: AGHT+IFVP5SVaL1qF/f5JvchALO9YPXcNoBq6pXemW0DxAs2YPUHfvD451iNdYYTDbidp8QZ53Fd+A==
X-Received: by 2002:a17:902:7241:b0:211:ff1c:e611 with SMTP id d9443c01a7336-2129f576484mr125711635ad.30.1732502973648;
        Sun, 24 Nov 2024 18:49:33 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:4ce7:266f:8012:7e3c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1fa27sm53479635ad.225.2024.11.24.18.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 18:49:32 -0800 (PST)
Date: Mon, 25 Nov 2024 11:49:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Saru2003 <sarvesh20123@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, corbet@lwn.net, terrelln@fb.com,
	linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Corrected the spelling of dictionary in the example
 usage of 'algorithm_params' in the ZRAM documentation.
Message-ID: <20241125024927.GA440697@google.com>
References: <20241124134550.69112-1-sarvesh20123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124134550.69112-1-sarvesh20123@gmail.com>

On (24/11/24 19:15), Saru2003 wrote:
> Signed-off-by: Saru2003 <sarvesh20123@gmail.com>

Can you please resend v2 with:
- updated subject "Documentation: zram: fix dictionary spelling"
- perhaps a short commit message is still needed
- I'd also assume your real name should be in SoB

Otherwise looks good.

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

