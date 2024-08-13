Return-Path: <linux-kernel+bounces-285547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6987E950F62
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073F8B24029
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6A1AAE28;
	Tue, 13 Aug 2024 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IelEeAII"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476F1AAE11
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586161; cv=none; b=MbKUPXmE9OZ/2dpIhl6++Db0N5+liF+PY/8yuxb9yIyd21FXy9EpZPa7eltM5czzvamGIQNeVjzZo/RCa2bhpFtZk6D9PH0wxHNCPsppf+JeSGiMgE/vcI9Uv3wjT2jSUWe6PQIk5Z2wQtLfsci2i1jhwPhpI+L9Re51ZJVIM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586161; c=relaxed/simple;
	bh=sYf7AubHKLRPISUz3iaN4Z/uAM0QtxXN1uvk9ImBQQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpLMjcHiWs4KhVfK/pZCSJ5u/V8oGfZGzVmBxKtxTHFBlTxECM1TbzrUq4bFTo69dxMmP7RKgyhFVpW9oTmW3T8EC5ChSvQkzFrmx4IqP/nJ1XACCQZDI5s37wgOGH38PB92goKhVGEiCZkSoWbrqvH4gaLmnoKekWHGxc32bw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IelEeAII; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4929540f38dso2172077137.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723586158; x=1724190958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYf7AubHKLRPISUz3iaN4Z/uAM0QtxXN1uvk9ImBQQA=;
        b=IelEeAIITogoo1SSJngz6zvknUJ23IORg0IIzoNgFQaInn6XdLBzk3zjG6skLppVPM
         gZuMdKd/IHfJezdOBdq1BSQtiDM0CLhxEcc2hgTtKMejxIffJwHmHz+xlE1l86gD4sHi
         BUt3LKrCBzkF/D5vnqjm6MpaE0ZHecrjK6xYAs0ycZG6Lnoo1AsyNMjLaSupNabxxVvT
         r6q+UU2ooXyoN/YK2K5ekvlNQVWnA1QrxZq/xIT0ubLDLqA8f74xqG9ELIcgtUovxR6j
         kRmtZf8oyWzEdk8Gc4dvAAcY/wmx13wlTJ0qiH0eT2wASvokQUYp9un55joVbGb0KRYO
         sVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723586158; x=1724190958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYf7AubHKLRPISUz3iaN4Z/uAM0QtxXN1uvk9ImBQQA=;
        b=iSc46yMP9P6AwuBHcSqtBaPhHkgTu5oUWiM/lNEup3Mx1abb1GUZfCEVo+3qn7ttaf
         5vMWGNjCu6jfze7OvefmPX75IuEu39EGdn+e7wIwfYmRJ6NCndYAvXsRSdYRyVWvWGWC
         JgrdIXkhTXOm85eYv847QS3mplDX1E2y7hOilE73Y9fNJ058SBqERfPDxtUSOrdANEZ9
         7F1EwiEbRwy6fHAEawAcEDuFF01bExXXOduWASvTzIHqnc6TmY3LIlUX316zrqvKX/IY
         DAdmkXlFMPDRyjnwNTrIOmqWSi0O9e5fH+kQRXN5h5V155gouFrghq5JZOqcyZE/7KW7
         1Hiw==
X-Forwarded-Encrypted: i=1; AJvYcCXPFAlcxNN90Jrv3o3/ideq06CW1Vks8ZzEhHmH9CSfq+jKH0Mo443uR4dHBzgSgjx2PfezOtsqEC/BkuE2//m6WBcePgwjaW/0RMPs
X-Gm-Message-State: AOJu0Yw4dC8iniyEd1qw1b9bzCOhlYsrh+ZHJENbvk4WUtCGzOj1wXLu
	R1Ro0LfKaZzRlyJfl5Ug5UWi6gjslxSZw9dzyxd9ZU5bnu0RLKNijJnLO7OBOl3zfnxLpGLmd3v
	esodVXPkT5jlPXkzHNcmlogHwXMtXyQjEfeya
X-Google-Smtp-Source: AGHT+IEQaFW6VTjl/NN5Addyayq2vESbO77ln4J7ElHigTL7AZmOrMHtx/th7RP9aYyJh8HhQcoWsHroq+JpTV9PMHI=
X-Received: by 2002:a05:6102:2ac1:b0:492:9adb:f4de with SMTP id
 ada2fe7eead31-497598af685mr1378119137.5.1723586158313; Tue, 13 Aug 2024
 14:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807220513.3100483-1-song@kernel.org> <20240813132907.e6f392ec38bcc08e6796a014@kernel.org>
 <0C1544B6-60CF-44DC-A10C-73F1504F81D1@fb.com>
In-Reply-To: <0C1544B6-60CF-44DC-A10C-73F1504F81D1@fb.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 13 Aug 2024 14:55:20 -0700
Message-ID: <CABCJKudPg+5Q3Y3H7LVa0DmN8ARati_oREVUqsLSvQpAgE5hWQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix kallsyms with CONFIG_LTO_CLANG
To: Song Liu <songliubraving@meta.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Song Liu <song@kernel.org>, 
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, "mbenes@suse.cz" <mbenes@suse.cz>, "pmladek@suse.com" <pmladek@suse.com>, 
	"joe.lawrence@redhat.com" <joe.lawrence@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>, 
	"morbo@google.com" <morbo@google.com>, "justinstitt@google.com" <justinstitt@google.com>, 
	"mcgrof@kernel.org" <mcgrof@kernel.org>, 
	"thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "kees@kernel.org" <kees@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, "mmaurer@google.com" <mmaurer@google.com>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 13, 2024 at 2:20=E2=80=AFPM Song Liu <songliubraving@meta.com> =
wrote:
>
> Hi Masami,
>
> Thanks for your review and test!
>
> @Sami, could you please also review the set?

As the kernel no longer uses the Clang feature combination that was
the primary motivation for adding these kallsyms changes in the first
place, this series looks reasonable to me. Thanks for cleaning this
up!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami

