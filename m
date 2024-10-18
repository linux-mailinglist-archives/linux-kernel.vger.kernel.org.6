Return-Path: <linux-kernel+bounces-370757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749089A31B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3242852C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD93FB0E;
	Fri, 18 Oct 2024 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OAI9xvIB"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632C3BB21
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729211610; cv=none; b=bCfiECrVHeQDOmgRADY6eUuWALAE9PPpFQ0gzZo6moq2AN1pdoHpD3eS8LgGv3TbT7uazwiOIgrFNXdaUGGOYcXA3i4Nz6HEdPzzyrBXMnxqMlsdol68jerYmTxrlD4jzSuI+IPwB1rue+qONJErtTx26yuq+euEV2Q4hk9PyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729211610; c=relaxed/simple;
	bh=UaubziqreVars5kwB1RL1MaoY9/7scLKYkD91X+UtoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxVIV+E2yUmxYATKjF1fyLUOG1dgx1WjuNoFHyovQ1LMjNJW++2PtixlqIC2snIXlMGTvOlI5TA7hkLateJMlCjS1hVAZfkvrVFYeCkGdUqQIPdR916CV9B2VouWk0Oo3rD89b5C/KHCC3P2zP9MmsEH7NJh7MUQ+gZNhrmVLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OAI9xvIB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-207115e3056so12276065ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729211607; x=1729816407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gOSInNa3wxtDkU63SvqNWcDXyiudmLKW+NQt7hVZSlQ=;
        b=OAI9xvIByZwxrgA3POlVoEPvFU1Nau9+9Jo82LDVryoG/rJici+kfqcKfLPGb1C0h0
         Eno5RML4bOUA++XGgvv1t0fW6Ate3fEmFiDG+VpFpDXg26j/UahPHytGkIMvD/to4+YO
         xGQ/oTuWdwDggv2UAS2s7QiGUql+fRLG6FUAmFQ0dNK2S/PjQKOr/IGkuh+1w6HbYSxD
         sP1AzqFTSVBSZJ9+qAMrmPm67py7FBn+O4YlJLqfQSg9TP/jmyoSVv5Adp5WfDGNmgvW
         5VrOy4MemEUqfaXF5Ceh/TJlLXWXN+Wgtew2firvzpuWxUG307MnzUc39kVRnrIxDC0N
         TiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729211607; x=1729816407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOSInNa3wxtDkU63SvqNWcDXyiudmLKW+NQt7hVZSlQ=;
        b=pkE+4zKzRVwhiDETRw5F0/LpyxOtOMwWMOHGPUT9dh0xd0vp13jWjha8KjICpfARxz
         t3moz6PDg+XVxQdQyXyTI+pHydASbhbei/me2nuTU5deHVCyfUr29q9WhppKCFxqwc1K
         9LQc3nppcxUturrkcNRmP2RqDfKIy+Fk63Wu4vDIQIIrLm37UonvFZbPHMfc6gbapQSs
         UwSq42qnMb02F91aHtGgn7sRM4CjjK8pZFJRPj9q77h2ZSCfMelBrK0FK+W54dnDeBkh
         /ozOyDU++llH36qiJn7gQe7IKgaZLEzxMI9YXKzxCbnBvfJub+ph3IWbB5DFwjE3okCf
         Odgw==
X-Gm-Message-State: AOJu0YyBLYM0g9nWkp9fHYZiJkWvrkuLT25FWqPr22jZXM+49pbPVVJT
	sDcZ7uFMC+fdsdxcQgGO2zXwr+9YmQUl+bi8UjRdHOYwTllc3gisgd/HYyvqgfw=
X-Google-Smtp-Source: AGHT+IHQI2307m9yUhp/rCogxM52iyd++1HMje6AZidsd/nNJsuPdapDFOS+aIPp7mGcC8TUigRvow==
X-Received: by 2002:a17:902:ec85:b0:20d:27fa:1911 with SMTP id d9443c01a7336-20e5a71aebdmr12236455ad.8.1729211606938;
        Thu, 17 Oct 2024 17:33:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8d6cd6sm2164585ad.131.2024.10.17.17.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 17:33:25 -0700 (PDT)
Message-ID: <dd1712dd-1485-417a-81cc-482d7dd26a11@kernel.dk>
Date: Thu, 17 Oct 2024 18:33:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdrom: Avoid barrier_nospec() in
 cdrom_ioctl_media_changed()
To: Josh Poimboeuf <jpoimboe@kernel.org>,
 Phillip Potter <phil@philpotter.co.uk>
Cc: linux-kernel@vger.kernel.org, Jordy Zomer <jordyzomer@google.com>
References: <1d86f4d9d8fba68e5ca64cdeac2451b95a8bf872.1729202937.git.jpoimboe@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1d86f4d9d8fba68e5ca64cdeac2451b95a8bf872.1729202937.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 4:09 PM, Josh Poimboeuf wrote:
> The barrier_nospec() after the array bounds check is overkill and
> painfully slow for arches which implement it.
> 
> Furthermore, most arches don't implement it, so they remain exposed to
> Spectre v1 (which can affect pretty much any CPU with branch
> prediction).
> 
> Instead, clamp the user pointer to a valid range so it's guaranteed to
> be a valid array index even when the bounds check mispredicts.

It's a cdrom, and media change detection to be more specific. I really
don't think anyone would care about performance here, it's not even
a hot path for a cdrom driver. That said, I don't disagree with
the change, just don't think it'll make one iota of difference
in the real world.

-- 
Jens Axboe


