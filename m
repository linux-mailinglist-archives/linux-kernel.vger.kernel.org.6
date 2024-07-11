Return-Path: <linux-kernel+bounces-249890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F82C92F136
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1AF1C22A01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A119FA72;
	Thu, 11 Jul 2024 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dol8757m"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6205A12F385
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720733923; cv=none; b=cz5Tfs+ysXLydKzkG7KEQeqopgCLDF+15vMIHEkXsn7apxcPD64rmJ80Cl9BYIf+L+kj3Hjgq4YDplLXYUYLhbADdVu5iotmpGrlcJVdaPIhinf+b0OOSIqbEU36F7mPRxW/QK/t4SAa43D3GpCLQ8J+/lxnJbIrAaZd1Cqwggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720733923; c=relaxed/simple;
	bh=f0wFiFq5dAE7dnpF6Vm0E8ke0Etl9xk5YcgJu9cdznM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7eVb33mxYi5PzCFJ7sDeEIIrgZ3AWkH8ttRoxD7pjGifnf+cMuYPRVBDx1Z92PlgjU8x1DDertNK6ffy9a11XqM9DcCbBa0n2uZUQYW9zJmqbuKLmF894itDMbwxeUJZ4pejyEzxwZjhUKTHpNtNvvwxdMNwRE/AdQX8Bk8mx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dol8757m; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64789495923so13183947b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720733921; x=1721338721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0wFiFq5dAE7dnpF6Vm0E8ke0Etl9xk5YcgJu9cdznM=;
        b=dol8757m30o8e3h8AAGCZV5KwjowtM7VkCqxdJkBhdGVizvMgGDXP/vZu2X4zt59QR
         cnA2ZSaqY+6V7wPLBbFB1aTfCoGKK6GnDQw0GP0HMzOBBH3ztyzv7Qz/XkWx4g5VKGm4
         m8YiJF8n437BmjiSxaK3AX+1tyCH+7jaVXv1O9nRbRbF9IpZ8pX+DLIpM7Gv4J5nz/z8
         nN6AYmz8+REn8Tg9ybUIMeqn2OMb0YfRmv94xtEFgL5g3xKR75ca1/9NoFNh+mIPRu0o
         ZfLrn4BIywWVqNvPbuV/DtTsCehY9RMHrhNcJmnOKOl6KqDxg7i3+xE3Dg7oB/qHAE4r
         A3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720733921; x=1721338721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0wFiFq5dAE7dnpF6Vm0E8ke0Etl9xk5YcgJu9cdznM=;
        b=LavzAM5ifUYC1yv0dfeeXmfVyTWLsBj5fShxQ+KJKy8TFivNLaDaZ5MM2vucWFlACl
         mSOjQ4/lav3IBxOY5jOgOeEQDsBPk039TsqRZkZ0n9Il15cb+zHT4Zv4yA4DvuvyY3gd
         IKGYRDOn/iFn40iffSzGBiQANotPv/feskVMqIUn5ypcjm8uMJdekCUiVphaN/BE/pxm
         hLM2u6CpIf2mJWV3i4Y+9WSaXH1LeGilchW8BSdq4SCIwjZQHh9wa3TyLl8NztX00NSV
         aYORGmE2Q9yZ+3Doky3KLXoyaSdxfe7ohOOqTuCa/EaXctD6YgV/6d+27YzikQRng08+
         Qr+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaiAhxQvGEegBUjUmzSf4ff2H81jNKVmn2VQODpym/kAiWSFKWdi3XDNFEmgiRIQJjNOo+3aSkGnZUxfR8JgrOU2vYtXHe6qWBRLal
X-Gm-Message-State: AOJu0YwZX8pC4E2N7j3MR3HZe3UXdIXS3aWw29UfIWJUsGHlnX97jvJ6
	8duL0fDZQYCkBCD8W9cBEK5jyOnwLRbqX/CHpAlaFMJSdA00ABm3tEmqMwiUkkb+wM0Qt9H2HNJ
	gy2DWMIH1CHV5xdwR+u9ReWrOpo5xUJmEHAoSXkOSEOQXTUXDsg==
X-Google-Smtp-Source: AGHT+IEy1pyt1fAB4JX4uVbAqGclWCC30idjb8WmdUApyesOAiZMyd3u1Ss45XXknzvuW3NpMSfe7bkeXK7gQR+K5Es=
X-Received: by 2002:a81:9181:0:b0:64b:a3f0:5eee with SMTP id
 00721157ae682-658eed5e01amr100627527b3.17.1720733920975; Thu, 11 Jul 2024
 14:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711204626.1669138-1-surenb@google.com> <20240711140742.b2c536fb4de2800534a99980@linux-foundation.org>
In-Reply-To: <20240711140742.b2c536fb4de2800534a99980@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jul 2024 14:38:27 -0700
Message-ID: <CAJuCfpFC3OLimU8q1m9tJh8UoRePb2Gw6Ezbrt-fOGBrKwzyUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: Export memory allocation profiling symbols
 used by modules
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 2:07=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 11 Jul 2024 13:46:26 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > Export mem_alloc_profiling_key, page_ext_get() and page_ext_set() symbo=
ls
> > as they can be used by modules (mem_alloc_profiling_key is used indirec=
tly
> > via mem_alloc_profiling_enabled()).
>
> Thanks, I'll add
>
> Fixes: 22d407b164ff ("lib: add allocation tagging support for memory allo=
cation profiling").

Perfect. Thank you!

