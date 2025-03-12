Return-Path: <linux-kernel+bounces-557293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986BA5D6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6794189C438
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076A1E7C2D;
	Wed, 12 Mar 2025 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLmUes0o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE41E5B71
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762643; cv=none; b=N6LyZs3Fm7GWhFkfGKyY6Xo+NuL91a7oph/AXiyVlYGZeTykMXsv2wdkMVgS31tm9eRC8qahey5PxRSmALgZ06qW5Ib4ed0vvifygGBpwLNBEuqBRVtM62X8QI31YEUKvTXUEu0QBRXdxBaA7TZUSnx0lvdkpOfKrTgxF7qPcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762643; c=relaxed/simple;
	bh=x67uQLsxjU3vUzZvTmVqB7uKc+5aHp3gPVKBlAOXdOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/u8dsZhjPkKnGkUw++tF1pd7qKAluoeMV5rcvYxKyrhTjI7I/vMsHn7P7mXu8YUAMkiKxgJqvA12Ia/s2dmQx46Ysf36EwLGuKPcVF2ZiA1xZ3zmys0GgfDPuekl4ZTr0pP27pSy/pvGRR7nWRrKAHMNYupl0BFCP6LmNq6Cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLmUes0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=D/T6VZ51OxElvIx263fopdHYKj4WI3VHYEX8QXJymOA=;
	b=bLmUes0og54kIYmg9xFK/4JQi7y+pKFAtnMGY3SAKNs8OO0RJQFL4Df8PN3WmYctYX7Pt8
	4SG6dYgTm6vRDyKm/w9P8279weOFs4JDpwzF/pqI19/UcGzHnJqK4Xc3GcXV2dnZZv6IrB
	BHwXymj3s7bOLrUtImJv/hCjlmMNCNc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-EkCw5yrnOMKRdUX7JCMcKA-1; Wed, 12 Mar 2025 02:57:19 -0400
X-MC-Unique: EkCw5yrnOMKRdUX7JCMcKA-1
X-Mimecast-MFC-AGG-ID: EkCw5yrnOMKRdUX7JCMcKA_1741762639
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-438e180821aso30845045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762639; x=1742367439;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/T6VZ51OxElvIx263fopdHYKj4WI3VHYEX8QXJymOA=;
        b=dLlvRAl3Y3TnSK6gu+Ju6Pqc2Yzr/Gsu6KB5WdLyzF1WnqYl47O2VLfCYbroreuQOx
         3wIwDmTdOFfMMq8t54r9UIA25J5Cr9ILaE0twYWlU7vv12ZsYsOhol95+K7lxFO4z7qt
         SclMIco7TDcM3Wixvz8eRzmvia2GmWzQmWX88zBo0D5yCa64eqNugjiyrtvXMF7nL91o
         c6Xr/rlLiTrUDRfYK5dGLJhhHYhyIUwCZwdhWOnsojXh3WwirMD1cpzn+7lBS+8N4o5k
         D3Ccl7m7vyJGzwnVt9maI+Ouu5lcj481lWdS8l9+CNY7LnORYFNb93Eyd3hBG+KdmfZY
         p5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkiXedPzgRBbbs1mLnJJrsuhdSBamRx7XvstmuL48ui2ax4YbUzTX7K16ij+O3SmruDaujVrVD++wA7/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WwsqsKkdNNNU6MTDq+74l3V0D2vMCHh+0Nz084lV6mNfd6qv
	6rVFPUas0GVDcIq0LVVfB4UEFrhpaDoTkoAcu32UtdaTLaKma6+EtdNYJwPrg0nsj8uDKOuF9Th
	TAjTTYDfVPjOk0r1AOV8lNRmR20u8ydyLMHjviZTnJpzIBKe1pDmyx5qH6p3tIlJ8LzZdii4Y
X-Gm-Gg: ASbGncsxfYFrkXqWwEi+LxgCgdHYh6V5sgnw201bk9uZGWxMKDp6Gx6lLwoxQ/UHbG0
	TSnXXDlmElCYc69ftin24z1PQ5QcuR2J8t81/CRCpDN4aYiekg/LPYPAMKuXpP+LGSoEf6bgQwH
	2nUcCAf/2On8l/szFXlW5f7jP4oLS66sZMKKdae+YgKOSstqW8QRQ9xziKML73apUO/sRyy0+IU
	B7zpy/uYZy5HXK2/D+GB2P3LNKHfXMVHXcWBR3Czt96265i9u/hdOg40fhGIQJ15ax5UbWE+jh4
	CtsNYdLZe4dJrfH2/CUZReFth5WtUiPaSwqA475XCA==
X-Received: by 2002:a05:6000:178d:b0:391:300f:7485 with SMTP id ffacd0b85a97d-39132d20ce3mr13892360f8f.8.1741762638756;
        Tue, 11 Mar 2025 23:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB2R+Abn/HbQu8JTjfd7VvjZqSMksnSyKTyI92bFesczk8jr9hcPiHcT/8gs/MMH4A/5tWrA==
X-Received: by 2002:a05:6000:178d:b0:391:300f:7485 with SMTP id ffacd0b85a97d-39132d20ce3mr13892343f8f.8.1741762638386;
        Tue, 11 Mar 2025 23:57:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e34fasm20308143f8f.75.2025.03.11.23.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:57:17 -0700 (PDT)
Message-ID: <5ed67309a14e9971fa46bdaf2ae2cd3f5db60fe5.camel@redhat.com>
Subject: Re: [PATCH 10/10] rv: raise the number of per-task monitor to 2
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, john.ogness@linutronix.de, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2025 07:57:14 +0100
In-Reply-To: <8ebb6cc8f566eaf6c62eef8391e930dbac10d66b.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <8ebb6cc8f566eaf6c62eef8391e930dbac10d66b.1741708239.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> There are 2 monitors to check realtime applications. Users may want
> to
> enable them both.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0include/linux/rv.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 6de4f93b390e..224c2194f582 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -44,7 +44,7 @@ struct ltl_monitor {
> =C2=A0 * adding more or developing a dynamic method. So far, none of
> =C2=A0 * these are justified.
> =C2=A0 */
> -#define RV_PER_TASK_MONITORS		1
> +#define RV_PER_TASK_MONITORS		2
> =C2=A0#define RV_PER_TASK_MONITOR_INIT	(RV_PER_TASK_MONITORS)
> =C2=A0
> =C2=A0union rv_task_monitor {

I was thinking this value could be defined in Kconfig. Here you are
adding two monitors that belong with each other, that would fit nicely
with nested monitors [1] (patch waiting for final Ack).

Your monitor (let's call it rtapp) would require 2 slots and you could
enforce that in Kconfig.

Of course you don't have to add it to this series, but just as a heads up.

Cheers,
Gabriele

[1] - https://lore.kernel.org/lkml/20250218123121.253551-5-gmonaco@redhat.c=
om/


