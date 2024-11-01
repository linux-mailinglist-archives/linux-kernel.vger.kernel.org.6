Return-Path: <linux-kernel+bounces-391659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D96DE9B89F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A810A28292A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1A14658D;
	Fri,  1 Nov 2024 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N1EaTN1t"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931864087C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431652; cv=none; b=kKNMBb65VdY5u8Lhvgl+wBHZmJW39Obg/vNqJbj7F83GYjYmcemaDM7uXmT2KdC7FAvI8vu/JL5Dhir0VfWmIhKL9D7VQ5tR8naSMJg56Ld3P0Qrq58I1d0PXc/B04ldLa73GknqMtO5oc9qIrr1ORPwSjgH1SQHCVFA1qV9P0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431652; c=relaxed/simple;
	bh=plqiRlvx73CLvMQkwpTvEhGhSpEHTS/efF6elyesKv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlInukU34SkpTPWp9OMDMlujEeG4cxJ2FzbOLfb74+pWnGJwbsMzrLI/wWX3QuyiEXfc4Y/raMEUQYlz+xpD5VyhriRp+le14bFf//IkjVssdNR+K51bNDx+ijO3RiVwgNszjL3fY2L4q2KgR2E/JLFW67iWqk4OaytDvZG0u4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N1EaTN1t; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1307681b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730431650; x=1731036450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nxx0Fx/9J0WPI0aj1beNLHUEJaZ/IpVHuJN6Hmx+s+c=;
        b=N1EaTN1tVST2vDTtn8xdXxAM6l+z6J3ySreaC3/6fUrYNV4DR1odwtnDEv0DZqGDho
         Ta8jNZkFL9Hp7aK7Ccu1Y413ySKrkCQ1oQUNf0pa2ntt76OxzGeLOSR7dCLSs2RQPRNW
         ijDHpoW2hBaw8ETSz4yoKpPBdOiudfJ3J66LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730431650; x=1731036450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nxx0Fx/9J0WPI0aj1beNLHUEJaZ/IpVHuJN6Hmx+s+c=;
        b=B5kDLblIlz50XYrKHDPqz+i0djedvHzGF/LTQl4YFjgKEv4NKUH5pmIHxVVACd+J+b
         bCDyNz/DZ3Gyx7VlV9ba7Wl8NRZLYBmC0Z+U84njr/4WZrYkyaFGaxKsbbLN8KypBiuS
         ijkLFYZhTLTSf0CJgAthoftACXaPY72vAzvLrjcuZucbLR0HfqEML4uld8rsFqTeU0Z9
         gElwEMTAGms2/2VU2mB5BGqh4A1XFU9/ki/KulBdH1vMdbDI0iYeVSwI61GyC1aUyhRq
         wJx1VcwvevFsST7Ryvm5EIC2/yjMZaf2LicUAufeWoEN4iyvlXbwZlvHmANA7If/xWqJ
         zVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR/RuYrFegvcmEYdpE71VI4KO3mRTuanxfGHrvin4NmQzYqRYwD+L3JSoP5KpSOnp++eZ6CQJQfb0DAwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+6GV53HYk75I2cZWFxPZXPSPfEh6rgT1mzuHG1w50Fq557Vp
	3Fwolg2A2bXa60h+BcRkhwlZsNHtCo91KCbyb5IcvnLo8uPUOxiTQPrDTdJk4A==
X-Google-Smtp-Source: AGHT+IHBHNMjqCPLi40ofFWzuOlSVxMwmz6cHcNqDpUlqrATnAlyUrBIVM+iVjxqynw+e5BWTJ2ckw==
X-Received: by 2002:a05:6a21:a34b:b0:1d6:fd8c:fa16 with SMTP id adf61e73a8af0-1dba55373fcmr2128905637.46.1730431649927;
        Thu, 31 Oct 2024 20:27:29 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4470:8fa8:957a:6c05])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c498esm1931051b3a.97.2024.10.31.20.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:27:29 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:27:25 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: linux-media@vger.kernel.org
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv6 0/3] media: venus: close() fixes
Message-ID: <20241101032725.GX1279924@google.com>
References: <20241025165656.778282-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025165656.778282-1-senozhatsky@chromium.org>

On (24/10/26 01:56), Sergey Senozhatsky wrote:
> A couple of fixes for venus driver close() handling
> (both enc and dec).
> 
> v5->v6:
> -- added kfree() backtrace to 0002

linux-media folks, are you fine with the series?

