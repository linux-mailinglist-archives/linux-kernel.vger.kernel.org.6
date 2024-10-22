Return-Path: <linux-kernel+bounces-377063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C78F9AB96B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7C5281782
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FB1CDA27;
	Tue, 22 Oct 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SavHLhxi"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3B1A2547
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635818; cv=none; b=twSFfP/sGqE2O22ikk9LfKKEz5FPgxHo9OGO1x+rKBhcShQn3s9yYCWFK4BWiApRQa/PV1OqHv3qrQGaS6I9ON8p+qjdcjri2HaQAPu3EuSp0SRhp4FtYH7K0IfDm6OoszxtWBpJ8Qnh4h4yj2RDoVF8qhtozOAgwi0iZXHqTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635818; c=relaxed/simple;
	bh=CHhdNx1DPtVhW6EV0JoW7AEwmi+u88cGX+7nUFlqziU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r85wyNdiz4nSFRu4tTUlQ0DNa2SZ3p8N1YaXNAwcsb12IegwF8g8+f0i0MYOjfl1ehfpkoN0pd+UsuSxnp9UFLthbw4jFxUBrq1pwIFZEXZPqQk8GNaSL6A2N8jxjn+B/AJ4RXLLsZI6iooTbYEQN2iL7vm8Vi87vZ+TZL+Huic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SavHLhxi; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b6b281d4so24776755ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729635814; x=1730240614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhA2wYt5X+6xbErUcsvMOcsB9pAsgLwkZvDUsTRyXLA=;
        b=SavHLhxi+I+FSH07xbsdwUxSKEJ8VMpoMBhcWWysdVN35198bnQFtHU9tOJyR9yptU
         5V9JceZyjk47fNKwZFIMfRLhh7UhowouQft/ghpdKvr+JOQpSdM0EFUqCS2YovUbVA+j
         HwgB1Eg/QaVOL78MsbEEy7NtBdFpn2il/hMyf0oS88KmXix/epS8Spx/JUIaPRHCVtTy
         HaT7a37YTaTMK2oBeI8ZdOw4JBkHMfh+d8zLJQAhdyHyH2PZe2YGdUNtM42FIGi2X354
         g3IpJ14SMcnniz8sagWEEcGYcJnq3R8+SUhIM4O7wpScUq8hRjwSa8XDmzecV4jXVYe9
         +PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635814; x=1730240614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JhA2wYt5X+6xbErUcsvMOcsB9pAsgLwkZvDUsTRyXLA=;
        b=AhxYSDT/Subcs9ZVOdGfiVPEZvbJ4+68ajrZIS3+uyvRSTtV9P7NOzm0TuQOcFHTVy
         +myLVorCBfN9yEh+RFeb/slzxvjXs7yT5Ux8xDL6bEcDoHbQCV6ed1YqxFpuneohTXOh
         51ghGEbjWNApgFwEYTXry+oUVh2p0OcS8EkgmvIckN7Of1cgCEmVL1M0/HAi5nGOMMwL
         cWQYGec58f5Yh9/I6Rg+kUcETBA1WqA9xHDxg6hWGGc5zLD0mQz+/jD/u/hPi+6qhhq7
         06G07KdHyZxCu4FGoYaaHZRbrJ/KgMBL/uOzlByRg8BM9iBXcXKi922zy8TRdq4zHZSU
         cl2A==
X-Forwarded-Encrypted: i=1; AJvYcCVvrH5Il8hqjQjBgXdcUjvjuv3zSFgo84KAhVr/H5xAsfrsrhxGhSw9XBbSfhdDCj1waYK+NdzqVhB5FLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37Z9ckigKjY7VZKi7IZh78rLoxtqfX5VEMsX50pxoauSqvQcs
	WD7tXP33xifWhiyItAn4t5fAAJ2uJNHdjV+fQI+7o6NN6h1C4mrDX8XW3un41QM=
X-Google-Smtp-Source: AGHT+IF1URWENUntDQK3IQF2oscOmySAOIRvWJ/fShmRQAFQvuvMoHolpboKlkjskSy5j8pf/ECWAg==
X-Received: by 2002:a05:6e02:1c47:b0:3a0:979d:843 with SMTP id e9e14a558f8ab-3a4d59709abmr7583465ab.9.1729635814300;
        Tue, 22 Oct 2024 15:23:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4cd6b6a32sm6761825ab.70.2024.10.22.15.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 15:23:33 -0700 (PDT)
Message-ID: <de7ff578-193f-49fd-8871-d998bb0fa149@kernel.dk>
Date: Tue, 22 Oct 2024 16:23:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: rust: fix formatting for
 kernel::block::mq::Request
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: Francesco Zardi <frazar00@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240903173027.16732-3-frazar00@gmail.com>
 <87cyk8mhlq.fsf@kernel.org>
 <CANiq72nYKH+UCQQ8mHTc1Z7Spinp9v9hrjLzVyWHXaoeSShQTw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANiq72nYKH+UCQQ8mHTc1Z7Spinp9v9hrjLzVyWHXaoeSShQTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/22/24 12:17 PM, Miguel Ojeda wrote:
> On Thu, Oct 10, 2024 at 11:29 AM Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>> Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>> Thanks for the patch!
> 
> Andreas/Jens: do you want me to pick this through `rust-next`?
> 
> Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")

Fine with me.

-- 
Jens Axboe


