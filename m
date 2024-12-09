Return-Path: <linux-kernel+bounces-436957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94E9E8D13
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE5018852CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD7215078;
	Mon,  9 Dec 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgNbGlx2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B25FEE6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731957; cv=none; b=UakZfhMybJXXD/Ck8NtOlXgxcWcjXzhOR9TtEd3e1IRdddmzAUofjE1RtnStM1z0wH5hg+l0V2lCbJ7nDikrhLwpc3EohEuIkh6vCWRM/hW/Lbec7QI92FobRg6UGWpP+k/5CmQ04GRmEU1WMnTSLTKzmBQgHWNlXFNhIDQaTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731957; c=relaxed/simple;
	bh=CIDLRtWxpCTzubiuT1G+hWeLeL6DwBMP+Otf5IDdt24=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULcuwUdEJzpHME+pl1gOh+BFClq+PHJ6ljPPsctFGrVX/RqlMPyrktcYAMDnl64JSrFhiTRZNfiroDXEoy+oVpd8E9QmyNAjwFyMkV4gHvngmGAIeND3jp/jWoMn2GVRei5z8k6buabJO3NvrgtSvKCUEiOLg8NP5aVHYxQJUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZgNbGlx2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733731955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L5yC7lqUzH5mFK494KvVO6PDaHTHKqMAdkFw5mKAc90=;
	b=ZgNbGlx2ORIOyHOZRsRU3lDg5dsy3+ObtPGx9KySoAUYOiYKPDzZQBJwlDJBL56M6tWad0
	m+c56YlHHPzEGaywCqJXuiaPra39Ix4AYs7aMLE07TZyxGtRfmL9jTkUvjaYCvKMNOvsoF
	7EeiRl875Qp295joI1Fj+RMJSgBs+wE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-6aEoCTNyMD20UTTTIyyIJA-1; Mon, 09 Dec 2024 03:12:33 -0500
X-MC-Unique: 6aEoCTNyMD20UTTTIyyIJA-1
X-Mimecast-MFC-AGG-ID: 6aEoCTNyMD20UTTTIyyIJA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e3cbf308so673835f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731952; x=1734336752;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5yC7lqUzH5mFK494KvVO6PDaHTHKqMAdkFw5mKAc90=;
        b=T8H/VWjVYnOBnDWZbYwCGLusMnfxBgGCuqbjlG2pIDvRfzaQwqWW5IkXEFp6onK6rl
         knu41h0mbNYDOMokbX1LKCmWsqfNCyTKJSCUaC7GeeujHIiNk/ygFdxjdvUHFTN/I+YG
         o+eeMEoFCk7a1ufyxEZM0JY4g3QiPpsF55OU7B2BzvUxm7A8dMf/F0saXc6eImuVzGLx
         DLKzHAgthGS2jYIcMGALaD958yBBqyRHQsmPrLs5dcXiELXE+sD15KekQmykD+7bEyhL
         +f+WEps2EN8GVQ4OEtA3cmqFy0RqCEpoY2QPkKBUDy1Y5PaG0OQ2FJDvveZ9NNTIrs8Q
         iqEA==
X-Gm-Message-State: AOJu0Yzjf/jSA4w+atjhxqBrXmB9wbiM8UXsZ/LgTCFfmTdBV7FRzZOW
	8JpgVI1OCbc7sT/QEY3y55MLYOp4XT2n+kfXeyZV+43b6GdF5WW4tUSOw6zMElD6oJn2Au+B0qu
	8tdfXXkwNChSAknmIrT8poVLcIZIz0BGrEi3sb1TRJEkEgP+eR9M4HwBUz0luJEP+RaVFXEPo9+
	TeaMTCh4A5N74dZAF3UZ6NQmKBqBEAyTpfkx9z0ipMyypgenU=
X-Gm-Gg: ASbGncvPAZ5+GcqynwZSXBwe3HPG+IXAzY6IyjoOBU1LsSnexKxFP2R2lqGtP0PdIgH
	3foh1637A+R3q0/ydAKt4L6boLWsNiezbOcjmKDB29qRE91+EVqIUDlwPu1LtWEJ0Lr0Cryk/Pm
	wiWe8x5KGFUNKNnwR0qeIz4UAaMIy+pxZu+auSaGfXIdj7lMvGzZVdRCu8B8QrEZ/lIcPA4lmHz
	HD6iox4+jSiUE6dnQmVuxgWQdBUrBYFKOO/4/+jyrItqbS4yT3zNDwMn+0GFpvYO9Y2xH3hAkYS
X-Received: by 2002:a05:6000:178a:b0:385:f417:ee46 with SMTP id ffacd0b85a97d-3862b33b786mr8424402f8f.2.1733731952576;
        Mon, 09 Dec 2024 00:12:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERxpCGr5FOfh+U40F7TT+UTrCH8cNOIQnKmUp3DkdDwCzxkwMqazGOe3UPcw0ZmgS6DnrG7A==
X-Received: by 2002:a05:6000:178a:b0:385:f417:ee46 with SMTP id ffacd0b85a97d-3862b33b786mr8424392f8f.2.1733731952258;
        Mon, 09 Dec 2024 00:12:32 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862f02f5c3sm8592429f8f.65.2024.12.09.00.12.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:12:31 -0800 (PST)
Message-ID: <94c05164fe0bc0b0f52fec3a1d21e0b836fbdf54.camel@redhat.com>
Subject: Re: [PATCH] sched: Move task_mm_cid_work to mm delayed work
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 09 Dec 2024 09:12:30 +0100
In-Reply-To: <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
References: <20241205083110.180134-2-gmonaco@redhat.com>
	 <4c067b75e06aadd34eff5b60fc7c59967aa30809.camel@redhat.com>
	 <5ba975e2-06b9-4b98-bece-d601b19a06db@efficios.com>
	 <ead55d690448cbf23677bcc1b4c1a5c129240c90.camel@redhat.com>
	 <445b4203-940d-4817-bd45-9da757f22450@efficios.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On Fri, 2024-12-06 at 09:06 -0500, Mathieu Desnoyers wrote:
>
> Thinking back on this, you'll want a program that does the following
> on a system with N CPUs:
>
> - Phase 1: run one thread per cpu, pinned on each cpu. Print the
>    mm_cid from each thread with the cpu number every second or so.
>
> - Exit all threads except the main thread, join them from the main
>    thread,
>
> - Phase 2: the program is now single-threaded. We'd expect the
>    mm_cid value to converge towards 0 as the periodic task clears
>    unused CIDs.
>
> So I think in phase 2 we can have an actual automated test: If after
> an order of magnitude more time than the 100ms delay between periodic
> tasks we still observe mm_cid > 0 in phase 2, then something is
> wrong.
>
> Thoughts ?

Nice idea, that looks neat and fairly simple. Also by printing every
second we would get the threads running in short bursts and, probably,
the test would fail with the current implementation, depending how long
we wait, of course.
I can try to draft something to test my implementation.

Thanks,
Gabriele


