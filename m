Return-Path: <linux-kernel+bounces-517624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C61EA38351
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8ED16F9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235821B91D;
	Mon, 17 Feb 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pvfESW+j"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF321771F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796372; cv=none; b=YSiV7KPZ1kTkkcF6bsjuKoRriEIOx3WNXpVdNMOC1mUdGtjeHwpBsetmJoSt60R1x9VfSMYqVsUSl0FiNzKncugoDzZ7iRxRLEmca1kkPb9YQup9P61U/KpRpEQUoQ+lBW8kYpQXdB13O1D5q+rdaTARt5/rsn7re5D0WS9503Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796372; c=relaxed/simple;
	bh=OKyVddpfzq6J5MZuiHsnrNWTLGHm9r5FfbDv9UjwuDU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LdHp30uD1zoFF7YBz/EBC/8OzPvpRfKCTi4apI8SSGTAWX/NKaNbPS2jSFQQxSepe5iNDtZZsVxi8wxkoblodJA/4luhwQ6FALD/AWJNh0iwzNRcAHWu4mxfAGprngnX35EWLHX/nwLicgyfu9/WrPeY+sM64mKB/tYExOiSTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pvfESW+j; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d18bf1c8faso10904415ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739796369; x=1740401169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y63/9QE/uFB5mV8manNhYs6WWs7kN5JgLdRnQ9vVGgU=;
        b=pvfESW+jSnr9Xs5HqcjPEi0NIBDh49Xvt/Zp++aT42GFP6Az0OIGxPCisqfEJW3F3d
         Dydn5UNxS9l/wyZfqqq23n/N8v9sNUaD1aZJx2NANGKZFmRO94WrCl1HkPL6ujDpt2Mm
         4tU6s3nh+0CSC/0o8dRoU1hbFnIYhQ/aS1hdfcOrjKHyv7LAdwhddCD7j5ZE9APxIybj
         PK8cc+gv7kHrRodrofQspvAXlBz7U6ngNpb5RTbMPLMxwn2CnomnAxJhxWZosAehaOEy
         THojlQmpuuk1dZdxHnr1o0FAapVShra1WuSdEijRgnNal4hMBvSVYanEz6K9qQAocr+Q
         tD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796369; x=1740401169;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y63/9QE/uFB5mV8manNhYs6WWs7kN5JgLdRnQ9vVGgU=;
        b=TQuN2OksR8HafBJmtJd/WjJDSLaDCUx9t4WDYDeMrjbpYtYbuUFFZAt4SQNzSz7jkV
         UC/0C2QX9vKu2k5QcfdjoJRLvu0dQRiucr/tjZF2cJgkgNV7WGYBTrN2cHx8LURbUV06
         X4fvBF2q/kgdoLof3Nn9kV6oCwnHleRZPqQ/voT6t/TNVbGR/AyiLh9VozLARfEt9naP
         NFSwwEcWxNJjL5MhQIyWzdnS/r6gnJDezLyukZE2E01AdyE93C9NZk2fmCWq19nL5dmj
         aqsMJLwzdLcjwynCgcxNmYjPHj/2/WcJ0SlO9QwNXNWc4EiXuSxB1qxNbYQTw+9sx7rM
         pwng==
X-Forwarded-Encrypted: i=1; AJvYcCUScdvo9PRjgev74grdgSbljEJSFHr60Z8dNG8flZyGmBv9hJ3NXkS9NZWflad+zIIY0foj/qtelO/MNqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYzG+VWRQtu0A9qVSnHuWaRMmw9HZcMCFwrgE2pTzPhxKyUop
	QJwox39YIxzg6uZhLAxQsfjwtAWreO9YH2i8lz1XLcDchPu7Z0FsbTS2abV/16k=
X-Gm-Gg: ASbGncssVdIR2jlB/63sSe8dfhSIl3s8SctvcC0f96jD//T7RxxtUjDaeN7vshC/3C0
	GXyyqVO0SUcq/nNimI66yBp1FQdrILsyUBWBmC8oxm5DifcEQsgSUmgyhLifTuxATSBI7oy5VSh
	0yfx29oSgAdvwUSJoI1ajnEH+2Iw2g6eeqYr+kfc93ThaVfnYCXUpMkbqpPEN2gNSGkAxgfkj8j
	jmJ/Zu8lJy8ec8MEwuAyyT1vvaso8sp5hID2VxTVi2N6a7LxwAU1PnWG4r90ygLEH81KN+pkqER
	aUa1270=
X-Google-Smtp-Source: AGHT+IGEDg7u3KsXfy/iTIcoq5+KTCNmFv9bFZ1Lj3LHC6ibcTWOosE8CCxUMPtVbeSoXZYlgZ2IGA==
X-Received: by 2002:a05:6e02:3042:b0:3cf:bc71:94ee with SMTP id e9e14a558f8ab-3d2809df962mr77765605ab.14.1739796369401;
        Mon, 17 Feb 2025 04:46:09 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee81857773sm1247159173.66.2025.02.17.04.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:46:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217022511.1150145-1-csander@purestorage.com>
References: <20250217022511.1150145-1-csander@purestorage.com>
Subject: Re: [PATCH v2 1/2] io_uring: introduce type alias for io_tw_state
Message-Id: <173979636811.644986.8851861360440313307.b4-ty@kernel.dk>
Date: Mon, 17 Feb 2025 05:46:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Sun, 16 Feb 2025 19:25:04 -0700, Caleb Sander Mateos wrote:
> In preparation for changing how io_tw_state is passed, introduce a type
> alias io_tw_token_t for struct io_tw_state *. This allows for changing
> the representation in one place, without having to update the many
> functions that just forward their struct io_tw_state * argument.
> 
> Also add a comment to struct io_tw_state to explain its purpose.
> 
> [...]

Applied, thanks!

[1/2] io_uring: introduce type alias for io_tw_state
      commit: bcf8a0293a019bb0c4aebafdebe9a1e7a923249a
[2/2] io_uring: pass struct io_tw_state by value
      commit: 94a4274bb6ebc5b4293559304d0f00928de0d8c0

Best regards,
-- 
Jens Axboe




