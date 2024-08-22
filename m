Return-Path: <linux-kernel+bounces-296869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBF395B001
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2AB1F237FE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB2170A18;
	Thu, 22 Aug 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XQzLSx/H"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFA16E86F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314515; cv=none; b=lzdbr8PXpctnb32P8VKVhsDF1IFpAdNYRYCPUuk4FCigJILGUMi2SlZ1QjcH6xeSJsrMswSH86yX5yDbHhA1BW1z4ruhXkkLoX7A5pFx27LM/kKtKyWUeLs5CQzF6g3IQ2nD/BKzVdE1CPxtyTRFdE3KObY1LxxeNrP1xAAE4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314515; c=relaxed/simple;
	bh=LQg2LikSVh4t6qUG9/JiYVMdVBSK+0WTTilbAKFAUcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnBbQagjYMujFrFWCB0e89z0u9E774Mo2p00KU40AguRieyTZouSx8afcDUBX9JT25us11pGdPkbdRAlE/FGAXR1HQtl0awjqpj/4Cy8nxFSmSgjx2ga/WMZdd9R5zEPNjOoUqTH/gYYdLeofxfvWG10D8WYFRZ0Zt1ifC1qCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XQzLSx/H; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-533462b9428so838271e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724314511; x=1724919311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uqbG4nW5Y6BHbHkXKVf6nVFJEVL3TwPzeJDq6NPW2qo=;
        b=XQzLSx/HKg+X/ALxTZuew+UMnOIvTcvEafXLyYr6F3tj7P2jigajL/ve5ujEdLQimN
         Ld9+g1C2Kc5tk6F+d4KLKrjybHnRnXiIZJJXOhWVWt8Svq0n64QA6+7+qYF0WtPJNyTr
         e95OtRO2q6fa71+l6fQgp3YnZgM/JqgkI+i00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314511; x=1724919311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqbG4nW5Y6BHbHkXKVf6nVFJEVL3TwPzeJDq6NPW2qo=;
        b=FBoktWHnM2IJyo9gKuSEHsNY0y5lXT7FSx/ibyxV53AbE7Cm711SoYsfNVLIfT2f1+
         3FQQ7v6VwJ0MgF1nfV0T1E1lzpykxGJDXD/diKE+fWY80fICdulabalxi4iqeFBKb3pf
         jY4J56+wBOCCwe6e4xSllZ3uXVM/UFOcrS1MtWCESjkyRdmf30+KCPvE+qZDlagenT/K
         iSdQZzC09PESLd1K7Y1w3Md5nwMK4W7D5zTpA8+YWqwFwK46rYgr0QmskbczAmGpdbdU
         3i4qDIVwCvj+qRi4AaCRH3dyj1T7LPyWKsn5jAReE7x2wnLcbnQ4gOXNxc2rgyag5WP6
         9KcA==
X-Forwarded-Encrypted: i=1; AJvYcCUQYEc0nSIaMVvPfW8ZqVWKYzgMmwLB6db54eWYvTcsu6LZA57xuXuUZTbHjIbpVTnkExNWvsA1VQzGFgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0xKxC/gaoewo4C710kOFvVnWw7PURe4h0fRNnAPg3LDMM2uIr
	ygabAmJ72btAWHWkBI3g3fWBJtXzMEHsffHFJ6MX/Y3lE97WawbPHmryqrYPSH3vKOlZ7xetVBz
	+HozSCFAV4rB7G94ysd9q9c1MYM3O8rXqR/GBFA==
X-Google-Smtp-Source: AGHT+IGeEsWLwDn62Q3uOu1kuIfreyy7/gjPN+p1rXMKUOBZDfj3t2/mNoyV7SIAvs0yR/zP1E2sixQmJRRO8bfS9r8=
X-Received: by 2002:a05:6512:b06:b0:52e:73f5:b7c4 with SMTP id
 2adb3069b0e04-5334fd4cbc5mr917514e87.37.1724314511188; Thu, 22 Aug 2024
 01:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-5-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-5-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:14:58 +0200
Message-ID: <CAJfpegvx2nyVpp4kHaxt=VwBb3U4=7GM-pjW_8bu+fm_N8diHQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] overlayfs: Document critical override_creds() operations
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Add a comment to these operations that cannot use the _light version
> of override_creds()/revert_creds(), because during the critical
> section the struct cred .usage counter might be modified.

Why is it a problem if the usage counter is modified?  Why is the
counter modified in each of these cases?

Thanks,
Miklos

