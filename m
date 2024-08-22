Return-Path: <linux-kernel+bounces-296927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAE495B0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFDD281378
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0D8170853;
	Thu, 22 Aug 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KBsYLmWy"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A716F271
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315977; cv=none; b=upunUd9kr0eVgOrAlwUS22k0UtUpm3RVLwTKnzPZp904jHC8yCFddfh2Z8DfoG9uUbuK14xVZZOD4OSUJg2uPfIt0ZKIJ5O6J3lCDyqk262Pie8Ln4WihdxZ9iLkG+2gFTbh63LIQJcv+WqG+0rK1L92oWF3ZfzX6eYHXlzjkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315977; c=relaxed/simple;
	bh=/eQ4p2wkfuEw0Nha5S3OKTT7W6j71aVIFBzaGsaDr1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8uJHlZJiVr78TgzYTK+JKCR0glcOQQtgxm0AxZw5XM0JZ1ZG8GvooKp+fKjb0KN3pKmiSpvFcClvBY6C0HUhFPj8+/AbMH9CMvj0oFGmEtQqhy1+zY/vSsCisO6qkMDuhCGgE+vKarGaouHonU+ApmequcpWVTiYWJXd7O308Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KBsYLmWy; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e13cda45037so572675276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724315975; x=1724920775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eQ4p2wkfuEw0Nha5S3OKTT7W6j71aVIFBzaGsaDr1A=;
        b=KBsYLmWyPPJjuWUaNw54kAt+goQW1oeOmfmo7eJetFqB4Lbg5noQpwtRtTfDtyMrvL
         WG4+2LHplXvfaZWLd1XmAtbvwE6GzFVZSahbi3DhEPv96w/NgnyocbRuNt6TKmORa/YJ
         NMXQZ55okoQVP3XIG/dybb/rvBS99BE2ChoqDK/LyoP+GeBtYk21oTJLB4Yl47yU8S52
         YeqJKj6t7GWRUDAQd0fMzmkd7QXWY+9Zqn2go6oDU5upNYUQxaeVHLVnlC8lSrJWCQMy
         3vOORWEC53FS/UVO/yURQ636UjzFsn4HtKDZsNI6WTXATbv38v1h1pj8J3x7smig4+ij
         qngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315975; x=1724920775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eQ4p2wkfuEw0Nha5S3OKTT7W6j71aVIFBzaGsaDr1A=;
        b=dhDnt58Wdhr02pz/AWnzXWObgN+AYkf7/bsrsoQCmpVTnGZN2xjX8NuUjsAChZrmmi
         sf7DRsdkpfxqdmg+vWt0r3RJ+VKfrIt5iEnFNhWzZKVqA+FGi1HJLn+xDdbMHr+MLuTB
         AJ12S2+RF8xF3uoQDZKEPDRqor4Zp7qfB7vZU9dUKqtL9B06A9lWDf+2YTQXIj6ZuWB7
         +QFUyDwgzcj7qNbhewK3zjO/udRf5k6YbCmqq9CfqRNlw1yDS7LsYWAfNX86bcqcYee3
         D8b017B/b+XRfUlYg86uyfRZljNJ4e23FjtMcRBiPRgxZPvLnhHTCymeG28iQTJU69Cv
         Cgmg==
X-Forwarded-Encrypted: i=1; AJvYcCXreYh/FDe1dA086ibQrd8WU75S5YIBlgUSJSKTN5IMPwv0fc9HGeuz9JsVowGVexSc3bFcSXf+axmwpHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdyv+NsUio5IOUuOD3EVcmqxuoAfYRUdMMc1GMTJ36MhhGulF
	6n8cxrDOg2FWNm3QXyCHj09E3Mw3iVMdZ5r+Jo9zJcaCnDCwEZzEP4zxlIoQYkYarM6drYjtgiK
	Pbj8yky5JNbZ1RnmSuLfh3/AZzYhXOKPcqzCLtA==
X-Google-Smtp-Source: AGHT+IHkFdJeVV+WqzmMGZrvSF/bGpFOy2vIodVP1TRyAky2+0nTxS+aXkYfl2LkMvbDx6kyhrF2nGcG5PB1NQylZEg=
X-Received: by 2002:a05:6902:2607:b0:e13:c8e7:5bcb with SMTP id
 3f1490d57ef6-e1665555b3emr6002370276.53.1724315974761; Thu, 22 Aug 2024
 01:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
 <20240628-dev-andyc-dyn-ftrace-v4-v2-1-1e5f4cb1f049@sifive.com> <877cckadci.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <877cckadci.fsf@all.your.base.are.belong.to.us>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 22 Aug 2024 16:39:23 +0800
Message-ID: <CABgGipV9R_=Sy1uJ3YMXzm3S9W=yHWxRD1J=drFaw8-Jesym0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] riscv: ftrace: support fastcc in Clang for WITH_ARGS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Zong Li <zong.li@sifive.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Evgenii Shatokhin <e.shatokhin@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:09=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Andy Chiu <andy.chiu@sifive.com> writes:
>
> > Some caller-saved registers which are not defined as function arguments
> > in the ABI can still be passed as arguments when the kernel is compiled
> > with Clang. As a result, we must save and restore those registers to
> > prevent ftrace from clobbering them.
> >
> > - [1]: https://reviews.llvm.org/D68559
> >
> > Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> > Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a=
9199c45b1@yadro.com/
> > Acked-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
>
> Shouldn't this be a separate fix? Still reading the details, but it
> smells like something what should be disabled when building w/ LLVM, no?

Yes, this is a fix. My intention was indicating the dependency. So
people won't hit into trouble testing it. I can send it in a separate
series.

Thanks,
Andy

