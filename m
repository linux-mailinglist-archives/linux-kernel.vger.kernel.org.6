Return-Path: <linux-kernel+bounces-266631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B394D9403BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE228319E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19D09479;
	Tue, 30 Jul 2024 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axkEswTx"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1932A1D2;
	Tue, 30 Jul 2024 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302972; cv=none; b=GiPbxB1RmRuZxtc78FymZcPdNNaoH5mSs3gr0Y7xMkZhl1UnLEx7Y4cSeRa6nLCfrgaT6dmc5Asi3bs67CVlrEt6O0lqYp/0OrBv+F+hsr29pgqFfM2fS8XCWqKp5AOvhUcxG7uvmkt/4Rsd2qchE/xozhdoV4RDzy954IpuqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302972; c=relaxed/simple;
	bh=bfBkGRjeTZ8KpCZ5YHsqKiqDI0RJTgT8r2ZT5d3DLEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imJZ5C0Dp7q2XLg4kYJMLIaexLCnXoroiBs7vbQZVnbT42Pbf2S920UDTMFtZ7qUvuSOeD1oSY6izidU375zzZ/JnvKvd7ti7wo4IechaGL2fEK12fjsqraYdEvV1QnLdM6eOWfg7AgWUAyivHZoWYk6DUYIU/83PGJlT5Uiflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axkEswTx; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5b1e33fa8so2225021eaf.3;
        Mon, 29 Jul 2024 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722302970; x=1722907770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayRf9T1O0mu5YBNweBKrgfpWWoseD3czz8LrR2EBiCY=;
        b=axkEswTxe//eA97v5GyO+yIprd7gK0vXJILZOlvFO+ChgZZWGIfoPJoVXa9tg7ioBU
         KkLsCltDKDGoWfq4+HUKrHHwdQl9Ic2Uq45zv5wmSzrhIz7IgDGWtA6XTbED8hNPbPGL
         Tf9NeQsFWCNxYZWzHhWJPYA6thBTbCklglYIaP7UrqGsUxnA0dwqzmN8RDuEiyQD7pVn
         dnAdEk2T7dmA1t/95IAHIGzHoW+KVvP7qFqxoMDdMOO1+AjaLnYyKljpHRMcWaAg7jmv
         lEXJaFTRApxsdKsEYE7H4v+UYBT6CrvTK5OQgG1lpe4/5mHFcCbQZPXRHEmNPg+268ys
         EQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722302970; x=1722907770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayRf9T1O0mu5YBNweBKrgfpWWoseD3czz8LrR2EBiCY=;
        b=mu4ayVciDe3VpNJdpinwT/ZHkEzP8Cf5/n2wDjq865aGeznmwmwX7ywxK2AqOYtkHk
         eaFmI/xNf3hcPPH4h1PtsCrdbKu1jSBWIDSNvS0/H/i2Bz3rPHI5Pre8NMJu7qQ9Ajrj
         pezya8LOJVWrE9VEOA64oZxzWhcc7CNFRiVelnAVsPvrIBpzJsXJxQorTW3rcc71JR45
         StzgJcSpUQM0tZVc2qavm5LjyNViyQaoqmn4qcPVlBE80jk7Pmcs71QX+LiuBW41z6Ox
         /Y5vDpq7VUG8n5ZrABSwAys0fVXJuwhLwapLVQ91AVD2vLX8vtsoRn0QCy8aDPq9KOfC
         RPcA==
X-Forwarded-Encrypted: i=1; AJvYcCUDOivEzL3jDSpUjlZJkmo2irxHlLReKgwoZizW8OUdjZfA053VTNYBXBJ/GXLYw7yxR6U+otDQa7nhRQk0Gnw6vhxFNXHaHiXSAvDZ2dxfL1j5w/fKYK189t/omYJt2nC3pj8dUZK8
X-Gm-Message-State: AOJu0YyBB1b6yi1v24TPB5JGVmFSMsVlposHUQ2DJgUucHj6d97Ta6at
	25uz37E9ZxNiRJN1Z+SXJUHaE/to3WLumq6p4D6SiKTxGMHWPoH8lXO/7jvi3cG9fAAkFIUClWv
	RIJ6USjL5lw600plWWBKsmQNoTi0=
X-Google-Smtp-Source: AGHT+IGrJDi7bUdmWempWTC5QLfmgv6XjZARfHLSd+52QVC0tT0bBW1ZeORqLg0MbVOL/0fg45OkWlRIK7ehuRIdm9U=
X-Received: by 2002:a05:6820:1b94:b0:5d5:bd48:8ed8 with SMTP id
 006d021491bc7-5d5d0eb33d9mr8447025eaf.5.1722302969740; Mon, 29 Jul 2024
 18:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726145754.2598197-1-dzm91@hust.edu.cn> <a17a7994657696fbba9c9be29c35629ef512f85b@linux.dev>
 <8734nrao67.fsf@trenco.lwn.net>
In-Reply-To: <8734nrao67.fsf@trenco.lwn.net>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 30 Jul 2024 09:29:03 +0800
Message-ID: <CAD-N9QUn7KFBaSx0orYYBZ0NUS0gYwUG23Taypr0i4JNjmv1AQ@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: add the translation of kbuild/headers_install.rst
To: Jonathan Corbet <corbet@lwn.net>
Cc: si.yanteng@linux.dev, Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:23=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> si.yanteng@linux.dev writes:
>
> >> \ No newline at end of file
> > Add a blankline.
> >
> > With this:
> >
> > Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>
> I went ahead, applied the patch, and fixed this.  Next time, it would be
> nice if I didn't have to do that final step :)

I am going to craft a v2 patch today, but you have already merged it :(

Dongliang Mu

>
> Thanks,
>
> jon
>

