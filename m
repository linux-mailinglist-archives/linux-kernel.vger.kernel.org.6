Return-Path: <linux-kernel+bounces-448405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9029F3FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E21E1888639
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586154279;
	Tue, 17 Dec 2024 01:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RjLVyv5g"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487DE54738
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397718; cv=none; b=j2NnyN0xT7tNX60kGultcHoJ/2rBsqHnYDN3Lv21QB5PS3Q4gea8foUlhofbecYeK5R650gvkiU9jeLVwkw6VY48OPRdVg+oeiP4wUFZF52tyGqLJWd/97sFVRSLt/Sy289AWVFbWjYkOhtKKJD5wfeNmHKjTtDgfMQtaD93s/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397718; c=relaxed/simple;
	bh=5j6iT2zeBprglLkGjsx781QuAZzbfmuFvWgXrzwhfk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCTP5zwA1hYplMPP4++r53tNNHqwYTDTEYIQeMPcZ4/pYQ0hQqterfqbZVlH0xpT5vNZXLHzUAr6CWLJskg6p0DsbsnjXwRfUG9fCEwx0HzYBOQydX9c9ztNIleTJMGQvghykcqScrrzA+CtxPOaCGmQl/bjHSgLmEqORNWuK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RjLVyv5g; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so642417666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734397714; x=1735002514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x5HbsH3y11AUtX77RP9ShUJxU46vkQ8YNLD+VoIrduA=;
        b=RjLVyv5gxiimBNWOsG+jhHfY6PlTvF4Pn+gRgvM875eJrj7+dHDDbiXjP+fiob3BSp
         SxeWPKe7sXEjDdaZwxggm52gnVQwKxShDzBWdQ4006KLTpbL3/VtouNqO+jyI5RFtTaq
         rkCpw4zJLANwrZ8duY5Dj3zs6PVNABhRIENyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734397714; x=1735002514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5HbsH3y11AUtX77RP9ShUJxU46vkQ8YNLD+VoIrduA=;
        b=jSiggr0m97rj30ySc6bJ94M51BjJNnbAiDJ67OffPQFxkKoetZImdZOc67tfig1JAM
         Rt7zh5v/dS66OA8vHc2dS0m47mDUY3VidpEUsNT2ym21jf0/P3sX+FAb+iygQ6TN9ChB
         lmdVH3LlBbsd2iiM9SVS7PWQVEPsHQHDiK0Bu59rseiSmJ1YnVdaz2mKUASkssmkgxnK
         40N7/vCzN3FkA77R/JINGdEhjz+WvUgwBS36NmVdCGcRfQ8r5qpE16qHXfDwvoTd7iG0
         KA2dn4jMmoPUi7obVPuX6uDTjf+73FfIFA0HOMToXidJZ80eW0N5MB1r5Kor8SJGgd+P
         g2sg==
X-Forwarded-Encrypted: i=1; AJvYcCW4xGoI/T6KdjSjsQefKXSfVjkQwgb2KwIxlaalMdOVSl4LUAiYRh7V+X5QWARc7EOAo6t4YPCY1pgbxWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsDEYpCSuaJOoM3krxf+u/jI+MXuG5DclX39F4+B2tkw6LM03
	aX9DoWPPqx0uwp+i4TdyXRFfwvXqUSB5Txy29dMnuAOfZJ00Q6FI9Pb1fA4SlqefmYZGeKndyH7
	+LaM=
X-Gm-Gg: ASbGncsbxuNPt+SfB+QCSMstF6VcOSXmgUn0CIQ8whi2rODj2Ig9LF2g8aRhdmOEF+J
	DgYgg7oEv4NjKgCYCGc0IXZRJ74WWYGW7oHAlOvIBgTJ7UdHT6smZ5Yxx/f7ijllFE17QqcemI5
	AJaEhsdnZ3gHZyBAGsC2ttfm9dKLCeZbPFUGIG7tlJ6Vgawx/nGYc0fr10U8avpGxKrP3rOxfxu
	k6vtRQf26up0TxzllBxY2sgge+XYstbNXPFYq66b1Gstxwv7dal3mcG1p8Aaxw2U88zqtb9xwFe
	dae3pbX3C1ElKTMRTL0j1CyhWMIGlqA=
X-Google-Smtp-Source: AGHT+IFwxEMxQtDPLlue+1J0NmgM7tkIWrqq+67XqX+KlazzwTlhp13uhV0Q7L5gCUAOF5chmyEjCg==
X-Received: by 2002:a05:6402:5214:b0:5d0:ed92:cdf6 with SMTP id 4fb4d7f45d1cf-5d63c3421f4mr31249642a12.19.1734397714356;
        Mon, 16 Dec 2024 17:08:34 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d7cf1f0f56sm752623a12.20.2024.12.16.17.08.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 17:08:31 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so635885766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:08:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVnrS0/QrnOQe+wdW9Woyqx6eD/N9KWpO9wlikIt0/e00uCcpS3PZ7SidN73GsP3qlU2UtkYxbpDWYZgI0=@vger.kernel.org
X-Received: by 2002:a05:6402:27d4:b0:5d0:d91d:c197 with SMTP id
 4fb4d7f45d1cf-5d63c3db906mr36599487a12.27.1734397709817; Mon, 16 Dec 2024
 17:08:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213054610.55843-1-laoar.shao@gmail.com> <20241213054610.55843-6-laoar.shao@gmail.com>
In-Reply-To: <20241213054610.55843-6-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Dec 2024 17:08:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj=W-4Eu=g83QPUDB+thtL=uY=_1OAVRvXJP=zay+K4Qg@mail.gmail.com>
Message-ID: <CAHk-=wj=W-4Eu=g83QPUDB+thtL=uY=_1OAVRvXJP=zay+K4Qg@mail.gmail.com>
Subject: Re: [PATCH 5/7] security: Replace get_task_comm() with %pTN
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, x86@kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-wireless@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	ocfs2-devel@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 21:47, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Since task->comm is guaranteed to be NUL-terminated, we can print it
> directly without the need to copy it into a separate buffer.

So i think we should do the "without copying into a separate buffer"
part of this series, but I do think we should just accept "%s" and
"task->comm".

IOW - getting rid of get_task_comm() is good.

But the "%pTN" pointer format ends up being unnecessary.

          Linus

