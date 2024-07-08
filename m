Return-Path: <linux-kernel+bounces-243938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF278929CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273CE1C21468
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5A1CAA4;
	Mon,  8 Jul 2024 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQBk15l7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DE1B974
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720422299; cv=none; b=um73a6PXHRFT5+rRvzpl8IX0D2SUIIhxdh4BEKSgfFS+7LUJWjADqNrhjRMmzUBWMNEqxfbnd7L5xrE1KzyWBTvlye4bFWh6BXItUyFtffYQSmoi5xk32yJlagx9Wd4CqB1X6aBHaf3TPu4OVHHUOWcdHJSvBuZzCeRcLfm1vBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720422299; c=relaxed/simple;
	bh=Lyh+OGU1qSqkgNUOSt3XboZ5A/fxDtSPgkO065fsa0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ot7cU9J6dRL2miKCZMM31dDjoKsbHLwkpbILto6CXq/+/jaPNGEs+bpz9FTIWUmxGrE3OSjdfQibmKz4+QHabW8W61fgG478yAbm0b231OOEwfsxRfrdP/Tw7/WNSyvt93ljQx+2Rs2nvlAmeUNHVXMFvG9YKTqPDR2G0TNR3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQBk15l7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720422297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuevZFB7MKI/Lq5uYauYhSH0Qsz8j07xL7h/7QL0zAQ=;
	b=DQBk15l7wcsqDpKfI4wFnm0bKEB3ge33XuOrj8f0EMf/RaXLbnqy+uA1evTowMJooAvrlP
	bgSVAunfYT/W779EbDVjy+5wrz1QPtxymcqPe2WJQlBsvawYKY6DRACuimB4aPr0F/Eh4v
	NPICCztreJIGRFcgssvZNGEfCBS+xRg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-sn50R59dPRKL1HA7L_O1vg-1; Mon, 08 Jul 2024 03:04:55 -0400
X-MC-Unique: sn50R59dPRKL1HA7L_O1vg-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-80fe896d0e4so1234701241.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 00:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720422294; x=1721027094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuevZFB7MKI/Lq5uYauYhSH0Qsz8j07xL7h/7QL0zAQ=;
        b=WQmokN+7RFzjFlFFSlPY6Nlyfk91mT7Vzs29kp6P+NdK240X3KBmROmnbluTHtlc6/
         JQidbwZ8f37bWMHAjdk8ooL/B/zbizV+RwAyt1uWFPBROKTPHtcWHxhJzrOIZeYersTp
         G115UZZ47psTh7b79R1BXnLVXJ2nXRndJXUj5zb/xZmVkET4wePQAW2TQ7VjIVJkC8Hf
         N2QsY8xDZGs/82GcF1kWjh/M1n/SmE5qzg5hM8iHLQ/NW5xoZPAOnXkqVaibmzyDtZLb
         z8xnJKnQUJut0cvJOomqRGUyTu6sp8jeNUzLrz8dB8ulw7wtwUQWQOPcP5rg1syQU3Uu
         JpBw==
X-Forwarded-Encrypted: i=1; AJvYcCU9iFqX2Qc2mqRMQ0MiZtW0Htxt+PxaY21SQFIo8SwOKtRLAWyyg/loEG8GZSJje6096Q/mz96Bmfc0jERUUVHqZ2aIu2fWNmNXYBkX
X-Gm-Message-State: AOJu0YxTCQzbAUKPAMsBrJ273w756jjiWG69D135xBIrAex6fQ79crov
	oD3YQIUEHTYseN+NPXuB4YI/uAD7jdk5QX1ee1ZA4sCBdQHAR3DKUIUkOUKs83vLtReTOyDShIY
	dtysB22Io8eiXbCHdGzY38446sQQ6X0JhESQLHf0rjvmqm4kmO1NoVG1MHZGW/UfhDPx+dB9HPE
	vjn6/RqefGKzJPf44D1+7TFvYiAvw+mx4RZekc
X-Received: by 2002:a67:fd99:0:b0:48c:376f:fbfe with SMTP id ada2fe7eead31-48fee6dcb3cmr8108038137.14.1720422294481;
        Mon, 08 Jul 2024 00:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgNBSM7bOK3sbqftf/T7VmMO3M7PHhmrjnMZg1tK5qooR3N3OIZ0nrg5Mz/+IAvFBjtZftOxhqa1SVHpbqFvk=
X-Received: by 2002:a67:fd99:0:b0:48c:376f:fbfe with SMTP id
 ada2fe7eead31-48fee6dcb3cmr8108021137.14.1720422294089; Mon, 08 Jul 2024
 00:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708064820.88955-1-lulu@redhat.com> <20240708064820.88955-2-lulu@redhat.com>
In-Reply-To: <20240708064820.88955-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 15:04:35 +0800
Message-ID: <CACGkMEvm59kNPvivACZt8mAZsZyp7O7FO5NUF6abB9XS_SwaEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vdpa: support set mac address from vdpa tool
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:48=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
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

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


