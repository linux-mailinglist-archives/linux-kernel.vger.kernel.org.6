Return-Path: <linux-kernel+bounces-371183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600419A377E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F31C1C211B9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54B18755C;
	Fri, 18 Oct 2024 07:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g665Ipob"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4243C13A40D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237459; cv=none; b=ec0++sCQKUzjEF7KGb7vTLNVcaVc1U+23ap14/qnA8WhyMS+7DMlDCsunIyk5t2JE5U2IVAg4cRvnnpNu/3eRFGBWrndZv5GCwRfWTGTukPF2yOQMBMgpUivWXXMMrd+g8qFiUJSgqcway3F4UyPaoc+6z2Q/TsE1m7K3atp0l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237459; c=relaxed/simple;
	bh=gAYaJkqvsGVJIhJpt6gkmJ9q6zPDeTu54KDIYXdvTDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUdTpxjWC1y01ZgnWFF4TP1Dv2+u7szkRh5rZkv3C04EGRxYj0EXmuATFaJWEyLRMLfRtYlXRH8Hcn0ZLzXXH4j5T8/r63WdnMerPyoaqx6DjInLwPq5vUAELEdsSkm2tyHnavG+tQQaBGO1vEXcLswjmWzbrc2SQ6GHAoGRuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=g665Ipob; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a156513a1so216274266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729237455; x=1729842255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GQQ6Z8pAZHpDQrA+EkcHNsSGUK1cfIY+DynaWtF0A8=;
        b=g665Ipobrl/5Qn1h1qNfLwjE22HGlpZiMBZ2WqTUiRmaDvAhvlxa8MM/qsN2PZXy+Q
         e4uwZfScJGAWljFpe1UO8BNnSj9uGNk2Y+tpenC/Un2QFBtFCTpsKHI8ElrqzGtInzS0
         p9XMC3tOzQU16/blpdNmumBG5Lhs/tjBwDJos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237455; x=1729842255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GQQ6Z8pAZHpDQrA+EkcHNsSGUK1cfIY+DynaWtF0A8=;
        b=mnwkQ9XB0QObCkV7nLIMfu/fCw09YCcX7SP58e0dCN70q9ipjEv2ALJhUoPHwIJJDw
         B80Vesx490vklD5p8ohMkq15TZ3xrGuJ8iS7CW9QtyTKarLtYmNMPBqULwM6HJxdIBC0
         dMfrgLUTHvszwZ33XkDNZJsY1N1YcohP2lSjsvBe7571GVb13hZ7ZwkmoBKuGbXfjBKm
         lcetxqMxo9+AUjdheQOlGc95Tv8BnCO6Wr+wEI5DgtjHZLPAc3Pki8C1MK160l7hsxNT
         +6kU9S9oQcNOjA+kbsiRQnGhPjVjjOZWBv4PX0a2xuAi+lv157A1kbzwbfrCv2COLmd9
         RiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnk4qJol5vXYVysFuiDI4J3ofHgKS13thaoPw6Oe7IAFjg/CxyAdU0+MknQ74D9xWVV6UkhGsZeqHteMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRC5o/lGsprqkk+8DSj+EqjMOEbrr1c6PDpr0nroqka11aUqwS
	acifIApVYbx5uuY9wmzFejx9+H8QC2hDKVh8Am0ZcF6M5p3qf/uvCFLUkGGbfi9+fR7cnUuombT
	Exb7O4v7xgwVsz3xnzSkeNU8oQonALwd9mS14+Q==
X-Google-Smtp-Source: AGHT+IFh2AGgdGfKZEdJoJseozKfl6fopR6KDUiqkM4PUV7YZYDzsmi0GbVtNpW15YJEYeJ86x5RvVL/4Bj5yC6Pn6E=
X-Received: by 2002:a17:907:7f8c:b0:a9a:3013:2ea1 with SMTP id
 a640c23a62f3a-a9a697748dfmr107911766b.1.1729237455199; Fri, 18 Oct 2024
 00:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017064923.1585214-1-zhengzucheng@huawei.com>
In-Reply-To: <20241017064923.1585214-1-zhengzucheng@huawei.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 18 Oct 2024 09:44:03 +0200
Message-ID: <CAJfpeguKB2k6jnzNKOdx9390bKwx8TktY7xp-wcy-h7wO08Vpw@mail.gmail.com>
Subject: Re: [PATCH -next] fs: Fix build error
To: Zheng Zucheng <zhengzucheng@huawei.com>
Cc: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Oct 2024 at 08:50, Zheng Zucheng <zhengzucheng@huawei.com> wrote=
:
>
> The following build error report:
> fs/overlayfs/file.c: In function =E2=80=98ovl_file_end_write=E2=80=99:
> fs/overlayfs/file.c:292:51: error: parameter name omitted
>   292 | static void ovl_file_end_write(struct file *file, loff_t, ssize_t=
)
>       |                                                   ^~~~~~
> fs/overlayfs/file.c:292:59: error: parameter name omitted
>   292 | static void ovl_file_end_write(struct file *file, loff_t, ssize_t=
)
>                                                                   ^~~~~~~
>
> Fixes: 291f180e5929 ("fs: pass offset and result to backing_file end_writ=
e() callback")
> Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>

Thanks for the patch.   The fix is already folded into the original
patch in fuse.git/for-next.

Miklos

