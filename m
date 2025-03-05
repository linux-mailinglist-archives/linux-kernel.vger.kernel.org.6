Return-Path: <linux-kernel+bounces-547508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62287A50A44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827D1172793
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D871DD9AC;
	Wed,  5 Mar 2025 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8ZS6KpX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7FB1A5BB7;
	Wed,  5 Mar 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200633; cv=none; b=W347/qwx/OSKwtyku332G6ysP3C7hMqYrkLCi9099bTRunx+CQP95dtzceQZQehz4arcq9ygglffq8CAprshzNWfkPcM0xyfYyj/yvQpiXqTdAxwanNw6qP7VrV41B2VOi1iu7VZ8bVA6Kei6x3zkD2JeJbIupNCKpC1vzzSOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200633; c=relaxed/simple;
	bh=gQTj8Q5JHzsGXzIfa7+8g2ZZ2VR4JimKv96wf/5CAZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggyIFOCkl0oQ6vIcBK6BDkq9wZdQ3urP6oSbNceLrADBC0g4yZKHLO5f+mYlw17V8Ah05LB00M1d75Vp0rEQlqH2VcYGfH7rte0/ggfTnTFvKxDCOfKJV89dGrUpqLT4+v0IsQiujlRBAFST2MDQFo8ne6HlsuJgjjIH/XyIau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8ZS6KpX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43995b907cfso46648535e9.3;
        Wed, 05 Mar 2025 10:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741200630; x=1741805430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5H2Dkfo/vt5zHKiZMetuzkN/iESwQof/o51gqGwt4o=;
        b=C8ZS6KpXR830pkcEt18lvgyrU170W8jRLI1BgxYehBcvQ+u1DTYcs71MSVHGL94n5d
         Z2ooxhBjdiDJNtZ357L2hM6+4xNVT14ZeVQi13si7W9FXXXgfLL+hvqPf0Evupa9KUXP
         uuKUV/1psdOgXy+S1ZdUk7iO2Zl4xdy7M9owQ6dv4getJ878shmUjFLUiJbLjgHcUBju
         ExIdNRXTJXhLZyyjoSatn1z/TGQa3QAgWNKoeW0l6B96TfXaJrHqUovMtRR8t8sZDLyD
         6YBjDqIhvhOLkaWiro1rb+srQMRVu0+GEbW457UXHCHOYnC1l1d/nY3kY08bThSNY3i7
         QjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200630; x=1741805430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5H2Dkfo/vt5zHKiZMetuzkN/iESwQof/o51gqGwt4o=;
        b=g6MJbOK+tih0ZlLbiBMXFnZZYsZK0VvvYah+jZDaeUG57PcISHmEQrdcJM5xMqbUWB
         9lZPy6Xk1HTiOEpAZMNYu7vZWXxInQmxi7/kDe6l18zPNGWK30CpWSJw8mIzC9nFFEDn
         v/HV+6WKyOP+oyvspbKajRRPatQW9yRWy1OmrzH2H5raTSrnizCacwEKNe48UN+vbrCa
         H3cPlAwYFT5t9+m2iEa3ieHIGRJQosQ0Tj6ab/58QC9+L8jhSIAs37xRVfCwwqIA4Jz0
         gcEJzjQMQDY8MNNKN9PtWepw1vC6uXdPF/rMFaQmbd/LRzZ/JMr7+SIG26pq4yiRMpLI
         YifQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoeOv1x7NwS6nBYMkzCuEEC4+pU5xzfDIj3zmCT76vOFkue47kDkg9mv+6MD5iHTe7G7fqAmlNuLjcoCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKkvEskgWTzHAcaKKaJPt9m1uSQuISF2wQhZgDC9HhPRkWK5u
	vZgH3Ic605qjAJoP84g3WzR5LjjX1rqU9OIe1jd9Tha2k7Yl/hP7
X-Gm-Gg: ASbGncuvAslFCRYrLGR00P1AxsudtOSVkEX9WAdc+HVCxOEoBwd7UtyLVSSDgIYBlG5
	pnDLr2nUogQmQh5L6qHx48bZfpJd7l6oxRGJr1kYZAmYf+moWVYVCe2RROLwoxf03MUNiVMwW3Y
	KsEerndekjIJujv8dHbQTXRGMvYeWXhl6KO77SOcs0YOKRzLbIxtaLpb/wgoeN918ipwT/WNlnz
	742PCzlftJUvnRMscTUqHIRka+tlbq+GlE9ZI+M+DxYYgr3R5P/idMWUQqkhW78sPoD8NKhYbtU
	JTRK0XyymBrMcP2BVVCDllS9AFbe9oGQABMcyp/q3AoC35BGhS5mh/1nLKXTQUEKus/Lnk3mMSR
	y5Sv93E+qi++MNJkg6V6l
X-Google-Smtp-Source: AGHT+IHnaRGavcvn0zG6fKQ1AhWlIi2RHdXvleFHrMhG9CHQJjG0/o2DM0tO1YMGeqqMtj5xnwthcA==
X-Received: by 2002:a05:600c:458a:b0:439:99d1:d4a4 with SMTP id 5b1f17b1804b1-43bd29c3ecdmr34059305e9.18.1741200629617;
        Wed, 05 Mar 2025 10:50:29 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd6530f26sm20378815e9.4.2025.03.05.10.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:50:29 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 12/15] arm64: dts: allwinner: a523: add X96Q-Pro+ support
Date: Wed, 05 Mar 2025 19:50:28 +0100
Message-ID: <3805591.MHq7AAxBmi@jernej-laptop>
In-Reply-To: <20250304222309.29385-13-andre.przywara@arm.com>
References:
 <20250304222309.29385-1-andre.przywara@arm.com>
 <20250304222309.29385-13-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 4. marec 2025 ob 23:23:06 Srednjeevropski standardni =C4=8Das je=
 Andre Przywara napisal(a):
> The X96QPro+ is a TV box using the Allwinner H728 SoC. That SoC seems to
> be a package variant of the A523 family, at least it uses the same SoC
> ID and is compatible as far as we can assess.
>=20
> It comes with the following specs:
>   - Allwinner H728 SoC: 8 Arm Cortex-A55 cores, Mali-G57 MC1 GPU
>   - 2 or 4GiB DDR3L DRAM
>   - 32, 64, or 128 GiB eMMC flash
>   - AXP717 + AXP323 PMICs
>   - Gigabit Ethernet (using MAXIO PHY)
>   - HDMI port
>   - 2 * USB 2.0 ports
>   - 1 * USB 3.0 port
>   - microSD card slot
>   - TOSLINK digital audio output
>   - 3.5mm A/V port
>   - infrared sensor
>   - 7-segment display
>   - 5V barrel plug power supply
>   - power button
>=20
> The PCB provides holes for soldering a UART header or cable, this is
> connected to the debug UART0. There is another set of UART pins
> available. The board also features a FEL button (accessible through the
> 3.5mm socket) and a reset button (only accessible when case is open).
>=20
> This .dts just describes the basic peripherals as far as we support them
> at the moment. The PMIC rail assignments are reverse engineered as far
> as possible, by dumping them from a running Android system, and correlati=
ng
> them to other boards using the same SoC.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



