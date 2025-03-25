Return-Path: <linux-kernel+bounces-575054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A78A6ECE9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85371694AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA001FC111;
	Tue, 25 Mar 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IzuE9DBj"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484C1DE8A5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896007; cv=none; b=TOidNS9zezF/BSsdbl0esiX+wh+1dryliEGfYaowy85HbxCv1w2oEdUQR94qyxsI3TUMFUe4tJdgWiSr0gGyhHUXbKtCGGKbvSTJlL5P/raU6ZAkZDcVcdYMGeFbVty8RtECARV0b9fRJ+WNdLeC9vysnqLrtamu45sQkUh2v3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896007; c=relaxed/simple;
	bh=GjiEbFoY/UGEFhuXgO4Md7Z3mYQ2MwEfWlLsdmw7Djs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvDqYGRO3zySKsDoQHN7V6WwcqR3RqQZnJY2SCImtuDPzLc0nScmDeYzcqZnKmmxsU95+6gfySBXWFMB4Eg1SFqz0TlQ3opkpdKZNuPTD5uTCWtVqHNgMHZyHicHUn+nb+rxXyiRo78QZIs6Y8lwl8DrJRXa3Yj/zjpw4uQ0B5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IzuE9DBj; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-525b44ec88aso1598844e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742896005; x=1743500805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b2lX5tfn7tIpxTTiRAKwTMrvBSHE/QiBFZ33eS8Haa8=;
        b=IzuE9DBjsaK7i0FVTeTco33PyMaRUhGg6jiRpeJnywHlXM0QEHN7gdCOQS99uFb6yH
         V1Bzig90qRFLv3Xn6aJrOaM7nK/e9sXIhnSXYRpyRyCp9WBq2J9kyIATYAwS/bODK0Q1
         fJJaLdLwYtmWsloYIF5ccKZYt5Ee328qlEKpfH4rFgjhqgUY461VgQuzf+9cCpCvMnZC
         FeMofV9GRQ/Gvr5lzfPjGdMym9olp+hdxGM8EywFNeevRUKmQDGq0oJH7GsbpR8zorxB
         DS39/Iyxa/vtDKvCZf7sTxr1xBUX6dTqIccjd5ehRryD0i+xviBH1dAu5dL02m2dv7zp
         tRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896005; x=1743500805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2lX5tfn7tIpxTTiRAKwTMrvBSHE/QiBFZ33eS8Haa8=;
        b=Oym9q6oldhq4ct3d03lVaS0FetygXm5EcpGk/CcCS7+wwKDMWcYWQ52BixnTLdHjbZ
         AOmoFONpcfTCspUgqD+DX88RfJnoxyxccIslpS5crNXNdKU+HYYw0bmF5SFOF/xbEbyc
         WN5cw/8qyI01we+VyYjwu96aF9aLPV1Wl5Vd/5+SKCtHRFUrfsWP4pmf2PP/8bvMhTXL
         mGoM7rIPVUY1kl+szKX55JS2/YY2ZbPghTvvGaPfAnXUsC3W8z02fjzJMbwjg3xGJSvS
         KFuI0G7qhR59Cdx5EajNhnLVukdxYkuEBD1M0+EOCVXrYt9v0wLkFp7ANAZKjPxFMHXN
         2D9A==
X-Gm-Message-State: AOJu0YyN4SwyqrLFZhCS2XRmVZuvaoc4N1DSahNNoxNwa5vSN+CaCQUS
	BzcbXHmZOZ5PIfsHspip87zZox+i05UUVv3TjePCnucmqIfYLo1c/H+2B7VvfOA+a3S30bfPmnE
	8JHEV7UywOLX/BJ3gTC0665gi28micWa/7kwMRg==
X-Gm-Gg: ASbGncuvDfY09rLBV1GLWUKnAZ08cRTC/iWJKcr+rP4GP71lD5y0oR8Zu03c8UaCpRi
	dx36Fzp28H8+7aO0D81fSztCDokzvmw4fZtmRQbARV0Uv9L5A6p0IBNSZp+qeupmM5YvFMj+THM
	ltmuEmuGUAHuWohAZzj4glBYTRrhhdwUBGaly9Adybxu/Jg8eUTUIf0gA+KI0=
X-Google-Smtp-Source: AGHT+IH//1u3lm0gEX6665f+nDZ4nWHXHyc8at04VLjpmQ8T0A2klnwJ74tyli52akhfB8SGxJAMgSoflf1CfRHTSfc=
X-Received: by 2002:a05:6102:3e8b:b0:4c1:9159:859c with SMTP id
 ada2fe7eead31-4c50d51d56amr10977038137.15.1742896004860; Tue, 25 Mar 2025
 02:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com>
 <CA+G9fYu54p6zQpX3Kw4dy+Yy3BM66r_iawvLchPvsB_Sq_wCNQ@mail.gmail.com> <20250324103313.2bc42730@gandalf.local.home>
In-Reply-To: <20250324103313.2bc42730@gandalf.local.home>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 15:16:32 +0530
X-Gm-Features: AQ5f1Jr22uNyEeSzPJIeFAGaU0oB0Z0_gFBkxqProEQ282Ldn9GhG4OhHPUzA3k
Message-ID: <CA+G9fYuFNCoSvZMYYpqMT1SC-p2W9Ra1EuwV6p2kiOH61Uxecg@mail.gmail.com>
Subject: Re: next-20250319: arm shmobile_defconfig trace.c undefined type
 'struct module'
To: Steven Rostedt <rostedt@goodmis.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Mar 2025 at 20:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 19 Mar 2025 19:42:42 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> > On Wed, 19 Mar 2025 at 17:01, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > >
> > > Regressions on arm the shmobile_defconfig builds failed with clang-20 and gcc-13
> > >
> > > First seen on the next-20250312
> > >  Good: next-20250311
> > >  Bad:  next-20250312 .. next-20250319
> > >
> > > Regressions found on arm:
> > >  - gcc-13-shmobile_defconfig
> > >  - gcc-8-shmobile_defconfig
> > >  - clang-20-shmobile_defconfig
> > >
> > > Regression Analysis:
> > >  - New regression? Yes
> > >  - Reproducible? Yes
> > >
> > > Build regression: arm shmobile_defconfig trace.c undefined type 'struct module'
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Anders bisected this build regression to the following commit,
> >
> > # first bad commit:
> >    [dca91c1c54686914dec4dabea8bae4f365c02007]
> >    tracing: Have persistent trace instances save module addresses
> >
> > Lore link,
> >  - https://lore.kernel.org/all/CA+G9fYs62qxt1PajEp2A8uUmQFeAsC2JBV2wuspbAxz_hFF7CA@mail.gmail.com/
>
> The fix should have been pushed to linux-next already.
>
> Could you test the latest linux-next?

The reported issue is fixed on tag: next-20250324.
Please refer below link for more details,

Link:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250324/testrun/27735288/suite/build/test/gcc-13-shmobile_defconfig/history/

- Naresh

