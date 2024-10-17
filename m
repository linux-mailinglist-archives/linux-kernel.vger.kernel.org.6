Return-Path: <linux-kernel+bounces-369276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C249A1B27
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726F21C211C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F11199229;
	Thu, 17 Oct 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e5P9AM5G"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95019340D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148281; cv=none; b=JUVi6SWMhcjwVm9qSgKfMbqgKdtjJy/7tpAE+HLBoWXH1ogLqF1nKAAOfgDAoUmSsNc3TO/3Nx/OHaDopf8zxIpRf7SC3LH5UJVnfYUXt4jqqHPvziEhhgYHpbAGsLiAkTMMlf9x4ImRr6VMP+lGvwskFLlpqOE9iJRkVv2n5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148281; c=relaxed/simple;
	bh=9PbfSRqIXFlwYhoX9bW5L1LVRxrN+vMPwwuGbqGJ/S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3zdxVoys/2mAhSvSlIrltm4CQKmUXOYEcKpgGiqHr3xfG5ewmC1Q0yaD2PiN7AlexvdPBqWVyLy7kDtU+mOxLYVUfT1t5i/riLWQ1CnMhHH9pyjgXlnxWIggcP5SvUYwuOqafkTRIpe9axqlCEunVZqvuSAGnctgpwhJ0Q0aN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e5P9AM5G; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so403527f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729148277; x=1729753077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsVxKNaCOUPIwvV/JXBrrJwghFlIic3EFjT3Sx4al/4=;
        b=e5P9AM5GCRY76Nh0zxawgS4QiCjbScVRh23yTZA1IpKy4mmiacs0Oh2EnQ8caPAiCw
         Sd5gkn9wdyrbSBZ/cYJqXY9SBTFhMfuf9nFid4u5K9TFwmjyApP7eHozjRFNjcjvu8w8
         r6uT/llf+i2JjqxCkNMwemPuGKMuTd5Y6ZPfKLzs+XEt08YbQ7DjkSLDjhOS3qZNqPVZ
         A3qXAAW2uJBmT4wcIDtfO1828xxGSFdh9WDzofz69aCsORjxcrMHumoXcuF06o5AHpwr
         jrx8sm9WX2c1I6xz7OciibH3gJfoAm+EwSQf0djgtkBrA8S9HFQK1JAAvMnzk6OpXk6q
         AYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148277; x=1729753077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsVxKNaCOUPIwvV/JXBrrJwghFlIic3EFjT3Sx4al/4=;
        b=C8LcStHWJQPPzbgJU4lbGBGWGEZwxGkPovRG98aENzW9ITyuzOTrHWT1674E7p6kTh
         ufR0x6Qlhiyv3wMVrqBvo8Y/OtIcQPgwGJHw0JHsk2Mlpaq46ZnYU9E1rA0IVe8KalMy
         1TaUYCvh3ohb5RDGEDikGTyzbf9is2wQlzzBsMatA/53xN35LhsNjtXEnATBHIQf7PFn
         fHUNBkly5uirD6YaTap8BJfLfKXTZLUo2BiAVKk2LymR7ZH4So3TNBDYQ7LD58ntYcBO
         QHsAX1h4Dc89PLBsjiaC12vVM3iJZcsSCTfFatqdkvea0T4fdqW4K6vjls/4FdRG1jOz
         RAZg==
X-Forwarded-Encrypted: i=1; AJvYcCUhCi4BtZ/UhUsNaGnAbXfyljdYALcUo35mefdJtPu9AiPWNmVkoX4sLkf7LdRCi/sveA5aVAHcMKSS5Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduiUowxkj9tywFq8va3w6l/u2cxnGnGJWhjuIcQS3/wO62DSr
	MLALHY0pj/dm3YTc1IUiIcifGgBDoQTR3vzlnUPAOXk108xdFch8wqfflRcCbc4=
X-Google-Smtp-Source: AGHT+IEtYf+6+JZ8RLzaXHf/9kDuV4vdC65QlGCnnohbNUZKjscouGvfPWgxqcZTV5jDTXH1TpWWhg==
X-Received: by 2002:adf:ce83:0:b0:37d:480f:9a6c with SMTP id ffacd0b85a97d-37d86c02a75mr4142670f8f.25.1729148277158;
        Wed, 16 Oct 2024 23:57:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3831:fc61:16eb:d0df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87adasm6260026f8f.29.2024.10.16.23.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 23:57:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: fold the Kconfig prompt into the option type for GPIO CDEV
Date: Thu, 17 Oct 2024 08:57:50 +0200
Message-ID: <172914826142.5858.5149802789967077947.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014110707.101320-1-brgl@bgdev.pl>
References: <20241014110707.101320-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Oct 2024 13:07:07 +0200, Bartosz Golaszewski wrote:
> The 'if !EXPERT' bit will work fine if it follows the 'bool "foobar"'
> declaration. No need to have separate entries for it.
> 
> 

Applied, thanks!

[1/1] gpio: fold the Kconfig prompt into the option type for GPIO CDEV
      commit: 3dcf0643fa5cd65e667057cfa11d6e54ac36f2ff

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

