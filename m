Return-Path: <linux-kernel+bounces-179078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A8F8C5B52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 20:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78E4B20AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B01D180A94;
	Tue, 14 May 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RDG2Lk2J"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A3180A78
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712374; cv=none; b=Id/tWiqAMnf0AWM8p/yyVfXPp3N8Px0XkkgiztpqkTSGls+PTgJuYQwUfvC54RBAhY7bHSfaJmcHrTr+WRog3b9wsTwQ2ERgHUoLq50IkItPDVSr+/YD8T50lEd+d0MP2UH0226uZ3RBCQV8Jiyi1rAVSYdwCgBKDykby1NsOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712374; c=relaxed/simple;
	bh=9/KPdGRlEJrAT1NZpQ7pcVvJ7WKkVMm+m6cd6ZNvkDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ymxpkahx9oy8+gr/fqLwySpmzw9f6W0oP1pnajEYbhXkdZruK2t2lsj3hKU4DRlV8LPJizLedueR1XPeHM+mtdEZTF4KkFJjeGgD7pFRcGPg5/OTQvpyCmd479jLVAFoWMmqNxgqUNeLW9QYN9/YJppXuHdwN2xf19c8FRNVGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RDG2Lk2J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ed0abbf706so44151245ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715712372; x=1716317172; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/KPdGRlEJrAT1NZpQ7pcVvJ7WKkVMm+m6cd6ZNvkDk=;
        b=RDG2Lk2Jl+CSjnkyy/M4Al/TYbFs43XjviclVxy7zmIdQ1nZ+cGHq4uN1Rp+4m6lhL
         TIfZylGLA5uNGVIuFU6GWGntyLfKreSYPzieErscZHyA7JjuNajoXqXQXlfAYinf73Oh
         yWwo1zpFxke3/wQW0yGnMjmSi61MH7/1SYBgHT+0CiUk2V/s076fTD8/IW4rQKkmq5gC
         VVRnM4lEzq7U2xuv5h+3990D4fQ38yenObXIkDTZg+JedP9/5CvWXLeZoRYygly64bhU
         qtfxVYXy+oceuZLwzotr+gCfIhWTqfDKUwDO09oh5dcfb3XP7aY2A1GjupHjwSksZAS+
         Mnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715712372; x=1716317172;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/KPdGRlEJrAT1NZpQ7pcVvJ7WKkVMm+m6cd6ZNvkDk=;
        b=q4S25PDA7hkqV/LYG5LNBFCN7SSl0qk+QO7nMoO8MOy0jE+3xRH7NpOxcaIHtXTE6X
         7pFRl56YNPQfbh/drsuqG9mqUM2ofcX/pXJhZ0IeJtXPehnv+wOTqLngOJHY+CGDpYIs
         G0Q5jVu0SvacIYhGBr7zTGDi4XktRIXc7bisKqUrFGOfooY2at/T6Xy+KqRBNlnpO7rm
         BX3mVlFWcE2dWpmfxkWNCuk0QnxNM7t90YQGnvSHn4QCDBiGwEfNCbYlfcnBQiSK1utD
         vhYyq5G0fv0Vb+erXzfQGscJHmxFILBFyAW8m/z27aXfqTvNhUs+CNxe5RUt1eHRMclb
         mIeg==
X-Forwarded-Encrypted: i=1; AJvYcCWT7QkO3BDxD+U3GC37d6ttmPb1lmVBOF5JTLLIKhV45OlTCe4/RHAFCzIJKE2dkvbt62eVBsLDMqy8ogp2PwYWylduXbGU0W+NrZmm
X-Gm-Message-State: AOJu0YzPLbQ9WahhzmAuwwprxR1z/tp4uKE+j7vJnGgPhqWy6kVUVY6l
	+6LqJGp/7cECt5u1Scuv/0LQcU9ZDaPvyFmpR6SbSH+LbSe1ImzQfzXrut/xjgw=
X-Google-Smtp-Source: AGHT+IEoObsEKnrH0xx3C0KUfwJWip12l93lYXbuldDs11Wqv7w3vbecPBywu++IWnpGBnVA7Y7dRg==
X-Received: by 2002:a17:902:8f87:b0:1ef:35d5:e3ea with SMTP id d9443c01a7336-1ef44059ad9mr143683265ad.59.1715712372044;
        Tue, 14 May 2024 11:46:12 -0700 (PDT)
Received: from localhost (75-172-111-169.tukw.qwest.net. [75.172.111.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf316f7sm101161005ad.164.2024.05.14.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 11:46:11 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Vibhore Vardhan <vibhore@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: msp@baylibre.com, d-gole@ti.com, Vibhore
 Vardhan <vibhore@ti.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a-wakeup: Enable RTC node
In-Reply-To: <20240429184445.14876-1-vibhore@ti.com>
References: <20240429184445.14876-1-vibhore@ti.com>
Date: Tue, 14 May 2024 11:46:10 -0700
Message-ID: <7hcypo44gd.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vibhore Vardhan <vibhore@ti.com> writes:

> On-chip RTC is used as a wakeup source on am62a board designs. This
> patch removes the disabled status property to enable the RTC node.
>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

