Return-Path: <linux-kernel+bounces-311499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F011D9689DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7B1282A79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F619E985;
	Mon,  2 Sep 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="jN+MUR21"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57117179AA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287192; cv=none; b=Y6YdrHJVYbB/3y3xMtni16ni7q7J0nanqpjtxc9+bpHBAWbirxvbO/OAgmWrU453OXJkMMrooZ/sTOzIH5XV2SW1gKoYOrZ6iidJxvO7esi0UMC30ndybDLPaVkFcenh1gowIAf/h4RjPvuqZEADW33CoEB8GJt2CQgMb0c/M0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287192; c=relaxed/simple;
	bh=H7vyAyYos1Mwcq7X2jIEKoRVgsk9WdtvDuhSksp7HbQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WZmkmPQUIIEoGeVn51V9gsPjcw7nWWN7o7tEicwCU9/WwU1OgRreS7fXBNIMyXVuBnA3yk18h6b0Psrov4Uck7WTQgBNc7UqSTQA1muPzBaBBrDS8cTwUHIVdydz4sPe87hLkw+pFev7rsPdI3QPuhm54w+dGYt0pv9g1bDVlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=jN+MUR21; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53346424061so882208e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1725287188; x=1725891988; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjFOfcuO0ShvMdTp7/UhQI6FmPlsW1v0riJgONdlWOw=;
        b=jN+MUR21WJREuexkc/0ZZQ0YWsy0RQ9T2O3AbtOxaJ2MOvEaA8nPTKgQgqlHFw+0Vl
         ZH2Y69AltD/5SuDzBeSGBwq0o3GQ0mLw2ihkde9XfRn5hszYGJnsseiUGG3iEEQy3vkb
         wAN1U9ZJM0DgQy6XopUhuakmF0GUvRUVXltGugvzMrjs25xMzMkYqV4ATU2Ve2229p5y
         4zRyFai2xQZcm0ImKKnEiFwpxLOL4wWREWf5umZdeUy1wpHwjaWmdHTmu/IeqfEU/Gfd
         ZYLIwzq0MNQTkd07p8R1dRQiOGYarKPSBUaXCqk5FvXefyD16/iXt3DUza5NfB64uIlO
         rcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287188; x=1725891988;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjFOfcuO0ShvMdTp7/UhQI6FmPlsW1v0riJgONdlWOw=;
        b=AXQhqyui6wfs218UZ1BWYurkXikhojpMZvQXlGshIg7K5FUi+EYvHa5nF5FlTJCr3L
         RR5s5t76RbgMqRRZ5lVkMGvanq8G7aovFHLK0g/xmkoPlhvG950U13UQUZgxMgrch2q5
         ZSFRQ6Rb+OcF6c0V29IP/n9X28maEh1Z0WimvuakPiTUevd4ShudBszbRki0J7c6RI8S
         pjlez8MpcocJSLrNWomBdpw+4n4hjGr9KOMyAiTMKUCz84shp1feSsZ6v8XxxJJE1LEI
         tDAcvw5ROC+hjE/tCTnDqyQrETIklsHsBZKCyHPFo8KzKCIzehfkdqo8rG3TV2L889he
         IDEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDq2d5nA9uL5pcCOZICIb0Q7LiwyOvCFVEkPLkEuVNdJbPYS88U+BJojXy/0At7MWZOPU3nyawOM0avGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VHGjIUmjqFKz+a0RwyqxLNveBB26q+CsbfMrkPdcbvYXNqky
	xFxrCbEdkzeEyDBHgXOM8WVeIEmmtJ0D+UF96aXYkFVRCqRErZnEEP7cJWk+cjw=
X-Google-Smtp-Source: AGHT+IHeIw+q9i7onUbUCEx78myzhKZ0pIFDsy/43aHlqTGGuR/yF5s3RmikeRVD7XGZV/QWroy3Ng==
X-Received: by 2002:a05:6512:b1a:b0:532:f06d:b12a with SMTP id 2adb3069b0e04-53546afcdabmr4089916e87.3.1725287188014;
        Mon, 02 Sep 2024 07:26:28 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:1050:bb01:34e6:8781:24eb:6a6c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d7482sm561805966b.165.2024.09.02.07.26.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:26:27 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v2] fs/ntfs3: Use swap() to improve code
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <20240826103939.63548-2-thorsten.blum@toblux.com>
Date: Mon, 2 Sep 2024 16:26:16 +0200
Cc: ntfs3@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <041F9CBB-17E9-4D6F-B981-BC861E1048CB@toblux.com>
References: <20240826103939.63548-2-thorsten.blum@toblux.com>
To: almaz.alexandrovich@paragon-software.com
X-Mailer: Apple Mail (2.3776.700.51)

On 26. Aug 2024, at 12:39, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
>=20
> Use the swap() macro to simplify the code and improve its readability.
>=20
> Fixes the following Coccinelle/coccicheck warning reported by
> swap.cocci:
>=20
>  WARNING opportunity for swap()
>=20
> Compile-tested only.
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Address kernel test robot feedback and assign match_offset as before
> - Link to v1: =
https://lore.kernel.org/linux-kernel/20240731135403.80805-2-thorsten.blum@=
toblux.com/
> ---
> fs/ntfs3/lib/lzx_decompress.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/ntfs3/lib/lzx_decompress.c =
b/fs/ntfs3/lib/lzx_decompress.c
> index 6b16f07073c1..4d5701024f83 100644
> --- a/fs/ntfs3/lib/lzx_decompress.c
> +++ b/fs/ntfs3/lib/lzx_decompress.c
> @@ -512,8 +512,7 @@ static int lzx_decompress_block(const struct =
lzx_decompressor *d,
> * the same code.  (For R0, the swap is a no-op.)
> */
> match_offset =3D recent_offsets[offset_slot];
> - recent_offsets[offset_slot] =3D recent_offsets[0];
> - recent_offsets[0] =3D match_offset;
> + swap(recent_offsets[offset_slot], recent_offsets[0]);
> } else {
> /* Explicit offset  */
>=20
> --=20
> 2.46.0
>=20

Hi Konstantin,

I just noticed that v1 of this patch is already in next (commit=20
7495ce846bbe4f38d7ea5e023e44ad864b6348ad), but v2 fixes a possible bug=20=

reported by kernel test robot (match_offset is still used later).

Could you take another look at it and apply v2 if possible?

Thanks,
Thorsten=

