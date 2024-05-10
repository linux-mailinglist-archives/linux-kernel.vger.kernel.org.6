Return-Path: <linux-kernel+bounces-175999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E288C288E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7DE2872D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF54172799;
	Fri, 10 May 2024 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbVW3k8b"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE41A2C3A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715357630; cv=none; b=u6FRQQ0rxa7eYqzKM1UY+1avm8lBWqr9c7H2A4svUZMkFBwMk9pgxqcYcrEhdsKwwnsyKLecW315oAYBaClop5Sa7fJv/JNW2CaIaVPVkOX7tNijbuk0dtIJ9Huhu9xgVieB2r8Lg8mX3+Uo8b8afVz9pFxSBobi9vZIMnTH8rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715357630; c=relaxed/simple;
	bh=b2Vtp/c0wZElNrbeWZjvkBtkRs6Hnk/JEEfb33UNJTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZahnmpGpaUAec17bLmyY9SjuNN+G4oRhomlQyA70uMtS+JrteqeUn3gpsDOchvPAYC4/9yZycA0hVjXMGI5s457aL+ZtZDYw0qay/qfoEk/07MaVc0UBvG2ZnpRIjKDlc5CcFb0JlKNV9sz0bbVZMdNqD5hwlms+OM4qRURatY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbVW3k8b; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7f919bc2e1cso875418241.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715357628; x=1715962428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2Vtp/c0wZElNrbeWZjvkBtkRs6Hnk/JEEfb33UNJTE=;
        b=vbVW3k8b8CuwO2i4y7DDdC8Zwd2VUBt/1Fkc+zhxmi9mpiZMYHAFMTQD9krnxYe7G+
         akkK50WuYKHhx9/u43UnUnHzOMvAyOFKR0KrFqSRUobcdQa6M328zG+E0tkvEb9ZCjI3
         95IRkok8ieJxRhYsRu6rEX5tnTRrp2Tc6mvT9M4jFh8/SjRFd5HQ7Fyi9Ho+oBlguplM
         x/pGU0nwEeXsDsJTyWSI5VMHuM5M1g2Qr60VzLE3l7L4CzgE7MAjwyt2Yb/Dmsq0ifft
         JLOvhguhIHVRXEnstaEBbJcWtNgLsomGjZCEbU96Ps67w6eIME6CBgHnIpkHt+wbIo9I
         /+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715357628; x=1715962428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2Vtp/c0wZElNrbeWZjvkBtkRs6Hnk/JEEfb33UNJTE=;
        b=k9b93E8FBsU4alExwC6BRkCGClulHxrS4PdT8Z9eYXqNcGe5xgq0HOcNCpS7iOa7AB
         EzVtEhKeyx0QQQ44ZNpjOBSfYToUF094BAABJd5HUY4aBB/0SEne4BTyF4jCYYtxATzo
         QTyCtsigKZk2/RLaagUvDul6dWTP/VzXL2xCLDefd+XyuBT2Vk+Qb7eq4++7RQ1iNnaS
         gCfKj8nG3ugbsxuv/1MTbcLbwOo29jYgqQDZUUm2zg3dUpXFzcpWHfqAswfzTxnNNTJj
         gQVOVAaYyybtvGYb5AkSHfY8bcOHxkGjf1spqCQR9EUAKAphjp613PVOpCs9UY3xbD0+
         t1cA==
X-Forwarded-Encrypted: i=1; AJvYcCX0fpzkUZOdozj8poQ8EdGX9I5jldjLS2OnGUfiYasuCZTGURZM5R5qQCPOVgAbXnKQORYVqfqK+9Cb9X+1dLUmSzslYHPzu2PFHkVw
X-Gm-Message-State: AOJu0Yyb4JgsXtweIrAuYAxTtdBIOWWPIUQseZrkI7Jrcyp6HsyN2mKW
	j05KwZk3lrPULhhW26+qhT/nv1pk+FAfTo3bKK7f559TTaPPST/6Yav/za6onOqZcJmfVFhkuym
	NF/IAIjlNoy1POOceLmr2ZPCvUMLc4K1+KWog
X-Google-Smtp-Source: AGHT+IG41/Va6A/PicQEwVzYdPo29oFPCeD2uQQ0q6aGV6VfwkSy/QFh16mwRnTYc1WroFao7pdgMaWgVuqXaACix2Q=
X-Received: by 2002:a67:ec0a:0:b0:47b:ab0d:b3f2 with SMTP id
 ada2fe7eead31-47fabb4fafcmr5674759137.9.1715357626878; Fri, 10 May 2024
 09:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-scrollback-delta-v1-1-4164d162a2b8@google.com> <2024051039-bankable-liking-e836@gregkh>
In-Reply-To: <2024051039-bankable-liking-e836@gregkh>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 10 May 2024 09:13:34 -0700
Message-ID: <CAFhGd8oo-th9bw-VQQAPva6_zNBHQjmOp+oEcaZOM4uk+xi-oQ@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: saturate scrollback_delta to avoid overflow
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 3:40=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 06, 2024 at 06:55:19PM +0000, Justin Stitt wrote:
> > Using the signed overflow sanitizer with syzkaller produces this UBSAN
> > report:
>
> <snip>
>
> I think you might want to hold off on these until the discussion on the
> hardening list about overflows all settles down to a solid resolution.
> Right now these all seem to be a mess and perhaps you will have a better
> set of primitives to work with once that thread is finished.

Agreed.

I came to the same conclusion once I reached fs/*.

Let's see how folks want to go forward with handling wraparound :thumbs_up:

>
> thanks,
>
> greg k-h

Thanks
Justin

