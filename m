Return-Path: <linux-kernel+bounces-268730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF36942869
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5982E1F23A37
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51E1A76C3;
	Wed, 31 Jul 2024 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vNIBSYxI"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F516C873
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412454; cv=none; b=tcp++L2r9FpOwq+H+6CF5HAypVhN9wsgmS+fPfxNBnaWiM1R42iecp2j964+k1K3Xd4cUMcSV2qmBL7hXxPf8yuifWNhHrLgGmhSydRnVIB7XATXxkCgIo8li9Ihn9mbzjTvrnRr01M5s+ndBSdwPbnRMd2uFvhBq2nR+gMWagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412454; c=relaxed/simple;
	bh=r/M3bCwa96zOVwQ8eR2vJi4t3kpkDcsGQ+pl/2SfrH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7My8SXxiaUVfkZsyp93SkLXHSSUiT5taiZTbOFI6epVr8XWQJBnZV4Cc/F3xBH4izzs68UOXX9te5SQgPFzsipBH2S49xN6Ynd8+Uz+r23C0lkDhOTEGhsk3tR33HX336JMqhCJ49giXlyNQkXbV5dzX7upOC2oi2WO/tTrsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vNIBSYxI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367940c57ddso2699324f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1722412451; x=1723017251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5+8i698Z8RRTDjwl7HeTjUjR9VXOcNfac5I83O7eQs=;
        b=vNIBSYxIw3lGYS+WWIZKUJEdAuG3p+JClyAAOgUwjGNkskvDzlwCtVQKvddPjFBlc+
         S8w4wSfS5v/AXuzP68D9jvEi/K8VhxKP+2ebnyaOYBazZSlRbw7GC6PBaB3A2syvIMvM
         u8+BGjNbpwOYVkaAcqv3X01QEMbHjssV/l1zVJlsiRp5Avv+nJV9qF0efJ81BfEJ5E/P
         znjZ4pM47C3C2BE1vnI66x2kOTYivYcp1S7B1oAyVEAmuQMcbmurfizkPL8smWvFSi2k
         Ntb0LTI3SZsKTUoxipvuXxUz/BfNMiTEhHtrH5abJZocEjosdx85RUdSQuE7mEgEk1cm
         hu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722412451; x=1723017251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5+8i698Z8RRTDjwl7HeTjUjR9VXOcNfac5I83O7eQs=;
        b=WTE5iMZTbkRCGg61JRlDo740r3HKUu4JUrQDrsM8jNDYPd7nLu2UWwTnHdOp3hNKS9
         bLXbpojTUuJKS+Nz873ug2AjQHLvDznaAMrS3s3CUKYOCu3VQ8fCIhYPOLEUJBBtQQA6
         0lwtX+pKMqrxibxd99iIzNEEDrXAK3vGCrVT8ZtD7FXhHdM7HcmIwt726b8KYwjeZpTv
         QzHMTLs3ye4FVUagBEPNiDvJli+hHrcl0P9xsEgy7In1Li0YW0bdtVJeWC7QfxlBVfr5
         a5MRbe1GN42sZNDYI4LQedKjt1WHX6DC8pI8wofhEiudnygPdL2yJAYwjNUz6Th8PIyd
         BCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcDzlqFykZFHkDkW4B0MHJYfBkXNDB+LkC0Exm+8eU9nnvVm+npmDh/M7SoGDnn2ebrIMzkjgmo/A+ISnsrwJtyDusRBfqWGWjqgpx
X-Gm-Message-State: AOJu0Yx9bGEoJKQsYKJOTyO3SmyHkkNV2Kgynqvz0L0idec+F4Izx6ax
	3hj8BxqK2AgweVwdXYPPRY1zqdviB9GWTZVhZrQN6nRZoV1lmUbhe4iUUcZIgjc=
X-Google-Smtp-Source: AGHT+IHXqyDqGF5DuHVbAUQN6IlkBRyt0ZeFJVe6a/2pITbuNfDNZnx5fSN3qQTWCtzBi+1IiVc/sw==
X-Received: by 2002:a05:6000:18c6:b0:368:3f13:22fe with SMTP id ffacd0b85a97d-36b5cf11545mr7896445f8f.23.1722412450809;
        Wed, 31 Jul 2024 00:54:10 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9c3f:3dd8:b524:cb31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857d5asm16355464f8f.84.2024.07.31.00.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:54:10 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: gpio: nxp,lpc3220-gpio: Convert to dtschema
Date: Wed, 31 Jul 2024 09:54:08 +0200
Message-ID: <172241244628.9881.266225655059546392.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731054442.109732-1-animeshagarwal28@gmail.com>
References: <20240731054442.109732-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 31 Jul 2024 11:14:30 +0530, Animesh Agarwal wrote:
> Convert the NXP LPC3220 SoC GPIO controller bindings to DT schema format.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: nxp,lpc3220-gpio: Convert to dtschema
      commit: f7176724e7c972201ee38ba531d6c8b68cab180b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

