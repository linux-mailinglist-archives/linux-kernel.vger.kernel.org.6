Return-Path: <linux-kernel+bounces-254561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935789334C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4105E1F23301
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D526EC5;
	Wed, 17 Jul 2024 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EXHJ4gy8"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E738803
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721176896; cv=none; b=blzqPExZVzGsKtwXV4Z+BAAkloh/+Awx6J2E81GsTQwhdGDLQAe5s+nP2ziypdmPHGr2i+QNw7pBlVJ8Oi9mBrhahPokjoEdep8vqJwQd+lYktSgWormHGDMABwhPoYKjGFdk72kKslTsVINWJlCwaQO/plLO+VrUduxiryK7Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721176896; c=relaxed/simple;
	bh=PDqZl8MfwLQXIfTzbyQCH4He/GRvYxes31eaif/hoeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa3NHCJ9rEig2f+hgbu8LIVxLujRiTnOOgxHjraN3y2bguTKocvyha1gn4Tmaed1koO6EOfb+s/hWzD3jwuNbDcYWeT/0d3nuKkS7rjzniFyzMMjl0sNpfA36n3eJA6MwrAAPrt7QcHmHW8CKqfLrwg2V6QC2xjMtkWDkt99wBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EXHJ4gy8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so521464a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721176892; x=1721781692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cPEE1/PfCm9ph5ZMgfxhzH0UhwP5mSQaE7CtT39oJag=;
        b=EXHJ4gy8P+dJgCwWAs8Qw1eid9c7Nv6F/+ZOmQSBCfnUOHIp5nCAUSOpAevE5ULGg1
         Y4i3c0gMz9wD/U9h1nIs7vgaMaZDhql14I2/LbpbpNmOxNerP3HGGgZwG4TpeYU7AXyU
         p8cfsHhPo2Ib75YJMuPdW4EW4BtCij9S+JKbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721176892; x=1721781692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPEE1/PfCm9ph5ZMgfxhzH0UhwP5mSQaE7CtT39oJag=;
        b=w91VXUeZ9b6o3r3FkngwHHIyZSPTxgRWpO+bHAPQbXXyXHXxFWHZueUTGN+t0Wm0tP
         mYSudAo2qx/7YOKOPd7bDd63WQ7PsIlKCR8Bes6dFgasyJwYT5zqtpy4y6CUxAo2oaqC
         rMabBlHErrf3yokNJCM9QUNPHqNhTHKJttm55Hn4Fx33HtpHyfOLDjhLyXL4pCizoZms
         951kmxfQPWbUJEU0SYLgYGzUDFp3q5DSPCQwBCLC6ijFOCy51UKwR6sJfv6xAdwd30nJ
         Cf0oWrTQymsfZYJ98LLoE6glpiPciamauwQGX+ay2r6O0LOzGnY5jPj9EmaImDjMR/TO
         TPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ys2zAfH790+v2KuzDTqPP+yxf+8pej1v/k+7P49Y2IQzo16uUvCxihi33MEOtvud2lcJVkc8t0z0q5KcnV10MovvJ+/boksZr1rg
X-Gm-Message-State: AOJu0YxHKb7XuRCAbegk94N4Mqw6pZqJPcXhHDVMy4JQGshegRtoT1z8
	6aIZiv66WwGF0WGANtbXFMybEb/xYTkbDIa63tKVeP2A/ru5wbJit7DIvpRYP9LlLH9yCyMoYnt
	LTucrPQ==
X-Google-Smtp-Source: AGHT+IGUu6tubj/iuv9Jyxu7yYAs4BHS5eYGwn6rIkGrJszhwX21gZV25jVxW90GN0y5Pt91NleHvg==
X-Received: by 2002:a17:906:3d6:b0:a77:cd4f:e4f1 with SMTP id a640c23a62f3a-a79edcf5c09mr287971366b.27.1721176892215;
        Tue, 16 Jul 2024 17:41:32 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5ea443sm381973766b.91.2024.07.16.17.41.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 17:41:31 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so521436a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 17:41:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCI431ltqER/u5nznDwgG0Glq6C+grIlQ8TChBRfLZgb69ayViXUA/fEKSjq/0tiOnKUaLjV4ox73yX7sj+A7CucHF7frI4XsJtYSA
X-Received: by 2002:a50:c308:0:b0:58b:5610:945c with SMTP id
 4fb4d7f45d1cf-59f0c91c8f0mr2868711a12.17.1721176891311; Tue, 16 Jul 2024
 17:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716143644.GA1827132@thelio-3990X> <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
In-Reply-To: <CAHk-=whfQoTDCd=8DYfCiX0a2ndqM-mmoxDm1xA7Kud+WQ9T8w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 17:41:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com>
Message-ID: <CAHk-=whVPmZm=rMBf1qkJzfZeBx4Es15_w7VnPK1wEs=XYDUgg@mail.gmail.com>
Subject: Re: Crash when booting UML after e3c92e81711d14b46c3121d36bc8e152cb843923
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 16:18, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm... Does this simple (whitespace-damaged) patch fix it for you?

I verified that it seemed to generate the right (generic) code, so
I've committed this fix. I didn't actually run your test-case, but it
looks ObviouslyCorrect(tm).

Famous last words,

                 Linus

