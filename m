Return-Path: <linux-kernel+bounces-330871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814C97A575
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD531C21978
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2347A14EC47;
	Mon, 16 Sep 2024 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOe8Kcq3"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB0A94F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501581; cv=none; b=EM6hLpY9KU7arfyANlOEMa7s423IYXQ/kQKmyIKUZBG6eSYdnTgrStr3H7O6eOHczrhfVCXOkIHa1OL1lGcVUVk98HdYGJiLt47f5FJ5D+kQg2kNiBQGfit/lsVYtidtn8+p8AeeVC0HzIfLFyIPx1+klJFxmJnFWZkv/43sOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501581; c=relaxed/simple;
	bh=CzBVpjhXKUoL0xgLw1etM9xeyX7HCpA0ArG5AFuON5A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k68ykUCQZ4XJPIqFByjznlYB9j1aRp61G+Yvc7UgFnFQo7G8+mgknSn5HPQwyn8xBb9arFXAObQ8ZM9e7DxAIqbTjf1u3whX3rQE8nxOFv67spKgcQNkBsJwW4re86ewESr+ucYuZUoTZzSkuW6N2zRuQoo+51WmwmRkkroyuQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOe8Kcq3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so678869a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726501578; x=1727106378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CzBVpjhXKUoL0xgLw1etM9xeyX7HCpA0ArG5AFuON5A=;
        b=UOe8Kcq3lcEdrphQzzQuG6Yt/guH7hDAWdUuSDYzvLsc1qGe4D8VQQpuIb/gbR2+KL
         exkepoLoEFra5KyQ/tS6XfKfk/qTlsZFPkOr/idBC0jlgROYVXLPfo8HAqcermdJTbn4
         d29C0IHZaH2V2wT7CGUWhCqTpv2d1E+sYE3lbscsvOap7CbOAw9z5K1b99q+jrfe59Qa
         VVwcVseXvXf4SlXTWNHmqHhfGcugoXrNoU4ONdJzM10HqbNJ6aVrTGfVdJuoeIbvbxC0
         6yyK62MIqIL8KnV8QQU3P+RJG7L+7KCekLTpVTJSqRqc89MFNzwXpeVJ6LTLpJpvpOol
         dlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726501578; x=1727106378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzBVpjhXKUoL0xgLw1etM9xeyX7HCpA0ArG5AFuON5A=;
        b=odsrxF4haiog4Gk0Ka9w7fFOfrrjCjtOVyCZ0HfK441vNcUWYomZI7a1+jU6KWjodE
         xwltZi+rlLBtdryAmno4JcpPeWsoPGv1DwgqUv1CHpp8+4TxdpUxzl+0k3nh0/cyOJaK
         rgiXldk5BJ3CsWJM22Ww5ECgU2HWx+12sb+4JoKy/eQsTi1MsIZ8Y0Hf5v6eleNjZ1+D
         ZMJ66anhhXLRR0au5TJ7cfiIzT9lJce2alzfF6eP8kPIg7wgVyrW5AeX6j+herUeqxjm
         9FssdhqVgBSzdIt3b1RYUAqpSy3xbRdGbLFIqLHxjXid4GOgIp1BiEeCiGwmDskD5lpO
         bmKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfQA49QDvjCwvFhXCRDw3qTIZArr9hSzfUhSMBL3mJ+tqzjffeDLCfXLutWN3/CN2QE5iQ6DkmV3MFAAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfa2aFIlRiBgRMfobPn0ZR19qmlD8kXXotqpxaHRPHyXCFyZc
	CYuG+byMD5xSNQNOHJMuZkuw/W/OcASqGbAdHoH3G8bibgLI+5ox06Nd0uIPlq4CI6z6yrJYdt1
	AFluGK9vGvShT5UePbzWdRxJGB+M=
X-Google-Smtp-Source: AGHT+IFitERibNlCs69b508h8u87CaCZ1BGQnopfANJdJvpfiAa/nXWo8c9qjy6z7F1P46s7d1u6H27Kfm1EdACCW3U=
X-Received: by 2002:a05:6402:42c2:b0:5c4:24ce:4f8 with SMTP id
 4fb4d7f45d1cf-5c424ce075fmr9998636a12.12.1726501578015; Mon, 16 Sep 2024
 08:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: YJ Lin <0xff07@gmail.com>
Date: Mon, 16 Sep 2024 23:46:07 +0800
Message-ID: <CAHhBtNqB=jQTnY1eu8or=toczr93ehUeuBkAZ7axFPr4ZHPjCQ@mail.gmail.com>
Subject: Intend to work on the DRM_* logging macro conversion
To: sean@poorly.run, rodrigosiqueiramelo@gmail.com, mairacanal@riseup.net, 
	hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, YJ Lin <0xff07@gmail.com>
Cc: ricardo@marliere.net, skhan@linuxfoundation.org, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean and the vkms maintainers:

I=E2=80=99m Leo, currently one of the mentees of the Linux Kernel Bug Fixin=
g
Program 2024 Summer Unpaid[1]. I saw an item on the DRM TODO list
regarding "Convert logging to drm_* functions with drm_device
parameter"[2]. It also suggests reaching out to the driver maintainers
beforehand. So I=E2=80=99d like to understand your opinions toward making t=
his
conversion on the vkms driver, and I=E2=80=99d like to start working on it =
if
you consider it suitable. Thank you!

(Also, do feel free to share tips for DRM and kernel development in general=
.)

Best,
Leo

[1] https://mentorship.lfx.linuxfoundation.org/project/9c354ea7-f08e-4d85-a=
93d-94d2a3cb30c8
[2] https://www.kernel.org/doc/html/latest/gpu/todo.html#convert-logging-to=
-drm-functions-with-drm-device-parameter

