Return-Path: <linux-kernel+bounces-182636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDAB8C8DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756081F23945
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D551411E2;
	Fri, 17 May 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V6VNs9MG"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AB1DFE1
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981061; cv=none; b=a/18U5fkIcUH9m7cxn4NoihGE7prCIYjftdltK7RjTlaWiHTEEScPh4qGSZL0fZ7BnP8ckYXMS3ZnP3ocE9htfU4zEBjUjtSE1gPBWqCveEsv7WDBCaAYoAJkVfiDEN6eyl9xEHaBhS60KtL0KUp70v/Poj+pvm3cp1cQmXcBpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981061; c=relaxed/simple;
	bh=IfJYkc42KzwKWgTt9YCXYbwQ78/cdkAW+9n0nYrQkT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+tFycqZlaD5ClhBeDdoOKrl2Pq3MFNBT7yV1XRaZ1nrKw3vZcjVkwFCo63oiYv2LNIIBNz8mkJ+GQoSC6MSwxyL9SUoaUWHDuMcAAqVJZv2Nn6PbdHgqo/DkvyAzylIz5t/kYADOSShoj9P3/7mnsT2YKwStQYZAncG0oj8QXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V6VNs9MG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ee954e0aa6so23077085ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981059; x=1716585859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZePBSOIoDFc3SJ8gpxBa7DmK4+hYpUiZT8OtqItIpw=;
        b=V6VNs9MGHBDRDRF5/nhVHVDUsUgKERAAIz3nPJExq336hvd0OSlfcw3STpcM0wO+ys
         TfHDlBFSdArqjPr8ur9ElSFq2KpF5JlnLl74Aike7zMX1etlakJTCklkAcTiQ/BQZbKV
         mKrjqyeBeXKvjPT3dHEM04PCge5ek8bKMxVck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981059; x=1716585859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZePBSOIoDFc3SJ8gpxBa7DmK4+hYpUiZT8OtqItIpw=;
        b=NcAN3y8l39mOjEy2VzsrLeG26TLSE7nSqaF3YjLjqFLFGmPtNcFa/OjBCcTHKsjG+4
         umJL2JOVMaJyOxosWNw1gyZZphrmkOzzHRDmzpUQdtRY4LLh9+Eiy/SMlFtjWKdlFRkb
         jAbrUi5jvaQ13F7PsJxJddI7TWdJ1BBBhXresFHUSaS1H4L5XrkjGootqP3zgq12ZI6J
         Gc/kalbaPTap+TNsY03z7NndMxWB9DncW8YF/Qn6ZQzW1On/KbIeoz3e4jN5AGVDAj20
         KceLM9U245xhQFZnCuOdVPWjxYtxi4NUN7EjBwU1+dgZ1OEoCUv2LJiN1Bz1gc/EY4O7
         lwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZk2W6FybaaaJ9Py6OUkznmHjl7dOrgQw5hCTMztD3zy6BNEgSa9YPQXSE+j9VL8ar3oomWOhq6s9LJBqRVJI+Br0H/bi5TXepxZIY
X-Gm-Message-State: AOJu0Ywzn83OSbLGAbYcJGv9erdW5Gax+mh09I9YlWn5uEtb0HYGL7UZ
	bBX+yPIiBNj/mg5yblQDyM2xiwdYp04atvIscpXHu9ef9hdssvAVN1mB8jMgwg==
X-Google-Smtp-Source: AGHT+IGp7tPMh78BJ0Avg5PsASLZPSKcpqsBME5h6vFDRUhs+O+wV26Hx+4VAxiIkqft96DMjEQODQ==
X-Received: by 2002:a05:6a00:9290:b0:6f3:e6e0:d9f3 with SMTP id d2e1a72fcca58-6f4e0385654mr24139207b3a.31.1715981059389;
        Fri, 17 May 2024 14:24:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a817cbsm15080510b3a.58.2024.05.17.14.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:24:18 -0700 (PDT)
Date: Fri, 17 May 2024 14:24:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Justin Stitt <justinstitt@google.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <202405171417.B290C50A@keescook>
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>
 <ZkavMgtP2IQFGCoQ@casper.infradead.org>
 <20240517012647.GN2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517012647.GN2118490@ZenIV>

On Fri, May 17, 2024 at 02:26:47AM +0100, Al Viro wrote:
> On Fri, May 17, 2024 at 02:13:22AM +0100, Matthew Wilcox wrote:
> > On Fri, May 17, 2024 at 12:29:06AM +0000, Justin Stitt wrote:
> > > When running syzkaller with the newly reintroduced signed integer
> > > overflow sanitizer we encounter this report:
> > 
> > why do you keep saying it's unintentional?  it's clearly intended.
> 
> Because they are short on actual bugs to be found by their tooling
> and attempt to inflate the sound/noise rate; therefore, every time

"short on bugs"? We're trying to drive it to zero. I would *love* to be
short on bugs. See my reply[1] to Ted.

> when overflow _IS_ handled correctly, it must have been an accident -
> we couldn't have possibly done the analysis correctly.  And if somebody
> insists that they _are_ capable of basic math, they must be dishonest.
> So... "unintentional" it's going to be.

As Justin said, this is a poor choice in wording. In other cases I've
tried to describe this as making changes so that intent is unambiguous
(to both a human and a compiler).

> <southpark> Math is hard, mmkay?  </southpark>
> 
> Al, more than slightly annoyed by that aspect of the entire thing...

I'm sorry about that. None of this is a commentary on code correctness;
we're just trying to refactor things so that the compiler can help us
catch the _unintended_ overflows. This one is _intended_, so here we are
to find a palatable way to leave the behavior unchanged while gaining
compiler coverage.

-Kees

[1] https://lore.kernel.org/linux-hardening/202405171329.019F2F566C@keescook/

-- 
Kees Cook

