Return-Path: <linux-kernel+bounces-299222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3395D1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23492B29D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C014518BC3D;
	Fri, 23 Aug 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8ZlJ+El"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE551885A2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427517; cv=none; b=hNwbjGOEPgLzRS0N8XI6fO3YfIHg58eSUEvm5obHmV2Uwbxt6CXpx6H34CWhyb9RMkftgYD4SFv47fLT77mdo7N5frwky70QV+7zX4uxbAi81nz715gQBb2XR5CMYe8olBsGWlOOJ3pYeRMbX2Er3wnGjUwPOXUFSF1ArQTVlqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427517; c=relaxed/simple;
	bh=O1aWP5ST7eabEAmdy9MKRcrR2g/nQXN2UIw338entCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aU0VzhzVysQ5keLpUKM9bFYT8E96r53aqxMEyw4sJ5RHBO3RQqnzz0yDuyilpz1wt18QCy4RNSXBAAboC5gvRKeYfBxUw/PQXOd8jys+T295ePrQfBlcSzJnKfQ7Mrpcmv6BUkM6aqRC14XhbbRewlB1FPmd5n7KNtT96F2Wz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q8ZlJ+El; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3e071eb64so31336791fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724427513; x=1725032313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1aWP5ST7eabEAmdy9MKRcrR2g/nQXN2UIw338entCE=;
        b=Q8ZlJ+ElQV+M4fz4TtJdjwMQjq1O4jGDqQshJ4EF3xd+4lNA/ZkZF3VJSLR5sxvAFe
         E7uP5hRjGrYAnNm1vsRvWvmXm/GfZKKyYqeOEDDzylEUpCQ4LjqOqVohitGtx7ne3X2S
         J6cGwisloAFyFFnscH47uZh1IEUcS0B27V/kbjLiWpt6Jjhpk1P2YOjqBp/YrRbK+2Bb
         fNaN7rzhbo8Kgv31IcKVhU0raPlRed8CnWONMkfZ3yDoQ4/PS8+04+Sg6DN/6WwA+72j
         QhcNPfjV9U5GcaPKSvFjCU7x9ywR+OZGP0ALRdhQB5+j3ljt8958ykMlt/KmAZfvkwQ0
         e6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724427513; x=1725032313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1aWP5ST7eabEAmdy9MKRcrR2g/nQXN2UIw338entCE=;
        b=ZMTFl/aftdc5wL0UqZizfpAfyzUDmne5CFMnMzBKQy30e2pdpzIT2qn9kuXkRF3KlA
         f01T6qUSI2m1ZRX3dJtuIJoCEECJfR1KbRe+THAFOfnjAKL8Jlwpyl0jolwRui/kPmJm
         Vq2NSrbBVCN/qBOoItXSxF5ko93D1hOQAO6DZkAC+9mbRmHM9Ld0sws/qs7vCVLF+hKK
         /umQwf0oQktQww8oDZCO21iVGOT7L6AAipJ6efPjjy+45gpcYJI/GNzufcKj6yicUx1j
         x48i6ysWEMIK1jVQB6HINPPOj0kxKsbfjfABd4sT8DzZ4oSD8VaVoehQDRedA1wIT168
         aAzg==
X-Forwarded-Encrypted: i=1; AJvYcCXZPhedAUsAuQZtNg0AAI+ks6PILjdn0qR9QowLP34aKk/fEDs5FKed8PlmsD3ru0LFhIFgEHb+SXiZqVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcV7xesSTmNTp9K5V6oRB6pJqAP6NsXjMZpvnh3BomD1JBe65Q
	y/KU3WktJAMpmzJ5DsFxrVwc00lU6Si8HXC8Z07kNECogFpI5XdxbL0yChjPceNlvALmXzx8n7B
	WyRQzj4YXsDFneglTGNQL90UX1duLEVw/CqMSnw==
X-Google-Smtp-Source: AGHT+IGoetHNeUNRdUhqkqZzFJx0tdmOHprFon9EuHG0B3EcAz/iUjVn5fTsqlDFXz4Pq7FWblIoahHetuYR1hUHo0I=
X-Received: by 2002:a05:6512:b22:b0:52c:ddef:4eb7 with SMTP id
 2adb3069b0e04-53438846f4cmr2384658e87.20.1724427512959; Fri, 23 Aug 2024
 08:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731191312.1710417-23-robh@kernel.org>
In-Reply-To: <20240731191312.1710417-23-robh@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Aug 2024 17:38:22 +0200
Message-ID: <CACRpkdYDn80SnyihbibDaEMf08F19G-uPCd3Pywcie5Dv13eZQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Use of_property_read_bool()
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 9:14=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:

> Use of_property_read_bool() to read boolean properties rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij

