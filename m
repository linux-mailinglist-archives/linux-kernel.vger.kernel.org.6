Return-Path: <linux-kernel+bounces-518197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248ABA38B46
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AB31894578
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11710235C0E;
	Mon, 17 Feb 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzLfUJPw"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD740235BF0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739816909; cv=none; b=VmHaWGf5WDwSbkHisPAberExI/Pf/CbbTVD2C9YOrqMgEQlXX5N7q98T2DVyaP/8lSbWe5jAYPjoYMtfdfZhbAEEVMcNU437yWh+tGD7Klh8xHFFfDITN7l2raFccWkRqkURP4r0JAHsX46BL6Oo7Qj1OLlSMLic3bQNjApxX+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739816909; c=relaxed/simple;
	bh=hCY876bzfHPrz+2xaMfuRfH/o45M88VIOZfakkcRy5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpdEjv7tqUhKEaclHX4kU4dS/SmotwHBmR4MNjI5ynrz1SelD5eQP6Kwa7HZldl7G7zHDhlBWaghQjjMpA54yrDhId3dWssj6xr3fbAXhR8Dvdnc3yvNHKsJPZl9atZzGQXnXao3XcIan2QPzEOZZpjKKWk3J+iSOFJLf4Vf+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzLfUJPw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb90f68f8cso292511866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739816906; x=1740421706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+l+0lQBsKNzTpGm0qORCGiSDs//13l2fOSSxE+r8mw=;
        b=qzLfUJPwcPB8DkidsERq+oMOmlW+KcywG2pPHuXqpYynBsPDoF9LFhMTV6Xmwlt86y
         aN9zj2psQSl8RfCIUMXTifF3LmtJATSwxljcf/S7soK08wPkQsa1d0gxN+L94115jsN/
         HzkWZYQc6XcPmhKorMm6oSKE0EO+YXwOAKwg2HCYAEgHkfCvkLLGSOm5Byj9TBiEWiuh
         Nuta+15VUCd9zzWwLNvaFOk65rg3aScMijEi43ctmv4RL5AZubN+ULW9IIw6fQ6DVbG1
         sgG2sBcKJOfl8CfFl9y/W250ybIkOGN3J1JZcCNMDowDk1/nOaaQtHfuxk1lVRFR2Z/g
         D5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739816906; x=1740421706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+l+0lQBsKNzTpGm0qORCGiSDs//13l2fOSSxE+r8mw=;
        b=p2cgdfB1jn3ylbVVFhS14G4xErAvfcUe9aFBdL5u27jbiMpdpGmPJrVDgpQTri+2gP
         IyYL6BhXAtkpNTH8uWgyL0PJKLyS/96nosRsGjnQMPh928K3qkwod/6/MM81atf1A9FX
         P0QljySL/p7/ny5948hpksgS6q8PJBwFY05q+V0LdVSS4zPlBrWJZ7bvLviV0o4dh/Oc
         AdBXhTUZkkoIIZ45HXs4GseZBXC9bNdkBCn4P1FRxgB8Z+l+sDqYPeUU/pGWF5iE4NZr
         IBE8MOF1VqRtevMqWCnVLZ27FGkxeBgAUsEjElK97TDtLX9EIlOztSXaUATwwAE7Q50E
         BinA==
X-Forwarded-Encrypted: i=1; AJvYcCWG6hfIY0INs3f8B/EF8PSlqAa6yApAC5B2VvCO2M7iDvVe/RdmxriROMSuxhSKoph4CaAg0hzxFenRdqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrW3oFsj5Iig5HNnhojVhkmkfeUXWdTb3msoahbsxq9ypfgjyY
	mNWk3F/Ly4muqdM+5InpSWb9nNucCKVUBul6xNugXWs5Y5v7Y8y0Sq3XbBOtgFMtDH+yLeeeaRH
	7mR/573S/bh9fLm41msbKvv/zi4mPTP/XYXNl
X-Gm-Gg: ASbGncu6tG/GDC0xGHkgUO0wx8HgOUcS7j9mwWjfW/SqFPHaZPcdF0TSMF5tNR84Gkm
	Z+rd+2qAKEJ/kEzUDaCQJEctiQhM8D4bAfqtc2/kTi89kgpm1NvGfnx/EBxMGC53cAMkuMRc4yG
	i4lRWhW2BMcl3iq6yilAs1n+kCKLcdIw==
X-Google-Smtp-Source: AGHT+IFjjgLMTvGHSCRWiwCYLddKG3v8fu3sqA5dCvDVOitjnq/kSTuDzxQRaYiuzB4Hayx3/fyBm1HmRPPrqarBzzI=
X-Received: by 2002:a17:907:7f27:b0:ab7:f096:61d8 with SMTP id
 a640c23a62f3a-abb70bfc808mr1220784666b.29.1739816905780; Mon, 17 Feb 2025
 10:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
In-Reply-To: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Feb 2025 19:28:14 +0100
X-Gm-Features: AWEUYZl-8xmVnot7cSihwj5mrrH3uVZP9wHKcdzkuxM7ag-b5A1qdgu8u59YhW8
Message-ID: <CANn89iLjxy3+mTvZpS2ZU4Y_NnPHoQizz=PRXbmj7vO7_OGffQ@mail.gmail.com>
Subject: Re: [PATCH] net: dev_addr_list: add address length validation in
 __hw_addr_insert function
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 5:54=E2=80=AFPM Suchit K <suchitkarunakaran@gmail.c=
om> wrote:
>
> Add validation checks for hardware address length in
> __hw_addr_insert() to prevent problems with invalid lengths.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  net/core/dev_addr_lists.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> index 90716bd73..b6b906b2a 100644
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
> @@ -21,6 +21,9 @@
>  static int __hw_addr_insert(struct netdev_hw_addr_list *list,
>       struct netdev_hw_addr *new, int addr_len)
>  {
> + if (!list || !new || addr_len <=3D 0 || addr_len > MAX_ADDR_LEN)
> + return -EINVAL;
> +

We do not put code before variable declarations.

Also, why @list would be NULL, or @new being NULL ?
This does not match the changelog.

>   struct rb_node **ins_point =3D &list->tree.rb_node, *parent =3D NULL;
>   struct netdev_hw_addr *ha;
>

Any syzbot report to share with us ?

Also, a Fixes: tag would be needed.

