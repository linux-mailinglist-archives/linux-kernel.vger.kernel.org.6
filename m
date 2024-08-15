Return-Path: <linux-kernel+bounces-288242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE39537D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A041D1C226C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24161B1437;
	Thu, 15 Aug 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZIB6qPwR"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E543AAE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737659; cv=none; b=nrhA97nsYqNjRtXFwr2YhKt3bUuHhD8YDMt+sFqpZJtMNjyr/Fqx30+eClp1PDMa0qQ2oaggp455Ksy9TwnYjPoIZGmJw6axJiPBXji4djO/KprtERJuUw6QpaTsDYI7kdgosQkuNK/vf/tygH0j0ZuqWSIi26+JE52zcVjju3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737659; c=relaxed/simple;
	bh=8EmgGrQTiAThFUecEEjj/YeR2I3mqpRC/ExlP7Mbp8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsdQBzjwFQ8MQM4K8ucg5ulePWecil0jBHIi0+uk1hWUXLlO/xw4WO1nde8H7yJmbmgRXIkahOQPL/irEhNxbfDpZk5yNcER0bTJllvzrSlecdrlyQtZ3CWbCg21Guu1C+4WfxE0C3Z4qB/kKFDxIBMuEBa9LHaLiJW3JQY6WsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZIB6qPwR; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f8ac6b908so2176939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723737656; x=1724342456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvY52rn3VLdN7FSBDk7M0Q/xyXbEHYPcDeYIz1HEN8U=;
        b=ZIB6qPwRpqE5R1sOeKpkgt/kx+fb4VkH6RBlekOE207dVb2SivpPOn1Z7FY+xTda0O
         aWP5oEh5/m563ppxAKSQzoeXC8h0P0+k+5LMuOr5RK4GEgLK+b6wUCkQZOZUtHE4sfJz
         G+NZNhCqRIv88Ah7rQt2eabsLTfg5UDmX+0YFcOVsoTuLJlmsh752vcwpHwCqRVdZVAH
         UecYR9cz9BP/hNdDMxdHlLe1RU/KH+pmxEudC/hIMyftKpHA343WWMWbJZ03e7A0v9fm
         M7RzOjGqEAXRV+4a9zdpNyWyN4ICptusqYk4G4NaRLJ4QYtl4Qghxfto9tIPzqsXkJXH
         x3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737656; x=1724342456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvY52rn3VLdN7FSBDk7M0Q/xyXbEHYPcDeYIz1HEN8U=;
        b=JH6sbEeEaLxmMpu7nL3hv7Aynmkw2zCv1NIrt1vY0o3CCPQdALAh+Xna/lhmg51w8M
         8Pxs1pOiPpsBwIXU/9HMXB47uvoQ9NnN/M4Ao6h64kjRIL9+hdiCw+wlnYvXvVU2tHnj
         FDBOsHujIwx2mF2Ywae3wo2Ic1JcZF4XpIun98FvJM0JVeyIFkFYSDiQi+iNPrk2ExGb
         03v8uAyRGD736WtQf4zPv4mUNtMD5Ty7sXTmELnTfAl7naSDayvTGNmWwHmD7Dgr5vXh
         550AMvcGQBs2mX54awgPKkCMaD5FjEdhDc0AUSSkDTwfrqtxhgjkThfHsUywfYvHR4mb
         pYTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhpOPcPsfHdhRtTA3GFzuARVuADUCG11T26xtPrsuIv9rJoLUo0oIuXGyfIUfynP2iUKcz6IWniS2R8CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiVmuEhEcWnjWcupm90OGg5+AJzl+3IBb42BPkmAtDtv5BFTi
	gesK4ub6txzVoDlwCZoWR0BVgOr9CIoVRjAo1y1zOP456AXgmIz/eOlj3NGjnI8=
X-Google-Smtp-Source: AGHT+IHVdJLpv3Jd1d39Hh3l6ibKrPATj6iR/ePmOqrUAeo+aVkAGUQ5weyaKqVzlglv7c5OP8ZOww==
X-Received: by 2002:a5d:91c9:0:b0:822:3c35:5fc0 with SMTP id ca18e2360f4ac-824f2721fa8mr14417139f.3.1723737655813;
        Thu, 15 Aug 2024 09:00:55 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f3db32sm566067173.116.2024.08.15.09.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 09:00:55 -0700 (PDT)
Message-ID: <622e155f-2ad0-4f62-a6a7-c9c88903db82@kernel.dk>
Date: Thu, 15 Aug 2024 10:00:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: fix erranous use of lock class key in rust
 block device bindings
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Andreas Hindborg <nmi@metaspace.dk>,
 Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>,
 linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240815074519.2684107-1-nmi@metaspace.dk>
 <172373175849.6989.2668092199011403509.b4-ty@kernel.dk>
 <CANiq72kFXihVGDGmRyuc0LkODYOv2jX3shP-dEHjV3k1sqFEKg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANiq72kFXihVGDGmRyuc0LkODYOv2jX3shP-dEHjV3k1sqFEKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 9:31 AM, Miguel Ojeda wrote:
> Hi Jens,
> 
> On Thu, Aug 15, 2024 at 4:22?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Applied, thanks!
>>
>> [2/2] rust: block: fix wrong usage of lockdep API
>>       commit: d28b514ea3ae15274a4d70422ecc873bf6258e77
> 
> If you picked 2/2 only, it requires the former as far as I understand.

Sorry I missed that, mostly because they were split into two separate
postings. Hence it only pulled one.

> If you want to pick both:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Otherwise, I am happy to take them too.

Go ahead and take them, I'll just kill the one I have. Thanks!

-- 
Jens Axboe


