Return-Path: <linux-kernel+bounces-223517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE48911455
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC12E284E14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBD97711C;
	Thu, 20 Jun 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i285cvu5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DE576041
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918511; cv=none; b=bYMqPU3RHfXeF6HjO8MF/eWrDGX8RMoYSz8x97PWL0NbNarSsGy0gRPOiZWZ0nf46+YYA0zgi5zKHGLb04F6ZEmQf6EMb2a7NgseFkFTweIrF0gUBSIpkrcQJOqyL/PYFVQU1n5lHfRQHI+d9ybGkPfRxVefEiUJfyCHWaSIabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918511; c=relaxed/simple;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byC0kZJ6V3oxu+3in+Rubsyj12CL8Ut9dht3O6cLDdA2TMxKwPbY9FCCcGQumaYs5NTyeEv+USBe0sqFEm6o/QOQAWI8/8l5v7xZYwzyt3xNnmehCbHJcNcecja2IO3o0g/Knqc3+KSGi7ozA8mvqjrWG9yPfIYL1CJjgkBS7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i285cvu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718918508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
	b=i285cvu534zOKsymJLhHt25hcPcUQ1cGr22RagnRn65Ux9Hv7kocqzUqAjo1XgXZOcmNug
	A6WOjrpM9DcMTl/OkikE3v9mVJxhBH6EBMjc8azIzMigbEJgzIU8/Nkx2gl0FFkynPXW3n
	JNC0bo5H/Myn45K5c5CeSp9nvdZ5+0g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-r6XSgOx4Ny2u8Pfa1aTWzg-1; Thu, 20 Jun 2024 17:21:46 -0400
X-MC-Unique: r6XSgOx4Ny2u8Pfa1aTWzg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f33c7ba07so67509866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918505; x=1719523305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
        b=cj2OKD1Lzn/jqGWN3rbHd1ZE1IYPD7gDrhmf5l4LTt9HonnXWB7CAEJrJyFdwb0Smh
         G97J900HzVNu4kDPjBlwpLevzVNhUq5ZVwC7RyZF59WHkVaNCbF1eCpAVIoPoL7yAmmw
         oXoBDl4ORpi1KRXr3BJP/6IHDFFCOvh08X6g85LYL5QE10TlpVYExtGx6PZjmuimR/+k
         4tEKKgDQisaxZtopH+gC8LMjGeUklRhtPAimUnDfBx9X0UjC+pXCQ05Ie8omdFvhoY48
         SGxCnJZMyxSuD1rHUmtfdpmeyk4VG53ml2XtIOyHF3qbEcvkW6S+WMnx/Q/Q0XBVNajI
         u0vg==
X-Forwarded-Encrypted: i=1; AJvYcCX+DfOuE01xU1Upb4+aQgp0kZErY2/CNmuasJPmRnWx/pzjD+2Rj1lW4Cf+iiQVbmw3y7wRiRAK5puBxV6Li+/sYxBGj/0ekqjtpSRH
X-Gm-Message-State: AOJu0YwKsFSV9Dv1l4R8XhNFPB8ZCyzTGS47VnmbAfJ8S4glvuBLbiHE
	T9KeIhSKu0dD2rweY9B3HDTDSZABlV4aWLFsPWtjHDzAmz8n/TDqnOHjzxmz+QtoHzSiuIULmtW
	/Gad+yLMtrDCH+IqJPgvo74lRvTjn8mRpiHNj+8Qr/MQUkJGlmfKKn3yfVpceBQ==
X-Received: by 2002:a17:906:3e8f:b0:a6f:38:6968 with SMTP id a640c23a62f3a-a6fab645136mr368399366b.32.1718918505184;
        Thu, 20 Jun 2024 14:21:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFInMUkzUyLtNJEWjuXNVwdvaGVwPshtBGyRuzXTA788k2STLElQ5LZklyOjhCpKUl4EQXQow==
X-Received: by 2002:a17:906:3e8f:b0:a6f:38:6968 with SMTP id a640c23a62f3a-a6fab645136mr368398266b.32.1718918504774;
        Thu, 20 Jun 2024 14:21:44 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428b9fsm11268566b.42.2024.06.20.14.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:21:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/mediatek: select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION=y
Date: Thu, 20 Jun 2024 23:20:52 +0200
Message-ID: <20240620212142.461771-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620054708.2230665-1-wenst@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queued, thanks.

Paolo


