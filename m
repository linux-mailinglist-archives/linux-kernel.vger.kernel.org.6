Return-Path: <linux-kernel+bounces-183883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46388C9F51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59311C20E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCE1369AF;
	Mon, 20 May 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1lTF429"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864F28E7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716217671; cv=none; b=Odq6FlTkWfsE7Upxt3o1FMselno8+Wb9igTSivcIwU6UY1rsIQFm+Nzp9TvELMbi1KeOODebb+DuDSea2XpMazohfcQzCIh3OfeqnJKsAmjmxmSySBZ8Rv+THAQjwHUlASSD2FSLS4Qgj53ZwgYKsZp/yUHjy45WJ5YbS34b6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716217671; c=relaxed/simple;
	bh=DY0GU6upOgiDDmylYzIWrHNWZ+2ZmWy8gOFdxID9q6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9eKqukOxtPOO5HyCxieRzVVurcqUSBC18K+3vfXzPY4XA1vnGzbV+JjaCHe+MaFuyasKKGdW//nYuTcF3MoYevQT3MiApszfMTBwksrZf63MxmbWb/Z/Y8iS7s4+2/NTYR08czxwfoal8ctks08crpEbc9GXk6Ojg44mUkh1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1lTF429; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ec41d82b8bso87779505ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716217669; x=1716822469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhwVQj77q9WsVa/PNIbqf67vLZaFOrT0DXfZ5Ha2VXE=;
        b=P1lTF429HedmKVy7wr1i/Ud2V3cZC9fl3aD+T4TbwMxwERbOqjT4DtWJJJM+ZL1fCW
         i7eXceTRYCzDf1bwP9/oG3Krs89ZsFDOQYueFY/+BVQP7VZ10+hcfSTRkNpeLxrBjH4N
         H3TwWnnS50hunnpEYgCV7uANDLdXnomJTU68DiNZQ79QO2787SiurNLmYrKxgh9HoDzx
         wN6096r/pYEn9sTv6dyShnUY6jxum/yahIAdHVCBDEYdAoOMwZvhSmaUA5JM6jqhej8R
         3n+x1G6bwXqGd8uXmZ6hHAh+TNlCCM9slh5EAzcpcfFOhZvfxG6DaDWwCQc7mKRNPETU
         g3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716217669; x=1716822469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhwVQj77q9WsVa/PNIbqf67vLZaFOrT0DXfZ5Ha2VXE=;
        b=uZJk0FXFhgc8Sg47GgV1Bqvt0yZzcNV93CksnIE42AT9eJgpWtOTt4LfJ8IARZZKX/
         UtNiaj0EREihaHe+pnC+K+oC3EJwQiWYoeqDeRJxhb8M8DWtG6ADIrp6n4ilEeAMRXHi
         CEfcFVDiM7K8SMCjP5LrTwPCn4q/9n2DC499lRCGLVVy9BtHcTA8Vvr8EbKE2k1upbN6
         LN/pLeFP/HXkddQ7IvJJ/MCOl/8N/Y6ZNzzRibWsdOVxvbsyYi6JQ5PuWlz2ULtujogp
         7PQdfvNwnjag9hoPAGYN/ONnsB2iSW+yd+eIc8C/oe5o9LtJlftUugJhaRBIYB1tfCII
         A3MA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Bd9+szmgadKp5iwXAwvKl3gCzyACGT3SfhHgSqNUijmIqoCkSwjnZ2UwaKhkj2XQ2eXLfpvQ7A3qaYXbPXEx2P5AhA80h5FT9EC6
X-Gm-Message-State: AOJu0YzZZlwzSU9KcGIBB5NXrUYlB7H4Auw+HIuzwXW0r4zyJpZtwck2
	88Jjaypw1+rFFtv1aKfmd1NU9+WV65UQ4G1NLW6kqgGvLiX+aKWWInNeyXeDo2fYS8Nu0oR+oox
	b8PwUnw7Wa+9YZDRps509hBQn3YU=
X-Google-Smtp-Source: AGHT+IFPFW/F5D24m94Tz0YHdPMZG54zKWfl02ijEGW9135nYPbQuliZTHA0+CJ4LJGqGqLCQ22PggF4KPszeIb267g=
X-Received: by 2002:a17:90a:e389:b0:2af:2be3:89c5 with SMTP id
 98e67ed59e1d1-2b6cc76d2bamr26474648a91.29.1716217669551; Mon, 20 May 2024
 08:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517082637.69928-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240517082637.69928-1-yang.lee@linux.alibaba.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 May 2024 11:07:37 -0400
Message-ID: <CADnq5_MTOUOdesLtSY_8X5kHVmGvXxSCY3Lh54RwGutysj=p1g@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Update optc35_set_odm_combine doc
 to match kernel-doc spec
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 4:42=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> This patch updates the function documentation comment for
> optc35_set_odm_combine to conform to the kernel-doc specification.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for the patch.  Srini already fixed this last week.

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/dri=
vers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> index 7c9faa507ec2..1f8516e5ce68 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
> @@ -50,7 +50,9 @@
>   * @optc: Output Pipe Timing Combine instance reference.
>   * @opp_id: Output Plane Processor instance ID.
>   * @opp_cnt: Output Plane Processor count.
> - * @timing: Timing parameters used to configure DCN blocks.
> + * @segment_width: Width in pixels of each segment in a horizontal direc=
tion.
> + * @last_segment_width: Width in pixels of the last segment if it differ=
s from
> + *                     other segments.
>   *
>   * Return: void.
>   */
> --
> 2.20.1.7.g153144c
>

