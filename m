Return-Path: <linux-kernel+bounces-246521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F492C30D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB79D2835E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF43157470;
	Tue,  9 Jul 2024 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xtqJ4b9o"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A602BAE5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548226; cv=none; b=fG/Y5HGwUbEe1xdj2JUK5Y71LCsAP5cPJNgsDRtp+DuFpanObd+pLvsDS13oVgihyhjVvpYL6SuLOHACsKx0eGjxMyckh0Q9ggrcn7L6vRqREp38NTkevTCeg4DpRvWRnZC8QsCHRnQrHaPK15kZYYMST8Ixgvobdz0EqsG1P6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548226; c=relaxed/simple;
	bh=WsLAfzI+7Bwv2prkUTtZSjaTSbqrCFN+yr5PJzahWFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohiPH6/1i+2xfDXKQkyukiPZie3SxnYaU8U3m3pJCRsRX4FRCrVMKadzW8Izefmuc8nPtJ9xrBQtnmQkBPL3xOKCDV1TyErUtOB3E05U9x+D/nUaJzuq5IyJFs6UYdjYmOYnlB9uCZR4CYZdiamaxlamOrd0e6uXE05go+cOOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xtqJ4b9o; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447f8aa87bfso38081cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720548224; x=1721153024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqN5zubKIj/TQOFKWAhx+fVe2OlrnB0YWoh2U1M0Yyc=;
        b=xtqJ4b9oxrN5u1MPyqnxASZoz6DJKPZcdbdlRBXSfniuD+WMbcLYe3w7DK0+FPoTMm
         we8soXKkyI09SwHY80UUb67ixx1zxGsPH+oUzfbLv/ZBkzRWrdnOJguIvUEgRM4g/Dtm
         uf46UbgYhF9LfrRhZYGCQ12gchMbbVUFExfSDSya4Rb9s80eifHzHwA9tYp1lid0n219
         9WNiFgDlNdhVbOwTFeXZC9YIf3YQ82+SyNBK8eymFtFABH6s6nFRxv/YRhW5d6ikC+vj
         ohb5dfvexQ6BlbYSPH59v1SBFwt5uFoH4RogoEpUsH17GtMCNMwbjs61dmjauhakZMw3
         1nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548224; x=1721153024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqN5zubKIj/TQOFKWAhx+fVe2OlrnB0YWoh2U1M0Yyc=;
        b=crUqsrewcQkH1290jqXfO5H6ln2nshks5KM6sshbW8Kkxh92ZXYbwrvnpFOvE7XxLY
         q/54CeWrhFZzm8H5rBqqFRGBiAasQovsOObfOcAXSRo26gqEWD/kwJiGfFCFekpUPTXY
         nKGF4jiGwZECqqkI/uvkLP8iekH+70PcE1M8g5vajEanO4CIVnDw/5r4kGhePXgkupw4
         ELNA9XftI8Qf5fDWmp4kYkKLSQXn1lKOsn3FON62oTH8mt5zX0hrHDVOQ8J2Fv1REPBU
         iW/CVKXmVseiCJQf/bFWKq2gu3Hj7tBK/3QHADGay1P7XsTvf1uY+yJP2CAHCiHhUlYf
         jmsg==
X-Forwarded-Encrypted: i=1; AJvYcCXfL7c+SHlNEE81yOsLRxf6rVO1wOJvMTQJqU7KfmRKIwkJgAIU+s85wwvzlt7rLw5BRElhaqIZ+qQE0l4D3QFdXT6RR+irL+9PfBMZ
X-Gm-Message-State: AOJu0Yx+kbxkR+LnS5qbP+ZW6g1J1ghfvQnlqB61R9Ee7mKDdzAtOKB5
	fkv3hlzViw5tDGT0YFJ7q/gfAMmDxEAwVOrspHAdFKZGwwb5i7aDqe6M4NyDneQYpfpZRMrMvtg
	/+WKZ3ZtwJp/7jGEiiUfMVMvPIum5ZvUOt7GM
X-Google-Smtp-Source: AGHT+IHvPMgn0fsAv3aOrL8xaBQkBQof36RR9T512/A0hicmFy9Vm3wk33u9td/COPCaaARqeetMnnx7FRZKU7BQSlM=
X-Received: by 2002:a05:622a:40b:b0:447:d78b:fdf6 with SMTP id
 d75a77b69052e-44acb3db365mr197561cf.10.1720548223808; Tue, 09 Jul 2024
 11:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709-devlink_fix-v2-1-22254f1138e1@quicinc.com>
In-Reply-To: <20240709-devlink_fix-v2-1-22254f1138e1@quicinc.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 9 Jul 2024 11:03:06 -0700
Message-ID: <CAGETcx8ASLya0q-Kv_fN0ubdFv8vCh-ZDN4yRh=0kQUQ-dv0Xg@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Fix size calculation of symlink name for devlink_(add|remove)_symlinks()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:13=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> devlink_(add|remove)_symlinks() kzalloc() memory to save symlink name
> for both supplier and consumer, but do not explicitly take into account
> consumer's prefix "consumer:", so cause wrong algorithm for calculating
> memory size, fixed by taking into account consumer's prefix as well.

Again, this makes it sound like you are fixing some bug. No "wrong
algorithm" is happening here. You are improving readability. So, just
say that?

-Saravana

>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Correct commit message and add inline comments
> - Remove fix tag
> - Link to v1: https://lore.kernel.org/r/20240707-devlink_fix-v1-1-623acb4=
31cd8@quicinc.com
> ---
>  drivers/base/core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2b4c0624b704..51209db7ff84 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -572,7 +572,11 @@ static int devlink_add_symlinks(struct device *dev)
>         len =3D max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
>                   strlen(dev_bus_name(con)) + strlen(dev_name(con)));
>         len +=3D strlen(":");
> -       len +=3D strlen("supplier:") + 1;
> +       /*
> +        * we kzalloc() memory for symlink name of both supplier and
> +        * consumer, so explicitly take into account both prefix.
> +        */
> +       len +=3D max(strlen("supplier:"), strlen("consumer:")) + 1;
>         buf =3D kzalloc(len, GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
> @@ -623,7 +627,7 @@ static void devlink_remove_symlinks(struct device *de=
v)
>         len =3D max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
>                   strlen(dev_bus_name(con)) + strlen(dev_name(con)));
>         len +=3D strlen(":");
> -       len +=3D strlen("supplier:") + 1;
> +       len +=3D max(strlen("supplier:"), strlen("consumer:")) + 1;
>         buf =3D kzalloc(len, GFP_KERNEL);
>         if (!buf) {
>                 WARN(1, "Unable to properly free device link symlinks!\n"=
);
>
> ---
> base-commit: c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
> change-id: 20240707-devlink_fix-0fa46dedfe95
>
> Best regards,
> --
> Zijun Hu <quic_zijuhu@quicinc.com>
>

