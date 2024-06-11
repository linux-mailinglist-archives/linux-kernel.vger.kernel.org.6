Return-Path: <linux-kernel+bounces-209876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC93903C28
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DD4284F71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A224617C22D;
	Tue, 11 Jun 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYwP88UM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A11E86F;
	Tue, 11 Jun 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110106; cv=none; b=Rxq3iZ6RvlFTWSoKypntHycuo/Ximk1nM0piP/FUPjXtIh54OZ5v3PpA0En/rad056H9jtjjay0h7k/k1HHDrZUKrMN582uEeGvDZPXDIAHYsER3tNeqda+t5nezI4aGi4M5BkiLMUgWvZ/SaqGxoTxHJ+rY55Ra2tRb/Olgssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110106; c=relaxed/simple;
	bh=B+F4jYtueaaFeYozuVyzY6N2Tp2CTNJFcO1Ip0Jlv6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnhpypMpBSK+f/a6IVs90Vaq0HgJTQBbeCGc4ispTpHY6iZQ489WmmHUArddaQHh1fom2+S09RsTeEGaDRlWC4xmrdNEuB1HPbxXBD9N+6kjwi69b2EEAI6NBV0c6JJl85UkbFuGxfkkGTwNUZVfP9+GiGhZ1eNhlIS/21/cwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYwP88UM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso1238765a12.3;
        Tue, 11 Jun 2024 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718110103; x=1718714903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/Oo7XjX+5E7PNpg5M8THdexoQgRehQoIPwH+7NOY6E=;
        b=eYwP88UM7W2dmme+g95CUTfjKMTaMaAIYMaj/3JvoF2zDydjCXFxxhp4X1mXgSsrQH
         rjW9+Gz+LbFGpJgJOeNbtKmOdsLldx5azUgNIzm2tVNPNzBkF150nbzekjdPma13vq/m
         cca9p2XacKRngWaG2QXiKSZD9KCgriN23NU60vUQyAyv1L7l6QVtQYsV0U6pg4cVEPIE
         YsTtcUVy5v3JFCA4i2zT6w2Fm/bh/ofRgnl55TLMy2ZCd5D8gap51ttpN7f3uyB5gDoO
         NcXjwFOsjU7phxPnYDQxx4EsEKO69mchzTwlJu+GwvsmrXzz5YADkBpEedZby4nqYxTA
         HcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718110103; x=1718714903;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/Oo7XjX+5E7PNpg5M8THdexoQgRehQoIPwH+7NOY6E=;
        b=iWZB7KcPgccV86QKJUYHGBE+fB/0XZ97lJP6Z+ppwpNgStD/W9DdhiU24qEDoSnS7G
         N+QYz/kxSw/2Bduq7VdLb1aLlLKydAQGdcnBUbs4N5NOrMwse+3b5xxjUxorKOcE3Y83
         Mov2aSSij7Xf2deO6PNG6gTOjrS2X9io6QM6cKllKmM9sJYHEV+3p/FiKXMj7gPLFQfa
         +0Mhsd9UJbRickMHz/hzOcWLNioQlqbn3g7iDlkhoHECxH6H3ZxoCSa/z/khuztGgqmk
         lO02gpTFvB62qPLYD4Ml/zVd6f/SCeFSTlB4UDF+BGSkfnojdPFML1dPHL1bgEIymmIw
         G+cA==
X-Forwarded-Encrypted: i=1; AJvYcCUOqYvOEigr7opsn3UTICAsdv7mj/tbJ3zgsA3rJXDDMzWoN5yHrP7I+t9qG3qv8jt0AtNqzo2HNke3LIxnkCpnVXU79ce4ItJAm9Mv6DWD0vurLlQzMSlux5nQEcSE0LMe1x72FJ7yHH9V7yN8Vz5ydgqogCZan6wL9q5//W46ZayvI8icGd9dqls=
X-Gm-Message-State: AOJu0YyfkAVw/w0WwinpN8y45qMfju747fEsgNo1ZZYiTqW+MMpWKZxJ
	QtUuHGRQ4tMEYaD+o0toK3ispf1iz+mgFBlbmGsTGeznbAtex01SwrauwEZF
X-Google-Smtp-Source: AGHT+IFp/1CR06HJRye+2fqk8C5zPASOQlbfXCIrIAIwmwTUWtI0C1ufR5WmUqLrkAfxRNHE9HGb6Q==
X-Received: by 2002:a50:9509:0:b0:57a:339f:1b2d with SMTP id 4fb4d7f45d1cf-57c5086e237mr8319342a12.5.1718110102611;
        Tue, 11 Jun 2024 05:48:22 -0700 (PDT)
Received: from [192.168.61.55] ([37.30.4.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c71b6dcaesm5635493a12.78.2024.06.11.05.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 05:48:22 -0700 (PDT)
Message-ID: <771bf8d4-5423-4972-ba27-615148a54c77@gmail.com>
Date: Tue, 11 Jun 2024 14:48:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: samsung: midas_wm1811: Fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <01590109-cf27-404b-88ff-b42bb73ca1c6@moroto.mountain>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <01590109-cf27-404b-88ff-b42bb73ca1c6@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8.06.2024 16:24, Dan Carpenter wrote:
> This accidentally returns success instead of -EINVAL.
> 
> Fixes: c91d0c2e198d ("ASoC: samsung: midas_wm1811: Add GPIO-based headset jack detection")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Good catch, thanks!

Acked-by: Artur Weber <aweber.kernel@gmail.com>

