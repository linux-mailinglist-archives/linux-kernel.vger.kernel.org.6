Return-Path: <linux-kernel+bounces-200916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C669F8FB680
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FFE1F219C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630413D270;
	Tue,  4 Jun 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVqustjF"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F176846D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 15:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513469; cv=none; b=fi/UK3diLyqQccU1T3yXFypdfKsavWpB6Hnr0efk/Flp1jwByJSRyLM7b5HN+RcD0WecTRFwqaOX0Eps1H7xjpaIXUbBBdZwHBj4LCVYqRd1aFd7WvQcA9PIcwg8jhIeioBeALJyNI0e2YTlGFYFs7JgpFmIExkSwmcQF83qRTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513469; c=relaxed/simple;
	bh=XuIzMtjidqLr+rmLnKne3/l8kEyJnGzKOsEtJfNXpEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud8GaNJeuUh77ZNRo7F1axzRyov9QDbj5TPjk3AtkFiunfthepnu+bVm4C4rb9pVQA6bio2HVGUM2rRYeTp4Hrznxq1NhvphyS6OlwV376rf8Z60CeRtz08uUCPd+00nCpv8Y6JRPyggSrs76/m/3TEn8fmo7Et56fJRlCHIcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVqustjF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ae1b32752aso29411266d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717513465; x=1718118265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuIzMtjidqLr+rmLnKne3/l8kEyJnGzKOsEtJfNXpEM=;
        b=oVqustjFXuCde0GVz/VF6qxpKhACqWW2BEM0ua+qnEOSutagmVdAPcktZTphUn3XB9
         0oIOkab7sq7+s6m8IuLeTVozASFaf7GNgvRNHZKySffN4uMrUN79IrBmJcvNA2G+JyKJ
         EocY3dUCZ0GO5zDmb3qS/GjIqCJMkG783FLz2H3xAXf+YNV6WE8WsYJsxc/w+YI2Xvdx
         NX/yRnAZ1kXWRsMHmXT+G6rra3llUG0bbaj+HntE7WxHSSFAVXdNHouZuc/FVUwApdSe
         J44QL6Mpt7FGHnQ5FZIsLm5F+V8+CkZn7dDOOuVH8mQrSKDMc5dPpwhs5RSHEZyBGM9D
         yVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717513465; x=1718118265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuIzMtjidqLr+rmLnKne3/l8kEyJnGzKOsEtJfNXpEM=;
        b=wIorYxXD0wZt1brk/pkTG4XE5zS/u6kP917T6f7FHXRG0YaUXsgtDhfMB8z5wc1VJ/
         C53DFq4gb8DIB5W/KmuBuqXwkn6Y0gA9PQGQKN4ZAifTMTNm6WVy0jaGaV7MwOjUA2Pb
         OnM+1jYRzGYgyJuvzygRN6mmfyhwzuS93EHTl0J8KgYXwVTeAx2/zViBGb18PnqONzeW
         tbFlJ3Oom3EODSfCdG+uDbaoiFVkRnAgKoUbguDGJkvvs0WB2zNSFsKDFlzWj/AN5kvj
         /xb3I92d2tMpRslHjn+wgwogQRksUHH3FQoGuN3oHVpU5WYo8fNsNKimSrhd+vS5GEBL
         aNOA==
X-Forwarded-Encrypted: i=1; AJvYcCWeVqmzry5vzShjmGBiUTihVQek397Fm1bXYgusxIK0ZYDD/UsKrxr2ql8OnRXi968ihCILmZ48qqI/aafRnKxCd9T4/7OS/kAiZsA7
X-Gm-Message-State: AOJu0Yyel21E1pimUMSWsH4nH152diSYBgTAl6rK6HdnsKtcEXx190eo
	FseI3puJy0ORCeDFpEVlQfHnDmXOPkxFGD8GEbNM6xOIt3twDar0Uv1cewN8Qh9mFU7VQLyqffa
	03PKa7bVTjfyme3JrR7Qwl7sfFwPqJYB+zIog
X-Google-Smtp-Source: AGHT+IEc2i2uYoZ0LGBr2D5FjAvAhS8oxe9fpEVAc8WRo0Ug/6h91bryBwxupz3K1jNeEdTNHPw2YH54C/01cg/SgVk=
X-Received: by 2002:a05:6214:5908:b0:6ab:9bd6:cf91 with SMTP id
 6a1803df08f44-6aecd6f0912mr143798536d6.56.1717513465195; Tue, 04 Jun 2024
 08:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717507310.git.dvyukov@google.com> <8e7115affb70513cdd9d5ce83547b98c4c5e419f.1717507310.git.dvyukov@google.com>
In-Reply-To: <8e7115affb70513cdd9d5ce83547b98c4c5e419f.1717507310.git.dvyukov@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 4 Jun 2024 17:03:43 +0200
Message-ID: <CAG_fn=WPX+T7XQUe9rYfv3zR9Ovh8wT_xORv7GCSREoi99ZRwA@mail.gmail.com>
Subject: Re: [PATCH 3/4] module: Fix KCOV-ignored file name
To: Dmitry Vyukov <dvyukov@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, nogikh@google.com, 
	tarasmadan@google.com, Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 3:45=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> w=
rote:
>
> Module.c was renamed to main.c, but the Makefile directive
> was copy-pasted verbatim with the old file name.
> Fix up the file name.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Fixes: cfc1d277891e ("module: Move all into module/")
> Cc: Aaron Tomlin <atomlin@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: syzkaller@googlegroups.com
Reviewed-by: Alexander Potapenko <glider@google.com>

