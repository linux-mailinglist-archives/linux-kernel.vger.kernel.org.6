Return-Path: <linux-kernel+bounces-277181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0823B949D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B889B23B3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA2218FDAA;
	Wed,  7 Aug 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sg51UcW7"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBDBE4E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722995991; cv=none; b=Fqv2IU1G+d9znp7Vl8CbS8QpoD750nYM9ssj4pdF7sJU9qYDII146nYJge+YTPjKL+7C6dRZNqHne81V8aXmu0k5mK8aFwx7+y/irSXaEre7L7J3QNjO3y10oux/eDWnC8F4TJwkSNroBzR0vihKaa3OL1ge7E51W9xzvFNf2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722995991; c=relaxed/simple;
	bh=6swMmyIH9qc2r8gZCH/sJTxj6C70uaqV0cUv3UzhcYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYjLGIBHfH5lEIL0HCwzL9zBHZwPMPWQrS7cX/TNq4Beo82ohtK7waGaYRfWtloqqMgVIoAkAi9HOBCs6Kiapq4AsckjiAV8wRc/S28tmtZ7J7VIIHYbN6zYNA8qvDB312WyIqZYMvb3BP5mFj6DYHXfo8zcv7XG805LvJfiRUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sg51UcW7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36bcc168cdaso831498f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722995988; x=1723600788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6swMmyIH9qc2r8gZCH/sJTxj6C70uaqV0cUv3UzhcYA=;
        b=Sg51UcW7U6luUhmPozl6GRsTdYK2PCyUhQtbPFWqHs4EVcULnz1tr98S8cN4zn7J9G
         c8En8SwdxU5LXqlSs1fEY7S++9XrcknJKkCb6F5uECaF7N0MxtoKBc+N/PfeU9PVPztq
         U+0ON5k9GCn8LuF5ouhkbClQhY2gC+8QLEu896Pb5X0b0VI8n01SGOHBba13MEtQZubo
         obZjkrIro5q+Zdu9eSPkTcaAjhexVPh6sGTeRnCnJcAdUZBC+tblOoYiIzW/pJn8+d7i
         332Wzom7c1LVuJGdRcxoVSVA4R9RipV7DppeqTJkmcft0a/qI1TERBWCEuVcUiAwKMUA
         d13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722995988; x=1723600788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6swMmyIH9qc2r8gZCH/sJTxj6C70uaqV0cUv3UzhcYA=;
        b=QhgmMkjZDvqOGqiNYwGdG8hGB4YHlX4u2DivUDUiAIetmiorI2I11ADBj6YBnJVxcI
         P7ZHyR0IwHA9jnEGlTjTcF1WA6vuKYXouXJcQr+2A5kqYdAnZxDZ5Rd3+W5R5+ePLeE9
         N2ZSXZYpgwGatNjg+vT5QuKB2hkpsf0+C3YP23m3eiyAn89LQVhNBSZcex1mLYNuTJFu
         pacKU3pz6C+GCaf6GhOTh9fYUbD2bvsesRbbZLjy2ldXs8kSV4ytRHbkicbs/EQHyNLP
         ILJkieIAroTEtf5MrYOUWc78LKDVuyUIlTGTlcnbeNP5HFW2EWT75h7DnmUVMjv+qxf2
         mRtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu5DxNFRAjQM9pk5NvVUr6bHwXA/AUNpFbmS8yxONuZrKyHrVU6eAwwJVDZeLIxaT3CrmLFRPfEs91p6I4YydstAuK2QHq8CbRwaRZ
X-Gm-Message-State: AOJu0YxhIFZRsOF0Rle/Zm1r7IWBXB+tlzJgDch/OUhHcwRR1YbSz//y
	DABd6uNjG7zspVSFksWemMrd/xqbv2mgzaH0EGib4HkAP4D8ZQXQv08VwRb6aeLZHTU++OuYHyL
	+uu/QTtXPHBjhvMXqGk16pY+N1CAbeJVzC6OH
X-Google-Smtp-Source: AGHT+IGKLTWJkUMhBpZHLWO708ZbAn7qTA+8RhzekMl/VbDr7FpOeJKgKpA3+NZdYcL9nux3YN6X1cNvy7PVczsBKwo=
X-Received: by 2002:a05:6000:1e83:b0:368:319c:9a70 with SMTP id
 ffacd0b85a97d-36bbc0e0c7dmr12051161f8f.5.1722995987612; Tue, 06 Aug 2024
 18:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806112208.150323-1-hongzhen@linux.alibaba.com>
In-Reply-To: <20240806112208.150323-1-hongzhen@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 6 Aug 2024 18:59:36 -0700
Message-ID: <CAB=BE-SpBK3oL6P1LDpknUWrwuh79R10XzZY7ZQB9p8Zncfstg@mail.gmail.com>
Subject: Re: [PATCH] erofs: get rid of check_layout_compatibility()
To: Hongzhen Luo <hongzhen@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM,

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

