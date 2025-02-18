Return-Path: <linux-kernel+bounces-520198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF12A3A6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCFB3A2A63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2197317A311;
	Tue, 18 Feb 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmdHKDkF"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D411E51ED;
	Tue, 18 Feb 2025 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905623; cv=none; b=owzjUMe0RWCctVLImta9WBEvGKF+9Kgs8oTpC4KZ2TVWjvveh3+xB/fgMY4VkqdwPY6wBtCWaCOzUtl96ZYPaJXaoeLOgvDR+gpCIbe9CRIVHh53Wjzzv+EBBlbSQ4uc6DNFWlZUQ83PwiUedxnuzCasw7xHlasO7mWXgHwkVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905623; c=relaxed/simple;
	bh=Hs/qnoFpXT5mzrFh3FYSbmqblVEDjKUtya7k9IFqpzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNMryRmaxOsziSxfneM6ipNenOhVJlCWjmKCl3WJH6zn34y9D7+JYmOYnOwN7jw0v474ylgERJq3boMhpde3U4hssJ8+rLnmuGVjENg7QEauh8MFmfobZOqILzQMhvOcS2JOde4ExDzBb1Q2AeQTYS+R1Mbb6jZOMs9vHkJb14Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmdHKDkF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f1e8efe84so2087013f8f.1;
        Tue, 18 Feb 2025 11:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905619; x=1740510419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hs/qnoFpXT5mzrFh3FYSbmqblVEDjKUtya7k9IFqpzY=;
        b=XmdHKDkFDQhYx821L5E/7NoKYwAN+oUnamBPfpc8y1riZ3i6oyTfxRTAtGPSfxr6fJ
         mnufgi8T2bO2DWJCZAk4vAdPJihYdjAJvPLOAf9bctZscQUB+5W45fO6Pxa6J/P9ZK9b
         vqoxs+tstCgpCrT4ctvEhJ28IcuArzsCiV4rkmw6j/ANYRNPuxwnSCSTDggZelW1FynN
         8BLlZQMD2NSGnLVA53fKfRGJ5lxCjktVMgioZJ/Qc1+N4hip9qFPUCG8k+QgpWoQNvD4
         KW85IKjeJ+SqYxGb0EdGejO39oh7a+XPb590xQqqszbPxc0kSP8zo/v8L8yWj4Hw/91z
         P4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905619; x=1740510419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs/qnoFpXT5mzrFh3FYSbmqblVEDjKUtya7k9IFqpzY=;
        b=KFjp8+gyyJNkZHUQ3N1CsBaPfWhFkfBB8wQH6zPJ4zNl4Z+9Hes+KqShD/WuXM539s
         M0BZ0H6fwoHk75LQ9SAT6prTceLP1oqPSjon6H4ugZQKpU6gl5So/mGCwWtuo5gsvN4/
         Bv9irgIh1vJ0zk5QtONQqLCWoAokXJanhwQd552uHN4zNl372N3/8EfJinnje76Gl6hF
         509SoVmWzIWYkttjHDd9AUFCrHwnpX3TlTy2mPJwHqz+D5mLJNnvpy54qX3sTWuX23//
         h2UDUplHK1k8zAS97D3iNiFuI4i+L9osjcjmnPVI4hleKjUHhCd5QYtglmsbBX7hAVaq
         RXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8VvCh/6dVNVEWNmGiviA9s/x6aesTB54rjUPLCIXt1upVkb5T260aMIFtvR3jrOJ5YVsgI6riWE+1@vger.kernel.org, AJvYcCUNHAqMu1s+jatE8k+ET/33QYidWebt4kn07NVNi6pIIAb0l4sTFy1mDU7sH9aMIQbgOLql13d06O9G@vger.kernel.org, AJvYcCXPgJ8kGfa6vgdC6sI8B4Yz+lI3VWYkl8iiwkXhkxHR/32xPgjXv0V7pgzCtLVr2A4589kyqxQtWmZyuaQF@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcC00PenVwcPuUohKJbQGI07GkuhE4e6v6HwWWyJNJYIhmeJk
	WmR2iRZEkPqeynXCtQxHsabb0FtOm/xFWTkkIJExXfC4HSbyZU4x
X-Gm-Gg: ASbGnctQcKsUCw2905XO2r695FEARCXeQRyxJa+5nEMkzJuLfXYanakaMm7VK7yntj3
	Yg7xC0X9kvtrZGhhceMzxtRRfvLenGBYSrrYLtVjvyqQIrrGsWXOOc4cc6V/JX4MYXsFqC6dxNs
	kBE5Un/n7qhytA6mKLsEvDbT/QzMX6aMU64ltMLB7AvjKbjqmVlHCv+8+GuwnZ1phV56Z9gsOX9
	SyJPC0CGffBh3Jn8hkUGZ+/6Y6QeqCZMmnDhErpFmBm2PRUi8VUYhylFuuFTmt74l+bmArPDlsQ
	edfMwkk0DeffmldViJ+B4v/o+gQroliyrh/BSuy7KwlRiJWHGScC04j+qtLYsQMwDJ4=
X-Google-Smtp-Source: AGHT+IE4Ztj3fqoFCu3fT1sr18ZtU3QldzSJQ2PYy4jRgkP/zHxGfnGiNxC0aElqmtmZKg2tXOMIXA==
X-Received: by 2002:a5d:6481:0:b0:38f:31fe:6d23 with SMTP id ffacd0b85a97d-38f33f2e91cmr13677516f8f.23.1739905619006;
        Tue, 18 Feb 2025 11:06:59 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43991c84fa4sm36268225e9.39.2025.02.18.11.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:06:58 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/15] clk: sunxi-ng: a523: Add support for bus clocks
Date: Tue, 18 Feb 2025 20:06:56 +0100
Message-ID: <10610758.nUPlyArG6x@jernej-laptop>
In-Reply-To: <20250214125359.5204-7-andre.przywara@arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <20250214125359.5204-7-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 14. februar 2025 ob 13:53:50 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> Add the basic bus clocks for the Allwinner A523 and T527 SoCs.
> This covers the AHB, APB0 and APB1 clocks. Linux is not supposed to
> change those clocks, but they are needed as parents for many other mod
> clocks.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



