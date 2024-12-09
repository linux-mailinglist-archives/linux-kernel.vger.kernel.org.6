Return-Path: <linux-kernel+bounces-437095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71819E8F08
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DB5162430
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E7D2165F1;
	Mon,  9 Dec 2024 09:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxFAqLAA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D912165E8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737618; cv=none; b=JlM1Whd9Mth2uADbdphf+YQAIfJXw5qGa6KygwBkyggg1/Snz88ktgEobZDFQhaA3sxP4n8Ugy9YFbDFn00rOwYj+x/PYOUGjjLZ/3FtZ62AveX2EAGnGVFH9JwLKiWu+dvg+HpBRlJka/d+0xf46IcWaKXPUmqwvD/eVojTMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737618; c=relaxed/simple;
	bh=/4yCcmtI9X8BI1PJ3TBHSU8LfIPaaUkVMzOZ5/bpD/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X72+xq7tVaeskwkgd1dzQ4JBTPYz7IcYRPTjICxqgSX5lzuNrilYMUPSzn3GQfGzDMtOA30D+liHPSLDVjkzR2cWPQT5tmrCPc/uwA86nGcx+8B4ac8YPQnbWgyOPTVf8rVWJnmMztStUM9MJ2YYmGOpRQZ70oPNg1VbXorbS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxFAqLAA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733737614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4yCcmtI9X8BI1PJ3TBHSU8LfIPaaUkVMzOZ5/bpD/E=;
	b=GxFAqLAAVSdKFqUYv2CN5D1NCvmNM/OmHbaok33hh4NDS2NwGCUlQiC/XUU2P3RUnJ04Mm
	LlrP36kkc/01zaulhVH4x3LoE7cHB5mPhNgoaVWIZ3TZbA31GjN4vuXIMeSYGJWvq6miZ/
	IMwIA07EVbMMRq45Y7z1JoaMHJcuYTU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-UB26wEhvPMSyxuxh1nsZPw-1; Mon, 09 Dec 2024 04:46:53 -0500
X-MC-Unique: UB26wEhvPMSyxuxh1nsZPw-1
X-Mimecast-MFC-AGG-ID: UB26wEhvPMSyxuxh1nsZPw
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d3f55f8f3aso1204452a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 01:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737612; x=1734342412;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4yCcmtI9X8BI1PJ3TBHSU8LfIPaaUkVMzOZ5/bpD/E=;
        b=oA/jEvyg3WZ3P0qN8zMGr6+D2DjTOitTKPPYJKHd0FhfhBs/9IlKi3DZeXu1AFr1l1
         82wE5kJdvRCFuIGfJCd/KObI+JI+nnhXezSnTQw9j8sKQUOi+hqxcc9kSLr/1PNOpB/+
         QWhyUqGykDiW1AR7viB/AsRSVIqiKDRlm7UWeXlKFXWhUKO32veEmTvRCWq5HJ7TrqbZ
         flenurGHIsVdrFf8Ww3K18KQ5PcBAPBz+3uqpOrqRg7LPYMyOKzdhrztaRbmHTkM1NAr
         4/hlLVzPr+j1aRy+O+Q/cFytST9dfJYOISb7exHYLRFhXuO12HNGkpQhC2N2q5bZlGpr
         o8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfkU52r3cuwYO1KJys3h8N7Chu0y6DIaaSya0lIIiZMnMgIl0lQtHUeOfD9lD3hY1PkKOd98TTX4dzxeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1r18sluljzx0dEraoCvTqV9D5aPQ7Lhgfpj+JTATc1OpHL3Od
	knMI93TsJ1wgbKtq1wCWBE3YysAEJQtpBb2+ptKE3TXcJL+tFoo4nBZ0xhLbEfrlypgdgGZK0xI
	wEs9sfcUwxkA18AEaOOf6uz2CofQpamrpO3cSoe6FuoySdR+jlSse/KEJkAq+lw==
X-Gm-Gg: ASbGncvRDCE+EZ7L6fitPvSOBXr2Oh/7s+SsjJpPKbOa32T+DbS7CrLNcdtMO/lubrA
	EGQQkMqJNJpqodTzVRjaEaD0izmSL2Ao72uecfRiy0fMCMXUs1moXs7q01hdj+ICYB/eQ9LwU++
	C8Oe5zmokOy1JgYrnW+1teEbNX89OWZfkjZRaFhHY19RxIBg32b8ljuKKpLt4J5HvA+WqMGZXoe
	g10e/09QJf2aH+Hb+JTf5OCpZ9xYT8atT00I3beTQDQq77iMXiPmTIJn7vm0apQPGEA4EjIW6k=
X-Received: by 2002:a05:6402:1f12:b0:5d0:e560:487f with SMTP id 4fb4d7f45d1cf-5d3be6b51f6mr13070162a12.11.1733737612320;
        Mon, 09 Dec 2024 01:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+SM0HMMf3rLKQaHWVX8CzFTGrQpKPYgN7rKoWJXvIPMd3Duz+8mjeqy9B/SksYJY5E9rQEQ==
X-Received: by 2002:a05:6402:1f12:b0:5d0:e560:487f with SMTP id 4fb4d7f45d1cf-5d3be6b51f6mr13070149a12.11.1733737611993;
        Mon, 09 Dec 2024 01:46:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3db53b828sm3387904a12.74.2024.12.09.01.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:46:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 84C7B16BD8AD; Mon, 09 Dec 2024 10:46:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: pktgen: Use kthread_create_on_cpu()
In-Reply-To: <20241208234955.31910-1-frederic@kernel.org>
References: <20241208234955.31910-1-frederic@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 09 Dec 2024 10:46:50 +0100
Message-ID: <87v7vt6ved.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:

> Use the proper API instead of open coding it.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


