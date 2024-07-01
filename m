Return-Path: <linux-kernel+bounces-235916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8429391DB3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D833B212D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206F84E18;
	Mon,  1 Jul 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UyVDiWYP"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B984DEB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825298; cv=none; b=FzfytGTD61RLRPC8hlMEllM17Q+jsRDsCMldExaJ5/lPTWULGTrv3Iava+kYYfOd9jjDteCOm2azHirTDaVDxSliSQkk5rHirQHrQ/KKF+wAzgXucCRQavBPAIdUg05gIfqAX++D3TUrrdRo/pcm+lAoB93f3eYIIEg+f2+oGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825298; c=relaxed/simple;
	bh=pKtmEUrQlTA0F2ac3541cFZOBFkYUhrUldNV8WVF0HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFLdnw9rrgdaF3TIGSdvoOGPsji2c4KsvnFs9R5opXt8WWOKjnI7RphWlB4Or6EBuN7n7+FVcyNhm6nq1TidIH5JBiMhmAZAeSIDlThf31aOwA5CSObkwEXJnfGXzPuSmcd6Ay3JSUTvqYzCiEco09mPegCi1yxDj5F4gUm9Wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UyVDiWYP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c8c6cc53c7so1840045a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 02:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719825296; x=1720430096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pKtmEUrQlTA0F2ac3541cFZOBFkYUhrUldNV8WVF0HY=;
        b=UyVDiWYP5lRZfZIxZUZo0RuRwZCZHJNCqOOjw41OGgOIKnQAUqKS5wZs3QcEqwPLq4
         YvMUyOCb+pkLMeDG+oHYgzph8wOqkBZn9+7shVwwURsmXqrciI3rX2pyBSwE9ev0zujO
         W8rW/L0gSYT+7us2WsmqLLQv2zl9XdoGTw789cep247FClxRdgRzfOn4TmBVoaP1PHGA
         FmCHyfjnSej4Gt7/udliLczxnUzeaW2UxmP8fVu4t5krs3c6ugHtQfMhb41hHKLyb8o0
         NNuU4wE9fXNXXamuSsXbsiw7IexY0dRehPQ+W6bKHnl9xJB8BmYu9xS7NzENDsAHC52B
         NW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825296; x=1720430096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKtmEUrQlTA0F2ac3541cFZOBFkYUhrUldNV8WVF0HY=;
        b=pwh5Jm6GG9pHRkHQMxh49dKuecTsM6FatnZK+Gz7YMhwgnm72Z3nSO+l8BLLZGaE+G
         ECun0hlgCGIDFdzXgJugYZ6F12mrEKYtVDFeAo72UgC372w8bHZ/gFhDhK77SlpEDRfl
         dwxlJvjTSOfVghfgD8qIueST5umAeonIgMjFqauSz1P3RZSVHXLjREin8dCJRr1ICzBP
         zOkJBz3ZPxDoHKczYy83+Rzrf9Ttd/Td+EP/ycNUY31hD2yCklD48tSiysN2oMmcZ9FJ
         wJgrRiQWdDZGpTUgYdzcTcB3P9hwsT9XigtH3w27fXGAauZy3T4a4GOPFbqfxzzadcvs
         9Tcg==
X-Forwarded-Encrypted: i=1; AJvYcCW+M/r6L8cLVIRUsAK8uGBYRvI0Ayt9a9rl8q1pcU0uu2m+wLyafUSX9Np6D+IZyrUspbNiK6bwj2EEwalMQAAPrpqqTVaHrGsGIH+u
X-Gm-Message-State: AOJu0YzA6PhDV6Xn+L8odCIMD/4MH79Om86KtbZmD5dJo9BiajJnhspR
	39Z2WzZzPSsAsrU392Zj4XoXlPLx0MwnPueu7GJj0+jxeZKVQsqwbqwd5CHLrvslRvPG4ZyONCS
	oy6f9IniKG98R1eMQL980+eJCVYjzG1OzQZlSQA==
X-Google-Smtp-Source: AGHT+IF9jQpQKcrxcoLFI513tP4pa+3WxK9vkzmTGRABCk37DfpNT9a0kMZr3OJoZGwOYrQPiOPna0U7ATKOrjtwlnA=
X-Received: by 2002:a17:90a:fe13:b0:2c7:ad68:f99f with SMTP id
 98e67ed59e1d1-2c93d77c93cmr3483555a91.46.1719825296558; Mon, 01 Jul 2024
 02:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701072908.25503-1-luxu.kernel@bytedance.com>
 <20240701072908.25503-2-luxu.kernel@bytedance.com> <CAH2o1u7j6pXhWHL2rBZak6LeXxn_KUbQHjygRGQKuEfS_vmtkQ@mail.gmail.com>
 <CAPYmKFtCzQOOsN7vutoY0MrthtvcGxBqRsbr4ZgMQsaY1CrXHQ@mail.gmail.com>
In-Reply-To: <CAPYmKFtCzQOOsN7vutoY0MrthtvcGxBqRsbr4ZgMQsaY1CrXHQ@mail.gmail.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 1 Jul 2024 17:14:45 +0800
Message-ID: <CAPYmKFs-R4SfjZOMyV5wxjrkV+Eawc-zRWKgAZNFpOezZ6JQDA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] iommu/riscv: Support sharing irq lines
 between iommu queues
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	apatel@ventanamicro.com, sunilvl@ventanamicro.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@rivosinc.com, baolu.lu@linux.intel.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Oh, I think I understand what you mean now after checking the
implementation of riscv_iommu_queue_vec(). I apologize for not
understanding the meaning of the code before, please ignore my
disturbance.

Best Regards,

Xu Lu

