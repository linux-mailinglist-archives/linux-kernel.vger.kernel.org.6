Return-Path: <linux-kernel+bounces-556402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D0A5C701
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6AF3B5F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2FC25E82D;
	Tue, 11 Mar 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUUjsaDV"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CCA25DD08
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706718; cv=none; b=reP0VrC+Td5kGoH2Tt+613Cqm/NoJZ2cckQPqFyMJ+KTaaRnkBPz/5uMmddT0dSiQQ9egaGwKviShTS/0KyHs1IVG3mZMZ6UjhwaEeqOwEJCIBfVWL6Bxc1JkAqIbL0p39qjXom6n1Aa1V9t37BCWpRKF5gDFrrJnyNQj3E+IS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706718; c=relaxed/simple;
	bh=7Bp9L0XUWM9HtD0nXnjpoDsrkJ76vECMAdIWTHbJYpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9N57A7vFnhLR2H8ISd6ABrC2a6mY0eC1nBPc6EPx7c5Bz+c4F6kY9aRLgNitlbHSHDaJiskRf0FHq6cMMXhB/0Jzy3+vuAYG5Ndaj8iYdEwGlE2HVGq+XIHgONTwIBn3a1qIvbwfPJlztCYLvcc2c9nFzRxukFvYqlA1VMydaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUUjsaDV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so6171a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741706714; x=1742311514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bp9L0XUWM9HtD0nXnjpoDsrkJ76vECMAdIWTHbJYpc=;
        b=HUUjsaDV/h6OJdxgsZ+37hrpAZcw3ec0vlJOy9XUpIzTYASBcuWKHCNLV2QFYV8t1u
         Syu8FiUiXO5sGDYPwcIwov0CFfAmSg8Qkrs35sqzFNU9N/eTlQpLSGCpNiHwF/2Qi78U
         dlrZCrIfqTFDj0jrYT6m3yTIi7NnzMI/fW0YsWRf8HgBxU1J8n0wGBBMHJ0ujXLrUgga
         cHBftxP4VKAuLVDHw19KTQGWm7hDoRK8Qq3oMpgAOQhT+Y5CzAIHSM1BFexjYEaydMpC
         oAOo6E6JNG9DGU5y4VTmzn8PsVt2NgGL1e9TAIeQBh+c0SLDgMxo9OlN15lUHRz0bnEX
         +a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706714; x=1742311514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bp9L0XUWM9HtD0nXnjpoDsrkJ76vECMAdIWTHbJYpc=;
        b=EcQ9aZm2OXbMGp9u32wkfPNo1n69QGUNZlDhjXRTgK9c7QzssywXcWQ3OKZ8CaTPvA
         2BdaBM2skVcAArsIOuL0anmDL7UoGpIE6RVbNBODvSZdeVlIAkSGraG6y1q8knBrX1yG
         Kr8BcHdwxEqRvITkMHHQSDMo190FiUdnvaWgJK7MJ1Q1b4wIb6Q5SZRVEGIV5iJpTayu
         SZ18zw1jo06yNuP5MQPKy4DB8jqHr4NUzlxosmZb6fX0EGfZ+vnw2XkwXhrxXMuDD3KR
         D0YeswjvlAWj+NgntedKb7z6Sad1Q+sLgUrXGcrQHlNSmQ7DSUGV5zGcR2R3NPG4CLiN
         k4qw==
X-Forwarded-Encrypted: i=1; AJvYcCXDpUWaW0j2OKI7jA6alIk/Gxrkv3vp8v5TFU9/eaMkOrYtkQiC8HFrwuNBkERXr5bBGYCYGy9uc8ucuRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIiQGQxJFhI0YzafYy+5tMSUmglz6qaILCmtllPSXV4TLISIy
	Z+G70322XfhbpzK15xFjiZJLKK8f/SeblNBLOLVRasDuMA9WrzwVJekzRRyHBuk4S/HHcq2TqS/
	98pacWOy5eu+eTnFoJyY3fqyhnoAqltBH++fl
X-Gm-Gg: ASbGnctBKi4+7itAwJVMcYc2PBRIgBvGPvTc99F/5jSZv8ud3yEWhTohCX5hRGuTpJC
	47Xt1/TYy2/K2TBsH3H4abVNecZDGMAKuTaEOvdpmi3kd6l0oxb1LUKfkUAmmXYmdxkHCUOjJi/
	84gBlzlYp1HVOn9UMk3CAIVao6IE4bmBqOCPSZnl9iVVyM7VtU8Fe9zstELY2G3jbH/qg=
X-Google-Smtp-Source: AGHT+IFJ+Zeetb2fHKVwImuvwaMBfM6cXpntiP+4Ydtlv8XW+cVvGKQDiMqorgEbo/Wt6gBVZwA8xdRT1ITflpkqSZk=
X-Received: by 2002:aa7:c918:0:b0:5e5:606e:d5a8 with SMTP id
 4fb4d7f45d1cf-5e6173bd40emr307514a12.4.1741706714455; Tue, 11 Mar 2025
 08:25:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144026.4154277-1-sdf@fomichev.me> <20250311144026.4154277-2-sdf@fomichev.me>
In-Reply-To: <20250311144026.4154277-2-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 08:24:56 -0700
X-Gm-Features: AQ5f1JqB6yJCw8-bZi6XkUvhl4Z9hUm8qqLBipF6hy06bumhLqBL7PWMuXMFE8Q
Message-ID: <CAHS8izOkrSAZ+omAC4EVZ3NzesOC7dgKyEto0ufK-bRpP82FCw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: create netdev_nl_sock to wrap
 bindings list
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	donald.hunter@gmail.com, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, jdamato@fastly.com, 
	xuanzhuo@linux.alibaba.com, asml.silence@gmail.com, dw@davidwei.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 7:40=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> No functional changes. Next patches will add more granular locking
> to netdev_nl_sock.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

