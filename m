Return-Path: <linux-kernel+bounces-523976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821DA3DD99
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243F217C19C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6937B1D6195;
	Thu, 20 Feb 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ele8cKsI"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232661D5145
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063665; cv=none; b=r4bN2jN1AYn6TSJzbEwh/yjenRl61jcPpDxB9g/NiHw0cGiy8JO8ahzRH2j4O/lh/iRQhayZNUVOKrTWE0aIamEVlZyMQPDbVqAZ/hd14lkEseYGA2NfpJq4NqUYtBQGErxjYwneZgl5727bd2HS9PP1rzXP3TTUZ0v8aZI8qD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063665; c=relaxed/simple;
	bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NupOp1inYTDUmOwkWyK8pVuVQxuwUtsJ5CPogAjbKyyIxZ/ZJ/owQtlzGP3FIcP0Fyt4tBWrvlziwV0f1zfzYEqFEsM7WoF9N2uiR/d+ISZRmjHXPZeeyiOakkuOwrdLiLyMph9lrUv8bL4NCjMRG/F9YayntD/qFh6p1QnJKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ele8cKsI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab78e6edb99so147504566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1740063661; x=1740668461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
        b=Ele8cKsIT24FYjkrAo1OrXddZb0T9pGKeIAPMwU1Tn2ZAE03HbYvgNwIPpM9wDhJ0b
         DtaxgDorZvJYbcbEyg/OKsjotFUJkC/LTE22dZHd+IZIm0CZ4B6xsP8CZvAmVCommfYy
         h/NKq4y1/hUARtECAJJ5hVWUnfVzXD74eji7H5YvAZps04k8GNR0Kc0u++HG9DsGusoe
         7FXMef+WN21el/OWt83SQ+vemUpuFAOVtBLg6jGa+/0V5Pi8D6cLlNq1LDmbPTJcNSms
         OYb5RleQz5exsyk7xUvjlQ98lpigeLAeBPqJ85VOqmQVXTA4xM8cYrvfqfg8ZCFq36Ig
         vt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063661; x=1740668461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX45Sw49DqWmVMlR4tXEGRM0noTXirnZFmIFacKpQVc=;
        b=AI+HyuZHCaS1LPc/GkshLnFs3d05f9mZEW61+pxWFwre/wge3l2KqN8nAHYrhYZDV8
         X38Cusr5bh8Aj+6ZqvuliUQDEO68LTgcQzITpMlBVTJ0BJTF/LLmIUJbcGY+iQh8p8Gc
         ep4XezB+LGL+dpr60PZddKv9fu0wre8KoRcywm085a+F+inwumi6otznfDCg1Ma2klbe
         HCpt0GWJ+EffDIHZuzrc9C6UOTMK2dUQp9qVQer7Q6gg3GzB5Pd+rI8Q6JSNyDLI+huT
         beF0eojW1PwbjJ0knco5hRqsTRCjw/DWZ0tiK4xqA6fL8N5KGbEx9oMOVgqIfIXX1njl
         C+cg==
X-Forwarded-Encrypted: i=1; AJvYcCWSYiuHh9zGljHOCqoEIfukF87EY56hdIEOFMSNeve/bgxz3RCaGEQUyoC4NUNWnDGfQK1tnucCNV5DPhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHjTAQJD4p3PMdyNUlHCVmoRfigiDzJnqG8FzdZsQVx3eThRl
	D3/LpoM6+b69+J6f4QzQXC/fF39MndcI3nDP804y/3g0oLn55JY55QfIYoLKD4ZTDMFOvowuFKi
	isdcSMQkFD695dCoyZMQJR0dq867eiofRaZpkgA==
X-Gm-Gg: ASbGncupYrW4M3b0B16d0Oj+ZGfxqaSa2Orr9s9B7Y+qiI1xKp0VmMRBBGadR5xtYyE
	p7jcK7IKbNK8ZyyPKDdsvAFGZR6DLxYkRv/4eyx7VNfQQhNcYZSfDtHR6fy948DPRtwkPIWs2Ir
	vi8OyUgA0KJY5INFwQI/6mNz63EQ==
X-Google-Smtp-Source: AGHT+IFsNIPyDQGc+75Qve6xdXZqYra68xghYqvPNR/a93wAgL+cet1YYKlnIsmF7J644V3bLmLkzN1ceWcyLicDD5A=
X-Received: by 2002:a17:907:3d8b:b0:abb:b1a4:b0fd with SMTP id
 a640c23a62f3a-abbccccfde8mr753397866b.7.1740063661328; Thu, 20 Feb 2025
 07:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com> <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com> <2025022051-rockband-hydroxide-7471@gregkh>
In-Reply-To: <2025022051-rockband-hydroxide-7471@gregkh>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 20 Feb 2025 16:00:49 +0100
X-Gm-Features: AWEUYZn11RtW2auyLztupwrGFbfU0x95LBmhMBqsyNDNUcIi41ux5lVFUDQ1JfI
Message-ID: <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:17=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> It wasn't sent to me or to the stable list, so how could have I seen it?

Oh, of course, I forgot to add stable. How shall we proceed? Do you
want me to resend to you with David's Signed-off-by?

