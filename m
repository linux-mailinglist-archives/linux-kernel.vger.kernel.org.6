Return-Path: <linux-kernel+bounces-543517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5EBA4D6A9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D8E16FE8C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27811FBE9D;
	Tue,  4 Mar 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKh0nY83"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69151FBC89
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077540; cv=none; b=BI+5jnPHjUH+0gBPs8FQ5SQm92zcN1J8P28MV3gNzoo2+7Ki55kQ363vItnNnntK6NSJEeEztk1bXO1472ySsKXbrEhz4kfWM2rE/Y33d5o7spq2q0XeiY8c7r3R8B8KyYb04XCGqsTMKjhaXoQ5vt4cMH+ol1CqdKMWUtpHyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077540; c=relaxed/simple;
	bh=ZYX5W2qo0J6KDJGUHsyIA03NeMoxJ75oq5Jqbs0b/UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nORvlOsMtwQBWEVL/RK97Vqn9USV7pUKfysY08X9kT4PpD399NxhvF7NIfBOaeEsf0tC5uIpeD+8O8iYwtOcYpxnMzUXgxoGRY662s3X6p3jCGnn3bHUNw8y1XSn7l4KfSDvLa1Wq2NlGE13NvDpqM4N8SMMcg33K73bKmwbWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKh0nY83; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f666c94285so48033707b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077538; x=1741682338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYX5W2qo0J6KDJGUHsyIA03NeMoxJ75oq5Jqbs0b/UM=;
        b=SKh0nY83PcwUU73o/u1Ezua1EBzHkSuz/y40gKxcOQvHz7XqxDJnHlDpCGHk7+eoMu
         OBzZaVWkiP8PcXsk8ppFzytaT40oTwvcqn+SZtNeBBRIsKM2Pz1pGh0ogAJBstaMZaHw
         meyoBDiUTaN2v+0qvPjfyoYTn+Un7VdBLj62gRfKhSUMbXgPC0rIe5mAxxvYyp0L5TxX
         atHDJz21tDKhj3/HzpSHvg0MIknYgolCS73b0tZxELalfr8e0Qk/20T3tjefiChf+KF9
         x5l2VKbOweUfd3yH74W8AwwbCkuLPoPsYOVg2lljxl5tE/nJhSTPDGZSBO/7Pec7t8/Y
         tjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077538; x=1741682338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYX5W2qo0J6KDJGUHsyIA03NeMoxJ75oq5Jqbs0b/UM=;
        b=Zd/zubpycBq4VZ0uJUcWGFYvEocVseOrsCyrAr8Ud6fbOSIRYK9TFoz60Ir/Qcnia5
         eNMOr6tc5qH6D4GMIm6j/Qi6vnaSIQVseKl9q6cFFMK9ShYXHrM6AVExN+l3vxePLwbq
         tGXXDxrz2VYy0HZnSVwf+tWJfN+D+nDX/4JdONJQKLR65X6QNPUyOevU2uMrPgDUYDgl
         hPs9hA1vLURkFg6HSXFj635jN9ynJxkPxvIyqS28qn41zeswux5T8ySv2E2DgmtiQzJY
         FauQOWcN/8GcVNIQnVBpKM7HiJxwmM+lIJVu/L0LA+mlkTpvR9tY2UCd3aIWGJcjbEue
         OEiA==
X-Forwarded-Encrypted: i=1; AJvYcCUnmNpzNEDEWh0lXxx2z01/Ik8htOMoy1PQp4gG+XBLOL0JpOsZVcgiQmtiCrnEYVhuD7WmIScir/9sw7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJp50kI1P11zQmJ+gQbzLn7FgX2vLb7kRPsuijToD2aW4PFTD
	EBxPyRe8/tISEpP63BBsMVYsLHbRJx2XdlR9wyKw5cpxQqlTRDgHCRH2RRx2URqz105G/oancVP
	Mg/DrVO0mGcEoDloHgPDbA6QRhUEDL66eXAaAGA==
X-Gm-Gg: ASbGncsFVLiw0dN3XdIbger7TggolY2717iWoyRvyYqgohSjBJ/Cp/bhfthriblsR8J
	8PtL/j/S0y/bhYYnMHtVf9AYbIMVqZlYtbYHhDZCsZo5SgFb9w7HSVg2gpJTGv6xS1egnBy3Cjg
	QHQKr3+Mdb8QyY1d4872Q0dJ3VTw==
X-Google-Smtp-Source: AGHT+IFZecsTbEQv8yIQnDTe4qYQxuFWKRYt90hdWjp7tqPlhx0s31g1I22yMpbTlBlWL9JWo4wt1mjIhLHqe4o98d4=
X-Received: by 2002:a05:690c:3341:b0:6fb:a4e6:7d35 with SMTP id
 00721157ae682-6fd4a064164mr198940787b3.9.1741077537823; Tue, 04 Mar 2025
 00:38:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-fix-a4-pinctl-v1-1-6579888b4272@amlogic.com>
In-Reply-To: <20250303-fix-a4-pinctl-v1-1-6579888b4272@amlogic.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:38:44 +0100
X-Gm-Features: AQ5f1JrqMzIuFFtin-kj4LskcpP2GXBY5HqPRMPuqc5yJUWCwELNnJQsuIXOkVY
Message-ID: <CACRpkdbbD6wLp1-m8WMnW68stz6U5GhxbJxcKAThYXWnH00u1Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: fix pin input property for a4
To: xianwei.zhao@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 8:53=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:

> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> The register of pin input attribute means the opposite.
> value of reigster meaning is 1 for input and 0 for output.
> So fix it.
>
> Fixes: 6e9be3abb78c ("pinctrl: Add driver support for Amlogic SoCs")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Patch applied!

Yours,
Linus Walleij

