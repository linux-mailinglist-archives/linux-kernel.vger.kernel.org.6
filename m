Return-Path: <linux-kernel+bounces-269513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE9D9433AB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB011C23444
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08961B581F;
	Wed, 31 Jul 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ryd+0aCl"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF6D1B3F0F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441094; cv=none; b=AZ9TA9Iih2mueAzubMN0DQIFyJG0i07nnvhh/rKRWzucaHQaky/X1YoMV9eYvUsLIFSFL90v/JHX6dK4AxOZmbGtDraYTkDGytJ5DjEKPG9qYyDX7ve2miSw9NMp5JK12T2gmwbIA4Qg8BzI67g8EroXd+of4mUj+8TNm429wOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441094; c=relaxed/simple;
	bh=qPPJaDa3oltxDrhp3U0v18X4YZrjzYBSJplVnujrCz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7nceCd5WnKalCpTEWyclAqypd1t4OFFSOhN8z79GNzhvvR7Ooy+O58JxZvzO3ufSKvoR09mO46qzSWtbcOauFdF4QHG+axWm2vXGNdshiG8Ov812Gqxf2+viwfNPwUVm19VF1i44kloF5wU9IHijlSiYWsqtANLAxCV8aDpn84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ryd+0aCl; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0b286b922eso4133128276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722441091; x=1723045891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+Y1tBH56NyXCyU3BPl+HWO+PHBBC2ShKFx3B+Ne8TU=;
        b=Ryd+0aClWamE0KM2+5GJ+Yj9xnPL+S8UkaFsjoM6RE6DVkGq17VLNzuMmFtcB9KPxw
         o7zaI0j2BUwznl72VL8x4EWAjf44oK4iR7sI8uE3shcro3yNqJkes18b/0sAVinCUMj9
         PokcwxDDFGV0G4HLY11eQ+bxwvpuyTgwLy3CyIQooVIJ28r6qtdFfzCTqrWds5LThfzK
         9t2ZJnZZDs0Q1Yed2wJlOESzxV8m3b7AFON+DplJeddWgBz5ZUu2HKAJXd4FJDKQ9Yp4
         M4YM0nE/zjgRm1lKVgzkUUMx/xvgfnVjtd2ilPfMyO09081cUZSY+latw0KXYHVO+kJa
         4jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441091; x=1723045891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+Y1tBH56NyXCyU3BPl+HWO+PHBBC2ShKFx3B+Ne8TU=;
        b=RoWl6t+Zl/ASTiC4VgUvJNK4p3kou17vLBVXeiEJrW5rxFXkbkN9+3hroBqq4Fmj5w
         USaYaWKqD0JMz8sis5gNlmG04Tt0ioYI2nCAnqpuDzbJ/KZRWSojBPHAY95p/vDcQNwf
         jYiD/YjrFyOSCKQlcvXecyN7Kkp6arOwYrt7Dfoq+yzzNV0ShiroQm8v1NCrEfGR+5G7
         fe6ZsjaPGSjYJfhC5hnQHaDzDOe7ZqDO2CRXPKVUKYNijgKSx8wouH32+N/Xm06Yquvw
         u8pOpwl7WjFSNG0wpUGhH2VjQ6KOFu5C1Q4eXNrMm6FAK9LaIkLAJYty3GQ0Kc6m3gOP
         t6Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVojL8gLTQXNebOcUkzG0fVKrW0+XnHiqVin+NdK4PsJ+1yICXhdSZbDt9fEE1PCIGBTGJB5YUXTtKYGisO4bak3AWWgw0unhylphga
X-Gm-Message-State: AOJu0Yxn5YeIlEqJWAsMbNsuydgOEJYGZ8xWpjtsvIARGdi6E2ZAP1QZ
	MZ6KCb1NqAaNyC4s/nKQ9vJAsolD0j8U53cAkj2/pKhUKSzlwZY8WN5wtx8L/Jgj0HDSMdYD534
	m85iG/uJyRi378OchPCOJMgMGqlkBpxgQ7vjt
X-Google-Smtp-Source: AGHT+IHwIZcmqLvjLJdL4nFbCs9ggYLgBXJnYBwKJ74/hRqjfxBmEuMXVpuI03ApuJDsvsemBmMco8Se14aj/qLzVvk=
X-Received: by 2002:a05:6902:100b:b0:e0b:1241:cc17 with SMTP id
 3f1490d57ef6-e0b54468ebemr16610271276.15.1722441090793; Wed, 31 Jul 2024
 08:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731075225.617792-1-ruanjinjie@huawei.com>
In-Reply-To: <20240731075225.617792-1-ruanjinjie@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Jul 2024 11:51:20 -0400
Message-ID: <CAHC9VhR9MC9GhGZi_1ftycfGyeuCQ=BXgAs+v+9D-nXWg+eu=A@mail.gmail.com>
Subject: Re: [PATCH] audit: Use strscpy instead of memcpy when copying comm
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eparis@redhat.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 3:46=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> There may be random garbage beyond a string's null terminator, memcpy mig=
ht
> use the entire comm array. so avoid that possibility by using strscpy
> instead of memcpy.
>
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  kernel/auditsc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

If you look at audit_log_pid_context() you'll see that we don't record
the entire task::comm field, we only record up the NUL byte, so any
garbage present after the end of the string should not make it into
the audit record.  We use memcpy(), as opposed to any of the string
based copy functions, as the task::comm field is relatively short and
having to count the length of the string in addition to copying the
string is likely more expensive than simply copying the full buffer.

--=20
paul-moore.com

