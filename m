Return-Path: <linux-kernel+bounces-422883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC669D9F47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76537B25876
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690EE1DFE11;
	Tue, 26 Nov 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SgAqWW2M"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7D41DAC90
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660865; cv=none; b=Gu0Qel5ArswucQHmPuOELgvJRq2lMyBpAsAAgYMURlFcgWfF5G1G/k4rLtbt5ItamAgl/8Xxs6ZbiZC1daNnZwzZzdpNJBU+EOCQ4EE7oVI/cuqCkjKGJhaM4kcEJZRB8KwTP9r1Q0FBXbFFOD+ZS3VlCzH6ZylVJDtQCClyZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660865; c=relaxed/simple;
	bh=51rqWKa/9fOh6GQVlexs1p8suWSnLeJOxOeaHETGV10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwBJ65Lw+LewDeJklxGNxTH6ceL4Xye4gIhCPqj2bXdhzvLUtGBDuZ+UpFELlQPB5DjlXX91CvjMS4wqbZ0CTUCtO3XbCfY+ywvxYNus0cZeYCQQ3rK/gqqklSrLKtO5b0ufE3GaNAbrlkqH8oq677pPuuO0jtX0bdfHnKbK28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SgAqWW2M; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa51bf95ce1so715174766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732660861; x=1733265661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7pbYi8XVvPynSRXkVpkfjziZ+aTH3WZhoGNDgr1HVmU=;
        b=SgAqWW2MmjSb5YvTAgl14bBpDrJsxoxbkc5YEuc2D8z0GdbJXyuBaVLgQXrNTuZQMR
         XYEXF/rSSpcidB8xVBFi15ENOpszrCxE+fKwr66XOeCslAIxKpVtYc41ibQyMdOKVAV/
         cMjNf4ybIKEXvTiwBiwgiWZD+d1jThuP9YSRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660861; x=1733265661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pbYi8XVvPynSRXkVpkfjziZ+aTH3WZhoGNDgr1HVmU=;
        b=WjQi5Yw5i8AIyr14HQaLvmwgcYtjG/GDT2R6z/FSVE2hLPtybhtjVjEmHwRHnByvLP
         qUrf/pE0rjohK5LxhcFhvPGwSOD+cmb7DpKn5cEXblVqNzryF9j9dvcfeZcIdUC2VSPy
         PRkXNooXTn7ZXS0AFPvSX3kjNoFQovqlf7adT6v/p8+uyY8y2umwUfhVssD7pu5/j+2W
         /PzQHDeW1X15+i1CyrcJ1gJ/zamC8E6sbhMvjQrOlIhYinFyv/5DKRhqEVmmjwoJ65z1
         5XKiBHh9y0bZZlVN0FK5m+i+p5j/+gitq2fsn+ZBnDcHnoG8jHQRvnaN1v+GEhYbBlsC
         dr6g==
X-Forwarded-Encrypted: i=1; AJvYcCX2ymKpLUucRuyJCslHrvV2tblXVfqybmNyMgUr+cUAax2H3QG5gTrF/KZSCf9NmqpbGy6hUrdjVZTYQ58=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj8sa7lhjheGVGMao4WQbsVEIh8jmCsolBotJSJ0b6650VzN6s
	uVpsbDAwS4+DhbbMJ9Z/HxLfA/ktcAF7qst5UfT0/ggGBIjnO+1xX1BTqJPRkI/zm75UvlA9Ugn
	qmZQjAg==
X-Gm-Gg: ASbGnctBPsX+Gm5LkdBRpCo8b5eZWpv6JZwDCsNfOwifJ+xqcC6iw9Ouv7N5f4A9R3j
	qcgKmyEkEa/Cbi07zQjGhEtTZZoxEPviHbH4fb1spkvdNMOV+wCJyGXLHAskacO0OVI47jOWNoS
	UOyukGwkRR61N7A6E1MFMjKl1mat02OmNbX0fJdhYU4AHP1BIrk2TJLNd3HOl18/lP/EldYcgMg
	IQ8SU8SzdjFOqHfT4XtrgavQsNHp8IczFrrIDgJj1+/25hpgpDWrzZGOpNlUeIPV44AyoiHOps/
	KeCVG3swMFsJHVIWSC1xrlH3
X-Google-Smtp-Source: AGHT+IH/yNfK7bcvWi0QaRZqlefiELkL3zJjFP438KZ6417BSI9CjGzR+6wiy1kZPYzEQwIpXZ9ahQ==
X-Received: by 2002:a17:906:9350:b0:aa5:427d:b101 with SMTP id a640c23a62f3a-aa580f57d4amr61474366b.36.1732660861334;
        Tue, 26 Nov 2024 14:41:01 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41a5fcsm5524674a12.78.2024.11.26.14.40.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 14:41:00 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso531617566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:40:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXWb/rCN9d6E6EumqT9aE7AuzubFnbSctdgsN9cjIbl6fk1zqzF7HE5E/Z244BBNglMDEh+sOX/8irG64E=@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1ce8:e4e0 with SMTP id
 a640c23a62f3a-aa580edfc21mr68092966b.10.1732660859315; Tue, 26 Nov 2024
 14:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com> <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com> <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com> <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
 <20241126084556.GI38837@noisy.programming.kicks-ass.net> <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
 <Z0Yz6xffDjL6m_KZ@google.com> <42ef4bd2-0436-4a1c-b88c-73101dbbf77a@intel.com>
In-Reply-To: <42ef4bd2-0436-4a1c-b88c-73101dbbf77a@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 14:40:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgAesttDd8qj6m9Ns-Xz6+44N4MsOnyROw5YzzhV74W7A@mail.gmail.com>
Message-ID: <CAHk-=wgAesttDd8qj6m9Ns-Xz6+44N4MsOnyROw5YzzhV74W7A@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 14:32, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> BTW shadowing of the goto-label is not a -Wshadow but a -Wfckoff level
> of complain; I have spend a few days to think of something better,
> including abusing of switch and more ugly things, -ENOIDEA

Yeah, I think you need to do that __UNIQUE_ID() thing for labels,
because while you can introduce local labels (see "__label__" use in
the wait macros and a few other places, where we do it) you need to
have a block scope to do that and the goto needs to be inside that
scope, of course.

Which I don't see how to do in this situation.

        Linus

