Return-Path: <linux-kernel+bounces-563022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBEDA635CD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146A116F840
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6C1A7262;
	Sun, 16 Mar 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aamLgAjm"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12561DFF8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742132138; cv=none; b=S2wwCHhlHqzncsYQJmRivy/egdHd3/g4rFC4dzPKgslYmuxcASk6QVOvJRtUQvYuArewH2LQecb22jjFNh9Y3tggyXcdvAwFveCrhOmZftXzaeftsmgZrDAcAEQmDTNwf7Kxh0fgroCpHU3pdH221VsceSN6kC0s6njbThFq/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742132138; c=relaxed/simple;
	bh=31vaCkzxFKpXaKqVCWHKndXUehhr3FmC4nOBTNfRDnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ae0Lthpoklc0DuSOG9HufXsgkwnOKv2HgTpAgg1S5nZQYfiTx+18uHwk/rafTcMbjhU6lkaqrq7VzieMjFsW6ZbD/RDVTF85BrYSYGvDzGDQ+7RB2xaNsl+5qz1jG7uiElXyzeYAQ0nUG8tzjhbDujbhlKx0AikfsLxk9cTng9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aamLgAjm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf848528aso10634725e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742132135; x=1742736935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR3K3QRxvoR/txzOB+kRH6BWKwmQVPtG4GR2Nw6b388=;
        b=aamLgAjmQOf+afGR+WhJtzUI4cWNin+Naa6gGuXSRPvZqLD4ymf6ac52dPDXof+Sye
         0TmXpjVWw9vHmeCeclK1B84IyO+k5cbj5xE1z07kRv0YPOe3AScj4i+IUM5tF5i2pR/6
         lEv01AOXnLkAL/vnzas9sXLOomZ6TJbe6QQCnw20TdBVbDtRAPeqft1eeWZOq+Sp25Gs
         /vWtpKq9piP9boR9CtBZtJYcLbKtzxKugde/qkqgIFPTupwhc2RQkyko0Be7Ju8Lk+Ow
         VSH7+STmPvgkMDnd6yGDrflwpn1cyHr1zGPtueFSUyK9uIaj2drVqAYviuoPmJY8PSSX
         NOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742132135; x=1742736935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uR3K3QRxvoR/txzOB+kRH6BWKwmQVPtG4GR2Nw6b388=;
        b=pUvGzUvmIgnsWdyzpKfugX4KZpgaEY/m9jomuwJmTx3d+pkRcFk3y6uw4/XXqKVe1O
         xSG/qvZzypMdH+f6jU4X97g5bn0cRi8OcfEmfz4LgzzqZktjWvIbQzWTuXlLfMQfT6m3
         7/7moAwsW/Yu293rxhFEV8+JlvRTPk5aYLcvhhXnc8MLRRb/vhK6fB/fJcat9NsZOkdq
         VfBkZSiZSBPuSeP7MwEQxd/cnRAxhkZ8/RqKIusDbBufwe1glzqbaZ6spgINRHWGvJB9
         8MVakfAZW2O8BAtbmzVrmbrYhsjTxR2+nKQCWWjPIIl0Bq4w+3WhI/Bd8HIDGw0bIOaU
         VzJg==
X-Gm-Message-State: AOJu0YzRGAjxN/6wTiFQVG5ESKH9YYC50lqg8WRfUsgJVLcweHfsWUqW
	O/8Wd5OKiRkbzCui54QkJZEFeRR60hB7hMFiC3YF6FFFosReLL/U7ZuAgg==
X-Gm-Gg: ASbGncvR9tjpLWPkZms9z76DQ4pADTighq5+1ARVMcxmNr4FycSkil0KQcI1jKzIQOo
	w4QfnkNH1Sykpn6BbvMWMksxVo/olDJQ/w8p0OmB6XmsVvcHYrPjCO8EYYPmlMLd3d0/z7cg8V1
	X6WStFam660OUfRq1isEC5vTincV21gP0A8QFN5F4cG9hIf+Z6y6UoDav63ByPD2sf5UDc5Gu7L
	siiQT2UnIKGHufq1HHVtd2wlTAOVSFQ5A3FC1xDEnVoUbEZ6YQBI9kujtEtky6q9oFzdZT+1pov
	wVAnriH6TPYhiPXN89LFnYtqvyGJMe3vm3N1yACnsO5muO3gLzTExW1/r/kQt2QBGkqHMRYF03s
	oLdFeSfNyPV04lhAUeg==
X-Google-Smtp-Source: AGHT+IGMQVLObTkBi5zYUMHxz5L9gNrirZ5kLHpsagVT0Kb0ZzuvCEzkOp0gaLrWL+A4ropNkckDeQ==
X-Received: by 2002:a05:600c:1d1a:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d1ec8c494mr117269615e9.14.1742132134935;
        Sun, 16 Mar 2025 06:35:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e92sm12233091f8f.38.2025.03.16.06.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 06:35:34 -0700 (PDT)
Date: Sun, 16 Mar 2025 13:35:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] random: get_random_u64_below()
Message-ID: <20250316133533.1050a88b@pumpkin>
In-Reply-To: <2ekh7esfcxnqdnjxufybel5kkpazjvwadwnb7zok5ske4vmptr@573764kocoga>
References: <20250313163810.60564-1-kent.overstreet@linux.dev>
	<20250315135234.65423e07@pumpkin>
	<olt5s7scbosagj4fpq25xun4kdvi6puwqdocgsvhpzguvpt7jt@dyy37p4uturh>
	<20250315205532.6815f2c5@pumpkin>
	<2ekh7esfcxnqdnjxufybel5kkpazjvwadwnb7zok5ske4vmptr@573764kocoga>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Mar 2025 17:32:38 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Sat, Mar 15, 2025 at 08:55:32PM +0000, David Laight wrote:
> ...
> > Oh I guess you haven't actually tested the version you submitted.
> > Time to play 'spot the silly error'.  
> 
> Please do share what you think you've found.

+static inline u64 get_random_u64_below(u32 ceil)

	David

