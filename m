Return-Path: <linux-kernel+bounces-519082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178F4A397B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1451C1895D90
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7B23C376;
	Tue, 18 Feb 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzZAYZ5D"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2723AE7E;
	Tue, 18 Feb 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872346; cv=none; b=Ri0jAB+eb1tyB0bgRfGik8z8pw9yugdOqofnUtIJtLjBRgppYWk4mxTkpOWcgIAS6jrHv+Y4IK2oq6LLeVXJuBtPKVkLIpa8xyg4YSZZOLQFlwL/lIbaUBc8SrVvSxrfADwanq4ziW+oVZE9xPHG7btPtx4OkeyoLVDqbFWSmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872346; c=relaxed/simple;
	bh=kXE7lzO8tAK+W+95G0EGctHj7HaDXe4ZOUjtDp40SHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4eX+3vtXIjAQCy14oydBs81/ixrB3zi1uOfiervRDkxfuwu/hyEyhQO6Aad8ABFmMiZEz4nllYOFZGZrL++8B2HWLI8el3GSqPHJHUkyDz+aVdfpoIezWIqPd5fKkpLMTz2DEEGNr2VjtnOZDZgy7TDtSgJxr2S6NAqeJizIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzZAYZ5D; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-218c8ac69faso10699095ad.3;
        Tue, 18 Feb 2025 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739872344; x=1740477144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXE7lzO8tAK+W+95G0EGctHj7HaDXe4ZOUjtDp40SHU=;
        b=WzZAYZ5DH5EuJ8L96HElxvHkGex3Bx6xkZlJcZidaRXvcAo6TUVw6bXCcxv71CKZMw
         FqBqw7lJ8Ioa5aVx3nUZC23obfQUH2wVgevqHgOkoL1tMympDdUz6ImMy4ESw7GBQQuC
         thAMGRdZgemg+k6F605wHBbSrRVk8+qwhIv/I9kH0PO/OhGWp5DPSZ3qfqUI/rKQPPyv
         A634SfD+es0+7QK9FjhdlvoQPtvch4KNBq9qEi70eHL8rSdFwq5P/AHfHHJRHR/rwstQ
         AEY+lcGzvsTnBhKyngvHtq3Z9K5JVUHABZXpUeChpITVTbqPdcHvjXipUtCe8MTLzWCE
         yWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739872344; x=1740477144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXE7lzO8tAK+W+95G0EGctHj7HaDXe4ZOUjtDp40SHU=;
        b=j4rvTiF21Smj3xiORd9i4YXzSPsTZI5kyBnoRjUEBvXt82Lo/2i3sE6GrUF4kw/Jvx
         C8ePtJPKtt5C+WC1EIxjdDqVzpQnt0RKcvvOddeVMfdIn16LVMnpO5i3uh3KFPU572f7
         vn7er/yK4EeVlqSBUQNGJGQ2XQhUrq3FQ5Bw3INOWs4/yhgZnANQqCHhu60KdCKTl0dO
         Ip6ArTCVKMz4trWMbpZ6A9j4nt8o3erC8kQMaAbZGtnNwKb+RY9Bb6bOCZsDXiXI7xne
         nUQURYJ+Nj8NgIbZt3bFRhgHFBT1GJEzEfXMqIXPCgFvf4Finw6weFqgP9jJGY1rzuj9
         fYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXld1a2asvN3FHTQej7xdvsc0DjwHzkUHc5tI0iNPDMOlMxNmextBMdMohRQrJVI77uqgukvYBoh0c/yTBa@vger.kernel.org, AJvYcCXxIuzWX2wtOzVBp/zE0/iBiGlqPY9SKd2UJ8ZGRiRWX8v3h3bUeaIJpkdr/CfqQ+XAK+cAFlRi2dyM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Wd2ffVu5IV6epwO9jqRum1dnhjh3m/3o8G9pEL108Yh/wiiM
	ns4XouBq6MlB3ebx9xamjVTgvwNYa8HqashDUF5Nfh0fa9iD10dG
X-Gm-Gg: ASbGncsBw2M2FW6xWjjQonpp21aipQbKQdvkmqS4Y3TkMsWUSS2LD/pcXKXXlk3v51X
	oOoLeT20REYwet3UWcDJz2ahuaecdxx6wqvxpgCwW4ooT3YO72xtjVeoB1Wc8viCJg43sK4pxDQ
	q5Zn9JMBjnlfqjiYp8yjQzL8b4EW9q4+U+fA9mChXF3JDZLzj19DTGgVX6CRLUgJCqFa0EvhCrn
	ohXSzpf0yVg6LMROYNwUkdQb+EsGNVEQR5md/aylqzcDojK/PLkiWa3jMPjEzul0vVDEc9+e5VT
	4hR/tCHsqHvJuxGdzG3x
X-Google-Smtp-Source: AGHT+IHMok0RZ+xEpPKwmA/x6p5MJpbMNsZxQZEpx8+bc1wEOXS9InOWhw+MuPI9x2Y6TY782k+mrw==
X-Received: by 2002:a05:6a21:998d:b0:1ed:ac86:8f94 with SMTP id adf61e73a8af0-1ee8caac786mr8600343637.1.1739872343886;
        Tue, 18 Feb 2025 01:52:23 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324276171fsm10031640b3a.144.2025.02.18.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 01:52:23 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: cristian.ciocaltea@collabora.com
Cc: airlied@gmail.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	kernel@collabora.com,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	robh@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source to VOP2 on RK3588
Date: Tue, 18 Feb 2025 17:52:16 +0800
Message-ID: <20250218095216.1253498-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b3234ce-4526-4735-b9c0-c242e6cc3cf0@collabora.com>
References: <1b3234ce-4526-4735-b9c0-c242e6cc3cf0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Cristian,

No matter one or two hdmi ports the rk3588 boards have, most of
devicetrees in mainline kernel only have hdmi0 supported. After applying
this patch their hdmi0 support is broken.

So I recommend moving the vop clk part to board level devicetree.
Then support of hdmi0 won't be broken, and board maintainers can add
HDMI1 PHY PLL clk when they are adding hdmi1 support. I can add support
for orangepi 5 max and armsom w3 for reference by other developers.

Best regards,
Jianfeng

