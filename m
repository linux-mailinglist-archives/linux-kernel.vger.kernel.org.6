Return-Path: <linux-kernel+bounces-571493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7F1A6BDEA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6BF3AF8F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B941DED5C;
	Fri, 21 Mar 2025 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntHFYyuW"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42301D9346;
	Fri, 21 Mar 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742569155; cv=none; b=SqUqVCEBpaxBruykyIPToALYD20aPFdfU7u49mSsYH50upDaLp4XIKKQKl63unejeQc1GowdNZ4RDIg7uxmlKQHUfX/tampDlHtbHZAlNCfwNTo97VJmp05WcsOL8QRWxwBYZ6tXUppnZScaZOU8BMDQ/ZuGenC4gyKrOLwp/oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742569155; c=relaxed/simple;
	bh=gLVO5wxzEEPQuhNuCP1PQvtMhRXWVqTwTEOz/3fjcwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXYbGaEF3TGlseR3gWWEOzkWEy9ze9CHYodMuCd4602ej8D4c0Kd0Mya4lSJC2RMIJYFUiH0jQW0vAHxix3we3sFQoSY2LAQWha+CMnRZbGottEGFadJqBYKJmV6w8+52IKAy/hH5z8x5tQyL/ZpcuDiE7/E0y8Rav1mqznJnPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntHFYyuW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so3547921a91.2;
        Fri, 21 Mar 2025 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742569153; x=1743173953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXKwGTUsQbiUYQW5joqs6O63fIJid8EztV7QgGhn/ng=;
        b=ntHFYyuWYCZc9Ujr6gog86g+lnT9Tq/FchqX+FUVEAenw+WL7Hc+PVLBcSnGD4IYQc
         0ZNAuf4nydKu7CHUaPIXHH016GeEC6O2XDHoAzbIwwykFabOyr6AIOmNYmhHGX9W00g2
         AfkWtLrzYcaMTNiENybXQx7CLaQd8OBowxQHrv1/oXzD6SGHEH9uu9tKhfJ8sif+kgwC
         HZM2TmXyjHCTM0KdTccisXYRaZ/FLPAsys5TsZWbZ3ytS/lsSOw6mt7hFOudukymCa8B
         K7aAef71bYFBQ7KR20kA0nCsLKvmdk39/vE5k+mIvuW21PIyOk/Q2x1oKN2UQo7WUSD6
         JVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742569153; x=1743173953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXKwGTUsQbiUYQW5joqs6O63fIJid8EztV7QgGhn/ng=;
        b=mGJ9AM9gu7maMPa8YfQaUhDspIHtr67QW64q8F9EVEx7D7gvwtmS80FG03kZsWSdk+
         H03JVNWGd328RAOi4WFIUZDX4ONk/z7QLKPhDPwHARk6blenVQ1I3depRlyYzP7EM4Kc
         1wgL7uEshATnSdgepciAZVx04yfCOloB857K8J1p4RbrRhLyrGNywt8umSe8gl3wB3bp
         SMqcZX/JKEF99laax59+XOF5S8CMzREaG3pFB0GMOuoAuE1Q6ACaKQITaudU/QhSAI5x
         bkWP8Y7Jt1f2Z9dWYByc7Jw9/PO5P5r9imrtUmVcS1cB2XcoCgP6/P/Xzgmlwz051dEE
         hvCw==
X-Forwarded-Encrypted: i=1; AJvYcCVdhq7t19HW0bALp61qPIZqza3Qo3TFj2NPb57U4u58wE94lOjBUpChnLMN24Bfr9YxFHBNxyCWo2+7@vger.kernel.org, AJvYcCWhSp/VPAoxgoFOW5K8XOygdrJjrUASDW0Ca1pjF4kyF9Zl9cjt9KjnOlni0whKHEp7EBwWfy1luKDtE165@vger.kernel.org, AJvYcCWtMyNY8KnDfsP0r/urel5pKXhCnNGKnb8Bx1zBiROn6j3+iFW4L2MW4tcyuOiFOGUnCOsUjtBB1yl5A14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17EYbi4v/AnQrhEAf17YDDHA0b2/Xe5IDeKs3iHap+iTFFtqa
	sZm9PmJmyuhhfyYnBX4O1q4F5hAWLVJU2dRviwI9rcRJE/93MpUa
X-Gm-Gg: ASbGncv6QVBeS+XbaGsPRMJ9m10mc+W4gDh1maTIXdMlRk7m+tEJTeMoAzW4MfuP0vc
	BPCiUdAaIC7ZGGMkNaTtcs2aW6hdQUt4fevsed8MByEBJQqjXn7WfuWxl08lWVMkjZQntl5Bwme
	Zc8BPHKVtSr1OUmNJ89FkQZskjmSf8SQBYtEuI+fefu/M11Wp6XPw/B2qi4EQSAkDJqurF3yQlP
	miR4JcIDMTNZBEhyBotS2dTqHm1ci+JrB32JAdaFdjQvPVQDrq5b0MHD4A/VkdO5mKiLAHUXrFC
	LriapcVxQgsEGPokFCgaihT5zVV1fh4/QsPgWJ+uiMJNPEzqJpWG42nhgg==
X-Google-Smtp-Source: AGHT+IF6umVYRS212iBtEP1x40AMIpx9W1bRR0L02OmSGE1cdJ1gfB1CHrlYoh+yhHyO6tWkRhmqfw==
X-Received: by 2002:a05:6a20:7285:b0:1f5:6f61:a0c2 with SMTP id adf61e73a8af0-1fe4300fe40mr8669919637.34.1742569152847;
        Fri, 21 Mar 2025 07:59:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd517fsm1985221b3a.40.2025.03.21.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:59:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Mar 2025 07:59:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Zev Weiss <zev@bewilderbeest.net>, Ban Feng <kcfeng0@nuvoton.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Eric Tremblay <etremblay@distech-controls.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florin Leotescu <florin.leotescu@oss.nxp.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Drop stray blank line in the header
Message-ID: <a85c2222-c2fd-41b4-bd29-79a43b4a451a@roeck-us.net>
References: <20250321080212.18013-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321080212.18013-1-krzysztof.kozlowski@linaro.org>

On Fri, Mar 21, 2025 at 09:02:12AM +0100, Krzysztof Kozlowski wrote:
> There should be no blank line between the YAML opening header and the
> schema '$id'.
> 
> Reported-by: Florin Leotescu (OSS) <florin.leotescu@oss.nxp.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Thanks,
Guenter

