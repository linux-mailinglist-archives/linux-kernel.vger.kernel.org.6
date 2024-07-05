Return-Path: <linux-kernel+bounces-242329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2B9286C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E39B21664
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5681482FD;
	Fri,  5 Jul 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uUkf/C9/"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBC1474A8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175219; cv=none; b=Cb9TO2yoXUMMr3IvsIu2PnlEqWBAG7AOsbyhKWBKsrKO15nfIEndq2VhfcHjIczprgqQesY/p+t5gDIaP1mkPysONy+4RNLgIl3FcTaVkONpOHnf2vnCtzZgVkQVEuy1HqMfl3dYnmgW1G3BAjDRhS+7S6avu8Wl4yCTerYEcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175219; c=relaxed/simple;
	bh=yGbo/J4eUFlKgy2mpmn6Hpr73tNFtSqMvohyWG45viU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwM+1PEwZn7guTxlrF07m9iMgxFuE+CL5Z0lYkL4XiPNajgmOn5pWnYyswX9gZZ5l4RSm89eq7rAyqcNPtop4dF2LTfdKW66x9nz8jZVfBLVltS6AWeJTOGHp923S014ETFUCG/womXR6d6Bw46en5hYmg0XXES/9pq59wiGCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uUkf/C9/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5daf5ea91so7460636d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720175217; x=1720780017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGbo/J4eUFlKgy2mpmn6Hpr73tNFtSqMvohyWG45viU=;
        b=uUkf/C9/RCS1HNEdopUdtpbZgZjAf/On16XiM4fSe3zHAtRryiPBJjXQwcvE17DiBJ
         EluE9uskGRL1YzjWKZW1e8UDJrbup2OmNZ+uTXIlPvHKAcN398CzJ4Wf/8Ora1QFiqco
         v++HU5FVBW6ch+nJ4YOOPTsQHmaYeYMlz/vLt0LIKmajnAMwH/SJsYyN5SI0RVB1szXG
         fr2xw67MACOTluwgVmQ7cv5/GDXvztAQR2v9LRVu4W3CbmjacVIki17ora1B6/D12E3L
         1RhjQ+MjoHWvp38fymZnsGL5YYx02GN3zIRiv4YntNW+ReomGdIEdI0JYeZcKBXNlfok
         k6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175217; x=1720780017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGbo/J4eUFlKgy2mpmn6Hpr73tNFtSqMvohyWG45viU=;
        b=mUMo17xJQJvjG+z1PSelfoSvGuwGxaYlaSClKbrrL220sjxCXO4itJ7Wcx8atEcI6w
         wVhIGHNSS5SNKp9xXmOr2Z0K3Jp82jLfQotu/V9UeuT8CiH8/PazGKVhQ7mT5nWUGeXQ
         rK0JVkJILeUK5XLfLXLoXh49trb1FSVSgI0xpGUaxKCEJG6YoP4AsIAevunUt1n8/pqG
         h5THeJUiyc1xJlXYz0KM0CaRF6V5WG2BiFHrgBpuZXpOi9X6B5VD6HR+nQ4/t/00vHxV
         iXfMdZ+zYpCZAie3mmBRNe6xrVZJmTiCcWyOwhv+ElDN+XIlr6/9hqVb+x6DOBTGz9KB
         CzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw03BlHFnHDxN+NL2sLaNs98WdaRVp9MKbZ1U7uRLeYcztW4F9xpfFwvpdB3yh2JLbzxoBOYFRmhOxP8ee/aCVUBP2rFVVdwZjft3I
X-Gm-Message-State: AOJu0Yz82OaHajEmcLZOFbLW7daRtBCbIcy1Rm6prZRNv6+vamFR3i9F
	rUVUcAH9K5/Gnbpe8ef2Y/GjNDcnV58hGA2kb768D/J2u9cryBJps7FUkk4CURc=
X-Google-Smtp-Source: AGHT+IHU8EOVpqYrcQTs3CHIcL+/+yQvLWdVExug/MFZEndiHTAoPACMoBY2RZmg3CFNlc85aj2geQ==
X-Received: by 2002:a05:6214:5013:b0:6b5:4b10:7849 with SMTP id 6a1803df08f44-6b5ecfb53f2mr47314046d6.1.1720175217387;
        Fri, 05 Jul 2024 03:26:57 -0700 (PDT)
Received: from aspen.lan ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5f47b8260sm6893286d6.100.2024.07.05.03.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:26:56 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:26:53 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: l4f00242t03: Add check for spi_setup
Message-ID: <20240705102653.GB110803@aspen.lan>
References: <20240705092800.3221159-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705092800.3221159-1-nichen@iscas.ac.cn>

On Fri, Jul 05, 2024 at 05:28:00PM +0800, Chen Ni wrote:
> Add check for the return value of spi_setup() and return the error
> if it fails in order to catch the error.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

