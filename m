Return-Path: <linux-kernel+bounces-565576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AD3A66AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3F1189FECF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FEC1DF723;
	Tue, 18 Mar 2025 06:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naLjqb+w"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D938FA6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280982; cv=none; b=n0D+/4BJdtC2HAyRhsKt0P+bV+6YHfgPZAjk0JzQcABc3sATgOJnFYeGk5IgcUzfIPxjb3kIdjQoWFya0uq/T/NUW71B62k0aZSsXaHdE8dnpGM/bGJIszMjvFyWU3DXj6Bs6XGzEaOR/XOJeumk75FVepmIbE1CRGOTFR8OZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280982; c=relaxed/simple;
	bh=2uO8v8ygGh+vmFJg/PzkAuTzo+G7jTPm/LwNHL88dBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwdc2sHu1KFh4gOHuGL/7EjfuJp62bbkOaMx5PfOXcd1bmN/upwQYCWeZnugTyI77OIgOPOMXaSxSw5yZQ2wOmYZy6DX2TjwszMB4VFGqwfFIzeTQul2sNQIGd4Lru288HffHGmxCOliANur9sI6EyFR+hrbAPDZSLuOmtRu19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naLjqb+w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso809783066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742280979; x=1742885779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwcG0nkjUDlN5Bh/rhj3k2ZPiTcT+O714WWyKryB05o=;
        b=naLjqb+w8FMiuQX1vbfEWHjR0lkGrBWmcm1naToX73kBBW/o/mpSjA7yj9fjDi9cS9
         x8TAmQ17dQOcd7UWfE+fBDfklj7RN9V2jXUaqZ2fDuKJNm4nZ8kad2LtTk2ChxSkHaMn
         U2CyYJfL9COb+w//6DSOhphF75eMYPh+0+vXVJYY62G4hxq2U7x4KBuIfUlysL2Zv8q0
         /mwkQ7Y+Eg3/+xGzsYRSDWNDn3wZhYmmqBJapwfFsx7eYM+iBB2MtJ4oYoWUTR+IM7vT
         +arT47VhjgGNResV5ODSGTS1T/2zaqJh0T0fkjaMqY1eGU7B9/HPIpMMphPV0/NVGccs
         9FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742280979; x=1742885779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwcG0nkjUDlN5Bh/rhj3k2ZPiTcT+O714WWyKryB05o=;
        b=npmHInb726ZPTXm8ek5VZOIrzmH8QQmK8dfyvtelf0e0ell/k1/E3fBCjP0uKzfLQz
         upmw1pfqWfV/J/TRajEw0Qyz37QETVl3TPCmp8Yx39AiAWmsOe51eL9Z1FDXYVEb0jsq
         saIN7hF6oXaHqP+mCdgrgYQ0t7k9CC3lkMgRZI8mPtbrIZs3zt7NN5z0ZWWp0PhsMY5g
         pnG8enMO0/fkSRm6Sx1QwMhza8hNjK3WuOuWWoiVNduv/dGXPnhCaOACVt3CpVd5ZNc8
         SLTFH2+otJ2whCnBhGZGpuWWg2moZ8rPc70n0bocibic8NtFEna70fbLMyjMbYkaTDhB
         6gvg==
X-Forwarded-Encrypted: i=1; AJvYcCXMnA33/EDSWwGfL0kmi3DZcQgE9ijsg2bNgS8L/acedhY2R5ipgriSQAjoh29UMRH9J1vVsRuTGXMuUXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8O0kMrwtPSACQtRRrhJ3WILW3rrztHgZJDtCb6H3jnrk+Z6+
	2axPrhl3tf8iCISAxDGkNbUSS0IA+9JUy56W9GvCoIU+RAwbvXuI
