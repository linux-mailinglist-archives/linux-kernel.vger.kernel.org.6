Return-Path: <linux-kernel+bounces-449870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4079F572A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00C7189471A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0834E1FA241;
	Tue, 17 Dec 2024 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2fUgj4Y"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF3012C475
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464702; cv=none; b=U82OVf/LO3fbvFl5jpQZj6yHSOUB+Ak3wfHT8vvGSnuOGhQJWg28kDmhbcw56NR8SD1GHB4eeEx8okW/D38YkZvTfbPhE0cNHm2+GiOA64FkV/sF1kMJYAL15RzDub5sxNdYLjoFkv+AVxsAYOh9BLvPiKt9czpd4a0goX3pYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464702; c=relaxed/simple;
	bh=achiuxBzbM3VEP5eZ162jNXTWMy+0cD2XHlKR/0lQsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mMO+3rG/NtOHtXzymoutxZkotC8tkqafVXYaS47A+waZ7OWoNnUJPSFeGoKKCdEftffCQBfD1Vm0OrhimLbIfQtgm9KifNlduc/ZHMazAc0PJXq6hqVTL1zw+06NKAwTy5BPfXswwZ6HRJl/ffDlzjh3wBfe9uZRv/kimySn0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2fUgj4Y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-540201cfedbso5702440e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734464698; x=1735069498; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f22HL5gpkon9dTeKpgexWS/AAUlUTb2ka1v0JukniNo=;
        b=V2fUgj4YVE0yd8NHfuFsn0f309aqa+YCO8aO08p1DSADqCLvINViS/ez4VUVg2Z5z3
         AJ3yK0YPxIjCLUEyhyAT/KYUj3CP/CAJml4mYUMg2USah41cqvgfhLOJ1bSwrBQ1SuwO
         3ZlmRQH8w6SW2MWCrOA73SmZ+RRbtDyjzc0nrkdRql9yXxfCEK3MNlDOiJkVAcqyUqFk
         Iy6V2L9oTvTlg8jrlX2DNsAH3qUlQJulMTq5eqjrA+kHoKW0tffjTDalISiRgExNp7mm
         aOfP2tgZ7qwBHeFFYuzgWFRuF9ZJVTiO8fz8cF6fyX1vx42VbSsE0//ZGN4I2K+OUEOC
         Vfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464698; x=1735069498;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f22HL5gpkon9dTeKpgexWS/AAUlUTb2ka1v0JukniNo=;
        b=QXEtN6Di4/p8AzeW/hf1sti/oJpCUQSJtOrOM88QGkGVrhC7UqrjYPuBJjkMXBzR5C
         quyuW6HA68a2ADIRaKcZOj5xBRD8Y5X8apZJ267z3rF/cNzPEIspyXlFkD2mxpDzT+UR
         DkqC6H0Nm0R/ZpmuuaRLVgrw2GKHDRsNn954BBQbOvJ137cmnSr2Gl9WpHVuHuiQ02hg
         vlWUJJuMIEOWmXSDy/sU4Y5fTZQeGM3kNMOEt7TUdu8nndHVh5HFGhU5gTBc35UDj9bP
         QrkXcJ+oysQBnt25YCr2XEQQXRmCzxhS3C/4UcQvHbfbEvmfnmLfTbseqkmMG/RRKblz
         hz0Q==
X-Gm-Message-State: AOJu0YwHJy7FRmup4TcGxWb/7O8rKCSfxGYpX4mtw7FrvTs98HOtXlk7
	zH4HNC6fdvGSrhGoNl5+WNN5Qegg0FYwohNtfV+pFumvPA7j0+v359V/pLp+nQc7pINqYtXVJxf
	W+seiP3dwWQW7btZYY/i3O905GKHvBg==
X-Gm-Gg: ASbGncsAM+wzOMA02XsXTiAjYmv2ThXw3rb41OiY7QS+QNdC6+9ZInYcbTls5LWTeFT
	lRuVDNvEfwU7MEy22EIPHkP4e/6X+DeyFyVZ9aef5E1dJxlFXMkrz6nsUfxnle/+afZZeDFMW
X-Google-Smtp-Source: AGHT+IF1nXqvs58oTofaVWDDwLovRaku8gSvBcTPCFZXJbG01IddUoietGed7rjgiN70w/10suvRe1C+OZrNvbiuo7w=
X-Received: by 2002:a05:6512:b97:b0:541:d287:a53b with SMTP id
 2adb3069b0e04-541e67473c6mr90611e87.19.1734464698185; Tue, 17 Dec 2024
 11:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <011da8e5ae7537ad188cc49cee6f96e09eb1b8db.1734427173.git.dsimic@manjaro.org>
 <CAH2r5mt61UvqdE-15ndegOHROObk0CfcZxMnTZeSn9oJymY=YA@mail.gmail.com>
In-Reply-To: <CAH2r5mt61UvqdE-15ndegOHROObk0CfcZxMnTZeSn9oJymY=YA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 17 Dec 2024 13:44:46 -0600
Message-ID: <CAH2r5mvyCvu+bjak7abXiBxK2k-a8AOJFNnD6tDx3k0BN3XrVA@mail.gmail.com>
Subject: Fwd: [PATCH] smb: client: Deduplicate "select NETFS_SUPPORT" in Kconfig
To: LKML <linux-kernel@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Tue, Dec 17, 2024 at 3:26=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Repeating automatically selected options in Kconfig files is redundant, s=
o
> let's delete repeated "select NETFS_SUPPORT" that was added accidentally.
>
> Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  fs/smb/client/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/smb/client/Kconfig b/fs/smb/client/Kconfig
> index 2aff6d1395ce..9f05f94e265a 100644
> --- a/fs/smb/client/Kconfig
> +++ b/fs/smb/client/Kconfig
> @@ -2,7 +2,6 @@
>  config CIFS
>         tristate "SMB3 and CIFS support (advanced network filesystem)"
>         depends on INET
> -       select NETFS_SUPPORT
>         select NLS
>         select NLS_UCS2_UTILS
>         select CRYPTO
>


--=20
Thanks,

Steve


--=20
Thanks,

Steve

