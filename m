Return-Path: <linux-kernel+bounces-311491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D1E9689C8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3704284C58
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F73219C55D;
	Mon,  2 Sep 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="HjIFdRjN"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCF2139C6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286800; cv=none; b=iNxnchH1l9LukGEdKfXNkxOup0W8JtHCww6LJp9Ml7k0nUH+xHDsnQ7gLFlyox/GOt9NN/AEGCCTZatTr+dj4IpwVyiNdlAZsbqktmnuwRoX66s6wp+prVE8YOerolUNwsLH9oHQA9eN/+7nioLcHxopj9w78AyvMwUrktI4NMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286800; c=relaxed/simple;
	bh=HsXtJ7rmCPvpO8FNuz71aF7GC88AVaz2LZeAx1BFn/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbLFgANx1eSimnnfqksRbHa9NtH3lWe0FY6n4BoYwy+dF8gLaPiHkBNYP/XsJPt+MHgJwgFe5ve6fv413MNK/vvDNvrog7eSIGsdMXB/VWCgH/DsohVYPcOi6XXh3w1JFv3rnhxdPPWUaKaHZdhpGdU0ZNFtUqmxR8SSPTD5JE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=HjIFdRjN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c243ef5237so300800a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1725286796; x=1725891596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6bW2NZP4VrgVIltiAw9D8lI/8DuPqP/RA//3j/PBKo=;
        b=HjIFdRjNxeNfTzZ4lf3zYcsWzwr6fn9rFbKAor+xQ4ERmENXT6tV9h9w9VhLXNffbl
         7omLKwfTesWvAd4AZv461/EEy7g+22kfw9dwsfV9TK17ykNs8SYwBYnqZJ1kc1pvD719
         evgdQRErhpt1WTyk4BU3xMTLPLlYQ2Fi8a5f9xIytOLYzx/sQI9s85foJDcQohkc6Qub
         wUmn7RPSoBFrTcA20TmszKXWamjSCQRuZ9uRnQI8h0snC5XpzHD4gzT1gmCWJ3h74VKQ
         8TbJdrTGKLVPmdT/6K3I7ZffzIJ3fLPzNu5KG3F++tmckqUgU8+xe9TaoX9Yu0KBwBmb
         ataw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286796; x=1725891596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6bW2NZP4VrgVIltiAw9D8lI/8DuPqP/RA//3j/PBKo=;
        b=XtZUv1ddt2MiiD6qDwL3GytSO7tjWT+FRgGhn3woJalZ3U+0KIUpDYJpdb3yWKUhMR
         D9fsvgGwPYVD4jVc+Jp2uk+aEWxRHMPxoW56LhwUMdd+xfNUwhALgNF6wGG7ZJlDWtCn
         +0zpLbWOhwqMOLXYuawu1RrFXZmNxuL2NWDkeFbibUE08aF21N3p6jtVHKRlhxLi7XDC
         zg94q/Z+/fr+5YfauPmSRMY5JGuAT7tpfpKM/yTjqeZe+zoz8fhkm8c7eUU6GGGyNkYt
         oq9Rau6MA+ejx2sfPcpEjTZc6WdmdzS43aI9kC66foabzguVWYgIWIizo1lwL11O5SgC
         F8FA==
X-Forwarded-Encrypted: i=1; AJvYcCUshes29lvhMx6mlker25gEhlk6Qk/lYzcEegR46wS3Xs1j+Y4mcYGOikQym8QqJpvyEnsGWGOwCKBPBnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiH6C1azLiqwlcT5Fzb22uwFuc6i5PYbzHLLBk16L/ea1UBCCL
	hBRcP0qBpoyBkkmzM2+nn6nkNHb1k0AaHSUIVaVbjpdRwZto1+Lr20Z2PruE9ptps3MAvONFU79
	R1bhJvFiqbM788jB0IdkKnjkRjh2/1BWtRX5cXg==
X-Google-Smtp-Source: AGHT+IFmiMRFgiATE391HVFzmnyUiAqVNpDIO6gtlnMmtJSi71lPkOvJYpccjsP4bXgqKYA6IDnWkiIlmIO6/99NFYY=
X-Received: by 2002:a05:6402:1ecb:b0:5c2:67da:9742 with SMTP id
 4fb4d7f45d1cf-5c267da9903mr657970a12.4.1725286795296; Mon, 02 Sep 2024
 07:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902141537.308914-1-colin.i.king@gmail.com>
In-Reply-To: <20240902141537.308914-1-colin.i.king@gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Mon, 2 Sep 2024 16:19:44 +0200
Message-ID: <CAMGffEk3JUviGmUJn=yWwP58gKs=y2hLQRbEr-XrMBf=VPaMqw@mail.gmail.com>
Subject: Re: [PATCH][next] scsi: pm8001: Remove trailing space after \n newline
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 4:15=E2=80=AFPM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> There is a extraneous space after a newline in a pm8001_dbg message.
> Remove it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx
> ---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80x=
x_hwi.c
> index 8fe886dc5e47..a9869cd8c4c0 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -2037,7 +2037,7 @@ mpi_ssp_completion(struct pm8001_hba_info *pm8001_h=
a, void *piomb)
>                         atomic_dec(&pm8001_dev->running_req);
>                 break;
>         }
> -       pm8001_dbg(pm8001_ha, IO, "scsi_status =3D 0x%x\n ",
> +       pm8001_dbg(pm8001_ha, IO, "scsi_status =3D 0x%x\n",
>                    psspPayload->ssp_resp_iu.status);
>         spin_lock_irqsave(&t->task_state_lock, flags);
>         t->task_state_flags &=3D ~SAS_TASK_STATE_PENDING;
> --
> 2.39.2
>

