Return-Path: <linux-kernel+bounces-331895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D955197B28A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2594289CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C9C185935;
	Tue, 17 Sep 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVlEUNpK"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E617B4E9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588968; cv=none; b=e/H0BstqMs+pYHoYpWcj+e27en0mosAOjuQ7gv9gmgTdyekVlul21KxiVzgMoyLqukjK/IQKIl2JO5fazDrdFwlaQYyKvIqDNKhR0tCoDrXf3SYuRILd4jnIUyrlbjJoA38X3rvJOzeeJFUSyUEBBBFShr2Wku9XxPXuL5zUv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588968; c=relaxed/simple;
	bh=m/7xfKs1vDGE/IvLOmvdVBLplK1KnhXmlb6VvcXHdv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpqhPRsK2UPzYdvHofLtOUArZ9/xODcTRbhg3usP6r6nOdjontsboyewfDCDm6izf48KKbONf8DlZO3+9X5N7jnwtsyRayG07jEZ1LvMiARwWmH0ezQmOMWg3UOQs/P73j1OWsIXexdYsPANiWv6CNzY3vkx9NWJ5EgNabHLODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVlEUNpK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f763e9e759so60160001fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726588965; x=1727193765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmO+mvccPH3HoFLjdOHsVRubWAgC2YHdv7d1kMMRDLg=;
        b=lVlEUNpK2evpqyBwg+TriIbJNOwZEXvOKsWXpnNXmhSI4LQfB5iZds56GN5NY8RlMj
         RTbIhjibPc37qYVkGlZrDfXMX7X7yfDR37RqncG4RBxlAAVzqZk6d9TaXKBYOEkNH2yu
         So4kNj0yU1pMPqef/LpfEeS0tOyYY0Lcr6NLwnsjo5uouKihaFZx8yGM/5+XQYnwyF63
         7yobwbxJgNgV8cDj516J7Lqv+7VXjn/IT+3WpZRWCIEavKrcIPiMG2cykSCmlgkij/bZ
         BJekK670KHtx4cBXvExXo0itH0xjfFiw0HbnJ8WjvMqiyAPvTdPt/gYwhzwA1tVJmhWR
         0dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588965; x=1727193765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmO+mvccPH3HoFLjdOHsVRubWAgC2YHdv7d1kMMRDLg=;
        b=RWrURi4vWceCUHGXqS2WEv8zY3r24+SsBs+4sNsFm0wdO47QQT9xH6P4WvgLARuGby
         zAi5nuEKqq6sMQvIBTAexGNj+UlNEeq2fY3FXTNlPxD8cJUyZmuY3GgArVaHIn1x3uTr
         8JXULcZEQ+jdWcSXYR/LvOCghdXhkwvAxexz/fz6CMd1xeCwh2sXJeTtaVn6SYIQeS8R
         GveaSRM/XjCaijY+a2dCVU1oFfxFrDJQb4MVlCZ4KpiPkaBYp+lw5d/iJhRBl4I0++6E
         Xq0N4Af0bQUBUz/X78463bxCjr9m7Ye4OCs+1oGACAcFaw1XFpU4x734e/VnTmPHtHa/
         11Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVyOH0A2T20AntOb9qC4HIPm4FLbPyaMUHG0WEdfWkv8K6cLkjeoGwR/IMxCUD4CwF7P8J/Oaa55s5n00w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnDklEskrHPlVCxgePjjDxDbFf+S/QIe1lM3pgTe8DstPnK1bU
	nV2RI/ymUWZnh1t86UBLyjyKrf0k/FbOczAo2G+Uly7H7rU8faUc
X-Google-Smtp-Source: AGHT+IEPgD8VnvpPcMCe+0rWVyMAZssxXAum20O0qWKZ6bEljf5n74TaMyhUGEPO6EJYfZZNVvUPUQ==
X-Received: by 2002:a2e:a587:0:b0:2f7:5d73:92a3 with SMTP id 38308e7fff4ca-2f787edbc0dmr121273931fa.24.1726588964937;
        Tue, 17 Sep 2024 09:02:44 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81e2sm9862759f8f.37.2024.09.17.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:02:44 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	arthurgrillo@riseup.net,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	jeremie.dautheribes@bootlin.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	melissa.srw@gmail.com,
	miquel.raynal@bootlin.com,
	mripard@kernel.org,
	nicolejadeyee@google.com,
	rodrigosiqueiramelo@gmail.com,
	seanpaul@google.com,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 0/4] drm/vkms: Switch all vkms object to DRM managed objects
Date: Tue, 17 Sep 2024 18:02:41 +0200
Message-ID: <20240917160242.2959-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com>
References: <20240912-google-vkms-managed-v3-0-7708d6ad262d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Louis,

Thanks for making this change even more atomic.

> To simplify the memory managment this series replace all manual drm 
> object managment by drm-managed one. This way the VKMS code don't have to 
> manage it directly and the DRM core will handle the object destruction.
> 
> No functional changes are intended in this series. This series depends on 
> [1] (for writeback connector) and [2] (for cleaning code).
> 
> PATCH 1/4: Migrate connector managment to drmm
> PATCH 2/4: Migrate encoder managment to drmm
> PATCH 3/4: Migrate connector management to drm
> PATCH 4/4: Migrate writeback connector management to drm
> 
> [1]: https://lore.kernel.org/all/20240906-writeback-drmm-v1-1-01ede328182c@bootlin.com/
> [2]: https://lore.kernel.org/all/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com/
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

The 4 patches:
Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
> Changes in v3:
> - As suggested by Maxime, split the managed and the dynamic allocation 
>   parts in different series
> - To reduce the diff in this series, extract the "remove crtc index" part, 
>   see https://lore.kernel.org/all/20240906-vkms-remove-index-v1-1-3cfedd8ccb2f@bootlin.com/
> - Link to v2: https://lore.kernel.org/r/20240827-google-vkms-managed-v2-0-f41104553aeb@bootlin.com
> 
> Changes in v2:
> - Applied comments from José
> - Extract the rename vkms_output -> vkms_crtc to avoid useless changes in 
>   the last commit
> - Extract the rename to_vkms_crtc_state to
>   drm_crtc_state_to_vkms_crtc_state to avoid useless changes in last 
>   commit
> - Extract the drm_mode_crtc_set_gamma_size result check in its own commit
> - Rebased on drm-misc/drm-misc-next
> - Link to v1: https://lore.kernel.org/r/20240814-google-vkms-managed-v1-0-7ab8b8921103@bootlin.com> 

