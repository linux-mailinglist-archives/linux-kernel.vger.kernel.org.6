Return-Path: <linux-kernel+bounces-539743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A8A4A80C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D545177E1E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C961B3934;
	Sat,  1 Mar 2025 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gmILZOoT"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C5119D067
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740795822; cv=none; b=qKeGTVor68WChYSRCHbLVT3NN6sxli6Vwe9YqaKmLCGa91Hkv3iP+C7Sa4TMaU2fzcExWDWphbk8Dnb+RM2wvYepjxOTtmxS8F3DJKeXiF/mPWUCCIb9JEQh3YehMfgCW3CKitivqAjeUvaj5IxUkEtgGOaCtqUzqcOWxnG2wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740795822; c=relaxed/simple;
	bh=wVE3hUnWuhQz2TZNW6Kw7SOk7Du1RwworYOIP4YiWqg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u5XpsQCgRQQmUenMWLey/Qb8NzrAiXHLXM8UgYPgHFUSv7gcZetRbnUHUVIoT6F00fOHJ9a1zZs9qTcDZTc589kWPAbr17PAaSdpyfPjAYzkmtZOs8BnKcTDPDR2BwFxXXiIP9IyEtKcjUoxQJGKPq7GmfmR3rbqVyfKI5kJgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gmILZOoT; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fb6c36ba25so24517527b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740795819; x=1741400619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BYnKVvuBP350pfI3rfuD1LPU9jxdWbLk68p0lijo6I=;
        b=gmILZOoTpRtmShyTvk+grE5T42XxGnsZIVfuRYCw/AcIDwen6/lqbuznAAYUTf6T5p
         2kn9xmz+N8nzZ8C/vD7j4lMLLeyc+PSlPie0QXjewFQtY+TrDZwQ9XtfVuqRu0Bo5cvF
         +vVFwfSFZ40VozaXznFoIBwPFdYjNbw4bCYwMEU/xlllLoRLsuvGv45MKaUEt9xUsucK
         F3wkE9MWixESTeaCuI7BiJWB8JxAKFMeaoDLDPRzxsCPKCZH8aw7eFyacTfqL7NIlJ2r
         8isciDHk6FHQhxKFQM+ShoqFipatMiOQNrLwzIQJerIzDR0oEL6Zr6t7YBQ+mAAbF3wq
         VxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740795819; x=1741400619;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BYnKVvuBP350pfI3rfuD1LPU9jxdWbLk68p0lijo6I=;
        b=PQL1saJ6+VqyO2bjgRlQosyi6Hoss48aST32az4y4ACJaLjq31wuPq/9IfCwNgstct
         pMN9id54CBnad/FCxZWQaVNyXqNXV2sMiu7bBP8FGWIm0ZZrykFQFnQyUGhW/Etywg1C
         mtPQSPYRMvAqKIfj4vWloKDss8Md/wsHpApfTITu7HOWre0J4DegfCt1mKZZCipM2YIq
         n9xsa2EqdgpazKOpqlcMjGsD5YR7skRFmaBLN/gafdZRB+VzHHI9j6oNwjJAiLS4ij/c
         j9Z+JdvPiNZiZdNE+1ZW2tB8t6/gZH43xa+TIVHKYuJbw0BdjQgM7wLbLgrpqamAp8CD
         E/YA==
X-Forwarded-Encrypted: i=1; AJvYcCWVHDzNjhSbjn6vTfX9dA2b0w4M0v1NZYqumu9P2JWdct8mhJsIeFVwAfFLGLOyw/8sZx2tT89ADb/Rc68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+fB/hFVV1l3G7gFLuBBbrWA5RhGD9FVZQHtWkhxzxZ7yEL/2
	NsfiSUPSbRTU/6lyBnqFOSz3OXebSVwj93FmcE8a6pQSdaudrQNaXQxHqXwje0M=
X-Gm-Gg: ASbGncssFXWJXzLExOYnljrS5ouQND+L7rL0cDPv30PmmyT6WG2diBWtezkojMixq0k
	d79VekMFgXo8JTtsThMbTebBsKyAPlxsgmAr7AFBInxypas1vdSCwVDsk6/QKNx5vJsOr3qOYv/
	dxybbCyOgl5w8xEW/zsZZqSYF9ayDJGFqje7EhPlOd9p7suP8ohZdqTAvGY00edbTAO9W6A8CU/
	UlwokvPol8+HWuf06UXnSchBRJKE63Q9xz1PHCVm5tEV7SZXVkWqpj/wdJZNshVhWPuV9//wUTm
	GnJAnXMT6pDrO+9XqKXJG0TbMtynSxKqovUkidg=
X-Google-Smtp-Source: AGHT+IG8nJeuHpJEDq1rCORo+ZTYleaO8aWCSHzkaErOv09hrsKrAoI+I7MVjGLe51Rem2KHG+9HzQ==
X-Received: by 2002:a05:690c:23c6:b0:6fd:33a1:f4b with SMTP id 00721157ae682-6fd39470133mr140297157b3.4.1740795819632;
        Fri, 28 Feb 2025 18:23:39 -0800 (PST)
Received: from [127.0.0.1] ([207.222.175.10])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3cb7e02dsm10175307b3.84.2025.02.28.18.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 18:23:38 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228230305.630885-1-csander@purestorage.com>
References: <20250228230305.630885-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring: convert cmd_to_io_kiocb() macro to function
Message-Id: <174079581845.2596794.17760767410091854418.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 19:23:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 16:03:04 -0700, Caleb Sander Mateos wrote:
> The cmd_to_io_kiocb() macro applies a pointer cast to its input without
> parenthesizing it. Currently all inputs are variable names, so this has
> the intended effect. But since casts have relatively high precedence,
> the macro would apply the cast to the wrong value if the input was a
> pointer addition, for example.
> 
> Turn the macro into a static inline function to ensure the pointer cast
> is applied to the full input value.
> 
> [...]

Applied, thanks!

[1/1] io_uring: convert cmd_to_io_kiocb() macro to function
      commit: 09fdd35162c289f354326a55d552a8858f6e8072

Best regards,
-- 
Jens Axboe




