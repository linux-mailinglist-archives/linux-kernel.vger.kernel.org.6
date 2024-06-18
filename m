Return-Path: <linux-kernel+bounces-219792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1CD90D7C7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC221F23DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F956BFB0;
	Tue, 18 Jun 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UQFoacEG"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1884CB4B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725772; cv=none; b=gv4FkTaotbi+R+lpoI3GtEm1t+jeFYTFmjxEExkoOJR3El7sqQCyyhkHF50XB1qBaJSC56csZydnpUlLeoR6UmqCYpQyUY1f0IHeGnnUlHI25fFHrWHbIKb0vTp6Cd5XM/Bs9hxlFU3T0NyUA5SqbqdrNMkAfZEJUXzyWN7K5FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725772; c=relaxed/simple;
	bh=uB+2S5G3KKCpQWRuEgQRZ3AMFOGdWw1yzBGOk2qVBlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToAjfln+PbydhBrLHTE6gUZwwkQTQ+v0S61ysEOiimq2cSzOyleHU0BrxQb8Oq1k3/sNfZSTpxpx6dOK6xrYkIuFN2ry5BXhhztEwkNZYfRDCVBVu3U3VMtAfg5Yc7iuH8IKUd90uPk2/lieeQKaVXBJk13XzeRi37sIL6QDhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UQFoacEG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57cad4475e0so9334381a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718725769; x=1719330569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7PV9oMz8cWEYpUb1KtzS92trOj0+RE15c12mLznp3uU=;
        b=UQFoacEG2rqOZO3+8Yp9/RkLwoNokgVwI853GOc2xCtwLiK6AFpz0bQ6fvhU1sP6Ez
         LsKE+QA4fPykJw+uCn+ZOR8zZJkw8vi21JL85ElkLHOLgYZT4tUaJasxPm1g0/RzprCT
         Nti3p8v7tsGsNOV3M/v+NQO+1XMWdodZjntU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718725769; x=1719330569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PV9oMz8cWEYpUb1KtzS92trOj0+RE15c12mLznp3uU=;
        b=OYM8xuyuzuVl+AlLiCCJlT69rsmO+RP1MCHVKBBc7uauibFUavmuW5EjZU2sOqg7T6
         c2KVmn3BWk6jdsY+1pQj0Z/pVMPkGyQBmEjbp2hKzOG8gK22ng7rHXQMn/6R1ik5CaS5
         xkgwLGsYUTE+P9reXgVeOTfTVHcl/Ie9nk/zJ8+uhAT4qrbqWrp2J7RXT29WcD0xBgDn
         17+S74YwnqP6uIqouSSLPct9637cCLFbVYuKeQqsolD736Y/jknFxiwKKZR1f1iKAZCh
         oEiF0prbasuqV3SokTaRZXkSKswaePFGvSz3D5kzIV0hWQUMnyaJEKHjpi+av0MaTlu5
         u2nw==
X-Gm-Message-State: AOJu0YykPaF7FSzh4JQGXY9rybJeDmPfZTnW+NQ8c2oPIb8Tjw4Wxwcn
	xaNGm6GmAvok74I6NYSOCU9H/Phrbl/yBdrGHrW4rJ8jJlxEpZhzVXx6g2VrG/ML09JFDE05qjG
	u+v4=
X-Google-Smtp-Source: AGHT+IFjHEdqO1QHBtDbV6Fd1vF/h80jZ0J6rAEcBHnsjSM1XCZ3tkI8eWMFrXB6PQOrRQDBOAw10w==
X-Received: by 2002:a05:6402:519:b0:579:fa8e:31a0 with SMTP id 4fb4d7f45d1cf-57cf7a66321mr2039122a12.10.1718725768824;
        Tue, 18 Jun 2024 08:49:28 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e70dsm7755657a12.62.2024.06.18.08.49.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 08:49:28 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cc7e85b4bso2498627a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:49:27 -0700 (PDT)
X-Received: by 2002:a05:6402:1a45:b0:57c:ff0d:b781 with SMTP id
 4fb4d7f45d1cf-57cff0db78dmr1048292a12.16.1718725767617; Tue, 18 Jun 2024
 08:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618105036.208a8860@rorschach.local.home> <CAHk-=whzYU-tOzxKg4f_i9G+D9No_r=uZ6g11w5UjkgfRZDf5g@mail.gmail.com>
In-Reply-To: <CAHk-=whzYU-tOzxKg4f_i9G+D9No_r=uZ6g11w5UjkgfRZDf5g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Jun 2024 08:49:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGnpjZiod5Pa-tVM-_vQ-auVcwxZ=oRrhV2BFFj1Sq7g@mail.gmail.com>
Message-ID: <CAHk-=whGnpjZiod5Pa-tVM-_vQ-auVcwxZ=oRrhV2BFFj1Sq7g@mail.gmail.com>
Subject: Re: Crash when CONFIG_FORCE_NR_CPUS is set and nr_cpus does not match
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Jun 2024 at 08:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you start out with the distro config, you're magically an expert.
> And when everybody is an expert, no one is.

The alternative is to find some better approximation of "this is an
embedded device, I'm willing to hardcode limits". But I'll try
removing it and seeing if anybody even notices.

             Linus

