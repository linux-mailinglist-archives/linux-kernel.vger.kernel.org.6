Return-Path: <linux-kernel+bounces-519571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D7A39E27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2265188B4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53957267B08;
	Tue, 18 Feb 2025 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uMJe0cX6"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE17267384
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887283; cv=none; b=L61Dl8iEEsUCGdKHahS5NS3bUz4bCqAfBxYqqQyrXjOKce/ZRZ8dsoq+f0CUTbQJhwLLEnRJ/foMUhIMhBYhz9dUJQkJJ2VEax8GxZkuXAF711tb7Ft2MSfTk61dWfEea1hENvECYrcDQCqX4slmAclQIkTyoG1xIDkV9EJAo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887283; c=relaxed/simple;
	bh=CUUtLbg/V9NQg+AuWoIWQTSD1MxC1DHpXmOuggSU0+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmvudnCquMvQoI7dTzyIIG3rBmRhyEs2/2P+ZTc8TvZO6I+oxCENL0Bu+wLxyZNaQqHtx3tIMbVyIdsfTGpbOJbX0WCOosBns2oCIxYH1srd3YPlUSXMuG5R/r0HVXTsKb4wp1aJUNWd/7pcEjXIp9xxiQuh0lw1Bsp9O5BGBqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uMJe0cX6; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1ABBF3FA50
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739887280;
	bh=9baZ8MtjuJOAuAOdwVfX6siiAQJttTW47fGC4JGW+8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=uMJe0cX6dg/8O7cep566C+h1tK6jlGR6+9waeuXGsv5zgBp1m5Cge4AD6DwZJe4Mr
	 coSDhmitStjYR2yalvovjfduV715JzVN9WO04qv63f9UJdFzXquLBIXAMmxJHHtmJA
	 GhU/qiI6cxNwOrlV8a87/6LBJTFHPDbbJ0R5HIO2fgMtDq7m/sfGyK6fDBBoIS6VkI
	 2vUzMz1D1d9WSNYN8Fw76eof5AXksiLU3DhqLXPeeev/9UaAgTbiTb/V9SrAaZKa4n
	 ZxRaxv8p7wIdVivzQuL1FxDGvY6ODQuHeeG3jBFunSPIFUqm/qmmckDY7P7UjVasxD
	 UFxwgD4Y+fVxw==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f55ccb04bso265540f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887280; x=1740492080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9baZ8MtjuJOAuAOdwVfX6siiAQJttTW47fGC4JGW+8U=;
        b=N1fU144AMZNIOlGOuot2E0dgmd3c5sL+v4GgM/rdh9jrt2zX6wtihOmNU5+gXxUasp
         mPPmIRU2VQKuXo1JhGe/Zyq6+5bvM9iI7RIPIusZCdce7mKm/Ivm8G0Bu31XC+3ev0EW
         mGZx1r2DJugknVMMV27oB6713rcCHKl+0KQTJ+Ovr7S6kGybuqBbyj1xs4mvUzp6j2RT
         C2/gKy9DOH+l+9bqTLXqEleNJ1RWj+R2YpXQpyaKRlr4YcwxqAYsPaxVda27dUjJkMjy
         XXRnW1Ba7QBhf+h2hrDuu0sIztneh5dJnWmoWMFpH8GwYZpYRBwp4MX5PEEfus4H3Izv
         LPww==
X-Forwarded-Encrypted: i=1; AJvYcCUaOaE1DSXoFG7rOk50qXRlNUCRY3Gb4Lgr/Q+XDnlr5wOQxppqzE3/OQn5QbNSi2WsaeQ1bEucXgrGr4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9jM8Bx89ZVYQECiTpYopCRx4/4n1zK1ndwE7DDYvl7nM9K3p
	RBW6bsRXGKpEAwKDmqBy1AxxDSBA40Crq2S12KrjB2kWpOGCai/mQ9mrX8Iyrc0ieeMNtRDjX8H
	1ImpMBGIKCfNqWqIVCmnFqk+yGJqdW6LwaL7YX49L5Cv0WruAnBLP22jIgP47STsmwWlPBjw66M
	M2C6KAzKUP386I
