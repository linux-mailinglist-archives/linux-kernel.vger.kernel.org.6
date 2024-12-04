Return-Path: <linux-kernel+bounces-431289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B769E3BC4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05338B35AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9751E1BC9F0;
	Wed,  4 Dec 2024 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEzESmK2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848E15E97
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319934; cv=none; b=nCXB3cGhBb8/2BUCx1Plu8YILK919sZeyMoAssrBl4RmsZLo6F6/rPahCccz2Ko2X7D7vxKDIhenckWmgFEROo1/GiSOmq+r3Pr0VAyGw701fSDnrvQ78G33Ph3tlkrhLatUAX4UejG8JzJR9wyFZR1eedAoSsth6hPUbPyrIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319934; c=relaxed/simple;
	bh=x7Zks2UUvhFqsbG7mkkKJv6OfEMFvfDACbsVK7TrU8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjM5QCI1PdpzItAPrIyEKTEDOR9kqyHyNW+dk0Ia8sLyJ0vE9llqoGAkaDqOrGsGs5cxY6ZyfA07xZDHOzMpwyIvbZgm8ozGhl2VGSnfNBbFsf1nL4ZFvlm1Cv4nTyELalci/aFB647aqHbmUxigg2LlJC2Eo3KMRc7ltHzwyCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEzESmK2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733319932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfzsMKSDpksu1Ik71I0LavlaD/4ezjHXC0zfA3/Wep4=;
	b=XEzESmK2wDAG16TeBuiPYNpu9OrGFL3GZX6dUBmR7DTFORWXLFyBr/K5NY+xwbacbwPnvC
	1lE2Up22oR263S4G4vGlEFXkW7E7k0B5LtzLt4h4t64YfIJyW/pIWgyJxEOVZd219tcj+C
	ZKA07QLkIbJyGaxtcPbCd6zC8ZrRt7c=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-Ok-znGjyPKuBIRSg7ay3ww-1; Wed, 04 Dec 2024 08:45:31 -0500
X-MC-Unique: Ok-znGjyPKuBIRSg7ay3ww-1
X-Mimecast-MFC-AGG-ID: Ok-znGjyPKuBIRSg7ay3ww
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6eec923c760so77447187b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319930; x=1733924730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfzsMKSDpksu1Ik71I0LavlaD/4ezjHXC0zfA3/Wep4=;
        b=H2a/+3RUTkSeLR8MUNw991k8K9jWWOehzY62vIg6JRdmwMXsXadO0gO+at0GSVzHeA
         qNUeBuuoADdco9xgXsjnGtDaIoN0SU/qhdKXKRyW4+r4viMyzr+L3Swn8MVEA/XCVNhO
         +4PvRG7Fy597GwiSdLwI9qcG/H94OmyY+ul4yZy7rWpO2zFIBiVA9/cLp24J4BqOtJ6L
         p/joSi6k8ZyfXU/GcR2G26ZZTpmbNuJkjbjWqwNBcJnOFuIZeDnA9odBHTca4yP6/Gsh
         9bkF2kIbbwN8KZyrLzM3jJrztM3jDMXjURiPsfB2M9gu/PXCGN/63DhMb+vJrcEysixt
         si+g==
X-Forwarded-Encrypted: i=1; AJvYcCURoAaDFx0E23iup7HFqmjePMBW9QgOs/XtKoAvMSJjYZ+yhPFnuk7Avplt24wQ0AF952o8kV96oBh/qwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyktoYGgFgEAGRv3QWqBb/ReOwA0w97kergzhVXSj/ae4Aatcc
	krD0M1kWfQ2gcRz4JocJ9yx2H4HXbIvZQj60iu6AtZk71pVVQI1veVXxbV3EP7V7WIqmhfzEuI/
	vazuZDYHXAYYdFLo/k1Bo8NGEFypuhGWR5U4M2AwrNE29maeb5v0c6oNDY8yE05aEES6oPMxxjk
	IO97cIkmi9I/GWudjuP4YyvrW9CJm7lXKtAfDf
X-Gm-Gg: ASbGnctN3Eo1S++CblFvwtitoYqLruIV415wfdqQ31/6ozBuR3SEBBKNhWHd4BYS9WP
	Ld14cpkJrlAL/bNn7TLd7BLBSD5jhVWQ=
