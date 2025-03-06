Return-Path: <linux-kernel+bounces-549925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D227AA558B2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E214E1749C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085B925A2B5;
	Thu,  6 Mar 2025 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXFkWud3"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913820469E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296286; cv=none; b=NJAv1IrWaukfgFf9p5Hv/99EpFq4ZInPRzycfP5uYOVOsejjmFDs2oHSc4NRoFHUJAGNrkmh5aDIB+79tKaxZWRYbvYTJySNW1ZIv4OuUxVqWZVAqjbBnFPH+pySzYgNrmgzg+wM33RmlK4BXD+7JU6CaMdFv8nKddHz3z1SLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296286; c=relaxed/simple;
	bh=jTLuvp354LUCFBEjUn6vv/C+4kNgg7zXepR1kdOwbgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKI5eExTllzjizc2sHxOrnc1m4+eoBgLsD0Su7Cut8f+J1vQwePHdHBrI49rpJFh0NksRm7JAW+qt9ATsLUAcun3eye0m9OkWAG+gsB9ikJe/wJUzyg3okDF20Uk/vj/10PnXZG/cLGUhVzV0zx5t/RiBfsmSIG66iDkUhaCyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wXFkWud3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so1688598a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 13:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741296282; x=1741901082; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jTLuvp354LUCFBEjUn6vv/C+4kNgg7zXepR1kdOwbgE=;
        b=wXFkWud3PhfIWlUy5fkzJEOwlrZDkNnaB6YGUEge+KOvt6ZjwSSQrEy7pjBRDjQred
         R5ETq5KqXPFgxNLDzVdkQAuF3/oZQBfSGRO9MTQmlQ/tCHoeWkxNCALwR1HvQzu2Pkqv
         YAhfI93Fp3FG6B3vquZHZgfDcLk+oNUGmyRbudeArjG4VbGNy3cefzwQ3FQ1OVkE7MMa
         PkJzk6mmU79jTzxGgVV7/X+7a8kMsYLWEGaKUbcWnldtPrjVWQi4FbchKBU9OUjJZlhb
         SPbB83aZQXhviYubX8NMVq9y9HG3x8QXdonxI6H6PN1m4D3EX4Q8+jFPf8JN89cg2vpp
         KfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741296282; x=1741901082;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jTLuvp354LUCFBEjUn6vv/C+4kNgg7zXepR1kdOwbgE=;
        b=QA7poJjN50MBII4TMgU0RxjUxFKH4NwCal7QojYNodvDnDaYL2AgxS3p0CpwDEdwNj
         YIgEMNcXC2WygdP00lCwl9hyFPsoXmDG1RZVIHkpT+3738PldCj+pu1iu0fezjjc8dpA
         9dDAGJzBwW1jWe6N3tbTCTlc1ewWXB9Ca4cZCoMUScwWIBv4PkMkIFsGjKecfTAs+vRG
         ZGKiSgC+DtKcvmOj8koTFqql/yOav47fX10xar/gLlFNc33LjIxk4pKOjq948BkYDjx4
         yNk89dBYaZZ7i5rjdLPE+GE4a05ngZ6/YCitdTVMiz3Xvbs3tslNVhZrtPkSMV6SVdsg
         qVxA==
X-Forwarded-Encrypted: i=1; AJvYcCV1K8ijTfUPixjs6q+NxQRPLqDC+bBMMXrw/qfO2XNbbaoJpbeaSHz2W8WC4Ojg0CtCZbfvq8S7OG3sm9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cFUHkqQQtFX/zeeH6ev3y9f3/wxJYH3SxZ9SIU6cvREUH2i5
	XbJe/svQv7zEjQqatExugNPz1e3xkL703/Cd00EIIICIrNTBO06J+xwJQdhIF7s=
X-Gm-Gg: ASbGncsnRD8IbMCkCKHHcnlPpD5gZi6I8uRr5oqHdeK5wF/00tx4xp1t11spbWV8vsI
	4yF58aoDSDvfFMo1PVlyQO5WoVB/OKOkbwtS/LRYeDNWWZelcpYaGWvDDnim/CMmg1NAoyT6VHk
	S9EA3F5yCFY30n+BVG5TgWd9RoY7lGm3NG7Syn/YD+zTpmxGkCD8s66qemORzq9/VlRZ23eepdQ
	R9WFw7b8LCiBpMtpea+9++DRsCfrQC06lcBLOZj+PZ+NEPNxR8hlHiGn/mb2x2c8S68CeaHYaPR
	fDecB/0c8h/m/lyiy4BWE2nWLTzuA8SQDrQ9jdHp31fdogs=
X-Google-Smtp-Source: AGHT+IFGoQqzB1ks/w233aQfmtwjDd/f0Of8nZuLXXAF+RrDFLWTghW9hL6fr6sdxMq2SuzJeJQr4A==
X-Received: by 2002:a05:6402:42d4:b0:5e5:437c:1daf with SMTP id 4fb4d7f45d1cf-5e5e22e66e3mr857005a12.16.1741296282233;
        Thu, 06 Mar 2025 13:24:42 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a9315sm1493110a12.46.2025.03.06.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:24:41 -0800 (PST)
Message-ID: <67ad046453d722ffd80370d45f4f515a432ec327.camel@linaro.org>
Subject: Re: [PATCH v3 4/4] pinctrl: samsung: Add filter selection support
 for alive bank on gs101
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski	
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
	 <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, 	kernel-team@android.com,
 jaewon02.kim@samsung.com
Date: Thu, 06 Mar 2025 21:24:40 +0000
In-Reply-To: <20250306-pinctrl-fltcon-suspend-v3-4-f9ab4ff6a24e@linaro.org>
References: <20250306-pinctrl-fltcon-suspend-v3-0-f9ab4ff6a24e@linaro.org>
	 <20250306-pinctrl-fltcon-suspend-v3-4-f9ab4ff6a24e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 20:42 +0000, Peter Griffin wrote:
> Newer Exynos based SoCs have a filter selection bitfield in the filter
> configuration registers on alive bank pins. This allows the selection of
> a digital or analog delay filter for each pin. Add support for selecting
> and enabling the filter.
>=20
> On suspend we set the analog filter to all pins in the bank (as the
> digital filter relies on a clock). On resume the digital filter is
> reapplied to all pins in the bank. The digital filter is working via
> a clock and has an adjustable filter delay flt_width bitfield, whereas
> the analog filter uses a fixed delay.
>=20
> The filter determines to what extent signal fluctuations received through
> the pad are considered glitches.
>=20
> The code path can be exercised using
> echo mem > /sys/power/state
> And then wake the device using a eint gpio
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


