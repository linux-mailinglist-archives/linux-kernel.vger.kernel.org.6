Return-Path: <linux-kernel+bounces-571073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBEAA6B8BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5B13B2418
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D096D20CCDA;
	Fri, 21 Mar 2025 10:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="TdZlsUHs"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739EE1E47C2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552826; cv=none; b=ZAP6JvnFlmdbEmeBlRgJUTpsV8+Gmf/Lo+tBxrpGO3GnJNdwKuj1NV5SCmLKBlZ8UUgC6eQop0pw/qkfTOAupjFRPdHzpXknbI73lMJQrFAZEeNfuMCcwH9Gec64Dkj9cEAzB6clQaMEdSPKPavKUQvFwi+GRCH3iMB1RVdvLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552826; c=relaxed/simple;
	bh=C6XBFDQAIe6jgF6F40xRB15uQkrbHzlxj9SySg4AP08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leOqYqbmWRd5y3W6AEcp6LyvXjZg05m5K7UKhUsFR1NUgik4yvu6qkcvHorXFOdBqYofT9+Xbdb8okFKdi89kbsE4WqlWrP87APYAK/i3LOTa08MiKEJZW29alobVHuiTAvICOj/4jjgNt8s6XRDboAT5FJVILKMzqOKvgb7T8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=TdZlsUHs; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c53b9d66fdso244303485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1742552823; x=1743157623; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6XBFDQAIe6jgF6F40xRB15uQkrbHzlxj9SySg4AP08=;
        b=TdZlsUHsbgNrvFWKr74ib1rO52+3/liwAwS1JFqwx6yapEeDkX3o9P8hqbxg4TWr87
         70MyY/R5x2Tom9e/G9Du9krSwiYhS3PpQlCLIuDQ8Kpcibsr7kl7i3+mL2f/5eIal170
         pvfI6WO93waEO1YCmhromQZ8XjMKa5pytw+HplISM6cIZ3Jyc8FWLZ7i4lKIJ0EExGbZ
         LqL9h1XwDRbi1qN5IavNQBl7pF/liW2j5ZbkZ+6vKEwh242vW6XCL5kaHH1+4HDcVZqC
         MDDlqXfQ9iW0jfpRsd4WAeRqtHHRFhz+BNdJ3oyo/P6PqeyPLo9ogk86aLgGZSrfhuRZ
         HE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742552823; x=1743157623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6XBFDQAIe6jgF6F40xRB15uQkrbHzlxj9SySg4AP08=;
        b=J/Heq/EZpYVtRDpb2Mp4h36a1eJoYrT5/39FbadIRX4wA7wBaEOrqR4T9rrb6Vo7++
         gvFVH5ew1XThneAQB9v/xKbePFpBy7FHcFrOXgkc+blnjw1kxDu6bPZ71SRp+3O305Bd
         d9DCmQUELOXvYqMxjFO/x4JGPWtUqofkhQa6GkueRb6/Ij+UO/pUEpBmIFQmeF8bTgYf
         WjGIDWeFnBv5e2dopMOxjkPT8bRwJdcmi3nMUr93uBcRFYfOk/213k3PmSzioiALQbyo
         wtnUZuXt3TmJx+GTHr8ZBC3abVkwDLpcYCQswCqRkMiKcP2IMaYaNsWvvrIf5073AcfM
         GLvw==
X-Forwarded-Encrypted: i=1; AJvYcCULQBDdhQEA4LjONe7TRFfsjACltc2ThJkKU66Ggewn7B8Q0++bjdWrNXPq6HeI/jqVX8By82G1iJ3HdLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDrV2LBAOHSB9zV8XG+BLwQRZK7S0e1ANXWwxkehkkJj8/kon
	nhYTsZTRVLUWJ9+vvjAv31Up+B4F9HWo/0MntjjhbPclPzbSXBWJgyvncqAzM/4v/nEbyOsw+Cc
	15QE1AdMlPRBoezFrG5zwJ/2mfLPh8+6N2y2Bsw==
X-Gm-Gg: ASbGnctzEr7p9xP45QPbh/qitZDCcpWnq6r2LfzNrDVMZYg8M5wz3D2BvSPUxt2xM78
	X5kCwRdn9pA9TM9/iUnkL0/h70bhOo/Tm6Kno//nqHMRUFcaN+0diYgh39jb2XvZOJtTXch3uIH
	mEhq9Ik+6SeezOF/7f7f9SWP2Z
X-Google-Smtp-Source: AGHT+IGtKZxKAoZgtR0aBlIVmyFJdz4vLgELnLl5z6u4LuYLjXNoyuq0UVrTF+CIIc7xPDTVRmAHZ+SRVPvG/7TyZXI=
X-Received: by 2002:a05:620a:4055:b0:7c5:a423:f5b0 with SMTP id
 af79cd13be357-7c5ba13361dmr406693385a.7.1742552823192; Fri, 21 Mar 2025
 03:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314085858.39328-1-vignesh.raman@collabora.com> <20250314085858.39328-2-vignesh.raman@collabora.com>
In-Reply-To: <20250314085858.39328-2-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 21 Mar 2025 10:26:52 +0000
X-Gm-Features: AQ5f1JpymW7UP78_0g_Z-sNByprYGBFX-xYqr_OlbVrsK0-Hob7Zk88vIu6Znbc
Message-ID: <CAPj87rMjF84yyPqBshuGu=8qx6Xhq9Z-HgEnQe=tRtbu3E8OtQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/ci: uprev mesa
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	lumag@kernel.org, quic_abhinavk@quicinc.com, mripard@kernel.org, 
	jani.nikula@linux.intel.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Fri, 14 Mar 2025 at 08:59, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> LAVA was recently patched [1] with a fix on how parameters are parsed in
> `lava-test-case`, so we don't need to repeat quotes to send the
> arguments properly to it. Uprev mesa to fix this issue.

Thanks a lot; the series is:
Acked-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