X-Received: by 2002:a05:690c:4a10:b0:6ef:61b9:e003 with SMTP id 00721157ae682-6efad2f6fd7mr88309257b3.36.1733319930679;
        Wed, 04 Dec 2024 05:45:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJh0JveXBGAfwCZPJXi92+8eFnpI5egIrMgPNGfFHIU7y+Wx98MO5YLZnKgkY4y96eHhMCpU6SnKNxWYBd6Nw=
X-Received: by 2002:a05:690c:4a10:b0:6ef:61b9:e003 with SMTP id
 00721157ae682-6efad2f6fd7mr88309027b3.36.1733319930450; Wed, 04 Dec 2024
 05:45:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127181324.3318443-1-cavery@redhat.com>
In-Reply-To: <20241127181324.3318443-1-cavery@redhat.com>
From: Ewan Milne <emilne@redhat.com>
Date: Wed, 4 Dec 2024 08:45:19 -0500
Message-ID: <CAGtn9rncdvYQUGYVZwePccEGOnAc0FU1s5GJ6S3PSgpc-1OfPA@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: storvsc: Do not flag MAINTENANCE_IN return of
 SRB_STATUS_DATA_OVERRUN as an error
To: Cathy Avery <cavery@redhat.com>
Cc: kys@microsoft.com, martin.petersen@oracle.com, wei.liu@kernel.org, 
	haiyangz@microsoft.com, decui@microsoft.com, jejb@linux.ibm.com, 
	mhklinux@outlook.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, bhull@redhat.com, 
	loberman@redhat.com, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 1:13=E2=80=AFPM Cathy Avery <cavery@redhat.com> wro=
te:
>
> This patch partially reverts
>
>         commit 812fe6420a6e789db68f18cdb25c5c89f4561334
>         Author: Michael Kelley <mikelley@microsoft.com>
>         Date:   Fri Aug 25 10:21:24 2023 -0700
>
>         scsi: storvsc: Handle additional SRB status values
>
> HyperV does not support MAINTENANCE_IN resulting in FC passthrough
> returning the SRB_STATUS_DATA_OVERRUN value. Now that SRB_STATUS_DATA_OVE=
RRUN
> is treated as an error multipath ALUA paths go into a faulty state as mul=
tipath
> ALUA submits RTPG commands via MAINTENANCE_IN.
>
> [    3.215560] hv_storvsc 1d69d403-9692-4460-89f9-a8cbcc0f94f3:
> tag#230 cmd 0xa3 status: scsi 0x0 srb 0x12 hv 0xc0000001
> [    3.215572] scsi 1:0:0:32: alua: rtpg failed, result 458752
>
> MAINTENANCE_IN now returns success to avoid the error path as
> is currently done with INQUIRY and MODE_SENSE.
>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Cathy Avery <cavery@redhat.com>
> ---
> Changes since v1:
> - Handle error and logging by returning success as previously
>   done with INQUIRY and MODE_SENSE [Michael Kelley].
> ---
>  drivers/scsi/storvsc_drv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 7ceb982040a5..d0b55c1fa908 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -149,6 +149,8 @@ struct hv_fc_wwn_packet {
>  */
>  static int vmstor_proto_version;
>
> +static bool hv_dev_is_fc(struct hv_device *hv_dev);
> +
>  #define STORVSC_LOGGING_NONE   0
>  #define STORVSC_LOGGING_ERROR  1
>  #define STORVSC_LOGGING_WARN   2
> @@ -1138,6 +1140,7 @@ static void storvsc_on_io_completion(struct storvsc=
_device *stor_device,
>          * not correctly handle:
>          * INQUIRY command with page code parameter set to 0x80
>          * MODE_SENSE command with cmd[2] =3D=3D 0x1c
> +        * MAINTENANCE_IN is not supported by HyperV FC passthrough
>          *
>          * Setup srb and scsi status so this won't be fatal.
>          * We do this so we can distinguish truly fatal failues
> @@ -1145,7 +1148,9 @@ static void storvsc_on_io_completion(struct storvsc=
_device *stor_device,
>          */
>
>         if ((stor_pkt->vm_srb.cdb[0] =3D=3D INQUIRY) ||
> -          (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE)) {
> +          (stor_pkt->vm_srb.cdb[0] =3D=3D MODE_SENSE) ||
> +          (stor_pkt->vm_srb.cdb[0] =3D=3D MAINTENANCE_IN &&
> +          hv_dev_is_fc(device))) {
>                 vstor_packet->vm_srb.scsi_status =3D 0;
>                 vstor_packet->vm_srb.srb_status =3D SRB_STATUS_SUCCESS;
>         }
> --
> 2.42.0
>

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


