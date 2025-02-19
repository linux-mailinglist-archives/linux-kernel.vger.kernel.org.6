Return-Path: <linux-kernel+bounces-521328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53EA3BBA9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7283B2034
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E6D1DE4D2;
	Wed, 19 Feb 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2exDrwG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B21D8DFE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739960945; cv=none; b=DGlkmUJl7bpJUxCcCqYWCZ2jDjqfrLbPH+SLnwPXjVSm9+OUQHDexK/GrH0m2AZsb+mc9j6PjY4n7vcaaz7JIjgW3/JNTa1CFkxRss0XFhJeEiRnS+4x+mzkaTYYUfiO66aoUXTcvzmB4+qieZWxA7aX1Jen/6IRXV2QOciMsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739960945; c=relaxed/simple;
	bh=KmZ5ajCGsmMtxPtx6lFWMFy5vKtZAWai7zkdN2IydG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pbz4V6kYe7fJK85wRttcMajZdRs/VxQi2Ufqk7+EVkJ4nixlHLbP98/+qtaax2Ie5O4Wrr9GQlWfAiDRpPk67kAsbH1uyWebaDCmrlyBy9+vMuHoFATsZyz08NDfhi8cw/3tMXaNXPi22zDDj+0D9jpU/G93zFox6QCyDJlNa7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2exDrwG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739960942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KmZ5ajCGsmMtxPtx6lFWMFy5vKtZAWai7zkdN2IydG0=;
	b=J2exDrwGkQ3wV+emfm7/T0qA++dPNdRlfVAKILmUmFT578k2XBxpMk3xHRPi4KDsE8NeMF
	srqVSZkD2xZgYTztj2UMvL2XMYj2tCaroCo7vqVwFEw9MEJ5NbIptRUHTZskWnoU9kjBJK
	mbEJUNg/Q2rNo6Df40wUfZJsB0OOUpo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-tgw5VtvEOH-TyPE5FenKTA-1; Wed, 19 Feb 2025 05:29:01 -0500
X-MC-Unique: tgw5VtvEOH-TyPE5FenKTA-1
X-Mimecast-MFC-AGG-ID: tgw5VtvEOH-TyPE5FenKTA_1739960940
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f20b530dfso6540923f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739960940; x=1740565740;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmZ5ajCGsmMtxPtx6lFWMFy5vKtZAWai7zkdN2IydG0=;
        b=S39/T0cI5czpUF2jRIcILt8EopYBPxue5RKxaN1kafDWNxFg/ezGGdlr0nIJy/LzDq
         Ame4eSMoZQuU7SgEPb9ySYyVGDwBJTQPzI32d0IFSYW5UUKC+52g4jyzNrK9TTaW2KTn
         fgmRxZsEYrHvq4Jbo8oxQ+3Ri8bggaIuhUE7xszcDdJvQ72VwmOzcZIz+2MFvyqBAj58
         1r1mK4DtfQixZ6bG6CHKbvcbWnVyiG1b94Bf+fMF22GeFwA+zx0zg/cEiHVJIn6t19cv
         egwRE5Jg6HmRU0VG55vx2LLTwXwWCUMiTjTfY1Dm2sHFXXzYj5uIxRX5CjDWLdDWcqUd
         mrDw==
X-Forwarded-Encrypted: i=1; AJvYcCVrwczpiui7tEhbSaUk5YTSWEDvTS47uLsIQL4mj1AB+uLJCOP0hVinhSEzhmb9kDY8j9S9lmeqY7OSwEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYoHjgSjAl8pnxOq3tN3C6BNHCfBY+BP3JUr1RcozgdpITEV7
	R8IfGHDbcdnhbe8BBzK1+70gNWzCiZStdAcjYSY8cAu5X5/TG0XMyTnWX1u4hMdhuNDqYtBydij
	1bQ9Nh+4SWHvK5tEmNFT3uEKPaGv5IGTJysBfQh4Zy59GZ92T1C1GfaK6BS/OTA==
X-Gm-Gg: ASbGncu52S6/P/Mc2Ymuj1C7STa87O84Gy0TAjHsRkcK9ymi1rCkYOrHN7YFbFHjlXq
	OceziYQR55J2X72So4CW7a8A4DaX5kitJFsOLw+oIuK9+pCnfmXHVmI6uVliJVWiqqYrnkkAe54
	/rexvmZqAv7f1xcr1I98IqUeE0ekFiTW1Ix9wm9f8+gvSrCuKTGJwYlo06oRw8q13FikSx71n4S
	BzKcUpYeHyI0Mo7tX01hso7PfWI9wN79B6mSa4N50fXnGqk3LVBZWvZfsJsAPXVdLPKHx09MS2j
	JKmjYPt7ukdJkTewivKqO4AQPcp+oMU=
X-Received: by 2002:a5d:4d85:0:b0:38d:e48b:1783 with SMTP id ffacd0b85a97d-38f340677a9mr11940525f8f.42.1739960940037;
        Wed, 19 Feb 2025 02:29:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX4l3XnwGj5iI5iIwJhLUZxaYwE8XwogtZmAZmicFid0uvz2Ao/SLPmwQ87+MadnmNKiUjMQ==
X-Received: by 2002:a5d:4d85:0:b0:38d:e48b:1783 with SMTP id ffacd0b85a97d-38f340677a9mr11940517f8f.42.1739960939726;
        Wed, 19 Feb 2025 02:28:59 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddbe0sm17665396f8f.39.2025.02.19.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:28:59 -0800 (PST)
Message-ID: <e74f656e58c1c0a113de87b745a13aeae7370f6f.camel@redhat.com>
Subject: Re: [PATCH v5 3/3] rseq/selftests: Add test for mm_cid compaction
From: Gabriele Monaco <gmonaco@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
	 <paulmck@kernel.org>, Shuah Khan <shuah@kernel.org>, Ingo Molnar
	 <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Wed, 19 Feb 2025 11:28:57 +0100
In-Reply-To: <60671af0-204d-413e-9b65-00b526764ab9@linuxfoundation.org>
References: <20250210075703.79125-1-gmonaco@redhat.com>
	 <20250210075703.79125-4-gmonaco@redhat.com>
	 <da68dc94-9aa8-4ee1-b0f9-e28eb5c7da56@efficios.com>
	 <2c2ee65283893a433ac4488f3d048b0f7454be24.camel@redhat.com>
	 <60671af0-204d-413e-9b65-00b526764ab9@linuxfoundation.org>
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

On Tue, 2025-02-18 at 16:45 -0700, Shuah Khan wrote:
>=20
> Please send v6 with the suggested changes. Also change the commit
> summary to
>=20
> "selftests/rseq"

Sure, will do. There was actually a V6 already, so I'm sending a V7.

In the meanwhile there was a discussion about the approach. I'm going
to send as V7 what is closer to the approach in V6.
I opened another series for the other approach (scan in batches), which
we may continue depending on the review of V7.

The test should be mostly independent on the approach though.

Thanks,
Gabriele


