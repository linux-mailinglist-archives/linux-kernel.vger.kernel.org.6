Return-Path: <linux-kernel+bounces-512997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE921A3403E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388983A804E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59B0227EA3;
	Thu, 13 Feb 2025 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwXXx4Sr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436F23F417
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453115; cv=none; b=NdClO/Bt2cUJJeZU/tK+JX0ZFq1W0D7ECfg12lCyp37Ayq3esRVUD+R7xTsgUCh+cLWomBLkqH/J1QiaA4p5mN7QbZB7F0hPb+lDAZg1x2VV9rfpFAOJjbbFrSkk+SgXz9YlzPyykwUV2AdM/N4maZW5WIQEz6PJv45igFL0tDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453115; c=relaxed/simple;
	bh=nlpTqYlU19ZhD3MHlYpDucVbAZ3fLtE0n7SjmJq+xpg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKsLPcn/5FeqZV33lHzMNipYvF2aryNpX6lmuCOIz4WhTu72I6wJpQ2YGESXPs+pnhN/CG/NVxO7qypsS86TjI0OpKtrgynUPgtx7flA8Z4Dw4zgzIZ1/GMOYdDKLrGBfugVkXCjqpIcE+S6uggGMe6O8IrHMfEhvBUEj8BoT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwXXx4Sr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739453112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nlpTqYlU19ZhD3MHlYpDucVbAZ3fLtE0n7SjmJq+xpg=;
	b=fwXXx4SrUJy7+PETTVyPo63JvxUzRq3RniCvs3B112CKHcknOH0st9w0NtDjLjKeTyOU9P
	fB0NA2yZ/qsuqOP2eBHpzhFtXW9pjOzhcUEFLYMwa6dbVhY9009Kv5QZRDsyBK/HSlp0ND
	JamQ1RBqbmQ1MwpEGGVl3QLM0qFK/RA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-nkoMCMh_Ov--SXSFs_FsfA-1; Thu, 13 Feb 2025 08:25:11 -0500
X-MC-Unique: nkoMCMh_Ov--SXSFs_FsfA-1
X-Mimecast-MFC-AGG-ID: nkoMCMh_Ov--SXSFs_FsfA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394c747c72so4928405e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739453110; x=1740057910;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlpTqYlU19ZhD3MHlYpDucVbAZ3fLtE0n7SjmJq+xpg=;
        b=Vu26QmQwVKjN0UcOebDfff6CR8pYuNQkBfXqceWLkSOmY5FRICwaH3FVajL3iHWwls
         1AD2AAgg/4tck8GoSxSny0ANCVWSP+OdZEHpu0EfYIkp3mBHnFsVrAZB+sIxK6F+8Cz9
         DHOeKoa/wwptwPJDLO3E5AbiwvKK20UayQD42QOhblBvn/8n2qrq1okjb1D+DV8B2Xx/
         36Sg535LfJ2+7Cu0tI3owqEDMDA7Uki6vrV45dUM+WvxYxog73tR392mhsioIXas87sU
         SFcVZ86AAl8l/l9PpIm7Plt3so+SQx2wX4ObziQXrGWvoL2T+E3TZGVJoF2f6tHMmDiU
         yy0A==
X-Gm-Message-State: AOJu0YwCodgf/AE4/nhjd6On2HJgY2q1VksWfopj5RzJ8xKAFX/pnP7x
	y1i6BQW8BkNPC5eQCL6Rb+ImAwIbMTAyElAdE30h1qiy7ZzxUbibww8K0TaY6mK3RAQeBUeNoj/
	kwqWwBdSI7LiR6Ms2AE+1tHGXq//uKnO+MfAbcfd8nVfvW0yRuvyf8IhIcIlVbKelv0gWFwo+sW
	7RMEroykQzEFRtlPJhaVGws9ATSwO4OYv7u7ynGxtdkBrxtWM=
X-Gm-Gg: ASbGncu5bI8MivAp9s7v9fi0FqmXTV8ilWWJ8mWZhm22nLDZda3zvMHorUJGpg+xSj/
	2pWXiuVMpOMuIEW48rNBDJTmNacIYWGsjE4LYGT4w72LryS1sO1wh7qzjionLXf065UsskxFOAW
	ZTfaV8bG2rXI6Ze67TfwWQNLHcY8YAfFCUFWXinoUJkxUNY2olKP5hIyGEKLSo9hJFOSsy/49TN
	v8pRib6LhmvGQWYgh2rsgQuyvnhBpGG6bYJOVHVdovG/t6Z7dfTYKcXD9Wo0t7Q6IWUZa0frQSa
	lZiB8YhI8SMW+voAy5BAw2HO+2xglac=
X-Received: by 2002:a05:600c:3d10:b0:434:a711:ace4 with SMTP id 5b1f17b1804b1-43959a49372mr72138895e9.17.1739453109823;
        Thu, 13 Feb 2025 05:25:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENU6VjDlB/N2PN9hlVnLZiGSzFJRV0p4BpMXpvTMGFtoS2ruJMjqgGYtys6hIAo1qsw5D79w==
X-Received: by 2002:a05:600c:3d10:b0:434:a711:ace4 with SMTP id 5b1f17b1804b1-43959a49372mr72138295e9.17.1739453109324;
        Thu, 13 Feb 2025 05:25:09 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43959d3d5f3sm49848455e9.0.2025.02.13.05.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:25:08 -0800 (PST)
Message-ID: <17bda9071b6962414f61668698fa840501819172.camel@redhat.com>
Subject: Re: [PATCH v6 2/3] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com,  Andrew Morton <akpm@linux-foundation.org>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,  Ingo
 Molnar <mingo@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Shuah
 Khan <shuah@kernel.org>
Date: Thu, 13 Feb 2025 14:25:01 +0100
In-Reply-To: <202502131405.1ba0803f-lkp@intel.com>
References: <202502131405.1ba0803f-lkp@intel.com>
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

On Thu, 2025-02-13 at 14:52 +0800, kernel test robot wrote:
> kernel test robot noticed
> "WARNING:at_kernel/workqueue.c:#__queue_delayed_work" on:
>=20
> [=C2=A0=C2=A0=C2=A0 2.640924][=C2=A0=C2=A0=C2=A0 T0] ------------[ cut he=
re ]------------
> [ 2.641646][ T0] WARNING: CPU: 0 PID: 0 at kernel/workqueue.c:2495
> __queue_delayed_work (kernel/workqueue.c:2495 (discriminator 9))=20
> [=C2=A0=C2=A0=C2=A0 2.642874][=C2=A0=C2=A0=C2=A0 T0] Modules linked in:
> [=C2=A0=C2=A0=C2=A0 2.643381][=C2=A0=C2=A0=C2=A0 T0] CPU: 0 UID: 0 PID: 0=
 Comm: swapper Not tainted
> 6.14.0-rc2-00002-g287adf9e9c1f #1
> [=C2=A0=C2=A0=C2=A0 2.644582][=C2=A0=C2=A0=C2=A0 T0] Hardware name: QEMU =
Standard PC (i440FX +
> PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 2.645943][ T0] RIP: 0010:__queue_delayed_work
> (kernel/workqueue.c:2495 (discriminator 9))=20

There seem to be major problems with this configuration, I'm trying to
understand what's wrong but, for the time being, this patchset is not
ready for inclusion.

Gabriele


