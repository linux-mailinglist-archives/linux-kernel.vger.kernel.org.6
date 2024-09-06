Return-Path: <linux-kernel+bounces-318030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9696E75B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA971C23290
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F8B1BDE6;
	Fri,  6 Sep 2024 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnQ+WfmD"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175A10E0
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 01:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587178; cv=none; b=aP86olpTURe2U5C9tyS3ZcpX3aFgxDFNBoPeYfrt9oTms2HMuDAG8touAULaCvw09nU73sTJhGOd5ifrd9E1z/zQYBDgWosxsEu4zpTGsTruVlptNl16usXAf5Wax/5rAITXqGhaeUpRZZ6kgFVvXfWT9FuXzgVN6eCb0iS85/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587178; c=relaxed/simple;
	bh=U52adYQlvuMR7+RUlygia/EjbR8uM8aQF8WKlzEJLT0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DRW1p9IvnxpHksk6LLlVHNhskU31hPxuK6zQLsf7Mx25FkoUcsEvydKJZ7WMupDe/GkLywo7qAaWm2SeaKVTGFr7pgCYT3rJ8PbBOJAZusLXqVeDiigfryRe3uJC60RT5ZddWhbrGm01TWM4hPKqN5b9Jq2JRkTQL5d6PPutcOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnQ+WfmD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-717929b671eso1074095b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 18:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725587176; x=1726191976; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UwnV3rN27k13ClzZkPYxKb2bde4aYZdPIxzu2F5jqrY=;
        b=lnQ+WfmDX3CKW65ibFfkX4z0GZxv+hHYnScnd3N/ZBefvEkr2xkRdlnrgzN4Yb3ZWC
         Dcx8WseYlwSBuwgkl44Qg/T8LeQ1+nRkoyfiO4Ua3+w0m2EM97DXy+TUz3l0BUhJbm0R
         bVjWFKuYrpAhcd21ZFHsqwLBgaNpN846JLbhSwG9cfPEBbYYl72LKOjFN081CPWxCOfv
         Nfu9Hzg0ftKknqnBXE99utN8EOpwOdM66YbRYzZTylrVUOnHx6PYBAKkAVXUhwH5W57b
         SY2Sh/fExbIdS5+TnUFRmhkGAulcDwkObBpgUoakzLPF4r1/m+3T7PQDL2mrsHSn//HN
         vSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725587176; x=1726191976;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwnV3rN27k13ClzZkPYxKb2bde4aYZdPIxzu2F5jqrY=;
        b=kc4Hqn0Qcsz50Z7nXC4LtLHPq4fEHUELgYoCNm6McViTZatHqvJPL+GqpTzMJor3sJ
         wg69FQaVi/2D6MDPc1YfJUfKykgYmMo8oXnDyS+yQ25PbxwPgB/AGw+Oqn6g6tJX/yyb
         dREIzj77MncHFv4Fn8FgEFFqf8lTNCyy0at/psyLEhP+IIEjLSP2g+u1m6++IOYl7zlc
         kZNujL92p0PZJlcIc2w71ZhgPLL708BQdAOirKi65DhC8HjXPjTY7SuuQN5X+vFuyrr/
         RThxRRKR+4nLkNizb+cB95PsEh5EbJQ2k6ANMeHd1OnXg95P3GdOaDo5XJiLUmsGJ0qY
         HVHA==
X-Forwarded-Encrypted: i=1; AJvYcCWmISHZvjuJcAI12KkgP9SxXF5soejcqUsbw/zIICTmJbB+gLL4ErCDI7kbQXj8rZ3ww7jVRP5bYlVPCmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMMkva9qw1NlTckH47XP3PET3Q1bE3xX+uWBOfcV/0/vmOn3Z
	bakYWkWjhM2C3OdaCJBTVZke4tFdIQOSTbZFwdjgXzJrCFDx/dR4C4XiRdn8x5l2TfiXUefKBwQ
	sihGIYPCSVkkZ39kIUDK9K0SPltk=
X-Google-Smtp-Source: AGHT+IEhczTHvvDjVeg6Pvbvn7UtOLZBLuPzW6GomhWkIzl2gBVFJydJN91+AvoJ8LIJzWan+AkZyr71ZFB4mf7Tiyo=
X-Received: by 2002:a05:6a20:e617:b0:1bd:288f:e8b4 with SMTP id
 adf61e73a8af0-1cce0fea606mr26332456637.7.1725587176167; Thu, 05 Sep 2024
 18:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adam Ford <aford173@gmail.com>
Date: Thu, 5 Sep 2024 20:46:05 -0500
Message-ID: <CAHCN7xLL4hrTK1OqsqUa78cdp9ZcG0sC+cO5QKC3x_Y9-QVzSA@mail.gmail.com>
Subject: i.MX8MP IMX-LCDIF Underrun Question(s)
To: imx@lists.linux.dev, Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	arm-soc <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Schrempf Frieder <frieder.schrempf@kontron.de>, 
	Dominique MARTINET <dominique.martinet@atmark-techno.com>
Content-Type: text/plain; charset="UTF-8"

I have been testing various settings on the HDMI out of the i.MX8MP.

I noticed that sometimes my monitor would not sync, but sometimes it
would on the same resolution/refresh rate.  Frieder noted the LCDIF
was sometimes underflowing, so read up on it a little bit.

In the comments of the LCDIF driver, it's noted:
    Set FIFO Panic watermarks, low 1/3, high 2/3 .

However, in the downstream kernels, NXP changes the threshold to 1/2
and 3/4 on the LCDIF that drives the HDMI, while leaving the other
LCDIF interfaces at the default.

When I increased the threshold to 1/2 and 3/4, it appeared that
several resolutions that my monitor was struggling to sync started
working, and it appeared to sync faster.  I don't have an HDMI
analyzer, so I cannot verify much beyond knowing if my monitor can or
cannot sync.

Could the threshold and underrun cause this monitor intermittent
issue, or would this be something else?

Does it make sense to have a flag or device tree option to override
the default thresholds to change the panic level?

adam

