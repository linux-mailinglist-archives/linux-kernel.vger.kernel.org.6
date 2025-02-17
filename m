Return-Path: <linux-kernel+bounces-517923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A11BA3878E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231BA1894340
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B52222570;
	Mon, 17 Feb 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="auzi/rSO"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A121A421
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806306; cv=none; b=pa2Bk2NfdLQZqNQfFmD9jeAUjLMvJX/CNRwN9i2xrUfX2iosmS0qzjxDHRtHjutm32lxry0vsSoRUdMnAKtyl99hs3M12AB1RK0sjb2cHJ8lZ6jdPM/e+RizrIQFSRFqzASSknYX+zX/0cHgc9pUDrTWoqlQ+l1O8OHgIwX0+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806306; c=relaxed/simple;
	bh=i4cD0V8+nfCJgVSaBV4TSFCD+HZ8bi6YcjwUGYdl3Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVgekXf9w7RsZltEXaal8bycKWh9YZ94Xbct0yK7gOyDCUhJwRLN/uQr65OEnng+UGmxnvcseH0ZJCmJ3HrEaKIuJDPTwaH7O/i5K7KPD2qH9Iba6FxHUTKQFyU0BVVfVQ8ooA8LvQP5vfcNGjTXDekESj0eRgcRIXyMd/bcQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=auzi/rSO; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2bc5212b2easo1775124fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739806303; x=1740411103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLy6tCidb31UtJbepHKM6tCxizCfttBLfmcun9Z57EU=;
        b=auzi/rSOT7lrk01fYLwijlvQnQLpts2nKb7Vj6exFCNMH/k9dd8/oOLdD11bEUZzH2
         V22jAQPIaafhqfK5LeS7KaueOtzUM5q4qZ9/L4VK1DDr04fhOdLjaVQp82YZyLvJls5H
         GyB4CAsa0BtB77j6X9tz+AfvNWQWrjBDpbdXL3ai/UucYJLv/XR5iXaiklmxqhtZp+ey
         jB+RejG7V35CglT4BEVcRuHQJZ3mEJZdrGKSJsu9Tgg9H8Y61VJ1m4dlm8srbwEU+SGm
         RswIQEGQNyZ5q+iXS2uZhJRpKxESsW9VRv+sjy1Jh4TJ6DekerSX6e0R2CSl3r66zj/U
         hAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739806303; x=1740411103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLy6tCidb31UtJbepHKM6tCxizCfttBLfmcun9Z57EU=;
        b=bWgBm4H/LMTD2tz3EAqiwj4XtqJSfweADqUNfngI+CUXO4tbMPAcGnp2Xw12T8wQ4Q
         oEJ8SvDPuYbdsbcWa4tejjwjXb4sRfVxeDwDB4fgQ9h1e0kUhlL16Iw1LeMeToFaO7c2
         Ft9VYevEaiqZZZofny/bGttS/Nuk+vtnQ1tLzoEHsX77tvhkgNVTOaMcUSJyX3sT7M/p
         5oQPAfHOELiu0x43K3YwzDVL7PYQVwZgyiZ1RNj6rlu1allitmoyuJTtAhw+H+qzF84k
         m1JwOI7PnJUH+B/3ZjyVPrSLBvUlOGngdJg665HTy69V4AklrC3aSIcquHJgHrjGLuU0
         hE5A==
X-Forwarded-Encrypted: i=1; AJvYcCVercTgFXovijKaeV3XfgzNyLogfzLy3ch13hT+OYFmhIZq0fqZwWDC/QI5cCHdRI/Qp4J5egvwMiNDP0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQzRiwBL0oVvUVAsFHp6u6TjIxMBXe3pGdead4c8LpgQq7Ivq
	B5hHv+PzYK+NHRyIC3SvDVXXcfsQWJltIURpDuruakUzpUjRVFi8KCJQbb/xJks=
X-Gm-Gg: ASbGncsjH47KIj0Iyes0dejD9VNJJOY1zXXjedwLh5g5Npuklk28EesWZV3Ezd5nAU1
	cucnTkksmrzgCiQuu24gyasRYKWZAOCc9TETEAml9PW10coRdzuinYRDOtOIRtjFs3MjrfjLgQ5
	Pm6VMS6hz0b+GDH6LFVNqMQTghkr6mKo4ksq5vRUcOWml7K0goFU592MImQgVvsUqa7sa9DhBZ3
	2/boqGtndEPMriFOSS+eiXYd1Zl+2SYNGyBI6bLttEZZ1TIMoFszut3ZLXOz8TyH3gnk4QiYBq8
	kSe/Gg053n2zQvTiDo+Tyd+oJf0yuaoQfiWlJsDDV6U4425Ulqij
X-Google-Smtp-Source: AGHT+IGNFQrTrIxdPZwMWpXCPOJVGNSy4LIlCpINievqrtoFIHd9q6fEfiQqQaF94LwUcwd34eFBIQ==
X-Received: by 2002:a05:6870:912b:b0:296:a67c:d239 with SMTP id 586e51a60fabf-2bc99abc0ffmr5808371fac.12.1739806303211;
        Mon, 17 Feb 2025 07:31:43 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548205d6sm4061410fac.4.2025.02.17.07.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 07:31:41 -0800 (PST)
Message-ID: <7f0689d4-e940-4889-a29f-4fcbe8a32676@baylibre.com>
Date: Mon, 17 Feb 2025 09:31:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: adjust the file entry in SPI OFFLOAD
To: Lukas Bulwahn <lbulwahn@redhat.com>, Mark Brown <broonie@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Nuno Sa
 <nuno.sa@analog.com>, linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
References: <20250217092851.17619-1-lukas.bulwahn@redhat.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250217092851.17619-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/17/25 3:28 AM, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit 8e02d1886988 ("spi: add basic support for SPI offloading") adds a
> new MAINTAINERS section referring to the non-existent file
> include/linux/spi/spi-offload.h rather than referring to the files added
> with this commit in the directory include/linux/spi/offload/.
> 
> Adjust the file reference to the intended directory.
> 
> Fixes: 8e02d1886988 ("spi: add basic support for SPI offloading")
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a54d8510ea6e..53cf3cbf33c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22402,7 +22402,7 @@ SPI OFFLOAD
>  R:	David Lechner <dlechner@baylibre.com>
>  F:	drivers/spi/spi-offload-trigger-pwm.c
>  F:	drivers/spi/spi-offload.c
> -F:	include/linux/spi/spi-offload.h
> +F:	include/linux/spi/offload/
>  K:	spi_offload
>  
>  SPI SUBSYSTEM

Thanks for fixing that.

Reviewed-by: David Lechner <dlechner@baylibre.com>


