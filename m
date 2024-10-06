Return-Path: <linux-kernel+bounces-352311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E71A991D5C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82B91F21C56
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154C71714AA;
	Sun,  6 Oct 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi7IUWTe"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130B150990
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728204465; cv=none; b=Wc6NNAUpF/Tf5uMpWEyEK2sOLB/EOjLQDk8x3+EFc4NkjGZQqbvdPUh+3ptNY7DmfO8UelPhcQEHpzQssbbdVarI6b1j8ImRhJDP8obJVgBr7kDCY45EIXox9AJJ8/Z/tPjRCWs32kmixEdytBPm3lFRSzDAELlEA61HiLWmmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728204465; c=relaxed/simple;
	bh=VefKXn4256AekPAE/FKsD4k2x/jTt3+ChOBib9JanGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ksz3deS0X4CrlhZTB5kXMV7FfDIqqtuIoSKeZulNFwNQ60VgH4hMXRVjAfHQFn9xR0oSPSp3yfPY05uLSti0HEs8uZ0jny7BrJ9ROgxk31hJrSPDkmRcTPedon94kmhRZqDEk3mq/wRkm2yE9Tx0CRAapRyBM4X+Rg7ZTGpbDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi7IUWTe; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so34314395e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 01:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728204462; x=1728809262; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJHEoXsWN5hyUxajNYzXjn5PZ0HeusIMUN5+ZB1UWo8=;
        b=Mi7IUWTeH5LSort2dtSFM9UO5w2KnftKMYfF5abNuAzWtq6a32Cxjiq9ILGrS61SxM
         FS94g2ZxfKZOihHBMiMMSW2VundMbR3r7DYHA421qy2Pm2FzwqZhmjpGM005ACxkE9aF
         nFUO2gWDTsxhuUKs56NaYhrf/zJFJPC9rhP0SNv19HTf7CAxC4KUsW1e5+lEA1951mhC
         C4w9RfARZf384y8qn483OCBvugQBuvEuLTk8zhyM61aheVKaExCSH2tdZvf08i5HZYgu
         LPzdz/HeKpc71v1jM26LXDM9PiZGcfQzYxa7/b9a6yDdnFf4vqxXB/SzWBEudW6ESAhi
         tW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728204462; x=1728809262;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJHEoXsWN5hyUxajNYzXjn5PZ0HeusIMUN5+ZB1UWo8=;
        b=TtoQgqhggSaXogOCVU00OcyaT4md28dthZeWKuB0de7xlDkYeSem0fpA12hnw0bheA
         Xu6hNXRPGTSK6Mop34yjMQBemHJMMn+CmcrcjgTnK4wsevd9Ie0NrYOiP9kw4i1KgNtx
         /CNlRxT+o7b9zAt4ZlIBjAzYnAkY3yWfA1wWXGrNkK15KGL9J3PDaaOJMM76nsTdGBGQ
         uvtNQdteaVg4EVtkuPurx/aUdtukD9KeAImekPJGAhgAuVcyuGmjSXXjcch4DO232J5B
         4hn9V4zXNKuKoeHZ77i+/jPlolEG216UH7uhetBaHJF5QyRWso5If5JZd87DCxDgHANU
         SpKQ==
X-Gm-Message-State: AOJu0Yy7QLB53k0+Mp78zOZyMeaRFQ/Y59MWpiOZ9BSJkB+3S+WxNRrt
	028vkYhVTCKim44uwqNAqiKErvGKPQ/gffj8OrCI3GMMVN76hb6lAv1JZg==
X-Google-Smtp-Source: AGHT+IG1iyqcTvXYAHKq0HImvyLzS5elsP3aE7861jOtnTLfHBwZjkPtP5/uG1FQ/wAoq9QCzu96Rw==
X-Received: by 2002:a05:600c:4e86:b0:42f:5ca3:d784 with SMTP id 5b1f17b1804b1-42f85aae76dmr69458895e9.14.1728204461792;
        Sun, 06 Oct 2024 01:47:41 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:88c9:84c7:abb8:5637? ([2a02:168:6806:0:88c9:84c7:abb8:5637])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4acddsm59245735e9.44.2024.10.06.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:47:41 -0700 (PDT)
