Return-Path: <linux-kernel+bounces-290227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5829550F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CE91F2425A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351C31C3F0F;
	Fri, 16 Aug 2024 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XJugk/iQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B878B50
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833781; cv=none; b=fN0ZoTW0f/kVMeGeKQmPAlp1ZOBYNec0Jta9IGq4y7WERCG5aS9cD/BDAbvjil7ab/8ImCGfYtksrCuTWYIBdI2eLbzxXLjBmFwIBHxWfOdjNjInYUAUHWNokwIkQLLopXUBBNIwaX2TQWart1ICv/SjQ5KbZC6QGz9EZncgVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833781; c=relaxed/simple;
	bh=IwDsZVeG3gGyoqwk/D1vcp3mZayiN81MvGHLXWnEqvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pteT+PNRarOtvdA7OWHWMYqJr2cbIJiTgHc7Typ5Bl5EOeJ1zQDeSl9MAe6DkyfuZ5PEPwMPs8jzpAJfwe5AFeavwEeEkRFfvU2/OBhWm+PhSZt4BUiUAJiNh35BO7LxJAmu2FAsNpUwRI/FGSLwkWWWOT0N+ddrSa9RS4hEGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XJugk/iQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef23d04541so28194651fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723833777; x=1724438577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SwP9f/9nyRQVtMDDIAkjN0ZO4UbDprmvfV2rz1oAwo8=;
        b=XJugk/iQHemcmaaMlnR8D3pxbpUPt1tg9GYsgs5WhNzqspHJPFIlhoc4k20NLsH+6u
         l0VRnJ2hYjq/lHSypaOp7JAg1r6iSQtYCU4CcO6U5R39XxJeBEKM8opj6x+sDYlJhnaR
         rtTlKzlJV0voa8iIH9d287MhVQKSwsaq7pVWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833777; x=1724438577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwP9f/9nyRQVtMDDIAkjN0ZO4UbDprmvfV2rz1oAwo8=;
        b=EORd/kX9E7lx8inhyD7TALr+k8DW9IdvHf1WQqXHmL7wkre6WTja8pkgU/zAXbCN+T
         ll4258NfLGZX5QM5HLD8vW3Bm6nCghPFmhTtoti48hVer8EKSgHj8zEqVjjAWetQ6kQ8
         i2xWZeYYWcNyQIgXVvxYn7F7IzGTH1XUbXZnmNpo5ddM5rrK+3FcvnnQGGjU90CfCRvP
         1ttsrECPo2M1Xpbzvgnj+ZvZhQ6cjG/dLjdzJtLzNObmL0PsnI1mZBNYigknVcUJQomP
         sgmKJ0jVuX/wffli5uByYgjrGIH9fEcPKIcmttVFu/7dxPkD5LUxEN47ZQaqYxEarGwy
         GCQA==
X-Forwarded-Encrypted: i=1; AJvYcCWSQHDk1TFPzwGTjyT6w3qTbdTAGm3ma0xdRhJP/j/g0T1NGF7VCXMNOaHHQdnu6EVKhxIlIMSXzRPqd68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+r7rQQyeow6FisIdBiOFw29ZN7DDCAOCoB3t013EFeXv5CEMB
	2VBBs4CMTUYKliweDMwUmwl9hTWSNG7Cy2U1KLvX/mLvW1+lXXn72kVAhemz3CsCxQEmkv6mx29
	7QyU=
X-Google-Smtp-Source: AGHT+IEIDNCILpF7PMzg4NDhXQzkbC5+4kh/ZBYlQ5M+9e9UmyaCBxotIO4gLjGevJ0isj2a55xWRg==
X-Received: by 2002:a2e:9d8b:0:b0:2f3:b582:a914 with SMTP id 38308e7fff4ca-2f3be5f2a9bmr24488361fa.41.1723833777120;
        Fri, 16 Aug 2024 11:42:57 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b74b2899sm6098171fa.61.2024.08.16.11.42.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 11:42:56 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso27839391fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:42:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMT771ReJV+jA3NTDXbuPxh6N3g5aVcRXwE2zeneyja0ZuScXlQ6acK2L/Hj6/Mu2/1rf87sbdSNQD5pY=@vger.kernel.org
X-Received: by 2002:a2e:d1a:0:b0:2ef:2fc9:c8b2 with SMTP id
 38308e7fff4ca-2f3be5de43cmr21003861fa.37.1723833775772; Fri, 16 Aug 2024
 11:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66bf57c7b023f_22218329410@iweiny-mobl.notmuch> <66bf8913bae92_23041d29441@iweiny-mobl.notmuch>
In-Reply-To: <66bf8913bae92_23041d29441@iweiny-mobl.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Aug 2024 11:42:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBSaEoou5_0myVxAgLd5YXUbeGq1e8BSd4i=vdMb1jcg@mail.gmail.com>
Message-ID: <CAHk-=wiBSaEoou5_0myVxAgLd5YXUbeGq1e8BSd4i=vdMb1jcg@mail.gmail.com>
Subject: Re: [GIT PULL] DAX for 6.11
To: Ira Weiny <ira.weiny@intel.com>
Cc: Zhihao Cheng <chengzhihao1@huawei.com>, Christoph Hellwig <hch@lst.de>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 10:15, Ira Weiny <ira.weiny@intel.com> wrote:
>
> Ira Weiny wrote:
> > Hi Linux, please pull from
>      ^^^^^
>      Linus.
>
> Apologies,

Heh. I've been called worse. And it's a fairly common typo with people
whose fingers are used to type "Linux" and do so on auto-pilot.

I have an evil twin called Kubys, which is what happens when I type my
own name and my right hand is off by one key.

So if I occasionally mis-type my own name, I can hardly complain when
others do it..

          Linus

