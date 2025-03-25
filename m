Return-Path: <linux-kernel+bounces-575366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E023BA70181
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F306117C525
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5047261385;
	Tue, 25 Mar 2025 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ly9wMgH0"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180C2594BE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907048; cv=none; b=FHe0/tvykuFTjQQAhnK4XzYiaPNQqFFXFKQCYvi9JJ/RegkzK44kYqWP/S7ktZlPtY+LJ2/z9jOP2+IUDlcj/wuKOy8bDTdeQ69EK8Jx4GHm91Tw+5SJSbUdxOHW0C9hY2C4mcuJDENBoa0GhBxkrc4BT0ylKNJCKrcjrWLprUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907048; c=relaxed/simple;
	bh=fRi6zeg6T5KPv8WzZ4XrsVxzdIG8PsIqcDMVZVuZ3yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qf9F3oxSKq09l7gKbEnEhE66nvTIobNxigPC6N4zFY7uApmjOgnMx41d0joGdhEhouGpeN4bj/CLKlu3/BSi+rYdIz8iWo/Lh0jdLkfRC7sDXKETdpHbnxBAIz9cxvyQAKVH5aezyjwIO6AgOj6oDhrDQpSZSh94qmRr9NDM3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ly9wMgH0; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6ecf0e07954so34854086d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742907045; x=1743511845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86XTbjdHZToTO9vFgFMOUGoOt+ekVajyxhh4sxGzdh0=;
        b=Ly9wMgH0r12gWqhtoLNAzVFDpE+A9YcjarPtEwYA4cowDL+LJIdiIFXiuEc7Cg6pe7
         N8emrmLy1dnhvMa+KWgG92/dojfPZmj0B6Pr7RrG8iKeW3OmyttZLU50kUuyrKlKNjVm
         WGxGni3ayKUMBQs/5q7vkqLUtECzXDh+JsjA9sMbCVYFfK+ibFRRWCPQkD0ylsaFWBfL
         DDm697XL6NImQ15/lUu7S+6PcB67LhgpgK6XW0AIf/mrLC4bby9zpg5iY11aYLvt62nC
         wfGyt/2E/E6dO3e59qf8xGfH6qUhgJrXz0jfbKte/EX4Dd3lefsx0pAovF233EdviKDj
         gSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907045; x=1743511845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86XTbjdHZToTO9vFgFMOUGoOt+ekVajyxhh4sxGzdh0=;
        b=iBWnpkowCh7gfgmAUPO2kiWAb36H4i1G2wL+M2IIsRQrJNe3tQs3CA1qFOrcUpWY2T
         PWW5JpLkW8vO7VRBhbBpysLk1byM4KSurb1UaWA2nAxvps/YIktuP7I5NqGmxYelCUnw
         6ABqsvswTUu0yuLJndc0+rPIWqlq9CmLY0E07gjvPlyp5E/GaDSKFVpeaD2ty4ggdMSz
         kg8N2uOwVCevH5/h28We8FzDpSwLv9azZ8kidZoc7XA35fmMrlT0Ml+clrp0v/xTE6GP
         jXScmk5vBdJNCpMlPzczGi2qjrKehuoNGgZhXN/DcD0hT5fxQ1Q4aCt0JpeR8tGyrPLq
         2FEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLNK+I3v8NJjlFMiDHPAv0EHXfkbMxmgpmrLPDHlpQi5z29j9bMXdAO9CCFVbfMFd8enHb/BKgJqlcDhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx+OXO4my5V19RhDGFsBEmbxh5QsoakZhS6NajOqhMFRn4m3OL
	rFa5OPRkf0vN//N4Y3Fx849eWgXGoRuVjgRYSLX4bKGnoa51PcIgNk5PEYlxAbY=
X-Gm-Gg: ASbGncsV2pq8wvIeicoDi7WybEHePKd0UoMzG7Pznz5d+aK2hSjREAPkq727Iki96Qe
	hVImoGwIXv+t1MI/lEKVtbobQS1Xj+fieeid2sZ6ZUlZnDkm2sWgAXaqlWbK2Amd7wWu7NBb7wS
	B3aBoZOApHoKtAEN8sCsHd3cybpkXz35zAmDyWvUcP0LocGWvxGRQIQCD0c0tlE5EPIQVGIzf2t
	zCgnvZ1ZzYk8yneXkwB7WazytsQNnm+oJwg4ssVhGMmOqTYoSsWaftDjgVnJoIy+xiNr5VyeJ5o
	QvSc/SymAfW4axRgjhjnAoW2l01qVA4tEBiyWhPkkg==
X-Google-Smtp-Source: AGHT+IGuLsKAsZriQ88efYyaOks4mTlTOIy6vgScpsPY432E17wHEpRLiv45zRl6y2rkbK9/IlgDcw==
X-Received: by 2002:a05:6214:212a:b0:6ea:d40e:2bc5 with SMTP id 6a1803df08f44-6eb3f2bb5fcmr272837256d6.9.1742907044676;
        Tue, 25 Mar 2025 05:50:44 -0700 (PDT)
Received: from [172.22.32.183] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef317fdsm55908016d6.62.2025.03.25.05.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:50:43 -0700 (PDT)
Message-ID: <80ac818e-33e0-4b91-9207-74da182de025@kernel.dk>
Date: Tue, 25 Mar 2025 06:50:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] nvme/ioctl: don't warn on vectorized uring_cmd
 with fixed buffer
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324200540.910962-1-csander@purestorage.com>
 <20250324200540.910962-2-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250324200540.910962-2-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/25 2:05 PM, Caleb Sander Mateos wrote:
> The vectorized io_uring NVMe passthru opcodes don't yet support fixed
> buffers. But since userspace can trigger this condition based on the
> io_uring SQE parameters, it shouldn't cause a kernel warning.

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


