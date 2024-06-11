Return-Path: <linux-kernel+bounces-209567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A799C9037D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C391C2320B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DEA179203;
	Tue, 11 Jun 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R07tjvWw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ABF178380
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098207; cv=none; b=Y7+2O8MBwbqkJtT5+hu/1SUDi6tqzhKxGMbED1qXE7dXwXIKP1DqRmXf1/SfHiyCL/JA41XHHAQrwdsGPPiRTqobHQvCw/8yGldAC1nXFupJRShNk4NAztm3JeU2cbSCxvmFV44Q0Dhxy7UpSepw8IRO4U3DztZuRw45ZUJZkZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098207; c=relaxed/simple;
	bh=iJTk2bWBP+lvdZeKGxbToy4THSOMUEfy+XjeY7nSGlc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P8LRdqd14IdfNmfANBj+BiOoSd9jBjz3fojOOgGuvoFY7Me2260kgX71eGSN78V38cWOx0I4a0QoFh8Enl0n5pep9/uwm+5CsbeFWUE2QuMXkP0S+g8kkUS/QT1+o/1XQCVdE/JefP1AJDSJaa8Ln7hmcEfO71fG8T8oQbhFPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R07tjvWw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a63359aaacaso103957666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718098204; x=1718703004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVSFe+LEvHD4J+FTFuddJTwPtiIyyXEmsUsAbuCvKKU=;
        b=R07tjvWwmhoExSOSlN1GwiJiPtl2ffnnMRsV0l+rlgKt9+KZwnltupMMXoFpDSYxnm
         lY45QVH66zvRMYnN4TYahnGgEhH//yIgwl01SfxGexot1WWNb8Z0NddQonZXWyW2UGYI
         I4knrQwAUCohys4eqml3e8VmC+h8tvYU71jb15UC2xAY9EQ59UJOKGW5vXrUOw78dff8
         AhpN1HSJ3aFipyLojRjnchos2TO/XqqWb970fhaW2JRc+ck/P/q+OEtu7LQUZcKULBPX
         ZJsx/ofb/Q3Ch5sOrNBVGzr/IOZe5bmSx2TFPgLOvI2RZgCcmLOdiXsGOglycgApZ/D2
         XFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098204; x=1718703004;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVSFe+LEvHD4J+FTFuddJTwPtiIyyXEmsUsAbuCvKKU=;
        b=omYANzJhV+DeFmn+KwZKjEFF9fdKnIvqE/OXp1hVhPpwC+OklD3GgekDmrlCvDk02b
         puj9xllUWEllD91QvV/Jbso8cHNOsiVJqEYtW5/hioPFEUEvbw5YrY7Yx8e51h2GN8X7
         rmBcxUqCoV1haMEFld8HYHVyIezcGhPcqyJNA79c70f6STHNm/4EUIdIGENTjU+G6JVE
         WXP5d4eeSruRmuuE0zrSeYQcn/UxwmOyyRpCz8ZzXVjOXB+Wd1FpCqWU2MiVIHMpHDR9
         z1xwuEFDfY/POjQkzhe7X81sXmGhHLi2rQ61Ek7zfPKt2h7L/FxHpgnZpD1HMNayvzhq
         Iobg==
X-Forwarded-Encrypted: i=1; AJvYcCWdEDX95zC/RX4UF5aRQOWnrDLqQ/WzBepNv9HC42r4pQ1duQX1UsJOIJhU6+m6lyR2cdB6QVZCgNLhaxva28fx4tJ1ycCtBgHfeCGk
X-Gm-Message-State: AOJu0YzwVvq8mO7hL5UZyAAHXAbp8QK+fJ2XxQKoHpg9czoz6yr2L2MC
	9XYB+s7pUCiC2hquCzRUE58fuGCy0agAuAuDc8kLA3wd8l4ipr/uIvSXNcNhNk0=
X-Google-Smtp-Source: AGHT+IFD64ACy4sU3prTnq2ZWsuYEYdfjvT2xIoEoOokPKRXtIEe7kYxR4O5bkXL5aDz3ZYE5z5ZfQ==
X-Received: by 2002:a17:906:17d9:b0:a6e:fbac:d7b6 with SMTP id a640c23a62f3a-a6efbacd808mr560256166b.21.1718098204489;
        Tue, 11 Jun 2024 02:30:04 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm735715966b.110.2024.06.11.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:30:03 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Julia Lawall <julia.lawall@inria.fr>, 
 MarileneGarcia <marilene.agarcia@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240516022838.8609-1-marilene.agarcia@gmail.com>
References: <20240516022838.8609-1-marilene.agarcia@gmail.com>
Subject: Re: [PATCH v2 linux-next] nvmem: meson-efuse: Replacing the use of
 of_node_put to __free
Message-Id: <171809820332.51273.7866466244916343148.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 10:30:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 15 May 2024 23:28:38 -0300, MarileneGarcia wrote:
> Use __free for device_node values, and thus drop calls to
> of_node_put.
> 
> The goal is to reduce memory management issues by using this
> scope-based of_node_put() cleanup to simplify function exit
> handling. When using __free a resource is allocated within a
> block, it is automatically freed at the end of the block.
> 
> [...]

Applied, thanks!

[1/1] nvmem: meson-efuse: Replacing the use of of_node_put to __free
      commit: 5e15aa6f07b35fb3d755f7cdffb8acbca62abe74

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


