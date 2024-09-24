Return-Path: <linux-kernel+bounces-336478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD05983B56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E712840C8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04B14012;
	Tue, 24 Sep 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TdOBkOUC"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAB23DE
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146107; cv=none; b=ILOrQr08FCUbZ6OKOCCTAClRcPr1LquEUVpG5fMuxoSV/FS5TW+cR92Up7eU4iPedQ9zm6TGW2RLIhXrutCyZEcW8Od3bGTY/vg/gZ0UK25Q6myauSafNVcMJk2qpMCGG0uXTNJlPamJNfU4OcwOu0tFzXn5SSFR+h8p/9szom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146107; c=relaxed/simple;
	bh=eHzafNxabmGSIs26LY/np3HBRImQLK5VxqnoAlmffCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLpTLB9ajJ3AVINMC5xjWSElK8dN+vZ6PMwQq9aYL2HHXPyRwyGencvroJvieiovq6B8bc29Z9A3k3nyIdrfpkxYvRWl0522HBXXkYblwU7eWTb3FJpfiq0oKK8IUWtZkt++6M7/5IOK5hU4DxoZ2C9k0p0Tr7IQ65vCxiNZJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TdOBkOUC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so18974821fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727146103; x=1727750903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LRazYseFwv7HnZyxXE3fGsm1aCnICLJvDr/BBHvdERY=;
        b=TdOBkOUCHdBZ0I6thCd6nm+anZ1k8J5ubeFed8tPAu3bv+SngZRMdY0mEudIuEOphV
         TUUakBNU4AJX6ZEg29yylZNYNykxZfJXJpC6pqfum17A/m3s3VVQPh/1p0s5lC7I1/pw
         N4jD10NQOJ2fXpJKVUBL4PoJ+R7MZHGrC35Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727146103; x=1727750903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRazYseFwv7HnZyxXE3fGsm1aCnICLJvDr/BBHvdERY=;
        b=AxQZmS7UbXkKgirIH+IdcFpQ81WCCBBp/8fajGPourwst9LslVeexYy6UCYhOZAIh8
         PgOh+Y6q9yMKeCn7CUFzq2mMzEEvdPRAJOILoxBi0xLfkPPDmXwIsbmtR6xwYPPuBiU2
         ZG57nUCqgsRAUfUKP7+uglF6X2Ip+M6wOlbNoA8vgAM6sZAI13rJogpqdfvVNojsTliT
         mskYHkdTn2xnf8aD3F6tU+K2D2cR0JSF1kr/RjLDVjIyDRd4oV6IdLjzVsAze1LSjmWH
         xISWza4bSgo8ko1K7gy0Gna7ihf44Cfatl3idf6guU9/pCpUInSUmQhnyQw5BjhxNHx0
         70+g==
X-Forwarded-Encrypted: i=1; AJvYcCUh9c5wzuYA+1rBLS2LDFt4zdNORqtxZ3TVhHsDUIRAr+n/w8qOEx0hhYGonK9MYGXJ4S7DUCxjZAxpZ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMZcXWImjW+eGArFHJA78146OfuRKTbKVxwucUXcYKRVVj8lzG
	jGF4pXFvsRNsboMwlzKFFDNJH7MXppWffV6gx/gxnQ26YCnkyEq5TrXPf7kaYF0KcaKjceEOLvu
	mZG8jLg==
X-Google-Smtp-Source: AGHT+IEkfm8XL8jDa7jr52RzXSPcK7Tp+IWvZp/9obNL6LIVIC4hripEGUqpeBy40mdkB15UtkP3kw==
X-Received: by 2002:a2e:9e04:0:b0:2f6:6198:1cf9 with SMTP id 38308e7fff4ca-2f7cb358243mr68509911fa.31.1727146102943;
        Mon, 23 Sep 2024 19:48:22 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d282fc1esm771291fa.15.2024.09.23.19.48.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 19:48:21 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365a9574b6so6951963e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMByW5d5jmPY/BT0wFzM9pTeXr1p1JSaO6HyLfMUULCBW3nF4zr/EvzBRxOgvn9FMJAnZhjIw7gHA3H4M=@vger.kernel.org
X-Received: by 2002:a05:6512:1095:b0:530:e0fd:4a97 with SMTP id
 2adb3069b0e04-536ac17ba54mr9463642e87.0.1727146100293; Mon, 23 Sep 2024
 19:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area> <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
In-Reply-To: <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 19:48:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
Message-ID: <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 19:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I had missed the issue with PREEMPT_RT and the fact that right now
> the inode hash lock is outside the inode lock, which is problematic.

.. although I guess that could be solved by just making the spinlock
be external to the hash list, rather than part of the list like
list_bh.

You wouldn't need to do one lock per list head, you could just do some
grouping of the hash.

That said, the vfs inode hash code really is pretty disgusting and has
been accumulating these warts for a long time. So maybe a "filesystems
do their own thing" together with some helper infrastructure (like
using rhashtable) is actually the right thing to do.

              Linus

