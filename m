Return-Path: <linux-kernel+bounces-185003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E73E78CAF47
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A10B218D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D70978C65;
	Tue, 21 May 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JcB/QtWc"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16C3D982
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297529; cv=none; b=egywfcQsy97p5xV3nrdXM3Ls6G5EOwHb+zMkItOMFmqGpRSmzGz9+Fcax0d11DIZACYbn+M+Esij27srK5LX6hA1PsGhCVWaLf+gm4d29p74ROHzeZ9EGkUdoZAfpJ/O5JTTywiFmyKteRc7R54dWTlc5Xt9W9xW6cWwRw83NP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297529; c=relaxed/simple;
	bh=Q3BzpxQzxgTGjpvVz0n6kxxufoCrf94YvT7kGwQ/znw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mJZnT4hjC/urV12IPBBPdYRqtHe+iL7Tnxqukn04xtjpbIYUEaCe5sb7Cy0Sg4VPAkbumgK9PgZ3qq/BZelqgsdgdcGQtcLSbDTy4ICPm05FUGvfuxjaRmME6rFxqGiQZmO0JOEPG6ymzIEn3c+CnD4EeZ7M1BB+JKP5RUJ3iDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JcB/QtWc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so25597661fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716297526; x=1716902326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1O/tA1X52KoacjGgYTBwOD/S3x5qNEiGtfQjLayBOw=;
        b=JcB/QtWcjtBir8Rro4/nIV9Ne50n7BVk4xDecHzG3tluIFnC2J7U0rxyuGk6w1zR6N
         Wels6fy8CYgDhoU+BHM5p1fTfs0AtJWI5J5ygEVt58QwqBPq5vQ4wPTzqu4iFWkt5ptH
         yckpgqoXT2R8vS7IUPDTfSWiLa6y3F3xAwHOiGcs4AtF1KrF9jxQsPqsdn9qUHkugaDl
         DpWlxHYPBHdK20v/3kcK4Y35Yv1SjLMf5vLyoEX5BG0LeRCdt1RlX9zamG3aM7nXf9wx
         O0qaBcQrwRucPlhGO+WSIE90visTo1QduoYd0pmNicuWwiRzRIs44eggXFmsCZyBQVxs
         CEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716297526; x=1716902326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1O/tA1X52KoacjGgYTBwOD/S3x5qNEiGtfQjLayBOw=;
        b=nGYKVL2q0+gruswezK3kDQFiOZcxmCailgUsgNat1MKmSTJhnXxzwto3oY4uLhXnOB
         sgOS43gmt3GJbWECr/ayjls9ObsdUXxtpKmnjlHAM+zuoByEY6hw+C61jIF81zZ/kLO3
         HEGhS0D4ei5A8svWY5GcWwlvEcPQOArgSv71uRBOQ+8acKnK16NnSeKXpHo2eNZqMjp1
         cntqbEvrIQdLm93dYue/3Mm+J1dogbU1YQV7NhaRuxf4JJhCI6me4nbsKy3sqRK9rXQu
         Z8pz03SLnrAjmsTjoqDIvusg1h2jJZHtYzOwvgjfA9BLwpFTDqIRWogeqqCAxvPLVTSM
         cGrA==
X-Forwarded-Encrypted: i=1; AJvYcCUxchgnDycMKtWWlRU586vUHL8njZVzamoFt6oRD5iA7ATHC9EcsEOT5QMBjKWLljLLsYH/GHHa03OfYgvox9c6wFcfITl/+tnPmLjg
X-Gm-Message-State: AOJu0YyLEfbppe+9k6Vqyf8RJI+h4PBbVkLTI2n3KBwqWurUDSuyjL5U
	6aRTZJ+F3mmfElIBM/ExyNVrkG0H4/acz8nezfCw35JJhbuWvyrLz0H0kcp0laudDaMzGeyUqQi
	v
X-Google-Smtp-Source: AGHT+IGt8DyB86CaoKzjdWfFeNKLu2gdXNrRsAo2Bzj8yuS9hbmTAVNJA1YHaPx/wWSZFwxB5Jqosw==
X-Received: by 2002:a2e:bc1b:0:b0:2e7:3484:5236 with SMTP id 38308e7fff4ca-2e7348454d5mr24652261fa.15.1716297525639;
        Tue, 21 May 2024 06:18:45 -0700 (PDT)
Received: from ?IPV6:2001:a61:139b:bf01:e8eb:4d8f:8770:df82? ([2001:a61:139b:bf01:e8eb:4d8f:8770:df82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b2653bsm497199255e9.4.2024.05.21.06.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 06:18:45 -0700 (PDT)
Message-ID: <f61cb0cb-8a74-494a-b191-8503b51897c5@suse.com>
Date: Tue, 21 May 2024 15:18:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: memory leakage in ncm_wrap_ntb() in USB ncm mode with kernel 5.15
To: "nanfengwq@sina.com" <nanfengwq@sina.com>,
 gregkh <gregkh@linuxfoundation.org>
Cc: balbi <balbi@kernel.org>, linux-usb <linux-usb@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <2024051922230825069112@sina.com>
 <2024051901-gimmick-cosponsor-f2dd@gregkh> <202405202232198531894@sina.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <202405202232198531894@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20.05.24 16:32, nanfengwq@sina.com wrote:
> hello:
> In embedded devices with relatively small memory, if the transfer speed of ncm is fast and other programs occupy CPU memory, it is likely that the return value ncm ->skd_tx_data of alloc_skb() is NULL, and the code is likely to enter err. If skb2 is not processed in err, it will cause memory leakage.

Hi,

apart from the submission process, could you please explain how this
condition may happem?

         if (skb) {

[..]
                 if (ncm->skb_tx_data

We know ncm->skb_tx_data != NULL && skb != NULL

                     && (ncm->ndp_dgram_count >= TX_MAX_NUM_DPE
                     || (ncm->skb_tx_data->len +
                     div + rem + skb->len +
                     ncm->skb_tx_ndp->len + ndp_align + (2 * dgram_idx_len))
                     > max_size)) {
                         skb2 = package_for_tx(ncm);


		if (!ncm->skb_tx_data) {

We know ncm->skb_tx_data == NULL && skb != NULL

                         /* Create a new skb for the NTH and datagrams. */
                         ncm->skb_tx_data = alloc_skb(max_size, GFP_ATOMIC);
                         if (!ncm->skb_tx_data)
                                 goto err;

It seems to me that either

skb2 = package_for_tx(ncm);

or

ncm->skb_tx_data = alloc_skb(max_size, GFP_ATOMIC);

can be executed. The code paths seem to be mutually exclusive.

	Regards
		Oliver