Message-ID: <900b7ee9e96e38b0d3cc088f3c6040be0915464b.camel@gmail.com>
Subject: Re: [REGRESSION] alg: ahash: Several tests fail during boot on
 Turris Omnia
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 06 Oct 2024 10:47:40 +0200
In-Reply-To: <ef7c7a96a73161e0f5061503242a8d3eddef121f.camel@gmail.com>
References: <ef7c7a96a73161e0f5061503242a8d3eddef121f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Some more experimental evidence on this.
I just evaluated the "selftest" status in /proc/crypto after boot.

I looked at three versions, each with 5 boots.
- v6.12-rc1
- 37da5d0ffa7b (the culprit)
- 96ad59552059 (the parent of the culprit)


v6.12-rc1
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Boot #		1	2	3	4	5
--------------------------------------------------------
mv-hmac-sha256	unknown	unknown	unknown	passed	unknown
mv-hmac-sha1	passed	unknown	unknown	passed	unknown
mv-hmac-md5	passed	passed	passed	passed	unknown
mv-sha256	unknown	unknown	passed	passed	passed
mv-sha1		passed	unknown	passed	passed	unknown
mv-md5		passed	passed	passed	passed	unknown
mv-cbc-aes	passed	passed	passed	passed	passed
mv-ecb-aes	passed	passed	passed	passed	passed
mv-cbc-des3-ede	passed	passed	passed	passed	passed
mv-ecb-des3-ede	passed	passed	passed	passed	passed
mv-cbc-des	passed	passed	passed	passed	passed
mv-ecb-des	passed	passed	passed	passed	passed
crc32c-generic	passed	passed	passed	passed	passed
sha224-generic	passed	passed	passed	passed	passed
sha256-generic	passed	passed	passed	passed	passed


37da5d0ffa7b (=E2=80=9Ccrypto: api - Do not wait for tests during registrat=
ion=E2=80=9D)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Boot #		1	2	3	4	5
--------------------------------------------------------
mv-hmac-sha256	unknown	unknown	unknown	unknown	unknown
mv-hmac-sha1	unknown	unknown	unknown	passed	unknown
mv-hmac-md5	unknown	unknown	unknown	passed	unknown
mv-sha256	passed	passed	unknown	unknown	unknown
mv-sha1		unknown	passed	unknown	passed	passed
mv-md5		unknown	passed	passed	passed	unknown
mv-cbc-aes	passed	passed	passed	passed	passed
mv-ecb-aes	passed	passed	passed	passed	passed
mv-cbc-des3-ede	passed	passed	passed	passed	passed
mv-ecb-des3-ede	passed	passed	passed	passed	passed
mv-cbc-des	passed	passed	passed	passed	passed
mv-ecb-des	passed	passed	passed	passed	passed
crc32c-generic	passed	passed	passed	passed	passed
sha224-generic	passed	passed	passed	passed	passed
sha256-generic	passed	passed	passed	passed	passed


96ad59552059 (=E2=80=9Ccrypto: api - Remove instance larval fulfilment=E2=
=80=9D)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Boot #		1	2	3	4	5
--------------------------------------------------------
mv-hmac-sha256	passed	passed	passed	passed	passed
mv-hmac-sha1	passed	passed	passed	passed	passed
mv-hmac-md5	passed	passed	passed	passed	passed
mv-sha256	passed	passed	passed	passed	passed
mv-sha1		passed	passed	passed	passed	passed
mv-md5		passed	passed	passed	passed	passed
mv-cbc-aes	passed	passed	passed	passed	passed
mv-ecb-aes	passed	passed	passed	passed	passed
mv-cbc-des3-ede	passed	passed	passed	passed	passed
mv-ecb-des3-ede	passed	passed	passed	passed	passed
mv-cbc-des	passed	passed	passed	passed	passed
mv-ecb-des	passed	passed	passed	passed	passed
crc32c-generic	passed	passed	passed	passed	passed
sha224-generic	passed	passed	passed	passed	passed
sha256-generic	passed	passed	passed	passed	passed


If I interprett regzbot history correctly, there was already one fix applie=
d on top of the culprit.
But e7a4142b35ce is already part of v6.12-rc1, and obviously did not solve =
my problem.



Best regards, Klaus

