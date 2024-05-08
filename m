Return-Path: <linux-kernel+bounces-173619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD98C0302
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1946F1F227AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83DF53387;
	Wed,  8 May 2024 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GMfcJzvQ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E194E79F6
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188960; cv=none; b=TjKdx6eMcKl8XnAIJULwiKJ5u3LU7+QsKnJqG8Xl6dGgh3dLckxz+zg63y1vnlgi2Kg+ThhVCOwEejXGMEStjd+5vzLc7wR3g/56iaEvF5ZaygHGgJ6JZVuBCcGZH8RccA9JMihMBXVWn19Up1o2KfeaFhfg/mvWVbSCFa0CVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188960; c=relaxed/simple;
	bh=klZ6+XShnNjYHqzk7WhV4DOji81QsTegGKMuhCL9oew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeXnD4KfYRWycb6HM/i9eE7gSJp61H+3ytjpq7XTWsijYWFHLRc0CsxoeW8kVHlytTO4xGJOvNI6DZLHjUpZeT0rltBY9lfQgyD57Qs5fe+syVce5AJC2+4rv++Q1gstVOdUQSUGanxog+ZSPhVKmAw7ttj+sxLCzu0LZEd7u+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GMfcJzvQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e22a1bed91so176611fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715188957; x=1715793757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SRl/m4RVKZLzWdBeNIFBLk9WHXC7qByJMfaYJzzbNPA=;
        b=GMfcJzvQFqhCKh9rx8b5qbVLoWn1Q3AK/UM4KWmP4IMSE7I4aFeN8FlzfXMxqrQ0B1
         0wgyIXFUtCFWqUkJhU2Rv5YOptdT9jsESSHz3cn4gJ9bxITMQwdBa9oomXBQaMRR1ZWg
         rgo4T633OAUJuZ3wR7CQai+MWMiDxKk0TyuME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188957; x=1715793757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRl/m4RVKZLzWdBeNIFBLk9WHXC7qByJMfaYJzzbNPA=;
        b=d1uq9upPBnDg9rnU7qj7imHc9Mgp0WjiE7o3oSCL18gmPvNolMAjrM6Nb0cLlbdVTy
         26d7HCmjjoGSyn7eZ4VqqkHcqjdJrSlGK43h3BbV8QI8KhDueZATjRk7ney/nlWj4S+U
         MtmoaXILgQqw0jQDCA/g4bJuiUJwhJTYZDjyJhmjcEtCZ5PSfVd6yKfB+SrcC7z76IFg
         ZjCBNrWi4HEwQmdbhiJOlO8KQ96QAkIsZRb3F9wozkbN+U9UNPvCukRXUbLm+QKk8QL6
         dr6yI4oOLDZUgc8U3JzUSamJba0B1T82NT0Yitk1jdS58JM/VoMOXhvfPm3oUmxgqPG0
         8lzg==
X-Forwarded-Encrypted: i=1; AJvYcCXYdwxXL5wmvSE7BEfoovDfPCbEXkk/XvSyqjcnbstXHDJHdOeB3ELZTVBXJM2y5sRKoZ+zs6utnFVSmm5NFjeMIhXFeFyI+XnPlbsK
X-Gm-Message-State: AOJu0YwNxO5d6gu+YjUR5nOosKhaxNTNdhWkSdU9Ko1SZfF2jzGVpDGL
	lKRy+ztUCHbXU8dbGgTOhQsynDOpIUmzTIW+3MjwUJhLxhnrwQCOtqMYDp4Ch7T5s/SdERN35LW
	ENqse4g==
X-Google-Smtp-Source: AGHT+IGz4Tg3ATKAXctlfrTOdC8t0KB2PvHop1PfGuraGTjbfjrkFKbuR/OhdCe/I6skpWfbO9ThEA==
X-Received: by 2002:a05:651c:105b:b0:2e1:cb22:a4d with SMTP id 38308e7fff4ca-2e4476af859mr20197321fa.36.1715188956846;
        Wed, 08 May 2024 10:22:36 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id t6-20020a2e7806000000b002d81c25febfsm2379356ljc.108.2024.05.08.10.22.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 10:22:36 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5206a5854adso4331721e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:22:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGiezfI8WwgbfWSAcYABzaUbCvWjzL7fESmXwQOoUZQZxrMcdAGeCsQaLhTMaausKVvCx+nsKIOMGOL93OjkgcfjZFBFWhgZrMLdHz
X-Received: by 2002:a05:6512:3709:b0:521:7885:150f with SMTP id
 2adb3069b0e04-5217c566c9bmr1897367e87.28.1715188955736; Wed, 08 May 2024
 10:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7abb76bb-eb4a-4136-af2f-6b22fbf3d79f@app.fastmail.com>
In-Reply-To: <7abb76bb-eb4a-4136-af2f-6b22fbf3d79f@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 May 2024 10:22:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbpyM=Vgb8cM_aoRtZf7GDWq7Wa-cJ=J0DpVkfnd1PBg@mail.gmail.com>
Message-ID: <CAHk-=whbpyM=Vgb8cM_aoRtZf7GDWq7Wa-cJ=J0DpVkfnd1PBg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM SoC fixes for 6.9, part 3
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 23:00, Arnd Bergmann <arnd@arndb.de> wrote:
>
> ARM SoC fixes for 6.9, part 3

Hmm. Some of this already came in in "part 2", and your diffstat is
wrong as a result.

You seem to have done the mtk-soc merge again:

> Arnd Bergmann (3):
>       Merge tag 'mtk-soc-fixes-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into for-next

and this part of the diffstat:

>  drivers/soc/mediatek/Kconfig                  |  1 +
>  drivers/soc/mediatek/mtk-svs.c                |  7 +++++--

doesn't show up for me because I already had it from your
soc-fixes-6.9-2 pull request.

I've pulled this, but am a bit confused about how you missed your own
previous pull..

               Linus