X-Gm-Gg: ASbGncswEJ+xQeFyI4LAOhManaqLxL+ysCMPRkRgYuRMEcEKEe9sBN2dF1qZy5Ldn0Z
	Oh53C2KkL6J7HjzpFYx34qKJtFck3QwTTyc6O2GDp9teOhlY79rgSzPZ7vPCW0lvvAVwGKjxUQz
	iRQHK8wJCQJvMYLdwu08BUmho8puX9uRG8ohzRdJxfRF1bX5fN/awmNhNCcyQxkDS12/JZn8sQ5
	h4cZJhZI9/FbaB0I2UwN82TPIHTUzVxuzbSNOWaa6vaMiynB6Q80QhVkuchhiTJUhTXxCsM7iR4
	gCOmoMKpzQFJG+dZnym1v6v+pJpAc08UG5FzpgoxBQ0jfOfzon8=
X-Received: by 2002:a5d:5f82:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-38f33f14a34mr9766457f8f.4.1739887279389;
        Tue, 18 Feb 2025 06:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3bFoFj7AvC39E0Kp9bB9u3iWm4LdGhfLWfOqb0TEnl13m+51JdBvSgkS7pO5yYT484fKs6g==
X-Received: by 2002:a5d:5f82:0:b0:38f:2a32:abbb with SMTP id ffacd0b85a97d-38f33f14a34mr9766394f8f.4.1739887278805;
        Tue, 18 Feb 2025 06:01:18 -0800 (PST)
Received: from [192.168.80.20] (51.169.30.93.rev.sfr.net. [93.30.169.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd51sm15105057f8f.29.2025.02.18.06.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 06:01:18 -0800 (PST)
Message-ID: <4cac90c2-e414-4ebb-ae62-2a4589d9dc6e@canonical.com>
Date: Tue, 18 Feb 2025 15:01:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/1 RESEND] block: fix conversion of GPT partition name to
 7-bit
To: Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc: daniel.bungert@canonical.com, Olivier Gayot <olivier.gayot@canonical.com>
References: <54095d2f-daea-4e4a-9542-f6a2b7603672@canonical.com>
Content-Language: en-US
From: Olivier Gayot <olivier.gayot@canonical.com>
In-Reply-To: <54095d2f-daea-4e4a-9542-f6a2b7603672@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The utf16_le_to_7bit function claims to, naively, convert a UTF-16
string to a 7-bit ASCII string. By naively, we mean that it:
 * drops the first byte of every character in the original UTF-16 string
 * checks if all characters are printable, and otherwise replaces them
   by exclamation mark "!".

This means that theoretically, all characters outside the 7-bit ASCII
range should be replaced by another character. Examples:

 * lower-case alpha (ɒ) 0x0252 becomes 0x52 (R)
 * ligature OE (œ) 0x0153 becomes 0x53 (S)
 * hangul letter pieup (ㅂ) 0x3142 becomes 0x42 (B)
 * upper-case gamma (Ɣ) 0x0194 becomes 0x94 (not printable) so gets
   replaced by "!"

The result of this conversion for the GPT partition name is passed to
user-space as PARTNAME via udev, which is confusing and feels questionable.

However, there is a flaw in the conversion function itself. By dropping
one byte of each character and using isprint() to check if the remaining
byte corresponds to a printable character, we do not actually guarantee
that the resulting character is 7-bit ASCII.

This happens because we pass 8-bit characters to isprint(), which
in the kernel returns 1 for many values > 0x7f - as defined in ctype.c.

This results in many values which should be replaced by "!" to be kept
as-is, despite not being valid 7-bit ASCII. Examples:

 * e with acute accent (é) 0x00E9 becomes 0xE9 - kept as-is because
   isprint(0xE9) returns 1.
 * euro sign (€) 0x20AC becomes 0xAC - kept as-is because isprint(0xAC)
   returns 1.

Fixed by using a mask of 7 bits instead of 8 bits before calling
isprint.

Signed-off-by: Olivier Gayot <olivier.gayot@canonical.com>
---
 V1 -> V2: No change - resubmitted with subsystem maintainers in CC

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';