X-Gm-Gg: ASbGncu+/2IQSNN4/2zWWP8+OVTMjjmX4wJDk5yKBOLLLHKEFFbu65iD3U8YMkNVjH9
	pin/vSlI1Fuh1dptH7sBD1KfuXyw2CDjiE1T3UhnCcU1pghIMbboQniq/tUrBfl8Ey8N+fokjpL
	oLaKv1raioED5x2KeYo5X3ritvtxmgRcpLqTrPanJJPrO1oXNUqIv2khbfiODAg2tjEnVTEIRCu
	EyXj9MW1/3bgOhFaOmB3EJs3UpA1cLjHs5yVOv1lEATJAIBYdlALi/xuuZX8SnLywIPgFvN2YeW
	hschPJUKjYAbl0uUpJDlZpFm45eF9V5O7QN9jMIMftd8wzaQNnQFPTYR7CU/D0ywTxPknRbvcDV
	diciO4TUdgyYbf0jpZvKPNXGbBCzPjKYHh6HliGJQ82caxA==
X-Google-Smtp-Source: AGHT+IEFPFabopy2MYvkvMtlIv02ESYxo7QfPaSYD2btK+WSLZa3CANNpz53pkWjwY2mwptKmEPudQ==
X-Received: by 2002:a17:907:96a1:b0:ac1:effd:f2ea with SMTP id a640c23a62f3a-ac3302d1dc1mr1648297366b.24.1742280978900;
        Mon, 17 Mar 2025 23:56:18 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-95-251-108-181.retail.telecomitalia.it. [95.251.108.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac38f091c7bsm106906766b.38.2025.03.17.23.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 23:56:17 -0700 (PDT)
Date: Tue, 18 Mar 2025 07:56:15 +0100
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: shawnguo@kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: OCOTP and DWMAC builtin modules are needed for imx93-11x11-evk
 kernel dev via TFTP and NFS
Message-ID: <Z9kZD0vEsrrIftk5@alb3rt0-ThinkPad-P15-Gen-1>
References: <Z9fhuVltKwqgHdLp@alb3rt0-ThinkPad-P15-Gen-1>
 <935028c6-ce56-46e0-96ff-46fa91c8f66a@linaro.org>
 <Z9hkDqcKG1xOmIB5@alb3rt0-ThinkPad-P15-Gen-1>
 <ef163f08-35f9-4d1d-8082-c826c6cd0aa0@linaro.org>
 <Z9hxKlrrqW4QyzdJ@alb3rt0-ThinkPad-P15-Gen-1>
 <88c66c98-7ea3-4172-9c99-405fe449cc5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c66c98-7ea3-4172-9c99-405fe449cc5b@linaro.org>

On Mon, Mar 17, 2025 at 08:14:30PM +0100, Krzysztof Kozlowski wrote:
> On 17/03/2025 19:59, Alberto Merciai wrote:
> >>>
> >>> By default they are enabled as external modules, then until we don't
> >>
> >> So everything is as expected...
> >>
> >>> reach userland they are not loaded thus eth and all the mechanism behind
> >>> that are out.
> >>>
> >>> I'm not using initramfs just tftp and NFS as follows:
> >>
> >> All arm64 platforms are supposed to use initramfs on defconfig with
> >> necessary modules.
> > Thanks a lot, I was not aware of that.
> > Do you have any reference?
> Reference for what? initramfs?
> 
> I am using meta-qcom initramfs:
> https://github.com/krzk/yocto-qcom
> with copy_modules argument:
> 
> https://github.com/krzk/tools/blob/7c0d1cacad06aa0cae8c2983ae26889471a9aaa6/linux/build.sh#L543
> 
> And here is how I append stuff, but simple `cat` one cpio archive to
> another cpio archive would work as well, just be sure some paths are not
> symlinks (/bin /usr/bin) because then `cat` has issues:
> 
> https://github.com/krzk/tools/blob/7c0d1cacad06aa0cae8c2983ae26889471a9aaa6/linux/build.sh#L504
> 
> Best regards,
> Krzysztof
Really appreciate, Thanks a lot!

