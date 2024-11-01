Return-Path: <linux-kernel+bounces-391826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED619B8C19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704571C21F4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDFE154C0F;
	Fri,  1 Nov 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a3rqP5Jw"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348D55896
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730446400; cv=none; b=CF9oEArfrMgUlbcXN/Avb2ZPTshiF5RaXt4t92IA2jsJqKuFZGIhLGPm+06fFjlxRabC+blNg6deh9JhuQj703rwljOZDc1E1NDdF10/07mUONdU3adc3vfkB3bkgaLy4pnEm1H7A5g94UOw/nb6uVoIOy5ze9geSFvL98ZWedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730446400; c=relaxed/simple;
	bh=qhFGRLaHaBNiKLE73NcljBTb7losW4d4S7ofVT6kuvI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n8Iztw+5dtVIjC0AhdscRHsHlgDf68SHI4Umkm7vgWE4KzMLWnXbVl3geY8vEST0qfwSWLwzB8WbErYQyZssUu75xDIkrlVv/Kiv1MMBX2HWIoJDJK0qi3JkD4fif/RbAnhD2PJLWoumvC82QbMG9ACajMIs6Ih5rKBXlHz3jzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a3rqP5Jw; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7180c7a4e02so807987a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730446397; x=1731051197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0cXB2oLG+I0p8wPr8eMU8Ys0SYe6ZSBDu+SHl0SmyM=;
        b=a3rqP5JwO3tWoKwueGq2QyuDFe/fop1BbMfLLKhQa7g8cNRa0shJqZk9zd3BitBcoy
         EuFX3LBMjw6il+4GcVRYceKRkunZ1UaG0fbH6fahT0b4ntnV349MMFpoAvm6qyj/YGzu
         oZKr1MhAD0lUNOrayMqG5381cUPHpnLmAQLP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730446397; x=1731051197;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0cXB2oLG+I0p8wPr8eMU8Ys0SYe6ZSBDu+SHl0SmyM=;
        b=ir3khTOqKwYDxlDhtLFYrzAVKAhpUIJbVNR3b1WhccVT4H7lvVJ6Mtc6WUXhcYzHdD
         AJ36YHgTze0KPE5dQJE+Fw2wbdTEinf1+pdyLbYlJGtsMzF8rY+uqpP586HMVCMbyf3y
         Z/OdtMkevWZb+BH47BRBbh27iAnnydHICfVCaI8TleZfrpf8ooQmLThJSuWT/uF/rvtB
         r7aIWgmLqBWnzT7bGkjk5KXFNZOCLxVLeiIIpS74aW47N7yKvHHRD9JX0akDekXIGZ/h
         SZG2GBAfqydpVjSvmS1jIikYPSQfgAkl7UBiLjPx0WtMX1uGJ+PwJzusEeyrNckXEHKz
         xflg==
X-Forwarded-Encrypted: i=1; AJvYcCWr2P54qBkMrinPGV2Uv9OvJZoMYjjrigD/bxMwK5LyvvV1TA0NaYMBtS1dpZbPtyuFTx19yqcrVgNNoUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfS47dN4LjDH/Q6LDjyET7WLlonxRffaaJuJZ6DkjIPOIyrtSn
	ciRwtWfNZv4gaLc+ntR7AixRAdXT4+Wb/cBC+/RkDNa8C9CAB23FZinQMjXGHyZv+MFK5v/x2vw
	=
X-Google-Smtp-Source: AGHT+IF7PmhAZPjT6v19uhaxDIcL8ZqQPNKppM7diN4JF6fjnpDhQzbGaadEPd6E9VLB8W0ZrCAg1A==
X-Received: by 2002:a05:6830:43a3:b0:713:ce15:d4d3 with SMTP id 46e09a7af769-71867f1bcfdmr20115290a34.1.1730446397237;
        Fri, 01 Nov 2024 00:33:17 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8ad8:6f24:a74a:4668])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45297636sm2003601a12.12.2024.11.01.00.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:33:16 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
In-Reply-To: <20241029111309.737263-1-wenst@chromium.org>
References: <20241029111309.737263-1-wenst@chromium.org>
Subject: Re: [PATCH] drm/mediatek: Drop dependency on ARM
Message-Id: <173044639489.1615222.7952709085038498555.b4-ty@chromium.org>
Date: Fri, 01 Nov 2024 15:33:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 29 Oct 2024 19:13:07 +0800, Chen-Yu Tsai wrote:
> The recent attempt to make the MediaTek DRM driver build for non-ARM
> compile tests made the driver unbuildable for arm64 platforms. Since
> this is used on both ARM and arm64 platforms, just drop the dependency
> on ARM.
> 
> 

Applied, thanks!

[1/1] drm/mediatek: Drop dependency on ARM
      commit: 89115aeecf38bfee3c5e79561b5c34a256e1a06a

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>


