Return-Path: <linux-kernel+bounces-286949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04B9520B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B11F282B22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1E21BBBCC;
	Wed, 14 Aug 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw2rjbpG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED02E3E5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655182; cv=none; b=N8qJeyBWMT35dn9UatcLYTtyh9VtB2LGQQkRpL0fxYi0gYSTuVwBRcKMcyDXKwQp0AGGmOPeuH40XYLnAwfqbvwrRCdYGDikmjrku3UA5DCnuFs2dSqkm1Xi440Jfhi5wg/4T4/jI6QwP30t08epeMSRLRfmoH73aQgkN8Ek4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655182; c=relaxed/simple;
	bh=sARIX4ukqMN0+YO7QoHBlDh3NtqVN+qyWfzelkzISJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2RCdoPmEsBqM1WAGU5W73BI9BPF/stR7m+uQLkdRWW45rrwmq8MSjqS1SBtwhqlskPOjCGk9PUZnUpSbIiBKAA02P50YsPQ9tgM6HNsBtQwDgMUAu6x/WbNgMfJchS7thHWDq6lMlOO7giF6us8LELAI/ATCvyBVZU2+yIGVCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw2rjbpG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723655179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sARIX4ukqMN0+YO7QoHBlDh3NtqVN+qyWfzelkzISJQ=;
	b=Vw2rjbpGVaLj9GhbF4znSARFqXop9eAHC47rftBRMoUKdsfme7/hdfdY0cbzZPpbIyQADS
	VzODf30GAZQQIY7wdAMTcQbLM7tA3mYiQuvGgTdv0A/UH9gSrBgclVU8IZ/fCNS5QPU5ym
	SiUJPqNjUDtrI6dpBRLIf7NutqUCmEE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-hVISOHx9M-aMnMhwEcUtYw-1; Wed, 14 Aug 2024 13:06:18 -0400
X-MC-Unique: hVISOHx9M-aMnMhwEcUtYw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so158845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655177; x=1724259977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sARIX4ukqMN0+YO7QoHBlDh3NtqVN+qyWfzelkzISJQ=;
        b=bEQhoHic3Upisy9/MuWl/RMBJ2PZEYq6MZPrC/tLp0oq+eee5+bVxrlC1jpabnrPGU
         uWR512N80/SlEGY36QaHtQDJVQOuSwpxFe4f7gScN6ULTWq5QcdrNCqYWfyZhZqpIiy7
         Yk2M4+l6KP+oB7wPEWwFh/E1UGEKyZ05U16KxcnhaKpSIdJGqegS47RTUFdLyZUWVANk
         Up9wuTWX8OFJfvYrgosrzDy6JWxKNOGBmSAFYloU7ogJB0k4yYIfRLUE8qtiP4zUnf3P
         0A2hZQP8inHAuK8Qyajmb9VnfFU6sDhMdkVSYbYkyIRUqNy6ZRUabFhSgdPUhqlOd/9D
         8j7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkcU/SDsnoqBCxYYhwTY7yagV2GTjHTrVbK4zzvEybMYiz1TdbppLFQ9pZywT0OiW4qX0oLJiRhqMnbf18u/CbScb/pOqw0as2pSvh
X-Gm-Message-State: AOJu0YzKyJh30XU4eEgMY3EzvOn3uqExq5oqsvjbyjIiESMOEiDs7q4S
	rP0RvdwvvQamV66Yd7pQSRWvktcfFe1JIXhcDlZ5wyTQ+eGp6BQ2pjhFJ0jMagb+Q0XJ2Q6vGKY
	ZbKHDODsaFGksftAeFOPiHltQMfyFVLrxki4NlOEidfWozAo54WkErA8NRkLramGCGdN5dAKiop
	1sfC3FTGjbNJaNcJisjkaG86Dz6SNgpkmzbv5t
X-Received: by 2002:a05:6000:a91:b0:368:e634:1520 with SMTP id ffacd0b85a97d-371778158afmr3221002f8f.59.1723655177104;
        Wed, 14 Aug 2024 10:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ92s0bv9O9QBrTJDwjKcvnvPi4/xG23d+AxWMhC7q7M8ceY+CEkp/DVKnrkLJkmwapEuW3h74NVPYEizA4eA=
X-Received: by 2002:a05:6000:a91:b0:368:e634:1520 with SMTP id
 ffacd0b85a97d-371778158afmr3220976f8f.59.1723655176647; Wed, 14 Aug 2024
 10:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814083113.21622-1-amit@kernel.org>
In-Reply-To: <20240814083113.21622-1-amit@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 14 Aug 2024 19:06:04 +0200
Message-ID: <CABgObfZHVO23h8MmWy=nzaToTMqcG3WgUVXHXf5N-Ca+c0y5wQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: uapi: fix typo in SEV_RET_INVALID_CONFIG
To: Amit Shah <amit@kernel.org>
Cc: seanjc@google.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, amit.shah@amd.com, 
	bp@alien8.de, ashish.kalra@amd.com, thomas.lendacky@amd.com, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:31=E2=80=AFAM Amit Shah <amit@kernel.org> wrote:
>
> From: Amit Shah <amit.shah@amd.com>
>
> "INVALID" is misspelt in "SEV_RET_INAVLID_CONFIG". Since this is part of
> the UAPI, keep the current definition and add a new one with the fix.
>
> Fix-suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Amit Shah <amit.shah@amd.com>

Queued, thanks.

Paolo


