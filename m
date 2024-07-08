Return-Path: <linux-kernel+bounces-244898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CE92AB20
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1391F22578
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1155014F100;
	Mon,  8 Jul 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BrFEH0TF"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE2E14EC51
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473937; cv=none; b=eFVYm2QTH+/zv4/LycjPCYH960gCRrwFbf0HjpAkYusBbW4I4b/UEIQ7P1vP9sLZoT6uHFI1iYs4v9qWM8r4ecUktXsmTE5YakkUxPPCtlImbMTHvqrYU4soZ0Nj2OyjgZKikT/+MRqbJotR5dSLzupSIFlH1h/C2fO7DkiOnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473937; c=relaxed/simple;
	bh=7JctZJAKiS8OEudEyYr/ynOmVp0voSFvu/g3pykv3D0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PRxbR7jilFqUDvysXfzNpP4yzzTFwe00kcjfnPpfUENzTGteaOh9r/B91nRLBSAg3kPLyfusmRQwJnlutR18pL0nVTI/vcJWS3PJMJuBMksx+6nxXcNPW2BNpEiHMF/XwgdCOmvLyn0N0y4roOQprS7MSOLpe0acz2mo3QCOUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BrFEH0TF; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e0c0df558so2291150fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720473935; x=1721078735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJvFU7TYtpQ06K0DjMCeUx+4vp854MVTBkG3gu9NGtM=;
        b=BrFEH0TFO/sVO7amffuQwbUgj3tcoE1Z/l702jjZY9TMQl173pUcT2uiQl7nyqVnuH
         K7KqbPqGVUwUN+uMec7k/rD1soOQHcjbRa9jgFWSIGm1fmi2wBzT466XVfbH5WAjs3Ra
         CMcNj04TEE9CaoPXDgfNsC0I70JS7YR0QJesCaqPFeQcRIXWp920wDuY/2NoC2grPgvR
         f74uea0Qw39QZzGA0Us6hkDDmntJcY+xw0K64BCr7Y4G7zAfKKTfb2OnSmAWnD8Qbso5
         zZZtJATBIjvU6N0Ojwhu3RFhc81RR/aTyvzmmfTk71soOE4JtErqUxNJvZWjEBgZglZF
         fTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720473935; x=1721078735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJvFU7TYtpQ06K0DjMCeUx+4vp854MVTBkG3gu9NGtM=;
        b=xI3LY9699Pb5RKM2eTcp8P2PDdpamcXrUTQaEApdGM87ZbHxFh5GJdUDXXyeOYW6wu
         LeuhBfPtriZvE6Qv++EGt6oSHmLX2pNGlyJ1A+ytYm5Px620GJY2ErfMY7s9WTYrnr0F
         sJqoYWEsGVxFQYlENzTEzpK3Tgu3SlfGFpywbM57qw/eX4IAnG4YWJcPvx2GeaUcPgtn
         HoHP7WgNKIbLMBTipqYVqGoonByihAJUkNbMG3gYX+3a0QLu3eD+rZPM/w4DHeUB0byC
         k8s0ahFeTFm1urRYwnw5RmNrZMuzPahMSxyEbHyuoH9r8YpZ6MA29GlNsyUY1BjGsz6X
         6Gdw==
X-Forwarded-Encrypted: i=1; AJvYcCWPc5NR8g53QdHBSC0feChWh8KUT5NQXTVzFoNKpK3M8yfTEuZ+kiKeuJN+PmKvhekTLHLNdtaHu4CdpacbQxZILNTclsvFhEv7wxCs
X-Gm-Message-State: AOJu0YwyBIcIbV5Pn93v2Y4PVtXrzWtFYcpofFwOWL/bZIPqRn2J8NBs
	6r/XsIHZ0luUU8gWAky+Fl9DRKShKPHlJFeoLJ0XZ0rp+ZtXgF7kuvwMl2aTkEU=
X-Google-Smtp-Source: AGHT+IFibYrQLzTfmVuZB2cwTblZ0w0GWvA/Rp6zMFtf4QieNjy5zWIw9c6j8/BZsVvjrbrriJbOIg==
X-Received: by 2002:a05:6870:2105:b0:25e:1f67:b3c2 with SMTP id 586e51a60fabf-25eae756dc3mr544905fac.1.1720473934739;
        Mon, 08 Jul 2024 14:25:34 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25ea9feb688sm194630fac.20.2024.07.08.14.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:25:34 -0700 (PDT)
Message-ID: <d4505dbf-a886-4fbe-8305-9ebee22a46b9@baylibre.com>
Date: Mon, 8 Jul 2024 16:25:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] docs: iio: Add documentation for AD4000
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, corbet@lwn.net, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
 <d5f07e2ea4f4aaae1c13ed0b1b0c6abb15492a67.1719686465.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d5f07e2ea4f4aaae1c13ed0b1b0c6abb15492a67.1719686465.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/24 2:07 PM, Marcelo Schmitt wrote:
> Document wiring configurations for the AD4000 series of ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>



