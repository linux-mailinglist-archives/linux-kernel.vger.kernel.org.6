Return-Path: <linux-kernel+bounces-240086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F959268FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD0D1C22547
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E201369A7;
	Wed,  3 Jul 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag2FdIsj"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B11DA316
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035029; cv=none; b=OvbeUuDtQRT+vb4bsck7GH5XQH5OSPUf66JZYP2KNf2arkkc5ZOZ6ZazmEkC/gNarZq1yePNEG//1SoJcxr8Lt1p+T/OY/bQZVlgrtnwNfKiYNdHFztoKhyvPmmoycO+xU6+SflS/IwrMVnyX1Hfp8e1JmZAMVmPSy/dmH2c8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035029; c=relaxed/simple;
	bh=VIiA5YFkLx9kkDpIIM47yLE7eWb31fsjtgC8dp+lKB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCiToBOSv/Vy4z556kLK7zSqr552F0bI2kF7tWgB+J5SU6jCQ5OrpHy/UEgoD2UexaAcEkWMWc+bfCjToYsSdsCAzYdmmibT+hz7w0VUAWmBmL5NTdrk3RaTOQ0HBgVemZq6Fu3BZ8wE70DUBAqyqfE+pzOJvGc4lbe8aSC+BQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag2FdIsj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7065a2f4573so4073859b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720035027; x=1720639827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U6ngBFMEaM22hRVrjS/ul8UiOi4VYKooMxA6n2arXQ=;
        b=ag2FdIsjatlnXUvoqUMVaGo74xj/f7pvvTyrwztsyhT2L878eog6Uu4qjVgH838nvM
         xzi/4ytuXl7UACkc+tDkO6NbYDfZ7R8s+SW1hUrW71HEM1i1+5ZUojQmM+cUuhATJzjS
         cncCHIRQ141E9awhD5NvYfP2+lN7GkClI4icS63xvKwMArTyX9HgsAnoV55lEQBqIHAG
         OeXuvh/WN/LXHIeSAt4zo2Cy3atoTFfIn95nVTO0466AHUxL11YSc2aFl7fJhjjUKRTj
         JCdvELjP8TQyJgF9VussZUXARaOKUB7KA9udsnmCyC9SGc5s8aVo/yH604Bp5Biz/Oth
         r6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720035027; x=1720639827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/U6ngBFMEaM22hRVrjS/ul8UiOi4VYKooMxA6n2arXQ=;
        b=W1jlZ0PEui5t1/apzglT60axrpmKTUW4/SxEdAUPngccO4r0ujkGX8hBZPnMhuR1M3
         SXwwfnBmBn9OHTInLp0N65KlZ5IFlrPuRO3ZNp+W+nJeNCpaj3nBFtmde9jNYEhilMyq
         45o2QxalXDmPra5abnQU1zb2lcyyBcl4+IZyzE2haEEMNvVgMugXAI3wpbRRYpgottjh
         54waKkqgVBnzHbem0Gi9G5D6wpbmzNupFBIAKF60t0IZ5OrWHSOFuECs64wj9Ju871RL
         FtSXUuVIDzT+XWNV6oMA5CdmkV8r9Vqu8QR+6tzg47s/NLtDfreZcssax/xsMUCChJip
         VZ0w==
X-Forwarded-Encrypted: i=1; AJvYcCWyLDqSDtFomKBXxaHrONKJQHXrjBcsCMiPWfLjecvzbA0cLRqUZZMU/2aWjmB0oeLBciCDsatvTwg8xwG4i9UZqSJ7z/VSx6NyhfRz
X-Gm-Message-State: AOJu0Yz6oF1MkNH1yO+LS9x/XvZ9hB8AaBcWrV6zq402MQb+ri8y9nug
	JGPcrWxu4zaI+POcCmS59VS7CSFkJVBtZgUY+Ko7+uAdf1g3+3o/jQZ7gLH8jpwqWDYkemaZOMO
	hxeBHQACVntxf4EMJPDIeT9CcIVhrmw==
X-Google-Smtp-Source: AGHT+IGvFowGCy5DqP8snrHrgHcRADL1PlajGDFe7dlJJE2VbHp1mckoRqvyEJpjnbJEQ2nFa7KRFCanrM00uxzR4hk=
X-Received: by 2002:a05:6a00:178f:b0:706:5bf1:586f with SMTP id
 d2e1a72fcca58-70aaac1f08dmr13143325b3a.0.1720035027159; Wed, 03 Jul 2024
 12:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703191341.239296-1-hamza.mahfooz@amd.com>
In-Reply-To: <20240703191341.239296-1-hamza.mahfooz@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jul 2024 15:30:15 -0400
Message-ID: <CADnq5_MsjcqbCg4ZjjLEkmyu4x72e+ago9tecHBfjezvTrU8hA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add an entry for AMD DC DML
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, 
	Chaitanya Dhere <chaitanya.dhere@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:20=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.com=
> wrote:
>
> We want all DML changes to be reviewed by Chaitanya or Jun. So, add an
> entry for DML to MAINTAINERS.
>
> Suggested-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7fec8ddb8d5b..d2fb60fee7e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -950,6 +950,13 @@ S: Supported
>  T:     git https://gitlab.freedesktop.org/agd5f/linux.git
>  F:     drivers/gpu/drm/amd/display/
>
> +AMD DISPLAY CORE - DML
> +M:     Chaitanya Dhere <chaitanya.dhere@amd.com>
> +M:     Jun Lei <jun.lei@amd.com>
> +S:     Supported
> +F:     drivers/gpu/drm/amd/display/dc/dml/
> +F:     drivers/gpu/drm/amd/display/dc/dml2/
> +
>  AMD FAM15H PROCESSOR POWER MONITORING DRIVER
>  M:     Huang Rui <ray.huang@amd.com>
>  L:     linux-hwmon@vger.kernel.org
> --
> 2.45.1
>

