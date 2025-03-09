Return-Path: <linux-kernel+bounces-552938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F7CA5813F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C1C7A549C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D7F178395;
	Sun,  9 Mar 2025 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9OlqJSQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4B14A639;
	Sun,  9 Mar 2025 06:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741503290; cv=none; b=sT5o65raNzj6PcIOEZZDPknE5oKWuK139MXrF8lHYFDZiVxO7EE2YSMCA8SCFk8qRzfluAoDU0ctKllYLDDJDrNRD2z8tWouHyPJp5kLk9eJnkl0Lkv941yAZzRK2JdcaZOWGiIl4pqHwHqURWDTCIxLCP+4kubGg1gKvdMngRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741503290; c=relaxed/simple;
	bh=dR4yAwvTNJJvPEYH7CC9OJCvxPsipjkV0SH/88zcY7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+b2qadzb0m7GRpcsZ1giMKWIbZHaVcTXXk4Ak7xcG/Bx2SQy0iDIyGd/s/Z0h6EsQ86ljkDHKif8WzimSVLy9dp6xjAMnQ6u5BzDIIdjU+zE4pJwdSCWrh+aVCYnYvpRZmOchdk1SnRz2zqC/3wgFDhLZHPhflCSchaanzNlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9OlqJSQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2963dc379so11221666b.2;
        Sat, 08 Mar 2025 22:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741503287; x=1742108087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR4yAwvTNJJvPEYH7CC9OJCvxPsipjkV0SH/88zcY7c=;
        b=m9OlqJSQAodAJDvZewsWu+j5tLmiqGgsQNv2yEp8CQuvnB7ba6nC3AJieLYusedMqJ
         NdqEBfJ6XGf4mKgiAdGQwmq1rtNf00+1bi645y1HbtzioUuZCRwHjWwGx+tDPraYVBXZ
         4qC1zm4BMgoGYOZ4VQeUeVEvQC/HLI+hurSut0VBxZl9skUNA1ENqjz9xu5/sguXlO8l
         Tvn1kPCxCDRdcCMjcgmZ0CCxS24zO1z0f+MMDXGxSxNI6WMaLqf+Hnl5UpmuaNfQqmMb
         /BkAZCvgi9b2SS0W4hvmWPYqG4KQppgIvL9fP3P4v7r/1thLA1EjCJ6vKzsdrLX1e4tG
         it7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741503287; x=1742108087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR4yAwvTNJJvPEYH7CC9OJCvxPsipjkV0SH/88zcY7c=;
        b=elaiZ0K1/62QkxPl9ZwZEWlcPLPtLVZTEUptqN1EhFy0TNpsxcsPvwgfOBZClM1rNX
         d4geo8KuyB4ynvPpe0ZAIR8djsu5jMNxTtULP56aHlu6f1n4c3aNaf0ZzMP7C+iOqMFD
         4hczV0KbtNw+HxeKUjqFYdejliQfxAQem8XW/eUD+UEJZ/fmICz3rH5QjiHSFCiPvFj7
         FeLUpFyYmRUH5F3QIYfV8zpx441kJPiq4bOM5YAqhqUmZc3/8XWcfqjjrLK9RvAH3okZ
         LTFKPKYtN8yi6JCzwIpG0jtBmQrglGkqKcbUrqKc5UHun1WpLFOKK16EEHY58JuG5cvZ
         N1iA==
X-Forwarded-Encrypted: i=1; AJvYcCU5VQiU+RdlMK/M8tJN6mipgJA5C2JoR+nLjZoGsO9sHh87Reb7XQ7vr1VatGUUz35K4zC8MWWCmd62@vger.kernel.org, AJvYcCUBnd1P+iU37+9KeFrlNW9O0ctyeS7qaSh8fUbEDyQHO1BxFUZmwa0wxX2fdHKsTrsV5QPq5YdbxoC0isiV@vger.kernel.org, AJvYcCWMh60xPzIV413YCdcZYUd3l2CYcOEPWKPDD3V+WIohm+rUPUuKSlZMDZNMCQ5eu/DFSUwE9OTmIeoz@vger.kernel.org
X-Gm-Message-State: AOJu0YwDtrlIs5kgzslnV45sTPZrJyjx3MHZDghVrTX2o/yaC1zGOXk0
	eKRPpg7nS8YIi5U/Y77fpRRsbjNNYpC7uK9WvbCnH1ZK61yploNi
X-Gm-Gg: ASbGnctuJv5Qr5v0WFwjWFiFFiSJjIegtsILQ4vawvSkhm5wYH4kkaRWwk4W8SKJMsN
	3IZ1JKDo0oJWBM2m2C3F+oPB19nCed25p0yIIUT78qrTOGuK9DziGDNu1dFQmF62kA5My0AH25T
	l+xB8/8SlNmZJ1dnXtNLvJWor4237OPFjOmHrs4+vD7SsnjuQWukMS3JFKfzOHmuR6Kv1jxrJz1
	tDIZtMt+YXkwSeS9F9rIqyhctp6IwelWZwmhLcBPw4galffxg8Ch3hnoLrOES8OPLNYMG3T1Or6
	kKnmegeCvG7QL3mbHDs7za7hwSLuSnw4shJQrGcPJkGj/iUVQwenPR+XSqr0unZfbQ==
X-Google-Smtp-Source: AGHT+IHtiDp8gpMAsTaMMeg7HPNhPDz22dxUOSHPXpQ1ifUae7xqi3maop+iP8E/2ePHJtdc9InCnQ==
X-Received: by 2002:a05:6402:2353:b0:5e5:c0e7:f428 with SMTP id 4fb4d7f45d1cf-5e5e210296emr27185280a12.0.1741503287053;
        Sat, 08 Mar 2025 22:54:47 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a9303sm5027358a12.42.2025.03.08.22.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 22:54:46 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/14] clk: sunxi-ng: a523: remaining mod clocks
Date: Sun, 09 Mar 2025 07:54:44 +0100
Message-ID: <3344204.44csPzL39Z@jernej-laptop>
In-Reply-To: <20250307002628.10684-12-andre.przywara@arm.com>
References:
 <20250307002628.10684-1-andre.przywara@arm.com>
 <20250307002628.10684-12-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 7. marec 2025 ob 01:26:25 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> Add the remaining mod clocks, driving various parts of the SoC: the "LEDC"
> LED controller, the "CSI" camera interface, the "ISP" image processor,
> the DSP clock, and the "fanout" clocks, which allow to put clock signals
> on external pins.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



