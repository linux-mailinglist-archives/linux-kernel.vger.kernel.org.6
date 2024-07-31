Return-Path: <linux-kernel+bounces-268465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A321D9424FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BD21F24913
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC2519478;
	Wed, 31 Jul 2024 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+L5IZGt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE418AE4
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722396055; cv=none; b=Zazd+AmJ1XnNKQm5MQmUU9muuG9rjGuuNB84Pt+7/pf4YsDap4LE8zN8/S7lufqqsoVOiMkGYQWoWjW6PA34D6iDxx3zhKpBdqIXQA8oWEkOYzCYP8ofrXPFIJnyhPm6L1Zx4f6dDQe5rLOWejMKKd09wceeX7mkpXyEG/UwXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722396055; c=relaxed/simple;
	bh=2pK8gm6ZVpEeA1ly3iczVmymWCxm8XAdJ3C8puJvIlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpcRyqNWpMmN/AptBBZi8/kuRL+0fwRQ5gFaTQpAtPNWyU46olVwdcqSGYi33vGyAMgL9n9CbiIkJi2KQKunQrSCMkl+X3LLb4RHt3S7fTWie/zpcST1yOghPunxQjuAoz9/bgDQAgXLUvEuvLrJ0kUJiELAhAps1x6IYgjGnwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+L5IZGt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722396053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU6UZtmb7nqWjCNh35gVT9eXpDgbdzROuHvxgQjoBAA=;
	b=f+L5IZGtZvHaOv5BqDIFHLIWxxRVZ546G5FPanSCsxuChzCQ0x+hD8PYOp8s9cyPrKg2xG
	UQPS80fNeClfSFcwc0uIVUay8HjL/EknHWIyJjm5qBxeUux/PgYOFwh0PU3iPIbB2B9/oX
	J2dU28tca8/yDLvOGFpfUgoB/N0gFEI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-fMMlxd36Ouu4O524G2rH8g-1; Tue, 30 Jul 2024 23:20:51 -0400
X-MC-Unique: fMMlxd36Ouu4O524G2rH8g-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7a2a04c79b6so506887a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722396050; x=1723000850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU6UZtmb7nqWjCNh35gVT9eXpDgbdzROuHvxgQjoBAA=;
        b=myQeEDKEK+1uknalZMrCO0XY5A5j5KTSenDWGuJk/u6Ov4FB+bt2iq30vzB+izOufk
         phiZomCTMYGENmjEto+cwiYFwM2ZzYaRYsr90z8QKsT6IIC70er7UlfUqPoac2O4qsSm
         0Y3E9ghZBkmWjRgrzwaNldqXyeCL6UqRrwqOoG/x1O5YTgj+h0kn9sghGoy3ypMnW3sA
         A5AU6b8Ls6IiS/V3UGpuAkCUCX3iY3CiqYYmZrNEDmpaVy/SlUZpHt2RADDZaN2e6FOa
         UvCw23SH+FpGBcrz21XplSOk1CuccbgBqK0PAqkaokzl+1O01ITkd2GG2xi9U8hIPc1C
         QcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYv8pjvhautha+14GtVLXphoUWxQhxDNqaHlGUiuxXM/fwDAh8faR5opeMlCeOl/5uDrgh88YpCi7hjjO0EAnAmDv0XSKsJkxVn+JY
X-Gm-Message-State: AOJu0Yy5PuRmgPArCqFfU7MEDJoln8avkjuBa2vdAPO0gZQEMZpwXrel
	PHKxwtgzZ78PLI4fraqEzQjnzxjxdhN79ioWbPQlWA94EqYhV0ehcYaOpVgt2Srq9IfpTUczO9k
	sdGRKGozJa5kxpncrcaLjc38HtmGOFbsgQoeTzYoj+eTITimQY3GFNL6XEQEzJsiyqqFbydZUgE
	oRiAfPKiMQ7fXdmzBHNCrUMiuhkcJcCdrDPDDu
X-Received: by 2002:a17:90a:558b:b0:2c7:d24b:57f with SMTP id 98e67ed59e1d1-2cfcabb4428mr6355875a91.19.1722396050568;
        Tue, 30 Jul 2024 20:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdikMPaOaei1HHj0OApex9jIV+xfMGVWj4qGTkYxBDHCya8v0ooI5txmdfclcFYjj3oMf8dl8KVIItDPVvzbI=
X-Received: by 2002:a17:90a:558b:b0:2c7:d24b:57f with SMTP id
 98e67ed59e1d1-2cfcabb4428mr6355848a91.19.1722396050017; Tue, 30 Jul 2024
 20:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731031653.1047692-1-lulu@redhat.com> <20240731031653.1047692-2-lulu@redhat.com>
In-Reply-To: <20240731031653.1047692-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:20:38 +0800
Message-ID: <CACGkMEs+bpWtpFp2hT+GrRUOJQq4h=2LgKWj+U4tM9a9wMQpDg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 11:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Add new UAPI to support the mac address from vdpa tool
> Function vdpa_nl_cmd_dev_attr_set_doit() will get the
> new MAC address from the vdpa tool and then set it to the device.
>
> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
>
> Here is example:
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "82:4d:e9:5d:d7:e6",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> root@L1# vdpa dev set name vdpa0 mac 00:11:22:33:44:55
>
> root@L1# vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500
>         }
>     }
> }
>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


