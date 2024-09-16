Return-Path: <linux-kernel+bounces-330838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821B997A506
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54841C21DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F281D158875;
	Mon, 16 Sep 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjcdVq4f"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86C5156861
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499665; cv=none; b=OyMEMFDlduGV9UdPJvgSCW6n59VPnxl5+h2KRoVfH8DUgZ1WZtn9uso94F7he6Qjkq2iJ6bpSTp0BX7y8sssIdLVAmSx6OoWGM+A5plSmKQkmJCWFvJ/oEBRVQwJQ5/CL6S9k/A0oudftfbaWpSCXfWa0Wppf6mxygZ3LOQNZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499665; c=relaxed/simple;
	bh=MNPa/nra4xltq5ilgrLpTIhW6TE5b8ddugSCAeqVmYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WwryB+YcdaRh/ROENIB0RE0dx/qD6DEVoy7x/pyRiTaIyBKX/JBZJ7UiLXV+dj8YZaD//j9c9r5fJtXqVXxwnNhCALwpKYPzYsMUYmNVzA79JadmeWZStXPChHJrMMbI92uOh7J40MO3JuYoiRbzMVpvD0Poz2gSgCdF2wjyuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjcdVq4f; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53653ee23adso4092107e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726499661; x=1727104461; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OsAXTXOvZFK/Kljg8OzHVc5yBHojHdqEWoO5Ysa4qY=;
        b=CjcdVq4fCKX9SnL1Fc4e5//pBPIj5qZWm7cJhDYiESriFaOtU+CpUnzLsWicR50tVs
         JhAPA05WmWybU31meXeYjm5k6ZYxUymry4RHT+BYaRg3wdSwAr4RuTcfUnQ1G0Esvxg5
         nbh1UTcbWXUYJre4FTm/rE8DXaeHPRYXz0Bxgcl8HQ27tHHcBvu/7eQEWGFin16j/ScL
         y9cGg0Hzr3FfLooUwEh/HG9lVxR9TfmV1NeGAr/XjavRvHjskN7Z4YVMjYAbCnDkuaXY
         liJ0FCXGnS1gPxt+BUMSnKwRihN6IzYrkVB2U4qS8WmM/VoU93ddyUY9E2u541RrMX+O
         fQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726499661; x=1727104461;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OsAXTXOvZFK/Kljg8OzHVc5yBHojHdqEWoO5Ysa4qY=;
        b=PeW9Yn5yJLChiw8Uc60wv68Di2t13g54Jebd0yDwUiZXpR3XPN+kNbvjAdNvxnhgBp
         aNtE/EYUQGU6hodg1Q4UC3RwDJUccjB17PZJ9BNZ/R9c6qwblIgETD7PA0sM2CTZLxM7
         PKYLPk2qAV6Rw2zjil/jKENL645mngXt1YZ/sibNR+cndcDUwdAQ8WmLmijlDFH4qpJE
         plLRlElLYTgbZ72h+DhJHbZAPjLQFm/UtTWIrdouFAiuwHgQr7uYC36g+LtvAhjPIDrD
         ONkAf0F0e+qBWk539t7tt6ql/YM9NvvYzlizxAMmN4fldf/dq0/LQ7IIm+vzlTY6xKSK
         Xa8A==
X-Forwarded-Encrypted: i=1; AJvYcCV2vHQURFHdK9wGdsmMfXTDrfo22PmA3fRNURelo6Xl1BgX+nHkbfHvg7MG3keZkTbJb41X9AxUwtWc8TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxG1fIDy7NQQs09sNIgYOGf/ZqeIZwDEWJXapZuvUILOagUPC4
	J8vgBg9LaqbHP74/2LSgNiiY3Dkk19jq8ni8Up05RIsOJCIMx8Z75MBGZYvpigY=
X-Google-Smtp-Source: AGHT+IHIZXxEIzCYwbLCzOTPPzjeLXzlFrRve1oqay800OYWVBqf3F+U2I/9rmXJlaoNgnkyGoPWdg==
X-Received: by 2002:a05:6512:3990:b0:533:3223:df91 with SMTP id 2adb3069b0e04-53678fbab40mr8213405e87.24.1726499660625;
        Mon, 16 Sep 2024 08:14:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f386dsm329089566b.49.2024.09.16.08.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 08:14:19 -0700 (PDT)
Date: Mon, 16 Sep 2024 18:14:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] nfsd: prevent integer overflow in decode_cb_compound4res()
Message-ID: <65cdbbab-7dca-4a73-af07-29863ab8f526@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If "length" is >= U32_MAX - 3 then the "length + 4" addition can result
in an integer overflow.  The impact of this bug is not totally clear to
me, but it's safer to not allow the integer overflow.

There is also some math in xdr_inline_decode() which could overflow, so
really it's ">= U32_MAX - 7" which is problematic.  Let's just check
against INT_MAX and make it easy.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/nfsd/nfs4callback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 43b8320c8255..12b44c9246d1 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -317,6 +317,8 @@ static int decode_cb_compound4res(struct xdr_stream *xdr,
 	hdr->status = be32_to_cpup(p++);
 	/* Ignore the tag */
 	length = be32_to_cpup(p++);
+	if (unlikely(length > INT_MAX))
+		goto out_overflow;
 	p = xdr_inline_decode(xdr, length + 4);
 	if (unlikely(p == NULL))
 		goto out_overflow;
-- 
2.45.2


