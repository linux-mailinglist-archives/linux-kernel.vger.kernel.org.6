Return-Path: <linux-kernel+bounces-331892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4288897B285
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09C51F240A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C7177998;
	Tue, 17 Sep 2024 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEJRkhc8"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDB617ADFC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726588955; cv=none; b=XzuJ9i4bu4GrxF0HeSZR4a30wJTxv9dSQIeUcODVIBIIipRlQj39Zoz+RIsGCtaTBfZ/GbMsx5M/yvoDocoK+qQA6b9uxw59BL49ta9qfsfPWTYfvxuIYBOJ+E6zfPfsi4WD3ClEbA1l7TVrd7k/WRHIzGzbfO0RTPMzSMfHQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726588955; c=relaxed/simple;
	bh=5QcFkcthRwSo0PwPBxAAk/DdXDtI8BuUmLnH2Jbi0wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/INutjBUXiqCJkxkzgfNzxdqI4seN7J9CDj5sBeU4uNuO2n1DcYE9dy7J3QDPByzuvg8rr+hay22BGC98A/p1a/QDlhEA9zr7CZKrPniitak/sMVuFonsLpF0yKzZS4HP4fx66J4Dc5CIC3TUeLa0z0HlTqDXHwmL4CvIORYS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEJRkhc8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso57391515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726588951; x=1727193751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kbWVWlWmyCgkKcJ+HaZFf9kkYklQ81QL9Q+STaEbPw=;
        b=PEJRkhc8HGhjGn5vXCuIDaReZzzG6fW2uHemf0JJqzb0DA/bkEsblauFDXPyF9Z3Gq
         3HL+/0ggEF8vaYXGu2GGOpvuCq89ab8fttD0ps43jOWOoD9+HM2QDXfNdEf/jUFAU90f
         gwh/LpZM5qPbGZcKZnHfW9pjg8tvBPHMLuqXVDrh/kX3g/sCHcwv6o7eYBB3JaNcvxy/
         +1c9BkQIOXEQlGNHfH5ndQGXk2SW5+5ySX7SgdmqDvmq1QqR7cRHq75Fh7F2d7QpIld1
         xm6LPAErNCaeaRxlgECaSJDZ4RkDEI/S+yi2ooVPeTklbu9MsSZsPrY5khqTZA6Ath2u
         ELVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726588951; x=1727193751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kbWVWlWmyCgkKcJ+HaZFf9kkYklQ81QL9Q+STaEbPw=;
        b=Zdsq0PGwXINzx/aJ/VlGXg/Ly1qfz+iQs2wZHPGNMG2wSYf1owDmfmFkjPEasflG9g
         1LAqzj769DW867tsvWvnZqQqST1Z7WLD4Um+VlvjarMIusMcJqUv+Qz47B+HQPJnTDWU
         L87jDcOBb5V6dQ8iqHmPy4mo3lT83hJhv9MdKWi0zm2+pb4hfXNVQ4HhdU1omNEVREiU
         0tvVufZgJrTusGVdFPiVGkIZNmkKFvB6wIWZo0U9SjhnEN6uiX+Hy6sz7nZhmy3HztdJ
         zJipOPVw1duaNzU5G4QQ06vwNPpe2zHhw+8Cc40vDuEsEu6lTH8TTvPCVCC26e/rg+S9
         9rFA==
X-Forwarded-Encrypted: i=1; AJvYcCWX6pEuibayDm/1t6Vg8PcLve4vQpimTK9nDoE8XxKmLvzGVjS8qG+gs+4p2sYpTKacnEYNXygg3Oh1MOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywjNV03f99eRqsFEwZuZJvn6MOUCVBrmQ9nkum7oR/gAdfD16Q
	Ut78ngQHoN5Q5I0SGGgiAptuRxofv4j+GP+22cSzNVkTSMP6xAdT
X-Google-Smtp-Source: AGHT+IHTNlNyBEouYbMiOHsa8/MLBLRjXHi4/gnaqBXDyWKeQ4B86r0KXV3ir8Cn9Ma3ufcHsjMwLQ==
X-Received: by 2002:a05:600c:3b17:b0:42c:ba83:3f0e with SMTP id 5b1f17b1804b1-42cdb538c44mr159369745e9.7.1726588950632;
        Tue, 17 Sep 2024 09:02:30 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b1947e2sm144569475e9.44.2024.09.17.09.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 09:02:30 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	hamohammed.sa@gmail.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mairacanal@riseup.net,
	melissa.srw@gmail.com,
	mripard@kernel.org,
	rodrigosiqueiramelo@gmail.com,
	simona@ffwll.ch,
	thomas.petazzoni@bootlin.com,
	tzimmermann@suse.de,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] drm/vkms: Suppress context imbalance sparse warning
Date: Tue, 17 Sep 2024 18:02:24 +0200
Message-ID: <20240917160228.2933-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912-vkms-warnings-v1-1-59f3e13ea8e5@bootlin.com>
References: <20240912-vkms-warnings-v1-1-59f3e13ea8e5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Louis,

> The functions `vkms_crtc_atomic_begin` and `vkms_crtc_atomic_flush` are
> responsible for locking and unlocking a mutex, respectively. Add the
> `__acquires` and `__releases` annotations to these functions to prevent
> the associated sparse warning about context imbalance.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Thanks for fixing this warning. Tested it and I can confirm that these
warnings are fixed now:

  drivers/gpu/drm/vkms/vkms_crtc.c:233:13: warning: context imbalance in 'vkms_crtc_atomic_begin' - wrong count at exit
  drivers/gpu/drm/vkms/vkms_crtc.c:262:39: warning: context imbalance in 'vkms_crtc_atomic_flush' - unexpected unlock

Feel free to add:
Reviewed-by: José Expósito <jose.exposito89@gmail.com>

> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> 
> ---
> base-commit: d2194256049910d286cd6c308c2689df521d8842
> change-id: 20240912-vkms-warnings-e0e331bc5e6d
> 
> Best regards,
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 40b4d084e3ceef9e1e24b7338efdd9253afee8d6..2ad164b518fb93f5b6b86948116ff7ed97770b60 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -232,6 +232,7 @@ static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
>  				   struct drm_atomic_state *state)
> +	__acquires(&vkms_output->lock)
>  {
>  	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
>  
> @@ -243,6 +244,7 @@ static void vkms_crtc_atomic_begin(struct drm_crtc *crtc,
>  
>  static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
>  				   struct drm_atomic_state *state)
> +	__releases(&vkms_output->lock)
>  {
>  	struct vkms_output *vkms_output = drm_crtc_to_vkms_output(crtc);
>  
> 

