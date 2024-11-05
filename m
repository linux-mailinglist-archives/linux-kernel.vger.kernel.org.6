Return-Path: <linux-kernel+bounces-396193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CBA9BC92F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8CF1C22813
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFCC1D040B;
	Tue,  5 Nov 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grX96xee"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B1433B5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799147; cv=none; b=UHMwiYGRTPOuxx6A/jcqKxKY/YaEKTAORzKA2HfrTbFcBL3TwVOK/uJmhbHjkP2lGfOpDmrZKMCm6QWnaMkmrPJgcqDc9zEtVtTT+jCmBIatfy3othWE06/MBf0tBtEkZNbcB7s4k41pHxgWkNtGrVPNqvUJI7qA+eyoRCh9+AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799147; c=relaxed/simple;
	bh=3boYlIm7+ysYJZ8hI0p5HudoZgakBgOBlMRjSuXyXRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJX18LgmkXZISvNJio3zuNMrMF6wV0+lXstb0+KXXXoEXdnsvNQPwfRy2a9WeO6w8c0urxSlA76I1tCUJ5B5ZO1VQrNXHO2E39OemcuUsnVAo7WuVMr+1at6JD4n4TfKJupC0GaizLKS+J+JdIv2150C77WbKkjYO4W9I+bHFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grX96xee; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730799145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaELkgjNq5yohIp9CDpDpFO7U1TxTr29on+OWubj13o=;
	b=grX96xee7qCq0ye4CSboji+bGs4Yh5jkzkWAwJXm637///8I9S9ts2PAGnS0OCM7s7LUz+
	2WMfKbe2JqQwhz3DYTuePtlHB22Mvdr849Ncc61fCJFgvbsHhebhew6/ISJeRzfKCEPnMr
	WsacZRUZ+h0u8CZNS8ryNbaYsmRp7dI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Ja8jlctfMXqtjJYczwSUaA-1; Tue, 05 Nov 2024 04:32:23 -0500
X-MC-Unique: Ja8jlctfMXqtjJYczwSUaA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e59d872d09so6703124a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799143; x=1731403943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaELkgjNq5yohIp9CDpDpFO7U1TxTr29on+OWubj13o=;
        b=e61id5r6asZWB3CUIV0sF1+Vq3IN1lVLtVbOfEu8kOKflw67jeEugfZ1bn21n8adMN
         Vuj8lysIcznP7DAIuEHFrM83tRd4vyTdMIEIPy4/JlXcWhOFsJ15fYV9nbm5TxCKc+4v
         bQuU+9/ywlGaERdorf/M1E/1GSc+3sj38eqlI/jHsPeG0HjpMF4lnkA8QqL6LhQ9+G0o
         STsfw98JFemzcDVl3VS3tO6tIws/0aRsVCUdK1V21kn9bmjZ8MwSThNTYap9G2YHLqhm
         cvaUOGIuo6d+QCPi0oI+IKEYclZJFcqAZts0/zqbyBLwg/5rB8XdrMftbn9Wvdd2wBxY
         8yMw==
X-Forwarded-Encrypted: i=1; AJvYcCXc+HzH0eesLu+L+njQwsQLmiI5bO1F3lzy8j6TcafXYGLFRoxtYdoI6Za5ZUSysaduVCz9YKIuSiFs6BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hogjw1Yrqze8x2cdRCVSUPgoRagU88/TEMwnLDrgSWeKrmYh
	ML+DfTybv5qOX8pPunJhD4p4fRcsWVLNfmodAP0q4BXE6AaWIV1qir/SgKvGbDTtIjnq2qmbUoC
	QgKE574wUlkz6xyzzmDr/DAEmP0DTtGLHn3oltwxuAZD0TMssjppAtcAr6UhDCvK9vbSaUSRuiv
	xM7Fs/Mc/xRulTPe1cpnUm8LWOmpOBeyyMf7rF
X-Received: by 2002:a17:90b:164f:b0:2e2:bfb0:c06 with SMTP id 98e67ed59e1d1-2e94c2b086cmr21054741a91.12.1730799142815;
        Tue, 05 Nov 2024 01:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrI2dYkCr6bnvyp62rgLDstJjcAcnHOsb+T5y5D8ck5xShQL7y314TViGgIjvrllU676F8agf4RY2ewZHmgK4=
X-Received: by 2002:a17:90b:164f:b0:2e2:bfb0:c06 with SMTP id
 98e67ed59e1d1-2e94c2b086cmr21054719a91.12.1730799142429; Tue, 05 Nov 2024
 01:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105072642.898710-1-lulu@redhat.com> <20241105072642.898710-2-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 17:32:10 +0800
Message-ID: <CACGkMEveK1uOg=Hq2WuYFW7+DbMoF_g6QjV5cUFkBHUEQXkcow@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] vhost: Add a new parameter to allow user select kthread
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:27=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> The vhost now uses vhost_task and workers as a child of the owner thread.
> While this aligns with containerization principles,it confuses some legac=
y
> userspace app, Therefore, we are reintroducing kthread API support.
>
> Introduce a new parameter to enable users to choose between
> kthread and task mode. This will be exposed by module_param() later.
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 2 ++
>  drivers/vhost/vhost.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9ac25d08f473..eff6acbbb63b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -41,6 +41,7 @@ static int max_iotlb_entries =3D 2048;
>  module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>         "Maximum number of iotlb entries. (default: 2048)");
> +static bool inherit_owner_default =3D true;

I wonder how management can make a decision for this value.

Thanks


